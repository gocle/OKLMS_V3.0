<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("br", "<br/>");  //br 태그
      pageContext.setAttribute("cn", "\n"); //Space, Enter
%> 
<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2016. 12. 01 오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>

<style type="text/css">
</style>

<c:set var="targetUrl" value="/lu/currproc/"/>
<c:set var="scrollNum" value="${param.scrollNum}"/>


<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
<script type="text/javascript" src="/js/oklms/iscroll.js"></script>
<script type="text/javascript">
var targetUrl = "${targetUrl}";	
var scrollNum = "${scrollNum}";
 
<!-- 

function fn_subject_schedule_form(){
	var reqUrl = CONTEXT_ROOT + targetUrl + "getCurrProcScheduleForm.do";
	$("#frmSearch").attr("action", reqUrl);
	$("#frmSearch").submit();
}

function fn_subject_eval_form(){
	var reqUrl = CONTEXT_ROOT + targetUrl + "getCurrProcEvalForm.do";
	$("#frmSearch").attr("action", reqUrl);
	$("#frmSearch").submit();
}
	
	
	//--> 	
</script>

				
<form id="frmSearch" name="frmSearch" method="post">
	<input type="hidden" id="weekCnt" name="weekCnt" value="" />
	<input type="hidden" id="weekId" name="weekId" value="" />
	<input type="hidden" id="year" name="year" value="${subjectVO.yyyy}" />
	<input type="hidden" id="term" name="term" value="${subjectVO.term}" />
	<input type="hidden" id="subjectCode" name="subjectCode" value="${subjectVO.subjectCode}" />
    <input type="hidden" id="subjectName" name="subjectName" value="${subjectVO.subjectName}" />
    <input type="hidden" id="subjectType" name="subjectType" value="${subjectVO.subjectType}" />
    <input type="hidden" id="onlineType" name="onlineType" value="${subjectVO.onlineType}" />
    <input type="hidden" id="lecMenuMarkYn" name="lecMenuMarkYn" value="Y" />
	<input type="hidden" id="subjectTraningType" name="subjectTraningType" value="OJT" />
    <input type="hidden" id="subClass" name="subClass" value="" />
    <input type="hidden" id="subjectClass" name="subjectClass" value="" />
	<input type="hidden" id="companyId" name="companyId" value="" />
	<input type="hidden" id="scrollNum" name="scrollNum" value="" />
		<input type="hidden" id="estblYy" name="estblYy" value="${subjectVO.estblYy}" />
	<input type="hidden" id="estblSemstrCd" name="estblSemstrCd" value="${subjectVO.estblSemstrCd}" />
	<input type="hidden" id="courseNo" name="courseNo" value="${subjectVO.courseNo}" />
	<input type="hidden" id="partitnClasSeCd" name="partitnClasSeCd" value="${subjectVO.partitnClasSeCd}" />
</form>	
		
			<h2>교과목 정보</h2>
						<h4 class="mb-010"><span>${subjectVO.subjectName} / ${subjectVO.subjectCode}</span> (${subjectVO.subjectClass}반) ㅣ ${subjectVO.yyyy}학년도 ${subjectVO.termName}</h4>
						<div class="group-area mb-010">
							<table class="type-1">
								<caption>교과목 정보의 교과형태 과정구분 훈련시간 담당교수 온라인 교육형태 정보 제공</caption>
								<colgroup>
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
								</colgroup>
								<tr>
									<th scope="row">교과형태</th>
									<td>${subjectVO.subjectTraningTypeName}</td>
									<th scope="row">과정구분</th>
									<td>${subjectVO.subjectTypeName}</td>
									<th scope="row">훈련시간</th>
									<td>${subjectVO.traningHour}시간</td>
								</tr>
								<tr>
									<th scope="row">담당교수</th>
									<td>${subjectVO.insNames}</td>
									<th scope="row">온라인 교육형태</th>
									<td>${subjectVO.onlineTypeName} (성적비율 ${subjectVO.gradeRatio}%)</td>
									<th scope="row">선수여부</th>
									<td>${subjectVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}</td>
								</tr>
							</table>

							<div class="btn-area mt-010">
								<div class="float-right">
								<a href="#none" onclick="fn_subject_schedule_form();" class="yellow">강의계획서</a>
								</div>
							</div><!-- E : btn-area -->
						</div>

						<%-- <h2>진행율</h2>
						<div class="progress-area mb-040">
							<ul>
								<li style="width:${ empty progress.realProgressRate  ? 0 : progress.realProgressRate}%; text-align: center"><span><b>${ empty progress.realProgressRate  ? 0 : progress.realProgressRate }</b> %</span></li>
							</ul>
						</div> --%><!-- E : 진행율 -->

						<h2>훈련정보</h2>
						<div class="table-responsive">
						<table class="type-2">
							<caption>훈련정보의 주차 훈련일자 능력단위명 능력단위요소명 교육시간 학습자료 훈련일지 학습활동서 등 정보 제공</caption>
							<colgroup>
								<col style="width:5%" />
								<col style="width:25%" />
								<col style="width:*%" />
								<%-- <col style="width:24%" /> --%>
								<col style="width:10%" />
								<%-- <col style="width:8%" /> --%>
								<col style="width:15%" />
								<col style="width:15%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">주차</th>
									<th scope="col">훈련일자</th>
									<th scope="col">능력단위명</th>
									<!-- <th scope="col">능력단위요소명</th> -->
									<th scope="col">교육시간</th>
									<!-- <th scope="col">학습자료</th> -->
									<th scope="col">훈련일지</th>
									<th scope="col">학습활동서</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
										
										<c:choose>
											<c:when test="${result.rowspanCnt eq '1'}">
												<tr <c:if test="${result.nowWeekCnt eq result.weekCnt}">class="highlight"</c:if>>
													<td>${result.weekCnt}</td>
													<td class="border-left">
													<c:choose>
														<c:when test="${empty result.traningDate}">기업현장교사 입력 전</c:when>
														<c:otherwise>${result.traningDate}(${result.dayWeek}) ${result.traningSt} ~ ${result.traningEd}</c:otherwise>
													</c:choose>
													</td>
													<td class="left">${result.ncsUnitName}</td>
													<%-- <td class="left">${fn:replace(result.ncsElemName, cn , br )}</td> --%>
													<td>${result.timeHour}</td>
													<!-- <td><a href="/lu/cop/bbs/BBSMSTR_000000000009/selectBoardList.do" class="btn-search-gray"></a></td> -->
													<td>
														<c:choose>
															<c:when test="${result.nowWeekYn eq 'Y'}">
																<a href="/lu/traning/listTraningNoteStd.do?weekCnt=${result.weekCnt}" class="btn-line-blue">진행</a>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${result.traNoteCnt eq '0'}">
																		<a href="/lu/traning/listTraningNoteStd.do?weekCnt=${result.weekCnt}" class="btn-line-orange">미작성</a>
																	</c:when>
																	<c:otherwise>
																		<a href="/lu/traning/listTraningNoteStd.do?weekCnt=${result.weekCnt}" class="btn-line-gray">완료</a>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</td>
													<td>
														<c:choose>
															<c:when test="${result.nowWeekYn eq 'Y'}">
																<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-blue">진행</a>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${result.actNoteCnt eq '0'}">
																		<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-orange">미작성</a>
																	</c:when>
																	<c:otherwise>
																		<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-gray">완료</a>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${result.rowNum eq '1'}">
														<tr <c:if test="${result.nowWeekCnt eq result.weekCnt}">class="highlight"</c:if>>
															<td rowspan="${result.rowspanCnt}">${result.weekCnt}</td>
															<td class="border-left">
															<%-- ${result.traningDate}(${result.dayWeek})<br />${result.traningSt} ~ ${result.traningEd} --%>
															
															<c:choose>
																<c:when test="${empty result.traningDate}">기업현장교사 입력 전</c:when>
																<c:otherwise>${result.traningDate}(${result.dayWeek}) ${result.traningSt} ~ ${result.traningEd}</c:otherwise>
															</c:choose>
															
															
															</td>
															<td class="left">${result.ncsUnitName}</td>
															<%-- <td class="left">${fn:replace(result.ncsElemName, cn , br )}</td> --%>
															<td rowspan="${result.rowspanCnt}">${result.timeHour}</td>
															<%-- <td rowspan="${result.rowspanCnt}"><!-- <a href="/lu/cop/bbs/BBSMSTR_000000000009/selectBoardList.do" class="btn-search-gray"></a> --></td> --%>
															<td rowspan="${result.rowspanCnt}">
																<c:choose>
																	<c:when test="${result.nowWeekCnt eq result.weekCnt}">
																		<a href="/lu/traning/listTraningNoteStd.do?weekCnt=${result.weekCnt}" class="btn-line-blue">진행</a>
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${result.traNoteCnt ge result.rowspanCnt}">
																				<a href="/lu/traning/listTraningNoteStd.do?weekCnt=${result.weekCnt}" class="btn-line-gray">완료</a>
																			</c:when>
																			<c:otherwise>
																				<a href="/lu/traning/listTraningNoteStd.do?weekCnt=${result.weekCnt}" class="btn-line-orange">미작성</a>
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															</td>
															<td rowspan="${result.rowspanCnt}">
																<c:choose>
																	<c:when test="${result.nowWeekCnt eq result.weekCnt}">
																		<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-blue">진행</a>
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${result.actNoteCnt ge result.rowspanCnt}">
																				<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-gray">완료</a>
																			</c:when>
																			<c:otherwise>
																				<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-orange">미작성</a>
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															</td> 
														</tr>
													</c:when>
													<c:otherwise>
														<tr <c:if test="${result.nowWeekCnt eq result.weekCnt}">class="highlight"</c:if>>
															<td class="border-left">${result.traningDate}(${result.dayWeek}) ${result.traningSt} ~ ${result.traningEd}</td>
															<td class="left">${result.ncsUnitName}</td>
															<%-- <td class="left">${fn:replace(result.ncsElemName, cn , br )}</td> --%>
														</tr>
													</c:otherwise>
												</c:choose>	 
												
											</c:otherwise>
										</c:choose>	
								</c:forEach>
								<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="10"><spring:message code="common.nodata.msg" /></td>
								</tr>
								</c:if>
							</tbody>
						</table>
						</div><!-- E : 훈련정보 -->

