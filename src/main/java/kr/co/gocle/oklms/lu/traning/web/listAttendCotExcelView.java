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
import org.springframework.web.servlet.view.document.AbstractXlsxView;


public class listAttendCotExcelView extends AbstractXlsxView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// TODO Auto-generated method stub
		String strClient = request.getHeader("User-Agent");
		String fileName = model.get("excelFileName") + ".xlsx";
        if (strClient != null && strClient.contains("MSIE")) {
            response.setHeader("Content-Disposition", "filename=" + fileName + ";");
        } else {
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");


		OutputStream fileOut = null;

		/*
		 * //워크북 생성 XSSFWorkbook objWorkBook = new XSSFWorkbook(); //워크시트 생성 XSSFSheet
		 * objSheet = objWorkBook.createSheet(); //시트 이름 objWorkBook.setSheetName(0 ,
		 * "data" ); //행생성 XSSFRow objRow = objSheet.createRow((short)0); //셀 생성
		 * XSSFCell objCell = null;
		 */
		//------------------------
		
		XSSFSheet sheet = (XSSFSheet) workbook.createSheet("data");

		// 헤더 작성
        XSSFRow header = sheet.createRow(0);
		String[] headers = {"기업명", "훈련과정명", "훈련시작일", "훈련종료일", "교과목명", "능력단위명",
                "훈련일자", "훈련 시작시간", "훈련 종료시간", "기업현장교사명", "학습근로자명",
                "훈련계획시간", "실제훈련시간", "비고", "총평"};
		
		for (int i = 0; i < headers.length; i++) {
            XSSFCell cell = header.createCell(i);
            cell.setCellValue(headers[i]);
        }

		// 데이터 작성
        @SuppressWarnings("unchecked")
		List<TraningNoteVO> data = (List<TraningNoteVO>) model.get("resultList");
		
        for (int i = 0; i < data.size(); i++) {
            TraningNoteVO vo = data.get(i);
            XSSFRow row = sheet.createRow(i + 1);

            row.createCell(0).setCellValue(vo.getCompanyName());
            row.createCell(1).setCellValue(vo.getTraningProcessName());
            row.createCell(2).setCellValue(vo.getStartDate());
            row.createCell(3).setCellValue(vo.getEndDate());
            row.createCell(4).setCellValue(vo.getSubjectName());
            row.createCell(5).setCellValue(vo.getNcsUnitName());
            row.createCell(6).setCellValue(vo.getTraningDate());
            row.createCell(7).setCellValue(vo.getTraningStHour());
            row.createCell(8).setCellValue(vo.getTraningEdHour());
            row.createCell(9).setCellValue(vo.getTutName());
            row.createCell(10).setCellValue(vo.getMemName());
            row.createCell(11).setCellValue(vo.getStudyTimePlan());
            row.createCell(12).setCellValue(vo.getStudyTime());
            row.createCell(13).setCellValue(vo.getBigo());
            row.createCell(14).setCellValue(vo.getReview());
        } 

        // 컬럼 너비 자동 조정
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
            sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 600);
        }
		
	}

}
