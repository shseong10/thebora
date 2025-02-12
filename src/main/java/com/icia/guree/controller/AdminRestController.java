package com.icia.guree.controller;

import com.icia.guree.dao.BoardDao;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.service.AdminService;
import com.icia.guree.service.BoardService;
import com.icia.guree.service.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
public class AdminRestController {

    @Autowired
    private BoardDao bDao;
    @Autowired
    private MemberDao mDao;
    @Autowired
    private BoardService bSer;
    @Autowired
    private MemberService mSer;
    @Autowired
    AdminService aSer;

    // 경매 삭제 게시글 보기
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/boardManager")
    public List<BoardDto> boardManager() {
        List<BoardDto> delList = bDao.boardDelList();

        return delList;

    }

    // 중고 삭제 게시글 보기
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/marketBoardManager")
    public List<BoardDto> marketBoardManager() {
        List<BoardDto> delList = bDao.marketBoardDelList();

        return delList;

    }

    // 게시글 완전 삭제
    @Secured("ROLE_admin")
    @PostMapping("/admin/realDelete")
    public boolean realDelete(@RequestParam("sb_num") Integer sb_num, HttpSession session) {
        return aSer.realDelete(sb_num, session);
    }

    // 게시글 복원
    @Secured("ROLE_admin")
    @PostMapping("/admin/restore")
    public boolean restore(@RequestParam("sb_num") Integer sb_num) {
        return  aSer.restore(sb_num);
    }

    // 카테고리 리스트
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/categoryList")
    public List<String> categoryList() {
        List<String> cateList = bSer.cateList();
        return cateList;
    }

    // 회원 리스트
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/memberList")
    public List<MemberDto> memberList() {
        List<MemberDto> memberList = mSer.MemberList();
        return memberList;
    }

    // 경매 완료 관리
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/AuctionEndManager")
    public List<BoardDto> auctionEndManager() {
        List<BoardDto> endList = bDao.boardEndList();
        return endList;
    }

    // 경매 신청받은 리스트
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/auctionApplyList")
    public List<BoardDto>auctionApplyList(){
        List<BoardDto> applyList = bDao.auctionApplyList();
        return applyList;
    }

    // 광고 신청받은 리스트
    @Secured({"ROLE_admin"})
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/admin/adApplyList")
    public List<BoardDto>adApplyList(){
        List<BoardDto> adList = bDao.adApplyList();
        for (BoardDto List :  adList ){
            if (List.getA_app().equals("1")){
                List.setA_app("미승인");
            }
            if (List.getA_app().equals("2")){
                List.setA_app("승인");
            }
        }
        return adList;
    }
    // 광고 승인
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/adApproval")
    public boolean abApproval(BoardDto bDto){
        return bDao.abApproval(bDto);
    }
    // 경매 신청 거절
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/auctionReject")
    public boolean auctionReject(@RequestParam("sb_num") String sb_num){
        return bDao.auctionReject(sb_num);
    }

    // 광고신청 거절
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/adReject")
    public boolean adReject(BoardDto bDto){

        return bSer.adReject(bDto);
    }

    //회원 삭제
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/memberDelete")
    public boolean memberDelete(@RequestParam("m_id") String m_id){
        return mDao.memberDelete(m_id);
    }

    //회원정보 수정
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/memberUpdate")
    public boolean memberUpdate(MemberDto mDto) {
       return aSer.memberUpdate(mDto);
    }


    //카테고리 추가
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/cateAttend")
    public boolean cateAttend(@RequestParam("c_kind") String c_kind) {

        return aSer.cateAttend(c_kind);
    }

    //카테고리 삭제
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/cateDelete")
    public boolean cateDelete(@RequestParam("c_kind") String c_kind) {

        return  aSer.cateDelete(c_kind);
    }

    //신청받은 경매 사진 보기
    @Secured({"ROLE_admin"})
    @PostMapping("/admin/picture")
    public List<String> picture(@RequestParam("sb_num") String sb_num){

        return aSer.picture(sb_num);
    }


}
