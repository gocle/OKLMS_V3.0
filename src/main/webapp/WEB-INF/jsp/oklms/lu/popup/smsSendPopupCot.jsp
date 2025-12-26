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

$(document).ready(function() {
	
 	if("${sendSuccess}"=="send"){
 		self.close();
 	}
	
	fn_changeContent("${mailVO.mailTempType}");
	
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
function fn_send_sms(){
	  
	
	var list = $("input[name='memIds']");
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
	  	
	  	var reqUrl = "/lu/sms/smsSendLocal.do";
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
		<!-- 팝업 사이즈 : 가로 620px 이상 설정 -->
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

			<ul id="sms-container">
				<li>
					<div>
						<textarea name="smsContent" id="smsContent" style="width:99%;height:150px" onkeyup="fn_limitByte();"   ></textarea>
						<p><b id="inputByte">0</b> / 80 Byte</p>
						<dl>
							<dt>SMS 템플릿</dt>
							<dd><input type="radio" name="mailTempType" onclick="javascript:fn_changeContent(this.value);" value="OC" <c:if test="${mailVO.mailTempType eq 'OC'}">checked</c:if>  /> 온라인교과수강</dd>
							<dd><input type="radio" name="mailTempType" onclick="javascript:fn_changeContent(this.value);" value="RC" <c:if test="${mailVO.mailTempType eq 'RC'}">checked</c:if> /> 과제 제출</dd>
							<dd><input type="radio" name="mailTempType" onclick="javascript:fn_changeContent(this.value);" value="TC"  <c:if test="${mailVO.mailTempType eq 'TC'}">checked</c:if> /> 팀프로젝트 제출</dd>
							<dd><input type="radio" name="mailTempType" onclick="javascript:fn_changeContent(this.value);" value="WC" <c:if test="${mailVO.mailTempType eq 'WC'}">checked</c:if> /> 재직증빙서류 제출</dd>
							<dd><input type="radio" name="mailTempType" onclick="javascript:fn_changeContent(this.value);" value="AC" <c:if test="${mailVO.mailTempType eq 'AC'}">checked</c:if> /> 학습활동서 작성</dd>
							<dd><input type="radio" name="mailTempType" onclick="javascript:fn_changeContent(this.value);" value="DC" <c:if test="${mailVO.mailTempType eq 'DC'}">checked</c:if> /> 토론참여</dd>
						</dl>
					</div>

					<table class="mem-list">
						<thead>
							<tr>
								<th><input type="checkbox" id="chbox" name="chbox" onclick="javascript:fu_onclick();" checked /></th>
								<th>학번</th>
								<th>이름</th>
							</tr>
						</thead>

						<tbody>
						
						<c:forEach  var="result" items="${resultlist}" varStatus="status">
						
							<tr>
								<td><input type="checkbox" name="memIds" value="${result.memId }" checked /></td>
								<td>${result.memId }</td>
								<td>${result.memName }</td>
							</tr>
							
						</c:forEach>
						
						</tbody>
					</table>
				</li>
				<li class="sms-btn"><a href="#!" onclick="javascript:fn_send_sms();" >전송하기</a></li>
			</ul><!-- E : sms-container -->
</form>

		</div><!-- E : sms-wrapper -->