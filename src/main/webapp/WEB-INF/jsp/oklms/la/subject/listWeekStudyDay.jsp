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
<c:set var="targetUrl" value="/la/term/"/>



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
		
		com.datepickerDateFormat('traningDate', 'button');

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
		
		if($("#subjectType").val() == ""){
			alert("교과구분 선택은 필수사항입니다.");
			$("#subjectType").focus();
			return;		
		}
		
			
		var reqUrl = "/la/term/listWeekStudyDay.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();
	}
	
	
	
	function fn_dateInit(id){
		$("#"+id).val("");
	}
	
	
	
function fn_save(){
	
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
	if($("#subjectType").val() == ""){
		alert("교과구분 선택은 필수사항입니다.");
		$("#subjectType").focus();
		return;		
	}
	
	if(confirm("Off-JT 수업일자를 변경 하시겠습니까?")){
		var reqUrl = CONTEXT_ROOT + "/la/term/updateWeekStudyDay.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();
	}
}
	
</script>


<form id="frmSubject" name="frmSubject" method="post">	
<ul class="search-list-1">
	<li>
		<span>학년도 / 학기 </span>&nbsp;&nbsp;&nbsp;

<select name="yyyy" id="yyyy" style="width: 120px; margin-right: 10px;" onchange="fn_search();"> 
	<option value="" >학년도-선택</option>
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
		<select name="subjectType" id="subjectType" style="width: 100px; margin-right: 10px;" onchange="fn_search();">
			<option value="">교과구분-선택</option>
			<option value="NORMAL" <c:if test="${param.subjectType eq 'NORMAL' }" > selected="selected"  </c:if>>학부</option>
			<option value="HSKILL" <c:if test="${param.subjectType eq 'HSKILL' }" > selected="selected"  </c:if>>고숙련</option>
		</select>
	</li>
</ul><!-- E : search-list-1 -->	
	<div class="search-btn-area">
		<a onkeypress="this.onclick;" onclick="javascript:fn_search(); return false" href="#fn_search">조회</a>
	</div>

<br/><br/>




	
			
		
	
	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<thead>
			<tr>
				<th width="4%">주차</th>
				<th width="4%">수업일</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${!empty param.yyyy and !empty param.term and !empty param.subjectType}">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>
					${status.count} 주차
					<input type="hidden" name="weekCnts" id="weekCnt${status.count}" value="${status.count}"/>
					</td>
					<td>
							<input type="text" name="traningDates" id="traningDate${status.count}" value="${result.traningDate}"  style="width:80px" readonly />  &nbsp;<a href="#fn_dateInit()" onclick="javascript:fn_dateInit('traningDate${status.count}');"  class="btn-1">초기화</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty resultList}">
				<tr>
					<td colspan="2">
						<spring:message code="common.nodata.msg" />
					</td>
				</tr>
			</c:if>
		</c:if>
		<c:if test="${empty param.yyyy or empty param.term or empty param.subjectType}">
				<tr>
					<td colspan="2">
						검색 후 조회가 가능합니다.
					</td>
				</tr>
			</c:if>
		</tbody>
	</table><!-- E : list -->

	<div class="page-btn">
		<a onclick="javascript:fn_save();" href="#fn_saveOnSchedule">수업정보 저장</a>
	</div>
</form>	

					
<script>
<c:choose>
<c:when test="${!empty resultList}">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		com.datepickerDateFormat("traningDate${status.count}" , 'button');
	</c:forEach>
</c:when>
</c:choose>

</script>
	