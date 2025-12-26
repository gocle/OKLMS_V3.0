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
<script type="text/javascript">
<!--
var jsonObj = eval('${lms:objectToJson(popupList)}');
PopupOpenerAPI.dataList = jsonObj;
PopupOpenerAPI.contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
	//팝업 알림.
	for (var i=0; i < PopupOpenerAPI.dataList.length; i++) {
		var popup = PopupOpenerAPI.dataList[i];
		PopupOpenerAPI.open(popup, true);
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
//-->
</script>

<form name="frmMainPage" id="frmMainPage" method="post">
<input type="hidden" name="nowDay" id="nowDay" >
<!-- HRD전담자 -->
<div class="half-left-area">
	<h3>OOO 훈련현황</h3>
	<div class="table-responsive">
		<table class="type-3 w640">
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th>실시연도</th>
					<th>과정명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>2020</td>
					<td><a href="">2019년도_대학연계형_BBB_L5_ver.2.0_기업명</a></td>
				</tr>
				<tr class="on">
					<td>2019</td>
					<td><a href="">2019년도_대학연계형_BBB_L5_ver.2.0_기업명</a></td>
				</tr>
				<tr>
					<td>2019</td>
					<td><a href="">2019년도_대학연계형_BBB_L5_ver.2.0_기업명</a></td>
				</tr>
				<tr>
					<td>20108</td>
					<td><a href="">2019년도_대학연계형_BBB_L5_ver.2.0_기업명</a></td>
				</tr>
				<tr>
					<td>2018</td>
					<td><a href="">2019년도_대학연계형_BBB_L5_ver.2.0_기업명</a></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="half-right-area">
	<h3>과정별 훈련현황</h3>
	<div class="compnay_year mt-000"><span>진행학기</span>2020학년도 1학기</div>
	<div class="company_view">
		<table class="type-2 wp100">
			<colgroup>
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th>과목명</th>
					<th>OJT/Off-JT</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="">기계공학설계1</a></td>
					<td>OJT</td>
				</tr>
				<tr class="on">
					<td>기업명</td>
					<td><a href="">과정명</a></td>
				</tr>
				<tr>
					<td>기업명</td>
					<td><a href="">과정명</a></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="clearfix"></div>
<div class="full-area bdb0 mt-040">
	<h3>교과목 상세보기</h3>
	
	<div class="training-info">
		 <div class="txt-box">
			<dl class="week">
				<dt><span class="en">학과</span></dt>
				<dd>기계설계공학과</dd>
			</dl>
			
			<dl class="mgnone">
				<dt>진행학기</dt>
				<dd>2019학견도 1학기</dd>
			</dl>
			<dl>
				<dt>교과목명</dt>
				<dd>정역학</dd>
			</dl>
			<dl>
				<dt>OJT/Off-JT</dt>
				<dd>Off-JT</dd>
			</dl>
		</div>
	</div>
	
	<div class="table-responsive mt-010">
		<table class="type-2">
			<colgroup>
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th>학번</th>
					<th>학습근로자명</th>
					<th>학습일지등록현황</th>
					<th>학습활동서작성현황</th>
					<th>내부평가현황</th>
					<th>성적</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>123456</td>
					<td>홍길동</td>
					<td><a href="">3주차</a></td>
					<td><a href="">2주차</a></td>
					<td><a href="" class="btn-line-orange">승인대기</a></td>
					<td>A</td>
				</tr>
				<tr>
					<td>123456</td>
					<td>홍길동</td>
					<td><a href="">3주차</a></td>
					<td><a href="">2주차</a></td>
					<td><a href="" class="btn-line-blue">승인</a></td>
					<td>A</td>
				</tr>
				<tr>
					<td>123456</td>
					<td>홍길동</td>
					<td><a href="#!" class="btn btn-primary btn-md">등록</a></td>
					<td><a href="">2주차</a></td>
					<td><a href="" class="btn-line-blue">승인</a></td>
					<td>A</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>	
	
	
	
<%-- 	
	<div class="half-left-area mt-100">
	<h3>TODAY</h3>
	<table class="type-3" style="table-layout:fixed;">
		<thead>
			<tr>
				<th>활동내역서<br />작성</th>
				<th>주간 훈련일지<br />미제출</th>
				<!-- <th>주차별 학습활동서<br />미제출</th> -->
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_1"><span>${readTodayCnt[0].myPageTodayCnt1}</span></a>건</td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_2"><span>${readTodayCnt[0].myPageTodayCnt2}</span></a>건</td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_3"><span>${readTodayCnt[0].myPageTodayCnt3}</span></a>건</td>
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
		
		 
		<c:forEach var="result" items="${listLmsUserMainPageStatusCnt}" varStatus="status">
			<tr>
				<td rowspan="2" class="left"> ${result.hrdTraningName }</td>
				<td>${result.schoolYear } 학년</td>
				<td>${result.stuCnt } 명</td>
				<td>${result.outCnt } 명</td>
			</tr>		
		</c:forEach>
		<c:if test="${ empty listLmsUserMainPageStatusCnt}">
			<tr>
				<td colspan="4">강의가 없습니다.</td>
			</tr>					 
		 </c:if> 
		</tbody>
	</table>
</div>

<div class="full-area">

	<div class="daily-schedule">
		<a href="#!" class="btn-pre" onclick="javascript:fn_searchDay('${yesDay}');" >이전</a> ${nowDay} <c:if test="${not empty nowDayName }"> (${nowDayName })</c:if><a href="#!"  onclick="javascript:fn_searchDay('${tomDay}');"  class="btn-next">다음</a>
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
		 
		
		<c:forEach var="result" items="${listLectureScheduleCcm}" varStatus="status">
			<tr>
				<td>
				<c:if test="${not empty result.traningStHour}"> 
					${result.traningStHour}:${result.traningStMin} ~ ${result.traningEdHour}:${result.traningEdMin}
				</c:if>
				</td>
				<td>${result.schoolYear}</td>
				<td class="left">${result.hrdTraningName}</td>
				<td>${result.subjectTraningType}</td>
				
				<td class="left">${result.subjectName}</td>
				<td>${result.subClass}</td>
				<td>${result.memberCotName}</td>
				<td>${result.memberPrtName}</td>
			</tr>	
		</c:forEach>
		<c:if test="${ empty listLectureScheduleCcm}">
			<tr>
				<td colspan="8">강의가 없습니다.</td>
			</tr>					 
		 </c:if> 
		 
		</tbody>
	</table>

 
</div>
 --%>
</form>
