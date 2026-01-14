<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

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


<script type="text/javascript">

	var targetUrl = "${targetUrl}";
	var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
	var totalCount = '${totalCount}'; //전체 데이터 갯수
	var pageIndex = '${pageIndex}'; //현재 페이지 정보
	
	$(document).ready(function() {

		if ('' == pageSize) {
			pageSize = 10;
		}
		if ('' == totalCount) {
			totalCount = 0;
		}
		if ('' == pageIndex) {
			pageIndex = 1;
		}

		loadPage();
	});

	/*====================================================================
		화면 초기화 
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}


	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/* 화면이 로드된후 처리 초기화 */
	function initHtml() {

//         com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
		
		
	}
	
	$(function () {
	    const $focusBtn = $('.focus-tr').first();

	    if ($focusBtn.length) {
	        // 포커스
	        $focusBtn.attr('tabindex', '-1').focus();

	        // 스크롤 (부드럽게 가운데)
	        $('html, body').animate({
	            scrollTop: $focusBtn.offset().top - ($(window).height() / 2)
	        }, 400);
	    }
	});

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search( param1 ){
		
		$("#pageIndex").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listMember.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}
	
	function fn_subject_schedule_form(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "getCurrProcScheduleForm.do";
		$("#frmLesson").attr("action", reqUrl);
		$("#frmLesson").submit();
	}
	
	function fn_subject_eval_form(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "getCurrProcEvalForm.do";
		$("#frmLesson").attr("action", reqUrl);
		$("#frmLesson").submit();
	}
	
	function fn_file_pop(weekId) { 
		popOpenWindow("", "popFileDown", 500, 260);
		var reqUrl = "/lu/online/popupOnlineTraningFileDown.do";
		$("#file_weekId").val(weekId);
		//$("#rowId").val(rowId);
		$("#frmFile").attr("action", reqUrl);
		$("#frmFile").attr("target", "popFileDown");
		$("#frmFile").submit();
	}
	
	
	function goLesson(lessonId,weekId,weekCnt,contentName,weekProgressRate,subjSchId,subjStep,subjTitle){
		//javascript:goLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}',${result.weekProgressRate});
		var reqUrl = "/lu/currproc/onlineTraningStd.do";
		$("#lessonId").val(lessonId);
		$("#weekId").val(weekId);
		$("#weekCnt").val(weekCnt);
		$("#contentName").val(contentName);
		$("#weekProgressRate").val(weekProgressRate);
		$("#subjSchId").val(subjSchId);
		$("#subjStep").val(subjStep);
		$("#subjTitle").val(subjTitle);
		
		//$("#rowId").val(rowId);
		$("#frmLesson").attr("action", reqUrl);
		$("#frmLesson").attr("target", "_self");
		$("#frmLesson").submit();
	}
	
</script>

<form id="frmLesson" name="frmLesson" method="post">
	<input type="hidden" id="id" name="id" value="" /> 
	<input type="hidden" id="courseContentId" name="courseContentId"/>
	<input type="hidden" id="lessonId" name="lessonId" />
	<input type="hidden" id="contentName" name="contentName" />
	<input type="hidden" id="weekProgressRate" name="weekProgressRate" />
	<input type="hidden" id="lessonItemId" name="lessonItemId" />
	<input type="hidden" id="lessonSubItemId" name="lessonSubItemId" />
	<input type="hidden" id="contentsDir" name="contentsDir" />
	<input type="hidden" id="contentsIdxFile" name="contentsIdxFile" />
	<input type="hidden" id="contentsRealFile" name="contentsRealFile" />
	<input type="hidden" id="weekCnt" name="weekCnt" value="" />
	<input type="hidden" id="weekId" name="weekId" value="" />
	<input type="hidden" id="subjSchId" name="subjSchId" value="" />
	<input type="hidden" id="subjStep" name="subjStep" value="" />
	<input type="hidden" id="subjTitle" name="subjTitle" value="" />
	<input type="hidden" id="stdLessonId" name="stdLessonId" value="" />
	<input type="hidden" id="cmsLessonId" name="cmsLessonId" value="" />
	<input type="hidden" id="cmsLessonItemId" name="cmsLessonItemId" value="" />
	<input type="hidden" id="cmsLessonSubItem" name="cmsLessonSubItem" value="" />
	<input type="hidden" id="linkContentYn" name="linkContentYn" value="" />
	<input type="hidden" id="progressAttendId" name="progressAttendId" value="" />
	<input type="hidden" id="progressTimeId" name="progressTimeId" value="" />
	<input type="hidden" id="pageInfo" name="pageInfo" value="" />
	<input type="hidden" id="viewLessonId" name="viewLessonId" value="" />
	<input type="hidden" id="weekProgressYn" name="weekProgressYn" value="" />
	<input type="hidden" id="spanId" name="spanId" value="" />
	<input type="hidden" id="attendProgress" name="attendProgress" value="${onlineTraningVO.attendProgress}" />
	<input type="hidden" id="cutProgress" name="cutProgress" value="${onlineTraningVO.cutProgress}" />
	<input type="hidden" id="progressAttendTypeCode" name="progressAttendTypeCode" value="${onlineTraningVO.progressAttendTypeCode}" />
	
	<input type="hidden" id="estblYy" name="estblYy" value="${subjectVO.estblYy}" />
	<input type="hidden" id="estblSemstrCd" name="estblSemstrCd" value="${subjectVO.estblSemstrCd}" />
	<input type="hidden" id="courseNo" name="courseNo" value="${subjectVO.courseNo}" />
	<input type="hidden" id="partitnClasSeCd" name="partitnClasSeCd" value="${subjectVO.partitnClasSeCd}" />
	
	<input type="hidden" id="yyyy" name="yyyy" value="${subjectVO.yyyy}" />
	<input type="hidden" id="term" name="term" value="${subjectVO.term}" />
	<input type="hidden" id="subjectCode" name="subjectCode" value="${subjectVO.subjectCode}" />
	<input type="hidden" id="subjectClass" name="subjectClass" value="${subjectVO.subjectClass}" />
	
</form>

<form id="frmFile" name="frmFile" method="post">
	<input type="hidden" id="file_weekId" name="weekId" value=""/>
</form>

<ul id="learning-popup">
	<li class="learning-area"  id="learning-area" style="height:820px; margin-top:-410px;">
		<div class="title">
			<span>${subjectVO.subjectName}</span>
			<!-- <a href="javascript:alert('준비중입니다.');" class="btn-1">과정소개</a>
			<a href="javascript:alert('준비중입니다.');" class="btn-2">사용안내</a>
			<a href="javascript:alert('준비중입니다.');" class="btn-3">오류신고</a> -->
			<a href="javascript:hideLearningPop();" class="btn-4">종료</a>
		</div>

		<div id="learn-container">
			<div id="index" style="height:760px">
				<div class="index-title"><span>INDEX</span></div>
				<div class="index-list" id="index" style="height:560px">
					<dl id="index-schedule">
						<!-- <dt><span><b>01</b> 주차</span> <b>출석 : ○</b></dt>
						<dd class="highlight">
							<div><a href="#!"><b>[01차시]</b> 전기공압의 기초회로</a></div>
							<ul class="on">
								<li><a href="#!"><span>○</span>과정소개</a></li>
								<li><a href="#!"><span>○</span>학습에 앞서</a></li>
								<li class="current"><a href="#!"><span>○</span>사전지식체크</a></li>
								<li><a href="#!"><span>○</span>시퀀스 제어란?</a></li>
								<li><a href="#!"><span>○</span>전기접점의 종류와 특징</a></li>
							</ul>
						</dd>
						-->
					</dl>
				</div>

				<div class="index-guide">
					<span>○ : 출석인정 진도율 ${onlineTraningVO.attendProgress}이상, △ : 지각인정 진도율 ${onlineTraningVO.cutProgress}이상 ~ 출석인정 진도율 ${onlineTraningVO.attendProgress}미만, × : 지각인정 진도율 ${onlineTraningVO.cutProgress}미만</span>
				</div>
			</div>


			<div id="movie-zone">
				<div class="movie-name"><span id="week-schedule-title">[ 01주차 ] 01차시&nbsp;&nbsp;-&nbsp;&nbsp;전기공압의 기초회로</span></div>
				<div class="wait-img" style="height:660px">잠시만 기다려주세요.</div>
				<iframe id="contentFrame" width="512px" height="660px" frameborder="0" allowfullscreen title="전기공압의 기초회로"></iframe>

				<div class="movie-control">
					<a href="javascript:prevView();" class="pre">이전</a>
					<span id="contentPage"><b>01</b> / 24</span>
					<a href="javascript:nextView();" class="next">다음</a>
				</div>
			</div><!-- E : movie-zone -->
		</div>

	</li>
	<li class="popup-bg"></li>
</ul><!-- E : learning-popup -->

<div id="content-area">
<fmt:parseNumber var = "offTimeHour" value = "${subjectVO.offTimeHour}" />
	<h2>교과목 정보</h2>
		<h4 class="mb-010"><span>${subjectVO.subjectName} / ${subjectVO.subjectCode}</span> (${subjectVO.subjectClass}반) ㅣ ${subjectVO.yyyy}학년도 ${subjectVO.termName}
		<a href="#none" onclick="fn_subject_schedule_form();" class="btn btn-warning btn-sm ml-005">강의계획서</a>
		</h4>
		<div class="group-area mb-010">
			<table class="type-1 responsive-tr">
				<caption>교과목 정보의 교과형태 과정구분 훈련시간 담당교수 온라인 교육형태 정보 제공</caption>
				<tr>
					<th scope="row">교과형태</th>
					<td>${subjectVO.subjectTraningTypeName}</td>
					<th scope="row">과정구분</th>
					<td>${subjectVO.subjectTypeName}</td>
					<th scope="row">훈련시간</th>
					<td>
					<fmt:parseNumber var= "time" integerOnly= "true" value= "${offTimeHour * fn:length(resultList) }" />
					${time}시간
					</td>
				</tr>
				<tr>
					<th scope="row">담당교수</th>
					<td>${subjectVO.insNames}</td>
					<th scope="row">온라인 교육형태</th>
					<td colspan="3">${subjectVO.onlineTypeName}</td>
					<%-- <th>선수여부</th>
					<td>${subjectVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}</td> --%>
				</tr>
		</table>
	</div><!-- E : 교과목 정보 -->

<%--
	<h2 class="mt-040">진행율</h2>
	<div class="progress-area mt-010">
		<p>전체 진행율  [ 총 ${ empty progress.onRealRrogressTime  ? 0 : progress.onRealRrogressTime} ] ></p>
		<ul>
			<li style="width:${ empty progress.onRealRrogressRate  ? 0 : progress.onRealRrogressRate}%; text-align: center"><span><b>${ empty progress.onRealRrogressRate  ? 0 : progress.onRealRrogressRate }</b> %</span></li>
		</ul>
	</div><!-- E : 진행율 -->
--%>
	<script type="text/javascript"> 
        $(function(){
            var article = ("table .tr-show"); 
            $("td button.a-title").click(function() { 
                var myArticle =$(this).parents().next("tr"); 
                var trid = myArticle.attr('id');
                if($(myArticle).hasClass('tr-hide')) { 
                    //$(article).removeClass('tr-show').addClass('tr-hide');
                    $(myArticle).removeClass('tr-show').addClass('tr-hide');
                    $(myArticle).removeClass('tr-hide').addClass('tr-show'); 
                } 
                else { 
                    $(myArticle).addClass('tr-hide').removeClass('tr-show'); 
                } 
            }); 
        });
	</script>

	
	<h2 class="mt-040">훈련정보 > 교과목 상세</h2>
	<div class="table-responsive mt-010">
	<table class="type-2">
		<caption>교과목 상세보기 주차 훈련일자 온라인학습기간 능력단위 온라인교육형태등의 정보 제공</caption>
		<colgroup>
			 <col style="width:5%" />
			<col style="width:12%" />
			<col style="width:12%" />
			<col style="width:*" />
			<col style="width:6%" />
			<col style="width:12%" />
			<col style="width:8%" />
			<col style="width:8%" />
			<col style="width:8%" />
			<col style="width:8%" />
			<%-- <col style="width:8%" /> --%>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">주차</th>
				<th scope="col">훈련일자</th>
				<th scope="col">온라인 학습기간</th>
				<th scope="col">능력단위</th>
				<th scope="col">교육 시간</th>
				<th scope="col">주별 진도율</th>
				<th scope="col">보조 자료</th>
				<th scope="col">과제 정보</th>
				<th scope="col">학습 자료</th>
				<!-- <th>훈련 일지</th> -->
				<th scope="col">학습 활동서</th>
			</tr>
		</thead>
		<tbody>
		
			<c:forEach var="result" items="${resultList}" varStatus="status">
				
				<c:choose>
					<c:when test="${!empty result.reinfcTraningDate and !empty result.reinfcDayWeek}">
						<tr>
							<td>${result.weekCnt}</td>
							<td>${result.traningDate}(${result.dayWeek})<c:if test="${fn:length(result.traningSt) > 1  and  fn:length(result.traningEd) > 1}"><br />${result.traningSt} ~ ${result.traningEd}</c:if></td>
							<td colspan="8">휴강 (보강일 ${result.reinfcTraningDate})</td>
						</tr>
					</c:when>
					<c:otherwise> 
						<tr <c:if test="${result.nowWeekYn eq 'Y'}"></c:if>>
								<td>${result.weekCnt} 
								
								<c:if test="${subjectVO.onlineType ne 'NONE'}">
									<button class="btn btn-black btn-week a-title" ><i class="xi-plus-min"></i></button>
								</c:if>
								
								</td>
								<td><!-- 휴보강 추가 -->
										${result.traningDate}(${result.dayWeek})<c:if test="${fn:length(result.traningSt) > 1  and  fn:length(result.traningEd) > 1}"><br />${result.traningSt} ~ ${result.traningEd}</c:if>
								</td>
								<td><c:if test="${!empty result.weekStDate and !empty result.weekEdDate and result.weekMappingCnt ne '0'}">${result.weekStDate} ~ ${result.weekEdDate}</c:if></td>
								<td class="left">${result.ncsName}</td>
								<td>${result.leadTime}</td>
								<!-- O -->
									<td>
									<c:choose>
										<c:when test="${result.weekMappingCnt ne '0'}">
											<!--${subjectVO.onlineTypeName} <p id="weekProgress_${result.weekId}">${result.weekProgressRate}%</p><a href="javascript:goWeekLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}',${result.weekProgressRate});" class="btn-full-gray">${result.btnText}</a>-->
											<span id="weekProgress_${result.weekId}">${result.weekProgressRate}%</span><%-- <a href="javascript:goLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}',${result.weekProgressRate});" class="btn-full-gray">${result.btnText}</a> --%>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									</td>
								<td>
								<c:if test="${result.weekFileCnt ne '0'}">
									<a href="#fn_file_pop" onclick="fn_file_pop('${result.weekId}');" class="btn-search-gray">자료</a>
								</c:if>
								</td>
								<td>
									<c:if test="${!empty  result.reportId}">
										<a href="/lu/report/getReportStd.do?reportId=${result.reportId}" class="btn-full-gray" style="width:49px;">과제</a>
									</c:if>
									<c:if test="${!empty  result.discussId}">
										<c:if test="${!empty  result.reportId}"><br /></c:if>
										<a href="/lu/discuss/listDiscuss.do?yyyy=${result.yyyy}&term=${result.term}&subjectCode=${result.subjectCode}&subClass=${result.subjectClass}" class="btn-full-gray" style="width:49px;">토론</a>
									</c:if>
								</td>
								<td><!-- <a href="/lu/cop/bbs/BBSMSTR_000000000009/selectBoardArticle.do" class="btn-search-gray"></a> --></td>
								<%-- <td>
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
								</td> --%>
								<td>
									<c:choose>
										<c:when test="${result.nowWeekYn eq 'Y'}">
											<c:choose>
												<c:when test="${result.actNoteCnt ne '0'}">
													<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-gray">완료</a>
												</c:when>
												<c:otherwise>
													<a href="/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}" class="btn-line-blue">진행</a>
												</c:otherwise>
											</c:choose>
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
							
							<!--  주차별 해당 차시 확인 테이블 -->
							
							<!-- 온라인 교과가 아닐때 추가 -->
							<c:if test="${subjectVO.onlineType ne 'NONE'}">
							
								<tr class="on tr-show ${result.weekId == param.focusId ? 'focus-tr' : '' }" id="tr_${status.count}">
									<td colspan="10">
										<div style="width:98%; margin:0 auto">
											<div class="sub_text blue_text mt-010 align-left">
				 								 <i class="xi-label"></i> ${result.contentName}
				 							</div>
											<div class="table-responsive mt-010 mb-010">
												<table class="type-1-2">
													<caption>차시 콘텐츠명차시별진도율 학습 학습기간 내 학습시간기준학습시간 등의 정보 제공</caption>
													<colgroup>
														<col width="8%" />
														<col width="*" />
														<col width="20%" />
														<col width="8%" />
														<col width="15%" />
														<col width="15%" />
													</colgroup>
													<thead>
														<tr>
															<th scope="col">차시</th>
															<th scope="col">콘텐츠명</th>
															<th scope="col">차시별 진도율</th>
															<th scope="col">학습</th>
															<th scope="col">학습기간</th>
															<th scope="col">내 학습시간 / 기준 학습시간</th>
														</tr>
													</thead>
													<tbody>
													<c:forEach var="sch" items="${scheduleList}" varStatus="sch_status">
														<c:if test="${result.weekId eq sch.weekId}">
														
														<c:set var="rate" value="60"/>
														
														<tr>
															<td>${sch.subjStep}차시</td>
															<td>${sch.subjTitle}</td>
															<td>
																<div class="charts" >
																	<div class="charts-chart"  data-percent="${sch.schProgressRate}%" style="width:${sch.schProgressRate}%;${sch.schProgressRate < 80 ? 'background-color: red !important' : ''}"></div>
																</div>
															</td>
															<td>
																<a href="javascript:goLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}','${result.weekProgressRate}','${sch.subjSchId}','${sch.subjStep}','${sch.subjTitle}');"
																class="btn-full-oraange">
																	${result.btnText}
																</a>
															</td>
															<td>${sch.startDate}~${sch.endDate}</td>
															<td>
																<!-- 진도율 이상 확인필요 -->
																${sch.schStudyMinute}/${sch.studyTime}
															</td>
														</tr>    
														</c:if>
													</c:forEach>	
													
													
														<%-- <tr>
															<td>1차시</td>
															<td>콘텐츠명</td>
															<td>
																<div class="charts">
																	<div class="charts-chart" data-percent="100%" style="width:100%"></div>
																</div>
															</td>
															<td><a href="javascript:goLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}',${result.weekProgressRate});"  class="btn-full-oraange">학습</a></td>
															<td>2020.02.15~<br />2020.02.20</td>
															<td>120/120</td>
														</tr>
														
														<tr>
															<td>2차시</td>
															<td>콘텐츠명</td>
															<td>
																<div class="charts">
																	<div class="charts-chart" data-percent="60%" style="width:60%"></div>
																</div>
															</td>
															<td><a href="" class="btn-full-oraange">학습</a></td>
															<td>2020.02.15~<br />2020.02.20</td>
															<td>120/120</td>
														</tr>
														
														<tr>
															<td>3차시</td>
															<td>콘텐츠명</td>
															<td>
																<div class="charts">
																	<div class="charts-chart" data-percent="25%" style="width:25%"></div>
																</div>
															</td>
															<td><a href="" class="btn-full-oraange">학습</a></td>
															<td>2020.02.15~<br />2020.02.20</td>
															<td>120/120</td>
														</tr> --%>
													</tbody>
												</table>
											</div>
										</div>
									</td>
								</tr>
								
							</c:if>
							
							
							
							<!--  //주차별 해당 차시 확인 테이블 -->
					</c:otherwise>
					</c:choose>
			</c:forEach>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:if test="${!empty result.reinfcTraningDate and !empty result.reinfcDayWeek}">
					<tr <c:if test="${result.nowWeekYn eq 'Y'}">class="highlight"</c:if>>
						<td>${result.weekCnt}주차<br/>보강</td>
						<td>${result.reinfcTraningDate}(${result.reinfcDayWeek})<c:if test="${fn:length(result.traningSt) > 1  and  fn:length(result.traningEd) > 1}"><br />${result.traningSt} ~ ${result.traningEd}</c:if></td>
						<td><c:if test="${!empty result.weekStDate and !empty result.weekEdDate and result.weekMappingCnt ne '0'}">${result.weekStDate} ~ ${result.weekEdDate}</c:if></td>
						<td class="left">${result.ncsName}</td>
						<td>${result.leadTime}</td>
						<!-- O -->
							<td>
							<c:choose>
								<c:when test="${result.weekMappingCnt ne '0'}">
									${subjectVO.onlineTypeName} <p id="weekProgress_${result.weekId}">${result.weekProgressRate}%</p><a href="javascript:goWeekLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}',${result.weekProgressRate});" class="btn-full-gray">${result.btnText}</a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							</td>
						<td>
						<c:if test="${result.weekFileCnt ne '0'}">
							<a href="#fn_file_pop" onclick="fn_file_pop('${result.weekId}');" class="btn-search-gray">자료</a>
						</c:if>
						</td>
						<td>
							<c:if test="${!empty  result.reportId}">
								<a href="/lu/report/getReportStd.do?reportId=${result.reportId}" class="btn-full-gray" style="width:49px;">과제</a>
							</c:if>
							<c:if test="${!empty  result.discussId}">
								<c:if test="${!empty  result.reportId}"><br /></c:if>
								<a href="/lu/discuss/listDiscuss.do?yyyy=${result.yyyy}&term=${result.term}&subjectCode=${result.subjectCode}&subClass=${result.subjectClass}" class="btn-full-gray" style="width:49px;">토론</a>
							</c:if>
						</td>
						<td><!-- <a href="/lu/cop/bbs/BBSMSTR_000000000009/selectBoardArticle.do" class="btn-search-gray"></a> --></td>
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
				</c:if>	
			</c:forEach> 
			
			<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="10"><spring:message code="common.nodata.msg" /></td>
			</tr>
			</c:if>
		</tbody>
	</table><!-- E : 훈련정보 -->
	</div>
	
	<style>
		table.type-2 .focus-tr:focus {
			background-color: #fff2de;
		    outline: 1px solid #ff9b00;
		    box-shadow: 0 0 0 2px #ffbe5b inset;
		    border-radius: 10px;

		}
	</style>


