<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ page import="org.apache.commons.lang3.time.DateUtils" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="kr.co.gocle.oklms.commbiz.util.BizUtil" %>
<%@ page import="kr.co.gocle.oklms.comm.vo.LoginInfo" %>
<%@ page import="egovframework.com.cmm.service.Globals" %>
<%@ page import="egovframework.com.cmm.LoginVO" %>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%-- <%@ page import="kr.co.gocle.oklms.sys.menu.vo.MenuMngmVO" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
${googleAnalytics.optValue}
<%@ include file="/include/sso_entry.jsp" %>

<script>
	function fn_authChange(selectObject){
		var value = selectObject.value;
		location.href = "/commbiz/auth/authProc.do?authGroupSet="+value;
	}
</script>

<!-- 2020년 jQuery 추가 -->
<script type="text/javascript" src="/js/oklms/filter.js"></script>
<script type="text/javascript" src="/js/oklms/nav.js"></script>	

<!-- oklms Header -->
<%
LoginInfo loginInfo = new LoginInfo(); 
String authGroupSet = loginInfo.getAuthGroupId();
%>

<c:set var="SESSION_AUTH_GROUP_SET" value="<%=authGroupSet %>"/>

<!-- ############### LU Header ############### -->
<ul id="header">
	<li class="logo-area"><h1><a href="/lu/main/lmsUserMainPage.do">한국기술교육대학교</a></h1></li>
	
	
	
	<li class="gnb-area">
	<c:if test="${fn:length(authList) > 1}">
		<span>
			<label for="authGroupSet" class="hidden">사용자 선택</label>
			<select name="authGroupSet" id="authGroupSet" onchange="fn_authChange(this);">
				<c:forEach var="result" items="${authList}" varStatus="status">
					<option value="${result.authGroupSet}" ${result.authGroupSet eq SESSION_AUTH_GROUP_SET ? 'selected' : ''}>${result.authGroupName}</option>
				</c:forEach>
			</select>
		</span>
	</c:if>
<%-- <%
if("STD".equals(loginInfo.getMemType())){
	// 학습근로자
%>
		<a href="/lu/today/lmsUserTodayPage.do#f_1" class="type-1<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1 == 0}">-on</c:if>">학습활동서<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_2" class="type-3<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2 == 0}">-on</c:if>">Q&A<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_3" class="type-7<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3 == 0}">-on</c:if>">과제<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_4" class="type-6<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt4 == 0}">-on</c:if>">팀프로젝트<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt4}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_5" class="type-5<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt5 == 0}">-on</c:if>">토론<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt5}</span>건</a>
<%   
}else if("CDP".equals(loginInfo.getMemType())){
	// 학과전담자
%>
	<a href="/lu/today/lmsUserTodayPage.do#f_1" class="type-3<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1 == 0}">-on</c:if>">Q&A<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1}</span>건</a>
	<a href="/lu/today/lmsUserTodayPage.do#f_2" class="type-7<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2 == 0}">-on</c:if>">과제<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2}</span>건</a>
	<a href="/lu/today/lmsUserTodayPage.do#f_3" class="type-6<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3 == 0}">-on</c:if>">팀프로젝트<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3}</span>건</a>
	<a href="/lu/today/lmsUserTodayPage.do#f_4" class="type-5<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt4 == 0}">-on</c:if>">토론<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt4}</span>건</a>
	<a href="/lu/today/lmsUserTodayPage.do#f_5" class="type-1<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt6 == 0}">-on</c:if>">제직증빙서류<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt6}</span>건</a>
<%   
}else if("CCN".equals(loginInfo.getMemType())){
	// 조회시간 문제로 예외처리 센터담당자
%>
		<a href="/lu/today/lmsUserTodayPage.do#f_1" class="type-1<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1 == 0}">-on</c:if>">주간훈련일지<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_2" class="type-3<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2 == 0}">-on</c:if>">학습활동서<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_3" class="type-7<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3 == 0}">-on</c:if>">면담일지<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_4" class="type-6<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt4 == 0}">-on</c:if>">훈련시간표<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt4}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_5" class="type-5<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt5 == 0}">-on</c:if>">담당자변경<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt5}</span>건</a>

<%   
}else if("COT".equals(loginInfo.getMemType())){
	// 기업현장교사
%><%   
}else if("PRT".equals(loginInfo.getMemType())){
	// 교수
%><%   
}else if("CCM".equals(loginInfo.getMemType())){
	// HRD담당자	
%>
		<a href="/lu/today/lmsUserTodayPage.do#f_1" class="type-1<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1 == 0}">-on</c:if>">활동내역서<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt1}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_2" class="type-3<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2 == 0}">-on</c:if>">주간훈련일지<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt2}</span>건</a>
		<a href="/lu/today/lmsUserTodayPage.do#f_3" class="type-7<c:if test="${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3 == 0}">-on</c:if>">학습활동서<span>${listLmsUserMainPageTodayCnt[0].myPageTodayCnt3}</span>건</a>
<%   
}else{
%>

<%		
}
%> --%>
	</li>
	<li class="m_nav_btn">
          <button class="m_show" style="display: block;"><span class="sr-only">모바일메뉴열기</span></button>
          <button class="m_closed" style="display: none;"><span class="sr-only">모바일메뉴닫기</span></button>
	</li>
</ul>




<!-- E : header : 상단 헤더 영역-->
<!-- ############### // LU Header ############### -->
 	<!-- <form id="frmMail" name="frmMail" method="post">
	<input type="hidden" name="weekCnt" id="mailWeekCnt" />
	<input type="hidden" name="memId" id="mailMemId" />
	<input type="hidden" name="lastDate" id="mailLastDate" />
	<input type="hidden" name="mailTempType" id="mailTempType" />
	<input type="hidden" name="subjectCode" id="mailSubjectCode" />
	
	<input type="hidden" name="companyId" id="mailCompanyId" />
	<input type="hidden" name="traningProcessId" id="mailTraningProcessId" />
	<input type="hidden" name="cotMemIds" id="cotMemIds"/>
	<input type="hidden" name="ccmMemIds" id="ccmMemIds"/>
	</form> -->
	
	<form id="frmAgree" name="frmAgree" method="post">
 	</form>
	
<script type="text/javascript">


/* 
function fn_send_mail(weekCnt,memId,lastDate,mailTempType,subjectCode){
	
	$("#mailWeekCnt").val(weekCnt);
	$("#mailMemId").val(memId);
	$("#mailLastDate").val(lastDate);
	$("#mailTempType").val(mailTempType);
	$("#mailSubjectCode").val(subjectCode);

	window.open("", "mailPopup", "width=940, height=580, left=100, top=50"); 
	
	$("#frmMail").attr("action","/lu/mail/mailSendPopup.do"); 
	$("#frmMail").attr("method", "post" );
	$("#frmMail").attr("target","mailPopup"); 
	$("#frmMail").submit();	

}
function fn_send_sms(weekCnt,memId,lastDate,mailTempType,subjectCode){
	
	$("#mailWeekCnt").val(weekCnt);
	$("#mailMemId").val(memId);
	$("#mailLastDate").val(lastDate);
	$("#mailTempType").val(mailTempType);
	$("#mailSubjectCode").val(subjectCode);

	window.open("", "smsPopup", "width=640, height=550, left=100, top=50"); 
	
	$("#frmMail").attr("action","/lu/sms/smsSendPopup.do"); 
	$("#frmMail").attr("method", "post" );
	$("#frmMail").attr("target","smsPopup"); 
	$("#frmMail").submit();	

}
function fn_send_sms_cot(weekCnt,memId,lastDate,mailTempType,subjectCode){
	
	$("#mailWeekCnt").val(weekCnt);
	$("#mailMemId").val(memId);
	$("#mailLastDate").val(lastDate);
	$("#mailTempType").val(mailTempType);
	$("#mailSubjectCode").val(subjectCode);

	window.open("", "smsPopupCot", "width=640, height=550, left=100, top=50"); 
	
	$("#frmMail").attr("action","/lu/sms/smsSendPopupCot.do"); 
	$("#frmMail").attr("method", "post" );
	$("#frmMail").attr("target","smsPopupCot"); 
	$("#frmMail").submit();	

}
function fn_sms_cot_company(){
 
	window.open("", "smsPopupCot", "width=640, height=550, left=100, top=50"); 
	
	$("#frmMail").attr("action","/lu/sms/smsSendPopupCompany.do"); 
	$("#frmMail").attr("method", "post" );
	$("#frmMail").attr("target","smsPopupCot"); 
	$("#frmMail").submit();	

}
function fn_set_sms(memId){
	 
	$("#mailMemId").val(memId);
	window.open("", "smsPopup", "width=640, height=550, left=100, top=50"); 
	
	$("#frmMail").attr("action","/lu/sms/smsSendPopup.do"); 
	$("#frmMail").attr("method", "post" );
	$("#frmMail").attr("target","smsPopup"); 
	$("#frmMail").submit();	

} */

function fn_sndAllClick(formName){ 
	$("#"+formName+" input[name=memIds]:checkbox").each(function() {
	    $(this).attr("checked",$("#chbox").is(":checked"));
	});	 
}



function fn_send_mail(weekCnt,memId,lastDate,mailTempType,subjectCode){
	$("#frmMail")[0].reset(); 
	
	$("#frmMail #mailWeekCnt").val(weekCnt);
	$("#frmMail #mailMemId").val(memId);
	$("#frmMail #mailLastDate").val(lastDate);
	//$("#frmMail #mailTempType").val(mailTempType);
	$("#frmMail #mailSubjectCode").val(subjectCode);
	
	
	var reqUrl = "/lu/mail/mailSendPopup.json";
	var param = $("#frmMail").serializeArray();
	var html = "";
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			//com.alert( jqXHR.responseJSON.retMsg );
			var resultlist  = jqXHR.responseJSON.resultlist;
			var mailVO = jqXHR.responseJSON.mailVO;
			
			$("#mail_body").html("");
			$("#mail_member_total").html("전체 "+resultlist.length+"건");
			$("#mail_member_list").html("전체 "+resultlist.length+"건");
			
			for (var i = 0; i < resultlist.length; i++) {
				
				
				html += "<tr>";
				html += "	<td><input type='checkbox' name='memIds' value='"+resultlist[i].memId+"' checked /></td>";
				html += "	<td>"+resultlist[i].memId+"</td>";
				html += "	<td>"+resultlist[i].memName+"</td>";
				html += "<tr>";
				
			}
			
//			$("<input></input>").attr({type:"hidden", name:"yyyy",  value:$.trim(mailVO.yyyy)}).appendTo($("#frmMail"));
//			$("<input></input>").attr({type:"hidden", name:"term",  value:$.trim(mailVO.term)}).appendTo($("#frmMail"));
	//		$("<input></input>").attr({type:"hidden", name:"weekCnt",  value:$.trim(mailVO.weekCnt)}).appendTo($("#frmMail"));
		//$("<input></input>").attr({type:"hidden", name:"subjectCode",  value:$.trim(mailVO.subjectCode)}).appendTo($("#frmMail"));
	///		$("<input></input>").attr({type:"hidden", name:"lastDate",  value:$.trim(mailVO.lastDate)}).appendTo($("#frmMail"));
			$("<input></input>").attr({type:"hidden", name:"receiveName",  value:$.trim(mailVO.receiveName)}).appendTo($("#frmMail"));
			//$("<input></input>").attr({type:"hidden", name:"msgType",  value:$.trim("1")}).appendTo($("#frmMail"));
			
			$("#mail_body").append(html);
			//$("#email-wrap").show();
			$('.jquery-modal').css('display','block');
			$("#email-wrap").css('display', 'inline-block');
			
		} else {
			alert("교과정보를 읽어오는대 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});

}
function fn_send_sms(weekCnt,memId,lastDate,mailTempType,subjectCode){
	
	$("#frmSms")[0].reset(); 
	
	
	$("#frmSms #mailWeekCnt").val(weekCnt);
	$("#frmSms #mailMemId").val(memId);
	$("#frmSms #mailLastDate").val(lastDate);
	$("#frmSms #mailTempType").val(mailTempType);
	$("#frmSms #mailSubjectCode").val(subjectCode);
	
	var reqUrl = "/lu/sms/smsSendPopupJson.json";
	var param = $("#frmSms").serializeArray();
	var html = "";
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			//com.alert( jqXHR.responseJSON.retMsg );
			
			var resultlist  = jqXHR.responseJSON.resultlist;
			var mailVO = jqXHR.responseJSON.mailVO;
			
			$("#sms_body").html("");
			$("#sms_member_list").html("("+resultlist.length+"명)");
			$("#sms_member_total").html("전체 "+resultlist.length+"건");
			
			for (var i = 0; i < resultlist.length; i++) {
				html += "<tr>";
				html += "	<td><input type='checkbox' name='memIds' value='"+resultlist[i].memId+"' checked /></td>";
				html += "	<td>"+resultlist[i].memId+"</td>";
				html += "	<td>"+resultlist[i].memName+"</td>";
				html += "<tr>";
				
			}
			
//			$("<input></input>").attr({type:"hidden", name:"yyyy",  value:$.trim(mailVO.yyyy)}).appendTo($("#frmSms"));
//			$("<input></input>").attr({type:"hidden", name:"term",  value:$.trim(mailVO.term)}).appendTo($("#frmSms"));
//			$("<input></input>").attr({type:"hidden", name:"weekCnt",  value:$.trim(mailVO.weekCnt)}).appendTo($("#frmSms"));
	//		$("<input></input>").attr({type:"hidden", name:"subjectCode",  value:$.trim(mailVO.subjectCode)}).appendTo($("#frmSms"));
//			$("<input></input>").attr({type:"hidden", name:"lastDate",  value:$.trim(mailVO.lastDate)}).appendTo($("#frmSms"));
			$("<input></input>").attr({type:"hidden", name:"receiveName",  value:$.trim("")}).appendTo($("#frmSms"));
			
			$("#sms_body").append(html);
			
			//$("#sms-wrap").show();
			$('.jquery-modal').css('display','block');
			$("#sms-wrap").css('display', 'inline-block');
			
		} else {
			alert("교과정보를 읽어오는대 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});

}
function fn_send_sms_cot(weekCnt,memId,lastDate,mailTempType,subjectCode){
	
	$("#frmSms")[0].reset(); 
	
	$("#frmSms #mailWeekCnt").val(weekCnt);
	$("#frmSms #mailMemId").val(memId);
	$("#frmSms #mailLastDate").val(lastDate);
	$("#frmSms #mailTempType").val(mailTempType);
	$("#frmSms #mailSubjectCode").val(subjectCode);
	
	var reqUrl = "/lu/sms/smsSendPopupCot.json";
	var param = $("#frmSms").serializeArray();
	
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			//com.alert( jqXHR.responseJSON.retMsg );
			
			
		} else {
			alert("교과정보를 읽어오는대 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});

}
function fn_sms_cot_company(){
 
	
	var reqUrl = "/lu/sms/smsSendPopupCompany.json";
	var param = $("#frmSms").serializeArray();
	
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			//com.alert( jqXHR.responseJSON.retMsg );
			
			
		} else {
			alert("교과정보를 읽어오는대 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});
 
}
function fn_set_sms(memId){
	  
	$("#frmSms #mailMemId").val(memId);
	
	var reqUrl = "/lu/sms/smsSendPopup.json";
	var param = $("#frmSms").serializeArray();
	
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			//com.alert( jqXHR.responseJSON.retMsg );
			
			
		} else {
			alert("교과정보를 읽어오는대 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});

}


function fn_sendMail(){
	
	var list = $("#frmMail input[name='memIds']");
	var checkNum = 0;
    for(var i = 0; i < list.length; i++){
        if(list[i].checked){ //선택되어 있으면 배열에 값을 저장함
        	checkNum++;    
        }
    }
	if(checkNum<=0){
		alert("선택된 대상자가 없습니다.");
		return;
	}
		
	if( com.isBlank( $("#mailTitle").val() ) ){
		$("#mailTitle").focus();
		alert("제목을 입력하세요.");
		return false;
	}
	
	if( com.isBlank( $("#mailContent").val() ) ){
		$("#mailContent").focus();
		alert("내용을 입력하세요.");
		return false;
	}
	
	if($('input:radio[id="mail_realTypeYn2"]').is(":checked") == true){
		if( com.isBlank( $("#mail_startDate").val() ) ){
			$("#mail_startDate").focus();
			alert("[예약발송] 날짜를 선택하세요.");
			return false;
		}
		if( com.isBlank( $("#mail_startHour").val() ) ){
			$("#mail_startHour").focus();
			alert("[예약발송] 시간을 선택하세요.");
			return false;
		}
		if( com.isBlank( $("#mail_startMinute").val() ) ){
			$("#mail_startMinute").focus();
			alert("[예약발송] 분을 선택하세요.");
			return false;
		}
		
		var sendDate = $("#mail_startDate").val()+$("#mail_startHour").val()+$("#mail_startMinute").val();
		$("#mail_sendDate").val(sendDate);
	}

	
	if(confirm("메일을 발송하시겠습니까?")){
		
		var reqUrl = "/lu/mail/mailSendJson.json";
		var formData = new FormData($('#frmMail')[0]);
		
		
		$.ajax({
			  type: "POST",
			  enctype: 'multipart/form-data', // 필수
			  data: formData, // 필수 
			  processData: false, // 필수 
			  contentType: false, // 필수
			  url: reqUrl,
			  success:function( data ) {
				  
				//  alert(data.retMsg);
				  
				  fn_modalHide('email-wrap');
				  
				//$( "#interviewMemberList" ).html( html );			
			  }
		});	
	  		
	}
}

function fn_sendSms(){
	  
	
	var list = $("#frmSms input[name='memIds']");
	var checkNum = 0;
    for(var i = 0; i < list.length; i++){
        if(list[i].checked){ //선택되어 있으면 배열에 값을 저장함
        	checkNum++;    
        }
    }
	if(checkNum<=0){
		alert("선택된 대상자가 없습니다.");
		return;
	}
	
	var tempType = $("#frmSms input[name='mailTempType']") ;
	var checkTypeNum = true;
    for(var i = 0; i < tempType.length; i++){
        if(tempType[i].checked){ //선택되어 있으면 배열에 값을 저장함
        	checkTypeNum=false; 
        }
    } 
    
	if($("#smsContent").val() == "" &&  checkTypeNum ){
		$("#smsContent").focus();
		alert("내용을 입력하세요.");
		return;
	}
	
	if($('input:radio[id="sms_realTypeYn2"]').is(":checked") == true){
		if( com.isBlank( $("#sms_startDate").val() ) ){
			$("#sms_startDate").focus();
			alert("[예약발송] 날짜를 선택하세요.");
			return false;
		}
		if( com.isBlank( $("#sms_startHour").val() ) ){
			$("#sms_startHour").focus();
			alert("[예약발송] 시간을 선택하세요.");
			return false;
		}
		if( com.isBlank( $("#sms_startMinute").val() ) ){
			$("#sms_startMinute").focus();
			alert("[예약발송] 분을 선택하세요.");
			return false;
		}
		
		var sendDate = $("#sms_startDate").val()+$("#sms_startHour").val()+$("#sms_startMinute").val();
		$("#sms_sendDate").val(sendDate);
	}
	
	
	if(confirm("메세지를 전송하시겠습니까?")){

		var reqUrl = "/lu/sms/smsSendJson.json";
		var param = $("#frmSms").serializeArray();
		
		//alert($("#frmSms input[name='memIds']").val());
		
		com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
			if (200 == jqXHR.status ) {
				com.alert( jqXHR.responseJSON.retMsg );
				
				fn_modalHide('sms-wrap');
			} else {
				alert("교과정보를 읽어오는대 실패했습니다.")
			}
			}, {
				async : true,
				type : "POST",
				errorCallback : null
			});
	  	
	}
	
}


function fn_comOjtClassSearch(){
	  
	  if($("#class_searchKeyword").val() == ""){
		$("#class_searchKeyword").focus();
		alert("검색어를 입력하세요.");
		return;
	} 
	
	var searchKeyword = $("#class_searchKeyword").val();
	var reqUrl = "/lu/subject/listOjtClass.json";
	var param = {"searchKeyword" : searchKeyword };
	
	$.ajax({
		url:reqUrl,
		type:"post",
		data:param,
		success:function(data){
	
			var resultList = data.listOjtClassName;
			var html = "";
			if(resultList.length > 0){
				for(var i=0; i < resultList.length; i++){
					html += "<li>";
					html += "<a href='#!' onclick='javascript:fn_search(\""+resultList[i].subjectClass+"\",\""+resultList[i].companyId+"\","+(i+0)+",\""+resultList[i].companyName+"\")' title='\""+resultList[i].companyName+"\"'>"+resultList[i].subjectClass+"반_"+resultList[i].companyName+"</a>";
					html += "<li>";
				}
				$("#thelist").html("");
				$("#thelist").append(html);
			} else {
				alert("검색 내용이 없습니다.");
			}
			
			
		},error:function(xhr,status,error){
			alert("분반정보를 불러오는대 실패했습니다.");
		}
		
	});	
	 
}


function fn_comOjtClassSearch1(){
	  
	  if($("#class_searchKeyword").val() == ""){
		$("#class_searchKeyword").focus();
		alert("검색어를 입력하세요.");
		return;
	} 

	var searchKeyword = $("#class_searchKeyword").val();
	var reqUrl = "/lu/subject/listOjtClass.json";
	var param = {"searchKeyword" : searchKeyword };
	
	$.ajax({
		url:reqUrl,
		type:"post",
		data:param,
		success:function(data){
	
			var resultList = data.listOjtClassName;
			var html = "";
			if(resultList.length > 0){
				for(var i=0; i < resultList.length; i++){
					html += "<li>";
					html += "<a href='#!' onclick='javascript:fn_comp_search(\""+resultList[i].subjectClass+"\")' title='\""+resultList[i].companyName+"\"'>"+resultList[i].subjectClass+"반_"+resultList[i].companyName+"</a>";
					html += "<li>";
				}
				$("#class_thelist").html("");
				$("#class_thelist").append(html);
			} else {
				alert("검색 내용이 없습니다.");
			}
			
			
		},error:function(xhr,status,error){
			alert("분반정보를 불러오는대 실패했습니다.");
		}
		
	});	
	 
}

function fn_comOjtClassSearch2(){
	  
	  if($("#class_searchKeyword").val() == ""){
		$("#class_searchKeyword").focus();
		alert("검색어를 입력하세요.");
		return;
	} 

	var searchKeyword = $("#class_searchKeyword").val();
	var reqUrl = "/lu/subject/listOjtClass.json";
	var param = {"searchKeyword" : searchKeyword };
	
	$.ajax({
		url:reqUrl,
		type:"post",
		data:param,
		success:function(data){
	
			var resultList = data.listOjtClassName;
			var html = "";
			if(resultList.length > 0){
				for(var i=0; i < resultList.length; i++){
					html += "<li>";
					html += "<a href='/lu/eval/listInsideEvalPrt.do?subClass="+resultList[i].subjectClass+"' title='\""+resultList[i].companyName+"\"'>"+resultList[i].subjectClass+"반_"+resultList[i].companyName+"</a>";
					html += "<li>";
				}
				$("#thelist").html("");
				$("#thelist").append(html);
			} else {
				alert("검색 내용이 없습니다.");
			}
			
			
		},error:function(xhr,status,error){
			alert("분반정보를 불러오는대 실패했습니다.");
		}
		
	});	
	 
}

function fn_comOjtClassMemberSearch(){
	  
	 if($("#member_searchName").val() == ""){
		$("#member_searchName").focus();
		alert("검색어를 입력하세요.");
		return;
	}
	var searchName = $("#member_searchName").val();
	$("#searchMemName").val(searchName);
	alert($("#searchMemName").val());
	var reqUrl = "/lu/subject/listOjtClassMember.json";
	var param = $("#frmActivity").serializeArray();
	
	$.ajax({
		url:reqUrl,
		type:"post",
		data:param,
		success:function(data){
	
			var resultList = data.memberlist;
			var html = "";
			if(resultList.length > 0){
				for(var i=0; i < resultList.length; i++){
					html += "<li>";
					html += "<a href='#!' onclick='javascript:fn_comp_search_search()'>"+resultList[i].memName+"</a>";
					html += "<li>";
				}
				$("#member_thelist").html("");
				$("#member_thelist").append(html);
			} else {
				alert("검색 내용이 없습니다.");
			}
			
			
		},error:function(xhr,status,error){
			alert("분반정보를 불러오는대 실패했습니다.");
		}
		
	});	
	 
}





var agreeCnt = "${agreeCnt}";

if(agreeCnt == "0"){
	fn_pop_agree();
}

function fn_pop_agree(){
	
	popOpenWindow("", "popAgree", 850, 750);
	var reqUrl = "/lu/main/lmsUserMainPagePopupAgree.do";
	//$("#rowId").val(rowId);
	$("#frmAgree").attr("action", reqUrl);
	$("#frmAgree").attr("target", "popAgree");
	$("#frmAgree").submit();
	
}

function fileValidation(name){
	var fileName = name.substring(name.lastIndexOf('.')+1).toUpperCase();
	//alert(fileName);
	var isValid;
	if ( (/DOC/i).test(fileName ) 
        || (/DOCX/i).test(fileName ) 
        || (/GIF/i).test(fileName ) 
        || (/HWP/i).test(fileName ) 
        || (/JPEG/i).test(fileName ) 
        || (/JPG/i).test(fileName ) 
        || (/PNG/i).test(fileName ) 
        || (/PDF/i).test(fileName ) 
        || (/PPT/i).test(fileName ) 
        || (/PPTX/i).test(fileName ) 
        || (/TXT/i).test(fileName ) 
	    || (/XLS/i).test(fileName ) 
	    || (/ZIP/i).test(fileName ) 
	    || (/XLSX/i).test(fileName ) 
	    || (/MP3/i).test(fileName ) 
	    || (/MP4/i).test(fileName ) 
	    || (/M4A/i).test(fileName ) 
	    || (/WAV/i).test(fileName ) 
	    || (/WMA/i).test(fileName ) 
	    || (/FLAC/i).test(fileName ) 
	    || (/OGG/i).test(fileName ) 
	    || (/AAC/i).test(fileName ) 
            ) {
                isValid = true;
            } else {
            	// Message.FILE_CHECK  : message.js
				var message = "파일 업로드는\n\nDOC,DOCX,GIF,HWP,JPEG,\nJPG,PNG,PDF,PPT,PPTX,\nTXT,XLS,ZIP,XLSX,MP3,\nMP4,M4A,WAV,WMA,\nFLAC,OGG,AAC\n\n확장자만 가능합니다.";
                alert(message);
                isValid = false;
            }
	//alert(isValid);
	return isValid;
	
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


function fn_modalClose(){
	$(".close-modal").click();
}

function fn_modalHide(id){
	//$("#"+id).hide();
	$('.jquery-modal').css('display','none');
	$("#"+id).css('display', 'none');
}

//SMS 바이트 제한
function fn_limitByte(){ 
	var len=0, j; 
	var smsValue = $("#smsContent").val()
	for (i=0, j=smsValue.length;i<j;i++, len++) { 
 		if ( (smsValue.charCodeAt(i)<0)||(smsValue.charCodeAt(i)>127) ){ 
			len = len+1; 
		} 
 		/*
		if (len >= 80) {
			alert( "최대 80 Bytes 까지만 보낼 수 있습니다." );
			$("#smsContent").val(smsValue.substring(0,i)); 
			$("#smsContent").focus(); 
			return; 
		} 
		*/
	}
	$("#inputByte").text(len);
}

function fn_changeContent(value){
	var content = "";
	var content1 = "안녕하세요 _학습근로자_님 \n_개설교과_의 _주차_주차 과제물 제출시 유의사항입니다.\n첨부파일을 참조하여 _마감일_까지 꼭 제출하여 주시기 바랍니다. \n감사합니다.";
	var content2 = "안녕하세요 _학습근로자_님 \n_개설교과_의 팀프로젝트 제출시 유의사항입니다. \n첨부파일을 참조하여 _마감일_ 까지 꼭 제출하여 주시기 바랍니다. \n감사합니다.";
	var content3 = "안녕하세요 _학습근로자_님 \n_개설교과_의 토론은 _마감일_까지 꼭 참여하여 \n주시기 바랍니다. 감사합니다.";
	var content4 = "안녕하세요 _학습근로자_님 \n이번 학기 재직증빙서류 마감일은 _마감일_입니다. \n꼭 기간 내 제출 바랍니다. \n감사합니다.";
	var content5 = "안녕하세요 _학습근로자_님 \n_개설교과_의 _주차_주차 온라인교과는 _마감일_까지 \n꼭 수강하여 주시기 바랍니다. \n감사합니다.";
	var content6 = "안녕하세요 _학습근로자_님 \n_개설교과_의 _주차_주차 학습활동서는 _마감일_ 까지 \n꼭 제출하여 주시기 바랍니다. \n감사합니다.";
	if(value=="RC"){
		content=content1;
	}else if(value=="TC"){
		content=content2;
	}else if(value=="DC"){
		content=content3;
	}else if(value=="WC"){
		content=content4;
	}else if(value=="OC"){
		content=content5;
	}else if(value=="AC"){
		content=content6;
	}
	
	$("#mailContent").val(content);
//	oEditors.getById["mailContent"].exec("SET_IR",[""]);
//	oEditors.getById["mailContent"].exec("PASTE_HTML", [content]);
}

function fn_changeSmsContent(value){ 
	
	var tempWeek = " _주차_주차 ";
	<c:if test='${mailVO.weekCnt eq "0"}' >tempWeek = "";</c:if>
	var tempLastdate = " _마감일_까지";
	<c:if test='${mailVO.lastDate eq ""}' >tempLastdate = "";</c:if>
	var tempSubject = " _개설교과_ ";
	<c:if test='${mailVO.subjectCode eq ""}' > tempSubject = ""; </c:if>
	var content = "";
	var content1 = tempSubject+tempWeek+" 과제는 "+tempLastdate+" 꼭 제출하여 주시기 바랍니다. 감사합니다.";
	var content2 = tempSubject+" 팀프로젝트는 "+tempLastdate+" 꼭 제출하여 주시기 바랍니다. 감사합니다.";
	var content3 = tempSubject+" 토론은 "+tempLastdate+" 꼭 참여하여 주시기 바랍니다. 감사합니다.";
	var content4 = "이번 학기 재직증빙서류 마감일은 _마감일_입니다.꼭 기간 내 제출 바랍니다. 감사합니다.";
	var content5 = tempSubject+tempWeek+" 온라인교과는 "+tempLastdate+" 꼭 수강하여 주시기 바랍니다. 감사합니다.";
	var content6 = tempSubject+tempWeek+" 학습활동서는 "+tempLastdate+" 꼭 제출하여 주시기 바랍니다. 감사합니다.";

	if(value=="RC"){
		content=content1;
	}else if(value=="TC"){
		content=content2;
	}else if(value=="DC"){
		content=content3;
	}else if(value=="WC"){
		content=content4;
	}else if(value=="OC"){
		content=content5;
	}else if(value=="AC"){
		content=content6;
	}
	
	$("#smsContent").val(content); 
}

function fn_changeSmsContent(value){ 
	
	var tempWeek = " _주차_주차 ";
	<c:if test='${mailVO.weekCnt eq "0"}' >tempWeek = "";</c:if>
	var tempLastdate = " _마감일_까지";
	<c:if test='${mailVO.lastDate eq ""}' >tempLastdate = "";</c:if>
	var tempSubject = " _개설교과_ ";
	<c:if test='${mailVO.subjectCode eq ""}' > tempSubject = ""; </c:if>
	var content = "";
	var content1 = tempSubject+tempWeek+" 과제는 "+tempLastdate+" 꼭 제출하여 주시기 바랍니다. 감사합니다.";
	var content2 = tempSubject+" 팀프로젝트는 "+tempLastdate+" 꼭 제출하여 주시기 바랍니다. 감사합니다.";
	var content3 = tempSubject+" 토론은 "+tempLastdate+" 꼭 참여하여 주시기 바랍니다. 감사합니다.";
	var content4 = "이번 학기 재직증빙서류 마감일은 _마감일_입니다.꼭 기간 내 제출 바랍니다. 감사합니다.";
	var content5 = tempSubject+tempWeek+" 온라인교과는 "+tempLastdate+" 꼭 수강하여 주시기 바랍니다. 감사합니다.";
	var content6 = tempSubject+tempWeek+" 학습활동서는 "+tempLastdate+" 꼭 제출하여 주시기 바랍니다. 감사합니다.";

	if(value=="RC"){
		content=content1;
	}else if(value=="TC"){
		content=content2;
	}else if(value=="DC"){
		content=content3;
	}else if(value=="WC"){
		content=content4;
	}else if(value=="OC"){
		content=content5;
	}else if(value=="AC"){
		content=content6;
	}
	
	$("#smsContent").val(content); 
}


</script>

<script>
$(document).ready(function() {
	$('#modalReturnComment').on('click', function(){
		$('#commentArea').val($(this).data("comment")); 
	});
	
	$("a[name=modalReturnEvalComment]").on('click', function(){
		$('#commentArea').val($(this).data("comment")); 
	});
	
	$("a[name=modalReturnNoteComment]").on('click', function(){
		$('#commentArea').val($(this).data("comment")); 
	});
	
	$("a[name=modalReturnActComment]").on('click', function(){
		$('#commentArea').val($(this).data("comment")); 
	});
	
	$("a[name=modalReturnWorkComment]").on('click', function(){
		$('#commentArea').val($(this).data("comment")); 
	});
	
	
	$('#frmMail input[name=realTypeYn]').click(function(){

		if($(this).val() == "Y"){
			$("#mail_startDate").attr("disabled", true);
			$("#mail_startHour").attr("disabled", true);
			$("#mail_startMinute").attr("disabled", true);
			
			$("#mail_startDate").val("");
			$("#mail_startHour").val("")
			$("#mail_startMinute").val("")
			
			$("#reserve").hide();
			
		} else {
			$("#mail_startDate").attr("disabled", false);
			$("#mail_startHour").attr("disabled", false);
			$("#mail_startMinute").attr("disabled", false);
			
			$("#mail_startDate").val("");
			$("#mail_startHour").val("")
			$("#mail_startMinute").val("")
			
			$("#reserve").show();
		}
	});
	
	$('#frmSms input[name=realTypeYn]').click(function(){

		if($(this).val() == "Y"){
			$("#sms_startDate").attr("disabled", true);
			$("#sms_startHour").attr("disabled", true);
			$("#sms_startMinute").attr("disabled", true);
			
			$("#sms_startDate").val("");
			$("#sms_startHour").val("");
			$("#sms_startMinute").val("");
			
			$("#reserve_sm").hide();
			
		} else {
			$("#sms_startDate").attr("disabled", false);
			$("#sms_startHour").attr("disabled", false);
			$("#sms_startMinute").attr("disabled", false);
			
			$("#sms_startDate").val("");
			$("#sms_startHour").val("");
			$("#sms_startMinute").val("");
			
			$("#reserve_sm").show();
			
		}
	});
	com.datepickerDateFormat('startDate', 'button');  
});
</script>


<!--  반려사유 팝업 -->
<div id="companion-wrap" class="modal">
	<div class="modal-title">반려사유<!-- 입력 --></div>
	<div class="modal-body hauto">
		<!-- <form name="" id="" method="post">	 -->								
			<p class="mt-010"><label for="commentArea" class="hidden">반려사유</label><textarea id="commentArea" readonly="readonly" col="50" rows="7"></textarea></p>
			<div class="btn-area align-center mt-010">
				<a href="javascript:fn_modalClose();"  class="yellow">확인</a>
			</div>
		<!-- </form> -->
	</div>
</div>
<!--  //반려사유 팝업  -->

<!--  기업검색 팝업 -->
<div id="etp-search" class="modal">
	<div class="modal-title">기업검색</div>
	<div class="modal-body hauto">
		<!--  검색 -->
		<div class="search_box2"> 
			<fieldset>
			<legend>게시물 검색</legend>
				<label for="companyName" class="hidden">기업명</label>
				<select id="companyName" name="" class="select" title="기업명">
					<option value="" >기업명</option>
				</select>
				
				<label for="searchWrd" class="hidden">검색어 입력</label>
				<input id="searchWrd" name="searchWrd" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
				<button class="btn btn-black btn-sch">검색</button> 
			</fieldset>
		 </div>
		 <!--  //검색 -->
		
		<!--  검색결과 -->
		<div class="table-box2">
			<table class="type-2 wp100">
				<caption>검색결과 기업코드, 기업명, 학생수 제공</caption>
				<thead>
					<tr>
						<th scope="col">기업코드</th>
						<th scope="col">기업명</th>
						<th scope="col">학생수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>기업코드</td>
						<td>기업명</td>
						<td>학생수</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--  검색결과 -->
	</div>
</div>
<!--  //기업검색 팝업  -->

<!--  교과목검색 팝업 -->
<div id="subject-search" class="modal">
	<div class="modal-title">교과목 검색</div>
	<div class="modal-body hauto">
		<!--  검색 -->
		<div class="search_box2"> 
			<fieldset>
			<legend>게시물 검색</legend>
				<label for="subjectName" class="hidden">과목명</label>
				<select id="subjectName" name="" class="select">
					<option value="" >과목명</option>
				</select>
				
				<label for="searchWrd" class="hidden">검색어 입력</label>
				<input id="searchWrd" name="searchWrd" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
				<button class="btn btn-black btn-sch">검색</button> 
			</fieldset>
		 </div>
		 <!--  //검색 -->
		
		<!--  검색결과 -->
		<div class="table-box2">
			<table class="type-2 wp100">
				<caption>검색결과 과목코드, 과목명, 학년, 학기 제공</caption>
				<thead>
					<tr>
						<th scope="col">과목코드</th>
						<th scope="col">과목명</th>
						<th scope="col">학년</th>
						<th scope="col">학기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>과목코드</td>
						<td>과목명</td>
						<td>학년</td>
						<td>학기</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--  검색결과 -->
	</div>
</div>
<!--  //교과목검색 팝업  -->


<!--  교사검색 팝업 -->
<div id="teacher-search" class="modal">
	<div class="modal-title">교사 검색</div>
	<div class="modal-body hauto">
		<!--  검색 -->
		<div class="search_box2"> 
			<fieldset>
			<legend>게시물 검색</legend>
				<label for="companyName" class="hidden">기업명</label>
				<select id="companyName" name="" class="select">
					<option value="" >기업명</option>
				</select>
				
				<label for="searchWrd" class="hidden">검색어 입력</label>
				<input id="searchWrd" name="searchWrd" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
				<button class="btn btn-black btn-sch">검색</button> 
			</fieldset>
		 </div>
		 <!--  //검색 -->
		
		<!--  검색결과 -->
		<div class="table-box2">
			<table class="type-2 wp100">
				<caption>검색결과 교사명, 소속기업명, 연락처 제공</caption>
				<thead>
					<tr>
						<th scope="col">교사명</th>
						<th scope="col">소속기업명</th>
						<th scope="col">연락처</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>교사명</td>
						<td>소속기업명</td>
						<td>01092457854</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--  검색결과 -->
	</div>
</div>
<!--  //학생검색 팝업  -->




<!-- Email 보내기 팝업 -->
<div id="email-wrap" class="modal large" style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); z-index:1012">
	<div class="modal-title">E-MAIL 보내기</div>
	<div class="modal-body">
		<form id="frmMail" name="frmMail"  method="post"  enctype="multipart/form-data" >					
		
		<input type="hidden" name="weekCnt" id="mailWeekCnt" />
		<input type="hidden" name="memId" id="mailMemId" />
		<input type="hidden" name="lastDate" id="mailLastDate" />
		<input type="hidden" name="subjectCode" id="mailSubjectCode" />
		
		<input type="hidden" name="companyId" id="mailCompanyId" />
		<input type="hidden" name="traningProcessId" id="mailTraningProcessId" />
		<input type="hidden" name="cotMemIds" id="cotMemIds"/>
		<input type="hidden" name="ccmMemIds" id="ccmMemIds"/>
		<input type="hidden" name="sendDate" id="mail_sendDate"/>
					
			<table class="type-write mt-020">							
				<caption>메일 제목 템플릿 발송시간 제공</caption>
				<tbody>
					<tr>
						<th scope="row"><label for="mailTitle">메일 제목</label></th>
						<td><input type="text" id="mailTitle" name="mailTitle" maxlength="100" value="" class=""></td>
					</tr>
					<tr>
						<th scope="row"><label for="mailTempType">템플릿</label></th>
						<td>
							<select id="mailTempType" name="mailTempType" onchange="javascript:fn_changeContent(this.value)"  >
								<option value="" <c:if test="${empty mailVO.mailTempType}">selected</c:if> >- 템플릿 없음-</option>
								<option value="RC" <c:if test="${mailVO.mailTempType eq 'RC'}">selected</c:if> >과제 제출</option>
								<option value="TC" <c:if test="${mailVO.mailTempType eq 'TC'}">selected</c:if>>팀프로젝트 제출</option>
								<option value="DC" <c:if test="${mailVO.mailTempType eq 'DC'}">selected</c:if>>토론참여</option>
								<option value="WC" <c:if test="${mailVO.mailTempType eq 'WC'}">selected</c:if>>재직증빙서류 제출</option>
								<option value="OC" <c:if test="${mailVO.mailTempType eq 'OC'}">selected</c:if>>온라인교과수강</option>
								<option value="AC" <c:if test="${mailVO.mailTempType eq 'AC'}">selected</c:if>>학습활동서 작성</option>		
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">발송시간</th>
						<td>
							<label for="mail_realTypeYn1"><input type="radio" id="mail_realTypeYn1" name="realTypeYn" value="Y" class="choice" checked="checked"> 즉시</label>
							<label for="mail_realTypeYn2"><input type="radio" id="mail_realTypeYn2" name="realTypeYn" value="N" class="choice"> 예약</label>
							<div id="reserve"  style="display:none;"> 
							<label for="mail_startDate" class="hidden">날짜선택</label><input type="text" id="mail_startDate" name="startDate" style="width: 90%" disabled="disabled">      
							<label for="mail_startHour" class="hidden">시간선택</label>
							<select id="mail_startHour" name="startHour" class="aw" disabled="disabled">
								<option value="">시간선택</option>
								<option value="00">00시</option>
								<option value="01">01시</option>
								<option value="02">02시</option>
								<option value="03">03시</option>
								<option value="04">04시</option>
								<option value="05">05시</option>
								<option value="06">06시</option>
								<option value="07">07시</option>
								<option value="08">08시</option>
								<option value="09">09시</option>
								<option value="10">10시</option>
								<option value="11">11시</option>
								<option value="12">12시</option>
								<option value="13">13시</option>
								<option value="14">14시</option>
								<option value="15">15시</option>
								<option value="16">16시</option>
								<option value="17">17시</option>
								<option value="18">18시</option>
								<option value="19">19시</option>
								<option value="20">20시</option>
								<option value="21">21시</option>
								<option value="22">22시</option>
								<option value="23">23시</option>
							</select>
							
							<label for="mail_startMinute" class="hidden">분선택</label>
							<select id="mail_startMinute" name="startMinute" class="aw" disabled="disabled">
								<option value="">분선택</option>
								<option value="00">00분</option>
								<option value="10">10분</option>
								<option value="20">20분</option>
								<option value="30">30분</option>
								<option value="40">40분</option>
								<option value="50">50분</option>
							</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">수신대상자</th>
						<td id="mail_member_total">전체 000건</td>
					</tr>												
				</tbody>
			</table>
			
			<ul class="grid-wrapper grid-cols2" style="margin-bottom: 20px;"> 
				<li> 
					<div class="grid-cell-inner"> 
						<h2 class="depth2-title" style="border-bottom: 1px solid rgb(221, 221, 221);">발송내용</h2> 
						<p>보내실 내용을 입력해주세요.</p>
						<p class="mt-010">
							<label for="mailContent" class="hidden">발송내용</label>
							<textarea name="mailContent" id="mailContent" maxlength="2000" style="width:100%;height:150px"  ></textarea>
						</p>
					</div>
				</li> 
				<li> 
					<div class="grid-cell-inner"> 
						<h2 class="depth2-title" style="border-bottom: 1px solid rgb(221, 221, 221);" <td id="mail_member_list">전체 000건</td>>수신자리스트<!-- (000명) --></h2> 
						<div class="table-box">
							<table class="type-2 wp100">
								<caption>수신자 학번,  이름 제공</caption>
								<colgroup>
									<col style="width:10%" />
									<col style="width:*" />
									<col style="width:*" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><label for="chbox" class="hidden">선택</label><input type="checkbox" id="chbox" name="chbox" onclick="javascript:fn_sndAllClick('frmMail');" class="choice" checked title="선택" /></th>
										<th scope="col">학번</th>
										<th scope="col">이름</th>
									</tr>
								</thead>
								<tbody id="mail_body">
									<tr>
										<!-- 
										<td><input type="checkbox" id="" name="" class="choice" /></td>
										<td>학번</td>
										<td>이름</td> -->
									</tr>
								</tbody>
							</table>
						</div>	
					</div> 
				</li> 
			</ul>
			
			<table class="type-write mt-020">
				<caption>첨부파일</caption>
				<colgroup>
					<col style="width:130px">
					<col style="width:*">
				</colgroup>
												
				<tbody>
					<tr>
						<th scope="row"><label for="file-input">첨부파일</label></th>
						<td><input type="file" name="file-input" id="file-input" /></td>
					</tr>												
				</tbody>
			</table>
			
			<div class="btn-area align-center mt-010">
				<a href="javascript:fn_modalHide('email-wrap');"  class="black">취소</a>
				<a href="#!"  onclick="javascript:fn_sendMail();"  class="yellow">보내기</a>
			</div>
		</form>
	</div>
</div>
<!--  //Email보내기 팝업  -->

<!--  SMS보내기 팝업 -->
<div id="sms-wrap" class="modal large" style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); z-index:1012">
	<div class="modal-title">SMS보내기</div>
	<div class="modal-body">
		<form id="frmSms" name="frmSms"  method="post">			
		<input type="hidden" name="weekCnt" id="mailWeekCnt" />
		<input type="hidden" name="memId" id="mailMemId" />
		<input type="hidden" name="lastDate" id="mailLastDate" />
		<input type="hidden" name="subjectCode" id="mailSubjectCode" />
		
		<input type="hidden" name="companyId" id="mailCompanyId" />
		<input type="hidden" name="traningProcessId" id="mailTraningProcessId" />
		<input type="hidden" name="cotMemIds" id="cotMemIds"/>
		<input type="hidden" name="ccmMemIds" id="ccmMemIds"/>		
		<input type="hidden" name="sendDate" id="sms_sendDate"/>
						
			<table class="type-write mt-020">							
				<caption>SMS보내기 발송시간 수신대상자 제공</caption>
				<tbody>
					<!-- <tr>
						<th>문자제목</th>
						<td><input type="text" id="" name="" value="" class=""></td>
					</tr>
					<tr>
						<th>문자설명</th>
						<td><input type="text" id="" name="" value="" class=""></td>
					</tr> -->
					<tr>
						<th scope="row">발송시간</th>
						<td>
							<label for="sms_realTypeYn1"><input type="radio" id="sms_realTypeYn1" name="realTypeYn" value="Y" class="choice" checked="checked"> 즉시</label>
							<label for="sms_realTypeYn2"><input type="radio" id="sms_realTypeYn2" name="realTypeYn" value="N" class="choice"> 예약</label>
							<div id="reserve_sm"  style="display:none;"> 
							<label for="sms_startDate" class="hidden">날짜선택</label>
							<input type="text" id="sms_startDate" name="startDate"  style="width: 90%" disabled="disabled" title="날짜선택">
							
							<label for="sms_startHour" class="hidden">시간선택</label>
							<select id="sms_startHour" name="startHour" class="aw" disabled="disabled">
								<option value="">시간선택</option>
								<option value="00">00시</option>
								<option value="01">01시</option>
								<option value="02">02시</option>
								<option value="03">03시</option>
								<option value="04">04시</option>
								<option value="05">05시</option>
								<option value="06">06시</option>
								<option value="07">07시</option>
								<option value="08">08시</option>
								<option value="09">09시</option>
								<option value="10">10시</option>
								<option value="11">11시</option>
								<option value="12">12시</option>
								<option value="13">13시</option>
								<option value="14">14시</option>
								<option value="15">15시</option>
								<option value="16">16시</option>
								<option value="17">17시</option>
								<option value="18">18시</option>
								<option value="19">19시</option>
								<option value="20">20시</option>
								<option value="21">21시</option>
								<option value="22">22시</option>
								<option value="23">23시</option>
							</select>
							
							<label for="sms_startMinute" class="hidden">분선택</label>
							<select id="sms_startMinute" name="startMinute" class="aw" disabled="disabled">
								<option value="">분선택</option>
								<option value="00">00분</option>
								<option value="10">10분</option>
								<option value="20">20분</option>
								<option value="30">30분</option>
								<option value="40">40분</option>
								<option value="50">50분</option>
							</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">수신대상자</th>
						<td id="sms_member_total">전체 000건</td>
					</tr>												
				</tbody>
			</table>
			
			<ul class="grid-wrapper grid-cols2" style="margin-bottom: 20px;"> 
				<li> 
					<div class="grid-cell-inner"> 
						<h2 class="depth2-title" style="border-bottom: 1px solid rgb(221, 221, 221);">발송내용</h2> 
						<p>보내실 내용을 입력해주세요.</p>
						<p class="mt-010">
							<label for="smsContent" class="hidden"></label>
							<textarea col="50" rows="7" name="smsContent" id="smsContent" onkeyup="fn_limitByte();" ></textarea>
						</p>
						<p class="mt-010">
							<label for="smsTempType" class="hidden">템플릿선택</label>
							<select name="smsTempType" id="smsTempType" title="" style="width:100%;" onchange="javascript:fn_changeSmsContent(this.value)" >
								<option value="" <c:if test="${empty mailVO.mailTempType}">selected</c:if> >- 템플릿 없음-</option>
								<option value="RC" <c:if test="${mailVO.mailTempType eq 'RC'}">selected</c:if> >과제 제출</option>
								<option value="TC" <c:if test="${mailVO.mailTempType eq 'TC'}">selected</c:if>>팀프로젝트 제출</option>
								<option value="DC" <c:if test="${mailVO.mailTempType eq 'DC'}">selected</c:if>>토론참여</option>
								<option value="WC" <c:if test="${mailVO.mailTempType eq 'WC'}">selected</c:if>>재직증빙서류 제출</option>
								<option value="OC" <c:if test="${mailVO.mailTempType eq 'OC'}">selected</c:if>>온라인교과수강</option>
								<option value="AC" <c:if test="${mailVO.mailTempType eq 'AC'}">selected</c:if>>학습활동서 작성</option>				
							</select>
						</p>
					</div>
				</li> 
				<li> 
					<div class="grid-cell-inner"> 
						<h2 class="depth2-title" style="border-bottom: 1px solid rgb(221, 221, 221);" id="sms_member_list"><!-- (000명) --></h2> 
						<div class="table-box">
							<table class="type-2 wp100">
								<caption>학번 이름 제공</caption>
								<colgroup>
									<col style="width:10%" />
									<col style="width:*" />
									<col style="width:*" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><label for="chbox" class="hidden">선택</label><input type="checkbox" id="chbox" name="chbox" onclick="javascript:fn_sndAllClick('frmSms');" class="choice" checked title="선택" /></th>
										<th scope="col">학번</th>
										<th scope="col">이름</th>
									</tr>
								</thead>
								<tbody id="sms_body">
									<!-- <tr>
										<td><input type="checkbox" id="" name="" class="choice" /></td>
										<td>학번</td>
										<td>이름</td>
									</tr> -->
								</tbody>
							</table>
						</div>	
					</div> 
				</li> 
			</ul>
			<div class="btn-area align-center">
				<a href="javascript:fn_modalHide('sms-wrap');"  class="black">취소</a>
				<a href="#!"  onclick="javascript:fn_sendSms();"  class="yellow">보내기</a>
			</div>
		</form>
	</div>
</div>
<!--  //SMS보내기 팝업  -->

<div class="jquery-modal blocker current" style="display:none"></div>


