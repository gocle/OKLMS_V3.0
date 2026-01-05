<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="kr.co.gocle.oklms.comm.util.Config" %>
<c:set var="targetUrl" value="/la/config/"/>
<script type="text/javascript">

var targetUrl = "${targetUrl}";

$(document).ready(function() {
	loadPage();	
});

/*====================================================================
	화면 초기화 
====================================================================*/
function loadPage() {
}

/* 각종 버튼에 대한 액션 초기화 */
function initEvent() {
}

/*====================================================================
사용자 정의 함수 
====================================================================*/


/* 수정 */
function fn_formSave(){
	
	if($("#optValue").val() == ""){
		alert("설정값 인력은 필수 입니다.");
		return false;
	}
	
	var reqUrl = CONTEXT_ROOT + targetUrl + "updateConfig.do";

	$("#frmConfig").attr("method", "post" );
	$("#frmConfig").attr("action", reqUrl);
	$("#frmConfig").submit();
}

/* 목록 페이지로 이동 */
function fn_list(){
	var reqUrl = CONTEXT_ROOT + targetUrl + "listConfig.do";
	$("#frmConfig").attr("method", "post" );
	$("#frmConfig").attr("action", reqUrl);
	$("#frmConfig").submit();	
}

	
</script>
<p style="display:block;text-align:left;"><font color="red">*</font> 는 필수입력사항입니다.</p>
<form:form modelAttribute="frmConfig">
<input type="hidden" id="confId" name="confId"  value="${lmsConfigVO.confId}"/>
<input type="hidden" id="optKey" name="optKey" value="${lmsConfigVO.optKey}"/>

<!-- 디폴트 셋팅항목 필드 끝 -->

<table border="0" cellpadding="0" cellspacing="0" class="view-1" style="margin:0;">

		<!-- <th width="15%">설정 아이디</th>
			<th width="30%">설정 키</th>
			<th width="20%">설정 이름</th>
			<th width="20%">설정 값</th>
			<th width="15%">숨김여부</th>
			conf_id	not null	varchar2(30)
opt_key	not null	varchar2(100)
opt_value		varchar2(4000)
opt_name		varchar2(100)
opt_type		varchar2(20)
opt_hidden		number
opt_unit_text		varchar2(30)
opt_help		varchar2(500)
site_prefix	not null	varchar2(50)
			
			 -->

	<tbody>
		<tr>
			<th width="132px">설정 키</th>
			<td>
					${lmsConfigVO.optKey}
			</td>      
			<th width="132px">설정 명	</th>
	  		<td>
	  				${lmsConfigVO.optName}	
	  		</td>  
		</tr>
		
		<tr>
			<th>설정 값<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
			<td>
				<c:choose>
					<c:when test="${lmsConfigVO.optType eq 'text'}">
						<input type="text" id="optValue" name="optValue"  value="${lmsConfigVO.optValue}" style="width:60%" />&nbsp;MB
					</c:when>
					<c:when test="${lmsConfigVO.optType eq 'textarea'}">
						<textarea rows="" cols="" id="optValue" name="optValue" style="width:60%">${lmsConfigVO.optValue}</textarea>
					</c:when>
				</c:choose>		
			</td>      
			<th>사용여부</th>
			<td>
				<select name="optHidden" id="optHidden">
					<option value="0" ${lmsConfigVO.optHidden eq '0' ? 'selected' : ''}>사용</option>
					<option value="1" ${lmsConfigVO.optHidden eq '1' ? 'selected' : ''}>미사용</option>
				</select>				
			</td>    
		</tr>
		<tr>
			<th>참고사항</th>
			<td colspan="3">
				${lmsConfigVO.optHelp}
			</td>      
		</tr>
	</tbody>
</table><!-- E : view-1 -->
</form:form>

<div class="page-btn">
	<a href="#fn_formSave" onclick="javascript:fn_formSave();" onkeypress="this.onclick;">저장</a>
	<a href="#fn_list" onclick="javascript:fn_list();" onkeypress="this.onclick;">목록</a>
</div><!-- E : page-btn -->
		
