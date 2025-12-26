/*******************************************************************************
 * COPYRIGHT(C) 2016 WIZI LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of WIZI LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 김현민    2016.10.26
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.lu.traning.web;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractXlsxView;


public class listAttendPrdExcelView extends AbstractXlsxView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// TODO Auto-generated method stub
		String strClient = request.getHeader("User-Agent");
		String fileName = (String) model.get("excelFileName")+".xlsx";
		String traningType = (String) model.get("traningType");


		if (strClient.indexOf("MSIE 5.5") > -1) {
			//response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "filename=" + fileName + ";");
		} else {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");

		}

		XSSFWorkbook xssfWorkbook = (XSSFWorkbook) workbook;
	    XSSFSheet sheet = xssfWorkbook.createSheet("data");

	    XSSFRow row;
        XSSFCell cell;
        
        // 헤더 생성
        row = sheet.createRow(0);
        int col = 0;

		if(traningType.equals("OFF")){
			String[] headers = {"기업명", "훈련과정명", "훈련시작일", "훈련종료일", "교과목명",
                    "온라인훈련방식", "능력단위명", "훈련일자", "훈련 시작시간", "훈련 종료시간",
                    "학습근로자명", "학번", "훈련계획시간", "실제훈련시간", "비고", "총평"};

            for (String header : headers) {
                cell = row.createCell(col++);
                cell.setCellValue(header);
            }
			
			List<TraningNoteVO> data = (List<TraningNoteVO>) model.get("resultList");
			
			 for (int i = 0; i < data.size(); i++) {
	                TraningNoteVO vo = data.get(i);
	                row = sheet.createRow(i + 1);
	                col = 0;
	                row.createCell(col++).setCellValue(vo.getCompanyName());
	                row.createCell(col++).setCellValue(vo.getTraningProcessName());
	                row.createCell(col++).setCellValue(vo.getStartDate());
	                row.createCell(col++).setCellValue(vo.getEndDate());
	                row.createCell(col++).setCellValue(vo.getSubjectName());
	                row.createCell(col++).setCellValue(vo.getOnlineType());
	                row.createCell(col++).setCellValue(vo.getNcsUnitName());
	                row.createCell(col++).setCellValue(vo.getTraningDate());
	                row.createCell(col++).setCellValue(vo.getTraningStHour());
	                row.createCell(col++).setCellValue(vo.getTraningEdHour());
	                row.createCell(col++).setCellValue(vo.getMemName());
	                row.createCell(col++).setCellValue(vo.getMemId());
	                row.createCell(col++).setCellValue(vo.getStudyTimePlan());
	                row.createCell(col++).setCellValue(vo.getStudyTime());
	                row.createCell(col++).setCellValue(vo.getBigo());
	                row.createCell(col++).setCellValue(vo.getReview());
	            }

			 	for (int i = 0; i < headers.length; i++) {
	                sheet.autoSizeColumn(i);
	                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 600);
	            }
			
		} else {
			String[] headers = {"기업명", "훈련과정명", "훈련시작일", "훈련종료일", "교과목명",
                    "능력단위명", "훈련일자", "훈련 시작시간", "훈련 종료시간",
                    "학습근로자명", "학번", "훈련계획시간", "실제훈련시간", "비고", "총평"};

            for (String header : headers) {
                cell = row.createCell(col++);
                cell.setCellValue(header);
            }
			
			List<TraningNoteVO> data = (List<TraningNoteVO>) model.get("resultList");
			
			for (int i = 0; i < data.size(); i++) {
                TraningNoteVO vo = data.get(i);
                row = sheet.createRow(i + 1);
                col = 0;
                row.createCell(col++).setCellValue(vo.getCompanyName());
                row.createCell(col++).setCellValue(vo.getTraningProcessName());
                row.createCell(col++).setCellValue(vo.getStartDate());
                row.createCell(col++).setCellValue(vo.getEndDate());
                row.createCell(col++).setCellValue(vo.getSubjectName());
                row.createCell(col++).setCellValue(vo.getNcsUnitName());
                row.createCell(col++).setCellValue(vo.getTraningDate());
                row.createCell(col++).setCellValue(vo.getTraningStHour());
                row.createCell(col++).setCellValue(vo.getTraningEdHour());
                row.createCell(col++).setCellValue(vo.getMemName());
                row.createCell(col++).setCellValue(vo.getMemId());
                row.createCell(col++).setCellValue(vo.getStudyTimePlan());
                row.createCell(col++).setCellValue(vo.getStudyTime());
                row.createCell(col++).setCellValue(vo.getBigo());
                row.createCell(col++).setCellValue(vo.getReview());
            }

            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 600);
            }
		}
	}

}
