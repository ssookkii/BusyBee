package mul.cam.a.util;

import java.util.Date;

public class FileUtil {

	public static String getNewFileName(String filename) {
		
		String newfilename = "";
		String fpost = "";
		
		if(filename.indexOf('.')>=0) { // 확장자명이 있음
			fpost = filename.substring(filename.indexOf('.')); // .txt
			newfilename = new Date().getTime() + fpost;
			
		} else { // 확장자명이 없음
			newfilename = new Date().getTime() + ".back";
		}
		
		return newfilename;
	}
	
}
