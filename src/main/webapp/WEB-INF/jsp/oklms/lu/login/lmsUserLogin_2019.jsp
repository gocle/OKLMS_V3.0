
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%@ include file="/common/sso_common.jsp"%>
<%@ include file="/common/sp_const.jsp"%>

<%
	String contextRootJS = request.getContextPath();
	String ssoYn =  EgovProperties.getProperty("Globals.ssoYn");
%>
<c:set var="ssoYn" value="<%=ssoYn %>"/>

<!-- 
<style>
#main-visual .member-area .log-type dd.item{float:left; position:relative; display:inline-block; width:175px; margin-bottom:5px; top:10px;}
#main-visual .member-area .log-type dd.btn{position:absolute; width:100px; height:61px; right:0; top:10px;}
#main-visual .member-area span{float:left; margin-top:20px;}
</style>
 -->

<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src="${contextRootJS }/js/oklms/popup.js"></script>
<!-- 2020년 jQuery 추가
<script type="text/javascript" src="/js/oklms/filter.js"></script>
 -->
<script type="text/javascript">

$(document).ready(function(){
	// 로그인 첫페이지나 호출시나 로그아웃시 아이디 입력 창으로 포커스 이동
	$("#bodyMemId").focus();
	com.datepickerDateFormat('memBirth', 'button');
	
	$("#check-1").click(function(){
		if($(this).prop("checked")){
			$("#check-2").prop("checked",true);
			$("#check-3").prop("checked",true);
		} else {
			$("#check-2").prop("checked",false);
			$("#check-3").prop("checked",false);
		}
	});

	
});

/**
 * browser 버전 체크
 * @returns
 */
 function browserVer(){

	var bwVer = "";
	var browserInfo = navigator.userAgent.toLowerCase();
	if( "Explorer" == browserType() ){
		bwVer = getIEVersion();
	}else if( "Chrome" == browserType() ){
		bwVer = getChromeVersion();
	}else{
		var bw = $.browser;
		if( undefined != bw ){
			bwVer = $.browser.version;
		}
	}
	return bwVer;
}

function getIEVersion() {
    var match = navigator.userAgent.match(/(?:MSIE |Trident\/.*; rv:)(\d+)/);
    return match ? parseInt(match[1]) : undefined;
}

function getChromeVersion() {
    var vMatch = navigator.userAgent.match(/(?:Chrome\/.*)(\d+)/);
    vMatch = vMatch + "";
    vMatch = vMatch.split(" ");
    return vMatch ? vMatch[0] : undefined;
}
/**
 * browser  타입 체크
 * @returns
 */
 function browserType(){
	var browserInfo = navigator.userAgent.toLowerCase();
	var browser     = browserInfo;

	if(browserInfo.indexOf('msie') != -1)    browser = "Explorer";
	if(browserInfo.indexOf('trident') != -1) browser = "Explorer";
	if(browserInfo.indexOf('safari') != -1)  browser = "Safari";
	if(browserInfo.indexOf('chrome') != -1)  browser = "Chrome";
	if(browserInfo.indexOf('opr') != -1)     browser = "Opera";
	if(browserInfo.indexOf('firefox') != -1) browser = "Firefox";
	if(browserInfo == browser)               browser = "등록되지 않은 브라우저 입니다";

	/*
	alert("Explorer : "+$.browser.msie);
	alert("safari : "  +$.browser.safari);
	alert("opera : "   +$.browser.opera);
	alert("mozilla : " +$.browser.mozilla);
	alert("chrome : "  +$.browser.chrome);
	*/
	return  browser;
}

if( "Explorer" == browserType() && 10 > browserVer() ){
	alert("Internet Explorer 10 이상 버전에 최적화 되어있으므로 업그레이드후 이용을 권장합니다.\n 브라우저 모드 : IE 10 , 문서 모드 : 표준");
}

	<%--
	function fn_loginProcBody(){

		var url = "/commbiz/login/loginProc.do";
		var $form  = $("#loginProcBodyForm");

		if($form.length < 1) {
			$form = $("<form id='loginProcBodyForm', method='post', action='"+url+"' target=''></form>");
			$(document.body).append($form);
		}
		//이전에 처리한 정보 삭제
		$form.empty();

		//정보 세팅
		$("<input></input>").attr({type:"hidden", name:'reqUri',  value:$.trim($("#reqUri").val())}).appendTo($form);
		$("<input></input>").attr({type:"hidden", name:'memId',  value:$.trim($("#bodyMemId").val())}).appendTo($form);
		$("<input></input>").attr({type:"hidden", name:'memPasswordEncript',  value:$.trim($("#bodyMemPasswordEncript").val())}).appendTo($form);
		$form.submit();
	}
	--%>
	function fn_loginProcBody(){
		var url = "/commbiz/login/loginProc.do";
		var $form  = $("#loginProcBodyForm");
		$form.attr("target", "");
		$form.attr("action", url);
		$form.submit();
	}

	function fn_loginProcSso(){
		var $form  = $("#spLoginFrm");
		$form.attr("target", "");
		$form.submit();
	}


	$(document).ready(function () {
		initEvent();
	});

	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {

		// input Type이 Text인 경우 Enter Key 입력시 조회
		$("#bodyMemId").keydown(function (key){
			if(key.keyCode == "13") {
				fnAfterCheckLogin();
			}
		});

		$("#bodyMemPasswordEncript").keydown(function (key){
			if(key.keyCode == "13") {
				fnAfterCheckLogin();
			}
		});

// 		$("#loginProcBodyForm").submit(function(event){
// 			fn_loginProcBody();
// 		});
	}

	function fnAfterCheckLogin(){
		var bodyMemId = "";
		var bodyMemPasswordEncript = "";
		bodyMemId = $('#bodyMemId').val();
		bodyMemPasswordEncript = $('#bodyMemPasswordEncript').val();

		if(bodyMemId == ""){
			alert("아이디를 입력해 주세요.");
			$("#bodyMemId").focus();
			return false;
		}

		if(bodyMemPasswordEncript == ""){
			alert("패스워드를 입력해 주세요.");
			$("#bodyMemPasswordEncript").focus();
			return false;
		}


		<c:choose>
			<c:when test="${ssoYn eq 'Y'}">
				$("#user_id").val(bodyMemId);
				$("#user_password").val(bodyMemPasswordEncript);
				if($("#sso-login").is(":checked") == true){
					fn_loginProcSso();
				} else {
					fn_loginProcBody();
				}
			</c:when>
			<c:otherwise>
				fn_loginProcBody();
			</c:otherwise>
		</c:choose>
	}


	function fn_OpenPopupCert(type){

			var reqUrl = "/commbiz/member/usrCrtt.do?rtnType="+type;
			com.openPopup("usrCrtt", reqUrl, 700, 350, "CENTER");
	}

	function fnOpenPopup(type){

		switch (type) {

			/* 아이디 찾기 */
			case "idFind":
				var reqUrl = "/commbiz/member/idFind.do";
				com.openPopup("idFind", reqUrl, 400, 275, "CENTER");
				break;

			/* 비밀번호 찾기 */
			case "pwFind":
				var reqUrl = "/commbiz/member/pwFind.do";
				com.openPopup("idFind", reqUrl, 400, 300, "CENTER");
				break;

			default:
				break;
		}
	}

	//공지사항, 주요학사일정, 자묻는질문팝업 상세
	function fn_board_pop(param1, param2){
		popOpenWindow("", "popSearch", 720, 500);

		var reqUrl = "/lu/cop/bbs/"+param2+"/popupSelectBoardArticle.do?nttId="+param1;

		$("#loginProcBodyForm").attr("action", reqUrl);
		$("#loginProcBodyForm").attr("target", "popSearch");
		$("#loginProcBodyForm").submit();
	}

	//공지사항, 주요학사일정, 자묻는질문팝업 목록
	function fn_board_list_pop(param1) {
		popOpenWindow("", "popSearch", 720, 500);

		var reqUrl = "/lu/cop/bbs/"+param1+"/popupSelectBoardList.do";

		$("#loginProcBodyForm").attr("action", reqUrl);
		$("#loginProcBodyForm").attr("target", "popSearch");
		$("#loginProcBodyForm").submit();
	}

	function fn_flagPlay() {
		if($("#playstop").is(".play")) {
			$("#playstop").attr('class','stop event_popup_stop');
		}else{
			$("#playstop").attr('class','play');
		}
	}

	function fn_createAccount(){
		popOpenWindow("", "popJoin", 850, 750);
		//var reqUrl = "/commbiz/outmember/popupJoinPage.do";
		var reqUrl = "/commbiz/outmember/popupAgree.do";
		$("#loginProcBodyForm").attr("action", reqUrl);
		$("#loginProcBodyForm").attr("target", "popJoin");
		$("#loginProcBodyForm").submit();
	}


	function bookmarksite(title, url) {
		//브라우져유형
		var browserInfo = navigator.userAgent.toLowerCase();
		var browser     = browserInfo;

		if(browserInfo.indexOf('msie') != -1)    browser = "Explorer";
		if(browserInfo.indexOf('trident') != -1) browser = "Explorer";
		if(browserInfo.indexOf('safari') != -1)  browser = "Safari";
		if(browserInfo.indexOf('chrome') != -1)  browser = "Chrome";
		if(browserInfo.indexOf('opr') != -1)     browser = "Opera"; 
		 
		
	    // Internet Explorer
	    if (browser=="Explorer") {

	        window.external.AddFavorite(url, title);

	    }else if(browser == "Chrome") {
	    	// Google Chrome
	        alert("Ctrl+D키를 누르시면 즐겨찾기에 추가하실 수 있습니다.");

	    }else if(browserInfo.indexOf('firefox') != -1) { 
		    // Firefox
	        window.sidebar.addPanel(title, url, "");
 
	    }else if(browser=="Opera") { 
	    	// opera 
	        var elem = document.createElement('a');
	        elem.setAttribute('href', url);
	        elem.setAttribute('title', title);
	        elem.setAttribute('rel', 'sidebar');
	        elem.click();
	    }
	} 
	
	/*
	* 화면 유효성 첵크
	*/
	function fn_formValidate() {
		
		/* if($("#check-1").is(":checked") == false ){
			alert("[이용약관] 동의는 필수항목입니다.");
			$("#check-1").focus();
			return; 
		}
		
		if($("#check-2").is(":checked") == false ){
			alert("[개인정보 수집 및 이용] 에 대한 동의는 필수항목입니다.");
			$("#check-2").focus();
			return; 
		}  */
		
		if( !$("#companyId").val() ){
			alert("기업을 선택하세요.");
			return false;
		}
		
			
		var authGroupIdCnt = $("input[name=authGroupIds]:checkbox:checked").length;

		if(authGroupIdCnt == 0){
			alert("회원유형을 선택하지 않았습니다.");
			$("#authGroupId1").focus();
			return false;
		} 
		
		
		if( !$("#loginId").val() ){
			alert("아이디를 입력하세요.");
			return false;
		}
		
		if( !$("#memCheck").val() ){
			alert("아이디 중복체크를 하세요.");
			return false;
		}
		
		
		
		if( !$("#koreanNm").val() ){
			alert("이름을 입력하세요.");
			return false;
		}
			
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
		   
		   
	
			
		if(!$("#mbtlnum").val()){
			alert("휴대폰번호를 입력하세요.");
			return false;
		}	   
		
		if(!$("#email").val()){
			alert("이메일을 입력하세요.");
			return false;
		}	
		
		if($("input:radio[name=sexdstnCd]:checked").length == 0){
			alert("성별을 선택하세요.");
			return false;
		}
		
		if(!$("#memBirth").val()){
			alert("생년월일을 입력하세요.");
			return false;
		}
		
		$("#ihidnum").val($("#memBirth").val());
		
		return true;
	}					   	   
	/* HTML Form 신규, 수정 */
	function fn_formSave(){
		if (fn_formValidate()) {
			//if(doubleSubmitCheck()) return;
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

	function fn_close(){
		$(".close-modal").click();
	}
	
</script>

<form id="spLoginFrm" name="spLoginFrm" method="post" action="<%= this.generateUrl(IDP_URL, LOGIN_URL) %>">
    <!--
    아이디 : <input type="text" name="user_id" /><br/>
    비밀번호 : <input type="text" name="user_password" />
     -->

    <input type="hidden" id="user_id" name="user_id" />
    <input type="hidden" id="user_password" name="user_password"/>

    <input type="hidden" name="<%= RELAY_STATE_NAME %>" value="/commbiz/login/ssoLoginProc.do" />
    <input type="hidden" name="<%= ID_NAME %>" value="<%= SP_ID %>" />
    <input type="hidden" name="<%= TARGET_ID_NAME %>" value="<%= SP_ID %>" />
    <!-- <input type="submit" value="SP로그인" /> -->
</form>

<form id="loginProcBodyForm" method="post" action="/commbiz/login/loginProc.do" class="gLogin">
	<input id="reqUri" name="reqUri" type="hidden" value="${reqUri }">
	<input id="menuArea" name="menuArea" type="hidden" value="LMS">
	<ul id="main-header">
		<li class="top-area">
			<h1><a href="#!">한국기술교육대학교</a></h1>
			<p><a href="#!" onclick="javascript:bookmarksite('oklms','http://oklms.koreatech.ac.kr/');" >즐겨찾기 추가</a><!-- a href="#!">아이디/비번찾기</a><a href="#!">학습지원센터</a--></p>
			<div>코리아텍에서 일과 학습을 동시에 하라!~</div>
		</li>
		<li class="top-title">일하고, 배우며, 함께 성장하는 <b>일학습병행교육!</b></li>
	</ul><!-- E : main-header -->
</form>
	<div id="main-visual">
		<ul>
			<form action="login-form-area" id="gLogin" class="gLogin">
			<li class="member-area">
				<div id="login" class="login-area gLogin">
						<fieldset>
							<legend>LOGIN</legend>
							<dl class="log-type">
							<!-- <dt>초기 아이디/비밀번호는 <b>학생(학번)/교수(사번)</b>입니다.</dt> -->
								<dt><b></b></dt>
								<dd class="item"><label for="uid" class="iLabel">아이디1</label><input type="text" name="memId" type="text" id="bodyMemId" placeholder="아이디" class="iText uid"/></dd>
								<dd class="item"><label for="upw" class="iLabel">비밀번호</label><input type="password" name="memPasswordEncript" type="password" id="bodyMemPasswordEncript" placeholder="비밀번호" class="ipass upw"/>
								
								<input name="login-btn" type="button" value="로그인" onclick="javascript:fnAfterCheckLogin();return false;"/>
								</dd>
								<dd class="btn">
								<br/><br/><br/>	<br/><br/><br/>	<br/><br/><br/>
								
								
								
								</dd>
							</dl>
							<span>
								<label for="id-save" class="save-area"><input name="checkbox" type="checkbox" id="id-save" />아이디 저장</label>
								<label for="sso-login" class="save-area"><input name="checkbox" ${ssoYn eq 'Y' ? 'checked' : ''}  type="checkbox" id="sso-login" />통합 로그인</label>
								<!-- <a href="#!" class="btn-find">비밀번호 찾기</a> -->
								<!-- <a href="#" onclick="fn_createAccount();" class="btn-find">회원 가입</a> -->
								<a href="#join-wrap" rel="modal:open"  class="btn-find">회원 가입</a>
							</span>
							<!-- <div class="idpw-find">
								<a href="#id-find" rel="modal:open" class="btn-find">아이디 찾기</a>
								<a href="#pw-find"  rel="modal:open"  class="btn-find">비밀번호 찾기</a>
							</div> -->

							<!-- <dl class="info-area">
								<dt>회원정보</dt>
								<dd class="info-photo"><img src="../../image/std/upload/user_photo_161227_0001.png" alt="" /></dd>
								<dd class="info-text"><b>홍길동홍길동홍길동홍길동홍길동홍길동홍길동홍길동홍길동홍길동</b> 님 OK-LMS에 오신것을 환영합니다.</dd>
								<dd class="info-btn"><a href="#!" class="btn-mypage">마이페이지</a><a href="#!" class="btn-logout">로그아웃</a></dd>
							</dl> -->
						</fieldset>
				</div><!-- E : login-area -->
			</li><!-- E : member-area -->
		</form>

			
			<!--  아이디 찾기 팝업 -->
			<div class="modal hauto" id="id-find" style="display:none;">
				<div class="modal-title">아이디 찾기</div>
				<div class="modal-body hauto">
					
					<form method="post" action="" enctype="" onsubmit="">            
						<div class="">
							<label for="">
							<input type="radio" name="" id="" value="" />
							회원정보에 등록한 휴대전화로 인증
							</label>
						</div>
						<div class="box03 mt-010" style="margin-bottom:0;">
							회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야 인증번호를 받을 수 있습니다.
						</div>
						
						<div class="mt-010">
							<label for="">
							<input type="radio" name="" id="" value=""  checked="checked " />
							회원정보에 등록한 이메일로 인증
							</label>
						</div>
						
						<ul class="horizontal_form type2 mt-010">
							<li>
								<div>
									<label class="jt_label" for="">이름</label>
								</div>
								<div>
									<input type="text" class="form_field jt_form_full_field" id="" name="" value="" placeholder="">
								</div>
							</li>
							<li>
								<div>
									<label class="jt_label" for="">이메일</label>
								</div>
								<div>
									<div class="form_control_wrap">
										<input type="text" class="form_field jt_inline_input2" name="" id="">
										<button type="button" class="file_button type2">인증번호발송</button>
									</div>
								</div>
							</li>
							<li>
								<div>
									<label class="jt_label" for="">인증번호</label>
								</div>
								<div>
									<div class="form_control_wrap">
										<input type="text" class="form_field jt_form_full_field" name="" id="" placeholder="인증번호 입력">
									</div>
								</div>
							</li>
						</ul>
	
						<!-- 버튼 -->
						<div class="btn-area  align-center mt-020">
							<a href="#id-find2" rel="modal:open"   class="btn btn-black">다음</a>
						</div>
						<!-- //버튼 -->
					</form>
				</div>
			</div>
			
			<div class="modal hauto" id="id-find2" style="display:none;">
				<div class="modal-title">아이디 찾기</div>
				<div class="modal-body hauto">
					<div class="box03 align-center" style="margin:0; font-size:15px;">
						 고객님의 정보와 일치하는  아이디 입니다.
					</div>
					<table class="type-2 mt-020 wp100">
						<colgroup>
							<col style="*">
							<col style="*">
						</colgroup>
						<thead>
							<tr>
								<th>아이디</th>
								<th>가입일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
							 	<td>
							 		<label for=""><input type="radio" name="" id="" value="" /> gildong1234</label>
								</td>
								<td>2020.02.12</td>
							</tr>
							
							<tr>
							 	<td>
							 		<label for=""><input type="radio" name="" id="" value="" /> gildong1234</label>
								</td>
								<td>2020.02.12</td>
							</tr>
							
							<tr>
							 	<td colspan="2">검색 결과가 없습니다.</td>
							</tr>				
						</tbody>
					</table>
				</div>
				<!-- 버튼 -->
				<div class="btn-area  align-center mb-020">
					<a href="" class="black">로그인하기</a>
					<a href="" class="black">비밀번호찾기</a>
				</div>
				<!-- //버튼 -->
			</div>
			<!--  //아이디 찾기 팝업 -->
			
			
			<!--  비밀번호 찾기 팝업 -->
			<div class="modal hauto" id="pw-find" style="display:none;">
				<div class="modal-title">비밀번호 찾기</div>
				<div class="modal-body hauto">
					<div class="box03 align-center" style="margin:0; font-size:15px;">
						 비밀번호를 찾고자 하는 아이디를 입력해주세요.
					</div>
					<form method="post" action="" enctype="" onsubmit="">            
						<ul class="horizontal_form type2 mt-010">
							<li>
								<div>
									<label class="jt_label" for="">아이디</label>
								</div>
								<div>
									<input type="text" class="form_field jt_form_full_field" id="" name="" value="" placeholder="">
								</div>
							</li>
						</ul>
	
						<!-- 버튼 -->
						<div class="btn-area  align-center mt-020">
							<a href="#pw-find2" rel="modal:open"   class="btn btn-black">다음</a>
						</div>
						<!-- //버튼 -->
					</form>
				</div>
			</div>

			<div class="modal hauto" id="pw-find2" style="display:none;">
				<div class="modal-title">비밀번호 찾기</div>
				<div class="modal-body hauto">
					<div class="box03 align-center" style="margin:0; font-size:15px;">
						 비밀번호를 찾을 방법을 선택해주세요.
					</div>
					<form method="post" action="" enctype="" onsubmit="">            
						<ul class="horizontal_form type2 mt-010">
							<li class="fs">
								<div style="padding-bottom:12px;">
									<labe for="">
										<input type="radio" id="" name="" value=""> 회원정보에 등록한 휴대전화로 인증<br /><span class="pl-015">(+82-01-6***-4***)</span>
									</label>
								</div>
							</li>
							<li class="fs">
								<div style="padding-bottom:12px;">
									<labe for="">
										<input type="radio" id="" name="" value=""> 회원정보에 등록한 이메일로 인증<br /><span class="pl-015">(asddfdf@g****.com)</span>
									</label>
								</labe>
							</li>
						</ul>
	
						<!-- 버튼 -->
						<div class="btn-area  align-center mt-020">
							<a href="#pw-find3" rel="modal:open"   class="btn btn-black">다음</a>
						</div>
						<!-- //버튼 -->
					</form>
				</div>
			</div>
			
			<div class="modal hauto" id="pw-find3" style="display:none;">
				<div class="modal-title">비밀번호 찾기</div>
				<div class="modal-body hauto">
					<div class="box03 align-center" style="margin:0; font-size:15px;">
						 비밀번호를 변경해주세요.<br />
						 다른 아이디나 사이트에서 사용한 적이 없는 안전한 비밀번호로 변경해주세요.
					</div>
					<form method="post" action="" enctype="" onsubmit="">            
						<ul class="horizontal_form type3 mt-010">
							<li class="fs">
								<div>아이디</div>
								<div>User-ID</div>
							</li>
							<li class="fs">
								<div><label class="jt_label" for="">새 비밀번호</label></div>
								<div>
									<div class="form_control_wrap">
										<input type="password" class="form_field jt_form_full_field" id="" name="" value="" placeholder="8자 이상">
									</div>
									<span class="explain"> 영문, 숫자, 특수문자를 함께 사용하면 보다 안전합니다.</span>
								</labe>
							</li>
							<li class="fs">
								<div><label class="jt_label" for="">새 비밀번호 확인</label></div>
								<div>
									<div class="form_control_wrap">
										<input type="password" class="form_field jt_form_full_field" id="" name="" value="" placeholder="">
									</div>
								</labe>
							</li>
						</ul>
	
						<!-- 버튼 -->
						<div class="btn-area  align-center mt-020">
							<a href="#pw-find2" rel="modal:open"   class="btn btn-black">다음</a>
						</div>
						<!-- //버튼 -->
					</form>
				</div>
			</div>
			<!--  //비밀번호 찾기 팝업 -->
			
			
			<!--  회원가입 팝업 -->
				<div id="join-wrap" class="modal large">
					<div class="modal-title">회원가입</div>
					<div class="modal-body hauto">
						<form method="post"  id="frmJoin" name="frmJoin" action ="">      
							<input type="hidden" name="memCheck" id="memCheck"  />      
							<input type="hidden" name="cprSeCd" id="cprSeCd" value="105"  />
							<input type="hidden" name="hffcSttusCd" id="hffcSttusCd" value="101"  />
							<input type="hidden" id="ihidnum" name="ihidnum" />
							<ul class="horizontal_form">
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">기업</label>
									</div>
									<div>
										<div class="form_control_wrap">
											
											<select id="companyId" name="companyId" class="form_field jt_form_full_field" >
												<option value="">소속기업 선택 </option>
												<c:forEach var="result" items="${listCompany}" varStatus="status">
												<option value="${result.companyId}">${result.companyName}</option>
												</c:forEach>
											</select>
											
										</div>
									</div>
								</li>
								<li class="contact_row_w350x fs">
									<div>
										<label class="jt_label" for="">회원유형</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<label for="authGroupId7"><input type="checkbox" name="authGroupIds" id="authGroupId7" value="2016AUTH0000008_COT">기업현장교사</label>
											<label for="authGroupId4"><input type="checkbox" name="authGroupIds" id="authGroupId4" value="2016AUTH0000004_CCM"> HRD 전담자</label>
										</div>
									</div>
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">구분</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<select name="">
												<option value="">선택</option>
												<option value="1">단기(온라인)</option>
												<option value="2">기본</option>
												<option value="3">심화</option>
											</select>
										</div>
									</div>	
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">아이디</label>
									</div>
									<div>
										<div class="form_control_wrap">
												<input type="text" class="form_field jt_inline_input" name="loginId" id="loginId" maxlength="15">
												<button type="button" class="file_button customfile_btn" onclick="memIdCheck();">중복확인</button>
											</div>
									</div>
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">이름</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" name="koreanNm" id="koreanNm" value="" placeholder="">
										</div>
									</div>
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">비밀번호</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="password" class="form_field jt_form_full_field" name="loginPwd" id="loginPwd1" value="" placeholder="">
										</div>
									</div>
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">비밀번호확인</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="password" class="form_field jt_form_full_field" name="loginPwd1" id="loginPwd2"  value="" placeholder="">
										</div>
									</div>
								</li>
								<li class="contact_row_w350x fs">
									<div>
										<label class="jt_label" for="">성별</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<label for="sexdstnCd1"><input type="radio" name="sexdstnCd" id="sexdstnCd1" value="101" >남</label>
											<label for="sexdstnCd2"><input type="radio" name="sexdstnCd" id="sexdstnCd2" value="102" > 여</label>
										</div>
									</div>
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">휴대폰번호</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" id="mbtlnum" name="mbtlnum" value="" placeholder="" maxlength="11">
										</div>
										<span class="explain">'-' 없이 입력</span>
									</div>
								</li>
								
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">생년월일</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" name="memBirth" id="memBirth"  maxlength="8" value="" placeholder="">
										</div>
										<span class="explain"> 8자리 입력(예:19821024)</span>
									</div>
								</li>
								
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">입사일</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" name="comBirth" id="comBirth"  maxlength="8" value="" placeholder="">
										</div>
										<span class="explain"> 8자리 입력(예:19821024)</span>
									</div>
								</li>
								
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">이메일</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" name="email" id="email" value="" placeholder="">
										</div>
									</div>	
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">휴대폰번호</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" name="hpNp" id="hpNp" value="" placeholder="">
										</div>
									</div>	
								</li>
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">사무실번호</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" name="telNo" id="telNo" value="" placeholder="">
										</div>
									</div>	
								</li>
								
								
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">직위</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="text" class="form_field jt_form_full_field" name="dutyNm" id="dutyNm"  maxlength="8" value="" placeholder="">
										</div>
									</div>
								</li>
								
								
								<li class="contact_row_w350x">
									<div>
										<label class="jt_label" for="">첨부파일</label>
									</div>
									<div>
										<div class="form_control_wrap">
											<input type="file" class="form_field jt_form_full_field" name="memFile" id="memFile" >
										</div>
									</div>
								</li>
								
							</ul>
							<!-- //신고서 작성 폼 -->

							<div class="agree_check box07  mt-020">
								<label class="check-1">
									<input class="jt_icheck" type="checkbox" name="check-1" id="check-1" > <strong>이용약관, 개인정보 수집 및 이용에 모두 동의합니다.</strong>
								</label>
								
								<div class="mt-020">
									<label class="check-2">
										<input class="jt_icheck" type="checkbox" name="check-2" id="check-2" > 이용약관 동의(필수)
									</label>
									<a href="#agree01" class="btn btn-black btn-xsm">보기 <i class="xi-external-link"></i></a>
									<br />
									<label class="check-3">
										<input class="jt_icheck" type="checkbox" name="check-3" id="check-3" > 개인정보 수집 및 이용에 대한 안내(필수)
									</label>
									<a href="#agree02" class="btn btn-black btn-xsm">보기 <i class="xi-external-link"></i></a>
								</div>
							</div>

							
							<!-- 버튼 -->
							<div class="btn-area  align-center mt-020">
								<a href="javascript:fn_close();" class="black">취소</a>
								<a href="javascript:fn_formSave();" class="yellow">등록</a>
							</div>
							<!-- //버튼 -->
						</form>
					</div>
				</div>
				<!--  //회원가입 팝업  -->
				
				<script type="text/javascript" charset="utf-8">
					$(function() {
						$('a[href="#agree01"]').click(function(event) {
					 		event.preventDefault();
					   		$(this).modal({
					      	closeExisting: false
							});
						});
					});
					
					$(function() {
						$('a[href="#agree02"]').click(function(event) {
					 		event.preventDefault();
					   		$(this).modal({
					      	closeExisting: false
							});
						});
					});
				</script>
				
				
				<div class="modal hauto" id="agree01" style="display:none;">
					<div class="modal-title">이용약관</div>
					<div class="modal-body hauto">
						<dl class="join-agree">
						<dt>서비스 이용약관</dt>
						<dd class="agree-box">
							<div class="agree-cont">
								<h5>제 1장 총칙</h5>
								<p>제 1조 (목적)</p>
								<span>1. 본 약관은 한국기술교육대학교(이하 "대학")의 OK-LMS(이하 "사이트")에서 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와 대학 사이트(oklms.koreatech.ac.kr)의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</span>
		
								<p>제 2조 (약관의 효력과 변경)</p>
								<span>1. 대학 사이트는 귀하가 본 약관 내용에 동의하는 경우, 대학 사이트의 서비스 제공행위 및 귀하의 서비스 사용행위에 본 약관이 우선적으로 적용됩니다.<br>2. 대학 사이트는 필요한 경우 본 약관을 관련 법령에 위배되지 않는 범위 내에서 변경할 수 있으며, 변경된 약관은 대학 사이트 내에 공지하며, 이용자의 권리 또는 의무에 관한 중요한 내용의 변경은 최소한 7일 이전에 공지합니다.<br>3. 회원이 변경된 약관에 동의하지 않는 경우, 사이트 회원등록을 취소 또는 회원탈퇴 (원서접수 후 해당시험일 미경과시 탈퇴불가)할 수 있으며, 7일 이후에도 거부의사 없이 서비스를 계속 사용할 경우 약관 변경 사항에 대한 동의로 간주됩니다.</span>
		
								<p>제 3조 (약관 외 준칙)</p>
								<span>1. 본 약관에 명시되지 않은 사항은 개인정보보호법, 전기통신사업법 및 기타 관련 법령의 규정에 따르며, 그렇지 않은 경우에는 일반적인 관례에 따릅니다.</span>
		
								<p>제 4조 (용어의 정의) 본 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>
								<span>1. 이용(접수)자 : 본 약관에 따라 대학 사이트가 제공하는 서비스를 받는 자<br>2. 가입 : 대학 사이트가 제공하는 회원가입 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용 계약을 완료시키는 행위<br>3. 회원 : 대학 사이트에 개인정보를 제공하여 회원등록을 한 자로서 대학 사이트가 제공하는 서비스를 이용할 수 있는 자<br>4. ID : 가입회원의 식별과 서비스 이용을 위해 회원이 선정한 문자와 숫자의 조합<br>5. 비밀번호 : 이용자와 회원ID가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합<br>6. 탈퇴 : 회원이 회원스스로 이용계약을 종료시키는 행위</span>
		
		
		
								<h5>제 2장 서비스 제공 및 이용</h5>
								<p>제 5조 (이용계약의 성립)</p>
								<span>1. 이용계약은 신청자가 온라인으로 대학 사이트에서 제공하는 소정의 회원가입신청 양식에서 요구하는 사항 을 기록하여 가입을 완료하는 것으로 성립됩니다.<br>2. 대학 사이트는 다음 각 호에 해당하는 이용계약에 대하여는 가입을 취소할 수 있습니다.
									<div>1) 다른 사람의 명의를 사용하여 신청하였을 때<br>2) 회원가입신청서의 내용을 허위로 기재하여 신청하였을 때<br>3) 다른 사람의 대학 사이트 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때<br>4) 대학 사이트를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우<br>5) 기타 대학 사이트가 정한 이용신청요건이 미비 되었을 때<br>6) 14세 미만의 아동이 법정대리인의 동의를 얻지 아니한 경우</div>
								</span>
		
								<p>제 6조 (회원정보 사용에 대한 동의)</p>
								<span>1. 회원의 개인정보는 개인정보보호법, 정보통신망이용촉진 및 정보보호등에 관한 법률 및 관련 법률에 의해 보호됩니다.<br>2. 대학 사이트의 회원 정보는 다음과 같이 사용, 관리, 보호됩니다.
									<div>1) 개인정보의 사용 : 대학 사이트는 서비스 제공과 관련해서 수집된 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다. 단, 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리 위원회의 요청이 있는 경우 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우, 귀하가 대학 사이트에 제공한 개인정보를 스스로 공개한 경우에는 그러하지 않습니다.<br>2) 개인정보의 관리 : 귀하는 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 성명과 주민등록번호를 제외하고 수시로 귀하의 개인정보를 변경할 수 있습니다.<br>3) 개인정보의 보호 : 귀하의 개인정보는 오직 귀하와 귀하의 요구에 의해 대학사이트 관리자만이 열람/수정/삭제할 수 있으며, 이는 전적으로 귀하의 ID와 비밀번호에 의해 관리되고 있습니다. 따라서 타인에게 본인의 ID와 비밀번호를 알려주어서는 안되며, 작업 종료시에는 반드시 로그아웃 해주시기 바랍니다.</div>
								3. 회원이 본 약관에 따라 이용신청을 하는 것은, 대학 사이트가 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주됩니다.</span>
		
								<p>제 7조 (사용자의 정보 보안)</p>
								<span>1. 가입 신청자가 대학 사이트 서비스 가입 절차를 완료하는 순간부터 귀하는 입력한 정보의 비밀을 유지할 책임이 있으며, 회원의 ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있습니다.<br>2. ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있으며, 당 사이트가 관계법령 및 개인정보 보호정책에 의거하여 그 책임을 지는 경우를 제외하고 회원에게 부여된 ID의 비밀번호 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.<br>3. 이용자는 대학 사이트에서 서비스사용 종료시마다 정확히 접속을 종료해야 하며, 정확히 종료하지 아니함으로써 제3자가 귀하에 관한 정보를 이용하게 되는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 대학 사이트는 책임을 부담하지 아니합니다.</span>
		
								<p>제 8조 (서비스의 중지 및 제한)</p>
								<span>1. 대학 사이트는 이용자가 본 약관의 내용에 위배되는 행동을 한 경우나 다음 각 호에 해당하는 경우 서비스의 중지 및 사용을 제한할 수 있습니다.
									<div>1) 서비스용 설비의 보수 또는 공사로 인한 부득이한 경우<br>2) 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 때<br>3) 국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 때</div>
								</span>
		
								<p>제 9조 (서비스의 변경 및 해지)</p>
								<span>1. 대학 사이트는 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관하여는 책임을 지지않습니다.<br>2. 대학 사이트는 서비스 이용과 관련하여 가입자에게 발생한 손해 중 가입자의 고의, 과실에 의한 손해에 대하여 책임을 부담하지 아니합니다.</span>
		
		
		
								<h5>제 3장 의무 및 책임</h5>
								<p>제 10조 (대학 사이트의 의무)</p>
								<span>1. 대학 사이트는 회원의 개인 신상정보를 본인의 승낙없이 타인에게 누설, 배포하지 않습니다. 다만, 전기통신관련법령 등 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 그러하지 아니합니다.</span>
		
								<p>제 11조 (회원의 의무)</p>
								<span>1. 회원 가입시에 요구되는 정보는 정확하게 기입하여야 합니다. 또한 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 하며, 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.<br>2. 회원은 대학 사이트의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.</span>
		
								<p>제 12조 (양도금지)</p>
								<span>1. 회원이 서비스의 이용권한, 기타 이용계약 상 지위를 타인에게 양도, 증여할 수 없습니다.</span>
		
								<p>제 13조 (손해배상)</p>
								<span>1. 대학 사이트는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 대학 사이트가 고의로 행한 범죄행위를 제외하고 이에 대하여 책임을 부담하지 아니합니다.</span>
		
								<p>제 14조 (면책조항)</p>
								<span>1. 대학 사이트는 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않습니다. 대학 사이트는 어떠한 경우라도 회원이 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다.<br>2. 대학 사이트는 회원간 또는 회원과 제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련하여 어떠한 책임도 부담하지 아니하고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다.</span>
		
								<p>제 15조 (재판관할)</p>
								<span>1. 대학 사이트와 이용자간에 발생한 서비스 이용에 관한 분쟁에 관한 소송은 한국산업인력대학 주소지 관할 법원으로 합니다.</span>

								<h5>부 칙</h5>
								<p>1. (시행일) 본 약관은 2017년 00월 00일부터 시행한다.</p>
							</div>
						</dd>
					</dl>
					</div>
				</div>

					
				<div class="modal hauto" id="agree02" style="display:none;">
					<div class="modal-title">개인정보 수집 및 이용에 대한 안내</div>
					<div class="modal-body hauto">
						<dl class="join-agree">
							<dt>개인정보 수집 및 이용에 대한 안내</dt>
							<dd class="agree-box">
								<div class="agree-cont">
									<p>1. 개인정보의 수집·이용 목적</p>
									<span>사이트에서 제공하는 서비스는 다음의 목적을 위해 개인정보를 수집·이용합니다. 수집된 개인정보는 다음 목적 이외의 용도로 이용되지 않습니다.
										<div>- (서비스 제공)공지사항, 훈련콘텐츠 제공, 본인인증 등의 서비스 제공에 관련한 목적으로 개인정보를 처리합니다.<br>- (회원가입 및 관리)한국기술교육대학교에서 제공하는 일학습병행제 훈련 서비스 등의 회원제 서비스 이용에 따른 본인확인, 개인 식별, 불량회원의 부정이용 방지와 비인가 사용방지, 연령확인, 분쟁조정을 위한 기록보존, 불만처리 등 민원처리, 공지사항 전달 등의 목적으로 개인정보를 처리합니다.</div>
									</span>
			
									<p>2. 개인정보의 수집항목, 수집방법, 보유근거, 보유기간</p>
									<span>개인정보의 보유 및 이용기간은 다음과 같습니다.<br>[OK-LMS 개인정보 처리방침] 한국기술교육대학교가 수집 및 보유하는 개인정보</span>
			
									<p>3. 개인정보 수집에 대한 거부 권리 및 그에 따른 서비스 제한사항</p>
									<span>이용자는 대학 사이트에서 수집하는 개인정보에 대해 동의를 거부할 권리가 있으나 필수항목에 대한 수집, 이용에 대한 동의 거부 시 회원가입과 서비스 이용에 제한을 받을 수 있습니다.</span>
			
									<p>4. 개인정보수집 및 이용자 : 한국기술교육대학교</p>
								</div>
							</dd>
						</dl>
					</div>
				</div>
			
			
			
			
			
			<li class="popup-area">
				<h2>POPUP ZONE</h2>
 
				<div class="pop-img">
					<c:if test="${fn:length(popupzoneResultList) != 0}">
						<c:forEach var="bannerResult" items="${popupzoneResultList}" varStatus="status">
						<c:if test="${bannerResult.sortOrdr == 1}">
							<p class="popupitem" style="display:block;"><a href="${bannerResult.linkUrl}" target="_blank"  title="새 창으로 이동" ><img src="/cmm/fms/getImage.do?atchFileId=${bannerResult.bannerImageFile}" alt="배너${status.count}"  /></a></p>
						</c:if>
						<c:if test="${bannerResult.sortOrdr != 1}">
							<p class="popupitem"><a href="${bannerResult.linkUrl}" target="_blank"  title="새 창으로 이동" ><img src="/cmm/fms/getImage.do?atchFileId=${bannerResult.bannerImageFile}" alt="배너${status.count}" /></a></p>
						</c:if>

						</c:forEach>
					</c:if>
				</div> 
				<!--div class="pop-img">
					<p class="popupitem" style="display:block;"><img src="/images/oklms/std/upload/main_banner_01.png" alt="배너1" /></p>
					<p class="popupitem"><img src="/images/oklms/std/upload/main_banner_02.png" alt="배너2" /></p>
					<p class="popupitem"><img src="/images/oklms/std/upload/main_banner_03.png" alt="배너3" /></p>
				</div -->
				<div class="pop-btn">
					<span class="prev event_popup_prev"><a href="#!" title="이전">이전</a></span>
					<span id="playstop" class="stop event_popup_stop"><a href="javascript:fn_flagPlay();" title="정지">정지/재생</a></span>
					<!-- 정지 클릭하였을 때 class="play" 로 교체 -->
					<span class="next event_popup_next"><a href="#!" title="다음">다음</a></span>
				</div>
			</li><!-- E : popup-area -->



			<li class="banner-area-1"><a href="#!">이용자매뉴얼</a></li>
			<li class="banner-area-2"><a href="#!" onclick="fn_board_list_pop('BBSMSTR_000000000010');">자주묻는질문</a></li>
		</ul>

		<div id="mvisual-wrap">
			<div class="ctrl-btns">
				<a href="#!" class="ctrl-btn btn-prev" title="이전">이전</a>
				<a href="#!" class="ctrl-btn btn-next" title="다음">다음</a>
				<div class="cnums-wrap">
					<div class="ctrl-nums">
						<c:forEach var="a" begin="1" end="${fn:length(mainResultList)}" step="1">
						<a href="#visImg${a}"><span>${a}</span></a>
					    </c:forEach>
					</div>
					<!--div class="ctrl-nums"><a href="#visImg1"><span>1</span></a><a href="#visImg2"><span>2</span></a><a href="#visImg3"><span>3</span></a></div-->
					<a href="#!" class="ctrl-btn btn-play"><span>재생</span></a>
					<a href="#!" class="ctrl-btn btn-stop"><span>정지</span></a>
				</div>
			</div>
			<div id="mvisual">
				<div class='visImgEffectWrap'>
					<c:if test="${fn:length(mainResultList) != 0}">
						<c:forEach var="mainResult" items="${mainResultList}" varStatus="status">
						<div class='visImgEffect'><div class="visImg"><img src="/cmm/fms/getImage.do?atchFileId=${mainResult.bannerImageFile}" alt="New Start! 일과 학습을 동시에, 취업난도 해결하고 기업이 원하는 맞춤형 인력을 양성할 수 있는 제도" /></div></div>
						</c:forEach>
					</c:if>
					<!--div class='visImgEffect'><div class="visImg"><img src="/images/oklms/std/main/main_visual1.png" alt="New Start! 일과 학습을 동시에, 취업난도 해결하고 기업이 원하는 맞춤형 인력을 양성할 수 있는 제도" /></div></div>
					<div class='visImgEffect'><div class="visImg"><img src="/images/oklms/std/main/main_visual2.png" alt="New Start! 일과 학습을 동시에, 취업난도 해결하고 기업이 원하는 맞춤형 인력을 양성할 수 있는 제도" /></div></div>
					<div class='visImgEffect'><div class="visImg"><img src="/images/oklms/std/main/main_visual3.png" alt="New Start! 일과 학습을 동시에, 취업난도 해결하고 기업이 원하는 맞춤형 인력을 양성할 수 있는 제도" /></div></div-->
				</div>
			</div>
		</div>

		<script type="text/javascript">
			var mVisual = new mainVisualEffect({obj:$("#mvisual-wrap"), contents:'.visImgEffect',prevBtn:$("#mvisual-wrap .btn-prev"),nextBtn:$("#mvisual-wrap .btn-next"), isPlay:true});
		</script>
	</div><!-- E : main-visual -->
	<div id="main-container">

		<div id="main-content">
			<dl class="notice">
				<dt>공지사항</dt>
				<c:if test="${fn:length(noticeResultList) == 0}">
					<dd>등록된 공지사항이 없습니다.</dd>
				</c:if>
				<c:forEach var="noticeResult" items="${noticeResultList}" varStatus="status">
				<dd>
					<c:choose>
					<c:when test="${'Y' == noticeResult.topNoticeYn}">
						<a href="#!"  onclick="fn_board_pop('${noticeResult.nttId}','${noticeResult.bbsId}');"><B><c:out value="${noticeResult.nttSj}"/></B>
							<c:if test="${noticeResult.isNowdateFlag == 'NOW'}">
							<img src="/images/oklms/std/main/icon_news.png" alt="새글" />
							</c:if>
						</a>
					</c:when>
					<c:otherwise>
						<a href="#!"  onclick="fn_board_pop('${noticeResult.nttId}','${noticeResult.bbsId}');"><c:out value="${noticeResult.nttSj}"/>
							<c:if test="${noticeResult.isNowdateFlag == 'NOW'}">
							<img src="/images/oklms/std/main/icon_news.png" alt="새글" />
							</c:if>
						</a>
					</c:otherwise>
					</c:choose>
				</dd>
				</c:forEach>
				<dd class="more"><a href="#!" onclick="fn_board_list_pop('BBSMSTR_000000000000');" title="더 보기">공지사항 더 보기</a></dd>
			</dl><!-- E : notice -->

			<dl class="schedule">
				<dt>주요학사일정</dt>
				<c:if test="${fn:length(academicCalendarResultList) == 0}">
					<dd>등록된 주요학사일정이 없습니다.</dd>
				</c:if>
				<c:forEach var="academicCalendarResult" items="${academicCalendarResultList}" varStatus="status">
				<dd>
					<c:choose>
					<c:when test="${'Y' == academicCalendarResult.topNoticeYn}">
						<a href="#!"  onclick="fn_board_pop('${academicCalendarResult.nttId}','${academicCalendarResult.bbsId}');"><span>[${academicCalendarResult.frstRegisterPnttm}]</span><B><c:out value="${academicCalendarResult.nttSj}"/></B>
							<c:if test="${academicCalendarResult.isNowdateFlag == 'NOW'}">
							<img src="/images/oklms/std/main/icon_news.png" alt="새글" />
							</c:if>
						</a>
					</c:when>
					<c:otherwise>
						<a href="#!"  onclick="fn_board_pop('${academicCalendarResult.nttId}','${academicCalendarResult.bbsId}');"><span>[${academicCalendarResult.frstRegisterPnttm}]</span><c:out value="${academicCalendarResult.nttSj}"/>
							<c:if test="${academicCalendarResult.isNowdateFlag == 'NOW'}">
							<img src="/images/oklms/std/main/icon_news.png" alt="새글" />
							</c:if>
						</a>
					</c:otherwise>
					</c:choose>
				</dd>
				</c:forEach>
				<dd class="more"><a href="#!" onclick="fn_board_list_pop('BBSMSTR_000000000004');" title="더 보기">주요학사일정 더 보기</a></dd>
			</dl><!-- E : schedule -->

			<dl class="customer">
				<dt>시스템 사용문의</dt>
				<!-- <dd class="number">041.560.1114</dd> -->
				<dd>운영시간 : 평일 9AM - 6PM</dd>
				<dd class="mail"><span>이메</span>일 : <a href="mailto:oklms@koreatech.ac.kr" title="메일보내기">oklms@koreatech.ac.kr</a></dd>
			</dl><!-- E : customer -->
		</div><!-- E : main-content -->

	</div><!-- E : main-container -->

	<div id="main-link">
		<ul>
			<li>
				<a href="http://email.koreatech.ac.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_shortcut1.png" alt="웹메일" /></a>
				<!-- <a href="http://el.koreatech.ac.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_shortcut2.png" alt="온라인교육" /></a> -->
				<a href="http://www.koreatech.ac.kr/kor/sub04_04_02.do" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_shortcut3.png" alt="제증명" /></a>
				<a href="http://help.koreatech.ac.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_shortcut4.png" alt="원격지원" /></a>
				<a href="http://dasan.koreatech.ac.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_shortcut5.png" alt="다산정보관" /></a>
				<a href="http://knw.koreatech.ac.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_shortcut6.png" alt="웹디스크" /></a>
			</li>
			<li class="main_site">
				<a href="http://www.moel.go.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_site1.png" alt="고용노동부" /></a>
				<a href="http://www.koreatech.ac.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_site2.png" alt="한국기술교육대학교" /></a>
				<a href="http://www.hrd.go.kr" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_site3.png" alt="통합 HRD-Net" /></a>

				<!-- 20170407 배너추가 -->
				<a href="http://www.bizhrd.net" target="_blank" title="새창열림"><img src="/images/oklms/std/main/main_site4.png" alt="기업일학습" /></a>
			</li>
		</ul>
	</div><!-- E : main-link -->
	
	
	 
	
	
	
	
	 	 




