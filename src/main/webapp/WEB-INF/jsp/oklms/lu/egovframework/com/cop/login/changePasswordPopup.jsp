<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
/**
 * @Class Name : /lu/egovframework/com/cop/bbs/EgovNoticeInqirePopup.jsp
 * @Description : 게시물 조회 화면
 * @Modification Information
 * @
 * @  수정일      수정자            수정내용
 * @ -------        --------    ---------------------------
 * @ 2017.01.05   이진근          최초 생성
 *
 */
%>

<script type="text/javascript">

function fn_formValidate(){
	
	var bodyMemPasswordEncript = "";
	var bodyNewPasswordEncript = "";
	var bodyNewPasswordEncriptChk = "";
	
	bodyMemPasswordEncript = $('#bodyMemPasswordEncript').val();
	bodyNewPasswordEncript = $('#bodyNewPasswordEncript').val();
	bodyNewPasswordEncriptChk = $('#bodyNewPasswordEncriptChk').val();

	if(bodyMemPasswordEncript == ""){
		alert("비밀번호를 입력해 주세요.");
		$("#bodyMemPasswordEncript").focus();
		return false;
	}
	
	if(bodyNewPasswordEncript == ""){
		alert("새 비밀번호를 입력해 주세요.");
		$("#bodyNewPasswordEncript").focus();
		return false;
		}
	else if(bodyNewPasswordEncript != bodyNewPasswordEncript.replace("\`",""))
		{
				alert(" \` 는 특수문자로 허용되지 않습니다.");
				return false;
		}
	else if(bodyNewPasswordEncript != bodyNewPasswordEncript.replace("-",""))
		{
				alert(" - 는 특수문자로 허용되지 않습니다.");
				return false;
		}
	else if(bodyNewPasswordEncript != bodyNewPasswordEncript.replace("<",""))
		{
			alert(" < 는 특수문자로 허용되지 않습니다.");
			return false;
		}
	else if(bodyNewPasswordEncript != bodyNewPasswordEncript.replace(">",""))
		{
			alert(" > 는 특수문자로 허용되지 않습니다.");
			return false;
		}
		
		var regExpIsPassword =  /^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-_])(?=.*[0-9]).{6,16}$/;     
		   ///^(?=.*[a-zA-Z])(?=.*[@#$%^&*!])(?=.*[0-9]).{6,16}$/;	// 비밀번호 체크 (숫자, 영어, 특수문자 포함 8~16자리 체크 '"<> 등 제외
	if( !regExpIsPassword.test( bodyNewPasswordEncript))
		{
			alert("숫자, 영어, 특수문자 포함 6~16자리의 비밀번호를 입력하세요");
			bodyNewPasswordEncript.focus();
			return false;
		}
	
	if(bodyNewPasswordEncriptChk == ""){
		alert("새 비밀번호 확인를 입력해 주세요.");
		$("#bodyNewPasswordEncriptChk").focus();
		return false;
	}
	
	if(bodyNewPasswordEncript != bodyNewPasswordEncriptChk){
		alert("새 비밀번호가 일치하지 않습니다.");
		$("#bodyNewPasswordEncriptChk").focus();
		return false;
	}
	
	return true;
}

function fn_change_password(){
	if (fn_formValidate()) {
		
		if(confirm("비밀번호를 변경 하시겠습니까?")){
			
			var reqUrl = "/commbiz/outmember/changePassword.json";
			var formData = $('#frm').serialize();

			$.ajax({
			    type: "POST",
			    data: formData,
			    url: "/commbiz/outmember/changePassword.json",
			    success: function(data) {
			        alert(data.retMsg);
			        if (data.retMsg === "비밀번호를 변경하였습니다." || data.retMsg.indexOf("비밀번호를 변경하였습니다.") > -1) {
                        window.close(); // 팝업 창 닫기
                    }
			    }
			});
		}
	}
}

</script>

<!-- S : 상세 보기 영역 (3 단 상세보기) -->
<form name="frm" id="frm" method="post" action="">


<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<div id="pop-wrapper" class="min-w650">
			
			<h1>비밀번호 변경</h1>

			<table class="type-2">
				<colgroup>
					<col width="30%" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>비밀번호</th>
						<td class="left">
						<input type="password" name="memPasswordEncript" id="bodyMemPasswordEncript" placeholder="비밀번호" class="ipass upw form-control">
						</td>
					</tr>
					<tr>
						<th>새 비밀번호</th>
						<td class="left">
						<input type="password" name="newPasswordEncript" id="bodyNewPasswordEncript" placeholder="새 비밀번호" class="ipass upw form-control">
						</td>
					</tr>
					<tr>
						<th>새 비밀번호 확인</th>
						<td class="left">
						<input type="password" name="newPasswordEncriptChk" id="bodyNewPasswordEncriptChk" placeholder="새 비밀번호 확인" class="ipass upw form-control">
						</td>
					</tr>
				</tbody>
			</table><!-- E : type-2 -->

			<div class="btn-area align-right mt-020">
				<a href="#" onclick="fn_change_password()" class="gray-1  float-left">변경</a>
			</div><!-- E : btn-area -->
		</div><!-- E : wrapper -->
		
		</form>
