package kr.co.gocle.oklms.la.statistics.web;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gocle.ifx.service.CmsIfxService;
import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.ifx.vo.CmsCourseContentVO;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.la.statistics.service.ContentStatisticsService;
import kr.co.gocle.oklms.la.statistics.vo.ContentStatVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

@Controller
public class ContentStatisticsController extends BaseController{
	
	@Autowired
	CmsIfxService cmsIfxService;
	
	@Autowired
	ContentStatisticsService contentStatistcsService;

	/**
	 * 콘텐츠 통계 리스트
	 * @param commandMap
	 * @param cmsCourseBaseVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/la/statistics/content/listContentStat.do")
	public String popupOnlineTraning(@RequestParam Map<String, Object> commandMap, @ModelAttribute("frmPop") CmsCourseBaseVO cmsCourseBaseVO, ModelMap model) throws Exception {
		
		
		// 등록 된 콘텐츠 별 버전목록을 가져온다.
		List<CmsCourseContentVO> resultList = contentStatistcsService.listCourseContentStat(cmsCourseBaseVO);
				
		Integer pageSize = cmsCourseBaseVO.getPageSize();
		Integer page = cmsCourseBaseVO.getPageIndex();
		
		int totalCnt = 0;
		if( 0 < resultList.size() ){
			totalCnt = Integer.parseInt( resultList.get(0).getTotalCount() );
		}
		int totalPage = (int) Math.ceil(totalCnt / pageSize);

        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalCount", totalCnt);
        model.addAttribute("pageIndex", page);

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(cmsCourseBaseVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(cmsCourseBaseVO.getPageUnit());
        paginationInfo.setPageSize(cmsCourseBaseVO.getPageSize());
        paginationInfo.setTotalRecordCount(totalCnt);
        
		
        model.addAttribute("cmsCourseBaseVO", cmsCourseBaseVO);
        model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		
		
		// View호출
		return "oklms/la/statistics/content/listContentStat";
	}
	
	/**
	 * 주차데이터 조회
	 * @param courseContentId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/la/statistics/content/courseContentDetail.json")
	@ResponseBody
	public List<ContentStatVO> getContentDetailStat( @RequestParam String courseContentId) throws Exception {

	    CmsCourseBaseVO vo = new CmsCourseBaseVO();
	    vo.setCourseContentId(courseContentId);

	    return contentStatistcsService.getContentDetailStat(vo);
	}
	
	
	/**
	 * 사용과목 조회 팝업
	 * @param lessonId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/la/statistics/content/popupUsedCourse.do")
	public String popupUsedCourse(
	        @RequestParam("lessonId") String lessonId, @RequestParam("lessonTitle") String lessonTitle,
	        Model model) throws Exception {

	    List<SubjectVO> list = contentStatistcsService.listUsedCourse(lessonId);

	    model.addAttribute("resultList", list);
	    model.addAttribute("lessonId", lessonId);
	    model.addAttribute("lessonTitle", lessonTitle);

	    return "oklms_popup/la/statistics/content/popupUsedCourse";
	}
	
	/**
	 * 통계 엑셀 다운로드
	 * @param searchVO
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/la/statistics/content/listContentStatExcel.do")
	public void excelDownload(
	        CmsCourseBaseVO searchVO,
	        HttpServletResponse response) throws Exception {
		
		searchVO.setPageSize(10000);
		
	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader(
	        "Content-Disposition",
	        "attachment; filename=\"content_statistics.xlsx\""
	    );

	    XSSFWorkbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("콘텐츠 사용 통계");

	    // =====================
	    // 스타일
	    // =====================
	    XSSFCellStyle headerStyle = wb.createCellStyle();
	    XSSFFont headerFont = wb.createFont();
	    headerFont.setBold(true);
	    headerStyle.setFont(headerFont);
	    headerStyle.setAlignment(HorizontalAlignment.CENTER);

	    XSSFCellStyle centerStyle = wb.createCellStyle();
	    centerStyle.setAlignment(HorizontalAlignment.CENTER);

	    // =====================
	    // 헤더
	    // =====================
	    Row header = sheet.createRow(0);
	    String[] headers = {
	        "콘텐츠명", "사용 횟수", "수강생 수",
	        "구분", "차시명", "차시 사용수", "차시 수강생수"
	    };

	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = header.createCell(i);
	        cell.setCellValue(headers[i]);
	        cell.setCellStyle(headerStyle);
	    }

	    List<CmsCourseContentVO> contentList = contentStatistcsService.listCourseContentStat(searchVO);

	    int rowIdx = 1;

	    for (CmsCourseContentVO content : contentList) {

	        int contentStartRow = rowIdx;

	        Row contentRow = sheet.createRow(rowIdx++);

	        contentRow.createCell(0).setCellValue(content.getSubtitle());
	        contentRow.createCell(1).setCellValue(content.getUsedCourseCnt());
	        contentRow.createCell(2).setCellValue(content.getStudentCnt());
	        contentRow.createCell(3).setCellValue("콘텐츠");
	        contentRow.createCell(4).setCellValue(content.getSubtitle());

	        content.setCourseContentId(content.getId());
	        content.setId("");
	        List<ContentStatVO> lessonList =contentStatistcsService.getContentDetailStat(content);

	        if (lessonList == null || lessonList.isEmpty()) {

	            Row lessonRow = sheet.createRow(rowIdx++);

	            lessonRow.createCell(3).setCellValue("차시");
	            lessonRow.createCell(4).setCellValue("차시 없음");
	            lessonRow.createCell(5).setCellValue("-");
	            lessonRow.createCell(6).setCellValue("-");

	        } else {
	        	for (ContentStatVO lesson : lessonList) {

		            Row lessonRow = sheet.createRow(rowIdx++);

		            lessonRow.createCell(3).setCellValue("차시");
		            lessonRow.createCell(4).setCellValue(lesson.getLessonTitle());
		            lessonRow.createCell(5).setCellValue(lesson.getUsedCourseCnt());
		            lessonRow.createCell(6).setCellValue(lesson.getStudentCnt());
		        }
	        }

	        if (rowIdx - contentStartRow > 1) {
	            sheet.addMergedRegion(new CellRangeAddress(
	                contentStartRow, rowIdx - 1, 0, 0
	            ));
	            sheet.addMergedRegion(new CellRangeAddress(
	                contentStartRow, rowIdx - 1, 1, 1
	            ));
	            sheet.addMergedRegion(new CellRangeAddress(
	                contentStartRow, rowIdx - 1, 2, 2
	            ));
	        }
	    }

	    sheet.setColumnWidth(0, 10000);
	    sheet.setColumnWidth(4, 9000);

	    wb.write(response.getOutputStream());
	}
	
	/**
	 * 사용과목 엑셀 다운로드
	 * @param lessonId
	 * @param lessonTitle
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/la/statistics/content/excelUsedCourse.do")
	public void usedCourseExcelDownload(@RequestParam String lessonId, @RequestParam String lessonTitle, HttpServletResponse response) throws Exception {

	    List<SubjectVO> list = contentStatistcsService.listUsedCourse(lessonId);

	    String fileName = lessonTitle + "_사용과목목록.xlsx";
	    fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

	    response.setContentType(
	        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
	    );
	    response.setHeader(
	        "Content-Disposition",
	        "attachment; filename=\"" + fileName + "\""
	    );

	    Workbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("사용 과목 목록");

	    int rowIdx = 0;

	    Row titleRow = sheet.createRow(rowIdx++);
	    titleRow.createCell(0).setCellValue("차시명");
	    titleRow.createCell(1).setCellValue(lessonTitle);

	    rowIdx++;

	    Row headerRow = sheet.createRow(rowIdx++);
	    headerRow.createCell(0).setCellValue("년도");
	    headerRow.createCell(1).setCellValue("학기");
	    headerRow.createCell(2).setCellValue("과목코드");
	    headerRow.createCell(3).setCellValue("교과목명");
	    headerRow.createCell(4).setCellValue("분반");
	    headerRow.createCell(5).setCellValue("수강생수");

	    for (SubjectVO vo : list) {
	        Row row = sheet.createRow(rowIdx++);
	        row.createCell(0).setCellValue(vo.getYyyy());
	        row.createCell(1).setCellValue(vo.getTerm());
	        row.createCell(2).setCellValue(vo.getSubjectCode());
	        row.createCell(3).setCellValue(vo.getSubjectName());
	        row.createCell(4).setCellValue(vo.getSubjectClass());
	        row.createCell(5).setCellValue(vo.getStudyCnt());
	    }

	    for (int i = 0; i <= 5; i++) {
	        sheet.autoSizeColumn(i);
	    }

	    wb.write(response.getOutputStream());
	}
}
