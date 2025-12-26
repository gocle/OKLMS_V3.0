<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src="/js/oklms/jquery-latest.js"></script>
<script type="text/javascript" src="/js/oklms/jquery-common.js"></script>
<script type="text/javascript">
<!--

$(function() {
 	if("${sendSuccess}"=="send"){
 		self.close();
 	}	
});
function pop_closeWin() {
	self.close();
}

//SMS 바이트 제한
function fn_limitByte(){ 
	var len=0, j; 
	var smsValue = $("#smsContent").val()
	for (i=0, j=smsValue.length;i<j;i++, len++) { 
 		if ( (smsValue.charCodeAt(i)<0)||(smsValue.charCodeAt(i)>127) ){ 
			len = len+1; 
		} 
		if (len >= 80) {
			alert( "최대 80 Bytes 까지만 보낼 수 있습니다." );
			$("#smsContent").val(smsValue.substring(0,i)); 
			$("#smsContent").focus(); 
			return; 
		} 
	}
	$("#inputByte").text(len);
}

function fn_send_sms(){
	 
	
	var tempType = $("input[name='mailTempType']") ;
	var checkTypeNum = true;
    for(var i = 0; i < tempType.length; i++){
        if(tempType[i].checked){ //선택되어 있으면 배열에 값을 저장함
        	checkTypeNum=false; 
        }
    } 
    
	if($("#smsContent").val() == "" &&  checkTypeNum ){
		alert("내용을 입력하세요.");
		return;
	}
	
	if(confirm("메세지를 전송하시겠습니까?")){
	  	
	  	var reqUrl = "/lu/sms/smsSend.do";
		$("#frmMail").attr("method", "post" );
		$("#frmMail").attr("action", reqUrl);
		$("#frmMail").submit();	
		
	}
}

function fu_onclick(){ 
	$("input[name=memIds]:checkbox").each(function() {
	    $(this).attr("checked",$("#chbox").is(":checked"));
	});	
}

//-->
</script>
		<!-- 팝업 사이즈 : 가로 300px  설정 -->
		<div id="sms-wrapper">
			<ul id="sms-header">
				<li><h1>SMS 발송</h1></li>
				<li class="btn"><a href="#!" onclick="javascript:pop_closeWin();">닫기</a></li>
			</ul><!-- E : sms-header -->

<form id="frmMail" name="frmMail"  method="post">

<input type="hidden" id ="yyyy"  name="yyyy" value="${mailVO.yyyy}" />
<input type="hidden" id ="term"  name="term" value="${mailVO.term}"  />
<input type="hidden" id ="weekCnt"  name="weekCnt" value="${mailVO.weekCnt}"  />
<input type="hidden" id ="subjectCode"  name="subjectCode" value="${mailVO.subjectCode}" />
<input type="hidden" id ="lastDate" name="lastDate" value="${mailVO.lastDate }" />
<input type="hidden" id ="receiveName" name="receiveName" value=""  />
<c:forEach  var="result" items="${resultlist}" varStatus="status">
	<input type="hidden" name="memIds" value="${result.memId }" />
</c:forEach>
			<ul id="sms-container">
				<li>
		 
						<textarea name="smsContent" id="smsContent" style="width:99%;height:150px" onkeyup="fn_limitByte();" <c:if test="${!empty mailVO.mailTempType}">disabled</c:if> ></textarea>
						<p><b id="inputByte">0</b><!--  / 80 Byte --></p>
						<dl>
							<dt>SMS 템플릿</dt>
							<dd><input type="radio" name="mailTempType" value="OC" <c:if test="${mailVO.mailTempType eq 'OC'}">checked</c:if>  /> 온라인교과수강</dd>
							<dd><input type="radio" name="mailTempType" value="RC" <c:if test="${mailVO.mailTempType eq 'RC'}">checked</c:if> /> 과제 제출</dd>
							<dd><input type="radio" name="mailTempType" value="TC"  <c:if test="${mailVO.mailTempType eq 'TC'}">checked</c:if> /> 팀프로젝트 제출</dd>
							<dd><input type="radio" name="mailTempType" value="WC" <c:if test="${mailVO.mailTempType eq 'WC'}">checked</c:if> /> 재직증빙서류 제출</dd>
							<dd><input type="radio" name="mailTempType" value="AC" <c:if test="${mailVO.mailTempType eq 'AC'}">checked</c:if> /> 학습활동서 작성</dd>
							<dd><input type="radio" name="mailTempType" value="DC" <c:if test="${mailVO.mailTempType eq 'DC'}">checked</c:if> /> 토론참여</dd>
						</dl>		
				</li>
				<li class="sms-btn"><a href="#!" onclick="javascript:fn_send_sms();" >전송하기</a></li>
			</ul><!-- E : sms-container -->
</form>

		</div><!-- E : sms-wrapper -->