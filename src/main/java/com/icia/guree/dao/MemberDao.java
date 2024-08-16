package com.icia.guree.dao;

import com.icia.guree.entity.AttendanceDto;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.entity.ProfileFile;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MemberDao {

    @Insert("insert into member values(#{m_id}, #{m_pw}, #{m_name},#{m_phone},#{m_addr},#{m_companyNum},default,default,default)")
    public boolean join(MemberDto mem);

    @Select("select * from member where m_id=#{username}")
    MemberDto getMemberInfo(String username);

    @Select("select m_id from member where m_name=#{m_name} and m_phone=#{m_phone}")
    String idFind(MemberDto mem);

    @Select("select m_id from member where m_id=#{m_id} and m_name=#{m_name} and m_phone=#{m_phone}")
    String pwFind(MemberDto mem);

    @Update("update member set m_pw = #{m_pw} where m_id = #{m_id}")
    boolean pwChange(MemberDto mDto);

    @Select("select count(*) from member where m_id = #{m_id}")
    boolean idCheck(String m_id);

    @Select("select * from attendance where a_m_id = #{m_id} order by a_num desc limit 1")
    AttendanceDto attendance(String m_id);

    @Update("update member set m_point = m_point + 10, m_sumpoint = m_sumpoint + 10 where m_id = #{username}")
    int pointPlus(String username);

    @Insert("insert into attendance values(null,#{username},now())")
    void attendancePlus(String username);

    @Select("select distinct * from mypage where m_id = #{username}")
    ProfileFile profile(String username);

    @Select("select * from member")
    List<MemberDto> getMemberList();

    boolean memberUpdate(MemberDto mDto);

    void infoUpdate(MemberDto mDto);

    @Update("update member set m_point = m_point - #{m_point} where m_id = #{m_id}")
    boolean pointPay(MemberDto mDto);

    @Select("select m_point from member where m_id=#{m_id}")
    int getUserPoint(String m_id);

    @Update("update member set m_point = m_point + #{a_bidPrice} where m_id =#{a_joinId}")
    void returnPoint(BoardDto attender);

    @Update("update member set m_point = m_point + #{sb_price}, m_sumpoint = m_sumpoint + #{sb_price} where m_id = #{sb_id}")
    void pointGet(BoardDto bDto);

    @Delete("delete from member where m_id = #{mId}")
    boolean memberDelete(String mId);

    @Update("update member set m_point = m_point - #{m_point} where m_id = #{m_id}")
    void pointExchange(MemberDto mDto);

    @Insert("insert into getitem values (null, #{sb_num},#{a_joinId})")
    void auctionGet(BoardDto bDto);
}
