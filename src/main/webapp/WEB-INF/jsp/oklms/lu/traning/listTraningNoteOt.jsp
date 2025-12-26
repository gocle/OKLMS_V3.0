<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
 <%
     //치환 변수 선언합니다.
      pageContext.setAttribute("br", "<br/>");  //br 태그
      pageContext.setAttribute("cn", "\n"); //Space, Enter
%> 
 						<h2>훈련일지</h2>
						<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
						<script type="text/javascript" src="/js/oklms/iscroll.js"></script>
						<script type="text/javascript" src="/js/jquery/jquery.raty.js"></script>
<script type="text/javascript">
<!--
$(document).ready(function() {
	
	com.datepickerDateFormat('startDate');
	com.datepickerDateFormat('traningDate');
	
	$("#time_leadTime").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	$("input[name='studyTimeArr']").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	
});
var tempListSeq="";
var listSeq="${SESSION_USER_SEQ}";
var listName="${SESSION_USER_NAME}";
var listMemId="${SESSION_USER_ID}";
var tempIndex="0";
var tempSave=true;

/*************************************************************
레이어 팝업창
**************************************************************/
var showLearningpop = function(){
	$(".student-area,.popup-bg").addClass("open"); 
	window.location.hash = "#open"; 
};
var hideLearningpop = function(){
	$(".student-area,.popup-bg").removeClass("open");
	// 선택값입력
  	showRegularAdd(tempIndex);
};
var showLearningpop1 = function(){
	$(".student-area,.popup-bg").addClass("open"); 
	window.location.hash = "#open"; 
};
var hideLearningpop1 = function(){
	$(".student-area,.popup-bg").removeClass("open"); 
};



var showLearningpop2 = function(){
	$(".student-area,.popup-bg").addClass("open"); 
	window.location.hash = "#open"; 
};
var hideLearningpop2 = function(){
	$(".student-area,.popup-bg").removeClass("open"); 
};



var showCompanypop = function(){
	$(".company-area,.popup-bg").addClass("open"); 
	window.location.hash = "#open"; 
};
var hideCompanypop = function(){
	$(".company-area,.popup-bg").removeClass("open"); 
};



var showTrainpop = function(){
	$(".training-area,.popup-bg").addClass("open"); 
	window.location.hash = "#open"; 
};
var hideTrainpop = function(){
	$(".training-area,.popup-bg").removeClass("open"); 
};




function fn_search(classId,companyId){
	
	$("#classId").val(classId);
	$("#companyId").val(companyId);
	
	var reqUrl = "/lu/traning/listTraningNoteOt.do";  
 
	$("#frmTraning").attr("target", "_self");
	$("#frmTraning").attr("action", reqUrl);
	$("#frmTraning").submit();

}
var myScroll;

function loaded() {
	myScroll = new iScroll('wrap', {
		snap: true,
		momentum: false,
		hScrollbar: false,
	});
}

document.addEventListener('DOMContentLoaded', loaded, false);

function fn_checkboxAll(param ){
	 
	$('#frmTraning' +param +' input:checkbox[name="checkMember"]').each(function(){
		if($(this).is(":checked") == true){
			$('.checkMember'+param).prop('checked',false);
		}else{
			$('.checkMember'+param).prop('checked',true);			
		}
	});
}
function fn_insert(index){
	
	if($("#review"+index).val()==""){
		alert("총평을 입력하세요");
		$("#review"+index).focus();
		return;
	} 
	
	if(doubleSubmitCheck()) return;
	
	var reqUrl = "/lu/traning/goInsertTraningNote.do";
	$("#frmTraning"+index).attr("action", reqUrl);
	$("#frmTraning"+index).submit();

}


function showRegularAdd(index){


	var checkMemberId="";
	var tempseq =listSeq.split(",");
	var tempname = listName.split(",");
	var tempid = listMemId.split(",");
	
	// 초기화처리
	listSeq="";
	listName="";
	listMemId="";
	
	var html = "";
		
	for(var i=0; tempseq.length>i ; i++){ 
		if(tempseq[i] && tempListSeq.indexOf(tempseq[i])>=0){
			 
			 var  companyNameText = "" ;
			 var  memIdText =tempid[i];
			 checkMemberId += memIdText+","; 
			 var  memNameText = tempname[i];
			 var  memSeqText = tempseq[i];
			 
			 var trIndex = "tr" + index;
			 var achievement = "achievementEnrichment" +index; 
			  
			 html +="<tr id='"+index+trIndex+"'>";
			 html +="<td>"+memIdText;
			 html += "<input type='hidden' name='memIdArr' id='memIdArr' value='"+memIdText+"'/>" ;
			 html += "<input type='hidden' name='memNmArr' id='memNmArr' value='"+memNameText+"'/>" ;
			 html += "<input type='hidden' name='traniningNoteDetailIdArr' id='traniningNoteDetailIdArr'/>" ;
			 html += "<input type='hidden' name='traniningNoteMasterIdArr' id='traniningNoteMasterIdArr'/>" ;
			 html +="</td>";
			 
			 html +="<td>"+memNameText+"</td>";
			 html +="<td><input type='text' style='width:95%;' name='studyTimeArr' /></td>";
			 html +="<td id='"+memIdText.trim()+"result'></td>"; 
			 html +="<td class='left'><input type='text' style='width:97%;' name='bigoArr'/></td>";
			 html +="<td> <a href='javascript:removeMemberHtml(\""+index+"\",\""+trIndex+"\");'>삭제</a>  </td>";
			 html +="</tr>";
			 
			 $("#traningNoteMemberSeqs"+index).val($("#traningNoteMemberSeqs"+index).val()+","+memSeqText);
			 $("#traningNoteMemberIds"+index).val($("#traningNoteMemberIds"+index).val()+","+memIdText);
			 $("#traningNoteMemberNames"+index).val($("#traningNoteMemberNames"+index).val()+","+memNameText);
			 tempSave = false;
		}
	 
	}
 

	$("#regularTr"+index).prepend(html);
	
	var memberIdlist = checkMemberId.split(",");
	
	for(var x=0;memberIdlist.length>x ; x++){
		$(function() {
			$('#'+memberIdlist[x].trim()+'result').raty({ 
				cancel :true,
				score: 5,
				path : "/images/oklms/std/inc" 
			});
		});			
	}

}
var indexNum=0;
function showRegular(index){
	if(indexNum >= Number(index)){
		index = Number(indexNum)+1;	
	}
	indexNum = index;
	$("#regular").show(); 
	var html = "";  
	 html +="<form name='frmTraningEnrichment${statustop.index}' id='frmTraningEnrichment"+index+"' method='post' >";
	 html +="										<input type='hidden' id='achievementEnrichment' name='achievementEnrichment' />";
	 html +="										<input type='hidden' id='state' name='state' value='W' />";
	 html +="										<input type='hidden' id='startTime' name='startTime' value=''/>";
	 html +="										<input type='hidden' id='finishTime' name='finishTime' value='' />";
	 html +="										<input type='hidden' id='planTime' name='planTime' value='' />";
	 html +="										<input type='hidden' id='weekId' name='weekId' value='${TraningNoteVO.weekId}'/>";
	 html +="										<input type='hidden' id='timeId' name='timeId' value=''/>";
	 html +="										<input type='hidden' name='weekCnt' value='${TraningNoteVO.weekCnt}' />";
	 html +="										<input type='hidden' id='memId' name='memId'/>";
	 html +="										<input type='hidden' id='traniningNoteDetailId' name='traniningNoteDetailId'  />";
	 html +="										<input type='hidden' id='traniningNoteMasterId' name='traniningNoteMasterId' />";
	 html +="						<input type='hidden'   name='classId' value='${TraningNoteVO.classId}' />";
	 html +="	<input type='hidden' name='traningNoteMemberSeqs' id='traningNoteMemberSeqs"+index+"'    />";
	 html +="	<input type='hidden' name='traningNoteMemberIds' id='traningNoteMemberIds"+index+"'   />";
	 html +="	<input type='hidden' name='traningNoteMemberNames' id='traningNoteMemberNames"+index+"' />";
	 	 
	 html +="								<dt> 보강훈련</dt>";
	 html +="								<dd style='display:block;'>";
	 html +="								<div class='mt-010 mb-020'>";
	 html +="								<input type='text' name='studyDate' id='startDate"+index+"' style='width:75px;' />";
	 html +="								시작 :<select name='traningStHour'>";
	 html +="											<option value='09' >오전 9시</option>";
	 html +="											<option value='10' >오전 10시</option>";
	 html +="											<option value='11' >오전 11시</option>";
	 html +="											<option value='12' >오전 12시</option>";
	 html +="											<option value='13' >오후 1시</option>";
	 html +="											<option value='14' >오후 2시</option>";
	 html +="											<option value='15' >오후 3시</option>";
	 html +="											<option value='16' >오후 4시</option>";
	 html +="											<option value='17' >오후 5시</option>";
	 html +="											<option value='18' >오후 6시</option>";
	 html +="									</select>";
	 html +="									<select name='traningStMin'>";
	 html +="										<option value='00' >0 분</option>";
	 html +="										<option value='10' >10 분</option>";
	 html +="										<option value='20' >20 분</option>";
	 html +="										<option value='30' >30 분</option>";
	 html +="										<option value='40' >40 분</option>";
	 html +="										<option value='50' >50 분</option>";
	 html +="									</select> ~";
	 html +="								종료 :<select name='traningEdHour'>";
	 html +="											<option value='09' >오전 9시</option>";
	 html +="											<option value='10' >오전 10시</option>";
	 html +="											<option value='11' >오전 11시</option>";
	 html +="											<option value='12' >오전 12시</option>";
	 html +="											<option value='13' >오후 1시</option>";
	 html +="											<option value='14' >오후 2시</option>";
	 html +="											<option value='15' >오후 3시</option>";
	 html +="											<option value='16' >오후 4시</option>";
	 html +="											<option value='17' >오후 5시</option>";
	 html +="											<option value='18' >오후 6시</option>";
	 html +="									</select>";
	 html +="									<select name='traningEdMin'>";
	 html +="										<option value='00' >0 분</option>";
	 html +="										<option value='10' >10 분</option>";
	 html +="										<option value='20' >20 분</option>";
	 html +="										<option value='30' >30 분</option>";
	 html +="										<option value='40' >40 분</option>";
	 html +="										<option value='50' >50 분</option>";
	 html +="									</select>";
	 
	 html +="									</div>";
	 html +="									<table class='type-2'>";
	 html +="										<colgroup>";

	 html +="											<col width='15%' />";
	 html +="											<col width='15%' />";
	 html +="											<col width='8%' />";
	 html +="											<col width='17%' />";
	 html +="											<col width='*' />";
	 html +="											<col width='10%' />";
	 html +="										</colgroup>";
	 html +="										<thead>";
	 html +="											<tr>";

	 html +="												<th>학번</th>";
	 html +="												<th>성명</th>";
	 html +="												<th>훈련시간</th>";
	 html +="												<th>성취도</th>";
	 html +="												<th>보강비고 (교육 중 특이사항 등)</th>";
	 html +="												<th>삭제</th>";
	 html +="											</tr>";
	 html +="										</thead>";
	 html +="										<tbody  id='regularTr"+index+"'>";
	  
	 
	 
	 html +="											<tr>";
	 html +="												<th>보강총평</th>";
	 html +="												<td colspan='5' class='left'><textarea name='review' rows='6'></textarea></td>";
	 html +="											</tr>";
	 html +="										</tbody>";
	 html +="									</table>";

	 html +="									<div class='btn-area align-center mt-010'>";
	 html +="										<a href='#!' class='orange' onclick='javascript:fn_memberpage(\""+index+"\");'>학습근로자추가</a>";
	 html +="										<a href='#!' onclick='javascript:fn_insertEnrichment(\""+index+"\");' class='yellow'>저장</a>";
	 html +="										<a href='#!' onclick='javascript:removeMemberHtml(\""+index+"\",\"frmTraningEnrichment"+index+"\");' class='gray-1'>삭제</a>";
	 html +="									</div>";	 
	 html +="								</dd>";
	 html +="								</form>";
	 
	$("#regular").append(html);
	com.datepickerDateFormat('startDate'+index);

}
//삭제 처리
function removeMemberHtml(index,memberId){
	$("#"+index+memberId).remove();
}
function removeMember(index,traniningNoteDetailId,traniningNoteMasterId ){
 

	$("#traniningNoteDetailId"+index).val(traniningNoteDetailId);
	$("#traniningNoteMasterId"+index).val(traniningNoteMasterId);
	
	var formData = $("#frmTraningEnrichment"+index).serialize();
	$.ajax({
		type:"POST",
		url:"/lu/traning/deleteTraningNoteEnrichment.do",
		cache:false,
		data:formData,
		success:function(html){
			alert("삭제되었습니다.");
		},
		error:function(e){
			alert(e);
		}
	});
}
// 훈련시간 변경처리
function  studyTimeArrZeor(values,max,memId,index){
	if(values == '0'){
		$('#'+memId+'result'+index+'').raty({ 
			cancel :true,
			score:0,					
			path : "/images/oklms/std/inc" 
		});		
	}else if(values==max){
		$('#'+memId+'result'+index+'').raty({ 
			cancel :true,
			score:5,					
			path : "/images/oklms/std/inc" 
		});			
	}

}

function fn_insertEnrichment(index){
	
	if(doubleSubmitCheck()) return;
	
	var reqUrl = "/lu/traning/goInsertTraningNoteEnrichment.do";
	$("#frmTraningEnrichment"+index).attr("action", reqUrl);
	$("#frmTraningEnrichment"+index).submit();

}
function fn_memberpage(index){
		if(!tempSave){
			alert("추가한 항목을 먼저 저장후 추가해주세요.");
			return;
		}
	listSeq = $( "#traningNoteMemberSeqs"+index ).val();
	listMemId = $( "#traningNoteMemberIds"+index ).val();
	listName = $( "#traningNoteMemberNames"+index ).val();		

	tempIndex = index;
	fn_memberLList("1");
}
function fn_memberLList( pageIndex){

$.ajax({
	  type: "POST",
	  url: "/lu/traning/ajaxTraningNote.do",
	  data: { "traningNoteMemberSeqs":listSeq ,"traningNoteMemberIds":listMemId ,"traningNoteMemberNames":listName ,"pageIndex": pageIndex,"subjectCode":"${TraningNoteVO.subjectCode}" , "weekCnt":"${TraningNoteVO.weekCnt}" ,"classId":"${TraningNoteVO.classId }" ,"timeId":"" },
	  success:function( html ) {
		$( "#traningNoteMemberList" ).html( html );
		showLearningpop();
	  }
});
}
//학습근로자 선택시 
function checkboxClick(param1,memSeq,memName,memId){

//체크박스 선택 
if(param1){ 
	if(listSeq.indexOf(memSeq) >=0){

	}else{
    	listSeq += ','+memSeq;
    	listName += ','+memName;
    	listMemId += ','+memId;
    	tempListSeq +=','+memSeq;
	}
}else{
	listSeq =	listSeq.replace(','+memSeq,'');
	listName = listName.replace(','+memName,'');
	listMemId = listMemId.replace(','+memId,'');
}
}

function fn_showSchedule(){
	
	if($("#weekTimeSchedule").css("display") == "none"){
	    $("#weekTimeSchedule").show();
	    $("#mod_btn").text();
	} else {
	    $("#weekTimeSchedule").hide();
	}
		
}

function fn_showTimeList(){
	if($("#weekTimeList").css("display") == "none"){
	    $("#weekTimeList").show();
	} else {
	    $("#weekTimeList").hide();
	}
}

function fn_insertTime(){
	if($("#time_weekCnt").val()==""){
		alert("[주차] 선택은 필수항목입니다.");
		$("#time_weekCnt").focus();
		return;
	} 
	if($("#time_traningDate").val()==""){
		alert("[훈련일] 선택은 필수항목입니다.");
		$("#time_traningDate").focus();
		return;
	}  
	
	if($("#time_traningStHour").val()==""){
		alert("[시작시간-시간] 선택은 필수항목입니다.");
		$("#time_traningStHour").focus();
		return;
	}  
	/*
	if($("#time_traningStMin").val()==""){
		alert("[시작시간-분] 선택은 필수항목입니다.");
		$("#time_traningStMin").focus();
		return;
	}  
	*/
	if($("#time_traningEdHour").val()==""){
		alert("[종료시간-시간] 선택은 필수항목입니다.");
		$("#time_traningEdHour").focus();
		return;
	}  
	
	/* if($("#time_traningEdMin").val()==""){
		alert("[종료시간-분] 선택은 필수항목입니다.");
		$("#time_traningEdMin").focus();
		return;
	}  */
	
	if($("#time_leadTime").val()==""){
		alert("[훈련시간] 입력은 필수항목입니다.");
		$("#time_leadTime").focus();
		return;
	}
	
	//if($("#time_ncsUnit").val()==""){
	//	alert("[능력단위] 선택은 필수항목입니다.");
	//	$("#time_ncsUnit").focus();
	//	return;
	//}  
	
	
	if( Number($("#time_traningStHour").val()) >= Number($("#time_traningEdHour").val()) ) {
		alert("시작시간이 종료시간보다 같거나 클 수 없습니다.");
		$("#time_traningEdHour").val("");
		$("#time_traningEdHour").focus();
		$("#time_leadTime").val("");
		return
	}
	
	if(doubleSubmitCheck()) return;
	
	var ncsUnit = $("#time_ncsUnit").val().split("|");
	
	$("#time_ncsUnitId").val(ncsUnit[0]);
	$("#time_ncsUnitName").val(ncsUnit[1]);
	
	var reqUrl = "/lu/traning/saveTraningNoteTime.do";
	$("#frmTime").attr("action", reqUrl);
	$("#frmTime").submit();
	
}

function fn_updateTime(weekId,timeId){
	
	if($("#"+timeId+"_traningDate").val()==""){
		alert("[훈련일] 선택은 필수항목입니다.");
		$("#"+timeId+"_traningDate").focus();
		return;
	}  
	
	if($("#"+timeId+"_traningStHour").val()==""){
		alert("[시작시간-시간] 선택은 필수항목입니다.");
		$("#time_traningStHour").focus();
		return;
	}  
	/*
	if($("#"+timeId+"_traningStMin").val()==""){
		alert("[시작시간-분] 선택은 필수항목입니다.");
		$("#"+timeId+"_traningStMin").focus();
		return;
	}  
	*/
	if($("#"+timeId+"_traningEdHour").val()==""){
		alert("[종료시간-시간] 선택은 필수항목입니다.");
		$("#"+timeId+"_traningEdHour").focus();
		return;
	}  
	
	/* if($("#"+timeId+"_traningEdMin").val()==""){
		alert("[종료시간-분] 선택은 필수항목입니다.");
		$("#"+timeId+"_traningEdMin").focus();
		return;
	}  */
	
	if($("#"+timeId+"_leadTime").val()==""){
		alert("[훈련시간] 입력은 필수항목입니다.");
		$("#"+timeId+"_leadTime").focus();
		return;
	}
	
	//if($("#"+timeId+"_ncsUnit").val()==""){
	//	alert("[능력단위] 선택은 필수항목입니다.");
	//	$("#"+timeId+"_ncsUnit").focus();
	//	return;
	//}  
	
	
	if( Number($("#"+timeId+"_traningStHour").val()) >= Number($("#"+timeId+"_traningEdHour").val()) ) {
		alert("시작시간이 종료시간보다 같거나 클 수 없습니다.");
		$("#"+timeId+"_traningEdHour").val("");
		$("#"+timeId+"_traningEdHour").focus();
		$("#"+timeId+"_leadTime").val("");
		return
	}
	
	if(doubleSubmitCheck()) return;
	
	var ncsUnit = $("#"+timeId+"_ncsUnit").val().split("|");
	
	$("#"+timeId+"_ncsUnitId").val(ncsUnit[0]);
	$("#"+timeId+"_ncsUnitName").val(ncsUnit[1]);
	
	$("#"+timeId+"_weekId").val(weekId);
	$("#"+timeId+"_timeId").val(timeId);
	
	var reqUrl = "/lu/traning/updateTraningNoteTime.do";
	$("#frm"+timeId).attr("action", reqUrl);
	$("#frm"+timeId).submit();
	
}

function fn_deleteTime(weekId,timeId){
	if(confirm("시간표를 삭제 하시겠습니까?\n시간표 삭제시 시간표에 등록 된\n훈련일지,학습활동서가 함께 삭제 됩니다.")){
		$("#"+timeId+"_weekId").val(weekId);
		$("#"+timeId+"_timeId").val(timeId);
		if(doubleSubmitCheck()) return;
		
		var reqUrl = "/lu/traning/deleteTraningNoteTime.do";
		$("#frm"+timeId).attr("action", reqUrl);
		$("#frm"+timeId).submit();
	}
	
}


function fn_leadTime(){
	var leadTime = 0;
	
	if(!$("#time_traningStHour").val() == "" && !$("#time_traningEdHour").val() == ""){
		
		if( Number($("#time_traningStHour").val()) >= Number($("#time_traningEdHour").val()) ) {
			alert("시작시간이 종료시간보다 같거나 클 수 없습니다.");
			$("#time_traningEdHour").val("");
			$("#time_traningEdHour").focus();
			$("#time_leadTime").val("");
			return
		}
		leadTime = Number($("#time_traningEdHour").val())-Number($("#time_traningStHour").val());
		$("#time_leadTime").val(leadTime);
		
	}
}

function fn_excel(){
	if($("#searchMonth").val()==""){
		alert("[월] 선택은 필수항목입니다.");
		$("#searchMonth").focus();
		return;
	} 
	
	
	var reqUrl = "/lu/traning/excelTraningNoteOt.do";
	$("#frmTraning").attr("action", reqUrl);
	$("#frmTraning").submit();
	
}

//--> 
</script>
<c:set var="tempCompany" value=""/>
<c:set var="tempClass" value=""/>
<c:set var="prevCompany" value=""/>
<c:set var="prevClass" value=""/>
<c:set var="nextCompany" value=""/>
<c:set var="nextClass" value=""/>


						<div class="group-area name-tab-content">
<form name="frmTraning" id="frmTraning" method="post">
				<input type="hidden" id="classId" name="classId" value="${TraningNoteVO.classId}" />
				<input type="hidden" id="companyId" name="companyId" value="${TraningNoteVO.companyId}" />
						
							
							
							<div class="group-area-title">
								<h4 class="mb-010"><span>${TraningNoteVO.subjectName} / ${TraningNoteVO.subjectCode }</span> (${TraningNoteVO.classId }분반_${TraningNoteVO.companyName})ㅣ ${TraningNoteVO.yyyy}학년도 ${TraningNoteVO.termName} </h4>

								<p style="padding-left: 100px">
									<label for="searchMonth" class="hidden">월 선택</label>
									<select id="searchMonth" name="searchMonth" >
										<option value="">월 선택</option>
										<option value="01">1월</option>
										<option value="02">2월</option>
										<option value="03">3월</option>
										<option value="04">4월</option>
										<option value="05">5월</option>
										<option value="06">6월</option>
										<option value="07">7월</option>
										<option value="08">8월</option>
										<option value="09">9월</option>
										<option value="10">10월</option>
										<option value="11">11월</option>
										<option value="12">12월</option>
									</select>
									<span class="btn-area" style="display:inline-block; width:inherit;"><a href="#!" class="orange" onclick="javascript:fn_excel()">훈련일지 출력</a></span>
								</p>
							</div>
							
							
							
							<div class="training-info">
								 <div class="txt-box">
									<dl>
										<dt><label for="weekCnt">주차</label></dt>
										<dd>
											<select id="weekCnt" name="weekCnt" onchange="javascript:fn_search('${TraningNoteVO.classId}','${TraningNoteVO.companyId}');">
												<c:forEach var="result" items="${weeklist}" varStatus="status">
												<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq TraningNoteVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
												</c:forEach>
											</select>		
										</dd>
									</dl>
									
									<dl>
										<dt>기간</dt>
										<dd>${TraningNoteVO.traningStDate} ~ ${TraningNoteVO.traningEndDate}</dd>
									</dl>
									<dl>
										<dt>능력단위</dt>
										<dd>${TraningNoteVO.ncsUnitName}</dd>
									</dl>
									
									<dl>
										<dt>주간 훈련시간</dt>
										<dd>${TraningNoteVO.timeHour}</dd>
									</dl>
									<!-- 
									<dl class="class-cont">
										<dt>능력단위요소</dt>
										<dd>${TraningNoteVO.ncsElemName}</dd>
									</dl>
									 -->
									<dl class="class-cont">
										<dt>수업내용</dt>
										<dd>${TraningNoteVO.lessonCn}</dd>
									</dl>
								</div>
							</div>
					</form>
	
					<div class="btn-area mt-010">
						<div class="float-right">
							<a href="#!" class="orange" onclick="javascript:fn_showTimeList();" id="add_btn">시간표 수정</a>
							<a href="#!" class="orange" onclick="javascript:fn_showSchedule();" id="mod_btn">시간표 추가</a>
						</div>
					</div>
					

				
							
					<div class="clearfix"></div>
					<div class="table-responsive mt-040" id="weekTimeList" style="display: none">
						<table class="type-2">
							<caption>주차 훈련일 시작시간 종료시간훈련시간 능력단위 등 정보제공</caption>
							<colgroup>
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="*">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">주차</th>
									<th scope="col">훈련일</th>
									<th scope="col">시작시간</th>
									<th scope="col">종료시간</th>
									<th scope="col">훈련시간</th>
									<th scope="col">능력단위</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="timeList" items="${timeList}" varStatus="status">
<form name="frm${timeList.timeId}" id="frm${timeList.timeId}" method="post">
				<input type="hidden" id="${timeList.timeId}_weekId" name="weekId" value="" />
				<input type="hidden" id="${timeList.timeId}_timeId" name="timeId" value="" />		
				<input type="hidden" id="${timeList.timeId}_yyyy" name="yyyy" value="${TraningNoteVO.yyyy}"/> 
				<input type="hidden" id="${timeList.timeId}_term" name="term" value="${TraningNoteVO.term}"/> 
				<input type="hidden" id="${timeList.timeId}_subjectCode" name="subjectCode" value="${TraningNoteVO.subjectCode}"/> 
				<input type="hidden" id="${timeList.timeId}_subjectClass" name="subjectClass" value="${TraningNoteVO.classId}"/> 
		<%-- 		<input type="hidden" id="${timeList.timeId}_traningStMin" name="traningStMin" value="00"/> 
				<input type="hidden" id="${timeList.timeId}_traningEdMin" name="traningEdMin" value="00"/>  --%>
				<input type="hidden" id="${timeList.timeId}_ncsUnitName" name="ncsUnitName" /> 
				<input type="hidden" id="${timeList.timeId}_ncsUnitId" name="ncsUnitId" /> 
				<input type="hidden" id="${timeList.timeId}_weekCnt" name="weekCnt" value="${TraningNoteVO.weekCnt}"/> 
								<tr>
									<td>
										${TraningNoteVO.weekCnt}주차
									</td>
									<td>
									<input type="text" name="traningDate" value="${timeList.traningDate}" id="${timeList.timeId}_traningDate" style="width: 85%;"> 
									</td>
									<td>
										<label for="${timeList.timeId}_traningStHour" class="hidden">시작시간 선택</label>
										<select name="traningStHour" id="${timeList.timeId}_traningStHour">
										    <option value="">선택</option>
										    <option value="01" ${timeList.traningStHour eq '01' ? 'selected' : ''}>오전 1시</option>
										    <option value="02" ${timeList.traningStHour eq '02' ? 'selected' : ''}>오전 2시</option>
										    <option value="03" ${timeList.traningStHour eq '03' ? 'selected' : ''}>오전 3시</option>
										    <option value="04" ${timeList.traningStHour eq '04' ? 'selected' : ''}>오전 4시</option>
										    <option value="05" ${timeList.traningStHour eq '05' ? 'selected' : ''}>오전 5시</option>
										    <option value="06" ${timeList.traningStHour eq '06' ? 'selected' : ''}>오전 6시</option>
										    <option value="07" ${timeList.traningStHour eq '07' ? 'selected' : ''}>오전 7시</option>
										    <option value="08" ${timeList.traningStHour eq '08' ? 'selected' : ''}>오전 8시</option>
											<option value="09" ${timeList.traningStHour eq '09' ? 'selected' : ''}>오전 9시</option>
											<option value="10" ${timeList.traningStHour eq '10' ? 'selected' : ''}>오전 10시</option>
											<option value="11" ${timeList.traningStHour eq '11' ? 'selected' : ''}>오전 11시</option>
											<option value="12" ${timeList.traningStHour eq '12' ? 'selected' : ''}>오전 12시</option>
											<option value="13" ${timeList.traningStHour eq '13' ? 'selected' : ''}>오후 1시</option>
											<option value="14" ${timeList.traningStHour eq '14' ? 'selected' : ''}>오후 2시</option>
											<option value="15" ${timeList.traningStHour eq '15' ? 'selected' : ''}>오후 3시</option>
											<option value="16" ${timeList.traningStHour eq '16' ? 'selected' : ''}>오후 4시</option>
											<option value="17" ${timeList.traningStHour eq '17' ? 'selected' : ''}>오후 5시</option>
											<option value="18" ${timeList.traningStHour eq '18' ? 'selected' : ''}>오후 6시</option>
											<option value="19" ${timeList.traningStHour eq '19' ? 'selected' : ''}>오후 7시</option>
											<option value="20" ${timeList.traningStHour eq '20' ? 'selected' : ''}>오후 8시</option>
											<option value="21" ${timeList.traningStHour eq '21' ? 'selected' : ''}>오후 9시</option>
											<option value="22" ${timeList.traningStHour eq '22' ? 'selected' : ''}>오후 10시</option>
											<option value="23" ${timeList.traningStHour eq '23' ? 'selected' : ''}>오후 11시</option>
											<option value="24" ${timeList.traningStHour eq '24' ? 'selected' : ''}>오후 12시</option>
										</select>
										&nbsp;&nbsp;
										<label for="${timeList.timeId}_traningStMin" class="hidden">시작분 선택</label>
										<select name="traningStMin" id="${timeList.timeId}_traningStMin">
										    <option value="00" ${timeList.traningStMin eq '00' ? 'selected' : ''}>00분</option>
											<option value="30" ${timeList.traningStMin eq '30' ? 'selected' : ''}>30분</option>
										</select>
									</td>
									<td>
										<label for="${timeList.timeId}_traningEdHour" class="hidden">종료시간 선택</label>
										<select name="traningEdHour" id="${timeList.timeId}_traningEdHour">
											<option value="">선택</option>
											<option value="01" ${timeList.traningEdHour eq '01' ? 'selected' : ''}>오전 1시</option>
										    <option value="02" ${timeList.traningEdHour eq '02' ? 'selected' : ''}>오전 2시</option>
										    <option value="03" ${timeList.traningEdHour eq '03' ? 'selected' : ''}>오전 3시</option>
										    <option value="04" ${timeList.traningEdHour eq '04' ? 'selected' : ''}>오전 4시</option>
										    <option value="05" ${timeList.traningEdHour eq '05' ? 'selected' : ''}>오전 5시</option>
										    <option value="06" ${timeList.traningEdHour eq '06' ? 'selected' : ''}>오전 6시</option>
											<option value="07" ${timeList.traningEdHour eq '07' ? 'selected' : ''}>오전 7시</option>
											<option value="08" ${timeList.traningEdHour eq '08' ? 'selected' : ''}>오전 8시</option>
											<option value="09" ${timeList.traningEdHour eq '09' ? 'selected' : ''}>오전 9시</option>
											<option value="10" ${timeList.traningEdHour eq '10' ? 'selected' : ''}>오전 10시</option>
											<option value="11" ${timeList.traningEdHour eq '11' ? 'selected' : ''}>오전 11시</option>
											<option value="12" ${timeList.traningEdHour eq '12' ? 'selected' : ''}>오전 12시</option>
											<option value="13" ${timeList.traningEdHour eq '13' ? 'selected' : ''}>오후 1시</option>
											<option value="14" ${timeList.traningEdHour eq '14' ? 'selected' : ''}>오후 2시</option>
											<option value="15" ${timeList.traningEdHour eq '15' ? 'selected' : ''}>오후 3시</option>
											<option value="16" ${timeList.traningEdHour eq '16' ? 'selected' : ''}>오후 4시</option>
											<option value="17" ${timeList.traningEdHour eq '17' ? 'selected' : ''}>오후 5시</option>
											<option value="18" ${timeList.traningEdHour eq '18' ? 'selected' : ''}>오후 6시</option>
											<option value="19" ${timeList.traningEdHour eq '19' ? 'selected' : ''}>오후 7시</option>
											<option value="20" ${timeList.traningEdHour eq '20' ? 'selected' : ''}>오후 8시</option>
											<option value="21" ${timeList.traningEdHour eq '21' ? 'selected' : ''}>오후 9시</option>
											<option value="22" ${timeList.traningEdHour eq '22' ? 'selected' : ''}>오후 10시</option>
											<option value="23" ${timeList.traningEdHour eq '23' ? 'selected' : ''}>오후 11시</option>
											<option value="24" ${timeList.traningEdHour eq '24' ? 'selected' : ''}>오후 12시</option>
										</select> 
										&nbsp;&nbsp;
										<label for="${timeList.timeId}_traningEdMin" class="hidden">시작분 선택</label>
										<select name="traningEdMin" id="${timeList.timeId}_traningEdMin">
										    <option value="00" ${timeList.traningEdMin eq '00' ? 'selected' : ''}>00분</option>
											<option value="30" ${timeList.traningEdMin eq '30' ? 'selected' : ''}>30분</option>
										</select> 
									</td>
									<td><input type="text" name="leadTime" id="${timeList.timeId}_leadTime" value="${timeList.leadTime}"  maxlength="2"></td>
									<td>
										<label for="${timeList.timeId}_ncsUnit" class="hidden">능력단위선택</label>
										<select name="ncsUnit" id="${timeList.timeId}_ncsUnit" >
											<option value="">능력단위선택</option>
											<c:set var="tempStr" value="${TraningNoteVO.yyyy }${TraningNoteVO.term }${TraningNoteVO.subjectCode }${TraningNoteVO.classId }"/>
											 <c:choose>
												<c:when test="${tempStr eq '20204SMZ00801' or tempStr eq '20204SMZ00802' or tempStr eq '20204SMZ00803' }">
													<option value="test|제도심화-급여">제도심화-급여</option>
												</c:when>
												<c:otherwise>
													<c:forEach var="result" items="${nscList}" varStatus="status">
													<c:set var="ncsVal" value="${result.ncsUnitId}|${result.ncsUnitName}"/>
													<c:set var="timeNcsVal" value="${timeList.ncsUnitId}|${timeList.ncsUnitName}"/>
													<option value="${result.ncsUnitId}|${result.ncsUnitName}" ${ncsVal eq timeNcsVal ? 'selected' : ''}>${result.ncsUnitName}</option>
												</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
									</td>
									<td>
										<a href="javascript:fn_updateTime('${timeList.weekId}','${timeList.timeId}');" class="btn-full-gray">수정</a>
										<a href="javascript:fn_deleteTime('${timeList.weekId}','${timeList.timeId}');" class="btn-full-oraange">삭제</a>
									</td>
								</tr>
</form>								
								</c:forEach>
							</tbody>
						</table>
					</div>

	
	<dl id="weekTimeSchedule" style="display: none">
	
	
		<form name="frmTime" id="frmTime"method="post">
			<input type="hidden" id="time_yyyy" name="yyyy" value="${TraningNoteVO.yyyy}"/> 
			<input type="hidden" id="time_term" name="term" value="${TraningNoteVO.term}"/> 
			<input type="hidden" id="time_subjectCode" name="subjectCode" value="${TraningNoteVO.subjectCode}"/> 
			<input type="hidden" id="time_subjectClass" name="subjectClass" value="${TraningNoteVO.classId}"/> 
		<!-- 	<input type="hidden" id="time_traningStMin" name="traningStMin" value="00"/> 
			<input type="hidden" id="time_traningEdMin" name="traningEdMin" value="00"/>  -->
			<input type="hidden" id="time_ncsUnitName" name="ncsUnitName" /> 
			<input type="hidden" id="time_ncsUnitId" name="ncsUnitId" /> 
			
			<div class="learner-training  mt-010 mb-040">
				<div class="table-responsive mt-010">
					<table class="type-2">
						<caption>주차 훈련일 시작시간 종료시간 훈련시간 능력단위 등 정보제공</caption>
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="20%">
							<col width="20%">
							<col width="10%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">주차</th>
								<th scope="col">훈련일</th>
								<th scope="col">시작시간</th>
								<th scope="col">종료시간</th>
								<th scope="col">훈련시간</th>
								<th scope="col">능력단위</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<label for="time_weekCnt" class="hidden">주차선택</label>
									<select name="weekCnt" id="time_weekCnt">
										<c:forEach var="result" items="${weeklist}" varStatus="status">
											<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq TraningNoteVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<label for="time_traningDate" class="hidden">훈련일</label>
									<input type="text" name="traningDate" id="time_traningDate" style="width: 85%;"> 
								</td>
								<td>
								<label for="time_traningStHour" class="hidden">시작시간 선택</label>
								<select name="traningStHour" id="time_traningStHour">
								    <option value="">선택</option>
								    <option value="01">오전 1시</option>
								    <option value="02">오전 2시</option>
								    <option value="03">오전 3시</option>
								    <option value="04">오전 4시</option>
								    <option value="05">오전 5시</option>
								    <option value="06">오전 6시</option>
								    <option value="07">오전 7시</option>
								    <option value="08">오전 8시</option>
									<option value="09">오전 9시</option>
									<option value="10">오전 10시</option>
									<option value="11">오전 11시</option>
									<option value="12">오전 12시</option>
									<option value="13">오후 1시</option>
									<option value="14">오후 2시</option>
									<option value="15">오후 3시</option>
									<option value="16">오후 4시</option>
									<option value="17">오후 5시</option>
									<option value="18">오후 6시</option>
									<option value="19">오후 7시</option>
									<option value="20">오후 8시</option>
									<option value="21">오후 9시</option>
									<option value="22">오후 10시</option>
									<option value="23">오후 11시</option>
									<option value="24">오후 12시</option>
								</select> 
								&nbsp;&nbsp;
								<label for="time_traningStMin" class="hidden">시작분 선택</label>
								<select name="traningStMin" id="time_traningStMin">
								    <option value="00">00분</option>
									<option value="30">30분</option>
								</select> 
								</td>
								<td>
								<label for="time_traningEdHour" class="hidden">종료시간 선택</label>
								<select name="traningEdHour" id="time_traningEdHour">
									<option value="">선택</option>
									<option value="01">오전 1시</option>
								    <option value="02">오전 2시</option>
								    <option value="03">오전 3시</option>
								    <option value="04">오전 4시</option>
								    <option value="05">오전 5시</option>
								    <option value="06">오전 6시</option>
									<option value="07">오전 7시</option>
									<option value="08">오전 8시</option>
									<option value="09">오전 9시</option>
									<option value="10">오전 10시</option>
									<option value="11">오전 11시</option>
									<option value="12">오전 12시</option>
									<option value="13">오후 1시</option>
									<option value="14">오후 2시</option>
									<option value="15">오후 3시</option>
									<option value="16">오후 4시</option>
									<option value="17">오후 5시</option>
									<option value="18">오후 6시</option>
									<option value="19">오후 7시</option>
									<option value="20">오후 8시</option>
									<option value="21">오후 9시</option>
									<option value="22">오후 10시</option>
									<option value="23">오후 11시</option>
									<option value="24">오후 12시</option>
								</select> 
								&nbsp;&nbsp;
								<label for="time_traningEdMin" class="hidden">시작분 선택</label>
								<select name="traningEdMin" id="time_traningEdMin">
								    <option value="00">00분</option>
									<option value="30">30분</option>
								</select> 
								</td>
								<td>
								<label for="time_leadTime" class="hidden">훈련시간</label>
								<input type="text" name="leadTime" id="time_leadTime"  maxlength="2"> 
								</td>
								<td>
								<label for="time_ncsUnit" class="hidden">능력단위선택</label>
								<select name="ncsUnit" id="time_ncsUnit" >
									<option value="">능력단위선택</option>
									
									<c:set var="tempStr" value="${TraningNoteVO.yyyy }${TraningNoteVO.term }${TraningNoteVO.subjectCode }${TraningNoteVO.classId }"/>
									 <c:choose>
										<c:when test="${tempStr eq '20204SMZ00801' or tempStr eq '20204SMZ00802' or tempStr eq '20204SMZ00803' }">
											<option value="test|제도심화-급여">제도심화-급여</option>
										</c:when>
										<c:otherwise>
											<c:forEach var="result" items="${nscList}" varStatus="status">
												<option value="${result.ncsUnitId}|${result.ncsUnitName}">${result.ncsUnitName}</option>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-area mt-010">
					<div class="float-right">
						<a href="#!" onclick="javascript:fn_insertTime();" class="yellow">저장</a>
					</div>
				</div>
			</div>
		</form>
	</dl>


<c:forEach var="timeList" items="${timeList}" varStatus="status">
 
						<c:if test="${!empty resultSum[status.index].weekId}" >
						<form name="frmTraning${status.index}" id="frmTraning${status.index}" method="post">
							<input type="hidden" id="achievement" name="achievement" />
							<input type="hidden" id="studyDate" name="studyDate" value="${resultSum[status.index].traningDate }"/>
							<input type="hidden" id="startTime" name="startTime" value="${resultSum[status.index].traningDate }"/>
							<input type="hidden" id="finishTime" name="finishTime" value="${resultSum[status.index].traningDate }" />
							<input type="hidden" id="traningStHour" name="traningsthour" value="${resultSum[status.index].traningStHour }"/>
							<input type="hidden" id="traningStMin" name="TraningStMin" value="${resultSum[status.index].traningStMin }"/>
							<input type="hidden" id="traningEdHour" name="traningEdHour" value="${resultSum[status.index].traningEdHour }"/>
							<input type="hidden" id="traningEdMin" name="traningEdMin" value="${resultSum[status.index].traningEdMin }"/>
							<input type="hidden" id="planTime" name="planTime" value="${resultSum[status.index].timeHour}" />
							<input type="hidden" id="weekId" name="weekId" value="${resultSum[status.index].weekId}"/>
							<input type="hidden" id="timeId" name="timeId" value="${resultSum[status.index].timeId}"/>
							<input type="hidden" id="weekCntId${status.index}" name="weekCnt" value="${TraningNoteVO.weekCnt}"/>
							<input type="hidden"   name="addyn" value="N"/>
							<input type="hidden"   name="classId" value="${TraningNoteVO.classId}" />
							<input type="hidden" id="state" name="state" value="W" />
							<input type="hidden" id="traningType" name="traningType" value="OJT" />  
							
							
							<div class="sub_text blue_text mt-040">
 								 <i class="xi-label"></i> 정규수업 : ${resultSum[status.index].traningDate}(${resultSum[status.index].dayOfWeek}) ${resultSum[status.index].traningSt}~${resultSum[status.index].traningEd} (${resultSum[status.index].timeHour}시간) / ${resultSum[status.index].ncsUnitName}
 							</div>	
							
							<div class="table-responsive mt-010">
								<table class="type-2">
								<caption>학번 성명 훈련시간 성취도 온라인 비고 (교육 중 특이사항 등) 등 정보제공</caption>
									<colgroup>										
											<col width="15%" />
											<col width="15%" />
											<col width="15%" />
											<col width="15%" />
											<col width="10%" />
											<col width="20%" />
											<col width="10%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">학번</th>
											<th scope="col">성명</th>
											<th scope="col">훈련시간</th>
											<th scope="col">성취도</th>
											<th scope="col">온라인</th>
											<th scope="col">비고 (교육 중 특이사항 등)</th>
											<th scope="col">상태</th>	
										</tr>
									</thead>
									<tbody>
										<c:set var="rowNum" value="${fn:length(resultlistSum[status.index])}"/>
										<c:forEach var="resultlist" items="${resultlistSum[status.index]}" varStatus="statuslist">
										<tr>											
											<td>${resultlist.memId} <input type="hidden" name="memIdArr" id="memIdArr" value="${resultlist.memId}"><input type="hidden" id="traniningNoteDetailIdArr1" name="traniningNoteDetailIdArr" value="${resultlist.traniningNoteDetailId}" /><input type="hidden" id="" name="traniningNoteMasterIdArr" value="${resultlist.traniningNoteMasterId}" /></td>
											<td>${resultlist.memName} <input type="hidden" name="memNmArr" id="memNmArr" value="${resultlist.memName}">  </td>
											<td>
												<label for="studyTimeArr" class="hidden">훈련시간</label>
												<c:if test="${!empty resultlist.studyTime }" >
												<input type="text" id="studyTimeArr" name="studyTimeArr" style="width:95%;" onchange="javascript:studyTimeArrZeor(this.value,'${resultSum[status.index].timeHour}','${resultlist.memId}','${status.index+1}');" value="${resultlist.studyTime}"/>
												</c:if>
												<c:if test="${empty resultlist.studyTime }" >
												<input type="text" id="studyTimeArr" name="studyTimeArr" style="width:95%;" onchange="javascript:studyTimeArrZeor(this.value,'${resultSum[status.index].timeHour}','${resultlist.memId}','${status.index+1}');"  value="${resultSum[status.index].timeHour}"/>
												</c:if>
											</td>		
											
																 
								<script type="text/javascript">
								<!--
								$(function() {
										$('#${resultlist.memId}result${status.index+1}').raty({ 
											cancel :true,
											<c:if test="${!empty resultlist.traniningNoteMasterId}">
											score: ${resultlist.achievement},
											</c:if>
											<c:if test="${empty resultlist.traniningNoteMasterId}">
											score:5,
											</c:if>												
											path : "/images/oklms/std/inc" 
										});
								});	
								//--> 
								</script>
											<td class="result${status.index+1}" id="${resultlist.memId}result${status.index+1}"></td>																															
											<td>${resultlist.attendProgress}%</td>
											<td><label for="name-bigoArr" class="hidden">비고 (교육 중 특이사항 등</label><input type="text" style="width:100%;" name="bigoArr" id="name-bigoArr" value="${resultlist.bigo}"/></td>
											<c:if test="${statuslist.index eq '0'}">
											<td rowspan="${rowNum}">
											<c:choose>
												<c:when test="${resultlist.status eq '1'}"><span class="label gray">승인대기</span></c:when>
												<c:when test="${resultlist.status eq '2'}"><span class="label blue">승인</span></c:when>
												<c:when test="${resultlist.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnNoteComment" data-comment="${resultlist.returnComment}" rel="modal:open">반려</a></span></c:when>
											</c:choose>
											</td>
											</c:if>
										</tr>
										</c:forEach>
										<%-- <c:if test="${resultlist.state eq 'X' or resultlist.state eq 'R'}">
											<tr>
												<th>반려사유</th>
												<td colspan="5" class="left">${resultSum[status.index].returnComment}</td>
											</tr>
										</c:if> --%>
										<tr>
											<th scope="row">총평</th>
											<td colspan="6" class="left"><textarea name="review" id="review${status.index}" rows="5" >${resultSum[status.index].review}</textarea></td>
										</tr>
									</tbody>
								</table>		
							</div>
							
							<div class="btn-area align-center mt-010">
								<c:choose>
									<c:when test="${resultlist.status eq '2'}"><a href="javascript:alert('승인 이후에는 수정이 불가능합니다.')" class="yellow">저장</a></c:when>
									<c:otherwise><a href="#!" class="yellow" onclick="fn_insert('${status.index}');">저장</a></c:otherwise>
								</c:choose>  
							</div>
						<!-- E : 정규수업 -->
					</form>
							
							</c:if>
</c:forEach>							

 
 <c:set var="maxNum" value="0" />
  <c:forEach var="TraningEnrichmentTimeVO" items="${TraningEnrichmentTimeVO}" varStatus="statustop">
 <c:set var="maxNum" value="${statustop.index+1}" /> 
  <dl  id="regular${statustop.index}" >
<form name="frmTraningEnrichment${statustop.index}" id="frmTraningEnrichment${statustop.index}" method="post" >

										<input type="hidden" id="achievementEnrichment" name="achievementEnrichment" />
										<input type="hidden" id="state" name="state" value="W" />
										<input type="hidden" id="startTime" name="startTime" value="${TraningRegularTimeVO.traningDate }"/>
										<input type="hidden" id="finishTime" name="finishTime" value="${TraningRegularTimeVO.traningDate }" />
										<input type="hidden" id="planTime" name="planTime" value="${TraningRegularTimeVO.timeHour}" />
										<input type="hidden" id="weekId" name="weekId" value="${TraningNoteVO.weekId}"/>
										<input type="hidden" id="timeId" name="timeId" value="${TraningEnrichmentTimeVO.timeId}"/>
										<input type="hidden" name="weekCnt" value="${TraningNoteVO.weekCnt}" />
										<input type="hidden" id="memId" name="memId"/>
										<input type="hidden" id="traniningNoteDetailId${statustop.index}" name="traniningNoteDetailId"  />
										<input type="hidden" id="traniningNoteMasterId${statustop.index}" name="traniningNoteMasterId" value="${TraningEnrichmentTimeVO.traniningNoteMasterId}"/>			
										<input type="hidden"   name="classId" value="${TraningNoteVO.classId}" />
								<dt>
									<div class="sub_text blue_text mt-040">
 								 		<i class="xi-label"></i>  보강훈련 
 								 	</div>
								 </dt>
								<dd style="display:block;">
									<div class="mt-010 mb-020">
									<label for="startDate" class="hidden">날짜</label>
									<input type="text" name="studyDate" id="startDate" value="${TraningEnrichmentTimeVO.traningDate}"  style="width:75px;" />
								시작 :
								<label for="nametraningStHour" class="hidden">시</label>
								<select name="traningStHour" id="nametraningStHour">
											<option value="09" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '09'}">selected="selected" </c:if>>오전 9시</option>
											<option value="10" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '10'}">selected="selected" </c:if>>오전 10시</option>
											<option value="11" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '11'}">selected="selected" </c:if>>오전 11시</option>
											<option value="12" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '12'}">selected="selected" </c:if>>오전 12시</option>
											<option value="13" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '13'}">selected="selected" </c:if>>오후 1시</option>
											<option value="14" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '14'}">selected="selected" </c:if>>오후 2시</option>
											<option value="15" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '15'}">selected="selected" </c:if>>오후 3시</option>
											<option value="16" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '16'}">selected="selected" </c:if>>오후 4시</option>
											<option value="17" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '17'}">selected="selected" </c:if>>오후 5시</option>
											<option value="18" <c:if test="${TraningEnrichmentTimeVO.traningStHour eq '18'}">selected="selected" </c:if>>오후 6시</option>
									</select>
									<label for="nametraningStMin" class="hidden">분</label>
									<select name="traningStMin" id="nametraningStMin">
										<option value="00"  <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '00'}"> selected="selected" </c:if> >0 분</option>
										<option value="10" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '10'}">selected="selected" </c:if> >10 분</option>
										<option value="20" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '20'}">selected="selected" </c:if>>20 분</option>
										<option value="30" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '30'}">selected="selected" </c:if>>30 분</option>
										<option value="40" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '40'}">selected="selected" </c:if>>40 분</option>
										<option value="50" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '50'}">selected="selected" </c:if>>50 분</option>
									</select> ~
								종료 :
									<label for="nametraningEdHour" class="hidden">시</label>
									<select name="traningEdHour" id=nametraningEdHour">
											<option value="09" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '09'}">selected="selected" </c:if>>오전 9시</option>
											<option value="10" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '10'}">selected="selected" </c:if>>오전 10시</option>
											<option value="11" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '11'}">selected="selected" </c:if>>오전 11시</option>
											<option value="12" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '12'}">selected="selected" </c:if>>오전 12시</option>
											<option value="13" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '13'}">selected="selected" </c:if>>오후 1시</option>
											<option value="14" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '14'}">selected="selected" </c:if>>오후 2시</option>
											<option value="15" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '15'}">selected="selected" </c:if>>오후 3시</option>
											<option value="16" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '16'}">selected="selected" </c:if>>오후 4시</option>
											<option value="17" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '17'}">selected="selected" </c:if>>오후 5시</option>
											<option value="18" <c:if test="${TraningEnrichmentTimeVO.traningEdHour eq '18'}">selected="selected" </c:if>>오후 6시</option>
									</select>
									<label for="nametraningEdMin" class="hidden">분</label>
									<select name="traningEdMin" id="nametraningEdMin">
										<option value="00"  <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '00'}"> selected="selected" </c:if> >0 분</option>
										<option value="10" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '10'}">selected="selected" </c:if> >10 분</option>
										<option value="20" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '20'}">selected="selected" </c:if>>20 분</option>
										<option value="30" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '30'}">selected="selected" </c:if>>30 분</option>
										<option value="40" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '40'}">selected="selected" </c:if>>40 분</option>
										<option value="50" <c:if test="${TraningEnrichmentTimeVO.traningStMin eq '50'}">selected="selected" </c:if>>50 분</option>
									</select>
									</div> 
									
									<div class="table-responsive mt-010">
									<table class="type-2">
										<caption>학번 성명 훈련시간 성취도 비고 (교육 중 특이사항 등) 등 정보제공</caption>
										<colgroup>
											<col width="15%" />
											<col width="15%" />
											<col width="8%" />
											<col width="20%" />
											<col width="*" />
											<col width="10%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="row">학번</th>
												<th scope="row">성명</th>
												<th scope="row">훈련시간</th>
												<th scope="row">성취도</th>
												<th scope="row">보강비고 (교육 중 특이사항 등)</th>
												<th scope="row">삭제</th>
											</tr>
										</thead>
<c:set var="memSeqs" value="" />
<c:set var="memIds" value="" />
<c:set var="memNames" value="" />
										<tbody  id="regularTr${statustop.index}">

											<c:forEach var="resultlist" items="${TraningNoteList2[statustop.index]}" varStatus="status">
											<c:set var="memSeqs" value="${memSeqs},${resultlist.memSeq}" />
											<c:set var="memIds" value="${memIds},${resultlist.memId}" />
											<c:set var="memNames" value="${memNames},${resultlist.memName}" />											
											<input type="hidden" id="" name="traniningNoteDetailIdArr" value="${resultlist.traniningNoteDetailId}" />
											<input type="hidden" id="" name="traniningNoteMasterIdArr" value="${resultlist.traniningNoteMasterId}" />											
											<tr id="${statustop.index}tr${status.index}">
												<td>${resultlist.memId} <input type="hidden" name="memIdArr" id="memIdArr" value="${resultlist.memId}"></td>
												<td>${resultlist.memName} <input type="hidden" name="memNmArr" id="memNmArr" value="${resultlist.memName}">  </td>
												<td><label for="studyTimeArr" class="hidden">훈련시간</label><input type="text" style="width:95%;" name="studyTimeArr" id="studyTimeArr" value="${resultlist.studyTime}"/></td>
									<script type="text/javascript">
									<!--
									$(function() {
											$('#${resultlist.memId}resultEnrich${status.index+1}').raty({ 
												cancel :true,
												score: ${resultlist.achievement},
												path : "/images/oklms/std/inc" 
											});
									});	
									//--> 
									</script>												
												<td   id="${resultlist.memId}resultEnrich${status.index+1}"></td>	
												<td class="left"><input type="text" style="width:95%;" name="bigoArr" value="${resultlist.bigo}"/></td>
												<td><a href="#" onclick="removeMember('${statustop.index}','${resultlist.traniningNoteDetailId}' , '${resultlist.traniningNoteMasterId}');removeMemberHtml('${statustop.index}','tr${status.index}');" >삭제</a>  </td>
											</tr>
											</c:forEach>
											<input type="hidden" name="traningNoteMemberSeqs" id="traningNoteMemberSeqs${statustop.index}"  value="${memSeqs}" />
											<input type="hidden" name="traningNoteMemberIds" id="traningNoteMemberIds${statustop.index}"  value="${memIds}" />
											<input type="hidden" name="traningNoteMemberNames" id="traningNoteMemberNames${statustop.index}"  value="${memNames}" />											 
											<tr>
												<th scope="col">보강총평</th>
												<td colspan="5" class="left"><textarea name="review" rows="6">${TraningEnrichmentTimeVO.review}</textarea></td>
											</tr>
										</tbody>
									</table>
 									<div class="btn-area align-center mt-010">
										<a href="#!" class="black" onclick="javascript:fn_memberpage('${statustop.index}');">학습근로자 추가</a>
										<a href="#!" onclick="javascript:fn_insertEnrichment('${statustop.index}');" class="black">저장</a>
									</div>
									 
								</dd>
</form>
							</dl><!-- E : 보강수업 -->
  </c:forEach> 							  
   <dl  id="regular" >
  </dl>
  	<!-- 
  									<div class="btn-area align-right mt-010">
										<a href="#!" class="orange" onclick="showRegular('${maxNum}');">보강훈련 추가</a>
									</div> 
  -->
 						
				
<ul id="student-popup">
	<li class="student-area" id="traningNoteMemberList" >

	</li>
	<li class="popup-bg"></li>
</ul><!-- E : student-popup --> 	
  

						</div> 

 