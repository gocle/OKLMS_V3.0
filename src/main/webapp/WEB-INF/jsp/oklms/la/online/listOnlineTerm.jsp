<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<c:set var="targetUrl" value="/la/online/"/>

<c:set var="weekLen" value="0"/>
	
<c:choose>
	<c:when test="${param.term eq '1' or param.term eq '2'}">
		<c:set var="weekLen" value="15"/>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${param.onlineType eq '101'}">
				<c:set var="weekLen" value="4"/>
			</c:when>
			<c:otherwise>
				<c:set var="weekLen" value="5"/>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>


<script type="text/javascript">

	var targetUrl = "${targetUrl}";

	$(document).ready(function() {
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
		
		com.datepickerDateFormat('startDate', 'button');
		com.datepickerDateFormat('endDate', 'button');

//         com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search(  ){
		
		if($("#yyyy").val() == ""){
			alert("학년도 선택은 필수사항입니다.");
			$("#yyyy").focus();
			return;
		}
		if($("#term").val() == ""){
			alert("학기 선택은 필수사항입니다.");
			$("#term").focus();
			return;		
		}
		if($("#onlineType").val() == ""){
			alert("온라인형태 선택은 필수사항입니다.");
			$("#onlineType").focus();
			return;	
		}
			
		var reqUrl = "/la/term/listOnlineTerm.do";
		$("#frmStand").attr("action", reqUrl);
		$("#frmStand").attr("target","_self");
		$("#frmStand").submit();
	}
	
	
	
	function fn_dateInit(id){
		$("#"+id).val("");
	}
	
	
function fn_saveOnStand() { 
		
		var startDate 			= $("#startDate").val().split(".").join("");
		var endDate 			= $("#endDate").val().split(".").join("");
		var attendProgress = $("#attendProgress").val();
		var cutProgress 		= $("#cutProgress").val();
		
		if($("#yyyy").val() == ""){
			alert("학년도 선택은 필수사항입니다.");
			$("#yyyy").focus();
			return;
		}
		if($("#term").val() == ""){
			alert("학기 선택은 필수사항입니다.");
			$("#term").focus();
			return;		
		}
		if($("#onlineType").val() == ""){
			alert("온라인형태 선택은 필수사항입니다.");
			$("#onlineType").focus();
			return;	
		}
		
		
		if(startDate == ""){
			alert("[시작일]은 반드시 선택해야 합니다.");	
			$("#startDate").focus();
			return;
		} 
		
		if(endDate == ""){
			alert("[종료일]은 반드시 선택해야 합니다.");
			$("#endDate").focus();
			return;
		}	
		
		if(Number(startDate) > Number(endDate)){
			alert("[시작일]이 [종료일]보다 클 수 없습니다.");
			$("#endDate").focus();
			return;
		}
		
		if(!$('input:radio[name=weekStudyType]').is(':checked')){
			alert("[주차 학습기간]은 반드시 선택해야 합니다.");
			$("#weekStudyType1").focus();
			return;
		} else {
			if($('input:radio[name="weekStudyType"]:checked').val()  == "WEEK"){
				if($('#weekStudy').val() == ""){
					alert("[주차]는 반드시 선택해야 합니다.");
					$("#weekStudy").focus();
					return;
				}
			}
		}
		
		if(attendProgress == ""){
			alert("[출석 진도율]은 반드시 선택해야 합니다.");
			$("#attendProgress").focus();
			return;
		}
		
		if(cutProgress == ""){
			alert("[결석 진도율]은 반드시 선택해야 합니다.");
			$("#cutProgress").focus();
			return;
		}
		
		if(!$('input:radio[name=progressAttendTypeCode]').is(':checked')){
			alert("[진도방식]은 반드시 선택해야 합니다.");
			$("#progressAttendTypeCode1").focus();
			return;
		}
		
		if(confirm("학기별 온라인훈련 기준정보를 저장 하시겠습니까?")){
			var reqUrl = "/la/term/saveOnlineTermStand.do";
			$("#frmStand").attr("action", reqUrl);
			$("#frmStand").attr("target","_self");
			$("#frmStand").submit();
		}
	} 
	
	
function fn_saveOnSchedule(){
	
	if($("#yyyy").val() == ""){
		alert("학년도 선택은 필수사항입니다.");
		$("#yyyy").focus();
		return;
	}
	if($("#term").val() == ""){
		alert("학기 선택은 필수사항입니다.");
		$("#term").focus();
		return;		
	}
	if($("#onlineType").val() == ""){
		alert("온라인형태 선택은 필수사항입니다.");
		$("#onlineType").focus();
		return;	
	}
	
	if(confirm("학기별 온라인훈련 기간을 저장 하시겠습니까?")){
		var reqUrl = CONTEXT_ROOT + "/la/term/saveOnlineTermWeek.do";
		$("#frmStand").attr("action", reqUrl);
		$("#frmStand").attr("target","_self");
		$("#frmStand").submit();
	}
}
	
</script>


<form id="frmStand" name="frmStand" method="post">	
<ul class="search-list-1">
	<li>
		<span>학년도 / 학기 / 훈련방식</span>&nbsp;&nbsp;&nbsp;

<select name="yyyy" id="yyyy" style="width: 120px; margin-right: 10px;"> 
	<option value="" >학년도-전체</option>
	<c:forEach var="i" begin="0" end="3" step="1">
		<option value="${nowYear-i+1}" <c:if test="${param.yyyy eq nowYear-i+1 }" > selected="selected"  </c:if>>${nowYear-i+1}학년도</option>
	</c:forEach>								
</select> 
		
	 
		&nbsp;&nbsp;&nbsp;
		<select name="term" id="term" style="width: 100px; margin-right: 10px;" onchange="fn_search();">
			<option value="">학기-선택</option>
			<option value="1" <c:if test="${param.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
			<option value="2" <c:if test="${param.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
			<option value="3" <c:if test="${param.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
			<option value="4" <c:if test="${param.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
		</select>
		&nbsp;&nbsp;&nbsp;
		<select name="onlineType" id="onlineType" style="width: 120px; margin-right: 10px;" onchange="fn_search();">
			<option value="">온라인형태-선택</option>
			<option value="101" <c:if test="${param.onlineType eq '101' }" > selected="selected"  </c:if>>순수온라인</option>
			<option value="104" <c:if test="${param.onlineType eq '104' }" > selected="selected"  </c:if>>플립</option>
		</select>
	</li>
</ul><!-- E : search-list-1 -->	
	<div class="search-btn-area">
		<a onkeypress="this.onclick;" onclick="javascript:fn_search(); return false" href="#fn_search">조회</a>
	</div>

<br/><br/>




	<c:if test="${!empty param.yyyy and !empty param.term and !empty param.onlineType}">
			
		<table border="0" cellpadding="0" cellspacing="0" class="view-1">
			<colgroup>
				<col style="width:110px" />
				<col style="width:*" />
			</colgroup>
			<tbody>
				<tr>
					<th>학습기간</th>
					<td>
						- 전체 학습기간 : 
						<input type="text" name="startDate" id="startDate" value="${onlineTraningVO.startDate}" readonly="readonly" style="width:65px;" /> ~<input type="text"name="endDate" id="endDate" value="${onlineTraningVO.endDate}" readonly="readonly" style="width:65px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						- 주차 학습기간 : 
						<input type="radio" name="weekStudyType"  id="weekStudyType1" ${onlineTraningVO.weekStudyType eq 'WEEK' ? 'checked' : ''}  class="choice" value="WEEK"/> 
						<select name="weekStudy" id="weekStudy">
							<option value="">선택</option>
							<option value="1" ${onlineTraningVO.weekStudy eq '1' ? 'selected' : ''}>1 주</option>
							<option value="2" ${onlineTraningVO.weekStudy eq '2' ? 'selected' : ''}>2 주</option>
						</select>&nbsp;&nbsp;&nbsp;
						<input type="radio" name="weekStudyType"  id="weekStudyType2" ${onlineTraningVO.weekStudyType eq 'FREE' ? 'checked' : ''} class="choice" value="FREE"/> FREE
					</td>
				</tr>
				<tr>
					<th>출석기준</th>
					<td>
						- 출석 : 진도율&nbsp;&nbsp;
						<select name="attendProgress" id="attendProgress">
							<option value="">선택</option>
							<option value="100" ${onlineTraningVO.attendProgress eq '100' ? 'selected' : ''}>100</option>
							<option value="95" ${onlineTraningVO.attendProgress eq '95' ? 'selected' : ''}>95</option>
							<option value="90" ${onlineTraningVO.attendProgress eq '90' ? 'selected' : ''}>90</option>
							<option value="85" ${onlineTraningVO.attendProgress eq '85' ? 'selected' : ''}>85</option>
							<option value="80" ${onlineTraningVO.attendProgress eq '80' ? 'selected' : ''}>80</option>
							<option value="75" ${onlineTraningVO.attendProgress eq '75' ? 'selected' : ''}>75</option>
							<option value="70" ${onlineTraningVO.attendProgress eq '70' ? 'selected' : ''}>70</option>
							<option value="65" ${onlineTraningVO.attendProgress eq '65' ? 'selected' : ''}>65</option>
							<option value="60" ${onlineTraningVO.attendProgress eq '60' ? 'selected' : ''}>60</option>
							<option value="55" ${onlineTraningVO.attendProgress eq '55' ? 'selected' : ''}>55</option>
							<option value="50" ${onlineTraningVO.attendProgress eq '50' ? 'selected' : ''}>50</option>
							<option value="45" ${onlineTraningVO.attendProgress eq '45' ? 'selected' : ''}>45</option>
							<option value="40" ${onlineTraningVO.attendProgress eq '40' ? 'selected' : ''}>40</option>
							<option value="35" ${onlineTraningVO.attendProgress eq '35' ? 'selected' : ''}>35</option>
							<option value="30" ${onlineTraningVO.attendProgress eq '30' ? 'selected' : ''}>30</option>
							<option value="25" ${onlineTraningVO.attendProgress eq '25' ? 'selected' : ''}>25</option>
							<option value="20" ${onlineTraningVO.attendProgress eq '20' ? 'selected' : ''}>20</option>
							<option value="15" ${onlineTraningVO.attendProgress eq '15' ? 'selected' : ''}>15</option>
							<option value="10" ${onlineTraningVO.attendProgress eq '10' ? 'selected' : ''}>10</option>
						</select> 이상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						- 결석 : 진도율&nbsp;&nbsp;
						<select name="cutProgress" id="cutProgress">
							<option value="">선택</option>
							<option value="95" ${onlineTraningVO.cutProgress eq '95' ? 'selected' : ''}>95</option>
							<option value="90" ${onlineTraningVO.cutProgress eq '90' ? 'selected' : ''}>90</option>
							<option value="85" ${onlineTraningVO.cutProgress eq '85' ? 'selected' : ''}>85</option>
							<option value="80" ${onlineTraningVO.cutProgress eq '80' ? 'selected' : ''}>80</option>
							<option value="75" ${onlineTraningVO.cutProgress eq '75' ? 'selected' : ''}>75</option>
							<option value="70" ${onlineTraningVO.cutProgress eq '70' ? 'selected' : ''}>70</option>
							<option value="65" ${onlineTraningVO.cutProgress eq '65' ? 'selected' : ''}>65</option>
							<option value="60" ${onlineTraningVO.cutProgress eq '60' ? 'selected' : ''}>60</option>
							<option value="55" ${onlineTraningVO.cutProgress eq '55' ? 'selected' : ''}>55</option>
							<option value="50" ${onlineTraningVO.cutProgress eq '50' ? 'selected' : ''}>50</option>
							<option value="45" ${onlineTraningVO.cutProgress eq '45' ? 'selected' : ''}>45</option>
							<option value="40" ${onlineTraningVO.cutProgress eq '40' ? 'selected' : ''}>40</option>
							<option value="35" ${onlineTraningVO.cutProgress eq '35' ? 'selected' : ''}>35</option>
							<option value="30" ${onlineTraningVO.cutProgress eq '30' ? 'selected' : ''}>30</option>
							<option value="25" ${onlineTraningVO.cutProgress eq '25' ? 'selected' : ''}>25</option>
							<option value="20" ${onlineTraningVO.cutProgress eq '20' ? 'selected' : ''}>20</option>
							<option value="15" ${onlineTraningVO.cutProgress eq '15' ? 'selected' : ''}>15</option>
							<option value="10" ${onlineTraningVO.cutProgress eq '10' ? 'selected' : ''}>10</option>
						</select> 미만&nbsp;&nbsp;&nbsp;
						(※사이 구간은 지각 처리)
					</td>
				</tr>
				<tr>
					<th>학점기준</th>
					<td>
						<select name="scheduleTime" id="scheduleTime">
							<option value="25" ${onlineTraningVO.scheduleTime eq '25' ? 'selected' : ''}>25</option>
							<option value="30" ${onlineTraningVO.scheduleTime eq '30' ? 'selected' : ''}>30</option>
							<option value="35" ${onlineTraningVO.scheduleTime eq '35' ? 'selected' : ''}>35</option>
							<option value="40" ${onlineTraningVO.scheduleTime eq '40' ? 'selected' : ''}>40</option>
							<option value="45" ${onlineTraningVO.scheduleTime eq '45' ? 'selected' : ''}>45</option>
							<option value="50" ${onlineTraningVO.scheduleTime eq '50' ? 'selected' : ''}>50</option>
							<option value="55" ${onlineTraningVO.scheduleTime eq '55' ? 'selected' : ''}>55</option>
							<option value="60" ${onlineTraningVO.scheduleTime eq '60' ? 'selected' : ''}>60</option>
						</select> 분 이상
					</td>
				</tr>
				<tr>
					<th>진도율 계산방식</th>
					<td>
						<input type="radio" name="progressAttendTypeCode" id="progressAttendTypeCode1" value="H" ${onlineTraningVO.progressAttendTypeCode eq 'H' ? 'checked' : ''}  class="choice" /> 시간+페이지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="progressAttendTypeCode" id="progressAttendTypeCode2" value="T" ${onlineTraningVO.progressAttendTypeCode eq 'T' ? 'checked' : ''}  class="choice" /> 시간&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="progressAttendTypeCode" id="progressAttendTypeCode3" value="P" ${onlineTraningVO.progressAttendTypeCode eq 'P' ? 'checked' : ''}  class="choice" /> 페이지
					</td>
				</tr>
			<tbody>
		</table>
	<div class="page-btn">
		<a onclick="javascript:fn_saveOnStand();" href="#fn_saveOnStand">설정 저장</a>
	</div>
	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<thead>
			<tr>
				<th width="4%">주차</th>
				<th width="4%">주차시작일</th>
				<th width="4%">주차종료일</th>
			</tr>
		</thead>
		<tbody>
		
			<c:forEach begin="1" end="${weekLen}" step="1" varStatus="status">
				<tr>
					<td>
					${status.count} 주차
					<input type="hidden" name="weekCnts" id="weekCnt${status.count}" value="${status.count}"/>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty resultList}">
								<input type="text" name="weekStDates" id="weekStDate${status.count}" value=""  style="width:80px" readonly />  &nbsp;<a href="#fn_dateInit()" onclick="javascript:fn_dateInit('weekStDate${status.count}');"  class="btn-1">초기화</a>
							</c:when>
							<c:otherwise>
								<c:forEach var="result" items="${resultList}" varStatus="status1">
									<c:if test="${status.count eq result.weekCnt}">
										<input type="text" name="weekStDates" id="weekStDate${result.weekCnt}" value="${result.weekStDate}"  style="width:80px" readonly />  &nbsp;<a href="#fn_dateInit()" onclick="javascript:fn_dateInit('weekStDate${result.weekCnt}');"  class="btn-1">초기화</a>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty resultList}">
								<input type="text" name="weekEdDates" id="weekEdDate${status.count}" value="" style="width:80px" readonly />  &nbsp;<a href="#fn_dateInit()" onclick="javascript:fn_dateInit('weekEdDate${status.count}');"  class="btn-1">초기화</a>
							</c:when>
							<c:otherwise>
								<c:forEach var="result" items="${resultList}" varStatus="status1">
									<c:if test="${status.count eq result.weekCnt}">
										<input type="text" name="weekEdDates" id="weekEdDate${result.weekCnt}" value="${result.weekEdDate}" style="width:80px" readonly />  &nbsp;<a href="#fn_dateInit()" onclick="javascript:fn_dateInit('weekEdDate${result.weekCnt}');"  class="btn-1">초기화</a>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table><!-- E : list -->
	
	<div class="page-btn">
		<a onclick="javascript:fn_saveOnSchedule();" href="#fn_saveOnSchedule">주차정보 저장</a>
	</div>
</form>	
</c:if>
					
<script>
<c:choose>
	<c:when test="${empty resultList}">
		<c:forEach var="result"  begin="1" end="${weekLen}" step="1" varStatus="status">
			com.datepickerDateFormat("weekStDate${status.count}" , 'button');
			com.datepickerDateFormat("weekEdDate${status.count}" , 'button');
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			com.datepickerDateFormat("weekStDate${status.count}" , 'button');
			com.datepickerDateFormat("weekEdDate${status.count}" , 'button');
		</c:forEach>
	</c:otherwise>
	</c:choose>

</script>
	