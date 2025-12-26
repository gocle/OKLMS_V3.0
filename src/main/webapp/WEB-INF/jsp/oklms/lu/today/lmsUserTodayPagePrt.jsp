<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
								<h2>TODAY</h2>

								<h3 class="mt-040"><i class="xi-label"></i> 훈련일지 작성</h3>
								<div class="table-responsive">
									<table class="type-2 mt-010  mb-010" >
										<thead>
											<tr>
												<th>번호</th>
												<th>교과구분</th>
												<th>학년</th>
												<th>개설교과명</th>
												<th>주차</th>
											</tr>
										</thead>
										<tbody>
	
										<c:forEach var="listTraningNotePrt" items="${listTraningNotePrt}" varStatus="status">
											<tr>
												<td>${status.count }</td>
												<td>
													<c:if test="${listTraningNotePrt.subjectTraningType eq 'OFF'}">Off-JT</c:if>
													<c:if test="${listTraningNotePrt.subjectTraningType ne 'OFF'}">${listTraningNotePrt.subjectTraningType}</c:if>											
												</td>
												<td>${listTraningNotePrt.schoolYear }</td>
												<td>
													<a href="#!" onclick="javascript:fn_searchTraningNote('${listTraningNotePrt.yyyy }','${listTraningNotePrt.term }','${listTraningNotePrt.subjectCode}','${listTraningNotePrt.subClass}','${listTraningNotePrt.weekCnt}','${listTraningNotePrt.subjectTraningType }');" class="text">
													${listTraningNotePrt.subjectName }
													</a>
												</td>
												<td>${listTraningNotePrt.weekCnt}</td>
											</tr>
										</c:forEach>
										<c:if test="${empty listTraningNotePrt}">
											<tr>
												<td colspan="5">미작성 훈련일지가 없습니다.</td>
											</tr>
										</c:if>	
	
										</tbody>
									</table>
								</div>

								<h3 class="mt-040"><i class="xi-label"></i> Q&A</h3>
								<div class="table-responsive">
									<table class="type-2 mt-010  mb-010" >
										<thead>
											<tr>
												<th>교과명</th>
												<th>제목</th>
												<th>작성자</th>
												<th>등록일</th>
											</tr>
										</thead>
										<tbody>
	
										<c:forEach var="listQnAPrt" items="${listQnAPrt}" varStatus="status">
											<tr>
												<td>${listQnAPrt.subjectName }</td>
												<td>
													<c:choose>
														<c:when test="${listQnAPrt.bbsId eq 'BBSMSTR_000000000007' }">
															<!-- 전체 Q&A -->
															<a href="javascript:fn_searchQna('${listQnAPrt.yyyy}','${listQnAPrt.term}','${listQnAPrt.subjectCode}','${listQnAPrt.subClass}','${listQnAPrt.subjectTraningType }','${listQnAPrt.bbsId}','${listQnAPrt.nttId}','N');">${listQnAPrt.nttSj }</a>
														</c:when>
														<c:otherwise>
															<!-- 진행중 Q&A -->
															<a href="javascript:fn_searchQna('${listQnAPrt.yyyy}','${listQnAPrt.term}','${listQnAPrt.subjectCode}','${listQnAPrt.subClass}','${listQnAPrt.subjectTraningType }','${listQnAPrt.bbsId}','${listQnAPrt.nttId}','Y');">${listQnAPrt.nttSj }</a>
														</c:otherwise>
													</c:choose>
												</td>
												<td>${listQnAPrt.ntcrNm }</td>
												<td>${listQnAPrt.frstRegisterPnttm}</td>
											</tr>
										</c:forEach>
										<c:if test="${empty listQnAPrt}">
											<tr>
												<td colspan="4">답변 대기중인 Q&amp;A가 없습니다.</td>
											</tr>
										</c:if>	
	
										</tbody>
									</table>
								</div>

 								<%-- <ul class="page-sum mb-010 mt-010">
									<li class="float-left" id="f_2">
										학습활동서 확인
									</li>
								</ul>

								<table class="type-2 mt-010  mb-010" >
									<thead>
										<tr>
											<th>선택</th>
											<th>교과구분</th>
											<th>학년</th>
											<th>개설교과명</th>
											<th>주차</th>
											<th>제출현황</th>
										</tr>
									</thead>
									<tbody>

									<c:forEach var="listActivityNotePrt" items="${listActivityNotePrt}" varStatus="status">
										<tr>
											<td><input type="radio" onclick="javascript:setSubjectSmsDate('${listActivityNotePrt.weekCnt}','AC','${listActivityNotePrt.subjectCode}','');" name="memIdArr" value="${listActivityNotePrt.memIds}" class="choice" /></td>
											<td>${listActivityNotePrt.subjectTraningType}</td>
											<td>${listActivityNotePrt.schoolYear}</td>
											<td><a href="#" class="text" onclick="javascript:fn_searchActivity('${listActivityNotePrt.yyyy}','${listActivityNotePrt.term}','${listActivityNotePrt.subjectCode}','${listActivityNotePrt.subClass}','${listActivityNotePrt.weekCnt}');" >${listActivityNotePrt.subjectName}</a></td>
											<td>${listActivityNotePrt.weekCnt}</td>
											<td>${listActivityNotePrt.noteCnt} / ${listActivityNotePrt.memberCnt} 명</td>
										</tr>
									</c:forEach>
 									<c:if test="${empty listActivityNotePrt}">
										<tr>
											<td colspan="6">미작성 훈련일지가 없습니다.</td>
										</tr>
									</c:if>
									</tbody>
								</table>

								<div class="btn-area align-right mt-010">
										<a href="#!" onclick="javascript:activitySms()" class="yellow">미제출자 SMS 발송</a>
								</div>
 								 --%>

								<h3 class="mt-040"><i class="xi-label"></i> 과제 제출현황</h3>
								<div class="table-responsive">
									<table class="type-2 mt-010  mb-010" >
										<thead>
											<tr>
												<th>선택</th>
												<th>개설교과명</th>
												<th>주차</th>
												<th>마감일</th>
												<th>참여현황</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${listReportSubmitPrt}" varStatus="status">
											<tr>
												<td><input type="radio" onclick="javascript:setSubjectSmsDate('${result.weekCnt}','RC','${result.subjectCode}','${result.submitEndDate}');" name="reportMemIdArr" value="${result.memIds}" class="choice" /></td>
												<td><a href="#!" onclick="javascript:fn_searchReport('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subClass}','${result.weekCnt}');" class="text" >${result.subjectName}</a></td>
												<td>${result.weekCnt}</td>
												<td>${result.submitEndDate}</td>
												<td>${result.scoreCnt}/${result.totCnt}명</td>
											</tr>										
											</c:forEach>
											<c:if test="${empty listReportSubmitPrt}">
											<tr>
												<td colspan="5">미제출 과제가 없습니다.</td>
											</tr>
									    	</c:if>
	
										</tbody>
									</table>
								</div>
								
								<div class="btn-area align-right mt-010">
										<a href="#!" onclick="javascript:reportSms()" class="yellow">미제출자 SMS 발송</a>
								</div>

								<h3 class="mt-040"><i class="xi-label"></i> 팀프로젝트 제출현황</h3>
								<div class="table-responsive">
									<table class="type-2 mt-010  mb-010" >
										<thead>
											<tr>
												<th>선택</th>
												<th>개설교과</th>
												<th>팀프로젝트주제</th>
												
												<th>과제제출구분</th>
												<th>제출마감</th>
												<th>제출현황</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${listTeamProjectSubmitPrt}" varStatus="status">
											<tr>
												<td><input type="radio" onclick="javascript:setSubjectSmsDate('0','TC','${result.subjectCode}','${result.projectEndDate}');" name="termMemIdArr" value="${result.memIds}" class="choice" /></td>
												<td><a href="#!" onclick="javascript:fn_searchTeam('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subClass}');" class="text" >${result.subjectName}</a></td>
												<td>${result.projectName}</td>
												
												<td>
													<c:if test="${result.submitType eq 'T'}">
													팀 제출
													</c:if>
													<c:if test="${result.submitType eq 'I'}">
													개별 제출
													</c:if>	
												</td>
												<td>${result.projectEndDate}</td>
												<td>
													<c:if test="${result.submitType eq 'T'}">
													${result.teamScoreCnt}/${result.teamTotCnt}팀
													</c:if>
													<c:if test="${result.submitType eq 'I'}">
													${result.scoreCnt}/${result.totCnt}명
													</c:if>												
												</td>
											</tr>										
											</c:forEach>
											<c:if test="${empty listTeamProjectSubmitPrt}">
											<tr>
												<td colspan="6">미제출 과제가 없습니다.</td>
											</tr>
									    	</c:if>
										</tbody>
									</table>
								</div>

								<div class="btn-area align-right mt-010">
										<a href="#!" onclick="javascript:termprojectSms()" class="yellow">미제출자 SMS 발송</a>
								</div>
								
								
								<!-- OJT 훈련일지  -->
								<h3 class="mt-040 mb-010"><i class="xi-label"></i> OJT 훈련일지</h3>
								<div class="box2">
									<ul class="training_list">
										<li>
											<div class="form_wrap">
												<input class="form-check-input"  type="checkbox" name="" id="" />
											</div>
											<div class="text_wrap">
												<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
												<ul class="text_left">
													<li>분반 : 2</span>
													<li>(주)코아아이티</li>
													<li>주차 : 5/5</li>
													<li>(기업특화)제도기본-유족</li>
												</ul>
												<div class="clearfix"></div>
												<div class="box07 mt-010">
													총평
												</div>
											</div>
										</li>
										
										<li>
											<div class="form_wrap">
												<input class="form-check-input"  type="checkbox" name="" id="" />
											</div>
											<div class="text_wrap">
												<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
												<ul class="text_left">
													<li>분반 : 2</span>
													<li>(주)코아아이티</li>
													<li>주차 : 5/5</li>
													<li>(기업특화)제도기본-유족</li>
												</ul>
												<div class="clearfix"></div>
												<div class="box07 mt-010">
													총평
												</div>
											</div>
										</li>
									</ul>
									
									<div class="btn-area mt-010">
										<div class="float-right">
											<a href="" class="btn btn-black">승인</a>
										</div>
									</div>
								</div>
								<!-- //OJT 훈련일지  -->
								
								
								<!-- OJT 학습활동서  -->
								<h3 class="mt-040 mb-010"><i class="xi-label"></i> OJT 학습활동서</h3>
								<div class="box2">
									<ul class="training_list">
										<li>
											<div class="form_wrap">
												<input class="form-check-input"  type="checkbox" name="" id="" />
											</div>
											<div class="text_wrap">
												<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
												<ul class="text_left">
													<li>분반 : 2</span>
													<li>(주)코아아이티</li>
													<li>주차 : 5/5</li>
													<li>(기업특화)제도기본-유족</li>
												</ul>
												<div class="clearfix"></div>
												<div class="box07 mt-010">
													총평
												</div>
											</div>
										</li>
										
										<li>
											<div class="form_wrap">
												<input class="form-check-input"  type="checkbox" name="" id="" />
											</div>
											<div class="text_wrap">
												<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
												<ul class="text_left">
													<li>분반 : 2</span>
													<li>(주)코아아이티</li>
													<li>주차 : 5/5</li>
													<li>(기업특화)제도기본-유족</li>
												</ul>
												<div class="clearfix"></div>
												<div class="box07 mt-010">
													총평
												</div>
											</div>
										</li>
									</ul>
									
									<div class="btn-area mt-010">
										<div class="float-right">
											<a href="" class="btn btn-black">승인</a>
										</div>
									</div>
								</div>
								<!-- //OJT 학습활동서  -->
								

<script type="text/javascript">
<!--
	
function fn_searchActivity(yyyy,term,subjectCode,classId,weekCnt){
	
	$("#yyyy").val(yyyy);
	$("#term").val(term);
	$("#subjectCode").val(subjectCode);
	$("#classId").val(classId);
	$("#weekCnt").val(weekCnt);
	var reqUrl = "/lu/activity/listActivityPrt.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();				
} 

function fn_egov_inqire_notice( nttId, bbsId) {
	 if(bbsId == "") return false;
	 
	var reqUrl =  "/lu/cop/bbs/"+bbsId+"/selectBoardArticle.do";
	document.frm.nttId.value = nttId;
	document.frm.bbsId.value = bbsId;
	
	$("#frm").attr("action", reqUrl);
	$("#frm").attr("target","_self");
	$("#frm").submit();
}
function fn_searchTraningNote(yyyy,term,subjectCode,classId,weekCnt,subjectTraningType){
	
	$("#yyyy").val(yyyy);
	$("#term").val(term);
	$("#subjectCode").val(subjectCode);
	$("#classId").val(classId);
	$("#weekCnt").val(weekCnt);
	$("#subjectTraningType").val(subjectTraningType);
	
	var reqUrl = "/lu/traning/listTraningNote.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();					
}
function fn_searchReport(yyyy,term,subjectCode,classId,weekCnt){
	
	$("#yyyy").val(yyyy);
	$("#term").val(term);
	$("#subjectCode").val(subjectCode);
	$("#classId").val(classId);
	$("#subClass").val(classId);
	$("#weekCnt").val(weekCnt);
	
	var reqUrl = "/lu/report/listReport.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();				
} 
function fn_searchTeam(yyyy,term,subjectCode,classId){
	
	$("#yyyy").val(yyyy);
	$("#term").val(term);
	$("#subjectCode").val(subjectCode);
	$("#classId").val(classId);
	$("#subClass").val(classId); 
	
	var reqUrl = "/lu/teamproject/listTeamproject.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();				
} 
function setSubjectSmsDate(weekCnt,mailTempType,subjectCode,lastDate){
	$("#mailWeekCnt").val(weekCnt);
	$("#mailTempType").val(mailTempType);
	$("#mailSubjectCode").val(subjectCode);
	$("#mailLastDate").val(lastDate);
}
function activitySms(){
	 
	var obj = document.getElementsByName("memIdArr");
    var arr_value = "";
    var lastDate="";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
         }
    }
    if(!$('input:radio[name=memIdArr]').is(':checked')){
		alert("선택된 교과가 없습니다.");
		return;
	}   
 
	fn_set_sms(arr_value);
}
function reportSms(){
	var obj = document.getElementsByName("reportMemIdArr");
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
         }
    }
    if(!$('input:radio[name=reportMemIdArr]').is(':checked')){
		alert("선택된 교과가 없습니다.");
		return;
	}   
 
	fn_set_sms(arr_value);	

}
function termprojectSms(){
	var obj = document.getElementsByName("termMemIdArr");
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
         }
    }
    if(!$('input:radio[name=termMemIdArr]').is(':checked')){
		alert("선택된 교과가 없습니다.");
		return;
	}   
 
	fn_set_sms(arr_value);	
}

function fn_searchQna(yyyy,term,subjectCode,classId,subjectTraningType,bbsId,nttId,lectureMenuMarkYn){
	
	var reqUrl = "";
	
	$("#frmBoard_yyyy").val(yyyy);
	$("#frmBoard_term").val(term);
	$("#frmBoard_subjectCode").val(subjectCode);
	$("#frmBoard_classId").val(classId);
	$("#frmBoard_subClass").val(classId); 
	$("#frmBoard_subjectTraningType").val(subjectTraningType); 
	$("#frmBoard_bbsId").val(bbsId); 
	$("#frmBoard_nttId").val(nttId); 
	$("#frmBoard_lectureMenuMarkYn").val(lectureMenuMarkYn); 
	
	if(lectureMenuMarkYn == "Y"){
		reqUrl = "/lu/cop/bbs/BBSMSTR_000000000010/selectBoardArticle.do";
	} else {
		reqUrl = "/lu/cop/bbs/BBSMSTR_000000000007/selectBoardArticle.do";
	}
	$("#frmBoard").attr("action", reqUrl);
	$("#frmBoard").attr("target","_self");
	$("#frmBoard").submit();				
}

//-->
</script>
<form:form commandName="frmActivity" name="frmActivity" method="post">
					  
<input type="hidden" name="yyyy"  id="yyyy" >
<input type="hidden" name="term"  id="term"  >
<input type="hidden" name="subjectCode"   id="subjectCode"  >
<input type="hidden" name="classId"   id="classId"  >
<input type="hidden" name="subClass"   id="subClass"  >
<input type="hidden" name="weekCnt"   id="weekCnt" value="0" >
 
<input type="hidden" name="subjectTraningType"   id="subjectTraningType"  >

</form:form>

<form name="frm" id="frm"  method="post">
<input type="hidden" name="bbsId" value="" />
<input type="hidden" name="nttId"  value="" />
<input type="hidden" name="bbsTyCode" value="BBST01" />
<input type="hidden" name="bbsAttrbCode" value="BBSA03" />
<input type="hidden" name="authFlag" value="" />
<input name="pageIndex" type="hidden" value="1"/>
<input type="hidden" name="memType"  value="PRT" />
<input type="hidden" name="lectureMenuMarkYn"  value="N" />
</form>

<form name="frmBoard" id="frmBoard"  method="post">
<input type="hidden" id="frmBoard_yyyy" name="yyyy"    />
<input type="hidden" id="frmBoard_term" name="term"     />
<input type="hidden" id="frmBoard_subjectCode" name="subjectCode"      />
<input type="hidden" id="frmBoard_classId" name="classId"      />
<input type="hidden" id="frmBoard_subClass" name="subClass"     />
<input type="hidden" id="frmBoard_subjectTraningType" name="subjectTraningType"     >
<input type="hidden" id="frmBoard_bbsId" name="bbsId" value="" />
<input type="hidden" id="frmBoard_nttId" name="nttId"  value="" />
<input type="hidden" id="frmBoard_lectureMenuMarkYn" name="lectureMenuMarkYn"  value="" />
<input type="hidden" id="frmBoard_pageIndex" name="pageIndex"  value="1"/>
<input type="hidden" id="frmBoard_memType" name="memType"  value="PRT" />
<input type="hidden" id="frmBoard_todayYn" name="todayYn"  value="Y" />

</form>