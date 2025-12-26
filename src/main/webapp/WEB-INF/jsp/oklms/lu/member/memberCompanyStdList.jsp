<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2017. 02.27  오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>

<style type="text/css">
</style>

<c:set var="targetUrl" value="/lu/member/"/>
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

		//기업체 검색 팝업 조회 성공여부
		var returnMsg = "";
		returnMsg = '${returnMsg}';
		var cnt = '${cnt}';

		if('POPUP_LIST_FAIL' != returnMsg && returnMsg != ''){
			$("#searchKeyword").val('${searchKeyword}');
			fn_showCompanypop();
		}

		//alert("cnt="+cnt);

		$(".tab-name-13").addClass('on');

		if(cnt == '0'){
			$("#styleDisplay1").show();
			$("#styleDisplay2").hide();
			$(".list-show").show();
			$(".list-hide").hide();
		} else {
			$("#styleDisplay1").hide();
			$("#styleDisplay2").show();
			$(".list-show").hide();
			$(".list-hide").hide();
		}
	}

	/*====================================================================
		사용자 정의 함수
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_search();
		}
	}

	/* 기업체 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = CONTEXT_ROOT + targetUrl + "listStdInfo.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	//초기화 기업체 리스트 조회
	function fn_searchKeywordNo(param1){
		$("#searchKeyword").val('');
		$("#searchKeywordNull").val('allSearch');
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = CONTEXT_ROOT + targetUrl + "listStdInfo.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	//기업체검색 목록에서 페이징 번호 클릭시 리스트 조회
	function fn_searchPaging( param1 ){
		$("#pageIndex").val( param1 );

		var reqUrl = CONTEXT_ROOT + targetUrl + "listStdInfo.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	function fn_showCompanypop( ){
		$("#student-popup").show();
		$(".company-area,.popup-bg").addClass("open");
		window.location.hash = "#open";
	}

	function fn_closeCompanypop( ){
		$("#searchKeyword").val('');
		$("#student-popup").hide();
		$(".company-area,.popup-bg").removeClass("open");
	}

	function fn_hideCompanypop( ){
		$("#searchKeyword").val('');
		var obj = "";
		obj = $("input:radio[name='tempCompanyId']:checked").val();
		if(undefined == obj){
			alert("기업체를 선택하여주십시오. ")
			return false;
		} else {
			$(".company-area,.popup-bg").removeClass("open");
			fn_setCompanypopInfo(obj);
		}
	}

	// 기업체 정보 셋팅
	function fn_setCompanypopInfo(obj){
		if( obj ){
			var arrInfo = obj.split("||");
			var companyId = arrInfo[0];

			$("#companyId").val(companyId);

			fn_listTraningProcessManage( companyId );
		}
	}

	//기업체에 매핑된 기업현장교사 회원정보 목록 조회
	function fn_listTraningProcessManage( param1 ){

		$("#companyId").val(param1);
		$("#tempTraningProcessId").val('noDivPopup');
		$("#memberType").val('STD');

		var reqUrl = CONTEXT_ROOT + targetUrl + "listStdInfo.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}

	//선택 메일보내기
	function fn_mailSend(){
		alert("작업중");
	}

	//선택 SMS보내기
	function fn_smsSend(){
		alert("작업중");
	}

	//기업체에 매핑된 기업현장교사 회원정보 목록 탭버튼 클릭시
	function fn_showTabbtn( param1 ){

		doActionShowTabbtn( param1 );

		$("#memberType").val(param1);
		$("#tempTraningProcessId").val('noDivPopup');

		var reqUrl = CONTEXT_ROOT + targetUrl + "listStdInfo.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	//탭버튼 활성화
	function doActionShowTabbtn( param1 ){
		if("COT" == param1){ //기업현장교사 탭버튼 클릭시
			$(".tab-name-11").addClass('on');
			$(".tab-name-12").removeClass('on');
			$(".tab-name-13").removeClass('on');
			$(".tab-name-14").removeClass('on');
			$(".tab-name-15").removeClass('on');

			$("#tab-content-11").css('display','block');
			$("#tab-content-12").css('display','none');
			$("#tab-content-13").css('display','none');
			$("#tab-content-14").css('display','none');
			$("#tab-content-15").css('display','none');
		} else if("CCM" == param1){ //HRD담당자 탭버튼 클릭시
			$(".tab-name-12").addClass('on');
			$(".tab-name-11").removeClass('on');
			$(".tab-name-13").removeClass('on');
			$(".tab-name-14").removeClass('on');
			$(".tab-name-15").removeClass('on');

			$("#tab-content-12").css('display','block');
			$("#tab-content-11").css('display','none');
			$("#tab-content-13").css('display','none');
			$("#tab-content-14").css('display','none');
			$("#tab-content-15").css('display','none');
		} if("STD" == param1){ //학습근로자 탭버튼 클릭시
			$(".tab-name-13").addClass('on');
			$(".tab-name-11").removeClass('on');
			$(".tab-name-12").removeClass('on');
			$(".tab-name-14").removeClass('on');
			$(".tab-name-15").removeClass('on');

			$("#tab-content-13").css('display','block');
			$("#tab-content-11").css('display','none');
			$("#tab-content-12").css('display','none');
			$("#tab-content-14").css('display','none');
			$("#tab-content-15").css('display','none');
		} else if("PRT" == param1){ //교수 탭버튼 클릭시
			$(".tab-name-14").addClass('on');
			$(".tab-name-11").removeClass('on');
			$(".tab-name-12").removeClass('on');
			$(".tab-name-13").removeClass('on');
			$(".tab-name-15").removeClass('on');

			$("#tab-content-14").css('display','block');
			$("#tab-content-11").css('display','none');
			$("#tab-content-12").css('display','none');
			$("#tab-content-13").css('display','none');
			$("#tab-content-15").css('display','none');
		}
	}
	function sms(){		
		var obj = document.getElementsByName("memIdArr");
		var temp = 0;
	    var arr_value = "";
	    for(var i = 0; i < obj.length; i++){
	         if(obj[i].checked){
	              arr_value += obj[i].value+",";
	              temp++;
	         }
	    }	
		if(temp==0){
			alert("선택된 대상이 없습니다.");
			return;
		}	  
		fn_send_sms(0,arr_value,'','','');
		
	}

	function email(){	
		var obj = document.getElementsByName("memIdArr");
	    var temp = 0;
	    var arr_value = "";
	    for(var i = 0; i < obj.length; i++){
	         if(obj[i].checked){
	              arr_value += obj[i].value+",";
	              temp++;
	         }
	    }
		if(temp==0){
			alert("선택된 대상이 없습니다.");
			return;
		}	  
		fn_send_mail(0,arr_value,'','','');	
	}
	
	function fn_updatePage(memSeq){
		
		var companyId = "";
		companyId = $("#companyId").val();
		if(companyId == ''){
			alert("기업체 정보가 없습니다. 기업체검색버튼을 클릭하여 기업체 선택후 탭버튼을 클릭해주세요.");
			return false;
		}
		
		$("#memSeq").val(memSeq);
		var reqUrl = "/lu/member/updateStdInfoPage.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
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
			
		    var reqUrl ="/lu/company/insertExcelMemberCompany.do";
		    
		    $("#frmCompany").attr("method", "post" );
			$("#frmCompany").attr("enctype", "multipart/form-data" );
			$("#frmCompany").attr("action", reqUrl);
			$("#frmCompany").attr("target","_self");
			$("#frmCompany").submit();
		}
	}

</script>

<form id="frmCompany" name="frmCompany"  method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" id="companyId" name="companyId" />
<h2>기업배정</h2>

<table class="type-write wp100">

			<tbody><tr>
				<th class="border-left">기업배정</th>
				<td class="border-left">
					<input type="file" name="uploadExcelFile" id="uploadExcelFile" style="width:50%;">&nbsp;&nbsp;
						<a class="btn btn-primary btn-mmd" href="/la/statistics/company/listCompanyStatExcelDownload2.do" onclick="javascript:fn_excel_file_down();">미배정 인원 템플릿 다운로드</a>&nbsp;&nbsp;
						<a class="btn btn-primary btn-mmd" href="/la/statistics/company/listCompanyStatExcelDownload1.do">기업코드 다운로드</a>&nbsp;&nbsp;
						<a class="btn btn-primary btn-mmd" href="#fn_excel_upload" onclick="javascript:fn_excel_upload();">엑셀 업로드</a>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<%-- 
<ul id="student-popup" style="display:none;">
	<li class="company-area">
		<h1>기업체 검색</h1>
		<div class="search-box-1 mb-020">
			<input type="text" id="searchKeyword" name="searchKeyword"placeholder="기업명을 입력" value="${searchKeyword}" />
			<a href="#!" onclick="javascript:fn_search(1);">조회</a>
			<a href="#!" onclick="javascript:fn_searchKeywordNo(1);">전체 조회</a>
		</div><!-- E : search-box-1 -->

		<div class="table-responsive">
		<table class="type-2">
				<colgroup>
					<col width="7%" />
					<col width="24%" />
					<col width="*" />
					<col width="12%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th>선택</th>
						<th>기업명</th>
						<th>소재지</th>
						<th>선정일</th>
						<th>기업고용보험관리번호</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultCompanyList}" varStatus="status">
					<tr>
						<td><input type="radio" name="tempCompanyId" id="tempCompanyId" value="${result.companyId}||${result.companyName}||${result.address}||${result.choiceDay}||${result.traningProcessId}||${result.hrdTraningName}"></td>
						<td>${result.companyName}</td>
						<td>${result.address}</td>
						<td>${result.choiceDay}</td>
						<td>${result.employInsManageNo}</td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(resultCompanyList) == 0}">
					<tr>
						<td colspan="6"><spring:message code="common.nodata.msg" /></td>
					</tr>
					</c:if>
				</tbody>
			</table>
			</div><!-- E : 기업체검색 -->

			<c:if test="${fn:length(resultCompanyList) != 0}">
			<div class="page-num mt-015">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_searchPaging" />
			</div>
			</c:if>

		<div class="btn-area align-center mt-010">
			<a href="#fn_closeCompanypop" class="yellow close" onclick="javascript:fn_closeCompanypop(); return false" onkeypress="this.onclick();">닫기</a>
			<a href="#fn_hideCompanypop" class="orange close" onclick="javascript:fn_hideCompanypop(); return false" onkeypress="this.onclick();">확인</a>
		</div><!-- E : btn-area -->
	</li>

	<li class="popup-bg"></li>
</ul><!-- E : student-popup -->

	<div id="">
			<h2>학습근로자 현황</h2>
			<div class="group-area mb-020">
				<table class="type-2" id="styleDisplay1">
					<colgroup>
						<col style="width:*" />
						<col style="width:*" />
						<col style="width:*" />
						<col style="width:*" />
					</colgroup>
					<thead>
						<tr>
							<th>기업명</th>
							<th>소재지</th>
							<th>선정일</th>
							<th>기업고용보험관리번호</th>
						</tr>
					</thead>
					<tbody>
						<tr class="list-hide" style="display:none">
							<td id="companyName"></td>
							<td id="address"></td>
							<td id="choiceDay"></td>
							<td id="employInsManageNo"></td>
						</tr>
						<tr class="list-show">
							<td colspan="4">자료가 없습니다. 기업체 검색버튼을 클릭하여 하나의 기업체를 선택해주세요</td>
						</tr>
					</tbody>
				</table>

				<table class="type-2" id="styleDisplay2" style="display:none">
					<colgroup>
						<col style="width:*" />
						<col style="width:*" />
						<col style="width:*" />
						<col style="width:*" />
					</colgroup>
					<thead>
						<tr>
							<th>기업명</th>
							<th>소재지</th>
							<th>선정일</th>
							<th>기업고용보험관리번호</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultCompanyTraningProcessList}" varStatus="status">
						<tr>
							<td>${result.companyName}</td>
							<td>${result.address}</td>
							<td>${result.choiceDay}</td>
							<td>${result.employInsManageNo}</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(resultCompanyTraningProcessList) == 0}">
						<tr>
							<td colspan="4">자료가 없습니다. 기업체 검색버튼을 클릭하여 하나의 기업체를 선택해주세요</td>
						</tr>
						</c:if>
					</tbody>
				</table>

				<div class="btn-area align-right mt-010">
					<a href="#fn_showCompanypop" class="yellow" onclick="javascript:fn_showCompanypop(); return false" onkeypress="this.onclick();">기업체 검색</a>
				</div><!-- E : btn-area -->
			</div>

		<div class="group-area mt-010">
			<table class="type-2">
				<colgroup>
					<col style="width:40px" />
					<col style="width:40px" />
					<col style="width:*" />
					<col style="width:*" />
					<col style="width:*" />
					<col style="width:*" />
					<col style="width:*" />
					<col style="width:*" />
					<col style="width:70px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="check0" id="check0" onclick="javascript:com.checkAll('check0','memIdArr');" class="choice" /></th>
						<th>번호</th>
						<th>학과</th>
						<th>성명</th>
						<th>학번</th>
						<th>핸드폰</th>
						<th>이메일</th>
						<th>훈련과정명</th>
						<th>학적상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultMemberStdList}" varStatus="status">
					<tr>
						<td><input type="checkbox" id="check1" name="memIdArr" value="${result.memId}" class="choice" /></td>
						<td>${status.count}</td>
						<td>${result.departmentName}</td>
						<td>${result.memName}</td>
						<td><a href="#fn_updatePage" onclick="javascript:fn_updatePage('${result.memSeq}'); return false"><font color="blue">${result.memId}</font></a></td>
						<c:if test="${result.hpNo1 == '' }">
							<td></td>
						</c:if>
						<c:if test="${result.hpNo1 != '' }">
							<td>${result.hpNo1}-****-${result.hpNo3}</td>
						</c:if>
						<td>${result.email1}**${result.email2}</td>
						<td>${result.hrdTraningName}</td>
						<td>${result.deleteName}<c:if test="${result.deleteYn eq 'Y'}"><br />(${result.deleteDt})</c:if></td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(resultMemberStdList) == 0}">
					<tr>
						<td colspan="9">자료가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>

			<div class="btn-area align-right mt-010">
				<a href="#fn_smsSend" onclick="javascript:sms(); return false" class="yellow">SMS</a>
				<a href="#fn_mailSend" onclick="javascript:email(); return false" class="orange">E-MAIL</a>
			</div>

		</div><!-- E :  list-->

		
	</div><!-- E : container -->
	
	<script type="text/javascript">

	 
	</script>
</form> --%>






