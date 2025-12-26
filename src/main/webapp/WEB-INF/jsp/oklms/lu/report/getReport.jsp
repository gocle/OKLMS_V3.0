<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

						<h2>과제</h2>
						<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode}</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>

						<table class="type-1 mb-030 responsive-tr">
							<caption>교과형태 과정구분 학점 교수 온라인 교육형태 선수여부에 대한 정보를 제공합니다</caption>
							<tbody>
									<tr>
										<th scope="row">교과형태</th>
									<td>${currProcVO.subjectTraningTypeName}</td>
										<th scope="row">과정구분</th>
									<td>${currProcVO.subjectTypeName}</td>
										<th scope="row">학점</th>
										<td>${currProcVO.point }학점</td>
									</tr>
									<tr>
										<th scope="row">교수</th>
										<td>${currProcVO.insNames}</td>
										<th scope="row">온라인 교육형태</th>
										<td>${currProcVO.onlineTypeName} (성적비율 ${currProcVO.gradeRatio}%)</td>
										<th scope="row">선수여부</th>
										<td>${currProcVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}</td>
									</tr>
								</tbody>
						</table>


<script type="text/javascript">
<!--

$(document).ready(function() {
 
	
});

/* 엑셀 다운로드 */
function fn_exclDownload(){
	var reqUrl = "/lu/report/getReportExcel.do";
	$("#frmReport").attr("action", reqUrl);
	$("#frmReport").attr("target","_self");
	$("#frmReport").submit();
}
/*  일괄다운로드 */
function fn_formSave_file(){

	var reqUrl =  "/lu/report/listReportExcel.do";
	$("#frmReport").attr("target", "_self");
	$("#frmReport").attr("action", reqUrl);
	$("#frmReport").submit();		

}

function sms(){		
	var obj = document.getElementsByName("memIdArr");
	var temp = 0;
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
              temp++;
         }
    }	
	if(temp==0){
		alert("선택된 대상이 없습니다.");
		return;
	}	  
	fn_send_sms(${reportVO.weekCnt},arr_value,'${reportVO.submitEndDate}','RC','${reportVO.subjectCode}');
	
}
//--> 
</script>
<form name="frmReport" id="frmReport" action=""  method="post" >
	<input type="hidden" name="reportId" value="${reportVO.reportId}"/>
</form>


						<!-- <table class="type-2"> -->
						<table class="type-write-view ">
							<caption>주차 제목 과제제출기간 평가 배점 내용 첨부파일에 대한 정보를 제공합니다</caption>
							<colgroup>
								<col style="width:15%" />
								<col style="width:*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">주차</th>
									<td class="left">${reportVO.weekCnt}주차</td>
								</tr>
								<tr>
									<th scope="row">제목</th>
									<td class="left">${reportVO.reportName}</td>
								</tr>
								<tr>
									<th scope="row">과제제출 기간</th>
									<td class="left">${reportVO.submitStartDate} ${reportVO.submitStartHour}:${reportVO.submitStartMin} ~ ${reportVO.submitEndDate} ${reportVO.submitEndHour}:${reportVO.submitEndMin}</td>
								</tr>
								<tr>
									<th scope="row">평가</th>
									<td class="left">${reportVO.evalYn}</td>
								</tr>
								<tr>
									<th scope="row">배점</th>
									<td class="left">${reportVO.score} 점</td>
								</tr>
								<tr>
									<th scope="row">내용</th>
									<td class="left">${reportVO.reportDesc}</td>
								</tr>
								<tr>
									<th scope="row">첨부파일</th>
									<td class="left">
									<c:if test="${!empty resultFile}">
											<a href="javascript:com.downFile('${resultFile.atchFileId}','${resultFile.fileSn}');" class="text-file">${resultFile.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
									</td>
								</tr>
							</tbody>
						</table><!-- E : 과제관리1 -->


						<div class="clearfix"></div>
						<div class="table-responsive mt-020">
						<table class="type-2">
							<caption>학번 이름 제출일 제출현황에 대한 정보를 제공합니다</caption>
							<colgroup>
								<col style="width:8%" />
								<col style="width:8%" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><label for="check0" class="hidden">선택</label><input type="checkbox" name="check0" id="check0" class="choice" onclick="javascript:com.checkAll('check0','memIdArr');" /></th>
									<th scope="col">번호</th>
									<th scope="col">학번</th>
									<th scope="col">이름</th>
									<th scope="col">제출일</th>
									<th scope="col">제출현황</th>
								</tr>
							</thead>
							<tbody>
							
							<c:forEach var="result" items="${result}" varStatus="status">
							
								<tr>
									<td><label for="memIdArr" class="hidden">선택</label><input type="checkbox" name="memIdArr" id="memIdArr" value="${result.memId }" class="choice" /></td>
									<td>${status.count}</td>
									<td>${result.memId }</td>
									<td>${result.memName }</td>
									<td>${result.insertDate }</td>
									<td>
										<c:if test="${!empty result.atchFileId }">
											<a href="javascript:com.downFile('${result.atchFileId}','1');"  class="btn-line-orange">제출</a>
										</c:if>
										<c:if test="${empty result.atchFileId }">
											미제출
										</c:if>										
									</td>
								</tr>									
								 				
							</c:forEach>
							<c:if test="${empty result}">
						          <tr>
						            <td colspan="6">자료가 없습니다.</td>
						          </tr>
						    </c:if>
							</tbody>
						</table>
						</div>

						<div class="btn-area mt-010">
							<div class="float-left"">
								<a href="/lu/report/listReport.do" class="gray-1 ">&lt; 이전화면</a>
							</div>
							
							<div class="float-right"">
								<a href="#" onclick="javascript:fn_exclDownload();" class="black">제출현황 출력</a>
								<a href="#" onclick="javascript:fn_formSave_file();" class="black">과제 다운로드</a>
	
								<a href="#!"  onclick="javascript:sms();" class="yellow">SMS 발송</a>
							</div>
						</div><!-- E : btn-area -->