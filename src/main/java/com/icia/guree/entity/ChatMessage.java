package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessage {
    public enum MessageType {
        ENTER, TALK, QUIT, submit, accept, denied
    }
    private MessageType type;
    private String c_recieveid;
    private String c_sendid;
    private String c_contents;
    private String c_sendtime;
}
