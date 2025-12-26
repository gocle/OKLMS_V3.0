<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%-- <script type="text/javascript" src="${contextRootJS }/js/jquery/plugins/blockUI/jquery.blockUI.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/jquery/jquery.maskedinput.js"></script> --%>
<script type="text/javascript">

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
		com.datepickerDateFormat('startDate', 'button');
		com.datepickerDateFormat('endDate', 'button');
	}


	/* 화면이 로드된후 처리 초기화 */
	function initHtml() {
		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
		//기업체 검색 팝업 조회 성공여부
		var returnMsg = "";
		returnMsg = '${returnMsg}';
		var cnt = '${resultTraningProcessListCnt}';
		var tdOffJtTotalCnt = '${tdOffJtTotalCnt}';

		$("#companyId").val('${tempCompanyId}');
	//	$("#companyName").html('${tempCompanyName}');
		$("#address").html('${tempAddress}');
		$("#choiceDay").html('${tempChoiceDay}');
		$("#employInsManageNo").html('${tempEmployInsManageNo}');

		$("#tempCompanyName").val('${tempCompanyName}');
		$("#tempAddress").val('${tempAddress}');
		$("#tempChoiceDay").val('${tempChoiceDay}');
		$("#tempEmployInsManageNo").val('${tempEmployInsManageNo}');

		if('POPUP_LIST_FAIL' != returnMsg && returnMsg != ''){
			$("#searchKeyword").val('${searchKeyword}');
			fn_showCompanypop();
		}
		
		if(cnt == '' || cnt == '0'){
			if(cnt == '0'){
				$(".list-show").hide();
				$(".list-hide").show();
			} else {
				$(".list-show").show();
				$(".list-hide").hide();
			}

			$("#styleDisplay1").hide();
			$("#styleDisplay2").hide();
		} else {
			$(".list-show").hide();
			$(".list-hide").show();
			$("#styleDisplay1").show();

			//if(tdOffJtTotalCnt != '' && tdOffJtTotalCnt != '0'){
				$("#styleDisplay2").show();
				$("#styleDisplay3").show();
			//}
		}
	}

	/*====================================================================
		사용자 정의 함수
	====================================================================*/
	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}

	/* 기업체 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = "/lu/traning/listTraningProcessManage.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//초기화 기업체 리스트 조회
	function fn_searchKeywordNo( param1 ){
		$("#searchKeywordNull").val('allSearch');
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = "/lu/traning/listTraningProcessManage.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//기업체검색 목록에서 페이징 번호 클릭시 리스트 조회
	function fn_searchPaging( param1 ){
		$("#pageIndex").val( param1 );

		var reqUrl = "/lu/traning/listTraningProcessManage.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//훈련과정 추가 신규입력화면 이동
	function fn_goInsert(){

		if($("#companyId").val() == ''){
			alert("기업체 정보가 없습니다. 기업체 검색 버튼을 클릭하여 기업체를 선택하여주십시오.");
			return false;
		}

		var reqUrl = "/lu/traning/goInsertTraningProcessManageList.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//훈련과정관리에 메핑된 개설강좌 목록 조회
	function fn_detail(param1, param2, param3){
		$("#companyId").val(param1);
		$("#traningProcessId").val(param2);
		$("#traningProcessManageId").val(param3);
		
		$("#tempTraningProcessId").val('noDivPopup');

		var reqUrl = "/lu/traning/listTraningProcessManage.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//기업체검색후 기업체 훈련과정 메핑 목록 조회
	function fn_listTraningProcessManage( param1 ){

		$("#companyId").val(param1);
		$("#tempTraningProcessId").val('noDivPopup');
		$("#pageIndex").val("1");
		

		var reqUrl = "/lu/traning/listTraningProcessManage.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
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
			alert("훈련과정관리를 처리할 하나의 기업체를 선택하여주십시오. ")
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
			var companyName = arrInfo[1];
			var address = arrInfo[2];
			var choiceDay = arrInfo[3];
			var employInsManageNo = arrInfo[4];

			$("#companyId").val(companyId);
			$("#companyName").html(companyName);
			$("#address").html(address);
			$("#choiceDay").html(choiceDay);
			$("#employInsManageNo").html(employInsManageNo);

			//서버단에서 사용하기위해 Temp성 항목정의
			$("#tempCompanyName").val(companyName);
			$("#tempAddress").val(address);
			$("#tempChoiceDay").val(choiceDay);
			$("#tempEmployInsManageNo").val(employInsManageNo);
			//companyId 값이 있으면 훈련과정명 및 훈련과정번호 정보를 가지고올 Json 서버로직을 수행한다.
			if(companyId != ''){
				fn_listTraningProcessManage( companyId );
			} //companyId 비교 if문 End
		} //obj 훈련과정마스터에 메핑된 개설강좌 정보 if문 End
	}

	//훈련과정 마스터 및 개설강좌 메핑 데이타 삭제
	function fn_delete(){
		if (confirm("삭제 하시겠습니까?")) {

			var obj = "";
			obj = $("input:radio[name='traningProcessIdArr']:checked").val();
			if(undefined == obj){
				alert("삭제 처리할 훈련과정을 선택하여주십시오. ")
				return false;
			}

			var reqUrl = "/lu/traning/deleteTraningProcessManage.do";

			$("#frmTraning").attr("action", reqUrl);
			$("#frmTraning").attr("target", "_self");
			$("#frmTraning").submit();
		}
	}

	//훈련과정 수정화면으로 이동
	function fn_goUpdate( ){

		var obj = "";
		obj = $("input:radio[name='traningProcessIdArr']:checked").val();
		if(undefined == obj){
			alert("수정 처리할 훈련과정을 선택하여주십시오. ")
			return false;
		}

		var reqUrl = "/lu/traning/goUpdateTraningProcessManageList.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//훈련과정 첫화면으로 이동
	function fn_goList( ){
		$("#companyId").val('');
		$("#traningProcessId").val('');
		$("#tempTraningProcessId").val('noDivPopup');

		var reqUrl = "/lu/traning/listTraningProcessManage.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}
	
	function fn_info_save( ){
		var reqUrl = "/lu/traning/saveTraningProcessManage.json";
		var param = $("#frmTraning").serializeArray();
		com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			
		} else {
			alert("저장에 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});
		
		var reqUrl = "/lu/traning/saveTraningProcess.json";
		var param = $("#frmTraning").serializeArray();
		com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			
		} else {
			alert("저장에 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});
		
	}
	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}

</script>

<!-- 훈련과정관리용 끝 -->
<form id="frmTraning" name="frmTraning" method="post">
<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />
<input type="hidden" id="companyId" name="companyId"/>
<input type="hidden" id="traningProcessId" name="traningProcessId" value="${param.traningProcessId }"/>
<input type="hidden" id="uiGubun" name="uiGubun" value="traningProcessCompanyPop" />
<input type="hidden" id="returnUrl" name="returnUrl" value="/lu/traning/traningProcessManageList" />
<input type="hidden" id="traningProcessManageId" name="traningProcessManageId" value="${param.traningProcessManageId }" />

<!-- Temp용 항목 -->
<input type="hidden" id="tempCompanyName" name="tempCompanyName"/>
<input type="hidden" id="tempAddress" name="tempAddress"/>
<input type="hidden" id="tempChoiceDay" name="tempChoiceDay"/>
<input type="hidden" id="tempEmployInsManageNo" name="tempEmployInsManageNo"/>
<input type="hidden" id="tempTraningProcessId" name="tempTraningProcessId" />
<input type="hidden" id="searchKeywordNull" name="searchKeywordNull"/>

<ul id="student-popup" style="display:none;">
	<li class="company-area" >
		<h1>기업체 검색</h1>
		<div class="search-box-1 mb-020">
			<input type="text" id="searchKeyword" name="searchKeyword" placeholder="기업명을 입력" value="${searchKeyword }"  class="mb-005" />
			<a href="#!" onclick="javascript:fn_search(1); return false"  class="mb-005" >조회</a>
			<a href="#!" onclick="javascript:fn_searchKeywordNo(1); return false"  class="mb-005" >전체조회</a>
		</div><!-- E : search-box-1 -->

		<div class="table-responsive">
			<table class="type-2 w800">
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
							<th>고용보험관리번호</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultCompanyList}" varStatus="status">
						<tr>
							<td><input type="radio" name="tempCompanyId" id="tempCompanyId" value="${result.companyId}||${result.companyName}||${result.address}||${result.choiceDay}||${result.employInsManageNo}"></td>
							<td>${result.companyName}</td>
							<td class="left">${result.address}</td>
							<td>${result.choiceDay}</td>
							<td>${result.employInsManageNo}</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(resultCompanyList) == 0}">
						<tr>
							<td colspan="5"><spring:message code="common.nodata.msg" /></td>
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
</ul> <!-- E : student-popup -->

	<div id="">
			<h2><c:out value="${curMenu.menuTitle }" /></h2>
			<div class="group-area">
				<div class="table-responsive mt-010">
					<table class="type-2">
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
								<td id="companyName">${tempCompanyName}</td>
								<td id="address"></td>
								<td id="choiceDay"></td>
								<td id="employInsManageNo"></td>
							</tr>
							<tr class="list-show">
								<td colspan="4">자료가 없습니다. 기업체 검색버튼을 클릭하여 하나의 기업체를 선택해주세요</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="btn-area  mt-010">
					<div class="float-right">
						<a href="#fn_showCompanypop" class="yellow" onclick="javascript:fn_showCompanypop(); return false" onkeypress="this.onclick();">기업체 검색</a>
						<a href="#fn_goInsert" class="orange" onclick="javascript:fn_goInsert(); return false" onkeypress="this.onclick();">훈련과정 추가</a>
					</div>
				</div><!-- E : btn-area -->
			</div>
	</div><!-- E : container -->


	<table id="styleDisplay1" class="type-2 mt-020 wp100" style="display:none">
		<colgroup>
			<col style="width:*" />
			<col style="width:100px;" />
			<col style="width:400px;" />
		</colgroup>
		<thead>
		<tr>
			<th>훈련과정명</th>
			<th>회차</th>
			<th>훈련과정번호</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultTraningProcessList}" varStatus="status">
		<tr>
			<td><a href="#fn_detail" onclick="javascript:fn_detail('${result.companyId}','${result.traningProcessId}','${result.traningProcessManageId}')" class="text">${result.hrdTraningName}</a></td>
			<td>${result.traningProcessPeriod}</td>
			<td>${result.hrdTraningNo}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	
	
	<div id="styleDisplay3" class="group-area mt-020" style="display:none">
	<div class="table-responsive mt-010" style="width: 100%; overflow-x:auto;">
		
		<!-- 검색조건유지 필드 끝 -->
		<table class="type-2">
			<tbody>
				<tr>
					<th width="132px">훈련과정명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
					<td>
						<input type="text" id="traningProcessName" name="traningProcessName"  value="${traningProcessVO.traningProcessName}"   style="width:90%" maxlength="50" />	
					</td>      
					<th width="132px">훈련과정번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
			  		<td>
			  			<input type="text" id="traningProcessNo" name="traningProcessNo"  value="${traningProcessVO.traningProcessNo}" style="width:90%" maxlength="30"   />	
			  		</td>
			  		<th width="132px">훈련과정회차<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
			  		<td>
			  			<input type="text" id="traningProcessPeriod" name="traningProcessPeriod" onkeydown="onlyNumber(this);"  value="${traningProcessVO.traningProcessPeriod}" style="width:90%" maxlength="5"   />	
			  		</td>    
				</tr>
				<tr>
					<th>실시년도</th>
					<td>
						<input type="text" id="year" name="year"  value="${traningProcessVO.year}" maxlength="4" onkeydown="onlyNumber(this);" style="width:90%" />
					</td>
					<th>훈련시작일</th>
					<td>
						<input type="text" id="startDate" name="startDate"  value="${traningProcessVO.startDate}" style="width:80%" />
					</td>      
					<th>훈련종료일</th>
					<td colspan="3">
						<input type="text" id="endDate" name="endDate"  value="${traningProcessVO.endDate}" style="width:80%" />
					</td>    
				</tr>
				<tr>
					<th>훈련상태</th>
					<td style="text-align: left;">
							&nbsp;<select id="traningStatusCd" name="traningStatusCd"  >
								<option value="">::선택::</option>
								<option value="1" ${traningProcessVO.traningStatusCd eq '1' ? 'selected' : ''}>진행중</option>
								<option value="2" ${traningProcessVO.traningStatusCd eq '2' ? 'selected' : ''}>전체중탈</option>
								<option value="3" ${traningProcessVO.traningStatusCd eq '3' ? 'selected' : ''}>훈련중지</option>
								<option value="4" ${traningProcessVO.traningStatusCd eq '4' ? 'selected' : ''}>종료</option>
							</select>
					</td>
					<th>과정구분</th>
					<td colspan="3" style="text-align: left;">
						&nbsp;<select id="traningTypeCd" name="traningTypeCd"  >
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
						<input type="text" id="ncsLicenceName" name="ncsLicenceName"  value="${traningProcessVO.ncsLicenceName}" maxlength="20" style="width:90%" />
					</td>
					<th>NCS 자격수준</th>
					<td>
						<input type="text" id="ncsLicenceLevel" name="ncsLicenceLevel"  value="${traningProcessVO.ncsLicenceLevel}" maxlength="20" style="width:90%" />
					</td>      
					<th>NCS 자격버전</th>
					<td>
						<input type="text" id="ncsLicenceVersion" name="ncsLicenceVersion"  value="${traningProcessVO.ncsLicenceVersion}" maxlength="20" style="width:90%" />
					</td>    
				</tr>
				
				<tr>
					<th>NCS 코드</th>
					<td>
						<input type="text" id="ncsCode" name="ncsCode"  value="${traningProcessVO.ncsCode}" maxlength="20" style="width:90%" />
					</td>
					<th>NCS 명</th>
					<td>
						<input type="text" id="ncsName" name="ncsName"  value="${traningProcessVO.ncsName}" maxlength="20" style="width:90%" />
					</td>  
					<th>등급</th>
					<td>
						<input type="text" id="centerGrade" name="centerGrade"  value="${traningProcessVO.centerGrade}" maxlength="20" style="width:90%" />
					</td>      
				</tr>
				
				<tr>
					<th>OJT 분반</th>
					<td>
						<input type="text" name="ojtClass" id="ojtClass" value="${traningInfoVO.ojtClass}" placeholder="예) 2분반 > 02분반으로 숫자 2자리" onkeydown="onlyNumber(this);" maxlength="2" style="width:90%" />
					</td>
					<th>OJT 훈련시간</th>
					<td>
						<input type="text" id="ojtTimeHour" name="ojtTimeHour"  value="${traningProcessVO.ojtTimeHour}" onkeydown="onlyNumber(this);" maxlength="4" style="width:90%" />
					</td>
					<th>Off-JT 훈련시간</th>
					<td>
						<input type="text" id="offTimeHour" name="offTimeHour"  value="${traningProcessVO.offTimeHour}" onkeydown="onlyNumber(this);" maxlength="4" style="width:90%" />
					</td>  
				</tr>
				<tr>
					<th>NCS 자격 매핑</th>
					<td colspan="5" style="text-align: left" style="width:90%">
						<select id="licenceId" name="licenceId" >
							<option value="">선택</option>
							<c:forEach var="result" items="${ncsList}" varStatus="status">
								<option value="${result.licenceId}" ${result.licenceId eq traningProcessVO.licenceId ? 'selected' : ''}>${result.licenceName}_${result.licenceLevel}_${result.licenceVersion}</option>
							</c:forEach>
						</select>
					</td>      
				</tr>
				
				<tr>
					<th>특이사항</th>
					<td colspan="5" style="width:90%">
						<textarea  id="centerBigo" name="centerBigo" maxlength="100"  rows="" cols="">${traningProcessVO.centerBigo}</textarea>
					</td>      
				</tr> 
				
			</tbody>
		</table>
		
		<%-- <table class="type-2">
			<colgroup>
				<col style="width:0px" />
				<col style="width:110px" />
				<col style="width:110px" />
				<col style="width:110px" />
				<col style="width:110px" />
				<col style="width:110px" />
				<col style="width:110px" />
				<col style="width:110px" />
				<col style="width:500px" />
			</colgroup>
			<thead>
				<tr>
					<th>OJT분반</th>
					<th>학습일지(월)</th>
					<th>학습활동서(월)</th>
					<th>훈련과정상태</th>
					<th>Off-JT 훈련비(월)</th>
					<th>OJT 훈련비(월)</th>
					<th>전담자(월)</th>
					<th>등급</th>
					<th>특이사항</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text"  name="ojtClass" id="ojtClass" value="${traningInfoVO.ojtClass}" maxlength="5" /></td>
					<td><input type="text"  name="noteMonth" id="noteMonth" value="${traningInfoVO.noteMonth}" maxlength="2" /></td>
					<td><input type="text"  name="actMonth" id="actMonth" value="${traningInfoVO.actMonth}" maxlength="2" /></td>
					<td>
						<select name="processStatus" id="processStatus">
							<option value="1" ${traningInfoVO.processStatus eq '1' ? 'selected' : ''}>진행중</option>
							<option value="2" ${traningInfoVO.processStatus eq '2' ? 'selected' : ''}>전체중탈</option>
							<option value="3" ${traningInfoVO.processStatus eq '3' ? 'selected' : ''}>훈련중지</option>
							<option value="4" ${traningInfoVO.processStatus eq '4' ? 'selected' : ''}>종료</option>
							<option value="5" ${traningInfoVO.processStatus eq '5' ? 'selected' : ''}>수료보고</option>
							<option value="6" ${traningInfoVO.processStatus eq '6' ? 'selected' : ''}>최종정산</option>
						</select>
					
					</td>
					<td><input type="text"  name="offMonthBiyong" id="offMonthBiyong" value="${traningInfoVO.offMonthBiyong}" maxlength="20" /></td>
					<td><input type="text"  name="ojtMonthBiyong" id="ojtMonthBiyong" value="${traningInfoVO.ojtMonthBiyong}" maxlength="20" /></td>
					<td><input type="text"  name="ccnMonth" id="ccnMonth" value="${traningInfoVO.ccnMonth}" maxlength="2" /></td>
					<td><input type="text"  name="ccnGrade" id="ccnGrade" value="${traningInfoVO.ccnGrade}" maxlength="5" /></td>
					<td>
					<textarea rows="" cols="" maxlength="200" name="ccnBigo" id="ccnBigo">${traningInfoVO.ccnBigo}</textarea>
				</tr>
			</tbody>
		</table> --%>
	</div>

	<div class="btn-area mt-010">
		<div class="float-right">
			<a href="#fn_info_save" class="yellow" onclick="javascript:fn_info_save();">수정</a>
		</div>
	</div><!-- E : btn-area -->
</div><!-- E : 훈련과정명 -->
	

	<%-- <div id="styleDisplay2" class="group-area mt-020" style="display:none">
	<div class="table-responsive mt-010">
		<table class="type-2">
			<colgroup>
				<col style="width:40px" />
				<col style="width:180px" />
				<col style="width:180px" />
				<col style="width:80px" />
				<col style="width:*" />
				<col style="width:60px" />
			</colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>훈련과정명</th>
					<th>훈련과정번호</th>
					<th>구분</th>
					<th>개설강좌명</th>
					<th>분반</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="${(tdOffJtTotalCnt+tdOjtTotalCnt)}"><input type="radio" name="traningProcessIdArr" checked="checked" id="traningProcessIdArr" value="${offJtTraingOneVO.companyId},${offJtTraingOneVO.companyName},${offJtTraingOneVO.traningProcessId}"></td>
					<td rowspan="${(tdOffJtTotalCnt+tdOjtTotalCnt)}">${offJtTraingOneVO.hrdTraningName}</td>
					<td rowspan="${(tdOffJtTotalCnt+tdOjtTotalCnt)}">${offJtTraingOneVO.hrdTraningNo}</td>
					<c:forEach var="result" items="${resultOffjtSubjectInfoList}" varStatus="status">
					<c:if test="${status.count == 1}">
						<td rowspan="${tdOffJtTotalCnt}">Off-JT</td>
						<td class="left">${result.subjectName}</td>
						<td>${result.subClass}</td> 
					</tr>
					</c:if>
					<c:if test="${status.count != 1}">
					<tr>
						<td class="left">${result.subjectName}</td>
						<td>${result.subClass}</td>
					</tr>
					</c:if>
					</c:forEach>
				<c:forEach var="result" items="${resultOjtSubjectInfoList}" varStatus="status">
				<c:if test="${status.count == 1}">
				<tr>
					<td rowspan="${tdOjtTotalCnt}">OJT</td>
					<td class="left">${result.subjectName}</td>
					<td>${result.subClass}</td>
				</tr>
				</c:if>
				<c:if test="${status.count != 1}">
				<tr>
					<td class="left">${result.subjectName}</td>
					<td>${result.subClass}</td>
				</tr>
				</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div> --%>

	<!-- <div class="btn-area mt-010">
		<div class="float-left">
			<a href="#fn_goList" class="gray-1t" onclick="javascript:fn_goList();">목록</a>
		</div>
		<div class="float-right">
			<a href="#fn_delete" class="gray-1" onclick="javascript:fn_delete();">삭제</a>
			<a href="#fn_goUpdate" class="yellow" onclick="javascript:fn_goUpdate();">수정</a>
		</div>
	</div> --><!-- E : btn-area -->
</div><!-- E : 훈련과정명 -->

<script type="text/javascript">

 
</script>

</form>


