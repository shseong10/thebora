package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

@Data
@Accessors(chain = true)
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderDto {
    private int order_num;
    private int item_num;
    private String order_id;
    private int order_count;
    private int item_price;
    private LocalDateTime order_date;
    private String order_status;

    private String sb_title;
    private String bf_sysfilename;
    private String m_name;
    private String m_phone;
    private String m_addr;

    private int total_amount;
    private String item_name;
    private int quantity;
}
