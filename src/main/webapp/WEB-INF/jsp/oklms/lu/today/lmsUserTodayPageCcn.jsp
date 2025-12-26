<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>

								<h2 id="f_1">주간훈련일지 미제출기업</h2>
								<div class="group-area mb-030" >
									<div class="table-responsive">
										<table class="type-2">
												<colgroup>
													<col style="width:50px" />
													<col style="width:*" />
													<col style="width:*" />
													<col style="width:50px" />
													<col style="width:100px" />
													<col style="width:100px" />
												</colgroup>
												<tr>
													<th>선택</th>
													<th>기업명</th>
													<th>훈련과정명</th>
													<th>주차</th>
													<th>OJT</th>
													<th>Off-JT</th>
												</tr>
	 
	
												<c:forEach var="result" items="${listWeekTraningNoteCompany}" varStatus="status">
												<tr>
													<td><input type="radio" name="weekTraningNote" value="" class="choice" onclick="javascript:setWeekTraningNote('${result.companyId}','${result.traningProcessId}');" /></td>
													<td>${result.companyName}</td>
													<td><a href="/lu/weektraning/listWeekTraningNoteCcn.do?companyId=${result.companyId}&traningProcessId=${result.traningProcessId}">${result.traningProcessName}</a></td>
													<td>${result.weekCnt}</td>
													<td>
														<c:if test="${result.stateOjt eq 'W'}"><a href="#!"  class="btn-line-orange">미제출</a></c:if>
														<c:if test="${result.stateOjt eq 'I'}"><a href="#!"  class="btn-line-gray">제출</a></c:if>
														<c:if test="${result.stateOjt eq 'X'}"><a href="#!"  class="btn-line-orange">반려</a></c:if>
														<c:if test="${empty result.stateOjt}"><a href="#!"  class="btn-line-orange">미작성</a></c:if>
													</td>
													<td>
														<c:if test="${result.stateOff eq 'W'}"><a href="#!"  class="btn-line-orange">미제출</a></c:if>
														<c:if test="${result.stateOff eq 'I'}"><a href="#!"  class="btn-line-gray">제출</a></c:if>
														<c:if test="${result.stateOff eq 'X'}"><a href="#!"  class="btn-line-orange">반려</a></c:if>
														<c:if test="${empty result.stateOff}"><a href="#!"  class="btn-line-orange">미작성</a></c:if>
													</td>
												</tr>										
												</c:forEach>
												<c:if test="${empty listWeekTraningNoteCompany}">
												<tr>
													<td colspan="6">미제출 기업이 없습니다.</td>
												</tr>
										    	</c:if>	 
	 
										</table>
									</div>
									<div class="btn-area align-right mt-010">
									 
										<p>
										<input type="checkbox" name="cotMemIds" value="cot" class="choice" /> 기업현장교사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="ccmMemIds" value="ccm" class="choice" /> HRD담당자
										</p>
										<a href="#!" onclick="javascript:weekSms();" class="yellow">SMS 발송</a>
							 
										<a href="/lu/weektraning/listWeekTraningNoteCcn.do"  class="orange">열기</a>
									</div><!-- E : btn-area -->
	 							</div>
	 							
	 							<%-- <h2 id="f_2">주차별 학습활동서 미제출자</h2>
								<div class="group-area" >
									<table class="type-2  mb-010 mt-010">
										<thead>
											<tr>
												<th>선택</th>
												<th>기업명</th>
												<th>훈련과정명</th>
												<th>주차</th>
												<th>OJT</th>
												<th>OFF</th>
											</tr>
										</thead>
										<tbody>
										 
											<c:forEach var="result" items="${listWeekActivityNoteCompany}" varStatus="status">
											<tr>
												<td><input type="radio" name="memIdArr" value="${result.memIds}" class="choice" /></td>
												<td>${result.companyName}</td>
												<td><a href="/lu/activity/listActivityHrd.do?yyyy=${result.yyyy }&term=${result.term}&companyId=${result.companyId}&traningProcessId=${result.traningProcessId}">${result.traningProcessName}</a></td>
												<td>${result.weekCnt}</td>
												<td>
													<c:if test="${result.ojtCnt eq result.stateOjt }">
														<c:if test="${result.ojtCnt > 0 }">
															제출
														</c:if> 
													</c:if>
													<c:if test="${result.ojtCnt ne result.stateOjt }">
															${result.stateOjt}/${result.ojtCnt }													
													</c:if>
												</td>
												<td>
													<c:if test="${result.offCnt eq result.stateOff }">
														<c:if test="${result.offCnt > 0 }">
															제출
														</c:if> 											
													</c:if>
													<c:if test="${result.offCnt ne result.stateOff }">
															${result.stateOff}/${result.offCnt }
													</c:if>
												</td>
											</tr>										
											</c:forEach>
											<c:if test="${empty listWeekActivityNoteCompany}">
											<tr>
												<td colspan="6">미제출 기업이 없습니다.</td>
											</tr>
									    	</c:if>

										</tbody>
									</table>
									<div class="btn-area align-right mt-010">
										<a href="#!" onclick="javascript:activitySms()" class="yellow">SMS 발송</a>
										<a href="/lu/activity/listActivityHrd.do"  class="orange">열기</a>
									</div><!-- E : btn-area -->
	 							</div> --%>
				 
								<h2 id="f_3">면담일지 미제출기업</h2>
								<div class="group-area">
									<div class="table-responsive">
									<table class="type-2  mb-010 mt-010">
									<thead>
										<tr>
											<th>선택</th>
											<th>기업명</th>
											<th>훈련과정명</th>
											<th>월</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="listInterviewCcn" items="${listInterviewCcn}" varStatus="status">
										<tr>
											<td><input type="radio" name="InterviewNote" value="" class="choice" onclick="javascript:setWeekTraningNote('${listInterviewCcn.companyId}','${listInterviewCcn.traningProcessId}');" /></td>
											<td>${listInterviewCcn.companyName}</td>
											<td><a href="/lu/interview/listInterviewCenter.do?companyId=${listInterviewCcn.companyId }&traningProcessId=${listInterviewCcn.traningProcessId }&mm=${listInterviewCcn.mm }" class="text">${listInterviewCcn.hrdTraningName }</a></td>
											<td>${listInterviewCcn.mm } 월</td>
										</tr>
									</c:forEach>
 									<c:if test="${empty listInterviewCcn}">
										<tr>
											<td colspan="4">데이터가 없습니다.</td>
										</tr>
									</c:if> 
									</tbody>
									</table>
									</div>
									<div class="btn-area align-right mt-010">
										<p>
										<input type="checkbox" name="interviewcotMemIds" value="cot" class="choice" /> 기업현장교사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="interviewccmMemIds" value="ccm" class="choice" /> HRD담당자
										</p>
										<a href="#!" onclick="javascript:interviewSms();" class="yellow">SMS 발송</a>
										<a href="/lu/interview/listInterviewCenter.do" class="orange">열기</a>
									</div><!-- E : btn-area -->

								</div>

								<h2 id="f_5">담당자 변경신청</h2>
								<div class="group-area">
									<div class="table-responsive">
									<table class="type-2  mb-010 mt-010">
										<thead>
											<tr>
												<th>번호</th>
												<th>기업명</th>
												<th>구분</th>
												<th>성명</th>
												<th>신청내용</th>
											</tr>
										</thead>
										<tbody>

											<c:forEach var="result" items="${listComMemberCcm}" varStatus="status">
											<tr>
												<td>${status.count}</td>
												<td>${result.companyName}</td>
												<td>											
													<c:if test="${result.memtype eq 'CCM'}" >HRD담당자</c:if>
													<c:if test="${result.memtype eq 'COT'}" >기업현장교사</c:if>											
												</td>
												<td>${result.memName}</td>
												<td>
													<c:if test="${result.updtApplicationStatus eq '1'}" >
													<a href="#!" class="btn-full-blue">${result.updtApplicationName}</a>
													</c:if>
													<c:if test="${result.updtApplicationStatus eq '2'}" >
													<a href="#!" class="btn-full-gray">${result.updtApplicationName}</a>													
													</c:if>
												</td>
											</tr>										
											</c:forEach>
											<c:if test="${empty listComMemberCcm}">
											<tr>
												<td colspan="5">변경신청이 없습니다.</td>
											</tr>
									    	</c:if>	 

										</tbody>
									</table>
									</div>
									<div class="btn-area align-right mt-010">
										<a href="/lu/member/listMemberChangeApplication.do"  class="orange">열기</a>
									</div><!-- E : btn-area -->
	 							</div>
	 							
								<h2 id="f_4">훈련시간표 변경신청</h2>
								<div class="group-area">
									<div class="table-responsive">
									<table class="type-2">
										<colgroup>
											<col style="width:50px" />
											<col style="width:*" />
											<col style="width:*" />
											
											<col style="width:100px" />
											<col style="width:100px" />
											<col style="width:*" />
										</colgroup>
										<tr>
											<th>번호</th>
											<th>기업명</th>
											<th>훈련과정명</th>
											
											<th>신청자</th>
											<th>변경신청일</th>
											<th>변경사유</th>
										</tr>
										<c:forEach var="result" items="${listTraningChangeScheduleDisapproved}" varStatus="status">
										
										<tr>
											<td>${status.count}</td>
											<td>${result.companyName}</td>
											<td>${result.hrdTraningName}</td>
											
											<td>${result.memName}</td>
											<td>${result.updateDate}</td>
											<td>${result.changeReason}</td>
										</tr>
																				
										</c:forEach>
										<c:if test="${empty listTraningChangeScheduleDisapproved}">
										<tr>
											<td colspan="6">변경신청이 없습니다.</td>
										</tr>
								    	</c:if>	
									</table>
									</div>
									<div class="btn-area align-right mt-010">
										<a href="/lu/traningChange/listTraningChangeScheduleApplication.do" class="orange">열기</a>
									</div><!-- E : btn-area -->
		
								</div><!-- E : 훈련시간표 변경신청 -->
		
 
 
								
								
 
<script type="text/javascript">
<!--

	
function fn_searchActivity(yyyy,term,subjectCode,classId,weekCnt){
	
	$("#yyyy").val(yyyy);
	$("#term").val(term);
	$("#subjectCode").val(subjectCode);
	$("#classId").val(classId);
	$("#weekCnt").val(weekCnt);
	var reqUrl = "/lu/activity/listActivityStd.do";
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

function setWeekTraningNote(companyId,traningProcessId)
{
	$("#mailCompanyId").val(companyId);
	$("#mailTraningProcessId").val(traningProcessId);
}
function weekSms(){
	 
	if(!$('input:radio[name=weekTraningNote]').is(':checked')){
		alert("선택된 훈련이 없습니다.");
		return;
	} 	
	var cotArr = $("input:checkbox[name=cotMemIds]:checked").val();
	var ccmArr = $("input:checkbox[name=ccmMemIds]:checked").val();
	
	var sumArr = cotArr+ccmArr;	

	if(!sumArr){
		alert("선택된 현장교사 또는 HRD담당자가 없습니다.");
		return false;
	}else{
		$("#cotMemIds").val(cotArr);
		$("#ccmMemIds").val(ccmArr);
	}
	
	fn_sms_cot_company();
}
function interviewSms(){
	 
	if(!$('input:radio[name=InterviewNote]').is(':checked')){
		alert("선택된 훈련이 없습니다.");
		return;
	} 	
	var cotArr = $("input:checkbox[name=interviewcotMemIds]:checked").val();
	var ccmArr = $("input:checkbox[name=interviewccmMemIds]:checked").val();
	
	var sumArr = cotArr+ccmArr;	

	if(!sumArr){
		alert("선택된 현장교사 또는 HRD담당자가 없습니다.");
		return false;
	}else{
		$("#cotMemIds").val(cotArr);
		$("#ccmMemIds").val(ccmArr);
	}
	
	fn_sms_cot_company();
}
function activitySms(){
	
	var obj = document.getElementsByName("memIdArr");
	var temp = 0;
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
              temp++;
         }
    }	
    if(!$('input:radio[name=memIdArr]').is(':checked')){
		alert("선택된 훈련이 없습니다.");
		return;
	} 
	fn_send_sms(0,arr_value,'','AC','');
}


//-->
</script>
<form:form commandName="frmActivity" name="frmActivity" method="post">
					  
<input type="hidden" name="yyyy"  id="yyyy" >
<input type="hidden" name="term"  id="term"  >
<input type="hidden" name="subjectCode"   id="subjectCode"  >
<input type="hidden" name="classId"   id="classId"  >
<input type="hidden" name="weekCnt"   id="weekCnt"  >
</form:form>

<form name="frm" id="frm"  method="post">
<input type="hidden" name="bbsId" value="" />
<input type="hidden" name="nttId"  value="" />
<input type="hidden" name="bbsTyCode" value="BBST01" />
<input type="hidden" name="bbsAttrbCode" value="BBSA03" />
<input type="hidden" name="authFlag" value="" />
<input name="pageIndex" type="hidden" value="1"/>
<input type="hidden" name="memType"  value="STD" />
<input type="hidden" name="lectureMenuMarkYn"  value="N" />
</form>
			