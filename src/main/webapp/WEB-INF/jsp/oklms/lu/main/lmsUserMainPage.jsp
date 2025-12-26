<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/popupApi.js"></script>
<script type="text/javaScript" language="javascript">
var jsonObj = eval('${lms:objectToJson(popupList)}');
PopupOpenerAPI.dataList = jsonObj;
PopupOpenerAPI.contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
	//팝업 알림.
	for (var i=0; i < PopupOpenerAPI.dataList.length; i++) {
		var popup = PopupOpenerAPI.dataList[i];
		//PopupOpenerAPI.open(popup, true);
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
</script>

<form name="frmMainPage" id="frmMainPage" method="post">

<c:choose>
<c:when test="${'STD' == memType}"> <!-- 학습근로자 -->

	<div class="half-left-area mt-100">
		<h3>TODAY</h3>
		<table class="type-3" style="table-layout:fixed;">
			<caption>학습활동서작성 질문과답변 과제제출 팀프로젝트과제제출 토론개설에 대한 정보 제공</caption>
			<thead>
				<tr>
					<th scope="col">학습활동서작성</th>
					<th scope="col">질문과답변</th>
					<th scope="col">과제제출</th>
					<th scope="col">팀프로젝트과제제출</th>
					<th scope="col">토론개설</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt5}</span>건</td>
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
			<li>
				<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
					<p>[ ${noticeResult.subjectName} ]</p>
					<c:if test="${'Y' == noticeResult.topNoticeYn}"><B></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></B></c:if>
				</a><span>${noticeResult.frstRegisterPnttm}</span>
			</li>
		</c:forEach>
		<li class="more"><a href="#!" onclick="fn_board_list('BBSMSTR_000000000005');" title="더 보기">공지사항 더 보기</a></li>
	</ul>
	</div>

	<div class="full-area">

		<div class="daily-schedule">
			<a href="#!" class="btn-pre">이전</a> 2016.10.02 (월) <a href="#!" class="btn-next">다음</a>
		</div>

		<dl id="tab-type-1">
			<dt class="tab-name-11 on"><a href="javascript:showTabbtn1();">OJT</a></dt>
			<dd id="tab-content-11" style="display:block;">
				<h3>강의일정</h3>
				<table class="type-2 mb-030">
					<caption>시간 개설 교과명 대상학년 분반 기업명 주차 능력단위요소 기업현장교사에 대한 정보 제공</caption>
					<colgroup>
						<col width="110px" />
						<col width="*" />
						<col width="60px" />
						<col width="50px" />
						<col width="130px" />
						<col width="50px" />
						<col width="140px" />
						<col width="90px" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">시간</th>
							<th scope="col">개설 교과명</th>
							<th scope="col">대상학년</th>
							<th scope="col">분반</th>
							<th scope="col">기업명</th>
							<th scope="col">주차</th>
							<th scope="col">단원(능력단위요소)</th>
							<th scope="col">기업현장교사</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>09:00 ~ 12:00</td>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
							<td>1</td>
							<td>01</td>
							<td>기업명_A</td>
							<td>4/15</td>
							<td>능력단위요소_3</td>
							<td>현장교사_A1</td>
						</tr>
						<tr>
							<td>14:00 ~ 17:00</td>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
							<td>1</td>
							<td>05</td>
							<td>기업명_E</td>
							<td>4/15</td>
							<td>능력단위요소_3</td>
							<td>현장교사_A1</td>
						</tr>
						<tr>
							<td>18:00 ~ 20:00</td>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
							<td>1</td>
							<td>14</td>
							<td>기업명_N</td>
							<td>4/15</td>
							<td>능력단위요소_3</td>
							<td>현장교사_A1</td>
						</tr>
					</tbody>
				</table>
			</dd>

			<dt class="tab-name-12"><a href="javascript:showTabbtn2();">Off-JT</a></dt>
			<dd id="tab-content-12">
				<h3>강의일정</h3>
				<table class="type-2 mb-030">
					<caption>시간 개설 교과명 대상학년 분반 기업명 주차 능력단위요소 장소에 대한 정보 제공</caption>
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
							<th scope="col">시간</th>
							<th scope="col">개설 교과명</th>
							<th scope="col">대상학년</th>
							<th scope="col">주차</th>
							<th scope="col">온라인 교육형태</th>
							<th scope="col">단원 (능력단위요소)</th>
							<th scope="col">장소</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>09:00 ~ 12:00</td>
							<td class="left"><a href="1_진행중인교과목.html" class="text">시퀀스제어 및 실습</a></td>
							<td>1</td>
							<td>3/15</td>
							<td>플립러닝<br /><a href="javascript:showLearningpop();" class="btn-line-gray-50">복습</a></td>
							<td>능력단위요소_D.1</td>
							<td>공학1관-C410</td>
						</tr>
						<tr>
							<td>14:00 ~ 17:00</td>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기계 가공학</a></td>
							<td>1</td>
							<td>3/15</td>
							<td>순수온라인<br /><a href="javascript:showLearningpop();" class="btn-line-gray-50">학습</a></td>
							<td>능력단위요소_D.1</td>
							<td>공학1관-C410</td>
						</tr>
						<tr>
							<td>18:00 ~ 20:00</td>
							<td class="left">교과목_D</td>
							<td>1</td>
							<td>3/15</td>
							<td>없음</td>
							<td>능력단위요소_D.1</td>
							<td>공학1관-C410</td>
						</tr>
					</tbody>
				</table>
			</dd>
		</dl>
	</div>

	<div class="half-left-area">
		<h3 class="mt-030">학습관리</h3>
		<table class="type-2">
			<caption>교과목 진도율 결석 온라인미수강 활동서미작성에 대한 정보 제공</caption>
			<colgroup>
				<col width="*" />
				<col width="80px" />
				<col width="50px" />
				<col width="50px" />
				<col width="50px" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">교과목</th>
					<th scope="col">진도율</th>
					<th scope="col">결석</th>
					<th scope="col">온라인<br />미수강</th>
					<th scope="col">활동서<br />미작성</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="left"><a href="1_진행중인교과목.html" class="text">시퀀스제어 및 실습</a></td>
					<td>60 / 80%</td>
					<td>2</td>
					<td>-</td>
					<td>1</td>
				</tr>
				<tr>
					<td class="left"><a href="1_진행중인교과목.html" class="text">기계 가공학</a></td>
					<td>80 / 80%</td>
					<td>0</td>
					<td>1</td>
					<td>2</td>
				</tr>
			</tbody>
		</table>
		<div class="board-more"><a href="10_Q&A.html">학습관리 더 보기</a></div>
		<div class="btn-area align-right mt-010">
			<a href="#!" class="gray-1">&lt; 이전</a>
			<a href="#!" class="gray-1">다음 &gt;</a>
		</div>
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
</c:when>

<c:when test="${'PRT' == memType}"> <!-- 담당교수 -->

<div class="half-left-area mt-100">
		<h3>TODAY</h3>
		<table class="type-3" style="table-layout:fixed;">
			<caption>훈련일지작성 학습활동서확인 Q&A 개별과제확인 팀프로젝트확인에 대한 정보 제공</caption>
			<colgroup>
				<col width="20%" />
				<col width="23%" />
				<col width="14%" />
				<col width="20%" />
				<col width="23%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">훈련일지 작성</th>
					<th scope="col">학습활동서 확인</th>
					<th scope="col">Q&A</th>
					<th scope="col">개별과제 확인</th>
					<th scope="col">팀프로젝트 확인</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</td>
					<td><span>${readTodayCnt[0].myPageTodayCnt5}</span>건</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="half-right-area mt-100">
		<h3>Q &amp; A</h3>
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

	<div class="full-area">

		<div class="daily-schedule">
			<a href="#!" class="btn-pre">이전</a> 2016.10.02 (월) <a href="#!" class="btn-next">다음</a>
		</div>

		<dl id="tab-type-1">
			<dt class="tab-name-11 on"><a href="javascript:showTabbtn1();">OJT</a></dt>
			<dd id="tab-content-11" style="display:block;">
				<h3>강의일정</h3>
				<table class="type-2 mb-030">
					<caption>강의일정에 대한 정보 제공</caption>
					<colgroup>
						<col width="110px" />
						<col width="*" />
						<col width="60px" />
						<col width="50px" />
						<col width="130px" />
						<col width="50px" />
						<col width="140px" />
						<col width="90px" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">시간</th>
							<th scope="col">개설 교과명</th>
							<th scope="col">대상학년</th>
							<th scope="col">분반</th>
							<th scope="col">기업명</th>
							<th scope="col">주차</th>
							<th scope="col">단원(능력단위요소)</th>
							<th scope="col">기업현장교사</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td>${result.traningStHour}:${result.traningStMin} ~ ${result.traningEdHour}:${result.traningEdMin}</td>
								<td class="left"><a href="1_진행중인교과목.html" class="text">${result.subjectName}</a></td>
								<td>${result.term}</td>
								<td>${result.subjectClass}</td>
								<td>${result.companyName}</td>
								<td>${result.weekCnt}/${result.totWeekCnt}</td>
								<td>${result.ncsElemName}</td>
								<td>${result.tutName}</td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="8">강의일정이 없습니다.</td>
							</tr>	
						</c:if>
					</tbody>
				</table>

				<h3>학습근로자관리</h3>
				<table class="type-2">
					<colgroup>
						<col width="*" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="90px" />
					</colgroup>
					<thead>
						<tr>
							<th>개설교과</th>
							<th>대상학년</th>
							<th>참여기업</th>
							<th>주차</th>
							<th>인원</th>
							<th>결석</th>
							<th>지각</th>
							<th>활동서 미작성</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
							<td>1</td>
							<td>20</td>
							<td>3/15</td>
							<td>40</td>
							<td>3</td>
							<td>0</td>
							<td>5</td>
						</tr>
						<tr>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
							<td>1</td>
							<td>15</td>
							<td>3/15</td>
							<td>40</td>
							<td>3</td>
							<td>0</td>
							<td>5</td>
						</tr>
						<tr>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
							<td>1</td>
							<td>15</td>
							<td>3/15</td>
							<td>40</td>
							<td>3</td>
							<td>0</td>
							<td>5</td>
						</tr>
					</tbody>
				</table>
			</dd>

			<dt class="tab-name-12"><a href="javascript:showTabbtn2();">Off-JT</a></dt>
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
						<tr>
							<td>09:00 ~ 12:00</td>
							<td class="left"><a href="1_진행중인교과목.html" class="text">시퀀스제어 및 실습</a></td>
							<td>1</td>
							<td>3/15</td>
							<td>플립러닝<br /><a href="javascript:showLearningpop();" class="btn-line-gray-50">VIEW</a></td>
							<td>능력단위요소_D.1</td>
							<td>공학1관-C410</td>
						</tr>
						<tr>
							<td>14:00 ~ 17:00</td>
							<td class="left"><a href="1_진행중인교과목.html" class="text">기계 가공학</a></td>
							<td>1</td>
							<td>3/15</td>
							<td>플립러닝<br /><a href="javascript:showLearningpop();" class="btn-line-gray-50">VIEW</a></td>
							<td>능력단위요소_D.1</td>
							<td>공학1관-C410</td>
						</tr>
						<tr>
							<td>18:00 ~ 20:00</td>
							<td class="left">교과목_D</td>
							<td>1</td>
							<td>3/15</td>
							<td>없음</td>
							<td>능력단위요소_D.1</td>
							<td>공학1관-C410</td>
						</tr>
					</tbody>
				</table>

				<h3>학습근로자관리</h3>
				<table class="type-2">
					<colgroup>
						<col width="*" />
						<col width="70px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th rowspan="2">개설교과</th>
							<th rowspan="2">대상학년</th>
							<th rowspan="2">주차</th>
							<th rowspan="2">인원</th>
							<th colspan="2">결석</th>
							<th colspan="2">지각</th>
							<th rowspan="2">활동서 미작성</th>
						</tr>
						<tr>
							<th class="border-left">집체</th>
							<th>온라인</th>
							<th>집체</th>
							<th>온라인</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="left"><a href="#!" class="text">시퀀스제어 및 실습</a></td>
							<td>1</td>
							<td>3/15</td>
							<td>45</td>
							<td>1</td>
							<td>3</td>
							<td>0</td>
							<td>5</td>
							<td>5</td>
						</tr>
						<tr>
							<td class="left"><a href="#!" class="text">기계 가공학</a></td>
							<td>1</td>
							<td>3/15</td>
							<td>45</td>
							<td>2</td>
							<td>3</td>
							<td>0</td>
							<td>5</td>
							<td>5</td>
						</tr>
					</tbody>
				</table>
			</dd>
		</dl>
	</div>
</c:when>

<c:when test="${'COT' == memType}"> <!-- 기업현장교사 -->
<div class="half-left-area mt-100">
<h3>TODAY</h3>
<table class="type-3" style="table-layout:fixed;">
		<thead>
			<tr>
				<th>훈련일지 작성</th>
				<th>학습활동서 확인</th>
				<th>질문과 답변</th>
				<th>공지사항</th>
				<th>면담일지 작성</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt5}</span>건</td>
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
			<li>
				<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
					<p>[ ${noticeResult.subjectName} ]</p>
					<c:if test="${'Y' == noticeResult.topNoticeYn}"><B></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></B></c:if>
				</a><span>${noticeResult.frstRegisterPnttm}</span>
			</li>
		</c:forEach>
		<li class="more"><a href="#!" onclick="fn_board_list('BBSMSTR_000000000005');" title="더 보기">공지사항 더 보기</a></li>
	</ul>
</div>

<div class="full-area">

	<div class="daily-schedule">
		<a href="#!" class="btn-pre">이전</a> 2016.10.02 (월) <a href="#!" class="btn-next">다음</a>
	</div>

	<h3>강의 일정</h3>
	<table class="type-2">
		<colgroup>
		<col width="110px" />
		<col width="*" />
		<col width="60px" />
		<col width="50px" />
		<col width="60px" />
		<col width="140px" />
		<col width="12%" />
	</colgroup>
		<thead>
			<tr>
				<th>시간</th>
				<th>개설교과명</th>
				<th>대상학년</th>
				<th>분반</th>
				<th>주차</th>
				<th>단원 (능력단위요소)</th>
				<th>교수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>09:00 ~ 12:00</td>
				<td class="left"><a href="1_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
				<td>1</td>
				<td>03</td>
				<td>4 / 15</td>
				<td>능력단위요소_3</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>14:00 ~ 17:00</td>
				<td class="left"><a href="1_진행중인교과목.html" class="text">시퀀스제어 및 실습</a></td>
				<td>1</td>
				<td>05</td>
				<td>4 / 15</td>
				<td>능력단위요소_3</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>18:00 ~ 20:00</td>
				<td class="left"><a href="1_진행중인교과목.html" class="text">시퀀스제어 및 실습</a></td>
				<td>1</td>
				<td>01</td>
				<td>4 / 15</td>
				<td>능력단위요소_3</td>
				<td>교수_01</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="half-left-area">
	<h3 class="mt-030">학습근로자관리</h3>
	<table class="type-2">
		<colgroup>
		<col width="*" />
		<col width="50px" />
		<col width="50px" />
		<col width="50px" />
	</colgroup>
		<thead>
			<tr>
				<th>교과목</th>
				<th>주차</th>
				<th>결석</th>
				<th>활동서<br />미작성</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="left"><a href="1_진행중인교과목.html" class="text">시퀀스제어 및 실습</a></td>
				<td>3</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr>
				<td class="left"><a href="1_진행중인교과목.html" class="text">시퀀스제어 및 실습</a></td>
				<td>3</td>
				<td>2</td>
				<td>3</td>
			</tr>
		</tbody>
	</table>
	<div class="btn-area align-right mt-010">
		<a href="#!" class="gray-1">&lt; 이전</a>
		<a href="#!" class="gray-1">다음 &gt;</a>
	</div>
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
</c:when>

<c:when test="${'CCN' == memType}"> <!-- 센터담당자 -->

<div class="half-left-area mt-100">
	<h3>TODAY</h3>
	<table class="type-3" style="">
		<colgroup>
			<col width="23%" />
			<col width="*" />
			<col width="20%" />
			<col width="20%" />
			<col width="18%" />
		</colgroup>
		<thead>
			<tr>
				<th>주간훈련일지<br />미제출건</th>
				<th>학습활동서<br />미제출자</th>
				<th>면담일지<br />미제출건</th>
				<th>훈련시간표<br />변경신청</th>
				<th>담당자<br />변경신청</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt5}</span>건</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="half-right-area mt-100">
	<h3>담당 기업현황</h3>
		<div class="company_area">
			<table class="type-2">
			<colgroup>
				<col width="25%" />
				<col width="*" />
				<col width="25%" />
				<col width="25%" />
			</colgroup>
			<thead>
				<tr>
					<th>학년</th>
					<th>기업체수</th>
					<th>전체학생수</th>
					<th>중도탈락자</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1학년</td>
					<td>3</td>
					<td>200명</td>
					<td>2명</td>
				</tr>
				<tr>
					<td>2학년</td>
					<td>3</td>
					<td>200명</td>
					<td>2명</td>
				</tr>
				<tr>
					<td>3학년</td>
					<td>3</td>
					<td>200명</td>
					<td>2명</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="full-area bdb0">

	<h3>금일훈련 일정</h3>
	<div class="daily-schedule">
		<a href="#!" class="btn-pre">이전</a> 2016.10.02 (월) <a href="#!" class="btn-next">다음</a>
	</div>

	<table class="type-2">
		<colgroup>
			<col width="130px" />
			<col width="110px" />
			<col width="50px" />
			<col width="*" />
			<col width="70px" />
			<col width="*" />
			<col width="50px" />
			<col width="90px" />
			<col width="90px" />
		</colgroup>
		<thead>
			<tr>
				<th>기업명</th>
				<th>훈련시간</th>
				<th>학년</th>
				<th>훈련 과정명</th>
				<th>교과구분</th>
				<th>개설 강좌명</th>
				<th>분반</th>
				<th>기업현장교사</th>
				<th>교수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>기업명_11</td>
				<td>10:00 ~ 12:00</td>
				<td>1</td>
				<td>훈련과정명_01</td>
				<td>OJT</td>
				<td>교과목_D1</td>
				<td>01</td>
				<td>현장교사_11</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>기업명_11</td>
				<td>10:00 ~ 12:00</td>
				<td>1</td>
				<td>훈련과정명_01</td>
				<td>OJT</td>
				<td>교과목_D1</td>
				<td>01</td>
				<td>현장교사_11</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>기업명_11</td>
				<td>10:00 ~ 12:00</td>
				<td>1</td>
				<td>훈련과정명_01</td>
				<td>OJT</td>
				<td>교과목_D1</td>
				<td>01</td>
				<td>현장교사_11</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>기업명_11</td>
				<td>10:00 ~ 12:00</td>
				<td>1</td>
				<td>훈련과정명_01</td>
				<td>OJT</td>
				<td>교과목_D1</td>
				<td>01</td>
				<td>현장교사_11</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>기업명_11</td>
				<td>10:00 ~ 12:00</td>
				<td>1</td>
				<td>훈련과정명_01</td>
				<td>OJT</td>
				<td>교과목_D1</td>
				<td>01</td>
				<td>현장교사_11</td>
				<td>교수_01</td>
			</tr>
		</tbody>
	</table>
</div>
</c:when>

<c:when test="${'CDP' == memType}"> <!-- 학과전담자 -->

<div class="full-area mt-070 mb-040" style="border-top:0;">
<h3>TODAY</h3>
<table class="type-3" style="table-layout:fixed;">
		<thead>
			<tr>
				<th>Q&amp;A 답변대기</th>
				<th>개별과제미체출</th>
				<th>팀프로젝트과제 미체출</th>
				<th>재직증빙서류 미승인</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</td>
			</tr>
		</tbody>
	</table>
</div>

	<div class="half-left-area">
		<h3>공지사항</h3>
		<ul class="board-list">
		<c:if test="${fn:length(noticeResultList) == 0}">
			<li>등록된 공지사항이 없습니다.</li>
		</c:if>
		<c:forEach var="noticeResult" items="${noticeResultList}" varStatus="status">
			<li>
				<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
					<p>[ ${noticeResult.subjectName} ]</p>
					<c:if test="${'Y' == noticeResult.topNoticeYn}"><B></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></B></c:if>
				</a><span>${noticeResult.frstRegisterPnttm}</span>
			</li>
		</c:forEach>
		<li class="more"><a href="#!" onclick="fn_board_list('BBSMSTR_000000000007');" title="더 보기">Q &amp; A 더 보기</a></li>
	</ul>
	</div>

	<div class="half-right-area">
		<h3>Q &amp; A</h3>
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

	<div class="full-area">
		<h3>담당 개설교과 조회</h3>

		<div class="search-box-1 mb-010">
			<select id="" onchange="">
				<option value="">2017년도</option>
			</select>
			<select id="" onchange="">
				<option value="">2학기</option>
			</select>
			<select id="" onchange="">
				<option value="">대상학년</option>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select id="" onchange="">
				<option value="">담당교수</option>
			</select>
			<input type="text" name="" value="교과코드/교과명검색" style="width:180px;" />
		<a href="#!">검색</a>
	</div><!-- E : search-box-1 -->


	<table class="type-2">
		<colgroup>
			<col width="80px" />
			<col width="60px" />
			<col width="60px" />
			<col width="*" />
			<col width="60px" />
			<col width="110px" />
			<col width="110px" />
		</colgroup>
		<thead>
			<tr>
				<th>학년도</th>
				<th>학기</th>
				<th>대상학년</th>
				<th>교과목명</th>
				<th>분반</th>
				<th>담당교수</th>
				<th>온라인 교육형태</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>2016</td>
				<td>2</td>
				<td>3</td>
				<td class="left"><a href="2_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
				<td>01</td>
				<td>담당교수_01</td>
				<td>플립러닝</td>
			</tr>
			<tr>
				<td>2016</td>
				<td>2</td>
				<td>3</td>
				<td class="left"><a href="2_진행중인교과목.html" class="text">기전공학기초설계2</a></td>
				<td>01</td>
				<td>담당교수_01</td>
				<td>없음</td>
			</tr>
		</tbody>
	</table>
</div>
</c:when>

<c:when test="${'CCM' == memType}"> <!-- HRD전담자 -->
	<div class="half-left-area mt-100">
	<h3>TODAY</h3>
	<table class="type-3" style="table-layout:fixed;">
		<thead>
			<tr>
				<th>활동내역서<br />작성</th>
				<th>주간 훈련일지<br />미제출</th>
				<th>주차별 학습활동서<br />미제출</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</td>
				<td><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="half-right-area mt-100">
	<h3>담당훈련과정 현황</h3>
	<table class="type-2">
		<colgroup>
			<col width="*" />
			<col width="60px" />
			<col width="75px" />
			<col width="75px" />
		</colgroup>
		<thead>
			<tr>
				<th>훈련과정명</th>
				<th>학년</th>
				<th>전체 학생수</th>
				<th>중도 탈락자</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td rowspan="2" class="left"><a href="#!" class="text">훈련과정_01</a></td>
				<td>1 학년</td>
				<td>15 명</td>
				<td>2 명</td>
			</tr>
			<tr>
				<td class="border-left">2 학년</td>
				<td>15 명</td>
				<td>2 명</td>
			</tr>
			<tr>
				<td class="left"><a href="#!" class="text">훈련과정_01</a></td>
				<td>1 학년</td>
				<td>15 명</td>
				<td>2 명</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="full-area">

	<div class="daily-schedule">
		<a href="#!" class="btn-pre">이전</a> 2016.10.02 (월) <a href="#!" class="btn-next">다음</a>
	</div>

	<h3>금일 훈련일정</h3>
	<table class="type-2 mb-030">
		<colgroup>
			<col width="100px" />
			<col width="50px" />
			<col width="*" />
			<col width="65px" />
			<col width="*" />
			<col width="50px" />
			<col width="90px" />
			<col width="90px" />
		</colgroup>
		<thead>
			<tr>
				<th>훈련시간</th>
				<th>학년</th>
				<th>훈련 과정명</th>
				<th>구분</th>
				<th>개설 교과명</th>
				<th>분반</th>
				<th>기업현장교사</th>
				<th>교수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>09:00 ~ 12:00</td>
				<td>1</td>
				<td class="left">훈련과정명_01</td>
				<td>OJT</td>
				<td class="left"><a href="#!" class="text">개설교과_D1</a></td>
				<td>01</td>
				<td>현장교사_A1</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>09:00 ~ 12:00</td>
				<td>1</td>
				<td class="left">훈련과정명_01</td>
				<td>Off-JT</td>
				<td class="left"><a href="#!" class="text">개설교과_D1</a></td>
				<td>01</td>
				<td>현장교사_A1</td>
				<td>교수_01</td>
			</tr>
			<tr>
				<td>09:00 ~ 12:00</td>
				<td>1</td>
				<td class="left">훈련과정명_01</td>
				<td>OJT</td>
				<td class="left"><a href="#!" class="text">개설교과_D1</a></td>
				<td>01</td>
				<td>현장교사_A1</td>
				<td>교수_01</td>
			</tr>
		</tbody>
	</table>

	<h3>활동내역서 미작성건</h3>
	<table class="type-2">
		<colgroup>
			<col width="50px" />
			<col width="*" />
			<col width="60px" />
			<col width="90px" />
			<col width="90px" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>훈련 과정명</th>
				<th>월</th>
				<th>기업현장교사</th>
				<th>HRD담당자</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미작성</td>
				<td>작성</td>
			</tr>
			<tr>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미작성</td>
				<td>작성</td>
			</tr>
			<tr>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미작성</td>
				<td>작성</td>
			</tr>
		</tbody>
	</table>

	<h3 class="mt-030">주간훈련일지 미제출건</h3>
	<table class="type-2">
		<colgroup>
			<col width="50px" />
			<col width="*" />
			<col width="60px" />
			<col width="90px" />
			<col width="90px" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>훈련 과정명</th>
				<th>주차</th>
				<th>OJT</th>
				<th>Off-JT</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미제출</td>
				<td>제출작성</td>
			</tr>
			<tr>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미제출</td>
				<td>제출작성</td>
			</tr>
			<tr>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미제출</td>
				<td>제출작성</td>
			</tr>
		</tbody>
	</table>

	<h3 class="mt-030">주차별 학습활동서 미제출건</h3>
	<table class="type-2">
		<colgroup>
			<col width="50px" />
			<col width="50px" />
			<col width="*" />
			<col width="60px" />
			<col width="110px" />
			<col width="90px" />
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" name="" value="" class="choice" /></th>
				<th>번호</th>
				<th>훈련 과정명</th>
				<th>주차</th>
				<th>OJT</th>
				<th>Off-JT</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="checkbox" name="" value="" class="choice" /></td>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미제출 (2/5)</td>
				<td>제출작성</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="" value="" class="choice" /></td>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미제출 (2/5)</td>
				<td>제출작성</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="" value="" class="choice" /></td>
				<td>1</td>
				<td class="left"><a href="#!" class="text">훈련과정명_01</a></td>
				<td>9</td>
				<td>미제출 (2/5)</td>
				<td>제출작성</td>
			</tr>
		</tbody>
	</table>

	<div class="btn-area align-right mt-010">
		<a href="#!" class="gray-1">SMS 발송</a>
	</div>
</div>

</c:when>
</c:choose>

</form>
