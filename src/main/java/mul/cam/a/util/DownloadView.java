package mul.cam.a.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import mul.cam.a.service.BbsService;

public class DownloadView extends AbstractView{
	
	@Autowired
	BbsService service;

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("DownloadView renderMergedOutputModel");
		
		File downloadfile = (File)model.get("downloadfile");
		String filename = (String)model.get("filename");
		int seq = (Integer)model.get("seq");
		
		response.setContentType(this.getContentType());
		response.setContentLength((int)downloadfile.length());
		
		filename = URLEncoder.encode(filename, "utf-8");
		
		
		// 다운로드 창에 실제로 나오게 되는거
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");	// 다운로드 받을떄 원본명으로 바꿈
		response.setHeader("Content-Transfer-Encoding", "binary;");									// 2진수로 받아라
		response.setHeader("Content-Length", "" + downloadfile.length());							// 파일의 길이값 
		response.setHeader("Pragma", "no-cache;"); 													// 저장을 잠깐 하는지 여부
		response.setHeader("Expires", "-1;");														// 기한
		
		OutputStream os = response.getOutputStream();
		FileInputStream fis = new FileInputStream(downloadfile);
		
		// 실제 데이터 기입
		FileCopyUtils.copy(fis, os);
		
		// download count 증가
		
		
		
		if(fis != null) {
			fis.close();
		}
		
		// 한글명 정상 작동 가능토록
		
	}
	
	

}
