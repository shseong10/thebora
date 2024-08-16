package com.icia.guree.dao;

import com.icia.guree.entity.*;
import org.apache.ibatis.annotations.Delete;
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

    boolean realDelete(Integer sb_num);

    boolean restore(Integer sb_num);

    List<String> getCateList();

    boolean cateDelete(String c_kind);

    boolean cateAttend(String c_kind);

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

    @Update("update advertisement set a_app = 2, a_date = #{a_date} where a_num = #{a_num}")
    boolean abApproval(BoardDto bDto);
    
    @Select("select * from saleboard join advertisement on sb_num = a_sb_num where a_app = 2 and sb_scope = 1 order by a_num desc")
    List<BoardDto> getAdItem();

    @Delete("delete from saleboard where sb_num = #{sb_num} ")
    boolean auctionReject(String sb_num);

    List<BoardDto> auctionEndList();

    @Update("update saleboard set sb_scope = 3 where  sb_num = #{sbNum}")
    boolean marketEnd(String sbNum);

    List<BoardDto> marketEndList(String name);

    List<BoardDto> myAuctionEndList(String name);

    @Update("update saleboard set sb_scope = 3, sb_nowprice = #{sb_price}  where  sb_num = #{sb_num}")
    void buyNow(BoardDto bDto);

    @Delete("delete from advertisement where a_num = #{a_num}")
    boolean adReject(String a_num);

    @Update("update member set m_point = m_point + 100*#{a_period} where m_id = #{sb_id}")
    boolean returnPoint(BoardDto bDto);

    @Select("select a_num,a_date from advertisement where a_app = 2")
    List<BoardDto> adList();

    @Delete("delete from saleapply where s_sb_num = #{sbNum}")
    boolean myTradeDel(String sbNum);

    @Delete("delete from chatting where sb_num = #{sb_num}")
    boolean chatDel(String sb_num);


   BoardDto auctionEndDetail(BoardDto bDto);

   @Select("select bf_sysfilename from boardfile where bf_sb_num = #{sbNum}")
    List<String> picture(String sbNum);

    List<BoardDto> myAuctionBuyList(String name);
}

