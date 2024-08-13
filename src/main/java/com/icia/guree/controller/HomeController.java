package com.icia.guree.controller;

import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.BoardFileDto;
import com.icia.guree.entity.ChattingDto;
import com.icia.guree.service.BoardService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@Controller
public class HomeController {

    @Autowired
    private BoardService bSer;

    //        에디터 영역을 최대크기:  [Ctrl] + [Shift] + F12
//        주석: Ctrl+/
//        자동코드정렬: Alt+Ctrl+L
//        라인 복사: Ctrl+D
//        라인 삭제: Ctrl+Y
//        리턴저장변수생성: Alt+Enter
//        설정: Ctrl+Alt+S


    @GetMapping("/")
    public String index(HttpSession session, Model model,BoardDto bDto, Principal principal) {
        System.out.println("Principal:"+principal);
        if(session.getAttribute("msg")!=null) {
            model.addAttribute("msg", session.getAttribute("msg"));
            session.removeAttribute("msg");

        }
        List<BoardDto> detail = bSer.auctionEndList();
        LocalDateTime now = LocalDateTime.now();
        log.info("=====================" + now);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        for (BoardDto bList : detail) {
            LocalDateTime later = LocalDateTime.parse(bList.getSb_timer(), formatter);
            boolean ifafter = now.isAfter(later);
            if (ifafter) {
                bDto.setSb_num(bList.getSb_num());
                bDto.setSb_price(bList.getSb_price());
                bDto.setSb_id(bList.getSb_id());
                bSer.auctionEnd(bDto);
            }
        }

        List<BoardDto> adDetail = bSer.adList();
        for (BoardDto adList : adDetail) {
            LocalDateTime later = LocalDateTime.parse(adList.getA_date(), formatter);
            boolean ifAfter = now.isAfter(later);
            if (ifAfter) {
                bDto.setA_num(adList.getA_num());
               boolean adEnd = bSer.advertisementEnd(bDto.getA_num());
               log.info("광고상품 시간만료{}",adEnd);
            }
        }


        List<BoardDto> adItem = bSer.getAdItem();
            model.addAttribute("adItem", adItem);

        List<BoardDto> item = bSer.recItem();
        if (!item.isEmpty()) {
            model.addAttribute("items", item);
        }
        List<BoardFileDto> itemFile = bSer.getIndexFile();
        if (!itemFile.isEmpty()) {
            model.addAttribute("files", itemFile);
        }

        return "index";
    }

    @GetMapping("/member/joindetail")
    public String joindetail() {
        return "member/join";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/chat")
    public String chat(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String name = userDetails.getUsername();
           List<ChattingDto> cList = bSer.getChatting(name);
           model.addAttribute("chat", cList);
           model.addAttribute("userId",name);
        }
        return "member/chat";
    }



    //@PostMapping("/member/login") 는 SecurityConfig.java의 필터에 정의함
    //@GetMapping("/member/logout") 는 SecurityConfig.java의 필터에 정의함
//
//    @GetMapping("/member/anyone")
//    public String anyone() {
//        return "member/anyone";
//    }
//
//
//
//    @PreAuthorize("isAnonymous()")
//    @GetMapping("/member/anonymous")
//    public String anonymous() {
//        return "member/anonymous";
//    }
//
//    @PreAuthorize("isAuthenticated()")
//    @GetMapping("/member/authenticated")
//    public String authenticated() {
//        return "member/authenticated";
//    }
//
//    @Secured({"ROLE_ADMIN","ROLE_USER"})
//    @GetMapping("/member/user")
//    public String user() {
//        return "member/user";
//    }
//
//    @Secured("ROLE_ADMIN")
//    @GetMapping("/member/admin")
//    public String admin() {
//        return "member/admin";
//    }
//
//    @PreAuthorize("isAuthenticated()")
//    @GetMapping("/board/list")
//    public String list() {
//        return "board/list";
//    }
//    @PreAuthorize("isAuthenticated()")
//    @GetMapping("/board/contents")
//    public String contents() {
//        return "board/contents";
//    }
}
