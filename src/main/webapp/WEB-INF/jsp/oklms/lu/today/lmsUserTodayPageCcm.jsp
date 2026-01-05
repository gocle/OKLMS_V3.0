<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>


							
		 						<h2 id="f_1">	활동내역서 미작성건</h2>
								<div class="group-area">
									<table class="type-2  mb-010 mt-010">
									<thead>
										<tr>
											<th>번호</th>
											<th>기업명</th>
											<th>훈련과정명</th>
											<th>월</th>
											<th>기업현장교사</th>
											<th>HRD담당자</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="result" items="${listActivityHrd}" varStatus="status">
										<tr>
											<td>${status.count }</td>
											<td>${result.companyName}</td>
											<td><a href="/lu/activitydesc/listActivityDesc.do?companyId=${result.companyId }&traningProcessId=${result.traningProcessId }" class="text">${result.traningProcessName }</a></td>
											<td>${result.mm } 월</td>
											<td>
												<c:if test="${empty result.bigoCot}"><a href="#!"  class="btn-line-orange">미작성</a></c:if>
												<c:if test="${!empty result.bigoCot}"><a href="#!"  class="btn-line-gray">작성</a></c:if>
											</td>
											<td>
												<c:if test="${empty result.bigoHrd}"><a href="#!"  class="btn-line-orange">미작성</a></c:if>
												<c:if test="${!empty result.bigoHrd}"><a href="#!"  class="btn-line-gray">작성</a></c:if>											
											</td>
										</tr>
									</c:forEach>
 									<c:if test="${empty listActivityHrd}">
										<tr>
											<td colspan="6">데이터가 없습니다.</td>
										</tr>
									</c:if> 
									</tbody>
									</table>
								</div>
 
 
 						
		 						<h2 id="f_2">	주간훈련일지 미제출건</h2>
								<div class="group-area">
									<table class="type-2  mb-010 mt-010">
									<thead>
										<tr>
											<th>번호</th>
											<th>기업명</th>
											<th>훈련과정명</th>
											<th>주차</th>
											<th>OJT</th>
											<th>Off-JT</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="result" items="${listWeekTraningNoteHrd}" varStatus="status">
										<tr>
											<td>${status.count }</td>
											<td>${result.companyName}</td>
											<td><a href="/lu/weektraning/listWeekTraningNoteHrd.do?companyId=${result.companyId }&traningProcessId=${result.traningProcessId }" class="text">${result.traningProcessName }</a></td>
											<td>${result.weekCnt } 주차</td>
											<td>
												<c:if test="${empty result.ojtState}">미작성</c:if>
												<c:if test="${result.ojtState eq 'W'}">미제출</c:if>
												<c:if test="${result.ojtState eq 'X'}">반려</c:if>
												<c:if test="${result.ojtState eq 'I'}">제출</c:if>
											</td>											
											<td>
												<c:if test="${empty result.state}">미작성</c:if>
												<c:if test="${result.state eq 'W'}">미제출</c:if>
												<c:if test="${result.state eq 'X'}">반려</c:if>
												<c:if test="${result.state eq 'I'}">제출</c:if>
											</td>
										</tr>
									</c:forEach>
 									<c:if test="${empty listWeekTraningNoteHrd}">
										<tr>
											<td colspan="6">데이터가 없습니다.</td>
										</tr>
									</c:if> 
									</tbody>
									</table>
								</div> 
								
 

	 							<%--< h2 id="f_3">주차별 학습활동서 미제출건</h2>
								<div class="group-area">
									<table class="type-2  mb-010 mt-010">
										<thead>
											<tr>
												<th><input type="checkbox" id="check0" onclick="javascript:com.checkAll('check0','memIdArr');" class="choice" /></th>
												<th>선택</th>
												<th>훈련과정명</th>
												<th>주차</th>
												<th>OJT</th>
												<th>OFF</th>
											</tr>
										</thead>
										<tbody>
										 
											<c:forEach var="result" items="${listWeekActivityNoteCompany}" varStatus="status">
											<tr>
												<td><input type="checkbox" name="memIdArr" value="${result.memIds}" class="choice" /></td>
												<td>${status.count}</td>
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
										<a href="#!" onclick="javascript:sms();" class="gray-1">SMS 발송</a>
									</div><!-- E : btn-area -->
	 							</div> --%>
 						
  
 
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

function sms(){		
	var obj = document.getElementsByName("memIdArr");
	var temp = 0;
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
              temp++;
         }
    }	
	if(temp==0){
		alert("선택된 대상이 없습니다.");
		return;
	}	  
	fn_send_sms(0,arr_value,'','AC','');
	
}

//-->
</script>
<form:form modelAttribute="frmActivity" name="frmActivity" method="post">
					  
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