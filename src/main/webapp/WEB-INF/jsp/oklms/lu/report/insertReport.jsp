<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
 
						<h2>과제</h2>
						<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>


						<table class="type-1 mb-030">
							<caption>교과형태 과정구분 학점 교수 온라인교육형태 선수여부에 대한 정보를 제공합니다</caption>
							<colgroup>
								<col style="width:15%" />
								<col style="width:*px" />
								<col style="width:15%" />
								<col style="width:*px" />
								<col style="width:15%" />
								<col style="width:*px" />
							</colgroup>
							<tbody>
									<tr>
										<th scope="row">교과형태</th>
									<td>${currProcVO.subjectTraningTypeName}</td>
										<th scope="row">과정구분</th>
									<td>${currProcVO.subjectTypeName}</td>
										<th scope="row">학점</th>
										<td>${currProcVO.point }학점</td>
									</tr>
									<tr>
										<th scope="row">교수</th>
										<td>${currProcVO.insNames}</td>
										<th scope="row">온라인 교육형태</th>
										<td>${currProcVO.onlineTypeName} (성적비율 ${currProcVO.gradeRatio}%)</td>
										<th scope="row">선수여부</th>
										<td>${currProcVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}</td>
									</tr>
								</tbody>
						</table>


<script type="text/javascript" src="/common/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
<!--
var oEditors = [];

$(document).ready(function() {
	loadPage();	
	$('#file-input').on("change", previewImages);
});

/*====================================================================
jqGrid 및 화면 초기화 
====================================================================*/
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
		com.datepickerDateFormat('submitStartDate');
		com.datepickerDateFormat('submitEndDate');
}


/* 화면이 로드된후 에디터 기본옵션 설정 초기화 */ 
function initEditor() {
	//Smart Editor
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "reportDesc",
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
function fn_formSave(){

	var startDate = $("#submitStartDate").val();
	var endDate = $("#submitEndDate").val();

	startDate = startDate.replace(".","");
	startDate = startDate.replace(".","");
	endDate = endDate.replace(".","");
	endDate = endDate.replace(".","");
	
	<c:if test="${currProcVO.subjectTraningType eq 'OJT'}">
		var len = $("input:checkbox[name=subjectClasss]:checked").length;
		
		if(len == 0){
			alert("분반 선택은 필수항목입니다.");
			return false;
		}
	</c:if>

	// 공개일이 마감일보다 큰지 비교
	if(Number(startDate) > Number(endDate)){
		alert("마감일이 공개일보다 전날짜입니다.");
		$("#submitEndDate").focus();
		return false;
	}

	var score = $("#score").val();
	
	// 배점 제한 풀러달라는 요청으로 주석처리 (김차훈 요청)
	// 2017.07.14
	
	//if(score>10){
	//	alert("배점은 10점이하로 입력하셔야합니다.");
	//	$("#score").val("10");
	//	return;
	//}
	
	if( $("#reportName").val()=="" ){
		alert("과제 제목을 입력하세요.");
		return;
	}
	
	//if(checkStringFormat($("#reportName").val())){
	//	alert("과제 제목에 특수문자가 들어있습니다.");
	//	$("#reportName").focus();
	//	return;
	//}
	
	
 	
	if(frmReport.evalYn[0].checked == true){
		if($("#score").val()=="0" || $("#score").val()==""){
			alert("평가 배점을 입력하세요.");
			return;
		}
	}
	
	if( $("#submitStartDate").val()==""|| $("#submitEndDate").val()==""){
		alert("제출기간을 입력하세요.");
		return;
	}
	
	if (  confirm("저장 하시겠습니까?")) {
		var data =oEditors.getById["reportDesc"].getIR();
		var text = data.replace(/[<][^>]*[>]/gi, "");
		if(text=="" && data.indexOf("img") <= 0){
			alert("필수항목을 입력해 주세요.");
			oEditors.getById["reportDesc"].exec("FOCUS"); 
			return false;
		}
		$("#reportDesc").val(data);
		var reqUrl =  "/lu/report/insertReport.do";
		$("#frmReport").attr("target", "_self");
		$("#frmReport").attr("action", reqUrl);
		$("#frmReport").submit();
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
function checkStringFormat(string) { 
	  
    var stringRegx = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
    var isValid = true; 
 
    return stringRegx.test(string); 
}
//--> 
</script>

						<h2>과제 출제</h2> 
<form:form commandName="frmReport" name="frmReport" method="post" enctype="multipart/form-data" >

<input type="hidden" name="yyyy" value="${currProcVO.yyyy}" />
<input type="hidden" name="term" value="${currProcVO.term}" />
<input type="hidden" name="subjectCode" value="${currProcVO.subjectCode}" />
<input type="hidden" name="classId" value="${currProcVO.subClass}" />
<input type="hidden" name="subjectTraningType" value="${currProcVO.subjectTraningType}" />

						<table class="type-write">
							<caption>주차 제목 과제제출 기간 평가 배점 내용 첨부파일에 대한 정보를 제공합니다</caption>
							<colgroup>
								<col style="width:130px" />
								<col style="width:*" />
								<col style="width:130px" />
								<col style="width:*" />
							</colgroup>
							<tbody>
								<c:if test="${currProcVO.subjectTraningType eq 'OJT'}">
								<tr>
									<th scope="row"><label for="weekCnt">분반</label></th>
									<td class="left" colspan="3">
										<c:forEach var="result" items="${listOjtClassName}" varStatus="status">
													<%-- <li <c:if test="${result.subjectClass eq subjectVO.subjectClass }">  class="current" </c:if> > --%>
													<%-- <a href="#!" onclick="javascript:fn_search('${result.subjectClass}','${result.companyId }','${status.count }','${result.companyName}')" title="${result.companyName}">${result.subjectClass}분반_${result.companyName }</a></li> --%>
												 <input type="checkbox"  name="subjectClasss" <c:if test="${result.subjectClass eq currProcVO.subClass }">checked="checked"</c:if> value="${result.subjectClass}">&nbsp;&nbsp;${result.subjectClass}분반_${result.companyName }<br/>
											</c:forEach>
									</td>
								</tr>
								</c:if>
								<tr>
									<th scope="row"><label for="weekCnt">주차</label></th>
									<td class="left" colspan="3">
										<select id="weekCnt" name="weekCnt" style="width:auto;" >
											<c:forEach var="result" items="${onlineTraningSchVO}" varStatus="status">
											<option value="${result.weekCnt}">${result.weekCnt}</option>
											</c:forEach>
										</select>&nbsp;&nbsp;&nbsp;
										주차
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="reportName">제목</label></th>
									<td class="left" colspan="3"><input type="text" name="reportName" id="reportName" style="width:97%;" /></td>
								</tr>
								<tr>
									<th scope="row">과제제출 기간</th>
									<td class="left" colspan="3">
										<!-- 
										<input type="radio" name="submitDateType" value="" class="choice"  />&nbsp;&nbsp;										
										학습활동서 제출마감일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										-->
										<label for="submitDateType">선택기간</label>
										<input type="radio" name="submitDateType" id="submitDateType" value="" class="choice" checked />&nbsp;&nbsp;
										<label for="submitStartDate" class="hidden">시작</label>
										<input type="text" name="submitStartDate" id="submitStartDate" value="" style="width:110px" /> 
										
										<select name="submitStartHour" id="submitStartHour" title="시작시간을 선택하세요" style="width:70px" >
       										 <option value="00" selected="selected">00시</option>
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
       										
       									<select name="submitStartMin" id="submitStartMin"  title="시작 분을 선택하세요" style="width:70px" >
        									<c:forEach var="item"  begin="0" end="59" step="1" varStatus="status">
       											<c:choose>
       												<c:when test="${item < 10 }">
       													<option value="0${item}">0${item}분</option>
       												</c:when>
       												<c:otherwise>
       													<option value="${item}">${item}분</option>
       												</c:otherwise>
       											</c:choose>
        									</c:forEach>
        								</select> 
       										 
										&nbsp;&nbsp;~&nbsp;&nbsp; 
										<label for="submitEndDate" class="hidden">종료</label>
										<input type="text" name="submitEndDate" id="submitEndDate"  value="" style="width:110px" />
										<select name="submitEndHour" id="submitEndHour" title="종료 시간을 선택하세요" style="width:70px" >
       										 <option value="00" selected="selected">00시</option>
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
       										
       									<select name="submitEndMin" id="submitEndMin"  title="종료 분을 선택하세요" style="width:70px" >
        									<c:forEach var="item"  begin="0" end="59" step="1" varStatus="status">
       											<c:choose>
       												<c:when test="${item < 10 }">
       													<option value="0${item}">0${item}분</option>
       												</c:when>
       												<c:otherwise>
       													<option value="${item}">${item}분</option>
       												</c:otherwise>
       											</c:choose>
        									</c:forEach>
        								</select> 
									</td>
								</tr>
								<tr>
									<th scope="row">평가</th>
									<td class="left">
										<label for="evalYn1"><input type="radio" name="evalYn" id="evalYn1"  value="Y" class="choice" checked /> Y</label>
										
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label for="evalYn2"><input type="radio" name="evalYn" id="evalYn2" value="N" class="choice" /> N</label>
									</td>
									<th scope="row"><label for="score">배점</label></th>
									<td class="left"><input type="number" name="score" id="score" value="0"  min="0" max="9" style="width:60px; text-align:right;"  /> 점
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="reportDesc">내용</label></th>
									<td class="left" colspan="3"><textarea name="reportDesc" id="reportDesc" rows="5"></textarea></td>
								</tr>
								<tr>
									<th scope="row"><label for="atchFiles">첨부파일</label></th>
									<td class="left" colspan="3">
										<input type="text" id="atchFiles" name="atchFiles" style="width:50%;" readonly  onchange="fileCheck(this.form.atchFiles)">
										<span>
											<a href="#@" class="checkfile"><label for="file-input">파일선택</label></a>
											<input type="file" class="file_input_hidden" name="file-input" id="file-input"  onchange="javascript:document.getElementById('atchFiles').value = this.value" />
										</span>
										<span id="fileSizeName">0KB / 100M</span>
									</td>
								</tr>
							</tbody>
						</table>
</form:form>
						<div class="btn-area mt-010">
							<div class="float-right">
							<a href="/lu/report/listReport.do" class="gray-1 float-left">취소</a><a href="#" onclick="javascript:fn_formSave();" class="orange">등록</a>
							</div>
						</div><!-- E : btn-area -->

