package com.icia.guree.common;

import com.icia.guree.dao.NoticeDao;
import com.icia.guree.entity.NoticeFileDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Slf4j
@Service
public class NoticeFileManager {

	@Autowired
	private NoticeDao nDao;

	// 파일 업로드, DB저장
	public boolean fileUpload(List<MultipartFile> attachments, HttpSession session, int n_num) {
		log.info("FileManager class");
		// 프로젝트의 upload경로 찾기
		String realPath = session.getServletContext().getRealPath("/");
		log.info("realPath={}", realPath);
		realPath += "upload/";
		log.info("realPath={}", realPath);

		// 2.폴더 생성을 꼭 할것...
		File dir = new File(realPath);
		if (!dir.isDirectory()) { // upload폴더 없다면
			dir.mkdir(); // upload폴더 생성
		}
		//파일의 정보를 BoardFile or HashMap에 저장
		Map<String, String> fMap = new HashMap<String, String>();
		fMap.put("n_num", String.valueOf(n_num));
		//System.out.println("size:"+attachments.size());
		boolean result = false;
		for( MultipartFile mf : attachments) {
			// 파일 메모리에 저장
			String oriFileName = mf.getOriginalFilename(); // a.txt
			if(Objects.requireNonNull(oriFileName).isEmpty()){
				return false;
			}
			System.out.println("원조 파일:"+oriFileName);
			fMap.put("oriFileName", oriFileName);
			// 4.시스템파일이름 생성 a.txt ==>112323242424.txt
			String sysFileName = System.currentTimeMillis() + "."
					+ oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
			System.out.println("서버 파일:"+sysFileName);
			fMap.put("sysFileName", sysFileName);
			
			// 5.메모리->실제 파일 업로드
			try {
				mf.transferTo(new File(realPath + sysFileName)); // 서버upload에 파일 저장
				//Map버전
				result= nDao.fileUpload(fMap);
				if(!result) break;
			} catch (IOException e) {
				System.out.println(e.getMessage());
				System.out.println("파일업로드 예외 발생");
				e.printStackTrace();
				result=false;
				break;  //반복 중단
			}
		} // For end
		return result;
	}
	
	public void fileDelete(String[] sysfiles, HttpSession session) {
		String realPath = session.getServletContext().getRealPath("/");
		realPath += "upload/";
		log.info("delete realPath: {}",realPath);
		for (String sysname : sysfiles) {  
			File file = new File(realPath + sysname);
			log.info("++++AbsoluteFile: {}",file.getAbsoluteFile());
			if (file.exists()) {
				file.delete();
				log.info("서버 파일 삭제 완료");
			} else {
				log.info("이미 삭제된 파일");
			}
		}//for end
	}

	public ResponseEntity<Resource> fileDownLoad(NoticeFileDto nFile, HttpSession ses) throws IOException{
		log.info("파일 다운로드");
		String realpath = ses.getServletContext().getRealPath("/");
		realpath += "upload/" + nFile.getNf_sysFileName();
		InputStreamResource res = new InputStreamResource(new FileInputStream(realpath));

		String fileName = URLEncoder.encode(nFile.getNf_oriFileName(), StandardCharsets.UTF_8);
		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
				.cacheControl(CacheControl.noCache()).body(res);
	}
}
