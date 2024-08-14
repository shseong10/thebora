package com.icia.guree.service;

import com.icia.guree.common.BoardFileManager;
import com.icia.guree.dao.BoardDao;
import com.icia.guree.dao.FileDao;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class AdminService {
    @Autowired
    private FileDao fDao;
    @Autowired
    private BoardFileManager bfm;
    @Autowired
    private BoardDao bDao;
    @Autowired
    private MemberDao mDao;



    public boolean realDelete(Integer sb_num, HttpSession session) {
        String[] sysFiles = fDao.getBoardSysFiles(sb_num);
        if (sysFiles.length != 0) {
            bfm.fileDelete(sysFiles, session);
        }
       return bDao.realDelete(sb_num);
    }

    public boolean restore(Integer sb_num) {
       return bDao.restore(sb_num);
    }

    public boolean cateDelete(String c_kind) {
       return bDao.cateDelete(c_kind);
    }

    public boolean cateAttend(String c_kind) {
       return bDao.cateAttend(c_kind);
    }

    public boolean memberUpdate(MemberDto mDto) {
       return mDao.memberUpdate(mDto) ;
    }

    public boolean reUpload(BoardDto bDto) {
        return bDao.reUpload(bDto);
    }

    public List<String> picture(String sbNum) {
        return bDao.picture(sbNum);
    }
}