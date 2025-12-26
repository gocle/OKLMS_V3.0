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
 						<h2>훈련일지(고숙련)</h2>
						<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
						<script type="text/javascript" src="/js/oklms/iscroll.js"></script>
						<script type="text/javascript" src="/js/jquery/jquery.raty.js"></script>
<script type="text/javascript">
<!--
$(document).ready(function() {
	
	com.datepickerDateFormat('startDate');

});

var tempListSeq="";
var listSeq="";
var listName="";
var listMemId="";
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
	
	var reqUrl = "/lu/traning/listTraningNote.do";
 
	$("#frmTraning").attr("target", "_self");
	$("#frmTraning").attr("action", reqUrl);
	$("#frmTraning").submit();

}
/* var myScroll;

function loaded() {
	myScroll = new iScroll('wrap', {
		snap: true,
		momentum: false,
		hScrollbar: false,
	});
}

document.addEventListener('DOMContentLoaded', loaded, false); */

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

function fn_search(classId,companyId){
	
	$("#classId").val(classId);
	$("#companyId").val(companyId);
	
	var reqUrl = "/lu/traning/listTraningNote.do";
 
	$("#frmTraning").attr("target", "_self");
	$("#frmTraning").attr("action", reqUrl);
	$("#frmTraning").submit();

}

function fn_approval( status ){
	
	var checkedVals = $("input:checkbox[name=traniningNoteMasterIds]:checked").length;
	
	if(checkedVals == 0){
		alert("처리 대상을 선택하세요.");
		return;
	}
	
	if( status == "3" ){
		if( $("#comment").val() == "" ){
			alert("반려사유를 입력하세요.");
			$("#comment").focus();
			return;
		}
	} else {
		$("#comment").val("");
	}
	$("#returnComment").val($("#comment").val());
	$("#status").val(status);
	var reqUrl = "/lu/traning/saveTraningNote.do";
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

						<%-- <ul id="learner-wrap" class="mb-010">
							<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
							<li id="wrap">
								<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
								<div id="scroller" style="width:${fn:length(subjectNameList)*128}px;">
									<ul id="thelist" class="name-tab-btn">
									<c:forEach var="result" items="${subjectNameList}" varStatus="status">
										<li <c:if test="${result.classId eq TraningNoteVO.classId }">  class="current" </c:if> >
											<a href="#!" onclick="javascript:fn_search('${result.classId}','${result.companyId }')">${result.classId}분반_${result.companyName }</a>
										</li>

										<c:if test="${result.companyId eq TraningNoteVO.companyId }">
											<c:set var="prevCompany" value="${tempCompany}"/>
											<c:set var="prevClass" value="${tempClass }"/>
											
											<c:if test="${status.first}">
												<c:set var="prevCompany" value="${subjectNameList[0].companyId }"/>
												<c:set var="prevClass" value="${subjectNameList[0].classId}"/>
											</c:if>	
											<c:if test="${!status.last}">
												<c:set var="nextCompany" value="${subjectNameList[status.index+1].companyId}"/>
												<c:set var="nextClass" value="${subjectNameList[status.index+1].classId}"/>
											</c:if>
											<c:if test="${status.last}">
												<c:set var="nextCompany" value="${subjectNameList[0].companyId }"/>
												<c:set var="nextClass" value="${subjectNameList[0].classId}"/>
											</c:if>											
										</c:if>
										<c:if test="${empty prevCompany }">
											<c:set var="tempCompany" value="${result.companyId }"/>
											<c:set var="tempClass" value="${result.classId}"/>									
										</c:if>		

										
									</c:forEach>
									</ul>
								</div>
							</li>
							<li id="next" onclick="myScroll.scrollToPage('next', 0);return false">next</li>
						</ul><!-- E : learner-wrap --> --%>

						
						<%-- 
			<ul id="learner-wrap" class="mb-010">
				<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
				<li id="wrap">
					<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
					<div id="scroller" style="width:${fn:length(subjectNameList)*128}px;">
						<ul id="thelist" class="name-tab-btn">
						<c:forEach var="result" items="${subjectNameList}" varStatus="status">
							<li <c:if test="${ result.classId eq TraningNoteVO.classId }">  class="current" </c:if> >
								<a href="#!" onclick="javascript:fn_search('${result.classId}','${result.companyId }')">${result.classId}분반_${result.companyName }</a>
							</li>

							<c:if test="${result.companyId eq TraningNoteVO.companyId }">
								<c:set var="prevCompany" value="${tempCompany}"/>
								<c:set var="prevClass" value="${tempClass }"/>
								
								<c:if test="${status.first}">
									<c:set var="prevCompany" value="${subjectNameList[0].companyId }"/>
									<c:set var="prevClass" value="${subjectNameList[0].classId}"/>
								</c:if>	
								<c:if test="${!status.last}">
									<c:set var="nextCompany" value="${subjectNameList[status.index+1].companyId}"/>
									<c:set var="nextClass" value="${subjectNameList[status.index+1].classId}"/>
								</c:if>
								<c:if test="${status.last}">
									<c:set var="nextCompany" value="${subjectNameList[0].companyId }"/>
									<c:set var="nextClass" value="${subjectNameList[0].classId}"/>
								</c:if>											
							</c:if>
							<c:if test="${empty prevCompany }">
								<c:set var="tempCompany" value="${result.companyId }"/>
								<c:set var="tempClass" value="${result.classId}"/>									
							</c:if>		

							
						</c:forEach>
						</ul>
					</div>
				</li>
				<li id="next" onclick="myScroll.scrollToPage('next', 0);return false">next</li>
			</ul><!-- E : learner-wrap -->
			 --%>
			 
			<div class="group-area name-tab-content">
				<div class="group-area-title">
					<h4><span>${TraningNoteVO.subjectName} / ${TraningNoteVO.subjectCode }</span> (${TraningNoteVO.classId }분반_${TraningNoteVO.companyName})ㅣ ${TraningNoteVO.yyyy}학년도 ${TraningNoteVO.termName} </h4>
										
					<!--  분반 검색 -->
					<p><a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">개설교과 분반 검색 <i class="xi-search"></i></a></p>

					<!--  분반 모달창 -->
					<div id="learner-wrap_area" class="modal">
						<div class="modal-title">개설교과 분반 검색 </div>
						<div class="modal-body">
							<!--  분반 검색 -->
							<div class="search_box"> 
								<fieldset>
								<legend>게시물 검색</legend>
									<label for="class_searchKeyword" class="hidden">검색</label>
									<input id="class_searchKeyword" name="searchKeyword"  title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
									<button class="btn btn-black btn-sch">검색</button> 
								</fieldset>
							 </div>
							
							<!--  분반 검색 결과 및 리스트 -->
							<div id="learner-wrap_box">
								<ul id="learner-wrap" >
									<li id="wrap">
										<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
										<div id="scroller" style="width:${fn:length(subjectNameList)*128}px;">
											<ul id="thelist" class="name-tab-btn">
											<c:forEach var="result" items="${subjectNameList}" varStatus="status">
												<li <c:if test="${ result.classId eq TraningNoteVO.classId }">  class="current" </c:if> >
													<a href="#!" onclick="javascript:fn_search('${result.classId}','${result.companyId }')">${result.classId}분반_${result.companyName }</a>
												</li>
		
												<c:if test="${result.companyId eq TraningNoteVO.companyId }">
													<c:set var="prevCompany" value="${tempCompany}"/>
													<c:set var="prevClass" value="${tempClass }"/>
													
													<c:if test="${status.first}">
														<c:set var="prevCompany" value="${subjectNameList[0].companyId }"/>
														<c:set var="prevClass" value="${subjectNameList[0].classId}"/>
													</c:if>	
													<c:if test="${!status.last}">
														<c:set var="nextCompany" value="${subjectNameList[status.index+1].companyId}"/>
														<c:set var="nextClass" value="${subjectNameList[status.index+1].classId}"/>
													</c:if>
													<c:if test="${status.last}">
														<c:set var="nextCompany" value="${subjectNameList[0].companyId }"/>
														<c:set var="nextClass" value="${subjectNameList[0].classId}"/>
													</c:if>											
												</c:if>
												<c:if test="${empty prevCompany }">
													<c:set var="tempCompany" value="${result.companyId }"/>
													<c:set var="tempClass" value="${result.classId}"/>									
												</c:if>		
											</c:forEach>
											</ul>
										</div>
									</li>
								</ul><!-- E : learner-wrap -->
							</div>
						</div>
					</div>
					<!--  //분반 모달창 -->
					<!--  //분반 검색 -->
				</div>
						
<form name="frmTraning" id="frmTraning" method="post">
				<input type="hidden" id="classId" name="classId" value="${TraningNoteVO.classId}" />
				<input type="hidden" id="companyId" name="companyId" value="${TraningNoteVO.companyId}" />
				<input type="hidden" id="status" name="status" value="" />
				<input type="hidden" id="returnComment" name="returnComment" value="" />
						
							
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
									<dl class="class-cont">
										<dt>능력단위요소</dt>
										<dd>${TraningNoteVO.ncsElemName}</dd>
									</dl>
									<dl class="class-cont">
										<dt>수업내용</dt>
										<dd>${TraningNoteVO.lessonCn}</dd>
									</dl>
								</div>
							</div>

							<%-- 
							<table class="type-1-1 mb-030">
								<colgroup>
									<col style="width:60px" />
									<col style="width:150px" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:70px" />
								</colgroup>
								<thead>
									<tr>
										<th>주차</th>
										<th>기간</th>
										<th>능력단위</th>
										<th>능력단위요소</th>
										<th>수업내용</th>
										<th>주간<br />훈련시간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<select id="weekCnt" name="weekCnt" onchange="javascript:fn_search('${TraningNoteVO.classId}','${TraningNoteVO.companyId}');">
												<c:forEach var="result" items="${weeklist}" varStatus="status">
												<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq TraningNoteVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
												</c:forEach>
											</select>											
										</td>
										<td>${TraningNoteVO.traningStDate} ~ ${TraningNoteVO.traningEndDate}</td>
										<td>${TraningNoteVO.ncsUnitName}</td>
										<td>${TraningNoteVO.ncsElemName}</td>
										<td class="left">${TraningNoteVO.lessonCn}</td>
										<td>${TraningNoteVO.timeHour}</td>

									</tr>
								</tbody>
							</table>
 							--%>


							<div class="learner-training">
<c:forEach var="timeList" items="${timeList}" varStatus="status">
 
						<c:if test="${!empty resultSum[status.index].weekId}" >
							<div class="sub_text blue_text mt-040">
 								 <i class="xi-label"></i> 정규수업 : 
 								 ${resultSum[status.index].traningDate}(${resultSum[status.index].dayOfWeek}) ${resultSum[status.index].traningSt}~${resultSum[status.index].traningEd} (${resultSum[status.index].timeHour}시간)  ${result.traniningNoteMasterId } 
 							</div>

							<div style="display:block;">
								<c:forEach var="resultlist" items="${resultlistSum[status.index]}" varStatus="statuslist">
									<div class="table-responsive mt-010">
									<table class="type-2">
										<caption>학번 성명 훈련시간 성취도 비고 (교육 중 특이사항 등) 등 정보제공</caption>
										<colgroup>				
												<col width="5%" />						
												<col width="10%" />
												<col width="10%" />
												<col width="7%" />
												<col width="15%" />
												<col width="*" />
												<col width="10%" />
												<col width="8%" />
												<col width="20%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">선택</th>
												<th scope="col">학번</th>
												<th scope="col">성명</th>
												<th scope="col">훈련시간</th>
												<th scope="col">성취도</th>
												<th scope="col">비고 (교육 중 특이사항 등)</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											
											<tr>											
												
												<td>
													<label for="traniningNoteMasterIds" class="hidden">선택</label>
													<input type="checkbox" id="traniningNoteMasterIds" name="traniningNoteMasterIds" value="${resultlist.traniningNoteMasterId}" ${empty resultlist.traniningNoteMasterId ? 'disabled' : ''}  class="choice" />
												</td>
												<td>${resultlist.memId} <input type="hidden" name="memIdArr" id="memIdArr" value="${resultlist.memId}"><input type="hidden" id="traniningNoteDetailIdArr1" name="traniningNoteDetailIdArr" value="${resultlist.traniningNoteDetailId}" /><input type="hidden" id="" name="traniningNoteMasterIdArr" value="${resultlist.traniningNoteMasterId}" /></td>
												<td>${resultlist.memName} <input type="hidden" name="memNmArr" id="memNmArr" value="${resultlist.memName}">  </td>
												<td>
													<%-- <c:if test="${!empty resultlist.studyTime }" >
													<input type="text" id="studyTimeArr" name="studyTimeArr" style="width:95%;" onchange="javascript:studyTimeArrZeor(this.value,'${resultSum[status.index].timeHour}','${resultlist.memId}','${status.index+1}');" value="${resultlist.studyTime}"/>
													</c:if>
													<c:if test="${empty resultlist.studyTime }" >
													<input type="text" id="studyTimeArr" name="studyTimeArr" style="width:95%;" onchange="javascript:studyTimeArrZeor(this.value,'${resultSum[status.index].timeHour}','${resultlist.memId}','${status.index+1}');"  value="${resultSum[status.index].timeHour}"/>
													</c:if> --%>
													<c:if test="${!empty resultlist.studyTime }" >
													${resultlist.studyTime}
													</c:if>
													<c:if test="${empty resultlist.studyTime }" >
													${resultSum[status.index].timeHour}
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
												<%-- <td class="left"><input type="text" style="width:95%;" name="bigoArr" value="${resultlist.bigo}"/></td> --%>
												<td class="left">${resultlist.bigo}</td>
												<td>
												<%-- <c:choose>
													<c:when test="${resultlist.status eq '1'}">승인대기</c:when>
													<c:when test="${resultlist.status eq '2'}">승인</c:when>
													<c:when test="${resultlist.status eq '3'}">반려</c:when>
												</c:choose> --%>
												<c:choose>
													<c:when test="${resultlist.status eq '1'}"><span class="label gray">승인대기</span></c:when>
													<c:when test="${resultlist.status eq '2'}"><span class="label blue">승인</span></c:when>
													<c:when test="${resultlist.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnNoteComment" data-comment="${result.returnComment}" rel="modal:open">반려</a></span></c:when>
												</c:choose>
												</td>
											</tr>
											
											<tr>
												<th scope="row">총평</th>
												<%-- <td colspan="5" class="left"><textarea name="review" id="review${status.index}" rows="5" >${resultSum[status.index].review}</textarea></td> --%>
												<td colspan="6" class="left">${resultlist.review}</td>
											</tr>
										</tbody>
									</table>		
	
									<%-- <div class="btn-area align-center mt-010">
										<a href="#!" class="yellow" onclick="fn_insert('${status.index}');">저장</a>
										<input type="text" id="returnComment" value="" placeholder="반려시 반려사유 필수 입력">
									</div> --%>

					 
								</div>
						<!-- E : 정규수업 -->
			</c:forEach>				
							
							</c:if>
</c:forEach>		

	<!-- <div class="float-right">
		<input type="text" name="returnComment" id="returnComment" placeholder="반려시 반려사유 필수 입력">
		<a href="#" onclick="javascript:fn_approval('3');" class="orange">반려</a>
		<a href="#" onclick="javascript:fn_approval('2');" class="orange">승인</a>
	</div>
 -->
 
 </form>
  
 
  					<div class="btn-area  mt-010">
						<div class="align-right wp100">
							<input type="text" name="comment" id="comment" class="wp50" placeholder="반려시 반려사유 필수 입력">
							<a href="#" onclick="javascript:fn_approval('3');" class="yellow">반려</a>
							<a href="#" onclick="javascript:fn_approval('2');" class="orange">승인</a>
							
								<a href="#!" onclick="javascript:fn_search('${prevClass}','${prevCompany }')" class="gray-1">&lt; 이전 분반</a> 
								<a href="#!" onclick="javascript:fn_search('${nextClass}','${nextCompany }')" class="gray-1">다음 분반 &gt;</a>
						</div>
					</div>
				</div> 

 