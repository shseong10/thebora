package com.icia.guree.dao;

import com.icia.guree.entity.QuestionDto;
import com.icia.guree.entity.SearchDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface QuestionDao {


    List<QuestionDto> getQuestionList(SearchDto sDto);

    int getQuestionCount(SearchDto sDto);

    boolean questionWrite(QuestionDto qDto);

    String getQuestionViewId(String username, Integer q_num);

    void setQuestionViewInfo(Integer q_num, String username);

    void setQuestionView(Integer q_num);

    QuestionDto getQuestionDetail(Integer q_num);

    boolean questionUpdate(QuestionDto qDto);

    String[] getSysFiles(int q_num);

    boolean fileUpload(Map<String, String> fMap);

    void fileDelete(int q_num);

}
