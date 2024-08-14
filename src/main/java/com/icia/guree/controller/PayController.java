package com.icia.guree.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icia.guree.entity.OrderDto;
import com.icia.guree.entity.PayApproveResponse;
import com.icia.guree.entity.PayReadyResponse;
import com.icia.guree.service.OrderService;
import com.icia.guree.service.PayService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.icia.guree.common.SessionUtils;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/hotdeal/order")
public class PayController {

    @Autowired
    PayService paySer;

    @Autowired
    OrderService oSer;

    //결제요청준비
    @PostMapping("/pay/ready")
    public @ResponseBody PayReadyResponse payReady(@RequestBody OrderDto order){
        String name = order.getItem_name();
        int totalPrice = order.getTotal_amount();

        log.info("주문상품 이름: {}", name);
        log.info("주문가격: {}", totalPrice);

        //PayService 요청 --> 카카오 결제 API 실행
        PayReadyResponse payReadyResponse = paySer.payReady(name, totalPrice);
        //처리 후 받은 결제 고유 번호(tid)를 세션에 저장
        SessionUtils.addAttribute("tid", payReadyResponse.getTid());
        log.info("결제 고유 번호: " + payReadyResponse.getTid());

        //DB에 필요한 정보도 세션에 저장
        SessionUtils.addAttribute("order", order);
        log.info("세션에 저장된 주문 정보: " + order);

        return payReadyResponse;
    }

    //결제승인요청
    @GetMapping("/pay/completed")
    public String payCompleted(@RequestParam("pg_token") String pgToken, Model model) throws JsonProcessingException {
        String tid = SessionUtils.getStringAttributeValue("tid");

        log.info("결제 승인 토큰: " + pgToken);
        log.info("결제 고유 번호: " + tid);

        //카카오 api 결제 요청
        PayApproveResponse payApproveResponse = paySer.payApprove(tid, pgToken);

        //주문결과 페이지에 필요한 정보 전달
        OrderDto order = (OrderDto) SessionUtils.getAttribute("order");
        if (order != null) {
            model.addAttribute("json", new ObjectMapper().writeValueAsString(order));
            model.addAttribute("order", order);
        }

        //DB 저장
//        boolean result = oSer.buyItem(order);
//        if (result) {
//            System.out.println("상품 구매내역 DB 저장 완료");
//            return "redirect:/hotdeal/order/result";
//        } else {
//            System.out.println("!! 상품 구매내역 DB 저장 실패");
//            return "redirect:/hotdeal/list";
//        }
        return "redirect:/hotdeal/order/result";
    }

//    @GetMapping("/pay/cancel")
//    public String payCanceled(){
//        return "redirect:/hotdeal/order";
//    }
}
