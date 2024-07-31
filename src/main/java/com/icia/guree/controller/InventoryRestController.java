package com.icia.guree.controller;

import com.icia.guree.entity.InventoryDto;
import com.icia.guree.service.InventoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
public class InventoryRestController {

    @Autowired
    private InventoryService iSer;

    @GetMapping("/hotdeal/admin/quickupdate")
    public String quickUpdate() {
        log.info("quickUpdate");
        return "redirect:/admin/main";
    }

    @GetMapping("/hotdeal/admin/quickview")
    public List<InventoryDto> getQuickView(@RequestParam("h_p_num") Integer h_p_num, Model model) {
        log.info("<<<<<<<h_p_num=" + h_p_num);
        List<InventoryDto> quickView = iSer.getQuickView(h_p_num);
        log.info("<<<<<<<<InventoryDto: {}", quickView);
        model.addAttribute("quickView", quickView);
        return quickView;
    }

    @PostMapping("/hotdeal/admin/quickupdate")
    public HashMap<String, Object> quickUpdate(@RequestBody InventoryDto inventory) {
        List<InventoryDto> iList = iSer.quickUpdate(inventory);
        HashMap<String, Object> hMap = new HashMap<>();
        hMap.put("iList", inventory);
        log.info(">>>>>> quickUpdate: {}", hMap);

        return hMap;
    }
}
