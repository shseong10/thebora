package com.icia.guree.service;

import com.icia.guree.common.FileManager;
import com.icia.guree.common.Paging;
import com.icia.guree.dao.InventoryDao;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.CategoryDto;
import com.icia.guree.entity.InventoryDto;
import com.icia.guree.entity.SearchDto;
import com.icia.guree.exception.DBException;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class InventoryService {
    @Autowired
    private InventoryDao iDao;

    @Autowired
    private FileManager fm;

    public static final int LISTCNT=10; //페이지당 10개
    public static final int PAGECOUNT=2; //페이지 그룹   이전 [3]  [4] 다음

    //상품 리스트 가져오기
    public List<InventoryDto> getInventoryList(Integer pageNum) {
        int startIdx =(pageNum-1)*LISTCNT;
        Map<String, Integer> pageMap=new HashMap<>();
        pageMap.put("startIdx", startIdx);
        pageMap.put("listCnt", LISTCNT);

        List<InventoryDto> iList = iDao.getInventoryList(pageMap);
        return iList;
    }

    //상품 카테고리 가져오기
    public List<CategoryDto> getCategoryList() {
        List<CategoryDto> cList = null;
        return  iDao.getCategoryList();
    }

    //상품 등록하기
    public boolean addItem (InventoryDto inventory, HttpSession session) {
        boolean result = iDao.addItemSelectKey(inventory);
        if (result) {
            if(!inventory.getAttachments().get(0).isEmpty()) {
                if(fm.fileUpload(inventory.getAttachments(), session, inventory.getSb_num())) {
                    log.info("=== 상품 등록 완료 ===");
                    return true;
                }
            }
            return true;
        } else {
            return false;
        }
    }

    //상품 상세보기
    public InventoryDto getInventoryDetail(Integer sb_num) {
        return iDao.getInventoryDetail(sb_num);
    }

    //상품 수정하기
    public boolean updateItem (InventoryDto inventory, HttpSession session) {
        boolean result = iDao.updateItem(inventory);
        if (result) {
            if(!inventory.getAttachments().get(0).isEmpty()) {
                //기존 파일 삭제
//                String[] sysFiles = iDao.getsysFiles(inventory.getSb_num());
//                if(sysFiles.length != 0) {
//                    fm.fileDelete(sysFiles, session);
//                    iDao.deleteFile(inventory.getSb_num());
//                }
                if(fm.fileUpload(inventory.getAttachments(), session, inventory.getSb_num())) {
                    log.info("!!=== 상품 수정 완료 ===!!");
                    return true;
                }
            }
            return true;
        } else {
            return false;
        }
    }

    //상품 삭제하기
    @Transactional
    public void deleteItem(Integer sb_num, HttpSession session) throws DBException {
        //파일 삭제
        String[] sysFiles = iDao.getsysFiles(sb_num);
        if(sysFiles.length != 0) {
            if(iDao.deleteFile(sb_num) == false) {
                log.info("!! deleteFile 예외발생");
                throw new DBException(); //롤백
            }
        }
        //원글 삭제
        if(!iDao.deleteItem(sb_num)) {
            log.info("!! deleteItem 예외발생");
            throw new DBException(); //롤백
        }
        //서버 파일 삭제
        if(sysFiles.length != 0) {
            fm.fileDelete(sysFiles, session);
        }
    }

    //관리자페이지
    //상품 리스트 가져오기
    public List<InventoryDto> getAdmin(Integer pageNum) {
        int startIdx =(pageNum-1)*LISTCNT;
        Map<String, Integer> pageMap=new HashMap<>();
        pageMap.put("startIdx", startIdx);
        pageMap.put("listCnt", LISTCNT);

        List<InventoryDto> iList = iDao.getInventoryList(pageMap);
        return iList;
    }

    public List<InventoryDto> quickUpdate(InventoryDto inventory) {
        List<InventoryDto> iList = null;
        if(iDao.quickUpdate(inventory)) {
//            iList = iDao.getInventoryList();
            log.info("빠른 수정 저장 성공");
        }
        return iList;
    }

    public List<InventoryDto> getQuickView(Integer sb_num) {
        List<InventoryDto> quickView = null;
        quickView = iDao.getQuickView(sb_num);
        if (quickView != null) {
            return quickView;
        } else {
            return null;
        }
    }

    public int countMarketItems(SearchDto sDto) {
        return iDao.countHotdealItems(sDto);
    }
}
