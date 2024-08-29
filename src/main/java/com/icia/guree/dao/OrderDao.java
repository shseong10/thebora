package com.icia.guree.dao;

import com.icia.guree.entity.OrderDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderDao {
    boolean buyNewItem(OrderDto order);

    boolean addPoint(OrderDto order);

    List<OrderDto> getMyOrder(String name);

    boolean saveSales(OrderDto order);
}
