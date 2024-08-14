package com.icia.guree.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icia.guree.common.SessionUtils;
import com.icia.guree.entity.OrderDto;
import com.icia.guree.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Slf4j
@Controller
public class OrderController {
    @Autowired
    private OrderService oSer;

    //상품 구매
    @PostMapping("/hotdeal/order")
    public String hotdealOrderItem(OrderDto order, HttpSession session, RedirectAttributes rttr, Model model) throws JsonProcessingException {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            order.setOrder_id(userDetails.getUsername());
        }
        log.info("상품 구매");
        log.info("<<<<구매 상품: {}", order);

        if (order != null) {
            model.addAttribute("json", new ObjectMapper().writeValueAsString(order));
            model.addAttribute("order", order);
            return "hotdeal/orderConfirm";
        } else {
            return "redirect:/hotdeal/list";
        }
    }

    @GetMapping("/hotdeal/order/result")
    public String hotdealOrderResult(){
        OrderDto order = (OrderDto) SessionUtils.getAttribute("order");
        log.info("결제가 완료된 주문 정보: {}", order);
        if(order != null){
            oSer.buyItem(order);
        }

        return "hotdeal/orderResult";
    }

}
