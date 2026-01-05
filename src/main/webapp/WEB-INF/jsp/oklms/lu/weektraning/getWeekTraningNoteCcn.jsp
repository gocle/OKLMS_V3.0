<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${traningNoteVO.addyn eq 'Y' }"><h2>보강훈련일지 조회</h2></c:if>
<c:if test="${traningNoteVO.addyn eq 'N' }"><h2>주간훈련일지 조회</h2></c:if>
						
<script type="text/javascript">
<!--

function fn_search(){ 
	var reqUrl = "/lu/weektraning/listWeekTraningNoteCcn.do";
	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").attr("target","_self");
	$("#frmWeekTraning").submit();	 
}

function fn_update(){
	var reqUrl = "/lu/weektraning/updateWeekTraningNoteCcn.do";
	$("#statusType").val("U");
	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").attr("target","_self");
	$("#frmWeekTraning").submit();	
}

function fn_return(){
	var reqUrl = "/lu/weektraning/updateWeekTraningNoteCcn.do";
	$("#statusType").val("X");
	
	$("#returnX").val($("#returnComment").val());
	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").attr("target","_self");
	$("#frmWeekTraning").submit();	
}

function fn_confirm(){
	var reqUrl = "/lu/weektraning/updateWeekTraningNoteCcn.do";
	$("#statusType").val("C");
	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").attr("target","_self");
	$("#frmWeekTraning").submit();
}

function fn_saveFile(){
	var reqUrl = "/lu/weektraning/updateWeekTraningNoteCcnFile.do";
	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").attr("target","_self");
	$("#frmWeekTraning").submit();
}


//-->
</script>


<c:set var="returnComment" value="" />
<c:set var="stateName" value="" />
						<c:if test="${!empty resultList}" >							
							<c:set var="stateName" value="${resultList[0].state }" />
							<c:set var="returnComment" value="${resultList[0].returnComment }" />
							<c:if test="${stateName eq 'C'}" >
							<c:set var="stateName" value="확정" />
							</c:if>
							<c:if test="${stateName eq 'X'}" >
							<c:set var="stateName" value="반려" />
							</c:if>
							<c:if test="${stateName eq 'I'}" >
							<c:set var="stateName" value="제출" />
							</c:if>
							<c:if test="${stateName eq 'W'}" >
							<c:set var="stateName" value="미제출" />
							</c:if>							
						</c:if>
						
						<table data-role="table" class="type-1-1 mt-010 ui-responsive">

							<%-- 
							<colgroup>
								<col style="width:100px" />
								<col style="width:100px" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:120px" />
								<col style="width:90px" />
								<col style="width:90px" />
							</colgroup>
							 --%>
							<thead>
								<tr>
									<th>상태</th>
									<th>구분</th>
									<th>기업명</th>
									<th>훈련과정명</th>
									<th>학년도</th>
									<th>학기</th>
									<th>주차</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${!empty result}">
								<tr>
									<td>${stateName}</td>
									<td>${traningNoteVO.traningType}</td>
									<td>${result.companyName }</td>
									<td>${result.hrdTraningName }</td>
									<td>${traningNoteVO.yyyy}</td>
									<td>${traningNoteVO.termName}</td>
									<td>${traningNoteVO.weekCnt }</td>
								</tr>
								</c:if>
							 
							</tbody>
						</table>
<c:set var="allReview" value="" />
  

<form:form modelAttribute="frmWeekTraning" name="frmWeekTraning" method="post" enctype="multipart/form-data"  >

<input type="hidden" name="companyId" id="companyId" value="${result.companyId }"  />
<input type="hidden" name="traningProcessId" id="traningProcessId"  value="${result.traningProcessId }" />
<input type="hidden" name="weekCnt"  value="${traningNoteVO.weekCnt }"/>
<input type="hidden" name="yyyy"  value="${traningNoteVO.yyyy}"/>
<input type="hidden" name="term"  value="${traningNoteVO.term}"/>
<input type="hidden" name="statusType" id="statusType" value="" />
<input type="hidden" name="traningType" id="traningType" value="${traningNoteVO.traningType}"  />	
<input type="hidden" name="addyn" id="addyn" value="${traningNoteVO.addyn}" />
<input type="hidden" name="baseCheckCompanyIds" id="baseCheckCompanyIds" value="${param.baseCheckCompanyIds }"  />	

<input type="hidden" name="returnComment"  id="returnX" value=""/>
 					
						<div class="table-responsive mt-020">
						<table class="type-2">
							<colgroup>
								<col style="width:120px" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:70px" />
								<col style="width:110px" />
								<col style="width:120px" />
								<col style="width:80px" />
								<col style="width:80px" />
								<col style="width:160px" />
							</colgroup>
							<thead>
								<tr>
									<th>일자</th>
									<th>개설강좌명</th>
									<th>능력단위요소</th>
									<th>주간<br />훈련시간</th>
									<th>성명</th>
									<th>주민등록번호</th>
									<th>실제<br />훈련시간</th>
									<th>성취도</th>
									<th>비고<br />(교육 중 특이사항 등)</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="tempId" value="xxx" />

							<c:forEach var="resultList" items="${resultList}" varStatus="status">
							<c:set var="newtempId" value="${resultList.subjectName}${resultList.classId}${resultList.traningDate}" />
								<tr>
								<c:if test="${tempId ne newtempId }" >
								<c:set var="allReview" value="${allReview} 
								${resultList.review}" />
									<td rowspan="${resultList.llCount}">${resultList.traningDate}</td>
									<td rowspan="${resultList.llCount}">${resultList.subjectName}</td>
									<td rowspan="${resultList.llCount}">${resultList.ncsElemName}</td>
									<td rowspan="${resultList.llCount}">${resultList.studyTimePlan}</td>									
								</c:if>
									<td <c:if test="${tempId eq newtempId }" > class="border-left" </c:if>>${resultList.memName}</td>
									<td></td>
									<td><input type="text" name="studyTimeArr" maxlength="" value="${resultList.studyTime}" style="width:30px; text-align:center;" /></td>
									<td><input type="text" name="score" maxlength="" value="${resultList.achievement}" style="width:30px; text-align:center;" /></td>
									<td><input type="text" name="bigoArr" maxlength="" value="${resultList.bigo}" style="width:120px;" />
									<input type="hidden" name ="traniningNoteDetailIdArr" value="${resultList.traniningNoteDetailId}"/>
									<input type="hidden" name ="traniningNoteMasterIdArr" value="${resultList.traniningNoteMasterId}"/>
									 
									<input type="hidden" name ="memIdArr" value="${resultList.memId}"/>
									<input type="hidden" name ="memNmArr" value="${resultList.memName}"/>
									</td>									
								</tr>
								<c:set var="tempId" value="${resultList.subjectName}${resultList.classId}${resultList.traningDate}" />
							</c:forEach>
							<c:if test="${empty resultList}">
								<tr>
									<td colspan="9">데이터가 없습니다.</td>								
								</tr> 
							</c:if>
							</tbody>
						</table>
						</div>
						
						<c:if test="${!empty resultList}"> 
						<table class="type-write mt-040">
							<tbody>
								<tr>
									<th>총평</th>
									<td>
										<textarea name="textarea" rows="5" readonly="readonly" disabled>${allReview}</textarea>
									</td>
								</tr>
							</tbody>
						</table>
						</c:if>



<c:if test="${!empty resultList}"> 
						<div class="btn-area mt-010">
							<div class="float-left">
								<a href="#!" onclick="javascript:fn_search();" class="gray-1">목록</a>
							</div>
							
							<div class="float-right">	
								<c:if test="${!empty resultFile}">
									<span><a href="javascript:com.downFile('${resultFile.atchFileId}','${resultFile.fileSn}');"><b>${resultFile.orgFileName}</b></a></span>
								</c:if>							
								<div class="float-left">		
									<input type="file" class="atchFiles" name="atchFiles" id="atchFiles"  style="width:200px"/>
									<a href="#!" onclick="javascript:fn_saveFile();"  class="yellow">파일저장</a> 
									<a href="#!" onclick="javascript:fn_update();"  class="yellow">수정</a>
								</div>
								
								<div class="float-right">		
								<input type="text" id="returnComment" value="${returnComment}" placeholder="반려시 반려사유 필수 입력" />
								<a href="#!" onclick="javascript:fn_return();" class="yellow">반려</a>
	 
								<a href="#!" onclick="javascript:fn_confirm();" class="orange">확정</a>
								</div>
							</div>
						</div>
</c:if>						
</form:form>						
