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

<style type="text/css">
</style>
<c:set var="targetUrl" value="/la/hak/"/>
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
		com.datepickerDateFormat("i_startDate" , 'button');
		com.datepickerDateFormat("i_endDate" , 'button');
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/


	/* 리스트 조회 */
	function fn_insert(){
		if($("#i_yyyy").val() == ""){
			alert("학년도를 선택하세요.");
			$("#i_yyyy").focus();
			return;
		}
		
		if($("#i_term").val() == ""){
			alert("학기를 선택하세요.");
			$("#i_term").focus();
			return;
		}
		
		if($("#i_startDate").val() == ""){
			alert("학기 시작일을 선택하세요.");
			$("#i_startDate").focus();
			return;		
		}
				
		if($("#i_endDate").val() == ""){
			alert("학기 종료일을 선택하세요.");
			$("#i_endDate").focus();
			return;
		}
		
		<c:forEach var="result" items="${resultList}" varStatus="status">
			var yyyy = "${result.yyyy}";
		    var term = "${result.term}";
		    
		    if($("#i_yyyy").val() == yyyy && $("#i_term").val() == term){
				alert("동일 학년도 학기가 존재합니다.");
				return;
			}
		</c:forEach>
		
		if(confirm("저장 하시겠습니까?")){
			if(doubleSubmitCheck()) return;
			var reqUrl = CONTEXT_ROOT + targetUrl + "insertHak.do";
			$("#frmTopHak").attr("action", reqUrl);
			$("#frmTopHak").attr("target","_self");
			$("#frmTopHak").submit();
		}
	}
	
	function fn_update(yyyy,term,index){
		
		if($("#startDate"+index).val() == ""){
			alert("학기 시작일을 선택하세요.");
			$("#startDate"+index).focus();
			return;		
		}
				
		if($("#endDate"+index).val() == ""){
			alert("학기 종료일을 선택하세요.");
			$("#endDate"+index).focus();
			return;		
		}
		
		$("#yyyy").val(yyyy);
		$("#term").val(term);
		$("#startDate").val($("#startDate"+index).val());
		$("#endDate").val($("#endDate"+index).val());
		
		
		if(confirm("수정 하시겠습니까?")){
			if(doubleSubmitCheck()) return;
			var reqUrl = CONTEXT_ROOT + targetUrl + "updateHak.do";
			$("#frmHak").attr("action", reqUrl);
			$("#frmHak").attr("target","_self");
			$("#frmHak").submit();
		}
	}
	
	function fn_delete(yyyy,term){
		
		$("#yyyy").val(yyyy);
		$("#term").val(term);
		
		if(confirm("삭제 하시겠습니까?")){
			if(doubleSubmitCheck()) return;
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteHak.do";
			$("#frmHak").attr("action", reqUrl);
			$("#frmHak").attr("target","_self");
			$("#frmHak").submit();
		}
	}
	
	
	
	function fn_dateInit(id){
		$("#"+id).val("");
	}
	
	var doubleSubmitFlag = false;
	function doubleSubmitCheck(){
	    if(doubleSubmitFlag){
	        return doubleSubmitFlag;
	    }else{
	        doubleSubmitFlag = true;
	        return false;
	    }
	}
	
</script>


<!-- 회원정보 팝업용 끝 -->
<form id="frmTopHak" name="frmTopHak" action="<c:url value='/la/hak/listHak.do'/>" method="post">
<ul class="search-list-1">
	<li>
		<span>학년도</span>
		
			<select name="yyyy" id="i_yyyy" style="width: 120px; margin-right: 10px;"> 
				<option value="" >선택</option>
				<c:forEach var="i" begin="0" end="3" step="1">
					<option value="${nowYear-i+1}">${nowYear-i+1}</option>
				</c:forEach>								
			</select> 
	</li>
	<li>
		<span>학기</span>
		<select name="term" id="i_term" style="width: 120px; margin-right: 10px;"> 
			<option value="" >선택</option>
			<option value="1">1학기</option>
			<option value="3">여름학기</option>
			<option value="2">2학기</option>
			<option value="4">겨울학기</option>
		</select> 
	</li>
	
	<li>
		<span>시작일</span>
		<input type="text" name="startDate" id="i_startDate" value="" readonly="readonly" style="width:110px;" />
	</li>
	<li>
		<span>종료일</span>
		<input type="text" name="endDate" id="i_endDate" value="" readonly="readonly" style="width:110px;" />
	</li>
		<!-- &nbsp;&nbsp;<a href="#">추가</a> -->
</ul><!-- E : search-list-1 -->
</form>
<div class="search-btn-area">
	<a onclick="javascript:fn_insert(); return false" href="#!">추가</a>
</div>
<form id="frmHak" name="frmHak" action="<c:url value='/la/hak/listHak.do'/>" method="post">
<input type="hidden" id=yyyy name="yyyy"/>
<input type="hidden" id="term" name="term"/>
<input type="hidden" id="startDate" name="startDate"/>
<input type="hidden" id="endDate" name="endDate"/>

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="20%">학년도</th>
			<th width="20%">학기</th>
			<th width="20%">시작일</th>
			<th width="20%">종료일</th>
			<th width="20%"></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>${result.yyyy}</td>
			<td>${result.termName}</td>
			<td>
			<input type="text" name="startDates" id="startDate${status.index}" value="${result.startDate}" readonly="readonly" style="width:110px;" />
			&nbsp;<a href="#fn_dateInit()" onclick="javascript:fn_dateInit('startDate${status.index}');"  class="btn-1">초기화</a>
			</td>
			<td>
			<input type="text" name="endDates" id="endDate${status.index}" value="${result.endDate}" readonly="readonly" style="width:110px;" />
			&nbsp;<a href="#fn_dateInit()" onclick="javascript:fn_dateInit('endDate${status.index}');"  class="btn-1">초기화</a>
			</td>
			<td><a href="#!" onclick="javascript:fn_update('${result.yyyy}','${result.term}','${status.index}');"  class="btn-2">수정</a>&nbsp;&nbsp;
			<a href="#!" onclick="javascript:fn_delete('${result.yyyy}','${result.term}');"  class="btn-1">삭제</a>&nbsp;&nbsp;
			<a href="#!" onclick="javascript:fn_update('${result.yyyy}','${result.term}','${status.index}');"  class="btn-2">아우누리 연계</a>
			</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td colspan="14"><spring:message code="common.nodata.msg" /></td>
		</tr>
		</c:if>
	</tbody>
</table><!-- E : list -->

</form>

<script>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		com.datepickerDateFormat("startDate${status.index}" , 'button');
		com.datepickerDateFormat("endDate${status.index}" , 'button');
	</c:forEach>

</script>
					

	