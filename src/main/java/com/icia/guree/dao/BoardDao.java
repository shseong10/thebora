package com.icia.guree.dao;

import com.icia.guree.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface BoardDao {

    boolean productRegister(BoardDto bDto);

    List<BoardDto> auctionList(BoardDto bDto);

    BoardDto auctionDetail(BoardDto bDto);

    void attend(BoardDto bDto);

    void auctionUser(BoardDto bDto);

    boolean saleBoardDelete(String sb_num);

    String getNumber();

    List<BoardFileDto> getFile(BoardDto bDto);

    BoardDto getAttender(BoardDto bDto);

    int countAuctionItems(BoardDto bDto);

    List<BoardDto> getMyTrade(String name);

    List<BoardDto> getMarketList(BoardDto bDto);

    boolean marketProductRegister(BoardDto bDto);

    List<BoardDto> getMySales(String name);

    List<BoardDto> getMyCart(String username);

    List<BoardDto> getMySalesCart(String username);

    boolean myCartAttend(String sb_num, String username);

    List<BoardDto> allList(SearchDto sDto);

    String getViewId(String username, String sb_num);

    void setBoardView(String sb_num);

    void setViewInfo(String sb_num, String username);

    List<BoardDto> getRecItem();

    List<BoardFileDto> getIndexFile();

    List<BoardDto> boardDelList();

    List<BoardDto> marketBoardDelList();

    void realDelete(Integer sb_num);

    void restore(Integer sb_num);

    List<String> getCateList();

    void cateDelete(String c_kind);

    void cateAttend(String c_kind);

    int countMarketItems(BoardDto bDto);

    int countAllItems(SearchDto sDto);

    void auctionEnd(BoardDto bDto);

    List<BoardDto> boardEndList();

    void buyApply(BoardDto bDto);

    List<BoardDto> myTrading(String name);

    boolean getBuyApply(BoardDto bDto);

    void myCartDel(BoardDto bDto);

    boolean reUpload(BoardDto bDto);

    void alertMsg(AlertDto alertMsg);

    List<AlertDto> getAlertInfo(String sb_id);

    boolean alertDel(String sb_num);

    void chatting(AlertDto alertMsg);

    List<ChattingDto> getChattingList(String name);

    List<ChattingDto> getChatRoom(ChattingDto cDto);

    boolean chatInsert(ChattingDto cDto);

    boolean auctionApply(BoardDto bDto);

    List<BoardDto> auctionApplyList();

    List<BoardDto> getMyboardList(String userId);

    boolean adApply(BoardDto bDto);

    @Select("select count(*) from advertisement where a_sb_num = #{sb_num}")
    boolean getMyAdApply(BoardDto bDto);

    List<BoardDto> adApplyList();

    @Update("update advertisement set a_app = 2 where a_num = #{a_num}")
    boolean abApproval(String a_num);
    
    @Select("select * from saleboard join advertisement on sb_num = a_sb_num where a_app = 2 order by a_num desc")
    List<BoardDto> getAdItem();
}

