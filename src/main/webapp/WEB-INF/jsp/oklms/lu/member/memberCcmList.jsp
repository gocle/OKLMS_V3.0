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
		var ccmMappingCnt = '${ccmMappingCnt}';

		if('POPUP_LIST_FAIL' != returnMsg && returnMsg != ''){
			$("#searchKeyword").val('${searchKeyword}');
			fn_showCompanypop();
		}

		$(".tab-name-12").addClass('on');
		//alert("cnt="+cnt);

		if(ccmMappingCnt == '0'){
		} else {
		}

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

/* 	function press(event) {
		if (event.keyCode==13) {
			fn_search();
		}
	} */

	/* 기업체 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyMember.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	//초기화 기업체 리스트 조회
	function fn_searchKeywordNo( param1 ){
		$("#searchKeyword").val('');
		$("#searchKeywordNull").val('allSearch');
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyMember.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	//기업체검색 목록에서 페이징 번호 클릭시 리스트 조회
	function fn_searchPaging( param1 ){
		$("#pageIndex").val( param1 );

		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyMember.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	/* 개설강좌 매핑정보 삭제 */
	function fn_del(){
		if (confirm("삭제 하시겠습니까?")) {
			var checkedVals = com.getCheckedVal('check0','check1');
			//var checkedVals = com.getCheckedVal('memIdArr','memIdArr');
			if(checkedVals == ""){
				alert("HRD전담자를 선택해주세요!.");
				return false;
			}

			$("#memSeq").val( checkedVals );

			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteMemberList.do";

			$("#frmMember").attr("action", reqUrl);
			$("#frmMember").attr("target", "_self");
			$("#frmMember").submit();
		}
	}

	/* 개설강좌 매핑정보 수정 */
	function fn_update(){
		if (confirm("기업체 훈련과정 매핑정보를 수정 하시겠습니까?")) {
			
			
			//var checkedVals = com.getCheckedVal('check0','check1');
			var checkedVals = com.getCheckedVal('memIdArr','memIdArr');
			
			if(checkedVals == ""){
				alert("HRD전담자를 선택해주세요!.");
				return false;
			}

			$("#memSeq").val( checkedVals );

			var reqUrl = CONTEXT_ROOT + targetUrl + "updateMemberCcmList.do";

			$("#frmMember").attr("action", reqUrl);
			$("#frmMember").attr("target", "_self");
			$("#frmMember").submit();
		}
	}

	function fn_showCompanypop( ){
		$("#student-popup").show();
		$(".company-area,.popup-bg").addClass("open");
		window.location.hash = "#open";
	}

	function fn_closeCompanypop( ){
		$("#student-popup").hide();
		$(".company-area,.popup-bg").removeClass("open");
	}

	function fn_hideCompanypop( ){
		var obj = "";
		obj = $("input:radio[name='tempCompanyId']:checked").val();
		if(undefined == obj){
			alert("HRD전담자를 엑셀일괄등록할 기업체를 선택하여주십시오. ")
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

	//기업체에 매핑된 회원정보 목록 조회
	function fn_listTraningProcessManage( param1 ){

		$("#companyId").val(param1);
		$("#tempTraningProcessId").val('noDivPopup');
		$("#memberType").val('CCM');

		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyMember.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}

	// 훈련과정 정보 셋팅
	function fn_setTraningPopInfo(obj){
		if( obj ){
			var arrInfo = obj.split("||");
			var traningProcessId = arrInfo[0];
			var hrdTraningName = arrInfo[1];
			var memSeq = arrInfo[2];

			$("#traningProcessId-"+memSeq).val(traningProcessId);
			$("#hrdTraningName-"+memSeq).html(hrdTraningName);
		}
	}

	/*  엑셀일괄등록 */
	function fn_excel_upload(){

		if($("input:file[name=uploadExcelFile]").val() == ""){
			alert("첨부할 파일이 존재하지 않습니다.");
			return;
		}

		if($("#companyId").val() == ''){
			alert("HRD전담자 회원정보를 일괄등록할 기업체를 선택해주세요.!");
			return;
		}

		var src = $("#uploadExcelFile").val();

		 if(!src.match(/\.(xls)$/i)) {
		      alert("엑셀(xls) 파일만 업로드 가능합니다.");
		      return;
		}

		if(confirm("작성한 엑셀파일로 HRD전담자 회원정보를 일괄 등록 하시겠습니까?")){

		    var reqUrl = CONTEXT_ROOT + targetUrl + "insertMemberExcel.do";

		    $("#frmMember").attr("method", "post" );
			$("#frmMember").attr("enctype", "multipart/form-data" );
			$("#frmMember").attr("action", reqUrl);
			$("#frmMember").attr("target","_self");
			$("#frmMember").submit();
		}
	}

	/*  엑셀일괄등록 양식 다운로드 */
	function fn_file_down(){
		var uploadFilePath = "/downloadfiles/";
	    $("#filename").val("CcmMemberSaveForm.xls");
	    $("#uploadFilePath").val(uploadFilePath);

	    var reqUrl = CONTEXT_ROOT + "/simpleDown.sv";
	    $("#frmDownLoad").attr("action",reqUrl);
	    $("#frmDownLoad").submit();
	}

	//교과목 검색 매핑
	function fn_addTraingSearchPopup( param1 ){

		$("#memSeq").val( param1 );

		popOpenWindow("", "popSearch", 850, 560);

		var reqUrl = CONTEXT_ROOT + "/lu/popup/goPopupSearchTraingName.do";

		$("#frmMember").attr("target", "popSearch");
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}

 

	//기업체에 매핑된 회원정보 목록 탭버튼 클릭시
	function fn_showTabbtn( param1 ){

		doActionShowTabbtn( param1 );

		$("#memberType").val(param1);
		$("#tempTraningProcessId").val('noDivPopup');

		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyMember.do";

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
	
	function fn_insertPage(){
		var companyId = "";
		companyId = $("#companyId").val();
		if(companyId == ''){
			alert("기업체 정보가 없습니다. 기업체검색버튼을 클릭하여 기업체 선택후 탭버튼을 클릭해주세요.");
			return false;
		}
		
		var reqUrl = "/lu/member/insertCompMemberPage.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}
	
	function fn_updatePage(memSeq){
		
		var companyId = "";
		companyId = $("#companyId").val();
		if(companyId == ''){
			alert("기업체 정보가 없습니다. 기업체검색버튼을 클릭하여 기업체 선택후 탭버튼을 클릭해주세요.");
			return false;
		}
		
		$("#memSeq").val(memSeq);
		var reqUrl = "/lu/member/updateCompMemberPage.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}
	
	
</script>

<!--  템플릿다운로드용 -->
<form id="frmDownLoad" >
	<input type="hidden"  name="filename" id="filename"  />
	<input type="hidden"  name="uploadFilePath" id="uploadFilePath" />
</form>

<!--  회원정보용 -->
<form id="frmMember" name="frmMember" method="post">
<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />
<input type="hidden" name="memSeq" id="memSeq" />
<input type="hidden" name="memberType" id="memberType" value="CCM" />
<input type="hidden" id="companyId" name="companyId" value="${companyId}" />
<input type="hidden" id="companyName" name="companyName" />
<input type="hidden" id="traningProcessId" name="traningProcessId" />
<input type="hidden" id="searchKeywordNull" name="searchKeywordNull"/>
<input type="hidden" id="tempTraningProcessId" name="tempTraningProcessId" />

<ul id="student-popup" style="display:none;">
	<li class="company-area" >
		<h1>기업체 검색</h1>
		<div class="search-box-1 mb-020">
			<input type="text" id="searchKeyword" name="searchKeyword" placeholder="기업명을 입력" value="${searchKeyword}" />
			<a href="#!" onclick="javascript:fn_search(1); return false">조회</a>
			<a href="#!" onclick="javascript:fn_searchKeywordNo(1); return false">전체 조회</a>
		</div><!-- E : search-box-1 -->

		<div class="table-responsive">
		<table class="type-2">
				<colgroup>
					<col width="10%" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
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
						<td><input type="radio" name="tempCompanyId" id="tempCompanyId" value="${result.companyId}"></td>
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
			</div>
			<!-- E : 기업체검색 -->

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
			<h2>기업전담자 관리</h2>
			<div class="group-area mb-020">
				<table class="type-2" id="styleDisplay1">
					<colgroup>
						<col style="width:400px;" />
						<col style="width:*" />
						<col style="width:150px;" />
						<col style="width:150px;" />
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
						<col style="width:400px;" />
						<col style="width:*" />
						<col style="width:150px;" />
						<col style="width:150px;" />
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
							<td class="left">${result.address}</td>
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

			<dl id="tab-type-2">
		<dt class="tab-name-11"><a href="#fn_showTabbtn" onclick="javascript:fn_showTabbtn('COT'); return false">기업현장교사</a></dt>
		<dd id="tab-content-11" style="display:none;"></dd>

		<dt class="tab-name-12"><a href="#fn_showTabbtn" onclick="javascript:fn_showTabbtn('CCM'); return false">HRD 담당자</a></dt>
		<dd id="tab-content-12" style="display:block;">

			<div class="group-area mt-010">
				<table class="type-2">
					<colgroup>
						<col style="width:40px" />
						<col style="width:80px" />
						<col style="width:100px" />
						<col style="width:200px" />
						<col style="width:200px" />
						<col style="width:200px" />
						<col style="width:200px" />
						<col style="width:*" />
						<col style="width:80px" />
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="check0" name="check0" onclick="javascript:com.checkAll('check0','memIdArr');" class="choice" /></th>
							<th>번호</th>
							<th>성명</th>
							<th>아이디</th>
							<th>주민등록번호</th>
							<th>핸드폰</th>
							<th>이메일</th>
							<th>훈련과정명</th>
							<th>변경</th>
							<th>재직증명서</th>
							<th>교육수료증</th>								
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultMemberCcmList}" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" id="memIdArr" name="memIdArr" value="${result.memId}" class="choice" />
							</td>
							<td>${status.count}</td>
							<td>${result.memName}</td>
							<td><a href="#fn_updatePage" onclick="javascript:fn_updatePage('${result.memSeq}'); return false"><font color="blue">${result.memId}</font></a></td>
							<td>
								${result.memBirth}-<c:if test="${result.sex == 'M' }">1</c:if><c:if test="${result.sex == 'F' }">2</c:if>******
							</td>
							<%-- <c:if test="${result.hpNo1 == '' }">
								<td></td>
							</c:if>
							<c:if test="${result.hpNo1 != '' }">
								<td>${result.hpNo1}-****-${result.hpNo3}</td>
							</c:if> --%>
							<td>${result.hpNo}</td>
							<td>${result.email1}**${result.email2}</td>
							<td id="hrdTraningName-${result.memSeq}">${result.hrdTraningName}</td>
							<td>
								<a href="#fn_addTraingSearchPopup" onclick="javascript:fn_addTraingSearchPopup('${result.memSeq}'); return false" class="btn-full-blue">변경</a>
								<input type="hidden" id="traningProcessId-${result.memSeq}" name="traningProcessId-${result.memSeq}" />
								<input type="hidden" id="oldTraningProcessId-${result.memSeq}" name="oldTraningProcessId-${result.memSeq}" value="${result.traningProcessId}" />
							</td>
							<td>
								<c:if test="${not empty result.atchFileId}">
								<a href="javascript:com.downFile('${result.atchFileId}','1');" class="text-file">다운로드</a>
								</c:if>
							</td>
							<td>
								<c:if test="${not empty result.atchFileId2}">
								<a href="javascript:com.downFile('${result.atchFileId2}','1');" class="text-file">다운로드</a>
								</c:if>
							</td>								
						</tr>
						</c:forEach>
						<c:if test="${fn:length(resultMemberCcmList) == 0}">
						<tr>
							<td colspan="11">자료가 없습니다.</td>
						</tr>
						</c:if>
					</tbody>
				</table>

				<div class="btn-area align-right mt-010">
					<a href="#fn_file_down" class="yellow float-left" onclick="javascript:fn_file_down(); return false">템플릿다운로드</a>
					<a href="#fn_excel_upload" class="orange float-left" onclick="javascript:fn_excel_upload(); return false">엑셀 업로드</a>
					<p class="course-input float-left">
						&nbsp;&nbsp;<input type="file" name="uploadExcelFile" id="uploadExcelFile" style="width:300px;" />
					</p>
					<a href="#fn_insertPage" onclick="javascript:fn_insertPage(); return false" class="orange">신규등록</a>
					<a href="#fn_smsSend" onclick="javascript:sms(); return false" class="yellow">SMS</a>
					<a href="#fn_mailSend" onclick="javascript:email(); return false" class="orange">E-MAIL</a>
					<a href="#fn_del" onclick="javascript:fn_del(); return false" class="gray-3">삭제</a>
					<a href="#fn_update" onclick="javascript:fn_update(); return false" class="gray-3">수정</a>
				</div>

			</div><!-- E :  list-->
		</dd>


	</dl>
	</div><!-- E : container -->


</form>






