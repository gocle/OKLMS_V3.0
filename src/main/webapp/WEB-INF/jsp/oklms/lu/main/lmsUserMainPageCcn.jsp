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


//페이지 이동
function goNoteOrderBy(orderValue,orderType){
	$("#noteOrderValue").val(orderValue);
	$("#noteOrderType").val(orderType);
	$("#frmMainPage").attr("action", "/lu/main/lmsUserMainPage.do");
	$("#frmMainPage").attr("target","_self");
	$("#frmMainPage").submit();	
}

function goActOrderBy(orderValue,orderType){
	$("#actOrderValue").val(orderValue);
	$("#actOrderType").val(orderType);
	$("#frmMainPage").attr("action", "/lu/main/lmsUserMainPage.do");
	$("#frmMainPage").attr("target","_self");
	$("#frmMainPage").submit();	
}

//페이지 이동
function fn_search(){
	$("#frmMainPage").attr("action", "/lu/main/lmsUserMainPage.do");
	$("#frmMainPage").attr("target","_self");
	$("#frmMainPage").submit();	
}
</script>


<form name="frmMainPage" id="frmMainPage" method="post">
	<input type="hidden" id="noteOrderValue" name="noteOrderValue" /> 
	<input type="hidden" id="noteOrderType" name="noteOrderType" />
	<input type="hidden" id="actOrderValue" name="actOrderValue" /> 
	<input type="hidden" id="actOrderType" name="actOrderType" />
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
			<caption>실년도 기업체수 담당학습근로자수 중도탈락자수에 대한 정보 제공</caption>
			<colgroup>
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">실시년도</th>
					<th scope="col">기업체수</th>
					<th scope="col">담당학습근로자수</th>
					<th scope="col">중도탈락자수</th>
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
						<td><a href="/lu/subject/listCompanyCcn.do?searchSchoolYear=${ result.schoolYear}">${ result.schoolYear}</a></td>
						<td><a href="/lu/subject/listCompanyCcn.do?searchSchoolYear=${ result.schoolYear}">${ result.companyCnt}</a></td>
						<td><a href="/lu/member/listStdMember.do?searchSchoolYear=${ result.schoolYear}">${ result.allStudentCnt}명</a></td>
						<td><a href="/lu/member/listStdInfo.do?searchOutYear=${ result.schoolYear}">${ result.dropoutCnt}명</a></td>
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

<!-- 공지사항 -->
<%-- <div class="half-right-area">
	<h3 class="notice-tit">
		공지사항
		<a href="/lu/cop/bbs/BBSMSTR_000000000000/selectBoardList.do"><i class="xi-plus"></i></a>
	</h3>
	<ul class="notice-list">
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
	</ul>
</div> --%>
<div class="half-right-area">
		<h3 class="notice-tit">
			공지사항
			<a href="#!" onclick="fn_board_list('BBSMSTR_000000000000');" title="더 보기"><i class="xi-plus"></i><span class="hidden">공지사항 더보기</span></a>
		</h3>
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
<!-- //공지사항 -->


<div class="clearfix"></div>
<div class="full-area bdb0 mt-040">



	<h3>훈련일지 2주 이상 미작성 기업</h3>
	<div class="table-responsive mt-010">

		<div class="search-box-1 mb-020">
			<label for="noteSearchKeyword" class="hidden">기업명 입력</label>
			<input type="text" id="noteSearchKeyword" name="noteSearchKeyword" value="${param.noteSearchKeyword}" maxlength="35" placeholder="기업명 입력" onkeypress="javascript:fn_search();">
			<a href="#fn_search" onclick="javascript:fn_search(); return false" onkeypress="this.onclick;">검색</a>
		</div>
		<table class="type-2">
			<colgroup>
				<col width="6%" />
				<col width="*" />
				<col width="10%" />
				<col width="20%" />
				<col width="8%" />
				<col width="8%" />
				<col width="12%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">No</th>
					<th scope="col">기업명&nbsp;&nbsp;<a href="javascript:goNoteOrderBy('COMPANY_NAME','DESC');">▼</a><a href="javascript:goNoteOrderBy('COMPANY_NAME','ASC');">▲</a></th>
					<th scope="col">교과목 구분&nbsp;&nbsp;<a href="javascript:goNoteOrderBy('SUBJECT_TRANING_TYPE_NAME','DESC');">▼</a><a href="javascript:goNoteOrderBy('SUBJECT_TRANING_TYPE_NAME','ASC');">▲</a></th>
					<th scope="col">교과목명&nbsp;&nbsp;<a href="javascript:goNoteOrderBy('SUBJECT_NAME','DESC');">▼</a><a href="javascript:goNoteOrderBy('SUBJECT_NAME','ASC');">▲</a></th>
					<th scope="col">담당교수&nbsp;&nbsp;<a href="javascript:goNoteOrderBy('INS_NAMES','DESC');">▼</a><a href="javascript:goNoteOrderBy('INS_NAMES','ASC');">▲</a></th>
					<th scope="col">기업현장교사&nbsp;&nbsp;<a href="javascript:goNoteOrderBy('TUT_NAMES','DESC');">▼</a><a href="javascript:goNoteOrderBy('TUT_NAMES','ASC');">▲</a></th>
					<th scope="col">현장교사연락처&nbsp;&nbsp;<a href="javascript:goNoteOrderBy('TUT_HP_NOS','DESC');">▼</a><a href="javascript:goNoteOrderBy('TUT_HP_NOS','ASC');">▲</a></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${listLmsUserMainPageCcnNote}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td><a href="/lu/traningstatus/listCompanyTraningProcessCcn.do?year=${result.year}&searchTraningProcess=${result.traningProcessId}|${result.companyId}|${result.traningProcessManageId}&searchYyyy=${result.yyyy}&searchTerm=${result.term}&searchSubjectCode=${result.subjectCode}&searchSubjectClass=${result.subjectClass}">${result.companyName}</a></td>
						<td>${result.subjectTraningTypeName}</td>
						<td>${result.subjectName}</td>
						<td>${result.insNames}</td>
						<td>${result.tutNames}</td>
						<td>${result.tutHpNos}</td>
					</tr>
				</c:forEach>	
			</tbody>
		</table>
	</div>



	
	<h3 class="mt-040">학습활동서 2주 이상 미작성 기업</h3>
	<div class="table-responsive mt-010">
		<div class="search-box-1 mb-020">
			<label for="noteSearchKeyword" class="hidden">기업명 입력</label>
			<input type="text" id="actSearchKeyword" name="actSearchKeyword" value="${param.actSearchKeyword}" maxlength="35" placeholder="기업명 입력" onkeypress="javascript:fn_search();">
			<a href="#fn_search" onclick="javascript:fn_search(); return false" onkeypress="this.onclick;">검색</a>
		</div>
		<table class="type-2">
			<colgroup>
				<col width="6%" />
				<col width="*" />
				<col width="10%" />
				<col width="20%" />
				<col width="8%" />
				<col width="8%" />
				<col width="12%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">No</th>
					<th scope="col">기업명&nbsp;&nbsp;<a href="javascript:goActOrderBy('COMPANY_NAME','DESC');">▼</a><a href="javascript:goActOrderBy('COMPANY_NAME','ASC');">▲</a></th>
					<th scope="col">교과목 구분&nbsp;&nbsp;<a href="javascript:goActOrderBy('SUBJECT_TRANING_TYPE_NAME','DESC');">▼</a><a href="javascript:goActOrderBy('SUBJECT_TRANING_TYPE_NAME','ASC');">▲</a></th>
					<th scope="col">교과목명&nbsp;&nbsp;<a href="javascript:goActOrderBy('SUBJECT_NAME','DESC');">▼</a><a href="javascript:goActOrderBy('SUBJECT_NAME','ASC');">▲</a></th>
					<th scope="col">담당교수&nbsp;&nbsp;<a href="javascript:goActOrderBy('INS_NAMES','DESC');">▼</a><a href="javascript:goActOrderBy('INS_NAMES','ASC');">▲</a></th>
					<th scope="col">기업현장교사&nbsp;&nbsp;<a href="javascript:goActOrderBy('TUT_NAMES','DESC');">▼</a><a href="javascript:goActOrderBy('TUT_NAMES','ASC');">▲</a></th>
					<th scope="col">현장교사연락처&nbsp;&nbsp;<a href="javascript:goActOrderBy('TUT_HP_NOS','DESC');">▼</a><a href="javascript:goActOrderBy('TUT_HP_NOS','ASC');">▲</a></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${listLmsUserMainPageCcnAct}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td><a href="/lu/traningstatus/listCompanyTraningProcessCcn.do?searchTab=act&year=${result.year}&searchTraningProcess=${result.traningProcessId}|${result.companyId}|${result.traningProcessManageId}&searchYyyy=${result.yyyy}&searchTerm=${result.term}&searchSubjectCode=${result.subjectCode}&searchSubjectClass=${result.subjectClass}">${result.companyName}</a></td>
						<td>${result.subjectTraningTypeName}</td>
						<td>${result.subjectName}</td>
						<td>${result.insNames}</td>
						<td>${result.tutNames}</td>
						<td>${result.tutHpNos}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</div>
</form>
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

