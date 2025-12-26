<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<style type="text/css"></style>

<c:set var="targetUrl" value="/lu/company/"/>
<script type="text/javascript">

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
		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
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
	function fn_search( param1 ){
		
		$("#pageIndex").val( param1 );
	
		var reqUrl = "/lu/company/listCompany.do";
		//alert($("#pageIndex").val());
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}

	/* 상세조회 페이지로 이동 */
	function fn_read( param1 ){
		
		$("#companyId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "getCompany.do";
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	/* 수정 페이지로 이동 */
	function fn_updt(  ){
		
		var checkedVal = $(":input:radio[name=companyIdSelect]:checked").val();
		
		if(undefined == checkedVal){
			alert("수정할 기업명에 라디오버튼을 선택하여주십시오.");
			return false
		}
		
		$("#companyId").val( checkedVal );
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "goUpdateCompany.do";
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	/* 삭제 */
	function fn_delt(){
		if (confirm("삭제 하시겠습니까?")) {
			var checkedVal = $(":input:radio[name=companyIdSelect]:checked").val();
			
			if(undefined == checkedVal){
				alert("삭제할 기업명에 라디오버튼을 선택하여주십시오.");
				return false
			}
			
			$("#companyId").val( checkedVal );
			
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteCompany.do";
			
			$("#frmCompany").attr("action", reqUrl);
			$("#frmCompany").submit();
		}
	}
	
	/* 신규 페이지로 이동 */
	function fn_cret(){
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "goInsertCompany.do";
		
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	/* 단체회원 양식 다운로드 */
	function fn_excel_file_down(){
		var uploadFilePath = "/downloadfiles/";
	    $("#filename").val("allCompanySaveForm.xls");
	    $("#uploadFilePath").val(uploadFilePath);
	    
	    var reqUrl = CONTEXT_ROOT + "/simpleDown.sv";
	    $("#frmDownLoad").attr("action",reqUrl);
	    $("#frmDownLoad").submit();
	}
	
	/* 단체회원 등록 */
	function fn_excel_upload(){
		
		if($("input:file[name=uploadExcelFile]").val() == ""){
			alert("첨부할 파일이 존재하지 않습니다.");
			return;
		}
		
		var src = $("#uploadExcelFile").val();
		
		 if(!src.match(/\.(xls)$/i)) {
		      alert("엑셀(xls) 파일만 업로드 가능합니다.");
		      return;
		}
		
		if(confirm("작성한 엑셀파일로 기업일괄 등록 하시겠습니까?")){
			
		    var reqUrl = CONTEXT_ROOT + targetUrl + "insertExcelCompany.do";
		    
		    $("#frmCompany").attr("method", "post" );
			$("#frmCompany").attr("enctype", "multipart/form-data" );
			$("#frmCompany").attr("action", reqUrl);
			$("#frmCompany").attr("target","_self");
			$("#frmCompany").submit();
		}
	}
	
</script>
	
	
<div id="">
	<h2><c:out value="${curMenu.menuTitle }" /></h2>


	
<form id="frmDownLoad" name="frmDownLoad">
	<input type="hidden"  name="filename" id="filename"  />
	<input type="hidden"  name="uploadFilePath" id="uploadFilePath" />
</form>	

<form id="frmCompany" name="frmCompany" action="<c:url value='/lu/company/listCompany.do'/>" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" id="companyId" name="companyId" />
	
	<div class="search-box-1">
		<input type="text" id="searchCompanyName" name="searchCompanyName" placeholder="(ex)기업명" value=""/>
		<input type="text" id="searchEmployInsManageNo" name="searchEmployInsManageNo" placeholder="(ex)고용보험관리번호" value=""/>
		<a href="#fn_search" onclick="javascript:fn_search(1); return false" >검색</a>
		
	
	</div><!-- E : search-box-1 -->
	<br/><br/>
	
	

	<table class="type-write wp100">

			<tbody><tr>
				<th class="border-left">일괄 업로드</th>
				<td class="border-left">
					<input type="file" name="uploadExcelFile" id="uploadExcelFile" style="width:50%;">&nbsp;&nbsp;
						<a class="btn btn-primary btn-mmd" href="#fn_excel_file_down" onclick="javascript:fn_excel_file_down();">템플릿 다운로드</a>&nbsp;&nbsp;
						<a class="btn btn-primary btn-mmd" href="##fn_excel_upload" onclick="javascript:fn_excel_upload();">엑셀 업로드</a>
				</td>
			</tr>
		</tbody>
	</table>
	
	
	<div class="btn-area mt-010">
		<div class="float-right">
		<a href="#fn_cret" class="yellow" onclick="javascript:fn_cret(); return false" onkeypress="this.onclick();">신규등록</a>
		</div>
	</div><!-- E : btn-area -->
	
	<div class="clearfix"></div>
	<div class="table-responsive mt-020">
	<table class="type-2">
		<colgroup>
			<col style="width:50px" />
			<col style="width:300px" />
			<col style="width:350px" />
			<col style="width:*" />
			<col style="width:120px" />
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>기업명</th>
				<th>고용보험관리번호 (사업자등록번호)</th>
				<th>소재지</th>
				<th>선정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:if test="${status.count eq '1'}">
					<td><input type="radio" name="companyIdSelect" value="${result.companyId}" class="choice" checked="checked"></td>
				</c:if>
				<c:if test="${status.count != '1'}">
					<td><input type="radio" name="companyIdSelect" value="${result.companyId}" class="choice"></td>
				</c:if>
				<%-- <td><a href="#fn_read" onclick="javascript:fn_read('${result.companyId}')" class="text">${result.companyName}</a></td> --%>
				<td><a href="#fn_read" onclick="javascript:fn_read('${result.companyId}')" class="text">${result.companyName}</a></td>
				<td>${result.employInsManageNo} (${result.companyNo})</td>
				<td class="left">${result.address}</td>
				<td>${result.choiceDay}</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="5"><spring:message code="common.nodata.msg" /></td>
			</tr>
			</c:if>
		</tbody>
	</table>
	</div>

 	<ul class="page-num-btn mt-015">
		<li class="page-num-area">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
		</li>
	</ul><!-- E : page-num-btn -->
	
	<div class="btn-area mt-010">
		<div class="float-right">
			<a href="/la/statistics/company/listCompanyStatExcelDownload1.do" class="yellow">엑셀 다운로드</a>
			<a href="#fn_delt" class="black" onclick="javascript:fn_delt(); return false" onkeypress="this.onclick();">삭제</a>
			<a href="#fn_updt" class="yellow" onclick="javascript:fn_updt(); return false" onkeypress="this.onclick();">수정</a>
		</div>
	</div><!-- E : btn-area -->
	
</form>

</div><!-- E : content-area -->
	
