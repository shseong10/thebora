package com.icia.guree.service;

import com.icia.guree.common.Paging;
import com.icia.guree.common.QuestionFileManager;
import com.icia.guree.dao.QuestionDao;
import com.icia.guree.entity.QuestionDto;
import com.icia.guree.entity.SearchDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class QuestionService {

    @Autowired
    private QuestionDao qDao;

    @Autowired
    private QuestionFileManager qm;

    public static final int LISTCNT = 10;
    public static final int PAGECOUNT = 2;

    public List<QuestionDto> getQuestionList(SearchDto sDto) {
        int pageNum = sDto.getPageNum();
        sDto.setStartIdx((pageNum - 1) * sDto.getListCnt());
        log.info("여기 왔냐????????");
        return qDao.getQuestionList(sDto);
    }

    public String getPaging(SearchDto sDto) {
        int totalNum = qDao.getQuestionCount(sDto);
        log.info("totalNum:{}", totalNum);
        String listUrl = null;
        if (sDto.getColName() != null) {
            listUrl = "/question/list?colName=" + sDto.getColName()
                    + "&keyWord=" + sDto.getKeyWord() + "&";
        } else {
            listUrl = "/question/list?";
        }
        Paging p = new Paging(totalNum, sDto.getPageNum(), sDto.getListCnt(), PAGECOUNT, listUrl);
        return p.makeHtmlPaging();
    }

    public boolean questionWrite(QuestionDto qDto, HttpSession ses) {
        boolean result = qDao.questionWrite(qDto);
        if (!qDto.getAttachments().get(0).isEmpty()) {
            if (qm.fileUpload(qDto.getAttachments(), ses, qDto.getQ_num())) {
                log.info("업로드 성공!");
                return true;
            }
            return true;
        }
        return result;
    }

    public QuestionDto getQuestionDetail(Integer q_num) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String viewId = qDao.getQuestionViewId(userDetails.getUsername(),q_num);
            if (viewId == null || !viewId.equals(userDetails.getUsername())) {
                qDao.setQuestionViewInfo(q_num,userDetails.getUsername());
                qDao.setQuestionView(q_num);
            }
        }
        return qDao.getQuestionDetail(q_num);
    }

    public boolean questionUpdate(QuestionDto qDto, HttpSession ses) {
        log.info("수정할 Dto:{}",qDto);
        boolean result = qDao.questionUpdate(qDto);
        if(result){
            if(!qDto.getAttachments().get(0).isEmpty()){
                String[] files = qDao.getSysFiles(qDto.getQ_num());
                if(files.length != 0){
                    qm.fileDelete(files, ses);
                    qDao.fileDelete(qDto.getQ_num());
                }
                if(qm.fileUpload(qDto.getAttachments(), ses, qDto.getQ_num())){
                    log.info("업로드 성공!!");
                    return true;
                }
            }
            return true;
        }else{
            return false;
        }
    }
}
