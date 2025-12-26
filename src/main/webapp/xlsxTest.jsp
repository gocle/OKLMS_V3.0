<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.*,
				java.io.*,
				java.util.List,
				java.util.HashMap,
				org.apache.poi.xssf.usermodel.XSSFCellStyle,
				org.apache.poi.xssf.usermodel.XSSFFont,
				org.apache.poi.xssf.usermodel.XSSFCell,
				org.apache.poi.xssf.usermodel.XSSFRow,
				org.apache.poi.xssf.usermodel.XSSFSheet,
				org.apache.poi.xssf.usermodel.XSSFWorkbook,
				org.apache.poi.xssf.usermodel.XSSFColor,
				org.apache.poi.ss.util.CellRangeAddress,
				org.apache.poi.ss.usermodel.Font,
				org.apache.poi.ss.usermodel.IndexedColors"%>

<%

String sFileName = "tem.xlsx";

sFileName = new String ( sFileName.getBytes("KSC5601"), "8859_1");
out.clear();
out = pageContext.pushBody();

response.reset(); 	// 이 문장이 없으면 excel 등의 파일에서 한글이 깨지는 문제 발생.
String strClient = request.getHeader("User-Agent");
String fileName = sFileName;


if (strClient.indexOf("MSIE 5.5") > -1) {

	//response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "filename=" + fileName + ";");

} else {

	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");

}


OutputStream fileOut = null;


//워크북 생성
XSSFWorkbook objWorkBook = new XSSFWorkbook();

//워크시트 생성
XSSFSheet objSheet = objWorkBook.createSheet();

//시트 이름
objWorkBook.setSheetName(0 , "data" );

//행생성
XSSFRow objRow = objSheet.createRow((short)0);

//셀 생성
XSSFCell objCell = null;

//------------------------




objRow = objSheet.createRow((short)0);

objCell = objRow.createCell((short)0);
objCell.setCellValue("aa");

objCell = objRow.createCell((short)1);
objCell.setCellValue("bb");

objCell = objRow.createCell((short)2);
objCell.setCellValue("cc");

objCell = objRow.createCell((short)3);
objCell.setCellValue("dd");

objCell = objRow.createCell((short)4);
objCell.setCellValue("ee");

objCell = objRow.createCell((short)5);
objCell.setCellValue("ff");

objCell = objRow.createCell((short)6);
objCell.setCellValue("gg");

objCell = objRow.createCell((short)7);
objCell.setCellValue("hh");


//----------------------------------------------------------------------------------------

//길이 설정

objSheet.setColumnWidth((short)0,(short)3000);

objSheet.setColumnWidth((short)1,(short)3000);

objSheet.setColumnWidth((short)2,(short)3000);

objSheet.setColumnWidth((short)3,(short)3000);

objSheet.setColumnWidth((short)4,(short)3000);

objSheet.setColumnWidth((short)5,(short)8000);

objSheet.setColumnWidth((short)6,(short)3000);

objSheet.setColumnWidth((short)7,(short)5000);



//--------------------------------------------------------------------------------------

fileOut = response.getOutputStream(); 
objWorkBook.write(fileOut);
fileOut.close();

%>

 <%-- 
						<table   width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
							<colgroup>
								<col style="width:10%" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<c:if test="${traningType eq 'OFF'}">
									<col style="width:*" />
								</c:if>
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
							</colgroup>
							<thead>
								<tr>
									<th>기업명</th>
									<th>훈련과정명</th>
									<th>훈련시작일</th>
									<th>훈련종료일</th>
									<th>교과목명</th>
									<c:if test="${traningType eq 'OFF'}">
										<th>온라인훈련방식</th>
									</c:if>
									<th>능력단위명</th>
									<th>훈련일자</th>
									<th>훈련 시작시간</th>
									<th>훈련 종료시간</th>
									<th>학습근로자명</th>
									<th>학번</th>
									<th>훈련계획시간</th>
									<th>실제훈련시간</th>
									<th>비고</th>
									<th>총평</th>
								</tr>
							</thead>
							<tbody  id="tableList">
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td>${result.companyName}</td>
										<td>${result.traningProcessName}</td>
										<td>${result.startDate}</td>
										<td>${result.endDate}</td>
										<td>${result.subjectName}</td>
										<c:if test="${traningType eq 'OFF'}">
										<td>${result.onlineType}</td>
										</c:if>
										<td>${result.ncsUnitName}</td>
										<td>${result.traningDate}</td>
										<td>${result.traningStHour}</td>
										<td>${result.traningEdHour}</td>
										<td>${result.memName}</td>
										<td>${result.memId}</td>
										<td>${result.studyTimePlan}</td>
										<td>${result.studyTime}</td>
										<td>${result.bigo}</td>
										<td>${result.review}</td>						
									</tr>
							</c:forEach>
							</tbody>
						</table> --%>