package com.icia.guree.service;

import com.icia.guree.entity.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;


@Service
@RequiredArgsConstructor
@Slf4j
public class PayService {

    @Autowired
    OrderService oSer;

    //결제요청 전송
    public PayReadyResponse payReady(String name, int totalPrice) {

        //요청 양식에 맞춰서 Map 작성
        HashMap<String, String> parameters = new HashMap<>();
        parameters.put("cid", "TC0ONETIME"); //api 테스트코드 사용
        parameters.put("partner_order_id", "0000000"); //
        parameters.put("partner_user_id", "THEBORA"); //서비스 이름
        parameters.put("item_name", name); //주문서 상품 이름 지정
        parameters.put("quantity", "1"); //수량
        parameters.put("total_amount", String.valueOf(totalPrice)); //가격
        parameters.put("tax_free_amount", "0"); //비과세 금액
        parameters.put("approval_url", "http://localhost/hotdeal/order/pay/completed"); // 성공 시 redirect url
        parameters.put("cancel_url", "http://localhost/hotdeal/order/pay/cancel"); // 취소 시 redirect url
        parameters.put("fail_url", "http://localhost/hotdeal/order/pay/fail"); // 실패 시 redirect url

        //HTTP 요청에 필요한 헤더와 바디를 포함한 클래스
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        //RestTemplate - REST API 호출 이후 응답을 기다림
        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/ready";

        //postForObject() - POST 요청을 보내고 객체로 결과를 반환받음
        ResponseEntity<PayReadyResponse> responseEntity = template.postForEntity(url, requestEntity, PayReadyResponse.class);
        log.info("결제 준비 응답 객체: {}", responseEntity.getBody());

        return responseEntity.getBody();
    }

    //결제 승인 요청
    public PayApproveResponse payApprove(String tid, String pgToken) {
        log.info("결제 승인 요청// 토큰: {}", pgToken);

        Map<String, String> parameters = new HashMap<>();
        parameters.put("cid", "TC0ONETIME"); //api 테스트코드 사용
        parameters.put("tid", tid);
        parameters.put("partner_order_id", "0000000"); //
        parameters.put("partner_user_id", "THEBORA"); //서비스 이름
        parameters.put("pg_token", pgToken);

        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/approve";
        PayApproveResponse payApproveResponse = template.postForObject(url, requestEntity, PayApproveResponse.class);
        log.info("결제 승인 요청 결과: {}", payApproveResponse);

        return payApproveResponse;
    }


    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();

        headers.set("Authorization", "SECRET_KEY "+ "DEVF5DE2FB2B9129E7C0329E9E9E9D344E7D9B9B");
        headers.set("Content-type", "application/json");

        return headers;
    }
}
