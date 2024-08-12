package com.icia.guree.controller;

import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.AlertDto;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.BoardFileDto;
import com.icia.guree.entity.ChattingDto;
import com.icia.guree.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Slf4j
public class BoardRestController {
    @Autowired
    private BoardService bSer;


    @PostMapping("/board/buyApply")
    public boolean buyApply(BoardDto bDto) {

        return bSer.buyApply(bDto);

    }

    // 입찰하기
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/board/attend")
    public String attend(BoardDto bDto) {
        String result = bSer.attend(bDto);

        log.info("=================sadasdasdasdas=====" + result);
        switch (result) {
            case "입찰 성공" -> {
                bSer.auctionUser(bDto);
                return result;
            }
            case "시작가미달" -> {
                return result;
            }
            case "포인트부족" -> {
                return result;
            }
            default -> {
                return result;
            }
        }
    }

    @PostMapping("/board/alertInfo")
    public List<AlertDto> alertInfo(@RequestParam("sb_id") String sb_id) {
        List<AlertDto> alertInfo = bSer.alertInfo(sb_id);

        return alertInfo;
    }

    @PostMapping("/board/alertDel")
    public boolean alertDel(AlertDto aDto) {
        boolean aDel = bSer.alertDel(aDto.getSb_num());
//        List<AlertDto> alertInfo = bSer.alertInfo(aDto.getSeller());

        return aDel;

    }

    @PostMapping("/board/chatRoom")
    public List<ChattingDto> chatRoom(ChattingDto cDto) {
        List<ChattingDto> chat = bSer.chatRoom(cDto);

        return chat;
    }

    @PostMapping("/board/chatInsert")
    public boolean chatInsert(ChattingDto cDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String name = userDetails.getUsername();
            cDto.setUsername(name);

        }
        return bSer.chatInsert(cDto);
    }


}
