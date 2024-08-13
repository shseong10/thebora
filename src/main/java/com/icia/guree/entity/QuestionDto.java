package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class QuestionDto {
    private int q_num;
    private String q_id;
    private String q_title;
    private String q_contents;
    private String q_date;
    private String q_views;

    List<MultipartFile> attachments;
    private List<QuestionFileDto> qfList;
}
