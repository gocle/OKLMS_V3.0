<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
  
						<h2>과제</h2>
						<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>

						<table class="type-1 mb-030">
							<caption>교과형태 과정구분 학점 교수 온라인 교육형태 선수여부에 대한 정보를 제공합니다</caption>
							<colgroup>
								<col style="width:15%" />
								<col style="width:*px" />
								<col style="width:15%" />
								<col style="width:*px" />
								<col style="width:15%" />
								<col style="width:*px" />
							</colgroup>
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
/*  수정,삭제 */
function fn_formSave(type){
	if(type=='I'){ 

		if($("#fileName-3").val()==""){
			alert("과제물을 첨부하세요.");
			return;
		} else {
			var ext = $("#fileName-3").val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['doc','docx','gif','hwp','jpeg','jpg','png','pdf','ppt','pptx','txt','xls','zip','xlsx']) == -1) {
				alert('doc , docx ,​​ gif ,​ hwp​ , ​jpeg ​, ​jpg​ ,​ png​ ,​\npdf ​, ​ppt​ , pptx, ​txt​ ,​​ xls​ , ​zip​ , ​xlsx​\n\n파일만 업로드 할 수 있습니다.');
				return;
		   	}
		}
		
		if(doubleSubmitCheck()) return;

		var reqUrl =  "/lu/report/insertReportStd.do";
		$("#frmReport").attr("target", "_self");
		$("#frmReport").attr("action", reqUrl);
		$("#frmReport").submit();		
	}else if(type=='D'){
		var reqUrl =  "/lu/report/deleteReportSubmit.do";
		$("#frmReport").attr("target", "_self");
		$("#frmReport").attr("action", reqUrl);
		$("#frmReport").submit();
	}
 
}

//--> 
</script>
<form:form commandName="frmReport" name="frmReport" method="post" enctype="multipart/form-data" >
<input name="reportId" type="hidden" value="${reportVO.reportId }" />
<input name="reportSubmitId" type="hidden" value="${reportVO1.reportSubmitId }" />
<input name="submitCheckYn" id="submitCheckYn" type="hidden" value="" />
					
						<!-- <table class="type-2"> -->
						<table class="type-write-view">
							<caption>주차 제목 과제제출기간 평가 배점 내용 첨부파일에 대한 정보를 제공합니다</caption>
							<colgroup>
								<col style="width:130px" />
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
								<%-- <tr>
									<th>과제물</th>
									<td class="left">
									<c:if test="${!empty resultFile1}">
											<a href="javascript:com.downFile('${resultFile1.atchFileId}','${resultFile1.fileSn}');" class="text-file">${resultFile1.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<c:if test="${reportVO.submitStatus ne '완료'}">
											<a href="#" onclick="javascript:fn_formSave('D');">[삭제]</a>
											</c:if>
									</c:if>		
									<c:if test="${empty resultFile1}">								
										<input type="text" id="fileName-3" style="width:50%;" readonly="readonly">
										<p class="file-find">
											<a href="#@" class="checkfile">파일찾기</a>
											<input type="file" class="file_input_hidden" name="file-input" onchange="javascript: document.getElementById('fileName-3').value = this.value" />
										</p>
									</c:if>	
									</td>
								</tr> --%>
							</tbody>
						</table><!-- E : 과제관리1 --> 
						
						<table class="type-2 mb-010" style="border-top:0;">
						<caption>과제물에 대한 정보를 제공합니다</caption>
						<colgroup>
								<col style="width:130px" />
								<col style="width:*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="fileName-3">과제물</label></th>
									<td class="left">
									<c:if test="${!empty resultFile1}">
											<a href="javascript:com.downFile('${resultFile1.atchFileId}','${resultFile1.fileSn}');" class="text-file">${resultFile1.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<c:if test="${reportVO.submitStatus ne '완료'}">
											<a href="#" onclick="javascript:fn_formSave('D');">[삭제]</a>
											</c:if>
									</c:if>		
									<c:if test="${empty resultFile1}">								
										<input type="text" id="fileName-3" style="width:50%;" readonly="readonly">
										<p class="file-find">
											<a href="#@" class="checkfile"><label for="">file-input</label></a>
											<input type="file" class="file_input_hidden" name="file-input" id="file-input" onchange="javascript: document.getElementById('fileName-3').value = this.value" />
										</p>
									</c:if>	
									</td>
								</tr>
								<c:if test="${reportVO.evalYn eq 'Y'}">
									<tr>		
										<th>점수</th>
										<td  class="left">
												${reportVO1.evalScore}
										</td>
									</tr>
								</c:if>
								<c:if test="${!empty feedVO}">
								<tr>
									<th scope="row">첨삭내용</th>
									<td class="left">${feedVO.reportFeedbackDesc}</td>
								</tr>
								<c:if test="${!empty resultFile2}">
									<tr>
										<th scope="row">첨삭파일</th>
										<td class="left">
											<a href="javascript:com.downFile('${resultFile2.atchFileId}','${resultFile2.fileSn}');" class="text-file">${resultFile2.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								</c:if>
								</c:if>
							</tbody>	
						</table>
						
						
						
</form:form>
						<div class="btn-area mt-010">
							<div class="float-right">
							<a href="/lu/report/listReportStd.do" class="black ">목록</a>
							<c:if test="${reportVO.submitStatus ne '완료'}">
								<a href="#!" onclick="javascript:fn_formSave('I');" class="black">제출</a>
							</c:if>
							</div>
							
						</div><!-- E : btn-area -->


  