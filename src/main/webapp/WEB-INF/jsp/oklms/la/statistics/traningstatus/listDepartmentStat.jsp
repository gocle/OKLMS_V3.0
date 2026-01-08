<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<c:set var="targetUrl" value="/la/statistics/traningstatus/" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>
<script type="text/javaScript" language="javascript">
	/* ********************************************************
	 * 페이징 처리 함수
	 ******************************************************* */
	var targetUrl = "${targetUrl}";
	var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
	var totalCount = '${totalCount}'; //전체 데이터 갯수
	var pageIndex = '${pageIndex}'; //현재 페이지 정보
	$(document).ready(function() {

		if ('' == pageSize) {
			pageSize = 10;
		}
		if ('' == totalCount) {
			totalCount = 0;
		}
		if ('' == pageIndex) {
			pageIndex = 1;
		} 
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

		//     com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
 
	}

	/*====================================================================
	 사용자 정의 함수 
	 ====================================================================*/
	function press(event) {
		if (event.keyCode == 13) {
			fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search(param1) {

		$("#pageIndex").val(param1);
		var reqUrl = CONTEXT_ROOT + targetUrl + "listDepartmentStat.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").submit();
	}

	function fn_LoginLogManage() { 
		document.getElementById("searchYn").value = "Y";
		fn_search(pageIndex);
	}
	
	function fn_calendarClear(Obj) {
		document.getElementById(Obj).value="";
	}
	
	//엑셀 다운로드 ddd
	function fn_exclDownload(){					
		var reqUrl = CONTEXT_ROOT + targetUrl + "listDepartmentStatExcelDownload.do";
		$("#pageIndex").val("1");
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();
	}
	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	function fn_save(){					
		var reqUrl = CONTEXT_ROOT + targetUrl + "saveDepartmentStat.do";
		$("#frmSubject").attr("action", reqUrl);
		$("#frmSubject").attr("target","_self");
		$("#frmSubject").submit();
	}
</script>
<%-- noscript 테그 --%>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
	기능을 사용하실 수 없습니다.</noscript>
<form name="frmSubject" id="frmSubject" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />  
	<input type="hidden" id="searchYn" name="searchYn" value="${param.searchYn}" />
	<!-- E : search-list-1 (검색조건 영역) -->
	<ul class="search-list-1">
		<li><span>구분</span> 
			<select name="searchKeyword" id="searchKeyword" onchange="javascript:fn_LoginLogManage();">
				<option value="" >전체</option>
				<option value="N" <c:if test="${subjectVO.searchKeyword eq 'N' }">selected</c:if>>대학연계형</option>
				<option value="Y" <c:if test="${subjectVO.searchKeyword eq 'Y' }">selected</c:if>>고숙련마이스터과정</option>
			</select>
		</li>
 		<li><span>학과명</span> 
			<select name="searchDeptName" id="searchDeptName"  onchange="javascript:fn_LoginLogManage();">
				<option value="" >전체</option>
				<c:forEach items="${deptCodeList}" var="deptCodeList" varStatus="status">	
				<option value="${deptCodeList.codeId}" <c:if test="${subjectVO.searchDeptName eq deptCodeList.codeId }">selected</c:if>>${deptCodeList.codeName}</option>
				</c:forEach>
				 
			</select> 
		</li>
		<li><span>훈련실시연도</span> 
			<select name="searchyyyy" id="searchyyyy"  onchange="javascript:fn_LoginLogManage();">
				<option value="" >전체</option>
				<c:forEach var="i" begin="0" end="11">
				    <c:set var="year" value="${nowYear - i}" />
				    <c:if test="${year >= 2015}">
				        <option value="${year}"
				            <c:if test="${subjectVO.searchyyyy eq year}">
				                selected="selected"
				            </c:if>>
				            ${year}
				        </option>
				    </c:if>
				</c:forEach>
			</select> 
		</li>
		<li><span>실시구분</span> 
			<select name="searchDeptTransferYn" id="searchDeptTransferYn"  onchange="javascript:fn_LoginLogManage();">
				<option value="" >전체</option>
				<option value="N" <c:if test="${subjectVO.searchDeptTransferYn eq 'N' }">selected</c:if>>신입</option>
				<option value="Y" <c:if test="${subjectVO.searchDeptTransferYn eq 'Y' }">selected</c:if>>편입</option>
			</select> 
		</li>
	</ul>

<!-- E : search-list-1 (검색조건 영역) -->
<div class="search-btn-area">
	<a href="#@" onclick="fn_LoginLogManage(); return false;">조회</a>
</div>
<ul class="board-info">
	<li class="info-area"><span>전체</span> : <c:out value="${fn:length(resultList) }" /> 건</li>
	<li class="btn-area"> 
		<a href="#fn_exclDownload" onclick="javascript:fn_save( ); return false" onkeypress="this.onclick;" class="btn">편제정원저장</a>
		&nbsp;&nbsp;&nbsp;<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul>

  

<div class="table-responsive">
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th rowspan="3">구분</th>
			<th rowspan="3">학과명</th>
			<th rowspan="3">훈련실시연도</th>
			<th rowspan="3">실시구분</th>			
			<th colspan="15">운영결과</th>			
		</tr>
		 <tr>
		 	<th rowspan="2">편제정원</th>
		 	<th rowspan="2">훈련총인원</th>
		 	<th rowspan="2">훈련실시인원</th>
		 	
		 	<th colspan="2">참여철회</th>
		 	<th rowspan="2">훈련중인원</th>
		 	<th colspan="2">중탈</th>
		 	<th colspan="2">미이수</th>
		 	<th colspan="2">이수</th>
		 	<th colspan="2">수료</th>
		 	<th rowspan="2">재학인원</th>
		 	
		 </tr>
		 
		<tr>
			<th>인원</th>
			<th>철회율</th>
			<th>인원</th>
			<th>중탈율</th>
			<th>인원</th>
			<th>미이수율</th>
			<th>인원</th>
			<th>이수율</th>
			<th>인원</th>
			<th>수료율</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" colspan="16"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
		<%-- 데이터를 화면에 출력해준다 --%>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">		
			<tr>
				<td><c:if test="${resultList.mstYn eq 'Y'}">고숙련마이스터과정</c:if><c:if test="${resultList.mstYn eq 'N'}">대학연계형</c:if></td>
				<td><c:out value="${resultList.deptName}" /></td>
				<td><c:out value="${resultList.yyyy}" /></td>
				<td><c:out value="${resultList.deptTransferNm}" /></td>
				<td>
				<input type="text" style="width: 40px; text-align: center" name="deptLimits" id="deptLimit${status.count}" onkeydown="onlyNumber(this);" maxlength="3" value="<c:out value="${empty resultList.formationTotal ? '0' : resultList.formationTotal}" />" />
				<input type="hidden" name="deptCds" id="deptCds${status.count}" value="${resultList.deptCd}" />
				<input type="hidden" name="deptYears" id="deptYears${status.count}" value="${resultList.yyyy}" />
				<input type="hidden" name="deptTransferYns" id="deptTransferYns${status.count}" value="${resultList.deptTransferYn}" />
				</td>
				<td><c:out value="${resultList.trainingTotal}" /></td>
				<td><c:out value="${resultList.trainingActionTotal}" /></td>
				<td><c:out value="${resultList.recantTotal}" /></td>
				<td><c:out value="${resultList.recantRatio}" />%</td>
				<td><c:out value="${resultList.trainingRealTotal}" /></td>
				<td><c:out value="${resultList.failTotal}" /></td>
				<td><c:out value="${resultList.failRatio}" />%</td>
				
				<td><c:out value="${resultList.notFinishTotal}" /></td>
				<td><c:out value="${resultList.notFinishRatio}" />%</td>
				
				<td><c:out value="${resultList.finishTotal}" /></td>
				<td><c:out value="${resultList.finishRatio}" />%</td>
				<td><c:out value="${resultList.completeTotal}" /></td>
				<td><c:out value="${resultList.completeRatio}" />%</td>
				<td><c:out value="${resultList.skTotal}" /></td>
			</tr>

		</c:forEach>
		
	</tbody>
	

</table>
</div>
	</form>


 