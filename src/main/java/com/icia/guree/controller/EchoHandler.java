package com.icia.guree.controller;

import com.icia.guree.entity.AlertDto;
import com.icia.guree.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Component
@Slf4j
@RequiredArgsConstructor
public class EchoHandler extends TextWebSocketHandler {
    @Autowired
    BoardService bSer;


    // 전체 로그인 유저
    private List<WebSocketSession> sessions = new ArrayList<>();
    private Map<String, List<String>> notificationBuffer = new HashMap<>();
    // 1대1 매핑
    private Map<String, WebSocketSession> userSessionMap = new HashMap<>();
    private final ObjectMapper objectMapper;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("Socket 연결");
        sessions.add(session);
        log.info(sendPushUsername(session));                //현재 접속한 사람의 username이 출력됨
        String senderId = sendPushUsername(session);
        userSessionMap.put(senderId, session);

        if (notificationBuffer.containsKey(senderId)) {
            List<String> bufferedMessages = notificationBuffer.get(senderId);
            for (String msg : bufferedMessages) {
                session.sendMessage(new TextMessage(msg));
            }
            notificationBuffer.remove(senderId);
        }

    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.info("session = " + sendPushUsername(session));
        String msg = message.getPayload();                //js에서 넘어온 메세지
        log.info("msg = " + msg);

        AlertDto alertMsg = objectMapper.readValue(msg, AlertDto.class);
        WebSocketSession sendedPushSession = userSessionMap.get(alertMsg.getSeller()); //로그인상태일때 알람 보냄
        WebSocketSession sendedPushSession2 = userSessionMap.get(alertMsg.getBuyer()); //로그인상태일때 알람 보냄
        LocalDateTime now = LocalDateTime.now();
        // 초를 2자리로 포맷하기 위한 DateTimeFormatter 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String dateFm = now.format(formatter);
        String result = dateFm.substring(0, 19);
        log.info("================alertMsg.getType()================ " + alertMsg.getType());
        log.info("================alertMsg.getType()=========같냐======={}",alertMsg.getType().equals("chat"));

        if (alertMsg.getType().equals("reject")) {
            alertMsg.setAlertDate(result);
            alertMsg.setMsg("<div class='toast choose' role='alert' aria-live='assertive' aria-atomic='true'>" +
                    "<div class='toast-header'>" +
                    "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
                    result +
                    "</div>" +
                    "<div class='toast-body'>" +
                    alertMsg.getSb_title() + "의 경매신청이 거절되었습니다." +
                    "</div>" +
                    "</div>");
            String alertContents = alertMsg.getMsg().replace("\"", "\\\"");
            String reject = "{\"type\":\"reject\",\"contents\":\""+alertContents+"\"}";

            if (sendedPushSession != null) {
                sendedPushSession.sendMessage(new TextMessage(reject));
            } else {
                notificationBuffer.computeIfAbsent(alertMsg.getSeller(), k -> new ArrayList<>()).add(reject);
            }
            bSer.alertMsg(alertMsg);
        }

        if (alertMsg.getType().equals("chat")) {
            String chat = "{\"type\":\"chat\",\"value\":\"<div>"+sendPushUsername(session)+" : "+alertMsg.getMsg()+"</div>\"}";
            if(alertMsg.getSeller().equals(sendPushUsername(session))){
                sendedPushSession2.sendMessage(new TextMessage(chat));
                alertMsg.setMsg("<div class='toast choose' role='alert' aria-live='assertive' aria-atomic='true'>" +
                        "<div class='toast-header'>" +
                        "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
                        result +
                        "</div>" +
                        "<div class='toast-body'>" +
                        alertMsg.getBuyer() + " 님이 메세지를 보냈습니다." +
                        "</div>" +
                        "</div>");
                String alertContents = alertMsg.getMsg().replace("\"", "\\\"");
                String alert = "{\"type\":\"chatAlert\",\"contents\":\""+alertContents+"\"}";
                if ( sendedPushSession2 != null){
                    sendedPushSession2.sendMessage(new TextMessage(alert));
                }else {
                    notificationBuffer.computeIfAbsent(alertMsg.getBuyer(), k -> new ArrayList<>()).add(alert);
                }
            }else{
                sendedPushSession.sendMessage(new TextMessage(chat));
                alertMsg.setMsg("<div class='toast choose' role='alert' aria-live='assertive' aria-atomic='true'>" +
                        "<div class='toast-header'>" +
                        "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
                        result +
                        "</div>" +
                        "<div class='toast-body'>" +
                        alertMsg.getSeller() + " 님이 메세지를 보냈습니다." +
                        "</div>" +
                        "</div>");
                String alertContents = alertMsg.getMsg().replace("\"", "\\\"");
                String alert = "{\"type\":\"chatAlert\",\"contents\":\""+alertContents+"\"}";
                if ( sendedPushSession != null){
                    sendedPushSession.sendMessage(new TextMessage(alert));
                }else {
                    notificationBuffer.computeIfAbsent(alertMsg.getSeller(), k -> new ArrayList<>()).add(alert);
                }
            }

        }

        if (alertMsg.getType().equals("apply")) {
            alertMsg.setAlertDate(result);
            alertMsg.setMsg("<div class='toast choose' role='alert' aria-live='assertive' aria-atomic='true'>" +
                    "<div class='toast-header'>" +
                    "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
                    result +
                    "</div>" +
                    "<div class='toast-body'>" +
                    alertMsg.getBuyer() + " 님이 " + "<a href='/board/marketDetail?sb_num=" + alertMsg.getSb_num() + "' style=\"color:black\"><strong>" + alertMsg.getSb_title() + "</strong> 에 구매신청을 하였습니다..</a>" +
                    "</div>" +
                    "</div>");
            String alertContents = alertMsg.getMsg().replace("\"", "\\\"");
            String alert = "{\"type\":\"alert\",\"contents\":\""+alertContents+"\"}";
            if (sendedPushSession != null) {
                sendedPushSession.sendMessage(new TextMessage(alert));
            } else {
                notificationBuffer.computeIfAbsent(alertMsg.getSeller(), k -> new ArrayList<>()).add(alert);
            }
            bSer.alertMsg(alertMsg);
            bSer.chatting(alertMsg);
        }
        if (alertMsg.getType().equals("attend")) {
//            if (sendedPushSession != null) {
//                sendedPushSession.sendMessage(new TextMessage(alertMsg.getA_bidPrice()));
//                sendedPushSession.sendMessage(new TextMessage(alertMsg.getBuyer()));
//            } else {
//                notificationBuffer.computeIfAbsent(alertMsg.getSeller(), k -> new ArrayList<>()).add(alertMsg.getMsg());
//            }
            String price = "{\"type\":\"price\",\"value\":\""+alertMsg.getA_bidPrice()+"\"}";
            String buyer = "{\"type\":\"buyer\",\"name\":\""+alertMsg.getBuyer()+"\"}";
            for (WebSocketSession webSocketSession : sessions) {
                if (webSocketSession.isOpen()) {
                    webSocketSession.sendMessage(new TextMessage(price));
                    webSocketSession.sendMessage(new TextMessage(buyer));
                }

            }
        }
    }


    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.info("Socket 연결 해제");
        sessions.remove(session);
        String userId = sendPushUsername(session);
        userSessionMap.remove(userId, session);
    }

    //알람을 보내는 유저(댓글작성, 좋아요 누르는 유저)
    private String sendPushUsername(WebSocketSession session) {
        String loginUsername;

        if (session.getPrincipal() == null) {
            loginUsername = null;
        } else {
            loginUsername = session.getPrincipal().getName();
        }
        return loginUsername;
    }
}
