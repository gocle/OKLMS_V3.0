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

$(document).ready(function() {

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
<!-- 센터담당자 -->

<div class="half-left-area">
	<h3>담당기업현황</h3>
	<div class="table-responsive">
		<%-- <table class="type-3 w640">
			<colgroup>
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th>실시연도</th>
					<th>기업 수</th>
					<th>과정 수</th>
					<th>학습근로자 수</th>
					<th>중도탈락자 수</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="">2016</a></td>
					<td>1</td>
					<td>1</td>
					<td>1</td>
					<td>1</td>
				</tr>
				<tr>
					<td><a href="">2017</a></td>
					<td>2</td>
					<td>2</td>
					<td>2</td>
					<td>2</td>
				</tr>
				<tr>
					<td><a href="">2018</a></td>
					<td>3</td>
					<td>3</td>
					<td>3</td>
					<td>3</td>
				</tr>
				<tr>
					<td><a href="">2019</a></td>
					<td>4</td>
					<td>4</td>
					<td>4</td>
					<td>4</td>
				</tr>
				<tr>
					<td>계</td>
					<td>10</td>
					<td>10</td>
					<td>10</td>
					<td>10</td>
				</tr>
			</tbody>
		</table> --%>
		
		<table class="type-3 w640">
			<colgroup>
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
			</colgroup>
			<thead>
				<tr>
					<th>실시년도</th>
					<th>기업체수</th>
					<th>전체학생수</th>
					<th>중도탈락자</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="totcompanyCnt" value="0"/>
				<c:set var="totallStudentCnt" value="0"/>
				<c:set var="totdropoutCnt" value="0"/> 
				<c:forEach var="result" items="${listLmsUserMainPageStatusCnt}" varStatus="status">
				
					<c:set var="totcompanyCnt" value="${ totcompanyCnt+ result.companyCnt}"/>
					<c:set var="totallStudentCnt" value="${totallStudentCnt + result.allStudentCnt}"/>
					<c:set var="totdropoutCnt" value="${totdropoutCnt+ result.dropoutCnt}"/>
					<tr>
						<td>${ result.schoolYear}</td>
						<td>${ result.companyCnt}</td>
						<td>${ result.allStudentCnt}명</td>
						<td>${ result.dropoutCnt}명</td>
					</tr>			
				</c:forEach>
				<c:if test="${!empty listLmsUserMainPageStatusCnt}">
					<tr>
						<td>계</td>
						<td>${ totcompanyCnt}</td>
						<td>${ totallStudentCnt}</td>
						<td>${ totdropoutCnt}</td>
					</tr>
				</c:if>	
	 			<c:if test="${ empty listLmsUserMainPageStatusCnt}">
					<tr>
						<td colspan="4">데이터가 없습니다.</td>
					</tr>					 
				 </c:if>
			<!-- 
				
				<tr>
					<td>계</td>
					<td>10</td>
					<td>10</td>
					<td>10</td>
					<td>10</td>
				</tr> -->
			</tbody>
		</table>
		
	</div>
</div>

<div class="clearfix"></div>
<div class="full-area bdb0 mt-040">
	<h3>전체기업현황</h3>
	<div class="table-responsive mt-010">
		<table class="type-2">
			<colgroup>
				<col width="80px" />
				<col width="*" />
				<col width="200px" />
				<col width="200px" />
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>훈련과정명</th>
					<th>기업명</th>
					<th>학습근로자수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${listTraningStatusCcn}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${result.traningProcessName}</td>
						<td>${result.companyName}</td>
						<td>${result.stuCnt}</td>
					</tr>
				</c:forEach>	
			</tbody>
		</table>
	</div>
	
	<h3 class="mt-040">기업전담자관리</h3>
	<div class="table-responsive mt-010">
		<table class="type-2">
			<colgroup>
				<col width="80px" />
				<col width="230px" />
				<col width="230px" />
				<col width="230px" />
				<col width="230px" />
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>기업현장교사</th>
					<th>HRD전담자</th>
					<th>기업명</th>
					<th>담당교과</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${listSubjectCcn}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${result.tutNames}</td>
						<td>${result.ccmNames}</td>
						<td>${result.companyName}</td>
						<td>${result.subjectName}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<%-- 
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
				<!-- <th>학습활동서<br />미제출자</th> -->
				<th>면담일지<br />미제출건</th>
				<th>훈련시간표<br />변경신청</th>
				<th>담당자<br />변경신청</th>
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

 
<div class="clearfix"></div>
<div class="full-area">
	<h3>담당기업현황</h3>
		<div class="company_area">
			<div class="table-responsive mt-010">
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
				 
				<c:forEach var="result" items="${listLmsUserMainPageStatusCnt}" varStatus="status">
					<tr>
						<td>${ result.schoolYear}학년</td>
						<td>${ result.companyCnt}</td>
						<td>${ result.allStudentCnt}명</td>
						<td>${ result.dropoutCnt}명</td>
					</tr>			
				</c:forEach>
	 			<c:if test="${ empty listLmsUserMainPageStatusCnt}">
					<tr>
						<td colspan="4">데이터가 없습니다.</td>
					</tr>					 
				 </c:if> 
				 
				</tbody>
			</table>
		</div>
	</div>
	 --%>
</div>

<div class="clearfix"></div>
<%-- 
<div class="full-area bdb0">
	<h3>금일훈련 일정</h3>

	<div class="daily-schedule">
			<a href="#!" class="btn-pre" onclick="javascript:fn_searchDay('${yesDay}');" >이전</a> ${nowDay} <c:if test="${not empty nowDayName }"> (${nowDayName })</c:if><a href="#!"  onclick="javascript:fn_searchDay('${tomDay}');"  class="btn-next">다음</a>
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
		
		<c:forEach var="result" items="${listLectureCcnSchedule}" varStatus="status">
			<tr>
				<td>${result.companyName}</td>
				<td>
					<c:if test="${not empty result.traningStHour}"> 
					${result.traningStHour}:${result.traningStMin} ~ ${result.traningEdHour}:${result.traningEdMin}
					</c:if>
				</td>
				<td>${result.schoolYear}</td>
				<td>${result.hrdTraningName}</td>
				
				<td>${result.subjectTraningType}</td>
				<td>${result.subjectName}</td>
				<td>${result.subClass}</td>
				<td>${result.memberCotName}</td>
				
				<td>${result.memberPrtName}</td>
			</tr>		
		</c:forEach>
		<c:if test="${ empty listLectureCcnSchedule}">
			<tr>
				<td colspan="9">데이터가 없습니다.</td>
			</tr>					 
		 </c:if> 
 
		</tbody>
	</table>
</div>
 --%>

</form>
