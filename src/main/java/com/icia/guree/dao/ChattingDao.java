package com.icia.guree.dao;

import com.icia.guree.entity.ChatMessage;
import com.icia.guree.entity.ChattingDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.entity.SearchDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChattingDao {

    List<ChattingDto> getMyChattingList();

    ChatMessage startChatting(String c_receiveid, String c_sendid, String cContents, String c_sendtime);

    List<ChattingDto> chattingSearch(String cTitle);

    int getChattingCount(SearchDto sDto);

    List<MemberDto> getMemberId(ChattingDto cDto, MemberDto mDto);

    boolean insertChatRoom(ChattingDto cDto);
}
