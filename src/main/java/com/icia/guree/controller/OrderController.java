package com.icia.guree.controller;

import com.icia.guree.entity.OrderDto;
import com.icia.guree.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
public class OrderController {
    @Autowired
    private OrderService oSer;

    //상품 구매
    @PostMapping("/hotdeal/buy_item")
    public String hotdealOrderItem(OrderDto order, HttpSession session, RedirectAttributes rttr) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            order.setOrder_id(userDetails.getUsername());
        }
        log.info("상품 구매");;
        log.info("<<<<구매 상품: {}", order);
        boolean result = oSer.buyItem(order, session);
        if (result) {
            rttr.addFlashAttribute("msg", "상품 구매 성공");
            return "redirect:/hotdeal/list";
        } else {
            rttr.addFlashAttribute("msg", "상품 구매 실패");
            return "redirect:/hotdeal/list";
        }
    }
}
