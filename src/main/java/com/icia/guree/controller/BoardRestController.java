package com.icia.guree.controller;

import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.BoardFileDto;
import com.icia.guree.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
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
            if (result.equals("입찰 성공")) {
                bSer.auctionUser(bDto);
                    return result;
            } else {
                return result;
            }
        }

}
