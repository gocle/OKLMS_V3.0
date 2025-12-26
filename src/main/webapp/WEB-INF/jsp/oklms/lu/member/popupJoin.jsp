<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : /lu/egovframework/com/cop/bbs/SearchEgovNoticeListPopup.jsp
  * @Description : 게시물 팝업 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2017.01.05   이진근          최초 생성
  *
  */
%> 
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
var selectRecordIndex = "";
/*====================================================================
화면 초기화
====================================================================*/
$(document).ready(function() {
	loadPage();
	
	$(document).on("change", "#memType", function() {
		if($(this).val() == "COT"){
			$("#tr_loginId").css("display","none");
			$("#tr_loginPwd1").css("display","none");
			$("#tr_loginPwd2").css("display","none");
		} else {
			$("#tr_loginId").css("display","");
			$("#tr_loginPwd1").css("display","");
			$("#tr_loginPwd2").css("display","");
		}
	});
});

function loadPage() {
	initEvent();
	initHtml();
}

/* 각종 버튼에 대한 액션 초기화 */
function initEvent() {
}

/* 화면이 로드된후 처리 초기화 */
function initHtml() {
	com.datepickerDateFormat('memBirth', 'button');
}

/*====================================================================
화면 사용 함수
====================================================================*/
/*
* 화면 유효성 첵크
*/
function fn_formValidate() {
	if( !$("#companyId").val() ){
		alert("기업을 선택하세요.");
		return false;
	}
	
		
	if( !$("#memType").val() ){
		alert("회원유형을 선택하세요.");
		return false;
	}
	
	if( $("#memType").val() == "CCM" ){
	
		if( !$("#loginId").val() ){
			alert("아이디를 입력하세요.");
			return false;
		}
		
		if( !$("#memCheck").val() ){
			alert("아이디 중복체크를 하세요.");
			return false;
		}
	}
	
	
	
	if( !$("#koreanNm").val() ){
		alert("이름을 입력하세요.");
		return false;
	}
	
	if( $("#memType").val() == "CCM" ){
		
		if( !$("#loginPwd1").val() ){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if( !$("#loginPwd2").val() ){
			alert("비밀번호 확인 값을 입력하세요.");
			return false;
		}
		if( $("#loginPwd1").val() != $("#loginPwd2").val() ){
			alert("비밀번호 확인 \n값이 일치하지 않습니다.");
			return false;
		}
		else	if($("#loginPwd1").val() != $("#loginPwd1").val().replace("\`",""))
		{
				alert(" \` 는 특수문자로 허용되지 않습니다.");
				return false;
		}
		else if($("#loginPwd1").val() != $("#loginPwd1").val().replace("-",""))
		{
				alert(" - 는 특수문자로 허용되지 않습니다.");
				return false;
		}
		else if($("#loginPwd1").val() != $("#loginPwd1").val().replace("<",""))
		{
			alert(" < 는 특수문자로 허용되지 않습니다.");
			return false;
		}
		else if($("#loginPwd1").val() != $("#loginPwd1").val().replace(">",""))
		{
			alert(" > 는 특수문자로 허용되지 않습니다.");
			return false;
		}
		
		var regExpIsPassword =  /^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-_])(?=.*[0-9]).{6,16}$/;     
		   ///^(?=.*[a-zA-Z])(?=.*[@#$%^&*!])(?=.*[0-9]).{6,16}$/;	// 비밀번호 체크 (숫자, 영어, 특수문자 포함 8~16자리 체크 '"<> 등 제외
		if( !regExpIsPassword.test( $("#loginPwd1").val()) ){
		
			alert("숫자, 영어, 특수문자 포함 6~16자리의 비밀번호를 입력하세요");
			return false;
		}
	   
	}
	   
	if($("#mbtlnum1").val() != "" && $("#mbtlnum2").val()  != "" && $("#mbtlnum3").val()  != ""){
		var mbtlnum = $("#mbtlnum1").val() + "-" + $("#mbtlnum2").val() + "-" + $("#mbtlnum3").val();;
		$("#mbtlnum").val(mbtlnum);
	}
		
	if(!$("#mbtlnum").val()){
		alert(" 휴대폰번호를 입력하세요.");
		return false;
	}	   
	
	if(!$("#email").val()){
		alert(" 이메일을 입력하세요.");
		return false;
	}	
	
	if($("input:radio[name=sexdstnCd]:checked").length == 0){
		alert(" 성별을 선택하세요.");
		return false;
	}
	
	if(!$("#memBirth").val()){
		alert(" 생년월일을 선택하세요.");
		return false;
	}
	
	$("#ihidnum").val($("#memBirth").val());
	
	return true;
}					   	   
/* HTML Form 신규, 수정 */
function fn_formSave(){
	if (fn_formValidate()) {
		if(doubleSubmitCheck()) return;
		if(confirm("저장 하시겠습니까?")){
			var reqUrl =  "/commbiz/outmember/inesertTempOutMember.do";
			$("#frmJoin").attr("target","_self");
			$("#frmJoin").attr("action", reqUrl);
			$("#frmJoin").submit();
		}
	}
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
			data:$('#frmJoin').serialize(),
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

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}

var doubleSubmitFlag = false;
function doubleSubmitCheck(){
    if(doubleSubmitFlag){
        return doubleSubmitFlag;
    }else{
        doubleSubmitFlag = true;
        return false;
    }
}


</script>



<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<!-- 팝업 사이즈 : 가로 850px 이상 설정 -->
		<div id="sms-wrapper">
			<ul id="sms-header">
				<li><h1>OK-LMS 회원정보 입력</h1></li>
				<li class="btn"><a href="javascript:self.close();">닫기</a></li>
			</ul><!-- E : sms-header -->

<form id="frmJoin" name="frmJoin" action ="" method="post">
	<input type="hidden" id="ihidnum" name="ihidnum" />
	<input type="hidden" id="mbtlnum" name="mbtlnum" />
	<input type="hidden" name="memCheck" id="memCheck"  />
	<input type="hidden" name="cprSeCd" id="cprSeCd" value="105"  />
	<input type="hidden" name="hffcSttusCd" id="hffcSttusCd" value="101"  />

			<div class="apply-wrap">
							<table class="type-write">
								<colgroup>
									<col width="100px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>기업</th>
										<td>
											<select id="companyId" name="companyId">
												<option value="">선택 </option>
												<c:forEach var="result" items="${listCompany}" varStatus="status">
												<option value="${result.companyId}">${result.companyName}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									
									<tr>
										<th>회원유형</th>
										<td>
											<select id="memType" name="memType">
												<option value="">선택 </option>
												<option value="COT">기업현장교사</option>
												<option value="CCM">HRD전담자</option>
											</select>
										</td>
									</tr>
									
									
									<tr id="tr_loginId">
										<th>아이디</th>
										<td>
											<input type="text" name="loginId" id="loginId" maxlength="" value="" style="width:40%;" />
											<a href="#@" onclick="memIdCheck();" class="checkfile">중복검사</a>
										</td>
									</tr>
									
									<tr>
										<th>이름</th>
										<td><input type="text" name="koreanNm" id="koreanNm"  maxlength="" value="" style="width:40%;" /></td>
									</tr>
									
									<tr id="tr_loginPwd1">
										<th>비밀번호</th>
										<td><input type="password" name="loginPwd" id="loginPwd1" maxlength="" value="" style="width:40%;" /></td>
									</tr>
									<tr id="tr_loginPwd2">
										<th>비밀번호 확인</th>
										<td><input type="password" name="loginPwd1" id="loginPwd2" maxlength="" value="" style="width:40%;" /></td>
									</tr>
									<tr>
										<th>휴대폰번호</th>
										<td>
										<input type="text" name="mbtlnum1" id="mbtlnum1" maxlength="3" value="" style="width:10%;" onkeydown="onlyNumber(this)"  />
										- <input type="text" name="mbtlnum2" id="mbtlnum2" maxlength="4" value="" style="width:10%;" onkeydown="onlyNumber(this)"  />
										- <input type="text" name="mbtlnum3" id="mbtlnum3" maxlength="4" value="" style="width:10%;" onkeydown="onlyNumber(this)"  />
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td><input type="text" name="email" id="email" maxlength="" value="" style="width:40%;" /></td>
									</tr>
									<tr>
										<th>성별</th>
										<td>
											<input type="radio" name="sexdstnCd" id="sexdstnCd1" value="101" class="choice" >&nbsp;&nbsp;남
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" name="sexdstnCd" id="sexdstnCd2"  value="102" class="choice" >&nbsp;&nbsp;여
										</td>
									</tr>
									<tr>
										<th>생년월일</th>
										<td>
											<input type="text" name="memBirth" id="memBirth" maxlength="" value="" readonly="readonly" style="width:13%;" />
										</td>
									</tr>
								</tbody>
							</table>

							<div class="btn-area align-right mt-010">
								<a href="javascript:self.close();" class="gray-1">취소</a><a href="javascript:fn_formSave();" class="orange">등록</a>
							</div><!-- E : btn-area -->
			</div>

</form>

		</div><!-- E : sms-wrapper -->



