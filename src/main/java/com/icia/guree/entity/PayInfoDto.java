package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayInfoDto {
    //payInfo
    private int price;
    private String itemName;

}
