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

<c:set var="targetUrl" value="/lu/member/"/>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
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

	

	/* 목록 페이지로 이동 */
	function fn_list(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyMember.do";

		$("#frmMember").attr("method", "post" );
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}

	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	
	function memIdCheck(){
		var check = true;
		if( !$("#loginId").val() ){
			alert("아이디를 입력하세요.");
			check = false;
			return false;
		}
		
		if(check){
			$.ajax({
				url:"/commbiz/outmember/memIdCheck.do",
				type:"post",
				data:$('#frmMember').serialize(),
				success:function(data){
					
					if(data.memId){
						alert("등록된 아이디가 있습니다.");
						$("#memCheck").val("");	
					}else{
						$("#memCheck").val($("#loginId").val());
						alert("사용가능한 아이디입니다.");
					}
					
				},error:function(xhr,status,error){
					alert("등록된 아이디가 있습니다.");
					$("#memCheck").val("");	
					//alert(xhr.status);
				}
				
			});		
		}
	}
	
	
	function fn_formValidate() {
		var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
		
			
		var authGroupIdCnt = $("input[name=authGroupIds]:checkbox:checked").length;

		if(authGroupIdCnt == 0){
			alert("회원유형을 선택하지 않았습니다.");
			$("#authGroupId7").focus();
			return false;
		} 
		
		var compLicenceCdCnt = $("input[name=compLicenceCd]:radio:checked").length;

		if(compLicenceCdCnt == 0){
			alert("이수교육을 선택하지 않았습니다.");
			$("#compLicenceCd1").focus();
			return false;
		} 
		
		
		
		if( !$("#memName").val() ){
			alert("이름을 입력하세요.");
			$("#memName").focus();
			return false;
		}
			
		   
		if($("input:radio[name=sex]:checked").length == 0){
			alert("성별을 선택하세요.");
			$("#sexdstnCd1").focus();
			return false;
		}
		
		if(!$("#email").val()){
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return false;
		}	
		
		if(!$("#memBirth").val()){
			alert("생년월일을 입력하세요.");
			$("#memBirth").focus();
			return false;
		}
		
		if(!$("#hpNo").val()){
			alert("휴대폰 번호를 입력하세요.");
			$("#hpNo").focus();
			return false;
		}
		   
		if(!$("#compTelNo").val()){
			alert("사무실 번호를 입력하세요.");
			$("#compTelNo").focus();
			return false;
		}	
		
		   
		if(!$("#compJoinDay").val()){
			alert("입사일을 입력하세요.");
			$("#compJoinDay").focus();
			return false;
		}
		
		
		if(!$("#dutyNm").val()){
			alert("직위를 입력하세요.");
			$("#dutyNm").focus();
			return false;
		}	
		<c:if test="${empty resultFile}">				
		if(!$("#licenceFile").val()){
			alert("첨부파일을 첨부하세요.");
			$("#licenceFile").focus();
			return false;
		}
		</c:if>
		
		if(!$("#compCareerYear").val()){
			alert("경력을 입력하세요.");
			$("#compCareerYear").focus();
			return false;
		}	
		
		if(!$("#compLicenceNm").val()){
			alert("자격명을 입력하세요.");
			$("#compLicenceNm").focus();
			return false;
		}	
		
		if(!$("#compEduLevelCd").val()){
			alert("학력을 선택하세요.");
			$("#compEduLevelCd").focus();
			return false;
		}	
		
		if(!$("#compStatusCd").val()){
			alert("재직상태를 선택하세요.");
			$("#compStatusCd").focus();
			return false;
		}	
		
		
		return true;
	}	
	
	/* HTML Form 신규, 수정 */
	function fn_formSave(){
		if (fn_formValidate()) {
			if(doubleSubmitCheck()) return;
			if(confirm("수정 하시겠습니까?")){
				var reqUrl =  "/lu/member/updateCompMember.do";
				$("#frmMember").attr("target","_self");
				$("#frmMember").attr("action", reqUrl);
				$("#frmMember").submit();
			}
		}
	}
	


</script>


<form id="frmMember" name="frmMember" method="post" enctype="multipart/form-data">
<input type="hidden" name="memberType" id="memberType" value="${memberType}" />
<input type="hidden" id="companyId" name="companyId" value="${memberVO.companyId}" />
<input type="hidden" name="memSeq" id="memSeq" value="${memberVO.memSeq}"  />

<div id="">
	<h2>기업전담자관리</h2>
	<table class="type-write">
		<tbody>
			<tr>
				<th colspan="2">기업명</th>
				<td>
					${companyVO.companyName}
				</td>
			</tr> 
			
			<tr>
				<th colspan="2">아이디<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					${memberVO.memId}
				</td>
			</tr>
			
			<tr>
				<th colspan="2">회원유형<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<label for="authGroupId7"><input type="checkbox" name="authGroupIds" id="authGroupId7" value="2016AUTH0000008_COT" <c:if test="${fn:indexOf(memberVO.authGroupId, '2016AUTH0000008') != -1}">checked</c:if>>기업현장교사</label>
					<label for="authGroupId4"><input type="checkbox" name="authGroupIds" id="authGroupId4" value="2016AUTH0000004_CCM" <c:if test="${fn:indexOf(memberVO.authGroupId, '2016AUTH0000004') != -1}">checked</c:if>> HRD 전담자</label>
				</td>
			</tr> 
			<tr>
				<th colspan="2">이수교육<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<label for="compLicenceCd1"><input type="radio" name="compLicenceCd" id="compLicenceCd1"  value="1" ${memberVO.compLicenceCd eq '1' ? 'checked' : ''}>단기(온라인)</label>
					<label for="compLicenceCd2"><input type="radio" name="compLicenceCd" id="compLicenceCd2" value="2" ${memberVO.compLicenceCd eq '2' ? 'checked' : ''}>기본</label>
					<label for="compLicenceCd3"><input type="radio" name="compLicenceCd" id="compLicenceCd3" value="3" ${memberVO.compLicenceCd eq '3' ? 'checked' : ''}>심화</label>
				</td>
			</tr>
			
			
			
			<tr>
				<th colspan="2">이름<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="memName" name="memName"  maxlength="10" value="${memberVO.memName}" style="width:30%;" />
				</td>
			</tr>
			
			<%-- <tr>
				<th colspan="2">비밀번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td><input type="password" id="memPassword1" name="memPassword"  maxlength="60" value="" style="width:30%;" /></td>
			</tr>
			
			<tr>
				<th colspan="2">비밀번호확인<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td><input type="password" id="memPassword2" name="memPassword1"  maxlength="60" value="" style="width:30%;" /></td>
			</tr> --%>
			<tr>
				<th colspan="2">성별<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<label for="sexdstnCd1"><input type="radio" name="sex" id="sexdstnCd1" value="M" ${memberVO.sex eq 'M' ? 'checked' : ''}>남</label>
					<label for="sexdstnCd2"><input type="radio" name="sex" id="sexdstnCd2" value="F"  ${memberVO.sex eq 'F' ? 'checked' : ''}> 여</label>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">이메일<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="email" name="email"  maxlength="20" value="${memberVO.email}" style="width:30%;" />
					8자리 입력(예:19821024)
				</td>
			</tr>
			
			
			<tr>
				<th colspan="2">생년월일<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="memBirth" name="memBirth" onkeydown="onlyNumber(this);" maxlength="8" value="${memberVO.memBirth}" style="width:30%;" />
					8자리 입력(예:19821024)
				</td>
			</tr>
			
			<tr>
				<th colspan="2">휴대폰번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="hpNo" name="hpNo"  onkeydown="onlyNumber(this);" maxlength="11" value="${memberVO.hpNo}" style="width:30%;" />
					※"-"빼고 넣어 주세요.
				</td>
			</tr>
			
			<tr>
				<th colspan="2">사무실번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="compTelNo" name="compTelNo"  onkeydown="onlyNumber(this);" maxlength="11"  value="${memberVO.compTelNo}" style="width:30%;" />
					※"-"빼고 넣어 주세요.
				</td>
			</tr>
			
			<tr>
				<th colspan="2">입사일<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" id="compJoinDay" name="compJoinDay"  maxlength="8" onkeydown="onlyNumber(this);" value="${memberVO.compJoinDay}" style="width:30%;" />
					8자리 입력(예:19821024)
				</td>
			</tr>
			
			<tr>
				<th colspan="2">직위<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" name="dutyNm" id="dutyNm"  maxlength="8"  value="${memberVO.dutyNm}" style="width:30%;" />
				</td>
			</tr>
			
			<tr>
				<th colspan="2">경력<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" name="compCareerYear" id="compCareerYear"  maxlength="2"  value="${memberVO.compCareerYear}" onkeydown="onlyNumber(this);" style="width:30%;" />
				</td>
			</tr>
			
			<tr>
				<th colspan="2">자격명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<input type="text" name="compLicenceNm" id="compLicenceNm"  maxlength="15"  value="${memberVO.compLicenceNm}" style="width:30%;" />
				</td>
			</tr>
			
			<tr>
				<th colspan="2">학력<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<select id="compEduLevelCd" name="compEduLevelCd"  >
						<option value="">학력선택 </option>
						<option value="1" ${memberVO.compEduLevelCd eq '1' ? 'selected' : ''}>고등학교졸업</option>
						<option value="2" ${memberVO.compEduLevelCd eq '2' ? 'selected' : ''}>대학교졸업(2,3년)</option>
						<option value="3" ${memberVO.compEduLevelCd eq '3' ? 'selected' : ''}>대학교졸업(4년)</option>
						<option value="4" ${memberVO.compEduLevelCd eq '4' ? 'selected' : ''}>석사졸업</option>
						<option value="5" ${memberVO.compEduLevelCd eq '5' ? 'selected' : ''}>박사졸업</option>
					</select>
				</td>
			</tr>
			<tr>
				<th colspan="2">재직상태<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					<select id="compStatusCd" name="compStatusCd"  >
						<option value="">선택 </option>
						<option value="1" ${memberVO.compStatusCd eq '1' ? 'selected' : ''}>재직</option>
						<option value="2" ${memberVO.compStatusCd eq '2' ? 'selected' : ''}>휴직</option>
						<option value="3" ${memberVO.compStatusCd eq '3' ? 'selected' : ''}>퇴사</option>
					</select>
				</td>
			</tr>
			
			
			<tr>
				<th colspan="2">재직증명서<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
				
					<c:if test="${!empty resultFile}">
							<a href="javascript:com.downFile('${resultFile.atchFileId}','1');" class="text-file">${resultFile.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<%-- <a href="javascript:com.deleteFile('${resultFile.atchFileId}|1', '/lu/member/updateCompMemberPage.do?memSeq=${ memberVO.memSeq}&companyId=${ memberVO.companyId}&memberType=${ memberVO.memType}');"  class="btn-del">[삭제]</a><br /> --%>
					</c:if>					
					<c:if test="${empty resultFile}">				
						<input type="file" class="form_field jt_form_full_field"  id="licenceFile" name="file-input" style="width:30%;">
					</c:if>	
				</td>
			</tr>
			
			<tr>
				<th colspan="2">교육수료증<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
				
					<c:if test="${!empty resultFile2}">
							<a href="javascript:com.downFile('${resultFile2.atchFileId}','1');" class="text-file">${resultFile2.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<%-- <a href="javascript:com.deleteFile('${resultFile2.atchFileId}|1', '/lu/member/updateCompMemberPage.do?memSeq=${ memberVO.memSeq}&companyId=${ memberVO.companyId}&memberType=${ memberVO.memType}');"  class="btn-del">[삭제]</a><br /> --%>
					</c:if>					
					<c:if test="${empty resultFile2}">				
						<input type="file" class="form_field jt_form_full_field"  id="licenceFile" name="file-input" style="width:30%;">
					</c:if>	
				</td>
			</tr>
			
			
			
			
		</tbody>
	</table>

	<div class="btn-area mt-010">
		<div class="float-left">
			<a href="#fn_list" onclick="javascript:fn_list();" onkeypress="this.onclick;" class="gray-1">목록</a>
		</div>
		<div class="float-right">
			<!-- <a href="#fn_formReset" onclick="javascript:fn_formReset();" onkeypress="this.onclick;" class="gray-1">취소</a> -->
			<a href="#fn_formSave" onclick="javascript:fn_formSave();" onkeypress="this.onclick;" class="orange">저장</a>
		</div>
	</div>

</div><!-- E : content-area -->
</form>

