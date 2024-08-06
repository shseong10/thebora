package com.icia.guree.service;

import com.icia.guree.common.BoardFileManager;
import com.icia.guree.dao.BoardDao;
import com.icia.guree.entity.AlertDto;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.BoardFileDto;
import com.icia.guree.entity.SearchDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Slf4j
@Service
public class BoardService {
    @Autowired
    private BoardFileManager fm;
    @Autowired
    private BoardDao bDao;

    public static final int LISTCNT = 10;
    public static final int PAGECOUNT = 5;

    public boolean productRegister(BoardDto bDto, HttpSession session) {
        boolean result = bDao.productRegister(bDto);
        String sbNum = bDao.getNumber();
        bDto.setSb_num(sbNum);
        log.info("++++++++++++++++++++++++++++++++++++Dto 내놔" + bDto.getSb_num());
        if (result) {
            if (!bDto.getAttachment().get(0).isEmpty()) {
                if (fm.fileUpload(bDto.getAttachment(), session, bDto.getSb_num())) {
                    return true;
                }
            }
            return true;
        }
        return false;
    }

    public List<BoardDto> auctionList(BoardDto bDto) {
        int startIndex = (bDto.getPageNum() - 1) * LISTCNT;
        if(startIndex <0) {
            startIndex = 0;
        }
        bDto.setStartIdx(startIndex);
        bDto.setListCnt(LISTCNT);

        List<BoardDto> bList = bDao.auctionList(bDto);
        log.info("=====dkfdkq쉽게하자===================={}", bList);
        return bList;

    }

    public int countAuctionItems(BoardDto bDto) {
        return bDao.countAuctionItems(bDto);
    }

    public BoardDto auctionDetail(BoardDto bDto) {
// 조회수
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String viewId = bDao.getViewId(userDetails.getUsername(), bDto.getSb_num());
            if (viewId == null || !viewId.equals(userDetails.getUsername())) {
                bDao.setViewInfo(bDto.getSb_num(), userDetails.getUsername());
                bDao.setBoardView(bDto.getSb_num());
            }
        }
        // 조회수 끝
        return bDao.auctionDetail(bDto);
    }


    public String attend(BoardDto bDto) {
        BoardDto attender = bDao.getAttender(bDto);
        log.info("나는 누구인가 제발 나와라요" + attender);
        log.info("나는 누구인가 제발 나와라요22" + bDto.getA_joinId());

        String msg = "입찰 실패.";
        String successmsg = "입찰 성공";
        if (attender == null || !bDto.getA_joinId().equals(attender.getA_joinId())) {
            if(bDto.getA_bidPrice() - Objects.requireNonNull(attender).getA_bidPrice() >= bDto.getSb_bid()){
                bDao.attend(bDto);
                return successmsg;
            }
        }
        return msg;
    }


    public void auctionUser(BoardDto bDto) {
        bDao.auctionUser(bDto);
    }

    public boolean saleBoardDelete(String sb_num) {

        return bDao.saleBoardDelete(sb_num);
    }

    public List<BoardFileDto> getFile(BoardDto bDto) {
        return bDao.getFile(bDto);
    }

    public List<BoardDto> myTrade(String name) {
        return bDao.getMyTrade(name);
    }


    public List<BoardDto> getMarketList(BoardDto bDto) {
        int startIndex = (bDto.getPageNum() - 1) * LISTCNT;
        if(startIndex <0) {
            startIndex = 0;
        }
        bDto.setStartIdx(startIndex);
        bDto.setListCnt(LISTCNT);

        List<BoardDto> bList = bDao.getMarketList(bDto);
        return bList;
    }

    public boolean marketProductRegister(BoardDto bDto, HttpSession session) {
        boolean result = bDao.marketProductRegister(bDto);
        String sbNum = bDao.getNumber();
        bDto.setSb_num(sbNum);
        log.info("++++++++++++++++++++++++++++++++++++Dto 내놔" + bDto.getSb_num());
        if (result) {
            if (!bDto.getAttachment().get(0).isEmpty()) {
                if (fm.fileUpload(bDto.getAttachment(), session, bDto.getSb_num())) {
                    return true;
                }
            }
            return true;
        }
        return false;
    }

    public List<BoardDto> mySales(String name) {
        return bDao.getMySales(name);
    }

    public List<BoardDto> myAuctionCart(String username) {
        return bDao.getMyCart(username);
    }

    public List<BoardDto> mySalesCart(String username) {
        return bDao.getMySalesCart(username);
    }

    public boolean myCartAttend(String sb_num, String username) {
        return bDao.myCartAttend(sb_num, username);
    }


    public List<BoardDto> allList(SearchDto sDto) {
        int startIndex = (sDto.getPageNum() - 1) * LISTCNT;
        if (startIndex < 0) {
            startIndex = 0;
        }
        sDto.setStartIdx(startIndex);
        sDto.setListCnt(LISTCNT);
        List<BoardDto> allList = bDao.allList(sDto);

        return allList;
    }

    public List<BoardDto> recItem() {
        return bDao.getRecItem();
    }

    public List<BoardFileDto> getIndexFile() {
        return bDao.getIndexFile();
    }


    public List<String> cateList() {
        return bDao.getCateList();
    }


    public int countMarketItems(BoardDto bDto) {
        return bDao.countMarketItems(bDto);
    }

    public int countAllItems(SearchDto sDto) {
        return bDao.countAllItems(sDto);
    }

    public void auctionEnd(BoardDto bDto) {
        bDao.auctionEnd(bDto);
    }

    public boolean buyApply(BoardDto bDto) {
       boolean getApply = bDao.getBuyApply(bDto);
       if (getApply) {
          return false;
       }else{
           bDao.buyApply(bDto);
           return true;
       }
    }

    public List<BoardDto> myTrading(String name) {
       return bDao.myTrading(name);
    }

    public void myAuctionCartDel(BoardDto bDto) {
        bDao.myCartDel(bDto);
    }

    public void alertMsg(AlertDto alertMsg) {
        alertMsg.setMsg("<li>" +
                "<div>" +
                "<button type='button' class='btn-close' aria-label='Close' onclick='alertDel("+alertMsg.getSb_num()+")'></button>" +
                alertMsg.getAlertDate() +
                "</div>" +
                "<div>" +
                alertMsg.getBuyer() + " 님이 " + "<a href='/board/marketDetail?sb_num=" + alertMsg.getSb_num() + "' style=\"color:black\"><strong>" + alertMsg.getSb_title() + "</strong> 에 구매신청을 하였습니다..</a>" +
                "</div>" +
                "</li>");
        bDao.alertMsg(alertMsg);
    }

    public List<AlertDto> alertInfo(String sb_id) {

        return bDao.getAlertInfo(sb_id);
    }

    public boolean alertDel(String sb_num) {
        return bDao.alertDel(sb_num);
    }
}
