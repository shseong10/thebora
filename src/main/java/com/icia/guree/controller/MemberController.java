package com.icia.guree.controller;

import com.icia.guree.dao.FileDao;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.*;
import com.icia.guree.service.BoardService;
import com.icia.guree.service.MemberService;
import com.icia.guree.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@Controller
public class MemberController {
    @Autowired
    private MemberService mSer;

    @Autowired
    private MemberDao mDao;

    @Autowired
    private FileDao pDao;

    @Autowired
    private BoardService bSer;

    @Autowired
    private OrderService oSer;

    //로그인 안된경우만 로그인창으로
    @PreAuthorize("isAnonymous()")
    @GetMapping("/member/login")
    public String login() {
        return "member/login";
    }

    @GetMapping("/member/login/error")
    public String loginError(Model model) {
        model.addAttribute("msg", "로그인 실패-model");
        return "member/login";
    }

    @PostMapping("/member/join")
    public String memberJoin(MemberDto mem, Model model, Principal principal) {
        boolean result = mSer.memJoin(mem);
        if (result) {
            System.out.println("회원가입 성공");
            return "redirect:/member/login";
        } else {
            System.out.println("회원가입 실패");
            return "redirect:/member/join";
        }
    }

    //아이디 찾기
    @GetMapping("/member/idFind")
    public String idFind() {
        return "member/idFinder";
    }

    //비밀번호 찾기
    @GetMapping("/member/pwFind")
    public String pwFind() {
        return "member/pwFinder";
    }

    //비밀번호 바꾸기
    @PostMapping("/member/pwChange")
    public String pwChange(MemberDto mDto) {
        boolean result = mSer.pwChange(mDto);

        if (result) {
            System.out.println("비밀번호 변경 성공");
            return "redirect:/member/login";
        } else {
            System.out.println("비밀번호 변경 실패");
            return "redirect:/member/pwFinder";
        }
    }

    // 출석체크
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/attendance")
    public String pointPlus(RedirectAttributes redirectAttributes) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            System.out.println(userDetails.getUsername());
            AttendanceDto result = mSer.attendance(userDetails.getUsername());
            if (result == null) {
                mSer.attendancePlus(userDetails.getUsername());
                mSer.pointPlus(userDetails.getUsername());  // Return the username
                redirectAttributes.addFlashAttribute("msg","출석체크 되었습니다.");
                return "redirect:/";
            }
            LocalDate today = LocalDate.now();
            log.info("===========today==========" + today);
            log.info("===========가져온 날짜==========" + result.getA_date());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDate attendDate = LocalDate.parse(result.getA_date(), formatter);
            log.info("===========가져온 날짜==========" + attendDate);
            if(attendDate.isEqual(today)) {
                redirectAttributes.addFlashAttribute("msg","이미 출석체크 되었습니다.");
            }else {
                mSer.attendancePlus(userDetails.getUsername());
                mSer.pointPlus(userDetails.getUsername());  // Return the username
                redirectAttributes.addFlashAttribute("msg","출석체크 되었습니다.");
            }
        }
        return "redirect:/";
    }

    //마이페이지
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/myPage")
    public String myPage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            System.out.println(userDetails.getUsername());
            ProfileFile profile = mSer.myPage(userDetails.getUsername());
            model.addAttribute("profile", profile);
        }
        return "member/myPage";
    }

    // 프로필 사진 업로드
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/member/profileUpdate")
    public String profileupdate(ProfileFile pDto, HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            pDto.setM_id(userDetails.getUsername());

            boolean result = mSer.profileupdate(pDto, session);

            if (result) {
                System.out.println("프로필 변경 성공");
                session.setAttribute("profile", pDto);
                return "redirect:/member/myPage";
            } else {
                System.out.println("프로필 변경 실패");
                return "redirect:/member/myPage";
            }

        }
        System.out.println("프로필 등록 실패");
        return "redirect:/member/myPage";
    }

    // 프로필 사진 삭제
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/profileDelete")
    public String profileDelete(HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            mSer.profileDelete(userDetails.getUsername(), session);
            System.out.println("프로필 삭제 성공");
            return "redirect:/member/myPage";
        } else {
            System.out.println("프로필 삭제 실패");
            return "redirect:/member/myPage";
        }
    }

    // 회원정보 수정 페이지
    @GetMapping("/member/infoUpdate")
    public String infoUpdate(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
           MemberDto mInfo = mSer.userInfo(userDetails.getUsername());
            model.addAttribute("mInfo",mInfo);

        }
        return "member/infoUpdate";
    }
    // 회원정보 수정하기
    @PostMapping("/member/infoUpdate")
    public String infoUpdate(MemberDto mDto,Model model) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            System.out.println(userDetails.getUsername());
            mDto.setM_id(userDetails.getUsername());
            mSer.infoUpdate(mDto);
            ProfileFile profile = mSer.myPage(userDetails.getUsername());
            model.addAttribute("profile", profile);
        }
        return "member/myPage";
    }
    //중고거래 판매완료 리스트
    @GetMapping("/member/marketEnd")
    public String marketendList(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String name = userDetails.getUsername();
            List<BoardDto> mEList = bSer.myMarketEndList(name);
            List<BoardDto> aEList = bSer.myAuctionEndList(name);
            List<OrderDto> myOrder = oSer.myOrder(name);
            List<BoardDto> aBList = bSer.myAuctionBuyList(name);

            if (mEList != null) {
                model.addAttribute("mEList", mEList);
            }
            if (aEList != null) {
                model.addAttribute("aEList", aEList);
            }
            if (myOrder != null) {
                model.addAttribute("myOrder", myOrder);
            }
            if (aBList != null){
                model.addAttribute("aBList", aBList);
            }

        }
        return "member/marketEnd";
    }

    // 포인트 충전 페이지
    @GetMapping("/member/pointCharge")
    public String pointCharge(){
        return "member/pointCharge";
    }
    // 포인트 환전 페이지
    @GetMapping("/member/pointExchange")
    public String pointExchange(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
           int point = mDao.getUserPoint(userDetails.getUsername());
           model.addAttribute("point",point);
        }

        return "member/pointExchange";
    }
    //포인트 환전 확인
    @GetMapping("/member/pointExchangeResult")
        public String exchangepoint(){
        return "member/pointExchangeResult";
    }

    //포인트 환전
    @PostMapping("/member/pointExchange")
    public String Exchange(MemberDto mDto,RedirectAttributes redirectAttributes){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            mDto.setM_id(userDetails.getUsername());
        }
        mDto.setM_sumPoint((int) (mDto.getM_point() * 0.95));
        int point = mDao.getUserPoint(mDto.getM_id());
        if (point>mDto.getM_point()){
            mDao.pointExchange(mDto);
            redirectAttributes.addFlashAttribute("mDto", mDto);
            return "redirect:/member/pointExchangeResult";
        }else{
            redirectAttributes.addFlashAttribute("msg","환전 신청한 금액보다 보유 포인트가 적습니다.");
            return "redirect:/member/pointExchange";
        }
    }


    //완료 경매 디테일
    @GetMapping("/board/auctionEndDetail")
    public String auctionEndDetail(BoardDto bDto, Model model){

           BoardDto eDetail = bSer.auctionEndDetail(bDto);
            List<BoardFileDto> file = bSer.getFile(bDto);
            model.addAttribute("eDetail",eDetail);
            model.addAttribute("file", file);

            return "board/auctionEndDetail";


}

}