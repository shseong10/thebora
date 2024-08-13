package com.icia.guree.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PayReadyResponse {
    private String tid;
    private String next_redirect_pc_url;

}
