package com.icia.guree.controller;

import com.icia.guree.entity.ChattingDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.entity.SearchDto;
import com.icia.guree.service.ChattingService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ChattingController {

    @Autowired
    private ChattingService cSer;

    @GetMapping("/chatting/list")
    public String chattingList(SearchDto sDto, Model model, HttpSession ses){

        if(sDto.getPageNum() == null){
            sDto.setPageNum(1);
        }
        if(sDto.getListCnt() == null){
            sDto.setListCnt(ChattingService.LISTCNT);
        }
        if(sDto.getStartIdx() == null){
            sDto.setStartIdx(0);
        }
        log.info("sDto: {}", sDto);

        List<ChattingDto> cList = null;
        cList = cSer.myChatList(sDto);
        log.info("제발 나와라요~{}", cList);
        if(cList != null) {
            String pageHtml = cSer.getPaging(sDto);
            model.addAttribute("cList", cList);
            model.addAttribute("pageHtml", pageHtml);
            if(sDto.getColName() != null){
                ses.setAttribute("sDto", sDto);
            }else{
                ses.setAttribute("pageNum", sDto.getPageNum());
                ses.removeAttribute("sDto");
            }
            return "chatting/ChattingList";
        }else{
            return "redirect:/";
        }
    }

   @GetMapping("/chatting/createChatRoom")
    public String createChatRoom(ChattingDto cDto, Model model, HttpSession ses, RedirectAttributes rt){
        log.info("채팅방 생성 들어왔냐????");
        log.info("cDto: {}", cDto);
        boolean result = cSer.createChatRoom(cDto, ses);
        if(result){
            log.info("채팅방 생성 성공했따리~");
            model.addAttribute("cDto", cDto);
            rt.addFlashAttribute("msg", "채팅방이 생성되었습니다.");
            return "redirect:/chatting/list";
        }else{
            log.info("채팅방 생성 실패했따리 ㅠ");
            rt.addFlashAttribute("msg", "채팅방 생성에 실패했습니다.");
            return "redirect:/chatting/createChatRoom";
        }
   }
}
