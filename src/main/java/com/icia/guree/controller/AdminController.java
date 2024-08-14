package com.icia.guree.controller;

import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.service.AdminService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Controller
public class AdminController {
    @Autowired
    AdminService aSer;

    // 관리자 페이지로
    @Secured("ROLE_admin")
    @GetMapping("/member/admin")
    public String admin(Model model) {
        return "member/admin";
    }


    // 경매 재등록
    @PostMapping("/admin/reUpload")
    public String reUpload(BoardDto bDto, Model model) {
        boolean reUp = aSer.reUpload(bDto);
        if (reUp) {
            model.addAttribute("msg","재업로드 성공");
            return "member/admin";

        }
        model.addAttribute("msg","재업로드 실패");
        return "member/admin";
    }



}
