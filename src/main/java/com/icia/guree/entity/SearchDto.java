package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SearchDto {
    private String sb_num;
    private String sb_id;
    private String sb_category;
    private String sb_saleKind;
    private String sb_title;
    private String sb_contents;
    private String sb_brand;
    private String sb_startPrice;
    private String sb_nowPrice;
    private String sb_price;
    private int sb_bid;
    private String sb_timer;
    private String sb_local;
    private String sb_count;
    private String sb_date;
    private String sb_scope;
    private String sb_view;
    private String a_num;
    private String a_joinId;
    private int a_bidPrice;
    private List<MultipartFile> attachment;
    private List<BoardFileDto>bfList;
    private String colName;
    private String keyWord;
    private Integer pageNum;
    private Integer listCnt;
    private Integer startIdx;
}
