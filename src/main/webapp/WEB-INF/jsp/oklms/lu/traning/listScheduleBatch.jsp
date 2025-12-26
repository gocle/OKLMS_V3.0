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

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2017. 01. 09 오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>
<c:set var="targetUrl" value="/lu/traning/"/>
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

	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			//fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search( param1 ){
		
		if($("#yyyy").val() == ""){
			alert("학년도를 선택해주시길 바랍니다.");
			$("#yyyy").focus();
			return;
		}
		
		if($("#term").val() == ""){
			alert("학기를 선택해주시길 바랍니다.");
			$("#term").focus();
			return;
		}
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listScheduleBatch.do";
		$("#frmTraning").attr("target","_self");
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}
	
	/* 리스트 조회 */
	function fn_change(){
		if($("#yyyy").val() != "" && $("#term").val() != ""){
			var reqUrl = CONTEXT_ROOT + targetUrl + "listScheduleBatch.do";
			$("#frmTraning").attr("target","_self");
			$("#frmTraning").attr("action", reqUrl);
			$("#frmTraning").submit();
		}
	}
	
	/* 훈련시간표 엑셀일괄등록 양식 다운로드 */
	function fn_excel_file_down(){
		var uploadFilePath = "/downloadfiles/";
	    $("#filename").val("TrainingScheduleBatchSaveForm.xls");
	    $("#uploadFilePath").val(uploadFilePath);

	    var reqUrl = CONTEXT_ROOT + "/simpleDown.sv";
	    $("#frmDownLoad").attr("action",reqUrl);
	    $("#frmDownLoad").attr("target","_self");
	    $("#frmDownLoad").submit();
	}
	
	/* 훈련시간표 엑셀일괄등록 */
	function fn_excel_upload(){
		
		if($("#yyyy").val() == ""){
			alert("학년도를 선택해주시길 바랍니다.");
			$("#yyyy").focus();
			return;
		}
		
		if($("#term").val() == ""){
			alert("학기를 선택해주시길 바랍니다.");
			$("#term").focus();
			return;
		}
		
		if($("input:file[name=uploadExcelFile]").val() == ""){
			alert("첨부할 파일이 존재하지 않습니다.");
			return;
		}

		var src = $("#uploadExcelFile").val();

		 if(!src.match(/\.(xls)$/i)) {
		      alert("엑셀(xls) 파일만 업로드 가능합니다.");
		      return;
		}

		if(confirm("시간표 일괄등록을 하시겠습니까?")){

		    var reqUrl = CONTEXT_ROOT + "/lu/traning/insertScheduleBatch.do";

		    $("#frmTraning").attr("method", "post" );
			$("#frmTraning").attr("enctype", "multipart/form-data" );
			$("#frmTraning").attr("action", reqUrl);
			$("#frmTraning").attr("target","_self");
			$("#frmTraning").submit();
		}
	}
	
</script>

<!-- 훈련시간표등록 템플릿다운로드 항목 -->
<form id="frmDownLoad" >
	<input type="hidden"  name="filename" id="filename"  />
	<input type="hidden"  name="uploadFilePath" id="uploadFilePath" />
</form>

			
<div id="content-area">
			<h2>훈련 시간표 일괄 등록</h2>
			<!-- E : search-list-1 (검색조건 영역) -->
<form id="frmTraning" name="frmTraning" action="<c:url value='/lu/traning/listScheduleBatch.do'/>" method="post">
		
			
		<div class="group-area mt-020">
			<div class="search-box-1">
				<select name="yyyy" id="yyyy" onchange="fn_change();"> 
						<option value="">학년도</option>
						<c:forEach var="i" begin="0" end="2" step="1">
					      <option value="${nowYear-i}" <c:if test="${traningScheduleVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
					    </c:forEach>								
				</select> 
				<select name="term" id="term" onchange="fn_change();">
						<option value="">학기</option>
						<option value="1" <c:if test="${traningScheduleVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
						<option value="2" <c:if test="${traningScheduleVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
						<option value="3" <c:if test="${traningScheduleVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
						<option value="4" <c:if test="${traningScheduleVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
					</select>
				<a href="#!" onclick="javascript:fn_search();">검색</a>
			</div><!-- E : search-box-1 -->
		</div>
		
		<span class="mt-020 float-left"><font color="blue">※ "템플릿 다운로드 후 엑셀파일 각항목 제목에 노란색"</font>으로 표시된 부분이 필수사항이므로 입력후 엑셀업로드 버튼클릭해주세요.<br><font color="blue">※"최대 15주차까지"</font> 개설강좌만 엑셀 일괄업로드 가능합니다.</span>
		
		<div class="group-area mt-010">
		<table class="type-write">
			<colgroup>
				<col style="width:100px" />
				<col style="width:*" />
			</colgroup>
			<tr>
				<th class="border-left">시간표 업로드</th>
				<td class="border-left">
					<input type="file" name="uploadExcelFile" id="uploadExcelFile" style="width:50%;" />&nbsp;&nbsp;
					<c:if test="${fn:length(resultList) > 0}">
						<a class="btn-full-blue" href="#fn_excel_file_down" onclick="javascript:fn_excel_file_down();">템플릿 다운로드</a>&nbsp;&nbsp;
						<a class="btn-full-blue" href="##fn_excel_upload" onclick="javascript:fn_excel_upload();">엑셀 업로드</a>
					</c:if>
				</td>
			</tr>
		</table>
		<br/><br/><br/><br/>
		<div class="group-area mb-010">
			<h5>훈련시간표 미등록 개설교과 ${fn:length(resultList)} 건</h5>
			<table class="type-2">
				<colgroup>
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:100" />
					<col style="width:*" />
					<col style="width:200px" />
					<col style="width:100px" />
					<col style="width:100px" />
				</colgroup>
				<thead>
					<tr>
						<th>학년도</th>
						<th>학기</th>
						<th>교과목코드</th>
						<th>분반</th>
						<th>교과목명</th>
						<th>학과</th>
						<th>교과구분</th>
						<th>학점여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${result.yyyy}</td>
						<td>${result.termName}</td>
						<td><input type="text" value="${result.subjectCode}" readonly="readonly" ></td>
						<td><input type="text" value="${result.subClass}" readonly="readonly" ></td>
						<td>${result.subjectName}</td>
						<td>${result.departmentName}</td>
						<td>${result.subjectTypeName}</td>
						<td>${result.pointUseYnName}</td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="8">시간표 미등록 상태인 개설교과가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<%-- <div class="btn-area align-right mt-010">
			<a href="#fn_excel_file_down" onclick="javascript:fn_excel_file_down();" class="yellow float-left" id="displaly6">템플릿 다운로드</a>
			
			<a href="#fn_goList" onclick="javascript:fn_delete('${status}');" class="gray-1" >삭제</a>
			<a href="#fn_goList" onclick="javascript:fn_goList();" class="orange" >목록</a> 
			
			<a href="#fn_excel_upload" onclick="javascript:fn_excel_upload();" class="yellow" id="displaly7" >엑셀업로드</a>
		</div> --%>
	</div>

						
</form>	
					</div><!-- E : content-area -->

	
	