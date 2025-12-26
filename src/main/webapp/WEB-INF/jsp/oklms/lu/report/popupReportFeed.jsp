<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<script type="text/javascript" src="/common/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">


<!--
var oEditors = [];

$(document).ready(function() {


	loadPage();
	
	
});


function loadPage() {
	initEvent();
	initHtml();
	initEditor();
}


/* 각종 버튼에 대한 액션 초기화 */ 
function initEvent() {
}
/* 화면이 로드된후 처리 초기화 */
function initHtml() {
}
function pop_closeWin() {
	self.close();
}

/* 화면이 로드된후 에디터 기본옵션 설정 초기화 */ 
function initEditor() {
	//Smart Editor
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "reportFeedbackDesc",
		sSkinURI: "/common/smartEditor/SmartEditor2Skin.html",	
		htParams : {bUseToolbar : true,
			fOnBeforeUnload : function(){
				//alert("아싸!");	
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["textAreaContent"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
}

/* HTML Form 신규, 수정 */
function fn_formSave(url){

	if (  confirm("저장 하시겠습니까?")) {
		var data =oEditors.getById["reportFeedbackDesc"].getIR();
		var text = data.replace(/[<][^>]*[>]/gi, "");
		if(text=="" && data.indexOf("img") <= 0){
			alert("필수항목을 입력해 주세요.");
			oEditors.getById["reportFeedbackDesc"].exec("FOCUS"); 
			return false;
		}
		$("#reportFeedbackDesc").val(data);
		var reqUrl =  url;
		$("#frmReport").attr("target", "_self");
		$("#frmReport").attr("action", reqUrl);
		$("#frmReport").submit();
		$(opener.document).find("#feed_${infoVO.reportSubmitId }").text("수정");
		//opener.location.reload();


	}
}

function fn_formDelete(){
	if (  confirm("삭제 하시겠습니까?")) {
		var reqUrl =  "/lu/report/deleteReportFeedBack.do";
		$("#frmReport").attr("target", "_self");
		$("#frmReport").attr("action", reqUrl);
		$("#frmReport").submit();
		$(opener.document).find("#feed_${infoVO.reportSubmitId }").text("등록");
		//opener.location.reload();
	}
}

function previewImages() {
	  var $preview = $('#preview').empty();
	  $("#fileName").val($('#file-input').val());
	  var filesize = 0;
	  if (this.files) {
		  $.each(this.files, readAndPreview);
	  }
	  
	  function readAndPreview(i, file) {
		if (window.FileReader) { // FireFox, Chrome, Opera 확인.
			//if (!/\.(jpe?g|png|gif)$/i.test(file.name)){
			//      return alert(file.name +" is not an image");
		    //} // else...
			
			if(!fileValidation(file.name)){
		    	$("#atchFiles").val("");
		    	return false;
		    }
		    
		    filesize = filesize + file.size;
		
		    if(filesize > 100000000){ //Checking Sum 100M Size
				alert("전체 사이즈 100M이상 업로드 할수 없습니다.");
				
				$("#atchFiles").val("");
				
				return false;
			}else{
				
				var filesizeNumber = "";
				if(filesize>1000000){
					filesizeNumber = ((filesize/1000000).toFixed(2))+" M";
				}else if(filesize>1000){
					filesizeNumber = ((filesize/1000).toFixed(2))+" KB";
				}else{
					filesizeNumber = filesize+" B";
				}		
				
				$("#fileSizeName").html( filesizeNumber +" / 100M");
			}
		}else{ // safari is not supported FileReader
	        alert('not supported Webbrowser!!');
	    }
	  }
}

//-->
</script>

	<body>
<form name="frmReport" id="frmReport" action=""  method="post" enctype="multipart/form-data">
		<input type="hidden" name="reportId" id="reportId"  value="${infoVO.reportId }" />
		<input type="hidden" name="reportSubmitId" id="reportSubmitId"  value="${infoVO.reportSubmitId }" />


		<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<div id="pop-wrapper" class="min-w650">

			<h1>과제 첨삭</h1>
			<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>



			<table class="type-1 mb-020">
				<caption>제목 주차 과제제출기간 내용에 대한 정보를 제공합니다</caption>
				<colgroup>
					<col style="width:110px" />
					<col style="width:200px" />
					<col style="width:110px" />
					<col style="width:*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3">${reportVO.reportName}</td>
					</tr>
					<tr>
						<th scope="row">주차</th>
						<td>${reportVO.weekCnt} 주차</td>
						<th scope="row">과제제출 기간</th>
						<td>${reportVO.submitStartDate} ${reportVO.submitStartHour}:${reportVO.submitStartMin}~${reportVO.submitEndDate} ${reportVO.submitEndHour}:${reportVO.submitEndMin}</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td colspan="3">${reportVO.reportDesc}</td>
					</tr>
				</tbody>
			</table>


			<table class="type-2">
				<caption>학번 이름 제출일 제출현황에 대한 정보를 제공합니다</caption>
				<colgroup>
					<col style="width:60px" />
					<col style="width:120px" />
					<col style="width:*" />
					<col style="width:80px" />
					<col style="width:80px" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">학번</th>
						<th scope="col">이름</th>
						<th scope="col">제출일</th>
						<th scope="col">제출현황</th>
					</tr>
				</thead>
				<tbody>
								<tr>
									<td>${infoVO.memId }</td>
									<td>${infoVO.memName }</td>
									<td>${infoVO.insertDate }</td>
									<td>
											<a href="#" class="btn-line-gray" onclick="javascript:com.downFile('${infoVO.atchFileId}','1');" >제출</a>
									</td>
								</tr>
		 
				</tbody>
			</table>
			<br/>
			<table class="type-write">
				<caption>주차 제목 과제제출 기간 평가 배점 내용 첨부파일에 대한 정보를 제공합니다</caption>
				<colgroup>
					<col style="width:130px" />
					<col style="width:*" />
					<col style="width:130px" />
					<col style="width:*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="reportFeedbackDesc">첨삭내용</label></th>
						<td class="left" colspan="3"><textarea name="reportFeedbackDesc" id="reportFeedbackDesc" rows="5">${feedVO.reportFeedbackDesc}</textarea></td>
					</tr>
					<tr>
						<th scope="row"><label for="atchFiles">첨삭파일</label></th>
						<td class="left" colspan="3">
							
							<c:if test="${!empty resultFile}">
								<a href="javascript:com.downFile('${resultFile.atchFileId}','${resultFile.fileSn}');" class="text-file">${resultFile.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:com.deleteFile('${resultFile.atchFileId}|${resultFile.fileSn}', '/lu/report/goPopupReportFeed.do?reportId=${infoVO.reportId }&reportSubmitId=${infoVO.reportSubmitId }')">[삭제]</a><br />
							</c:if>
							
							<c:if test="${empty resultFile}">
								<input type="text" id="atchFiles" name="atchFiles" style="width:50%;" readonly  onchange="fileCheck(this.form.atchFiles)">
								<span>
									<a href="#@" class="checkfile"><label for="file-input">파일선택</label></a>
									<input type="file" class="file_input_hidden" name="file-input" id="file-input"  onchange="javascript:document.getElementById('atchFiles').value = this.value" />
								</span>
								<span id="fileSizeName">0KB / 100M</span>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
</form>

			<div class="btn-area align-center mt-010" style="border-top:1px solid #CCC; padding-top:20px;">
				<c:if test="${empty feedVO}">
					<a href="#!" onclick="javascript:fn_formSave('/lu/report/insertReportFeedBack.do');" class="black">저장</a>
				</c:if>
				<c:if test="${!empty feedVO}">
					<a href="#!" onclick="javascript:fn_formSave('/lu/report/updateReportFeedBack.do');" class="black">저장</a>
					<a href="#!" onclick="javascript:fn_formDelete();" class="orange">삭제</a>
				</c:if>
				<a href="javascript:pop_closeWin();" class="black">닫기</a>
			</div>


		</div><!-- E : wrapper -->
	</body>