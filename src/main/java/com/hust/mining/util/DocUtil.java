package com.hust.mining.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTP;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTR;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTText;

public class DocUtil {
	
	FileOutputStream fos;
	XWPFDocument docx;
	
	public DocUtil(String filename) {
		try {
			fos = new FileOutputStream(filename);
			docx = new XWPFDocument();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private void init(){
		//设置页眉
		CTP ctpHeader = CTP.Factory.newInstance();
		CTR ctrHeader = ctpHeader.addNewR();
		CTText ctHeader = ctrHeader.addNewT();
		ctHeader.setStringValue("这是页眉");
	}
	
}
