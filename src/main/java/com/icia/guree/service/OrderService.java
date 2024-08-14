package com.icia.guree.service;

import com.icia.guree.dao.OrderDao;
import com.icia.guree.entity.OrderDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class OrderService {
    @Autowired
    private OrderDao oDao;

    public boolean buyItem(OrderDto order) {
        boolean result = oDao.buyNewItem(order);
        if (result) {
            return true;
        } else {
            return false;
        }
    }

    public boolean addPoint(OrderDto order) {
        return oDao.addPoint(order);
    }

    public List<OrderDto> myOrder(String name) {
        return oDao.getMyOrder(name);
    }
}
