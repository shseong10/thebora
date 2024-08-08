package com.icia.guree.dao;

import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.CategoryDto;
import com.icia.guree.entity.InventoryDto;
import com.icia.guree.entity.SearchDto;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface InventoryDao {

    @Select("select * from saleboard")
    List<InventoryDto> compareQuary();

    boolean addItemSelectKey(InventoryDto inventory);

    List<InventoryDto> getInventoryList(Map<String, Integer> pageMap);

    List<InventoryDto> getAdmin();

    boolean fileInsertMap(Map<String, String> fMap);

    @Select("select bf_sysfilename from boardfile where bf_sb_num=#{sb_num}")
    String[] getsysFiles(int sb_num);

    InventoryDto getInventoryDetail(int sb_num);

    List<CategoryDto> getCategoryList();

    boolean updateItem (InventoryDto inventory);

    //첨부파일 삭제
    @Delete("delete from boardfile where bf_sb_num=#{sb_num}")
    boolean deleteFile(int sb_num);

    //상품 삭제
    @Delete("delete from saleboard where sb_num=#{sb_num}")
    boolean deleteItem(Integer sb_num);

    boolean quickUpdate(InventoryDto inventory);

    List<InventoryDto> getQuickView(Integer sb_num);

    List<InventoryDto> getInventoryListSearch(SearchDto sDto);

    @Delete("delete from boardfile where bf_sb_num=#{sb_num} and bf_orifilename=#{bf_orifilename}")
    boolean deleteSelFmap(Map fMap);

    int countHotdealItems(SearchDto sDto);
}
