package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

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
    private String order_date;
    private String order_status;

    private String sb_title;
    private String bf_sysfilename;
    private String m_name;
    private String m_phone;
    private String m_addr;

    private int total_amount;
    private String item_name;
    private int quantity;

    private int sb_num;
    private int sb_salekind;
    private int sb_id;
    private int sb_scope;
    private List<BoardFileDto> bfList;
}
