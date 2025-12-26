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

var jsonObj = eval('${lms:objectToJson(popupList)}');
PopupOpenerAPI.dataList = jsonObj;
PopupOpenerAPI.contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
	//팝업 알림.
	for (var i=0; i < PopupOpenerAPI.dataList.length; i++) {
		var popup = PopupOpenerAPI.dataList[i];
		PopupOpenerAPI.open(popup, true);
	}
	
	$( "#table_1  tr" ).click(function() {
		  $( "#table_1  tr" ).removeClass("on");
		  //$(this).addClass("on");
		});
	$( "#subject_body tr" ).click(function() {
		alert(2);
		$( "#subject_body  tr" ).removeClass("on");
		//$(this).addClass("on");
	}); 
	
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

function fn_subject(traningProcessId, companyId , yyyy, term, subjectCode, subjectClass, termName){
	var html = "";
	var reqUrl = "/lu/main/listSubject.json";
	var param = { "traningProcessId" : traningProcessId, "companyId" : companyId , "yyyy" : yyyy, "term" : term, "subjectCode" : subjectCode, "subjectClass" : subjectClass};
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
	if (200 == jqXHR.status ) {
		//com.alert( jqXHR.responseJSON.retMsg );
		
		var listSubjectCot= jqXHR.responseJSON.listSubjectCot;
		
		$("#now_term").html('<span>진행학기</span>'+yyyy+"학년도 "+termName);
		
		for (var i = 0; i < listSubjectCot.length; i++) {
			html += "<tr>";
			html += "	<td><a href='javascript:fn_std( \""+listSubjectCot[i].yyyy+"\", \""+listSubjectCot[i].term+"\", \""+listSubjectCot[i].subjectCode+"\", \""+listSubjectCot[i].subjectClass+"\", \""+listSubjectCot[i].subjectName+"\", \""+listSubjectCot[i].termName+"\", \""+listSubjectCot[i].subjectTraningType+"\", \""+listSubjectCot[i].departmentName+"\");''>"+listSubjectCot[i].subjectName+"</a></td>";
			html += "	<td>"+listSubjectCot[i].subjectTraningType+"</td>";
			html += "</tr>";
		}
		
		$("#subject_body").empty();
		$("#subject_body").append(html);
		
	} else {
		alert("교과정보를 읽어오는대 실패했습니다.")
	}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	});
}
function fn_std(yyyy,term,subjectCode,subjectClass,subjectName,termName,subjectTraningType,departmentName){
	$("#subject_term").html(yyyy+" 학년도 "+termName);
	$("#subject_name").html(subjectName);
	$("#subject_type").html(subjectTraningType);
	$("#subject_departmentName").html(departmentName);
	
	var html = "";
	var reqUrl = "/lu/main/listSubjectStd.json";
	var param = { "yyyy" : yyyy, "term" : term , "subjectCode" : subjectCode, "subjectClass" : subjectClass };
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
	if (200 == jqXHR.status ) {
		//com.alert( jqXHR.responseJSON.retMsg );
		
		var listSubjectStd = jqXHR.responseJSON.listSubjectStd;
		
		/* 
		var maxWeekNoteCnt = listSubjectStd[i].maxWeekNoteCnt;
		var maxWeekActCnt = listSubjectStd[i].maxWeekActCnt;
		var evalMStatus = listSubjectStd[i].evalMStatus;
		var evalFStatus = listSubjectStd[i].evalFStatus; 
		 */
		for (var i = 0; i < listSubjectStd.length; i++) {
			html += "<tr>";
			html += "	<td>"+listSubjectStd[i].memId+"</td>";
			html += "	<td>"+listSubjectStd[i].memName+"</td>";
			html += "	<td>"+(listSubjectStd[i].maxWeekNoteCnt == null ? '' : listSubjectStd[i].maxWeekNoteCnt+'주차')+"</td>";
			html += "	<td>"+(listSubjectStd[i].maxWeekActCnt == null ? '' : listSubjectStd[i].maxWeekActCnt+'주차')+"</td>";
			html += "	<td>"+(listSubjectStd[i].evalMStatus == undefined ? '' : listSubjectStd[i].evalMStatus)+"</td>";
			html += "	<td>"+(listSubjectStd[i].evalFStatus == undefined ? '' : listSubjectStd[i].evalFStatus)+"</td>";
			html += "	<td>"+(listSubjectStd[i].gradNm == undefined ? '' : listSubjectStd[i].gradNm)+"</td>";
			html += "</tr>";
		}
		
		/* <th>학번</th>
		<th>학습근로자명</th>
		<th>학습일지등록현황</th>
		<th>학습활동서작성현황</th>
		<th>내부평가현황</th>
		<th>성적</th> */
		
		$("#std_body").empty();
		$("#std_body").append(html);
		
	} else {
		alert("교과정보를 읽어오는대 실패했습니다.")
	}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	});
}


</script>

<form name="frmMainPage" id="frmMainPage" method="post">
<input type="hidden" name="nowDay"  id="nowDay" />
  <!-- 기업현장교사 -->

<div class="half-left-area">
	<h3>${SESSION_COMPANY_NAME} 훈련현황</h3>
	<div class="table-responsive">
		<table class="type-3 w640" id="table_1">
			<caption>실시연도 과정명에 대한 정보 제공</caption>
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">실시연도</th>
					<th scope="col">과정명</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${listLmsUserMainPageCotTraningProcess}" varStatus="status">
					<tr>
						<td><a href="javascript:fn_subject('${result.traningProcessId}','${result.companyId}','${result.yyyy},'${result.term}','${result.subjectCode}','${result.subjectClass}','${result.termName}')">${result.year}</a></td>
						<td><a href="javascript:fn_subject('${result.traningProcessId}','${result.companyId}','${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.termName}')">${result.traningProcessName}</a></td>
					</tr> 
				 </c:forEach>		
				 <c:if test="${ empty listLmsUserMainPageCotTraningProcess}">
					<tr>
						<td colspan="2">데이터가 없습니다.</td>
					</tr>					 
				 </c:if>	
			</tbody>
		</table>
	</div>
</div>

<div class="half-right-area">
	<h3>과정별 훈련현황</h3>
	<div class="compnay_year mt-000" id="now_term"></div>
	<div class="company_view">
		<table class="type-2 wp100" id="table_2">
			<caption>과목명 OJT/Off-JT에 대한 정보 제공</caption>
			<colgroup>
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">과목명</th>
					<th scope="col">OJT/Off-JT</th>
				</tr>
			</thead>
			<tbody id="subject_body">
				
				<!-- <tr>
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
				</tr> -->
			</tbody>
		</table>
	</div>
</div>

<div class="clearfix"></div>
<div class="full-area bdb0 mt-040">
	<h3>교과목 상세보기</h3>
	
	<div class="training-info">
		 <div class="txt-box">
			<dl>
				<dt><span class="en">학과</span></dt>
				<dd id="subject_departmentName"></dd>
			</dl>
			
			<dl>
				<dt>진행학기</dt>
				<dd id="subject_term"></dd>
			</dl>
			<dl>
				<dt>교과목명</dt>
				<dd id="subject_name"></dd>
			</dl>
			<dl>
				<dt>OJT/Off-JT</dt>
				<dd id="subject_type"></dd>
			</dl>
		</div>
	</div>
	
	<div class="table-responsive mt-010">
		<table class="type-2">
			<caption>학습 학습근로자명 학습일지등록현황 학습활동서작성현황 중간내부평가현황 기말내부평가현황에 대한 정보 제공</caption>
			<colgroup>
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">학번</th>
					<th scope="col">학습근로자명</th>
					<th scope="col">학습일지등록현황</th>
					<th scope="col">학습활동서작성현황</th>
					<th scope="col">내부평가현황(중간)</th>
					<th scope="col">내부평가현황(기말)</th>
					<th scope="col">성적</th>
				</tr>
			</thead>
			<tbody id="std_body">
				<!-- <tr>
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
				</tr> -->
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
				<th>훈련일지 작성</th>
				<!-- <th>학습활동서 확인</th> -->
				<th>질문과 답변</th>
				<th>면담일지 작성</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_1"><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</a></td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_2"><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</a></td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_3"><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</a></td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_4"><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</a></td>
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
		<a href="#!" class="btn-pre" onclick="javascript:fn_searchDay('${yesDay}');" >이전</a> ${nowDay} <c:if test="${not empty nowDayName }"> (${nowDayName })</c:if><a href="#!"  onclick="javascript:fn_searchDay('${tomDay}');"  class="btn-next">다음</a>
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

		 <c:forEach var="result" items="${listLectureCotSchedule}" varStatus="status">
					<tr>
						<td>${result.traningStHour}:${result.traningStMin} ~ ${result.traningEdHour}:${result.traningEdMin}</td>
						<td class="left">
<a href="#!" onclick="javascript:fn_lec_menu_display('${result.subjectTraningType}','${result.yyyy}','${result.term}','${result.subjectCode}','${result.subClass}','${result.subjectName}','${result.subjectType}','${result.onlineType}');"  class="text">${result.subjectName}</a>
						</td>
						<td>${result.schoolYear}</td>
						<td>${result.subClass}</td>
						
						<td>${result.weekCnt} / ${result.maxWeekCnt}</td>
						<td>${result.ncsUnitName} </td>
						<td>${result.memberPrtName}</td>
					</tr> 
		 </c:forEach>		
		 <c:if test="${ empty listLectureCotSchedule}">
			<tr>
				<td colspan="7">데이터가 없습니다.</td>
			</tr>					 
		 </c:if>		 
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
				<!-- <th>활동서<br />미작성</th> -->
			</tr>
		</thead>
		<tbody>
				<c:forEach var="rs" items="${listLmsUserMainPageStatusCnt }" varStatus="status">
					<tr>
					 	<td>${rs.subjectName}</td>
					 	<td>${rs.weekCnt}</td>
					 	
					 	<td>${rs.totalTime-rs.attend}</td>
					 	
						<td>
							<c:if test="${(rs.totalTime-rs.attend) < 0 }">
							0
							</c:if>
							<c:if test="${(rs.totalTime-rs.attend) > 0 }">
							${rs.totalTime-rs.attend }
							</c:if>							
						</td>					 	
				 	
					 	<td>${rs.activityNoteCnt}</td>
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
