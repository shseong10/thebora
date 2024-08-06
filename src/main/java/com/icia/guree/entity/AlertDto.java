package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AlertDto {
    private String type;
    private String seller;
    private String buyer;
    private String sb_num;
    private String sb_title;
    private String msg;
    private String a_bidPrice;
    private String alertDate;
}
