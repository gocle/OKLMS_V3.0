<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="submitCheck" value="C"/>

						<h2>주차별 학습활동서 제출</h2>

						<table class="type-1-1 mb-040">
							<caption>구분 기업명 훈련과정명 학년도 학기 주차에 대한 정보제공</caption>
							<colgroup>
								<col style="width:120px" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:120px" />
								<col style="width:100px" />
								<col style="width:100px" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구분</th>
									<th scope="col">기업명</th>
									<th scope="col">훈련과정명</th>
									<th scope="col">학년도</th>
									<th scope="col">학기</th>
									<th scope="col">주차</th>
								</tr>
							</thead>
							<tbody>
								<tr>
								<tr>
								 
									<td>${activityVO.traningType }</td>
									<td>${result.companyName }</td>
									<td>${result.hrdTraningName }</td>
									<td>${activityVO.yyyy }</td>
									<td>${activityVO.termName }</td>
									<td>${activityVO.weekCnt }</td>
					 
								</tr>
								</tr>
							</tbody>
						</table>



						<h2 class="sub_tit">학습근로자별 학습활동서</h2>
						<table class="type-1-1">
							<caption>성명 주민등록번호 주차 학습기간 대한 정보제공</caption>
							<colgroup>
								<col style="width:180px" />
								<col style="width:*" />
								<col style="width:120px" />
								<col style="width:250px" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">성명</th>
									<th scope="col">주민등록번호</th>
									<th scope="col">주차</th>
									<th scope="col">학습기간</th>
								</tr>
							</thead>
							<c:set var="memName" value="" />
							<c:forEach var="result" items="${resultlist}" varStatus="status">
							<c:set var="memName" value="${result.memName }" />	
							</c:forEach>
							<tbody>
								<tr>
									<td>${memName}</td>
									<td> </td>
									<td>${activityVO.weekCnt } 주차</td>
									<td>${subjweekStdVO.traningStDate} ~ ${subjweekStdVO.traningEndDate}</td>
								</tr>
							</tbody>
						</table>


						<div class="table-responsive mt-030">
							<table class="type-2">
								<caption>개설강좌명 능력단위요소 교육시간 성취도 학습활동내역에 대한 정보제공</caption>
								<colgroup>
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:80px" />
									<col style="width:80px" />
									<col style="width:80px" />
									<col style="width:100px" />
									<col style="width:*" />
								</colgroup>
								<tr>
									<th scope="col" rowspan="2">개설강좌명</th>
									<th scope="col" rowspan="2">능력단위요소</th>
									<th scope="col" colspan="3">교육시간</th>
									<th scope="col" rowspan="2">성취도</th>
									<th scope="col" rowspan="2">학습활동내역</th>
								</tr>
								<tr>
									<th scope="col" class="border-left">전체</th>
									<th scope="col">계획</th>
									<th scope="col">결과</th>
								</tr>
								<c:forEach var="result" items="${resultlist}" varStatus="status">
								
								<tr>								
									<td>${result.subjectName}</td>
									<td>${result.ncsUnitName} ${result.ncsElemName}</td>
									
									<td>${result.allTimeHour}시간</td>
									<td>${result.weekTimeHour}시간</td>
									<td>
									<c:if test="${!empty result.weekAddTimeHour}">
									${result.weekWorkTimeHour} + ${result.weekAddTimeHour}시간
									</c:if>
									<c:if test="${empty result.weekAddTimeHour}">
									${result.weekWorkTimeHour} 시간									
									</c:if>									

									</td>
									<td>
									<c:if test="${!empty result.weekAddTimeHour}">
										${result.weekWorkAchievement} / ${result.weekAddAchievement}
									</c:if>
									<c:if test="${empty result.weekAddTimeHour}">
										${result.weekWorkAchievement} 
									</c:if>									
									</td> 																										
									<td>${result.content}</td>
								</tr>
								
								</c:forEach>
								 
							</table>
						</div>



							<table class="type-write mt-020	">
								<caption>요청사항 과제물첨부에 대한 정보제공</caption>
								<colgroup>
									<col style="width:150px" />
									<col style="width:*" />
								</colgroup>
								<tbody>
								<c:forEach var="result" items="${resultlist}" varStatus="status">
								
									<c:if test="${!empty result.reqContent and !empty result.atchFileId}">
									<tr>
										<th scope="row">요청사항</th>
										<td>${result.reqContent}</td>
									</tr>
									<tr>
										<th scope="row">첨부파일</th>
										<td class="left">
											<a href="javascript:com.downFile('${result.atchFileId}','1');" class="text-file">첨부파일</a>											 
										</td>
									</tr>
									</c:if>
									<c:if test="${empty result.reqContent and !empty result.atchFileId}">
									<tr>
										<th scope="row">첨부파일</th>
										<td class="left">
											<a href="javascript:com.downFile('${result.atchFileId}','1');" class="text-file">첨부파일</a>											 
										</td>
									</tr>
									</c:if>
									<c:if test="${!empty result.reqContent and empty result.atchFileId}">
									<tr>
										<th scope="row">요청사항</th>
										<td>${result.reqContent}</td>
									</tr>
									</c:if>

									<c:if test="${result.state ne 'C' }">
										<c:set var="submitCheck" value="W"/>
									</c:if>

								</c:forEach>	
								</tbody>
							</table>
			 
<script type="text/javascript">
<!-- 
 
function fn_search(){ 
	var reqUrl = "/lu/activity/listWeekActivityStd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
};  
function fn_submit(){
	var reqUrl = "/lu/activity/updateWeekActivityStd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	
}

//-->
</script>
<form:form commandName="frmActivity" name="frmActivity" method="post"  >
		<input type="hidden" name="companyId" id="companyId" value="${activityVO.companyId }"  />
		<input type="hidden" name="traningProcessId" id="traningProcessId"  value="${activityVO.traningProcessId }" />
		<input type="hidden" name="weekCnt" id="weekCnt"  value="${activityVO.weekCnt}"  />
		<input type="hidden" name="traningType" id="traningType"  value="${activityVO.traningType}"  />
		<input type="hidden" name="yyyy" id="yyyy"   value="${activityVO.yyyy}"  />
		<input type="hidden" name="term" id="term" value="${activityVO.term}" />
		<input type="hidden" name="memSeq" id="memSeq"  /><input type="hidden" name="memSeqs" id="memSeqs" value="${activityVO.memSeqs}"  />
</form:form>


							<div class="btn-area align-right mt-010">
								<a href="#!" onclick="javascript: fn_search();" class="gray-1 ">이전화면</a>
								<c:if test="${submitCheck eq 'W' }">
								<a href="#!" onclick="javascript: fn_submit();" class="orange ">제출</a>
								</c:if>
							</div>
