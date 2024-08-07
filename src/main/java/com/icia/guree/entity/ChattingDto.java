package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChattingDto {
    private String c_num;
    private String c_sendid;
    private String sellerId;
    private String c_title;
    private String c_contents;
    private String c_sendtime;
    private String username;
}
