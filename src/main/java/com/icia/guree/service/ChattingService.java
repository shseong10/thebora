package com.icia.guree.service;

import com.icia.guree.common.Paging;
import com.icia.guree.dao.ChattingDao;
import com.icia.guree.entity.ChatMessage;
import com.icia.guree.entity.ChattingDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.entity.SearchDto;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class ChattingService {

    @Autowired
    private ChattingDao cDao;

    public static final int LISTCNT = 10;
    public static final int PAGECOUNT = 2;

    public ChatMessage startChatting(String c_receiveid, String c_sendid, String c_contents, String c_sendtime){
        return cDao.startChatting(c_receiveid, c_sendid, c_contents, c_sendtime);
    }

    public List<ChattingDto> myChatList(SearchDto sDto){
        int pageNum = sDto.getPageNum();
        sDto.setStartIdx((pageNum-1) * sDto.getListCnt());
        log.info("왔냐?????????");
        return cDao.getMyChattingList();
    }

    public List<ChattingDto> chattingSearch(String c_title) {
        log.info("search target : {}", c_title);
        return cDao.chattingSearch(c_title);
    }

    public String getPaging(SearchDto sDto) {
        int totalNum = cDao.getChattingCount(sDto);
        log.info("totalNum:{}", totalNum);
        String listUrl = null;
        if (sDto.getColName() != null) {
            listUrl = "/chatting/list?colName=" + sDto.getColName()
                    + "&keyWord=" + sDto.getKeyWord() + "&";
        } else {
            listUrl = "/chatting/list?";
        }
        Paging p = new Paging(totalNum, sDto.getPageNum(), sDto.getListCnt(), PAGECOUNT, listUrl);
        return p.makeHtmlPaging();
    }

    public boolean createChatRoom(ChattingDto cDto, HttpSession ses) {
        boolean result = cDao.insertChatRoom(cDto);
        if(result){
            log.info("데이터 삽입 성공!");
            return true;
        }else{
            log.info("데이터 삽입 실패했다 ㅠ");
            return false;
        }
    }
}
