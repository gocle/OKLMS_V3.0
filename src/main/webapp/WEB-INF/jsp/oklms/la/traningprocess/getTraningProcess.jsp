<%@page import="kr.co.gocle.oklms.comm.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="kr.co.gocle.oklms.comm.util.Config" %>
<%
String retMsg = StringUtil.trimString((String)request.getAttribute("retMsg"),"");

%>
<c:set var="targetUrl" value="/la/traningprocess/"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	var targetUrl = "${targetUrl}";
	var useCnt = "${useCnt}";
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
		com.datepickerDateFormat('startDate', 'button');
		com.datepickerDateFormat('endDate', 'button');
	}

	/*====================================================================
	사용자 정의 함수 
	====================================================================*/

	/* 입력 필드 초기화 */
	function fn_formReset( param1 ){
		$("#frmProcess").find("input,select").val("");
	}
	
	/* 수정 */
	function fn_formSave(){
		
		if($("#traningProcessName").val() == ""){
			alert("훈련과정명을 넣어 주세요.");
			return false;
		}
		
		if($("#traningProcessNo").val() == ""){
			alert("훈련과정 번호를 넣어 주세요.");
			return false;
		}
		
		if($("#traningProcessPeriod").val() == ""){
			alert("훈련과정 회차를 넣어 주세요.");
			return false;
		}
		
		if($("#startDate").val() == ""){
			alert("훈련시작일 넣어 주세요.");
			return false;
		}
		
		if($("#endDate").val() == ""){
			alert("훈련종료일 넣어 주세요.");
			return false;
		}
		
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "updateTraningProcess.do";

		$("#frmProcess").attr("method", "post" );
		$("#frmProcess").attr("action", reqUrl);
		$("#frmProcess").submit();
	}
	
	/* 삭제 */
	function fn_formDelete(){
		if(useCnt != "0"){
			alert("운영중인 훈련과정은 삭제가 불가능합니다.");
			return;
		}
		
		if(confirm("훈련과정을 삭제 하시겠습니까?")){
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteTraningProcess.do";

			$("#frmProcess").attr("method", "post" );
			$("#frmProcess").attr("action", reqUrl);
			$("#frmProcess").submit();
		}
	}
	
	/* 목록 페이지로 이동 */
	function fn_list(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listTraningProcess.do";

		$("#frmProcess").attr("method", "post" );
		$("#frmProcess").attr("action", reqUrl);
		$("#frmProcess").submit();	
	}
	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}

</script>
<p style="display:block;text-align:left;"><font color="red">*</font> 는 필수입력사항입니다.</p>
<%-- 팝업폼 --%>
<%-- 팝업폼 --%>
<form:form commandName="frmProcess">
<!-- 디폴트 셋팅항목 필드 시작 -->
<!-- 디폴트 셋팅항목 필드 끝 -->

<!-- 검색조건유지 필드 시작 -->
<input type="hidden" name="searchKeyword" id="searchKeyword" value="${traningProcessVO.searchKeyword}"/>
<input type="hidden" name="traningProcessId" id="traningProcessId" value="${traningProcessVO.traningProcessId}"/> 


<!-- 검색조건유지 필드 끝 -->
<table border="0" cellpadding="0" cellspacing="0" class="view-1" style="margin:0;">
	<tbody>
		<tr>
			<th width="132px">훈련과정명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
			<td>
				<input type="text" id="traningProcessName" name="traningProcessName"  value="${traningProcessVO.traningProcessName}"   style="width:90%" maxlength="100" />	
			</td>      
			<th width="132px">훈련과정번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	  		<td>
	  			<input type="text" id="traningProcessNo" name="traningProcessNo"  value="${traningProcessVO.traningProcessNo}" style="width:40%" maxlength="30"   />	
	  		</td>
	  		<th width="132px">훈련과정회차<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	  		<td>
	  			<input type="text" id="traningProcessPeriod" name="traningProcessPeriod" onkeydown="onlyNumber(this);"  value="${traningProcessVO.traningProcessPeriod}" style="width:40%" maxlength="5"   />	
	  		</td>    
		</tr>
		<tr>
			<th>실시년도</th>
			<td>
				<input type="text" id="year" name="year"  value="${traningProcessVO.year}" maxlength="4" onkeydown="onlyNumber(this);" style="width:40%" />
			</td>
			<th>훈련시작일</th>
			<td>
				<input type="text" id="startDate" name="startDate"  value="${traningProcessVO.startDate}" style="width:40%" />
			</td>      
			<th>훈련종료일</th>
			<td colspan="3">
				<input type="text" id="endDate" name="endDate"  value="${traningProcessVO.endDate}" style="width:40%" />
			</td>    
		</tr>
		<tr>
			<th>훈련상태</th>
			<td>
					<select id="traningStatusCd" name="traningStatusCd"  >
						<option value="">::선택::</option>
						<option value="1" ${traningProcessVO.traningStatusCd eq '1' ? 'selected' : ''}>진행중</option>
						<option value="2" ${traningProcessVO.traningStatusCd eq '2' ? 'selected' : ''}>전체중탈</option>
						<option value="3" ${traningProcessVO.traningStatusCd eq '3' ? 'selected' : ''}>훈련중지</option>
						<option value="4" ${traningProcessVO.traningStatusCd eq '4' ? 'selected' : ''}>종료</option>
					</select>
			</td>
			<th>과정구분</th>
			<td colspan="3">
				<select id="traningTypeCd" name="traningTypeCd"  >
						<option value="">::선택::</option>
						<option value="1" ${traningProcessVO.traningTypeCd eq '1' ? 'selected' : ''}>일반</option>
						<option value="2" ${traningProcessVO.traningTypeCd eq '2' ? 'selected' : ''}>변경인정</option>
						<option value="3" ${traningProcessVO.traningTypeCd eq '3' ? 'selected' : ''}>과정연계</option>
					</select>
			</td>      
		</tr>
		
		<tr>
			<th>NCS 자격명</th>
			<td>
				<input type="text" id="ncsLicenceName" name="ncsLicenceName"  value="${traningProcessVO.ncsLicenceName}" maxlength="20" style="width:40%" />
			</td>
			<th>NCS 자격수준</th>
			<td>
				<input type="text" id="ncsLicenceLevel" name="ncsLicenceLevel"  value="${traningProcessVO.ncsLicenceLevel}" maxlength="20" style="width:40%" />
			</td>      
			<th>NCS 자격버전</th>
			<td>
				<input type="text" id="ncsLicenceVersion" name="ncsLicenceVersion"  value="${traningProcessVO.ncsLicenceVersion}" maxlength="20" style="width:40%" />
			</td>    
		</tr>
		
		<tr>
			<th>NCS 코드</th>
			<td>
				<input type="text" id="ncsCode" name="ncsCode"  value="${traningProcessVO.ncsCode}" maxlength="20" style="width:40%" />
			</td>
			<th>NCS 명</th>
			<td>
				<input type="text" id="ncsName" name="ncsName"  value="${traningProcessVO.ncsName}" maxlength="20" style="width:40%" />
			</td>  
			<th>등급</th>
			<td>
				<input type="text" id="centerGrade" name="centerGrade"  value="${traningProcessVO.centerGrade}" maxlength="20" style="width:40%" />
			</td>      
		</tr>
		
		<tr>
			<th>OJT 훈련시간</th>
			<td>
				<input type="text" id="ojtTimeHour" name="ojtTimeHour"  value="${traningProcessVO.ojtTimeHour}" onkeydown="onlyNumber(this);" maxlength="4" style="width:40%" />
			</td>
			<th>Off-JT 훈련시간</th>
			<td colspan="3">
				<input type="text" id="offTimeHour" name="offTimeHour"  value="${traningProcessVO.offTimeHour}" onkeydown="onlyNumber(this);" maxlength="4" style="width:40%" />
			</td>  
		</tr>
		<tr>
			<th>NCS 자격 매핑</th>
			<td>
				<select id="licenceId" name="licenceId" >
					<option value="">선택</option>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<option value="${result.licenceId}" ${result.licenceId eq traningProcessVO.licenceId ? 'selected' : ''}>${result.licenceName}_${result.licenceLevel}_${result.licenceVersion}</option>
					</c:forEach>
				</select>
			</td>    
			<th>학과</th>
			<td colspan="3">
				<select id="deptNo" name="deptNo" >
					<option value="">선택</option>
					<c:forEach var="result" items="${deptCodeList}" varStatus="status">
						<option value="${result.codeId}" ${result.codeId eq traningProcessVO.deptNo ? 'selected' : ''}>${result.codeName}</option>
					</c:forEach>
				</select>
			</td>  
		</tr>
		
		<tr>
			<th>특이사항</th>
			<td colspan="5">
				<textarea  id="centerBigo" name="centerBigo" maxlength="100"  rows="" cols="">${traningProcessVO.centerBigo}</textarea>
			</td>      
		</tr> 
		
	</tbody>
</table><!-- E : view-1 -->
</form:form>

<div class="page-btn">
	<a href="#fn_formSave" onclick="javascript:fn_formSave();" onkeypress="this.onclick;">수정</a>
	<a href="#fn_formDelete" onclick="javascript:fn_formDelete();" onkeypress="this.onclick;">삭제</a>
	<a href="#fn_list" onclick="javascript:fn_list();" onkeypress="this.onclick;">목록</a>
</div><!-- E : page-btn -->
		
