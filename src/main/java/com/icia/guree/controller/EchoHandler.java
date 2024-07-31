package com.icia.guree.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Component
@Slf4j
@RequiredArgsConstructor
public class EchoHandler extends TextWebSocketHandler {
    // 전체 로그인 유저
    private List<WebSocketSession> sessions = new ArrayList<>();

    // 1대1 매핑
    private Map<String, WebSocketSession> userSessionMap = new HashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("Socket 연결");
        sessions.add(session);
        log.info(sendPushUsername(session));				//현재 접속한 사람의 username이 출력됨
        String senderId = sendPushUsername(session);
        userSessionMap.put(senderId, session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.info("session = " + sendPushUsername(session));
        String msg = message.getPayload();				//js에서 넘어온 메세지
        log.info("msg = " + msg);

        if (!StringUtils.isEmpty(msg)) {
            String[] strs = msg.split(",");

            if (strs != null && strs.length == 5) {
                String pushCategory = strs[0];			//구매신청, 채팅 등등 구분
                String buyer = strs[1];			//보낸 유저
                String seller = strs[2];		//푸시 알림 받을 유저
                String sb_num = strs[3];				//게시글번호
                String title = strs[4];					//게시글제목

                WebSocketSession sendedPushSession = userSessionMap.get(seller);	//로그인상태일때 알람 보냄

                //구매신청
                if ("apply".equals(pushCategory) && sendedPushSession != null) {
                    TextMessage textMsg = new TextMessage(buyer + " 님이 " + "<a href='/board/marketDetail?sb_num="+sb_num+"' style=\"color:black\"><strong>" + title + "</strong> 에 구매신청을 하였습니다..</a>");
                    sendedPushSession.sendMessage(textMsg);
                }

                //좋아요
//                else if ("like".equals(pushCategory) && sendedPushSession != null) {
//                    TextMessage textMsg = new TextMessage(buyer + " 님이 " + "<a href='/porfolDetail/" + sb_num + "' style=\"color:black\"><strong>" + title + "</strong> 을 좋아요♡ 했습니다.</a>");
//                    sendedPushSession.sendMessage(textMsg);
//                }
//
//                //자식댓글
//                else if ("reReply".equals(pushCategory) && sendedPushSession != null) {
//                    TextMessage textMsg = new TextMessage(buyer + " 님이 " + "<a href='/porfolDetail/" + sb_num + "' style=\"color:black\"><strong>" + title + "</strong> 글의 회원님 댓글에 답글을 남겼습니다.</a>");
//                    sendedPushSession.sendMessage(textMsg);
//                }
            }
        }
    }

//    @Override
//    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        log.info("Socket 연결 해제");
//        sessions.remove(session);
//        userSessionMap.remove(sendPushUsername(session), session);
//    }

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
