package com.icia.guree.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icia.guree.common.FileManager;
import com.icia.guree.entity.*;
import com.icia.guree.exception.DBException;
import com.icia.guree.service.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class InventoryController {
    @Autowired
    private InventoryService iSer;

    @Autowired
    private MemberService mSer;

    @Autowired
    private FileManager fm;

    //상품 업로드
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/hotdeal/add_item")
    public String addItem(Model model) {
        log.info("상품 업로드 페이지로 이동");
        List<CategoryDto> cList = iSer.getCategoryList();
        if (cList != null) {
            System.out.println("cList:" + cList);
            model.addAttribute("cList", cList);
        }
        return "hotdeal/addItem";
    }
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/hotdeal/add_item")
    public String addItem(InventoryDto inventory, HttpSession session, RedirectAttributes rttr) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            inventory.setM_id(userDetails.getUsername());
        }
        log.info("상품 업로드");
        log.info(">>>>상품: {}", inventory);
        for (MultipartFile mf : inventory.getAttachments()) {
            log.info(">>> 파일명: ", mf.getOriginalFilename());
            log.info("====================================================");
        }
        boolean result = iSer.addItem(inventory, session);
        if (result) {
            rttr.addFlashAttribute("msg", "상품 업로드 성공");
            return "redirect:/hotdeal/list";
        } else {
            rttr.addFlashAttribute("msg", "상품 업로드 실패");
            return "redirect:/hotdeal/add_Item";
        }
    }

    //상품 목록
    @GetMapping("/hotdeal/list")
    public String inventoryList(SearchDto sDto, Model model, HttpSession session) throws JsonProcessingException {
        int totalItems = iSer.countMarketItems(sDto);
        int totalPages = (int) Math.ceil((double) totalItems / BoardService.LISTCNT);
        if (sDto.getPageNum() == null || sDto.getPageNum() < 1) {
            sDto.setPageNum(1);
        } else if (sDto.getPageNum() > totalPages) {
            sDto.setPageNum(totalPages);
        }

        int currentGroup = (sDto.getPageNum() - 1) / BoardService.PAGECOUNT;
        int startPage = currentGroup * BoardService.PAGECOUNT + 1;
        int endPage = Math.min(startPage + BoardService.PAGECOUNT - 1, totalPages);

        List<InventoryDto> iList = iSer.getInventoryList(sDto.getPageNum());

        if (iList != null) {
        System.out.println("iList:" + iList);
        model.addAttribute("iList", iList);
        model.addAttribute("keyWord", sDto.getKeyWord());
        model.addAttribute("currentPage", sDto.getPageNum());
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("pageCount", BoardService.PAGECOUNT);
        }

        return "hotdeal/itemList";
        }

//상품 상세
@GetMapping("/hotdeal/list/detail")
public String inventoryDetail(@RequestParam("sb_num") Integer sb_num, Model model) throws JsonProcessingException {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        System.out.println("-----현재 페이지에 접속중인 유저-----");
        ProfileFile profile = mSer.myPage(userDetails.getUsername());
        model.addAttribute("profile", profile);
    }

    log.info("<<<<<<<sb_num=" + sb_num);
    if (sb_num == null) {
        return "redirect:/hotdeal/list";
    }
    InventoryDto inventory = iSer.getInventoryDetail(sb_num);
    log.info("<<<<<<<<InventoryDto: {}", inventory);
    log.info("<<<<<<<<InventoryFile: {}", inventory.getIfList());
    if (inventory != null) {
        model.addAttribute("json", new ObjectMapper().writeValueAsString(inventory));
        model.addAttribute("inventory", inventory);
        return "hotdeal/viewItem";
    } else {
        return "redirect:/hotdeal/list";
    }
}

//상품 수정하기
@PreAuthorize("isAuthenticated()")
@GetMapping("/hotdeal/update_item")
public String updateItem(@RequestParam("sb_num") Integer sb_num, Model model) throws JsonProcessingException {
    log.info("{}번째 상품 수정 페이지로 이동", sb_num);
    InventoryDto inventory = iSer.getInventoryDetail(sb_num);
    List<CategoryDto> cList = iSer.getCategoryList();
    if (cList != null) {
        System.out.println("cList:" + cList);
        model.addAttribute("cList", cList);
    }
    if (inventory != null) {
        model.addAttribute("json", new ObjectMapper().writeValueAsString(inventory));
        model.addAttribute("inventory", inventory);
        return "hotdeal/updateItem";
    } else {
        return "redirect:/hotdeal/list";
    }
}

@PreAuthorize("isAuthenticated()")
@PostMapping("/hotdeal/update_item")
public String updateItem(@RequestParam("sb_num") Integer sb_num, InventoryDto inventory, HttpSession session, RedirectAttributes rttr,
                         HttpServletRequest request) {
    log.info("상품 수정");

    for (MultipartFile mf : inventory.getAttachments()) {
        log.info("추가 업로드 파일: {}", mf.getOriginalFilename());
    }

    boolean result = iSer.updateItem(inventory, session);
    if (result) {
        rttr.addFlashAttribute("msg", "상품 수정 성공");
        //선택한 파일 삭제
        if (request.getParameterValues("deleteFile").length > 0) {
            Map fMap = new HashMap();
            for (String bf_orifilename : request.getParameterValues("deleteFile")) {
                log.info("IController/선택한 파일 삭제>>>FileManager {}", bf_orifilename);
                fMap.put("sb_num", sb_num);
                fMap.put("bf_orifilename", bf_orifilename);
                fm.deleteSelFmap(session, fMap);
            }
        }
        return "redirect:/hotdeal/list";
    } else {
        rttr.addFlashAttribute("msg", "상품 수정 실패");
        return "redirect:/hotdeal/update_Item";
    }
}

//상품 삭제하기 *이미 주문되었거나 장바구니에 담긴 상품은 삭제 불가.
@PreAuthorize("isAuthenticated()")
@GetMapping("/hotdeal/delete_item")
public String deleteItem(@RequestParam("sb_num") Integer sb_num, HttpSession session, RedirectAttributes rttr) {
    log.info(">>>>>삭제 대상 글번호: {}", sb_num);

    try {
        iSer.deleteItem(sb_num, session); // *****
        rttr.addFlashAttribute("msg", sb_num + "번 삭제성공");
        return "redirect:/hotdeal/list";
    } catch (DBException e) {
        log.info(e.getMessage());
        rttr.addFlashAttribute("msg", sb_num + "번 삭제실패");
        return "redirect:/hotdeal/list/detail?sb_num=" + sb_num;
    }
}

//관리자페이지
@GetMapping("/hotdeal/admin/main")
public String getAdmin(SearchDto sDto, Model model, HttpSession session) throws JsonProcessingException {
    List<CategoryDto> cList = iSer.getCategoryList();
    if (cList != null) {
        System.out.println("cList:" + cList);
        model.addAttribute("cList", cList);
    }

    int totalItems = iSer.countMarketItems(sDto);
    int totalPages = (int) Math.ceil((double) totalItems / BoardService.LISTCNT);
    if (sDto.getPageNum() == null || sDto.getPageNum() < 1) {
        sDto.setPageNum(1);
    } else if (sDto.getPageNum() > totalPages) {
        sDto.setPageNum(totalPages);
    }

    int currentGroup = (sDto.getPageNum() - 1) / BoardService.PAGECOUNT;
    int startPage = currentGroup * BoardService.PAGECOUNT + 1;
    int endPage = Math.min(startPage + BoardService.PAGECOUNT - 1, totalPages);

    List<InventoryDto> iList = iSer.getInventoryList(sDto.getPageNum());

    if (iList != null) {
        System.out.println("관리자페이지 테이블 출력==================");
        System.out.println("iList:" + iList);
        model.addAttribute("iList", iList);
        model.addAttribute("json", new ObjectMapper().writeValueAsString(iList));
        model.addAttribute("keyWord", sDto.getKeyWord());
        model.addAttribute("currentPage", sDto.getPageNum());
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("pageCount", BoardService.PAGECOUNT);
        return "hotdeal/adminMain";

    } else {
        return "redirect:/hotdeal/list";
    }
}

@ResponseBody
@PostMapping("/upload/hotdeal")
public Map<String, Object> editorFileUpload(MultipartHttpServletRequest request, HttpSession session) {
    Map<String, Object> uploadedImg = fm.editorFileUpload(request, session);
    return uploadedImg;
}
}
