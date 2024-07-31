package com.icia.guree.controller;

import com.icia.guree.entity.BoardDto;
import com.icia.guree.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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



}
