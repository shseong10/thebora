package com.icia.guree.service;

import com.icia.guree.common.BoardFileManager;
import com.icia.guree.dao.BoardDao;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.*;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
public class BoardService {
    @Autowired
    private BoardFileManager fm;
    @Autowired
    private BoardDao bDao;
    @Autowired
    private MemberDao mDao;

    public static final int LISTCNT = 12;
    public static final int PAGECOUNT = 5;

    public boolean auctionApply(BoardDto bDto, HttpSession session) {
        boolean result = bDao.auctionApply(bDto);
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
        if (startIndex < 0) {
            startIndex = 0;
        }
        bDto.setStartIdx(startIndex);
        bDto.setListCnt(LISTCNT);

        List<BoardDto> bList = bDao.auctionList(bDto);
        bList.forEach(i->{
            String price = i.getSb_price()+"";
            String nPrice = i.getSb_nowPrice()+"";
            String sPrice = i.getSb_startPrice()+"";
            String bidPrice = i.getSb_bid()+"" ;
            i.setElement(price.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
            i.setStart(sPrice.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
            i.setNow(nPrice.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
            i.setBid(bidPrice.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
        });

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
                try {
                    bDao.setViewInfo(bDto.getSb_num(), userDetails.getUsername());
                    bDao.setBoardView(bDto.getSb_num());
                }catch (RuntimeException e){
                    return null;
                }
            }
        }
        // 조회수 끝
        BoardDto bDetail = bDao.auctionDetail(bDto);
            String price = bDetail.getSb_price()+"";
            String nPrice = bDetail.getSb_nowPrice()+"";
            String sPrice = bDetail.getSb_startPrice()+"";
            String bidPrice = bDetail.getSb_bid()+"" ;
        bDetail.setElement(price.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
        bDetail.setStart(sPrice.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
        bDetail.setNow(nPrice.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
        bDetail.setBid(bidPrice.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));


        return bDetail;
    }

    public boolean buyNow(BoardDto bDto) {
        BoardDto attender = bDao.getAttender(bDto);

        int point = mDao.getUserPoint(bDto.getA_joinId());
        MemberDto mDto = new MemberDto();
        mDto.setM_id(bDto.getA_joinId());
        mDto.setM_point(bDto.getSb_price());

        if (attender == null) {
            if (point >= bDto.getSb_price()) {
                mDao.pointPay(mDto);
                mDao.pointGet(bDto);
                bDao.buyNow(bDto);
                bDao.auctionUser(bDto);
                mDao.auctionGet(bDto);
                return true;
            }
        }else if (point >= bDto.getSb_price()) {
            mDao.returnPoint(attender);
            mDao.pointPay(mDto);
            bDao.buyNow(bDto);
            bDao.auctionUser(bDto);
            return true;
        }
        return false;
    }

    public String attend(BoardDto bDto) {
        BoardDto attender = bDao.getAttender(bDto);
        int point = mDao.getUserPoint(bDto.getA_joinId());
        MemberDto mDto = new MemberDto();
        mDto.setM_id(bDto.getA_joinId());
        mDto.setM_point(bDto.getA_bidPrice());
        log.info("나는 누구인가 제발 나와라요" + attender);
        log.info("나는 누구인가 제발 나와라요22" + bDto.getA_joinId());

        String msg = "입찰 실패";
        String successmsg = "입찰 성공";
        String fail= "포인트부족";
        String failMsg= "시작가미달";
        if (attender == null) {
            if(bDto.getSb_startPrice()>bDto.getA_bidPrice()){
                return failMsg;
            }
            if (point >= bDto.getA_bidPrice()) {
                mDao.pointPay(mDto);
                bDao.attend(bDto);
                return successmsg;
            } else {
                return fail;
            }
        } else if (!bDto.getA_joinId().equals(Objects.requireNonNull(attender).getA_joinId())) {
            if (bDto.getA_bidPrice() - Objects.requireNonNull(attender).getA_bidPrice() >= bDto.getSb_bid()) {
                if (point >= bDto.getA_bidPrice()) {
                    mDao.returnPoint(attender);
                    mDao.pointPay(mDto);
                    bDao.attend(bDto);
                    return successmsg;
                }else {
                    return fail;
                }
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
        if (startIndex < 0) {
            startIndex = 0;
        }
        bDto.setStartIdx(startIndex);
        bDto.setListCnt(LISTCNT);

        List<BoardDto> bList = bDao.getMarketList(bDto);
        bList.forEach(i->{
            String price=i.getSb_price()+"" ;
            i.setElement(price.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
        });
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
        List<BoardDto> item = bDao.getRecItem();
        item.forEach(i->{
            String price=i.getSb_price()+"" ;
            i.setElement(price.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
        });
        return item;
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
        mDao.pointGet(bDto);
        mDao.auctionGet(bDto);

    }

    public boolean buyApply(BoardDto bDto) {
        boolean getApply = bDao.getBuyApply(bDto);
        if (getApply) {
            return false;
        } else {
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
        if (alertMsg.getType().equals("apply")) {
            alertMsg.setMsg(
                    "<div class='container'>" +
                    "<div class='row p-0'>" +
                            "<div class='col-11 p-0'>" +
                                alertMsg.getBuyer() + "님이 " +
                                "<strong><a href='/board/marketDetail?sb_num="+alertMsg.getSb_num()+"'>" +
                                alertMsg.getSb_title() + "</a></strong>에 구매신청을 하였습니다.<br>" +
                                "<small>" + alertMsg.getAlertDate() + "</small>" +
                            "</div>" +
                            "<div class='col-1 p-0'>" +
                                "<button type='button' class='btn-close' aria-label='Close' onclick='alertDel("+alertMsg.getSb_num()+")'></button>" +
                            "</div>" +
                    "</div>" +
                    "</div>");
        }
        if (alertMsg.getType().equals("reject")) {
            alertMsg.setMsg(
                    "<div class='container'>" +
                    "<div class='row' p-0>" +
                            "<div class='col-11 p-0'>" +
                            "<strong>" + alertMsg.getSb_title() + "</strong>의 경매신청이 거절되었습니다.<br>" +
                            "<small>" + alertMsg.getAlertDate() + "</small>" +
                            "</div>" +
                            "<div class='col-1 p-0'>" +
                            "<button type='button' class='btn-close' aria-label='Close' onclick='alertDel("+alertMsg.getSb_num()+")'></button>" +
                            "</div>" +
                            "</div>" +
                            "</div>");
        }
        if (alertMsg.getType().equals("adReject")) {
            alertMsg.setMsg(
                    "<div class='container'>" +
                    "<div class='row p-0'>" +
                            "<div class='col-11 p-0'>" +
                            "<strong>" + alertMsg.getSb_title() + "</strong>의 광고신청이 거절되었습니다.<br>" +
                            "<small>" + alertMsg.getAlertDate() + "</small>" +
                            "</div>" +
                            "<div class='col-1 p-0'>" +
                            "<button type='button' class='btn-close' aria-label='Close' onclick='alertDel("+alertMsg.getSb_num()+")'></button>" +
                            "</div>" +
                            "</div>" +
                            "</div>");
        }

        bDao.alertMsg(alertMsg);
    }

    public List<AlertDto> alertInfo(String sb_id) {

        return bDao.getAlertInfo(sb_id);
    }

    public boolean alertDel(String sb_num) {
        return bDao.alertDel(sb_num);
    }

    public void chatting(AlertDto alertMsg) {
        bDao.chatting(alertMsg);
    }

    public List<ChattingDto> getChatting(String name) {
        return bDao.getChattingList(name);
    }

    public List<ChattingDto> chatRoom(ChattingDto cDto) {
        return bDao.getChatRoom(cDto);
    }

    public boolean chatInsert(ChattingDto cDto) {

        return bDao.chatInsert(cDto);
    }


    public List<BoardDto> myboardList(String userId) {
        return bDao.getMyboardList(userId);
    }

    public boolean adApply(BoardDto bDto) {
        boolean result = bDao.getMyAdApply(bDto);
        if (result) {
            return false;
        } else {
            return bDao.adApply(bDto);
        }

    }

    public List<BoardDto> getAdItem() {
        List<BoardDto> item = bDao.getAdItem();
        item.forEach(i->{
            String price=i.getSb_price()+"" ;
            i.setElement(price.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","));
        });
        return item;
    }

    public List<BoardDto> auctionEndList() {
        return bDao.auctionEndList();
    }

    public boolean marketEnd(String sbNum) {
        return bDao.marketEnd(sbNum);
    }

    public List<BoardDto> myMarketEndList(String name) {
        return bDao.marketEndList(name);
    }
    public List<BoardDto> myAuctionEndList(String name) {
        return bDao.myAuctionEndList(name);
    }

    public boolean adReject(BoardDto bDto) {
        if(bDao.adReject(bDto.getA_num())){

            return bDao.returnPoint(bDto);
        }
        return false;
    }

    public List<BoardDto> adList() {
        return bDao.adList();
    }

    public boolean advertisementEnd(String a_num) {
      return bDao.adReject(a_num);
    }

    public boolean myTradeDel(String sb_num) {
      boolean del = bDao.myTradeDel(sb_num);
      if(del){
         return bDao.chatDel(sb_num);
      }
      return false;
    }


    public BoardDto auctionEndDetail(BoardDto bDto) {
       return bDao.auctionEndDetail(bDto);
    }

    public List<BoardDto> myAuctionBuyList(String name) {
        return bDao.myAuctionBuyList(name);
    }
}
