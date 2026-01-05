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

<link href="/js/jquery/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" type="text/css" />

<c:set var="targetUrl" value="/lu/company/"/>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript">
	var targetUrl = "${targetUrl}";
	var oldCompanyNo = "";

	$(document).ready(function() {
		loadPage();
	});

	/*====================================================================
		화면 초기화
	====================================================================*/
	function loadPage() {
		$('#companyNo').keypress(function (event) {
		    if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
		      event.preventDefault();
		    }
		});
		$('#employInsManageNo').keypress(function (event) {
		    if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
		      event.preventDefault();
		    }
		});
		$('#telNo2').keypress(function (event) {
		    if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
		      event.preventDefault();
		    }
		});
		$('#telNo3').keypress(function (event) {
		    if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
		      event.preventDefault();
		    }
		});
		$('#regularEmploymentCnt').keypress(function (event) {
		    if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
		      event.preventDefault();
		    }
		});

		$("#companyName").focus();
		oldCompanyNo = $('#companyNo').val(); //수정전 사업자등록번호
		com.datepickerDateFormat('choiceDay');
		com.datepickerDateFormat('makeDay');
		com.datepickerDateFormat('evalDay');
		
	}

	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/*====================================================================
	사용자 정의 함수
	====================================================================*/

	/* 입력 필드 초기화 */
	function fn_formReset( param1 ){
		$("#frmCompany").find("input,select").val("");
	}

	/* 수정 */
	function fn_formSave(){

		if($("#company_companyName").val() == ""){
			alert("기업명을 넣어 주세요.");
			return false;
		}

		var companyNo  = $("#companyNo").val();
		var employInsManageNo = $("#employInsManageNo").val();
		var employInsManageNoSubStr = "";

		if(companyNo == ""){
			alert("사업자등록번호을 넣어 주세요.");
			return false;
		}

		if(companyNo.length != 10){
			alert("입력한 사업자등록번호가 10자리가 아닙니다.");
			return false;
		}

		if(employInsManageNo == ""){
			alert("고용보험관리번호을 넣어 주세요.");
			return false;
		}
/*
		if(employInsManageNo.length != 12){
			alert("입력한 고용보험관리번호가 12자리가 아닙니다.");
			return false;
		}

		employInsManageNoSubStr = employInsManageNo.substring(0, 10);

		if(employInsManageNoSubStr != companyNo){
			alert("입력한 고용보험관리번호는 사업자등록번호의 10자리가 동일해야합니다.");
			return false;
		}
*//*
		if($("#zipCode").val() == ""){
			alert("우편번호를 넣어 주세요.");
			return false;
		}

		if($("#address").val() == ""){
			alert("주소를 넣어 주세요.");
			return false;
		}

		if($("#addressDtl").val() == ""){
			alert("주소상세를 넣어 주세요.");
			return false;
		}
*/
		if($("#ceo").val() == ""){
			alert("대표자명을 넣어 주세요.");
			return false;
		}

		if($("#telNo1").val() == ""){
			alert("연락처1를 선택해주세요.");
			return false;
		}

		if($("#telNo2").val() == ""){
			alert("연락처2를 입력해주세요.");
			return false;
		}

		if($("#telNo3").val() == ""){
			alert("연락처3를 입력해주세요.");
			return false;
		}

		if($("#choiceDay").val() == ""){
			alert("선정일를 선택해주세요.");
			return false;
		}
/*
		if(oldCompanyNo != $("#companyNo").val()){
			if($("#status").val() != "true"){
				alert("중복체크를 하지 않았습니다.");
				return false;
			}
		}
*/

		var reqUrl = CONTEXT_ROOT + targetUrl + "updateCompany.do";

		$("#frmCompany").attr("method", "post" );
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}

	/* 목록 페이지로 이동 */
	function fn_list(){

		$("#companyId").val(null);

		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompany.do";

		$("#frmCompany").attr("method", "post" );
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}

	/* 다음라이브러리를 통한 도로명 검색 팝업 호출 */
	function fn_goSearchDoroCodePop(){
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = ''; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                fullAddr = data.roadAddress;

	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	            if(data.userSelectedType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	           // document.getElementById("zipCode").value = data.postcode; //6자리 우편번호 사용
	            //document.getElementById("zipCode").value = data.zonecode; //5자리 기초구역번호 사용
	            //document.getElementById("address").value = fullAddr;

	            $("#zipCode").val(data.zonecode);
	            $("#address").val(fullAddr);

	            // 커서를 상세주소 필드로 이동한다.
	            //document.getElementById("addressDtl").focus();
	            $("#addressDtl").focus();
	        }
	    }).open();
	}

	//사업자등록번호 중복체크
	function fn_CompanyIdDuckCheck(){
		if($("#companyNo").val()==''){
			alert("사업자등록번호를 등록해 주세요.");
			return false;
		}
		if(checkBizID($("#companyNo").val())){
			$("#companyNoPop").val($("#companyNo").val());

			popOpenWindow("", "popSchMemId", 650, 560);

			var reqUrl = CONTEXT_ROOT + "/lu/popup/popup/goPopupCompanyInfoIdCheck.do";

			$("#frmPop").attr("action", reqUrl);
			$("#frmPop").attr("target", "popSchMemId");
			$("#frmPop").submit();
		}else{
			alert("사업자등록번호가 틀립니다.");
			$("#companyNo").val("");
		}
	}

	function checkBizID(bizID) {
	    // bizID는 숫자만 10자리로 해서 문자열로 넘긴다.
	    var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
	    var tmpBizID, i, chkSum=0, c2, remander;
	    var result;
	    bizID = bizID.replace(/-/gi,'');
	    for (i=0; i<=7; i++) {
	        chkSum += checkID[i] * bizID.charAt(i);
	    }
	    c2 = "0" + (checkID[8] * bizID.charAt(8));
	    c2 = c2.substring(c2.length - 2, c2.length);
	    chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1));
	    remander = (10 - (chkSum % 10)) % 10 ;
	    if (Math.floor(bizID.charAt(9)) == remander) {
	        result = true ; // OK!
	    } else {
	        result = false;
	    }
	    return result;
	}

	function checkNumber(check_form){
	     var numPattern = /([^0-9])/;
	     var numPattern = check_form.value.match(numPattern);
	     if(numPattern != null){
	         alert("숫자만 입력해 주세요!");
	         check_form.value = "";
	         check_form.focus();
	         return false;
	     }
	 }


</script>

<%-- 팝업폼 --%>
<form id="frmPop" method="post" name="frmPop">
  <input type="hidden" name="companyNoPop" id="companyNoPop"/>
</form>
<%-- 팝업폼 --%>
<form:form modelAttribute="frmCompany">
<!-- 디폴트 셋팅항목 필드 시작 -->
<input type="hidden" name="status" id="status" value="true"/>
<input type="hidden" name="tempCompanyNo" id="tempCompanyNo"/>
<input type="hidden" name="companyId" id="companyId" value="${companyVO.companyId}"/>
<!-- 디폴트 셋팅항목 필드 끝 -->

<!-- 검색조건유지 필드 시작 -->
<%-- <input type="hidden" name="searchCompanyName" id="searchName" value="${companyVO.searchCompanyName}"/>
<input type="hidden" name="searchEmployInsManageNo" id="searchWord" value="${companyVO.searchEmployInsManageNo}"/> --%>

<!-- 검색조건유지 필드 끝 -->

<div id="">
	<h2>담당기업체 신규등록</h2>
	<table class="type-write mt-010">
		<%-- <colgroup>
			<col style="width:80px" />
			<col style="width:210px" />
			<col style="width:*" />
		</colgroup> --%>
		<tbody>
			<tr>
				<th colspan="2">기업명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td><input type="text" id="company_companyName" name="companyName"  maxlength="60" value="${companyVO.companyName}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th colspan="2">고용보험관리번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="employInsManageNo" name="employInsManageNo" maxlength="12" value="${companyVO.employInsManageNo}"/>
	  				<p>※"-"빼고 넣어 주세요.</p>
				</td>
			</tr>
			<tr>
				<th colspan="2">사업자등록번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="companyNo" name="companyNo"  maxlength="10" value="${companyVO.companyNo}"  style="width:70%" />
					<a href="#fn_CompanyIdDuckCheck" class="btn btn-black btn-mmd" onclick="javascript:fn_CompanyIdDuckCheck(); return false" onkeypress="this.onclick;">중복확인</a>
	  				<p>※"-"빼고 넣어 주세요.</p>
				</td>
			</tr>
			<tr>
				<th colspan="2" rowspan="2">주소<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
				<input type="text" id="zipCode" name="zipCode"  maxlength="" value="${companyVO.zipCode}" style="width:20%;" readonly="readonly" />
				<input type="text" id="address" name="address"  maxlength="" value="${companyVO.address}" style="width:60%;" readonly="readonly" />
				<a href="#fn_goSearchDoroCodePop" class="btn btn-black btn-mmd" onclick="javascript:fn_goSearchDoroCodePop( ); return false" onkeypress="this.onclick;">검색</a></td>
			</tr>
			<tr>
				<td class="border-left"><input type="text" id="addressDtl" name="addressDtl"  maxlength="210" value="${companyVO.addressDtl}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th colspan="2">대표자<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td><input type="text" id="ceo" name="ceo"  maxlength="60" value="${companyVO.ceo}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th rowspan="6">담당자 연락처</th>
				<th>직위</th>
				<td><input type="text" id="position" name="position"  maxlength="50" value="${companyVO.position}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th class="border-left">성명</th>
				<td><input type="text" id="name" name="name"  maxlength="20" value="${companyVO.name}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th class="border-left">연락처<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<select name="telNo1" id="telNo1" style="width:80px;">
						<option selected value=''>::선택::</option>
						<c:forEach var="localTelNoCd" items="${localTelNoCode}" varStatus="status">
							<option value="${localTelNoCd.codeId}" ${localTelNoCd.codeId == companyVO.telNo1 ? 'selected="selected"' : '' }>${localTelNoCd.codeId}</option>
						</c:forEach>
					</select>
					-
					<input type="text" id="telNo2" name="telNo2"  value="${companyVO.telNo2}"  maxlength="4" style="width:20%" />
					-
					<input type="text" id="telNo3" name="telNo3"  value="${companyVO.telNo3}"  maxlength="4" style="width:20%" />
				</td>
			</tr>
			<tr>
				<th class="border-left">휴대폰</th>
				<td>
					<select name="hpNo1" id="hpNo1" style="width:80px;">
						<option selected value=''>::선택::</option>
						<option value="010" ${'010' == companyVO.hpNo1 ? 'selected="selected"' : '' }>010</option>
						<option value="011" ${'011' == companyVO.hpNo1 ? 'selected="selected"' : '' }>011</option>
						<option value="016" ${'016' == companyVO.hpNo1 ? 'selected="selected"' : '' }>016</option>
						<option value="017" ${'017' == companyVO.hpNo1 ? 'selected="selected"' : '' }>017</option>
						<option value="018" ${'018' == companyVO.hpNo1 ? 'selected="selected"' : '' }>018</option>
						<option value="019" ${'019' == companyVO.hpNo1 ? 'selected="selected"' : '' }>019</option>
					</select>
					-
					<input type="text" id="hpNo2" name="hpNo2"  value="${companyVO.hpNo2}"  maxlength="4" style="width:20%" />
					-
					<input type="text" id="hpNo3" name="hpNo3"  value="${companyVO.hpNo3}"  maxlength="4" style="width:20%" />
				</td>
			</tr>
			<tr>
				<th class="border-left">팩스</th>
				<td>
					<select name="faxNo1" id="faxNo1" style="width:80px;">
						<option selected value=''>::선택::</option>
						<c:forEach var="localTelNoCd" items="${localTelNoCode}" varStatus="status">
							<option value="${localTelNoCd.codeId}" ${localTelNoCd.codeId == companyVO.faxNo1 ? 'selected="selected"' : '' }>${localTelNoCd.codeId}</option>
						</c:forEach>
					</select>
					-
					<input type="text" id="faxNo2" name="faxNo2"  value="${companyVO.faxNo2}"  maxlength="4" style="width:20%" />
					-
					<input type="text" id="faxNo3" name="faxNo3"  value="${companyVO.faxNo3}"  maxlength="4" style="width:20%" />
				</td>
			</tr>
			<tr>
				<th class="border-left">E-mail</th>
				<td><input type="text" id="email" name="email" maxlength="100" value="${companyVO.email}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th colspan="2">선정일<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td><input type="text" id="choiceDay" name="choiceDay"  readonly="readonly" value="${companyVO.choiceDay}" style="width:50%;" /></td>
			</tr>
			<%-- <tr>
				<th colspan="2">업종</th>
				<td>
					<select id="bigBusinessType" name="bigBusinessType" onchange="" style="width:20%;" >
						<option value="00" ${companyVO.bigBusinessType == '00' ? 'selected="selected"' : '' }>::선택::</option>
						<option value="01" ${companyVO.bigBusinessType == '01' ? 'selected="selected"' : '' }>농업</option>
					</select>
					<select id="middleBusinessType" name="middleBusinessType" onchange="" style="width:20%;" >
						<option value="000" ${companyVO.middleBusinessType == '000' ? 'selected="selected"' : '' }>::선택::</option>
						<option value="011" ${companyVO.middleBusinessType == '011' ? 'selected="selected"' : '' }>작물 재배업</option>
						<option value="012" ${companyVO.middleBusinessType == '012' ? 'selected="selected"' : '' }>축산업</option>
						<option value="013" ${companyVO.middleBusinessType == '013' ? 'selected="selected"' : '' }>작물재배 및 축산 복합농업</option>
						<option value="014" ${companyVO.middleBusinessType == '014' ? 'selected="selected"' : '' }>작물재배 및 축산 관련 서비스업</option>
						<option value="015" ${companyVO.middleBusinessType == '015' ? 'selected="selected"' : '' }>수렵 및 관련 서비스업</option>
					</select>
					<select id="smailBusinessType" name="smailBusinessType" onchange="" style="width:20%;" >
						<option value="0000" ${companyVO.smailBusinessType == '0000' ? 'selected="selected"' : '' }>::선택::</option>
						<option value="0111" ${companyVO.smailBusinessType == '0111' ? 'selected="selected"' : '' }>곡물 및 기타 식량작물 재배업</option>
						<option value="0112" ${companyVO.smailBusinessType == '0112' ? 'selected="selected"' : '' }>채소, 화훼작물 및 종묘 재배업</option>
						<option value="0113" ${companyVO.smailBusinessType == '0113' ? 'selected="selected"' : '' }>과실, 음료용 및 향신용 작물 재배업</option>
						<option value="0114" ${companyVO.smailBusinessType == '0114' ? 'selected="selected"' : '' }>기타 작물 재배업</option>
						<option value="0115" ${companyVO.smailBusinessType == '0115' ? 'selected="selected"' : '' }>시설작물 재배업</option>
						<option value="0121" ${companyVO.smailBusinessType == '0121' ? 'selected="selected"' : '' }>소 사육업</option>
						<option value="0122" ${companyVO.smailBusinessType == '0122' ? 'selected="selected"' : '' }>양돈업</option>
						<option value="0123" ${companyVO.smailBusinessType == '0123' ? 'selected="selected"' : '' }>가금류 및 조류 사육업</option>
						<option value="0129" ${companyVO.smailBusinessType == '0129' ? 'selected="selected"' : '' }>기타 축산업</option>
						<option value="0130" ${companyVO.smailBusinessType == '0130' ? 'selected="selected"' : '' }>작물재배 및 축산 복합농업</option>
						<option value="0141" ${companyVO.smailBusinessType == '0141' ? 'selected="selected"' : '' }>작물재배 관련 서비스업</option>
						<option value="0142" ${companyVO.smailBusinessType == '0142' ? 'selected="selected"' : '' }>축산 관련 서비스업</option>
						<option value="0150" ${companyVO.smailBusinessType == '0150' ? 'selected="selected"' : '' }>수렵 및 관련 서비스업</option>
					</select>
				</td>
			</tr> --%>
			<tr>
				<th colspan="2">상시근로자수</th>
				<td><input type="number" min="0" max="9999" id="regularEmploymentCnt" name="regularEmploymentCnt"  maxlength="20" value="${companyVO.regularEmploymentCnt}" style="width:20%;" /> 명</td>
			</tr>
			<tr>
				<th colspan="2">기업구분</th>
				<td>
					<select id="companyDivCd" name="companyDivCd" style="width:50%">
						<option value="00" ${companyVO.companyDivCd == '00' ? 'selected="selected"' : '' }>::선택::</option>
						<option value="01" ${companyVO.companyDivCd == '01' ? 'selected="selected"' : '' }>대기업</option>
						<option value="02" ${companyVO.companyDivCd == '02' ? 'selected="selected"' : '' }>중견기업</option>
						<option value="03" ${companyVO.companyDivCd == '03' ? 'selected="selected"' : '' }>중소기업</option>
						<option value="04" ${companyVO.companyDivCd == '04' ? 'selected="selected"' : '' }>공기업</option>
						<option value="05" ${companyVO.companyDivCd == '05' ? 'selected="selected"' : '' }>교육기관</option>
						<option value="06" ${companyVO.companyDivCd == '06' ? 'selected="selected"' : '' }>기타</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">홈페이지 URL</th>
				<td><input type="text" id="homepageUrl" name="homepageUrl"  maxlength="50" value="${companyVO.homepageUrl}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">훈련참여상태</th>
				<td>
					<select id="traningStatusCd" name="traningStatusCd" style="width:50%">
						<option value="" selected>::선택::</option>
						<option value="1" ${companyVO.traningStatusCd == '1' ? 'selected="selected"' : '' }>진행중</option>
						<option value="2" ${companyVO.traningStatusCd == '2' ? 'selected="selected"' : '' }>참여대기</option>
						<option value="3" ${companyVO.traningStatusCd == '3' ? 'selected="selected"' : '' }>참여포기</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">기업상태</th>
				<td>
					<select id="companyStatusCd" name="companyStatusCd" style="width:50%" >
						<option value="" selected>::선택::</option>
						<option value="1" ${companyVO.companyStatusCd == '1' ? 'selected="selected"' : '' }>정상</option>
						<option value="2" ${companyVO.companyStatusCd == '2' ? 'selected="selected"' : '' }>폐업</option>
						<option value="3" ${companyVO.companyStatusCd == '3' ? 'selected="selected"' : '' }>합병</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">관할 지부지사</th>
				<td><input type="text" id="controlPlaceName" name="controlPlaceName"   maxlength="50" value="${companyVO.controlPlaceName}" style="width:99%;" /></td>
			</tr>
			
			
			
			<tr>
				<th rowspan="3">재학생 단계</th>
				<th>도제(참여기관명)</th>
				<td><input type="text" id="stuLevelName1" name="stuLevelName1"  maxlength="50" value="${companyVO.stuLevelName1}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th class="border-left">Uni-Tech(참여기관명)</th>
				<td><input type="text" id="stuLevelName2" name="stuLevelName2"  maxlength="50" value="${companyVO.stuLevelName2}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th class="border-left">IPP(참여기관명)</th>
				<td><input type="text" id="stuLevelName3" name="stuLevelName3"  maxlength="50" value="${companyVO.stuLevelName3}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th rowspan="4">재직자 단계</th>
				<th>단독기업형</th>
				<td><input type="text" id="compLevelName1" name="compLevelName1"  maxlength="50" value="${companyVO.compLevelName1}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th class="border-left">대학연계형(참여기관명)</th>
				<td><input type="text" id="compLevelName2" name="compLevelName2"  maxlength="50" value="${companyVO.compLevelName2}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th class="border-left">P-Tech(참여기관명)</th>
				<td><input type="text" id="compLevelName3" name="compLevelName3"  maxlength="50" value="${companyVO.compLevelName3}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th class="border-left">고숙련마이스터(참여기관명)</th>
				<td><input type="text" id="compLevelName4" name="compLevelName4"  maxlength="50" value="${companyVO.compLevelName4}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">설립일자</th>
				<td><input type="text" id="makeDay" name="makeDay"  maxlength="10"  readonly="readonly" value="${companyVO.makeDay}" style="width:50%;"  /></td>
			</tr>
			
			<tr>
				<th colspan="2">신용등급</th>
				<td><input type="text" id="creditLevel" name="creditLevel"  maxlength="25" value="${companyVO.creditLevel}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">자산총계</th>
				<td><input type="text" id="assets" name="assets"  maxlength="25" value="${companyVO.assets}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">부채총계</th>
				<td><input type="text" id="liabilities" name="liabilities"  maxlength="25" value="${companyVO.liabilities}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">자본총계</th>
				<td><input type="text" id="equities" name="equities"  maxlength="25" value="${companyVO.equities}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th colspan="2">매출액</th>
				<td><input type="text" id="revenue" name="revenue"  maxlength="25" value="${companyVO.revenue}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">영업이익</th>
				<td><input type="text" id="operatingIncome" name="operatingIncome"  maxlength="25" value="${companyVO.operatingIncome}" style="width:99%;" /></td>
			</tr>
			<tr>
				<th colspan="2">당기순이익</th>
				<td><input type="text" id="netIncome" name="netIncome"  maxlength="25" value="${companyVO.netIncome}" style="width:99%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">평가일자</th>
				<td><input type="text" id="evalDay" name="evalDay"  maxlength="25"  readonly="readonly" value="${companyVO.evalDay}" style="width:50%;"  /></td>
			</tr>
			
			<tr>
				<th colspan="2">조회기관</th>
				<td><input type="text" id="searchPlaceName" name="searchPlaceName"  maxlength="25" value="${companyVO.searchPlaceName}" style="width:99%;" /></td>
			</tr>
			
		</tbody>
	</table>

	<div class="btn-area mt-010">
		<div class="float-right">
		<a href="#fn_list" onclick="javascript:fn_list();" onkeypress="this.onclick;" class="black">목록</a>
		<a href="#fn_formReset" onclick="javascript:fn_formReset();" onkeypress="this.onclick;" class="black">취소</a>
		<a href="#fn_formSave" onclick="javascript:fn_formSave();" onkeypress="this.onclick;" class="black">저장</a>
		</div>
	</div>

</div><!-- E : content-area -->
</form:form>

