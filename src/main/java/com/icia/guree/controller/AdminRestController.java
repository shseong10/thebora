package com.icia.guree.controller;

import com.icia.guree.dao.BoardDao;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.service.AdminService;
import com.icia.guree.service.BoardService;
import com.icia.guree.service.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
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
    private BoardService bSer;
    @Autowired
    private MemberService mSer;
    @Autowired
    AdminService aSer;

    // 경매 삭제 게시글 보기
    @PostMapping("/admin/boardManager")
    public List<BoardDto> boardManager() {
        List<BoardDto> delList = bDao.boardDelList();

        return delList;

    }

    // 중고 삭제 게시글 보기
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

    @PostMapping("/admin/categoryList")
    public List<String> categoryList() {
        List<String> cateList = bSer.cateList();
        return cateList;
    }

    @PostMapping("/admin/memberList")
    public List<MemberDto> memberList() {
        List<MemberDto> memberList = mSer.MemberList();
        return memberList;
    }

    @PostMapping("/admin/AuctionEndManager")
    public List<BoardDto> auctionEndManager() {
        List<BoardDto> endList = bDao.boardEndList();
        return endList;
    }
    @PostMapping("/admin/auctionApplyList")
    public List<BoardDto>auctionApplyList(){
        List<BoardDto> applyList = bDao.auctionApplyList();
        return applyList;
    }
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
    @PostMapping("/admin/adApproval")
    public boolean abApproval(@RequestParam("a_num") String a_num){
        return bDao.abApproval(a_num);
    }
    @PostMapping("/admin/auctionReject")
    public boolean auctionReject(@RequestParam("sb_num") String sb_num){
        return bDao.auctionReject(sb_num);
    }

    // 광고신청 거절
    @PostMapping("/admin/adReject")
    public boolean adReject(BoardDto bDto){

        return bSer.adReject(bDto);
    }


}
