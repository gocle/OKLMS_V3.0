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

<h2>교과목 정보</h2>
<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
<script type="text/javascript" src="/js/oklms/iscroll.js"></script>


<script type="text/javascript">
var targetUrl = "${targetUrl}";	
var scrollNum = "${scrollNum}";

<!--

	
	function fn_search(subjectClass,companyId,scrollNum,companyName){
		
		$("#subjectClass").val(subjectClass);
		$("#subClass").val(subjectClass);
		$("#companyId").val(companyId);
		$("#companyName").val(companyName);
		$("#scrollNum").val(scrollNum);
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCurrProc.do";
	 	
		$("#frmSearch").attr("target", "_self");
		$("#frmSearch").attr("action", reqUrl);
		$("#frmSearch").submit();
		
		
		///lu/currproc/listCurrProc.do?subjectTraningType="+subjectTraningType+"&year="+year+"&term="+term+"&subjectCode="+subjectCode+"&subjectName="+subjectName+"&subClass="+subClass+"&lecMenuMarkYn=Y&subjectType="+subjectType+"&onlineType="+onlineType;

	}
	var myScroll;

	function loaded() {
		myScroll = new iScroll('wrap', {
			snap: true,
			momentum: false,
			hScrollbar: false,
		});
	}

	document.addEventListener('DOMContentLoaded', loaded, false);
	
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
	
	function fn_note(weekCnt){
		var reqUrl = "/lu/traning/listTraningNote.do";
		$("#weekCnt").val(weekCnt);
		$("#frmSearch").attr("action", reqUrl);
		$("#frmSearch").submit();
	}

	function fn_activity(weekCnt){
		var reqUrl = "/lu/activity/listActivityPrt.do";
		$("#weekCnt").val(weekCnt);
		$("#frmSearch").attr("action", reqUrl);
		$("#frmSearch").submit();
	}
	function fn_saveTraningSubject(){
		
		var reqUrl = "/lu/currproc/saveTraningSubject.json";
	 	var param = $("#frmTraning").serializeArray();
		com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){	
			if (200 == jqXHR.status ) {
				var retMsg 	= jqXHR.responseJSON.retMsg;
				alert(retMsg);
			} else {
				alert("처리에 실패했습니다.")
			}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});
	}

	
	//--> 	
	
	
</script>


<%-- 
<ul id="learner-wrap" class="mb-010">
	<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
	<li id="wrap">
		<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
		<div id="scroller" style="width:${fn:length(listOjtClassName)*128}px;">
			<ul id="thelist" class="name-tab-btn">
				<c:forEach var="result" items="${listOjtClassName}" varStatus="status">
					<li <c:if test="${result.subjectClass eq subjectVO.subjectClass }">  class="current" </c:if> >
					<a href="#!" onclick="javascript:fn_search('${result.subjectClass}','${result.companyId }','${status.count }','${result.companyName}')" title="${result.companyName}">${result.subjectClass}분반_${result.companyName }</a></li>
				</c:forEach>
			</ul>
		</div>
	</li>
	<li id="next" onclick="myScroll.scrollToPage('next', 0);return false">next</li>
</ul><!-- E : learner-wrap -->
 --%>
				
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
    <input type="hidden" id="subClass" name="subClass" value="${subjectVO.subjectClass}" />
    <input type="hidden" id="subjectClass" name="subjectClass" value="${subjectVO.subjectClass}" />
    <input type="hidden" id="classId" name="classId" value="${subjectVO.subjectClass}" />
	<input type="hidden" id="companyId" name="companyId" value="" />
	<input type="hidden" id="companyName" name="companyName" value="" />
	<input type="hidden" id="scrollNum" name="scrollNum" value="" />
	
	<input type="hidden" id="estblYy" name="estblYy" value="${subjectVO.estblYy}" />
	<input type="hidden" id="estblSemstrCd" name="estblSemstrCd" value="${subjectVO.estblSemstrCd}" />
	<input type="hidden" id="courseNo" name="courseNo" value="${subjectVO.courseNo}" />
	<input type="hidden" id="partitnClasSeCd" name="partitnClasSeCd" value="${subjectVO.partitnClasSeCd}" />
</form>	

<div class="group-area name-tab-content">						
						
						<div class="group-area-title">
							<h4><span>${subjectVO.subjectName} / ${subjectVO.subjectCode}</span> (${subjectVO.subjectClass}분반_${empty param.companyName ? companyName : param.companyName}) ㅣ ${subjectVO.yyyy}학년도 ${subjectVO.termName}</h4>
														
							<!--  분반 검색 -->
							<p><a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">개설교과 분반 검색 <i class="xi-search"></i></a></p>

							<!--  분반 모달창 -->
							<div id="learner-wrap_area" class="modal">
								<div class="modal-title">개설교과 분반 검색 </div>
								<div class="modal-body">
									<!--  분반 검색 -->
									<div class="search_box"> 
										<fieldset>
										<legend>게시물 검색</legend>
											<label for="class_searchKeyword" class="">검색어 입력</label>
											<input id="class_searchKeyword" name="searchKeyword" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
											<button class="btn btn-black btn-sch" onclick="fn_comOjtClassSearch();">검색</button> 
										</fieldset>
									 </div>
									
									<!--  분반 검색 결과 및 리스트 -->
									<div id="learner-wrap_box">
										<ul id="learner-wrap">
											<li>
												<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
												<div id="scroller" <%-- style="width:${fn:length(listOjtClassName)*128}px;" --%>>
													<ul id="thelist" class="name-tab-btn">
														<c:forEach var="result" items="${listOjtClassName}" varStatus="status">
															<li <c:if test="${result.subjectClass eq subjectVO.subjectClass }">  class="current" </c:if> >
															<a href="#!" onclick="javascript:fn_search('${result.subjectClass}','${result.companyId }','${status.count }','${result.companyName}')" title="${result.companyName}">${result.subjectClass}분반_${result.companyName }</a></li>
														</c:forEach>
													</ul>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<!--  //분반 모달창 -->
							<!--  //분반 검색 -->
						
						</div>

						<div class="group-area mb-010">
							<table class="type-1 responsive-tr">
								<caption>교과목 정보의 교과형태 과정구분 훈련시간 담당교수 온라인교육형태 선수여부 정보 제공</caption>
								<colgroup>
									<col class="wp12" />
									<col class="wp21" />
									<col class="wp12" />
									<col />
									<col class="wp12" />
									<col class="wp21" />
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

							<div class="btn-area align-right mt-010">
								<a href="#none" onclick="fn_subject_schedule_form();" class="yellow">강의계획서</a><!-- <a href="#none" onclick="fn_subject_eval_form();" class="orange">체크리스트</a> -->
							</div><!-- E : btn-area -->
						</div><!-- E : 교과목 정보 -->

									<%-- <p>권장 진도율 (<fmt:formatNumber value="${ getProgress.allTimeHourNow/getProgress.totalTime }"  type="percent" />)</p>
									<progress value="${ getProgress.allTimeHourNow/getProgress.totalTime *100 }" max="100"></progress>
									<p>실제 진도율 <c:if test="${ getProgress.realProgressRate > 0}" >(<fmt:formatNumber value="${ getProgress.realProgressRate/100 }"  type="percent" />)</c:if></p>
									<progress value="${ getProgress.realProgressRate }" max="100"></progress>								
								</div><!-- E : 진행율 --> --%>

						<%-- <h2>진행율</h2>
						<div class="progress-area ">
							<ul>
								<li style="width:${ empty getProgress.realProgressRate  ? 0 : getProgress.realProgressRate}%; text-align: center"></li>
							</ul>
							<span><strong>${ empty getProgress.realProgressRate  ? 0 : getProgress.realProgressRate }</strong> %</span>
						</div> --%><!-- E : 진행율 -->
						<c:if test="${!empty traningList}">
						<form id="frmTraning" name="frmTraning" method="post">
						<div class="clearfix"></div>
							<div class="table-responsive mt-040">
								<table class="type-2">
									<caption>교과목 정보의 훈련과정명 기업명 시작일 종료일 등급 특이사항 비고 정보 제공</caption>
									<colgroup>
										<col width="*">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="6%">
										<col width="15%">
										<col width="6%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">훈련과정명</th>
											<th scope="col">기업명</th>
											<th scope="col">시작일</th>
											<th scope="col">종료일</th>
											<th scope="col">등급</th>
											<th scope="col">특이사항</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="result" items="${traningList}" varStatus="status">
										<tr>
											<td>
											<input type="hidden" id="traningProcessManageIds${status.count}" name="traningProcessManageIdss" value="${result.traningProcessManageId}">
											${result.traningProcessName}
											</td>
											<td>${result.companyName}</td>
											<td>${result.startDate}</td>
											<td>${result.endDate}</td>
											<td>
												<label for="prtGrade${status.count}" class="hidden">등급 선택</label>
												<select id="prtGrade${status.count}" name="prtGrades">
													<option value="">선택</option>
													<option value="A" ${result.prtGrade eq 'A' ? 'selected' : ''}>A</option>
													<option value="B" ${result.prtGrade eq 'B' ? 'selected' : ''}>B</option>
													<option value="C" ${result.prtGrade eq 'C' ? 'selected' : ''}>C</option>
													<option value="D" ${result.prtGrade eq 'D' ? 'selected' : ''}>D</option>
													<option value="F" ${result.prtGrade eq 'F' ? 'selected' : ''}>F</option>
												</select>
											</td>
											<td>
												<label for="prtBigo${status.count}" class="hidden">특이사항 입력</label>
												<textarea id="prtBigo${status.count}" name="prtBigos" id="prtBigo${status.count}" name="prtBigos"  rows="5">${result.prtBigo}</textarea>
											</td>
											<td>
												<a href="javascript:fn_saveTraningSubject();" class="btn-full-gray">등록</a>
											</td>
										</tr>
									</c:forEach>	
									</tbody>
								</table>
							</div>
						</form>
						</c:if>
						
						<h2 class="mt-040">훈련정보</h2>						
						<!--  디자인 변경  -->
						<!-- 훈련정보 tab -->
						<!-- <ul class="training tabs">
							<li class="tab-link current" data-tab="tab-1">
								1주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-2">
								2주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-3">
								3주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-4">
								4주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-5">
								5주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-6">
								6주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-7">
								7주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-8">
								8주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-9">
								9주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
							<li class="tab-link" data-tab="tab-10">
								10주차<span>교육시간 6</span>
								<i class="xi-play"></i>
							</li>
						</ul> -->
					
						<%-- <div id="tab-1" class="tab-content current">
							<ul class="training-box">
								<!--  loop  -->
								<li>
									<div class="box03">
										<strong class="title"><span class="num">[1주차]</span>2019.06.25(화) / 09:00 ~ 12:00</strong>
									</div>
									
									<ul>
										<li>
											<span>능력단위명</span> 
											<em>(기업특화)제도기본-유족</em>
										</li>
										<li>
											<span>능력단위요소명</span>
											<em></em>
										</li>
										<li>
											<span>교육시간</span> 
											<em>시간</em>
										</li>
										<li>
											<span>학습자료</span> 
											<em></em></li>
										<li>
											<span>훈련일지</span> 
											<em>
												<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn btn-primary btn-sm">진행</a>
											 	<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn btn-warning btn-sm">미작성</a>
											 	<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn btn-black btn-sm">완료</a>
											</em>
										</li>
										<li>
											<span>학습활동서</span> 
											<em>
												<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn btn-primary btn-sm">진행</a>
											 	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn btn-warning btn-sm">미작성</a>
											 	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn btn-black btn-sm">완료</a>
											</em>
										</li>
									</ul>
								</li>
								<!--  //loop  -->  
								
								<!--  loop  -->
								<li>
									<div class="box03">
										<strong class="title"><span class="num">[1주차]</span>2019.06.27(목) / 09:00 ~ 12:00</strong>
									</div>
									
									<ul>
										<li>
											<span>능력단위명</span> 
											<em>(기업특화)제도기본-유족</em>
										</li>
										<li>
											<span>능력단위요소명</span>
											<em></em>
										</li>
										<li>
											<span>교육시간</span> 
											<em>시간</em>
										</li>
										<li>
											<span>학습자료</span> 
											<em></em></li>
										<li>
											<span>훈련일지</span> 
											<em>
												<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn btn-primary btn-sm">진행</a>
											 	<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn btn-warning btn-sm">미작성</a>
											 	<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn btn-black btn-sm">완료</a>
											</em>
										</li>
										<li>
											<span>학습활동서</span> 
											<em>
												<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn btn-primary btn-sm">진행</a>
											 	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn btn-warning btn-sm">미작성</a>
											 	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn btn-black btn-sm">완료</a>
											</em>
										</li>
									</ul>
								</li>
								<!--  //loop  -->  
							</ul>
						</div>
						
						<div id="tab-2" class="tab-content">
							2주차
						</div>
						
						<div id="tab-3" class="tab-content">
							3주차
						</div>
						
						<div id="tab-4" class="tab-content">
							4주차
						</div>
						
						<div id="tab-5" class="tab-content">
							5주차
						</div>
						
						<div id="tab-6" class="tab-content">
							6주차
						</div>
						
						<div id="tab-7" class="tab-content">
							7주차
						</div>
						
						<div id="tab-8" class="tab-content">
							8주차
						</div>
						
						<div id="tab-9" class="tab-content">
							9주차
						</div>
						
						<div id="tab-10" class="tab-content">
							10주차
						</div> --%>
						<!-- //훈련정보 tab -->
						
						<!--  // 디자인 변경  -->
						
						
						<div class="table-responsive">
							<table class="type-2">
								<caption>주차 훈련일자 능력단위명 교육시간 훈련일지 학습활동서 정보 제공</caption>
								<colgroup>
									<col style="width:5%" />
									<col style="width:25%" />
									<col style="*" />
									<%-- <col style="*" /> --%>
									<col style="width:10%" />
									<col style="width:15%" />
									<col style="width:10%" />
									<col style="width:10%" />
									<%-- <col style="width:8%" /> --%>
								</colgroup>
								<thead>
									<tr>
										<th scope="row" rowspan="2">주차</th>
										<th scope="row" rowspan="2">훈련일자</th>
										<th scope="row" rowspan="2">능력단위명</th>
										<!-- <th>능력단위요소명</th> -->
										<th scope="row" rowspan="2">교육시간</th>
										<!-- <th>학습자료</th> -->
										<th scope="row" rowspan="2">훈련일지</th>
										<th scope="row" colspan="2">학습활동서</th>
									</tr>
									<tr>
										<th scope="row">등록여부</th>
										<th scope="row">승인여부</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
											
											
											
											<c:choose>
												<c:when test="${result.rowspanCnt eq '1'}">
												
												<c:set var="lessonCnt" value= "${result.lessonCnt}"/>
												
													<tr <c:if test="${result.nowWeekCnt eq result.weekCnt}">class="highlight"</c:if>>
														<td>${result.weekCnt}</td>
														<td class="border-left">
														
														
														  <c:choose>
															<c:when test="${empty result.traningDate}">기업현장교사 입력 전</c:when>
															<c:otherwise>${result.traningDate}(${result.dayWeek}) ${result.traningSt} ~ ${result.traningEd}</c:otherwise>
														</c:choose>
														
														</td>
														<td>${result.ncsUnitName}</td>
														<%-- <td>${fn:replace(result.ncsElemName, cn , br )}</td> --%>
														<td>${result.timeHour}</td>
														<!-- <td><a href="/lu/cop/bbs/BBSMSTR_000000000009/selectBoardList.do" class="btn-search-gray"></a></td> -->
														
														<td>
															<c:choose>
																<c:when test="${empty result.traningDate}">
																	<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">미작성</a>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${empty result.traNoteStatus}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">등록중</a>
																		</c:when>
																		<c:when test="${result.traNoteStatus eq '1'}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">승인요청</a>
																		</c:when>
																		<c:when test="${result.traNoteStatus eq '2'}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">승인</a>
																		</c:when>
																		<c:when test="${result.traNoteStatus eq '3'}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">반려</a>
																		</c:when>
																	</c:choose>
																</c:otherwise>
															</c:choose>
															<%-- <c:choose>
																<c:when test="${result.nowWeekYn eq 'Y'}">
																	<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-blue">진행</a>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${result.traNoteCnt eq '0'}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">미작성</a>
																		</c:when>
																		<c:otherwise>
																			<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-gray">완료</a>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose> --%>
														</td>
														
														<!--  
														<td>
															<c:choose>
																<c:when test="${result.nowWeekYn eq 'Y'}">
																	<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-blue">진행</a>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${result.traNoteCnt eq '0'}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">미작성</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${result.traNoteApprovalCnt eq result.traNoteCnt}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-gray">완료</a>
																				</c:when>
																				<c:otherwise>
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">${result.traNoteApprovalCnt} / ${result.traNoteCnt}</a>
																				</c:otherwise>
																			</c:choose>
																			
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</td>
														-->
														<td>
															<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">${result.actNoteCnt} / ${result.lessonCnt}</a>
															<%-- <c:choose>
																<c:when test="${result.nowWeekYn eq 'Y'}">
																	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">진행</a>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${result.actNoteCnt eq lessonCnt}">
																			<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-gray">완료</a>
																		</c:when>
																		<c:otherwise>
																			<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-orange">${result.actNoteCnt} / ${lessonCnt}</a>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose> --%>
														</td> 
														
														<td>
															<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">${result.actNoteApprovalCnt} / ${result.lessonCnt}</a>
															<%-- <c:choose>
																<c:when test="${result.nowWeekYn eq 'Y'}">
																	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">진행</a>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${result.actNoteApprovalCnt eq lessonCnt}">
																			<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-gray">완료</a>
																		</c:when>
																		<c:otherwise>
																			<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-orange">${result.actNoteApprovalCnt} / ${lessonCnt}</a>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose> --%>
														</td> 
														
													</tr>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${result.rowNum eq '1'}">
														
															<c:set var="lessonCnt" value= "${result.lessonCnt * result.rowspanCnt}"/>
															
															<tr <c:if test="${result.nowWeekCnt eq result.weekCnt}">class="highlight"</c:if>>
																<td rowspan="${result.rowspanCnt}">${result.weekCnt}</td>
																<td class="border-left">
																
																 <c:choose>
																	<c:when test="${empty result.traningDate}">기업현장교사 입력 전</c:when>
																	<c:otherwise>${result.traningDate}(${result.dayWeek}) ${result.traningSt} ~ ${result.traningEd}</c:otherwise>
																</c:choose>
																
																</td>
																<td>${result.ncsUnitName}</td>
																<%-- <td>${fn:replace(result.ncsElemName, cn , br )}</td> --%>
																<td>${result.timeHour}</td>
																<%-- <td rowspan="${result.rowspanCnt}"><!-- <a href="/lu/cop/bbs/BBSMSTR_000000000009/selectBoardList.do" class="btn-search-gray"></a> --></td> --%>
																<td>
																	<c:choose>
																		<c:when test="${empty result.traningDate}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">미작성</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${empty result.traNoteStatus}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">등록중</a>
																				</c:when>
																				<c:when test="${result.traNoteStatus eq '1'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">승인요청</a>
																				</c:when>
																				<c:when test="${result.traNoteStatus eq '2'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">승인</a>
																				</c:when>
																				<c:when test="${result.traNoteStatus eq '3'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">반려</a>
																				</c:when>
																			</c:choose>
																		</c:otherwise>
																	</c:choose>
																	<%-- <c:choose>
																		<c:when test="${result.nowWeekCnt eq result.weekCnt}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-blue">진행</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${result.traNoteCnt eq '0'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-orange">미작성</a>
																				</c:when>
																				<c:otherwise>
																					<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-gray">완료</a>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose> --%>
																</td>
																
																<%-- <td>
																	<c:choose>
																		<c:when test="${result.nowWeekCnt eq result.weekCnt}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-blue">진행</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${result.traNoteCnt eq '0'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-orange">미작성</a>
																				</c:when>
																				<c:otherwise>
																					<c:choose>
																						<c:when test="${result.traNoteApprovalCnt eq result.traNoteCnt}">
																							<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-gray">완료</a>
																						</c:when>
																						<c:otherwise>
																							<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">${result.traNoteApprovalCnt} / ${result.traNoteCnt}</a>
																						</c:otherwise>
																					</c:choose>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose>
																</td> --%>
																
																<td>
																	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">${result.actNoteCnt} / ${result.lessonCnt}</a>
																	<%-- <c:choose>
																		<c:when test="${result.nowWeekCnt eq result.weekCnt}">
																			<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">진행</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${result.actNoteCnt eq lessonCnt}">
																					<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-gray">완료</a>
																				</c:when>
																				<c:otherwise>
																					<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-orange">${result.actNoteCnt} / ${lessonCnt}</a>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose> --%>
																</td> 
																
																<td>
																<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">${result.actNoteApprovalCnt} / ${result.lessonCnt}</a>
																	<%-- <c:choose>
																		<c:when test="${result.nowWeekCnt eq result.weekCnt}">
																			<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">진행</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${result.actNoteApprovalCnt eq lessonCnt}">
																					<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-gray">완료</a>
																				</c:when>
																				<c:otherwise>
																					<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-orange">${result.actNoteApprovalCnt} / ${lessonCnt}</a>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose> --%>
																</td> 
															</tr>
														</c:when>
														<c:otherwise>
															<tr <c:if test="${result.nowWeekCnt eq result.weekCnt}">class="highlight"</c:if>>
																<td class="border-left">${result.traningDate}(${result.dayWeek}) ${result.traningSt} ~ ${result.traningEd}</td>
																<td>${result.ncsUnitName}</td>
																<td>${result.timeHour}</td>
																
																<%-- <td>${fn:replace(result.ncsElemName, cn , br )}</td> --%>
																<td>
																	<c:choose>
																		<c:when test="${empty result.traningDate}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">미작성</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${empty result.traNoteStatus}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">등록중</a>
																				</c:when>
																				<c:when test="${result.traNoteStatus eq '1'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">승인요청</a>
																				</c:when>
																				<c:when test="${result.traNoteStatus eq '2'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-gray">승인</a>
																				</c:when>
																				<c:when test="${result.traNoteStatus eq '3'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">반려</a>
																				</c:when>
																			</c:choose>
																		</c:otherwise>
																	</c:choose>
																</td>	
																<td>
																	<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">${result.actNoteCnt} / ${result.lessonCnt}</a>
																</td> 
																
																<td>
																<a href="#none" onclick="fn_activity('${result.weekCnt}');" class="btn-line-blue">${result.actNoteApprovalCnt} / ${result.lessonCnt}</a>
																</td>
																	
																	<%-- <c:choose>
																		<c:when test="${result.nowWeekYn eq 'Y'}">
																			<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-blue">진행</a>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${result.traNoteCnt eq '0'}">
																					<a href="#none" onclick="fn_note('${result.weekCnt}');" class="btn-line-orange">미작성</a>
																				</c:when>
																				<c:otherwise>
																					<a href="#none" onclick="fn_note('${result.weekCnt}');"  class="btn-line-gray">완료</a>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose> --%>
																</td>
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
							</table><!-- E : 훈련정보 -->
						</div>
</div>
						

<script>
	if(scrollNum > 9){
		setTimeout(function() { $("#next").trigger("click"); }, 1000); 
	} 
	if( scrollNum > 18 ) {
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 27 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 36 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 45 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 

</script>	

