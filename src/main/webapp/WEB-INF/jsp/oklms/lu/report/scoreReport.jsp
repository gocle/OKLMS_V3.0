<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

						<h2>과제</h2>
						<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>

						
						<table class="type-1 responsive-tr">
							<caption>교과형태 과정구분 학점 교수 온라인교육형태 선수여부에 대한 정보를 제공합니다.</caption>
							<colgroup>
								<col style="width:15%" />
								<col style="width:*" />
								<col style="width:15%" />
								<col style="width:*" />
								<col style="width:15%" />
								<col style="width:*" />
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
									
							
						<h2 class="mt-040">과제 세부내용</h2>
						<div class="table-responsive mt-010">
						<table class="type-2">
							<caption>주차 제목 과제제출기간 평가 배점 내요 첨부파일에 대한 정보를 제공합니다.</caption>
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
						</table>
						</div>
						<!-- E : 과제관리1 -->
						

<script type="text/javascript">
<!--

$(document).ready(function() {
    $('.arrEvalScore').keyup(function () {
    	var num10=${reportVO.score};
    	if(num10< $(this).val()){
        	alert("배점보다 큰점수를 입력할수 없습니다.");
        	 $(this).val(num10)	
    	}
    });

	
});

 
function fn_formSave(){
		
	//점수저장
	if (  confirm("점수를 저장 하시겠습니까?")) {
		var reqUrl =  "/lu/report/scoreReport.do";
		$("#frmReport").attr("target", "_self");
		$("#frmReport").attr("action", reqUrl);
		$("#frmReport").submit();	
	} 
}
//alert("${loginAuthGroupId}");


function fn_popupReportFeed(reportId,reportSubmitId){
	var url = "/lu/report/goPopupReportFeed.do?reportId="+reportId+"&reportSubmitId="+reportSubmitId;
	var wndName = "report";
	var wWidth = "858";
	var wHeight = "700";

	popOpenWindow( url, wndName, wWidth, wHeight, 250, 400, 'scrollbars=yes' );
}


/*  일괄다운로드 */
function fn_formSave_file(){

	var reqUrl =  "/lu/report/listReportExcel.do";
	$("#frmReport").attr("target", "_self");
	$("#frmReport").attr("action", reqUrl);
	$("#frmReport").submit();		

}

//--> 
</script>


<div class="btn-area mt-010">
	<div class="float-right">
		<c:if test="${loginAuthGroupId ne '2016AUTH0000006' }">
		<a href="javascript:fn_formSave();" class="black">저장</a>
		</c:if>
	</div>
</div>



<c:set var="fileCnt" value="0"/>
<h2 class="mt-040">과제 제출 현황 및 채점</h2>

<form:form modelAttribute="frmReport" name="frmReport" method="post"  >
<input type="hidden" name="reportId" value="${reportVO.reportId}"/>

						<div class="table-responsive mt-010">
						<table class="type-2 mt-015">
							<caption>학번 이름 제출일 제출현황 점수 정보를 제공합니다.</caption>
							<colgroup>
								<col style="width:70px" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">학번</th>
									<th scope="col">이름</th>
									<th scope="col">제출일</th>
									<th scope="col">제출현황</th>
									<th scope="col">점수</th>
									<th scope="col">첨삭</th>
								</tr>
							</thead>
							<tbody>

							<c:forEach var="result" items="${result}" varStatus="status">
							<input type="hidden" name="arrReportSubmitId" value="${result.reportSubmitId }"/>
								<tr>
									<td>${status.count}</td>
									<td>${result.memId }</td>
									<td>${result.memName }</td>
									<td>${result.insertDate }</td>
									<td>
										<c:if test="${!empty result.atchFileId }">
											<a href="javascript:com.downFile('${result.atchFileId}','1');"  class="btn-line-orange">제출</a>
											<c:set var="fileCnt" value="${fileCnt+1}"/>
										</c:if>
										<c:if test="${empty result.atchFileId }">
											미제출
										</c:if>										
									</td>
									<td>
										<label for="arrEvalScore" class="hidden">점수</label>
										<c:if test="${!empty result.atchFileId }">											
											<c:if test="${loginAuthGroupId eq '2016AUTH0000006' }">
											${result.evalScore }
											</c:if>
											<c:if test="${loginAuthGroupId ne '2016AUTH0000006' }">
											<input  type="number" min="0" max="9" class="arrEvalScore"  name="arrEvalScore" id="arrEvalScore" style="width: 70px;'" value="${result.evalScore }" />
											</c:if>
										</c:if>
										<c:if test="${empty result.atchFileId }">
											<c:if test="${loginAuthGroupId eq '2016AUTH0000006' }">
											${result.evalScore }
											</c:if>
											<c:if test="${loginAuthGroupId ne '2016AUTH0000006' }">
											<input type="hidden" name="arrEvalScore" id="arrEvalScore"  value="${result.evalScore }" />
											</c:if>
										</c:if>	
									</td>
									<td>
									<c:if test="${!empty result.atchFileId }">
									
										<c:choose>
											<c:when test="${result.feedCnt eq '0' }">
												<a href="javascript:fn_popupReportFeed('${result.reportId }','${result.reportSubmitId }')" id="feed_${result.reportSubmitId}"  class="btn-line-blue">등록</a>
											</c:when>
											<c:otherwise>
												<a href="javascript:fn_popupReportFeed('${result.reportId }','${result.reportSubmitId }')" id="feed_${result.reportSubmitId}"  class="btn-line-blue">수정</a>
											</c:otherwise>
										</c:choose>
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
</form:form>
						<div class="btn-area mt-010">
							<div class="float-left">
								<a href="/lu/report/listReport.do" class="gray-1">&lt; 이전화면</a>
							</div>
							<div class="float-right">
							
							
								<c:if test="${fileCnt > 0 }">
									<a href="#" onclick="javascript:fn_formSave_file();" class="black">과제 다운로드</a>
								</c:if>
								
								<c:if test="${fileCnt == 0 }">
									<a href="javascript:alert('제출 된 과제가 없습니다.');"  class="black">과제 다운로드</a>
								</c:if>
								
								<c:if test="${loginAuthGroupId ne '2016AUTH0000006' }">
								<a href="javascript:fn_formSave();" class="black">저장</a>
								</c:if>
							</div>
						</div><!-- E : btn-area -->
