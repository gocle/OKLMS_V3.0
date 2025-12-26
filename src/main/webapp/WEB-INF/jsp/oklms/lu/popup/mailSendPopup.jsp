<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src="/common/smartEditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="/js/oklms/jquery-latest.js"></script>
<script type="text/javascript" src="/js/oklms/jquery-common.js"></script>
<script type="text/javascript">
<!--
var oEditors = [];
$(document).ready(function() {
	loadPage();	
});
$(function() {
 	if("${successYn}"=="Y"){
 		self.close();
 	}	
});
function loadPage() { 
//	initEditor();
	fn_changeContent("${mailVO.mailTempType}");
}

function pop_closeWin() {
	self.close();
}

function fu_onclick(){ 
	$("input[name=memIds]:checkbox").each(function() {
	    $(this).attr("checked",$("#chbox").is(":checked"));
	});	 
}
/* 화면이 로드된후 에디터 기본옵션 설정 초기화 */ 
function initEditor() {
	//Smart Editor
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "mailContent",
		sSkinURI: "/common/smartEditor/SmartEditor3Skin.html",	
		htParams : {
			bUseToolbar : true,
			bUseVerticalResizer:false
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["textAreaContent"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
}
function fn_send_mail(){
	

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
		
	if( com.isBlank( $("#mailTitle").val() ) ){
		alert("제목을 입력하세요.");
		return false;
	}
	/*
	var data =oEditors.getById["mailContent"].getIR();
	var text = data.replace(/[<][^>]*[>]/gi, "");
	if(text=="" && data.indexOf("img") <= 0){
		alert("내용을 입력하세요.");
		oEditors.getById["mailContent"].exec("FOCUS"); 
		return false;
	}
	$("#mailContent").val(data);
	*/
	if( com.isBlank( $("#mailContent").val() ) ){
		alert("내용을 입력하세요.");
		return false;
	}
	
	
	
	if(confirm("메일을 발송하시겠습니까?")){
		
	  	var reqUrl =  "/lu/mail/mailSend.do";
	  	
		$("#frmMail").attr("method", "post" ); 
		$("#frmMail").attr("action", reqUrl);
		$("#frmMail").submit();	
	}
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
//-->
</script>
		<!-- 팝업 사이즈 : 가로 920px 이상 설정 -->
		<div id="sms-wrapper">
			<ul id="sms-header">
				<li><h1>E-MAIL 발송</h1></li>
				<li class="btn"><a href="#!"  onclick="javascript:pop_closeWin();">닫기</a></li>
			</ul><!-- E : sms-header -->

<form id="frmMail" name="frmMail"  method="post"  enctype="multipart/form-data" >

<input type="hidden" id ="yyyy"  name="yyyy" value="${mailVO.yyyy}" />
<input type="hidden" id ="term"  name="term" value="${mailVO.term}"  />
<input type="hidden" id ="weekCnt"  name="weekCnt" value="${mailVO.weekCnt}"  />
<input type="hidden" id ="subjectCode"  name="subjectCode" value="${mailVO.subjectCode}" />
<input type="hidden" id ="lastDate" name="lastDate" value="${mailVO.lastDate }" />
<input type="hidden" id ="receiveName" name="receiveName" value=""  />
<input type="hidden" id ="msgType" name="msgType" value="1" />
			<ul id="sms-container">
				<li>

					<table class="mail-list">
						<colgroup>
							<col width="25%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td><input type="text" id="mailTitle" name="mailTitle" /></td>
							</tr>
							<tr>
								<th>E-MAIL 템플릿</th>
								<td>
									<select name="mailTempType" onchange="javascript:fn_changeContent(this.value)"  >
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
								<td colspan="2" class="editor" style="padding:0 0 0 0;"  >
									<textarea name="mailContent" id="mailContent" style="width:100%;height:150px" ></textarea>
								</td>
							</tr>
							<tr>
								<th>파일 첨부</th>
								<td>
									<input type="text" id="fileName" style="width:50%;" readonly="readonly">
									<span class="file-find">
										<a href="#@" class="checkfile">찾아보기</a><!-- style="left: 390px; top: 380px; right: 0px; bottom: 100px;" -->
										<input type="file" class="file_input_hidden" name="file-input" style="left: 390px; top: 325px; right: 0px; bottom: 100px;" onchange="javascript: document.getElementById('fileName').value = this.value" />										
									</span>
								</td>
							</tr>
						</tbody>
					</table>


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



				<li class="sms-btn"><a href="#!"  onclick="javascript:fn_send_mail();" >전송하기</a></li>
			</ul><!-- E : sms-container -->
</form>


		</div><!-- E : sms-wrapper -->