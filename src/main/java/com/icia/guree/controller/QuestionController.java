package com.icia.guree.controller;

import com.icia.guree.entity.QuestionDto;
import com.icia.guree.entity.SearchDto;
import com.icia.guree.service.NoticeService;
import com.icia.guree.service.QuestionService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@Slf4j
public class QuestionController {

    @Autowired
    private QuestionService qSer;

    @GetMapping("/question/list")
    public String questionList(SearchDto sDto, Model model, HttpSession ses) {
        if(sDto.getPageNum() == null){
            sDto.setPageNum(1);
        }
        if(sDto.getListCnt() == null){
            sDto.setListCnt(NoticeService.LISTCNT);
        }
        if(sDto.getStartIdx() == null){
            sDto.setStartIdx(0);
        }
        log.info("sDtoList : {}", sDto);

        List<QuestionDto> qList = qSer.getQuestionList(sDto);

        if (qList != null) {
            String pageHtml = qSer.getPaging(sDto);
            model.addAttribute("qList", qList);
            model.addAttribute("pageHtml", pageHtml);
            if(sDto.getColName() != null){
                ses.setAttribute("sDto", sDto);
            }else{
                ses.setAttribute("pageNum", sDto.getPageNum());
                ses.removeAttribute("sDto");
            }
            return "question/QuestionList";
        }else{
            return "redirect:/";
        }
    }

    @GetMapping("/question/write")
    public String questionWrite(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails userDetails) {
            model.addAttribute("userId", userDetails.getUsername());
        }
        log.info("글쓰기 창 오픈 두과좌~~~");
        return "question/QuestionWrite";
    }

    @PostMapping("/question/write")
    public String questionWrite(QuestionDto qDto, HttpSession ses, RedirectAttributes ra){
        log.info("글쓰기 창 열었냐??????");
        log.info("qDto List:{}", qDto);
        log.info("attachents : {}", qDto.getAttachments());

        for(MultipartFile mf : qDto.getAttachments()){
            log.info("파일명 : {}", mf.getOriginalFilename());
            log.info("파일 사이즈 : {}", mf.getSize());
        }

        boolean result = qSer.questionWrite(qDto, ses);
        if(result){
            System.out.println("글쓰기에 성공하였습니다.");
            ra.addFlashAttribute("msg", "질문글이 작성되었습니다.");
            return "redirect:/question/list";
        }else{
            System.out.println("글쓰기에 실패했습니다.");
            ra.addFlashAttribute("msg", "질문글 작성에 실패했습니다.");
            return "redirect:/question/write";
        }
    }

    @GetMapping("/question/detail")
    public String questionDetail(Integer q_num, Model model) {
        log.info("q_num : {}", q_num);
        if(q_num == null){
            return "redirect:/question/list";
        }
        QuestionDto qDto = qSer.getQuestionDetail(q_num);
        log.info("qDto : {}", qDto);
        log.info("qFile : {}", qDto.getQfList());
        if(qDto != null){
            model.addAttribute("qDto", qDto);
            return "question/QuestionDetail";
        }else{
            return "redirect:/question/list";
        }
    }

    @GetMapping("/question/update")
    public String questionUpdate(Integer q_num, Model model){
        log.info("글 수정하러 왔냐????");
        QuestionDto qDto = qSer.getQuestionDetail(q_num);
        if(qDto != null){
            model.addAttribute("qDto", qDto);
            return "question/QuestionUpdate";
        }else{
            return "redirect:/question/list";
        }
    }

    @PostMapping("/question/update")
    public String questionUpdate(QuestionDto qDto, HttpSession ses, RedirectAttributes ra){
        log.info("글수정 포스트매핑 왔냐??");
        log.info("qDto : {}", qDto);
        log.info("파일 사이즈 몇임? {}", qDto.getAttachments().size());

        boolean result = qSer.questionUpdate(qDto, ses);
        if(result){
            ra.addFlashAttribute("msg", "글 수정에 성공하였습니다.");
            log.info("글 수정 성공");
            return "redirect:/question/detail?q_num" + qDto.getQ_num();
        }else{
            ra.addFlashAttribute("msg", "글 수정에 실패했습니다.");
            log.info("글 수정 실패");
            return "redirect:/question/update?q_num" + qDto.getQ_num();
        }
    }
}
