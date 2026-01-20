<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>

<script type="text/javascript" src="${contextRootJS }/js/oklms/onlineStudy.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/popupApi.js"></script>
<script type="text/javascript">
<!--
//var jsonObj = eval('${lms:objectToJson(popupList)}');
var jsonObj = ${lms:objectToJson(popupList)};
var pSubjectTraningType = "${param.subjectTraningType}";
PopupOpenerAPI.dataList = jsonObj;
PopupOpenerAPI.contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
	//팝업 알림.
	for (var i=0; i < PopupOpenerAPI.dataList.length; i++) {
		var popup = PopupOpenerAPI.dataList[i];
		PopupOpenerAPI.open(popup, true);
	}
	
	if(pSubjectTraningType == "OFF"){
		showTabbtn2();
	} else {
		showTabbtn1();
	}
	
});

function fn_board_list(bbsId) {
	var reqUrl = "/lu/cop/bbs/"+bbsId+"/selectBoardList.do";

	$("#frmMainPage").attr("action", reqUrl);
	$("#frmMainPage").submit();
}

function fn_board_detail(nttId, bbsId) {
	var reqUrl = "/lu/cop/bbs/"+bbsId+"/selectBoardArticle.do?nttId="+nttId;

	$("#frmMainPage").attr("action", reqUrl);
	$("#frmMainPage").submit();
}
function fn_searchDay(day){
	var reqUrl = "/lu/main/lmsUserMainPage.do";
	$("#nowDay").val(day);
	$("#frmMainPage").attr("action", reqUrl);
	$("#frmMainPage").submit();	
}

function goWeekLessonSubmit(lessonId,weekId,weekCnt,contentName,weekProgressRate ,attendProgress, cutProgress,progressAttendTypeCode){

	$("#attendProgress").val(attendProgress);
	$("#cutProgress").val(cutProgress);
	$("#progressAttendTypeCode").val(progressAttendTypeCode);
	goWeekLesson(lessonId,weekId,weekCnt,contentName,weekProgressRate);

}

function fn_setTraning(subjectTraningType){
	$("#subjectTraningType").val(subjectTraningType);
}

//-->
</script>

<style>
table.type-2 td.onlineTypeName-td {
	padding-left: 1.2rem;
	text-align: left
}

table.type-2 td a.new-move-btn {
	background: url(/images/oklms/std/inc/opsz24.png) left 30% no-repeat; 
	color :#666;
	border : 0;
	background-size: 14px;
	font-size : 12px;
	margin-top: 4px;
	padding-left: 17px;
	overflow: inherit;
}

.new-move-btn span {
    background: url(/images/oklms/std/inc/edu_lnb_6.png) #d2e6ff no-repeat;
    border-radius: 20px;
    padding: 0.3rem 1.2rem 0.2rem 0.8rem;
    color: #666;
    background-size: 5px;
    background-position: 87% 50%;
    margin-left: 2px;
    border: 1px solid #a9c4e8;
    font-size: 11px
}
.notice-list {
	height: 241px;
	overflow: auto;
}
</style>


<form id="frmLesson" name="frmLesson" method="post">
	<input type="hidden" id="id" name="id" value="" /> 
	<input type="hidden" id="courseContentId" name="courseContentId"/>
	<input type="hidden" id="lessonId" name="lessonId" />
	<input type="hidden" id="lessonItemId" name="lessonItemId" />
	<input type="hidden" id="lessonSubItemId" name="lessonSubItemId" />
	<input type="hidden" id="contentsDir" name="contentsDir" />
	<input type="hidden" id="contentsIdxFile" name="contentsIdxFile" />
	<input type="hidden" id="contentsRealFile" name="contentsRealFile" />
	<input type="hidden" id="weekCnt" name="weekCnt" value="" />
	<input type="hidden" id="weekId" name="weekId" value="" />
	<input type="hidden" id="subjSchId" name="subjSchId" value="" />
	<input type="hidden" id="stdLessonId" name="stdLessonId" value="" />
	<input type="hidden" id="cmsLessonId" name="cmsLessonId" value="" />
	<input type="hidden" id="cmsLessonItemId" name="cmsLessonItemId" value="" />
	<input type="hidden" id="cmsLessonSubItem" name="cmsLessonSubItem" value="" />
	<input type="hidden" id="linkContentYn" name="linkContentYn" value="" />
	<input type="hidden" id="progressAttendId" name="progressAttendId" value="" />
	<input type="hidden" id="progressTimeId" name="progressTimeId" value="" />
	<input type="hidden" id="pageInfo" name="pageInfo" value="" />
	<input type="hidden" id="viewLessonId" name="viewLessonId" value="" />
	<input type="hidden" id="spanId" name="spanId" value="" />
	<input type="hidden" id="attendProgress" name="attendProgress" value="" />
	<input type="hidden" id="cutProgress" name="cutProgress" value="" />
	
	<input type="hidden" id="progressAttendTypeCode" name="progressAttendTypeCode" value="" />
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
					<dl id="index-schedule"></dl>
				</div>

				<div class="index-guide">
					<span>○ : 출석인정 진도율 ${onlineTraningVO.attendProgress}이상, △ : 지각인정 진도율 ${onlineTraningVO.cutProgress}이상 ~ 출석인정 진도율 ${onlineTraningVO.attendProgress}미만, × : 지각인정 진도율 ${onlineTraningVO.cutProgress}미만</span>
				</div>
			</div>


			<div id="movie-zone">
				<div class="movie-name"><span id="week-schedule-title">[ 01주차 ] 01차시&nbsp;&nbsp;-&nbsp;&nbsp;전기공압의 기초회로</span></div>
				<div class="wait-img" style="height:660px">잠시만 기다려주세요.</div>
				<iframe id="contentFrame" width="512px" height="660px" frameborder="0" allowfullscreen title="movie-zone"></iframe>

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

<form name="frmMainPage" id="frmMainPage" method="post">
<input type="hidden" name="nowDay" id="nowDay" >
<input type="hidden" name="subjectTraningType" id="subjectTraningType" value="${param.subjectTraningType}" >
<!-- 학습근로자 -->
	<!-- 강의일정 -->
	
	<div class="full-area mt-000">
		<h3>MY PAGE</h3>
		
		<!-- 전체 공지사항 -->
		<%-- <div class="half-left-area">
			<h3 class="notice-tit mt-040">
				Q &amp; A
				<a href="#!" onclick="fn_board_list('BBSMSTR_000000000007');" ><i class="xi-plus"></i><span class="hidden">Q&A 더보기</span></a>
			</h3>
			<ul class="notice-list">
			<c:if test="${fn:length(quAndAnResultList) == 0}">
				<li class="no-text">등록된 QNA가 없습니다.</li>
			</c:if>
			<c:forEach var="quAndAnResult" items="${quAndAnResultList}" varStatus="status">
				<li>
					<a href="#!" onclick="fn_board_detail('${quAndAnResult.nttId}','${quAndAnResult.bbsId}');">
						<span class="day"><strong></strong>${quAndAnResult.frstRegisterPnttm}</span> 
						<div class="txt">
							<span><em class="label orange">${quAndAnResult.subjectName}</em>${quAndAnResult.nttSj}</span>
						</div> 
					</a>
				</li>
			</c:forEach>
			</ul>
		</div> --%>
		<!-- //전체  공지사항 -->
		
		<div class="half-left-area">
			<h3 class="notice-tit mt-040">
				알림사항
				<a href="#!" onclick="fn_board_list('BBSMSTR_000000000050');" ><i class="xi-plus"></i><span class="hidden">알림사항 더보기</span></a>
			</h3>
			<ul class="notice-list">
				<c:if test="${fn:length(newsResultList) == 0}">
					<li class="no-text">등록된 알림사항이 없습니다.</li>
				</c:if>	
				<c:forEach var="noticeResult" items="${newsResultList}" varStatus="status">
					<li>
						<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
							<span class="day">${noticeResult.frstRegisterPnttm}</span>
							<div class="txt">
								<span>
								<!-- 
									<em class="label orange">${noticeResult.subjectName}</em>
								 -->	
								 <em class="label orange">알림</em>
									<c:if test="${'Y' == noticeResult.topNoticeYn}"></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></c:if>
								</span>
							</div> 
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		
		<!-- 교과목별 공지사항 -->
		<div class="half-right-area">
			<h3 class="notice-tit mt-040">
				공지사항
				<a href="#!" onclick="fn_board_list('BBSMSTR_000000000000');" ><i class="xi-plus"></i><span class="hidden">공지사항 더보기</span></a>
			</h3>
			<%-- <ul class="notice-list">
				<c:forEach var="noticeResult" items="${noticeAllResultList}" varStatus="status"> 
				<li>
					<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
						 <span class="day"><strong></strong>${noticeResult.frstRegisterPnttm}</span>
						<div class="txt">
							<span><em class="label orange">${noticeResult.subjectName}</em>${noticeResult.nttSj}</span>
						</div> 
					</a>
				</li>
			</c:forEach>
			</ul> --%>
			<ul class="notice-list">
				<c:if test="${fn:length(noticeAllResultList) == 0}">
					<li class="no-text">등록된 공지사항이 없습니다.</li>
				</c:if>
				<c:forEach var="noticeResult" items="${noticeAllResultList}" varStatus="status">
					<li>
						<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
							<span class="day">${noticeResult.frstRegisterPnttm}</span>
							<div class="txt">
								<span>
								<!-- 
									<em class="label orange">${noticeResult.subjectName}</em>
								 -->	
								 <em class="label orange">공지</em>
									<c:if test="${'Y' == noticeResult.topNoticeYn}"></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></c:if>
								</span>
							</div> 
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<!-- //교과목별  공지사항 -->
		<div class="clearfix"></div>
		<div class="lecture-date" style="margin-top: 10px;">
			<ul>
				<!--  Off-JT -->
				<li>
					<div class="lecture-title">
						<strong class="tit"><i class="xi-label"></i> Off-JT</strong>
					</div>
					<div class="lecture-box">
						
						<table class="type-2 wp100">
							<caption>교과명 출견현황 학습활동서 과제출제현황에 대한 정보 제공</caption>
							<thead>
								<tr>
									<th scope="col">교과명</th>
									<th scope="col">출결현황</th>
									<th scope="col">확습활동서</th>
									<th scope="col">과제 출제 현황</th>
								</tr>
							</thead>
							<tbody>
							
							
							<c:forEach var="offListSchedule" items="${offListSchedule}" varStatus="status">
								<tr>
									<td class="onlineTypeName-td">
									<a href="#!"  onclick="javascript:fn_lec_menu_display('${offListSchedule.subjectTraningType}','${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.subjectType}','${offListSchedule.onlineType}');"  class="text">${offListSchedule.subjectName}</a>
									<c:if test="${offListSchedule.onlineTypeName ne '없음'}">
										<a href="javascript:fn_lec_menu_display('${offListSchedule.subjectTraningType}','${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.subjectType}','${offListSchedule.onlineType}');" class="btn btn-primary  btn-sm">${ offListSchedule.onlineTypeName}</a>
										<br>
										<c:set var="infos" value="${fn:split(offListSchedule.currWeekInfo, ',')}" />
	
										<c:forEach var="it" items="${infos}">
											<c:set var="pair" value="${fn:split(it,'|')}" />
											<c:set var="weekTitles" value="${pair[0]}" />
											<c:set var="weekId" value="${pair[1]}" />
											<a href="javascript:fn_lec_menu_display_shc('${offListSchedule.subjectTraningType}','${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.subjectType}','${offListSchedule.onlineType}','${weekId}');" class="btn new-move-btn">
												${weekTitles} <span>바로가기</span>
											</a>
											<br>
										</c:forEach>
										</c:if>
									</td>
									<td>${offListSchedule.atnDay} / ${offListSchedule.maxWeekCnt}</td>
									<td>${offListSchedule.activityCnt} / ${offListSchedule.maxWeekCnt}</td>
									<td>
									<c:if test="${ offListSchedule.reportCnt ne '0' }">
									<a href="javascript:fn_lec_url('${offListSchedule.subjectTraningType}','${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.subjectType}','${offListSchedule.onlineType}','/lu/report/listReportStd.do');" class="btn-full-gray">과제</a>
									</c:if>
									</td>
								</tr>					
							</c:forEach>
		
							<c:if test="${ empty offListSchedule}">
								<tr>
									<td colspan="4">강의가 없습니다.</td>
								</tr>					 
							</c:if>
							
							 	<!-- <tr>
									<td><a href="">HRD와기업가정신</a><a href="" class="btn btn-primary  btn-sm">이러닝</a></td>
									<td>3/5</td>
									<td><a href="" class="btn-line-orange">미작성</a></td>
									<td><a href="" class="btn-full-gray">토론</a></td>
								</tr>

								<tr>
									<td colspan="4">강의가 없습니다.</td>
								</tr>	 -->				 
							</tbody>
						</table>
						
					</div>
				</li>
				<!--  //Off-JT -->
				
				<!--  ojt -->
				<li>
					<div class="lecture-title">
						<strong class="tit"><i class="xi-label"></i> OJT</strong>
					</div>
					<div class="lecture-box">
						
						<table class="type-2 wp100">
							<caption>교과명 출견현황 학습활동서에 대한 정보 제공</caption>
							<thead>
								<tr>
									<th scope="col">교과명</th>
									<th scope="col">출결현황</th>
									<th scope="col">학습활동서</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="ojtListSchedule" items="${ojtListSchedule}" varStatus="status">
								 	<tr>
										<td>
											<a href="#!" onclick="javascript:fn_lec_menu_display('${ojtListSchedule.subjectTraningType}','${ojtListSchedule.yyyy}','${ojtListSchedule.term}','${ojtListSchedule.subjectCode}','${ojtListSchedule.subClass}','${ojtListSchedule.subjectName}','${ojtListSchedule.subjectType}','${ojtListSchedule.onlineType}');" class="text">${ojtListSchedule.subjectName}</a>
										</td>
										<td>${empty ojtListSchedule.ojtAttendCnt ? '0' : ojtListSchedule.ojtAttendCnt} / ${ojtListSchedule.maxWeekCnt}</td>
										<td>${ojtListSchedule.activityCnt} / ${ojtListSchedule.maxWeekCnt}</td>
									</tr>
									
								 </c:forEach>
								 <c:if test="${ empty ojtListSchedule}">
									<tr>
										<td colspan="3">강의가 없습니다.</td>
									</tr>					 
								 </c:if> 
							
							 	<!-- <tr>
									<td><a href=""></a></td>
									<td>3/5</td>
									<td><a href="" class="btn-line-orange">미작성</a></td>
								</tr>

								<tr>
									<td colspan="3">강의가 없습니다.</td>
								</tr>	 -->				 
							</tbody>
						</table>
					
					</div>
				</li>
				<!--  //ojt -->
			</ul>
		</div> 
	</div>	
	<!-- //강의일정 -->
	
	<div class="full-area">
		<h3>교과목 이수 현황</h3>
		
		<div class="table-responsive scroll-height01">
			<table class="type-2 mb-030">
				<caption>교과명 학점 성적 진행학기 교수명 교과목구분 대한 정보 제공</caption>
				<colgroup>
					<col width="*" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="12%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">교과명</th>
						<th scope="col">학점</th>
						<th scope="col">성적</th>
						<th scope="col">진행학기</th>
						<th scope="col">교수명</th>
						<th scope="col">교과목구분</th>
					</tr>
				</thead>
				<tbody>
				
					<c:set var="totPoint" value="0"/>
					<c:forEach var="result" items="${listComplete}" varStatus="status">
					 	 <tr>
							<td><%-- <a href="javascript:fn_lec_menu_display('${result.subjectTraningType}','${result.yyyy}','${result.term}','${result.subjectCode}','${result.subClass}','${result.subjectName}','${result.subjectType}','${result.onlineType}');"> --%>${result.subjectName}<!-- </a> --></td>
							<td>
							<c:choose>
								<c:when test="${result.point ne '0'}">
								${result.point}학점
								<c:set var="totPoint" value="${totPoint+result.point}"/>
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
							</td>
							<td>${result.gradNm}</td>
							<td>${result.yyyy}년 ${result.termName}</td>
							<td>${result.insNames}</td>
							<td>${result.subjectTraningTypeName}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(listComplete) == 0}">
						<tr>
							<td colspan="6">이수 목록이 없습니다.</td>
						</tr>
					</c:if>					
				</tbody>
				<tfoot>
					<tr>
						<th scope="row">이수학점</th>
						<th colspan="5">${totPoint}학점</th>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	
	
	
	
	<%-- 
	<div class="half-left-area mt-100">
		<h3>TODAY</h3>
		<table class="type-3" style="table-layout:fixed;">
			<thead>
				<tr>
					<!-- <th>학습활동서작성</th> -->
					<!-- <th>질문과답변</th> -->
					<th>과제제출</th>
					<th>팀프로젝트과제제출</th>
					<th>토론개설</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_1"><span>${readTodayCnt[0].myPageTodayCnt1}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_2"><span>${readTodayCnt[0].myPageTodayCnt2}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_3"><span>${readTodayCnt[0].myPageTodayCnt3}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_4"><span>${readTodayCnt[0].myPageTodayCnt4}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_5"><span>${readTodayCnt[0].myPageTodayCnt5}</span></a>건</td>
				</tr>
			</tbody>
		</table>
	</div>
	

	<div class="half-right-area mt-100">
	<h3>공지사항</h3>
	<ul class="board-list">
		<c:if test="${fn:length(noticeResultList) == 0}">
			<li>등록된 공지사항이 없습니다.</li>
		</c:if>
		<c:forEach var="noticeResult" items="${noticeResultList}" varStatus="status">
			<c:if test="${noticeResult.isExpired eq 'N' }">
		
			<li>
				<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
					<p> [ ${noticeResult.subjectName} ]</p>
					<c:if test="${'Y' == noticeResult.topNoticeYn}"><B></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></B></c:if>
				</a><span>${noticeResult.frstRegisterPnttm}</span>
			</li>
			
			</c:if>
		</c:forEach>
		<li class="more"><a href="#!" onclick="fn_board_list('BBSMSTR_000000000005');" title="더 보기">공지사항 더 보기</a></li>
	</ul>
	</div>

	<div class="full-area">

		<div class="daily-schedule">
			<a href="#!" class="btn-pre" onclick="javascript:fn_searchDay('${yesDay}');" >이전</a> ${nowDay} <c:if test="${not empty nowDayName }"> (${nowDayName })</c:if><a href="#!"  onclick="javascript:fn_searchDay('${tomDay}');"  class="btn-next">다음</a>
		</div>

		<dl id="tab-type-1">
			<dt class="tab-name-11 on"><a href="javascript:showTabbtn1();fn_setTraning('OJT');">OJT</a></dt>
			<dd id="tab-content-11" style="display:block;">
				<h3>강의일정</h3>
				<table class="type-2 mb-030">
					<colgroup>
						<col width="110px" />
						<col width="*" />
						<col width="60px" />
						<col width="50px" />
						<col width="130px" />
						<col width="100px" />
						<col width="140px" />
						<col width="90px" />
					</colgroup>
					<thead>
						<tr>
							<th>시간</th>
							<th>개설 교과명</th>
							<th>대상학년</th>
							<th>분반</th>
							<th>기업명</th>
							<th>주차</th>
							<th>단원(능력단위요소)</th>
							<th>기업현장교사</th>
						</tr>
					</thead>
					<tbody>
					
					 <c:forEach var="ojtListSchedule" items="${ojtListSchedule}" varStatus="status">
					 
					 	<tr>
							<td>${ojtListSchedule.traningStHour}:${ojtListSchedule.traningStMin} ~ ${ojtListSchedule.traningEdHour}:${ojtListSchedule.traningEdMin}</td>
							<td class="left">
								<a href="#!" onclick="javascript:fn_lec_menu_display('${ojtListSchedule.subjectTraningType}','${ojtListSchedule.yyyy}','${ojtListSchedule.term}','${ojtListSchedule.subjectCode}','${ojtListSchedule.subClass}','${ojtListSchedule.subjectName}','${ojtListSchedule.subjectType}','${ojtListSchedule.onlineType}');" class="text">${ojtListSchedule.subjectName}</a>
							</td>
							<td>${mainPageVO.sessionLevel}</td>
							<td>${ojtListSchedule.subClass}</td>
							<td>${ojtListSchedule.companyName}</td>
							<td>${ojtListSchedule.weekCnt} / ${ojtListSchedule.maxWeekCnt}</td>
							<td>
								<c:if test="${not empty ojtListSchedule.ncsUnitName}">${ojtListSchedule.ncsUnitName}</c:if>
								<c:if test="${not empty ojtListSchedule.ncsElemName}">(${ojtListSchedule.ncsElemName})</c:if>
							</td>
							<td>${ojtListSchedule.tutNames} </td>
						</tr>
						
					 </c:forEach>
					 <c:if test="${ empty ojtListSchedule}">
						<tr>
							<td colspan="8">강의가 없습니다.</td>
						</tr>					 
					 </c:if> 
					</tbody>
				</table>
			</dd>

			<dt class="tab-name-12"><a href="javascript:showTabbtn2();fn_setTraning('OFF');">Off-JT</a></dt>
			<dd id="tab-content-12">
				<h3>강의일정</h3>
				<table class="type-2 mb-030">
					<colgroup>
						<col width="110px" />
						<col width="*" />
						<col width="60px" />
						<col width="60px" />
						<col width="110px" />
						<col width="180px" />
						<col width="130px" />
					</colgroup>
					<thead>
						<tr>
							<th>시간</th>
							<th>개설 교과명</th>
							<th>대상학년</th>
							<th>주차</th>
							<th>온라인 교육형태</th>
							<th>단원 (능력단위요소)</th>
							<th>장소</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="offListSchedule" items="${offListSchedule}" varStatus="status">
						<tr>
							<td>${offListSchedule.traningStHour}:${offListSchedule.traningStMin} ~ ${offListSchedule.traningEdHour}:${offListSchedule.traningEdMin}</td>
							<td class="left">
							<a href="#!" onclick="javascript:fn_lec_menu_display('${offListSchedule.subjectTraningType}','${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.subjectType}','${offListSchedule.onlineType}');"  class="text">${offListSchedule.subjectName}</a>
							</td>
							<td>${mainPageVO.sessionLevel}</td>
							<td>${offListSchedule.weekCnt} / ${offListSchedule.maxWeekCnt}</td>
							<td>
					<c:if test="${offListSchedule.subjectTraningType eq 'OFF'}">
						<c:choose>
							<c:when test="${offListSchedule.weekMappingCnt ne '0'}">
								${offListSchedule.onlineTypeName} <p id="weekProgress_${offListSchedule.weekId}">${offListSchedule.weekProgressRate}%</p><a href="javascript:goWeekLessonSubmit('${offListSchedule.lessonId}','${offListSchedule.weekId}','${offListSchedule.weekCnt}','${offListSchedule.contentName}',${offListSchedule.weekProgressRate},'${offListSchedule.attendProgress}', '${offListSchedule.cutProgress}','${offListSchedule.progressAttendTypeCode}');" class="btn-full-gray">학습</a>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</c:if>
												</td>
							<td>
								<c:if test="${not empty offListSchedule.ncsUnitName}">${offListSchedule.ncsUnitName}</c:if>
								<c:if test="${not empty offListSchedule.ncsElemName}">(${offListSchedule.ncsElemName})</c:if>
							</td>
							<td>${offListSchedule.lctrumNm}</td>
						</tr>					
					</c:forEach>

					<c:if test="${ empty offListSchedule}">
						<tr>
							<td colspan="7">강의가 없습니다.</td>
						</tr>					 
					</c:if>

					</tbody>
				</table>
			</dd>
		</dl>
	</div>

	<div class="half-left-area">
		<h3 class="mt-030">학습관리</h3>
		<table class="type-2">
			<colgroup>
				<col width="*" />
				<col width="80px" />
				<col width="50px" />
				<col width="50px" />
				<col width="50px" />
			</colgroup>
			<thead>
				<tr>
					<th>교과목</th>
					<th>진도율</th>
					<th>결석</th>
					<th>온라인<br />미수강</th>
					<!-- <th>활동서<br />미작성</th> -->
				</tr>
			</thead>
			<tbody>
				<c:forEach var="rs" items="${listLmsUserMainPageStatusCnt }" varStatus="status">
					<tr>
						<td class="left"><a href="#!"  onclick="javascript:fn_lec_menu_display('${rs.subjectTraningType}','${rs.yyyy}','${rs.term}','${rs.subjectCode}','${rs.subClass}','${rs.subjectName}','${rs.subjectType}','${rs.onlineType}');"  class="text">${rs.subjectName}</a></td>
						<td>${rs.realProgressRate} %</td>
						<td>${rs.totalTime - rs.attend }</td>
						<td>
							<c:if test="${rs.subjectTraningType eq 'OFF' }">
								<c:choose>
									<c:when test="${rs.onlineType ne 'NONE'}">
										<c:if test="${(rs.onTotalTime - rs.onAttend) < 0 }">
										0
										</c:if>
										<c:if test="${(rs.onTotalTime - rs.onAttend) > 0 }">
										${rs.onTotalTime - rs.onAttend }
										</c:if>
									</c:when>
									<c:otherwise>
										0
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${rs.subjectTraningType ne 'OFF' }">-</c:if>
						</td>
						<td>${rs.activityNoteCnt}</td>
					</tr>				
				</c:forEach>
				
				<c:if test="${ empty listLmsUserMainPageStatusCnt}">
					<tr>
						<!-- <td colspan="5">강의가 없습니다.</td> -->
						<td colspan="4">강의가 없습니다.</td>
					</tr>					 
				</c:if>
			</tbody>
		</table>
 
	</div>

	<div class="half-right-area">
		<h3 class="mt-030">Q &amp; A</h3>
		<ul class="board-list">
		<c:if test="${fn:length(quAndAnResultList) == 0}">
			<li>등록된 Q &amp; A가 없습니다.</li>
		</c:if>
		<c:forEach var="quAndAnResult" items="${quAndAnResultList}" varStatus="status">
			<li>
				<a href="#!" onclick="fn_board_detail('${quAndAnResult.nttId}','${quAndAnResult.bbsId}');">
					<p>[ ${quAndAnResult.subjectName} ]</p>
					<c:if test="${'Y' == quAndAnResult.topNoticeYn}"><B></c:if>${quAndAnResult.nttSj}<c:if test="${'Y' == quAndAnResult.topNoticeYn}"></B></c:if>
				</a><span>${quAndAnResult.frstRegisterPnttm}</span>
			</li>
		</c:forEach>
		<li class="more"><a href="#!" onclick="fn_board_list('BBSMSTR_000000000007');" title="더 보기">Q &amp; A 더 보기</a></li>
		</ul>
	</div>
	 --%>
</form>

