<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
						<h2>팀프로젝트</h2>
						
						<div class="group-area-title">
							<c:choose>
								<c:when test="${currProcVO.subjectTraningType eq 'OJT'}">
									<h4><span>${currProcVO.subjectName} / ${currProcVO.subjectCode}</span> (${currProcVO.subClass}분반_${empty param.companyName ? companyName : param.companyName}) ㅣ ${currProcVO.yyyy}학년도 ${currProcVO.termName}</h4>
								</c:when>
								<c:otherwise>
									<h4><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
								</c:otherwise>
							</c:choose>
							<c:if test="${currProcVO.subjectTraningType eq 'OJT'}">
							
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
												<label for="class_searchKeyword" class="">검색어 입력</label>
												<input id="class_searchKeyword" name="searchKeyword" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
												<button class="btn btn-black btn-sch" onclick="fn_comOjtClassSearch();">검색</button> 
											</fieldset>
										 </div>
										
										<!--  분반 검색 결과 및 리스트 -->
										<div id="learner-wrap_box">
											<ul id="learner-wrap">
												<li>
													<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
													<div id="scroller" <%-- style="width:${fn:length(listOjtClassName)*128}px;" --%>>
														<ul id="thelist" class="name-tab-btn">
															<c:forEach var="result" items="${listOjtClassName}" varStatus="status">
																<li <c:if test="${result.subjectClass eq subjectVO.subjectClass }">  class="current" </c:if> >
																<a href="#!" onclick="javascript:fn_search('${result.subjectClass}','${result.companyId }','${status.count }','${result.companyName}')" title="${result.companyName}">${result.subjectClass}분반_${result.companyName }</a></li>
															</c:forEach>
														</ul>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<!--  //분반 모달창 -->
								<!--  //분반 검색 -->
							
							</c:if>
							
						</div>
							<div class="group-area">
								<table class="type-1">
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
	
								<div class="btn-area mt-010">
									<div class="float-right">
										<a href="/lu/teamproject/goInsertTeamproject.do" class="orange">프로젝트 생성</a>
									</div>
								</div><!-- E : btn-area -->
							</div>
					
<script type="text/javascript">
	<!--
	
	$(document).ready(function() {
	
		
	});
	/*  수정,삭제 */
	function fn_formSave(type){ 
		 
	 	if(!$(":input:radio[name=teamprojectArr]:checked").val()){
	 		alert("팀프로젝트를 선택하세요!");
	 		return;
	 	} 
	 	
	 	var teamprojectArr = $(":input:radio[name=teamprojectArr]:checked").val().split("|");
	 	var teamprojectId = teamprojectArr[0];
	 	var scoreCnt = teamprojectArr[1];
	 	var submitCnt = teamprojectArr[2];
	 	
	 	//alert(teamprojectId);
	 	//alert(scoreCnt);
	 	//alert(submitCnt);
	 	
	 	$("#teamprojectId").val(teamprojectId);
	 	$("#scoreCnt").val(scoreCnt);
	 	$("#submitCnt").val(submitCnt);
	 	
		//수정
		if(type=="U"){
			var reqUrl =  "/lu/teamproject/goUpdateTeamproject.do";
			$("#frmTeamproject").attr("target", "_self");
			$("#frmTeamproject").attr("action", reqUrl);
			$("#frmTeamproject").submit();
		//삭제	
		}else if(type=="D"){
			
			if ( scoreCnt > 0 || submitCnt > 0 ) {
				alert("제출건이 있는 팀프로젝트는 삭제가 불가능합니다.");
				return;
			}
			
			if (  confirm("삭제 하시겠습니까?")) {
				var reqUrl =  "/lu/teamproject/deleteTeamproject.do";
				$("#frmTeamproject").attr("target", "_self");
				$("#frmTeamproject").attr("action", reqUrl);
				$("#frmTeamproject").submit();	
			}
		}
	}
	function fn_popupTeamproject(teamprojectId){
		var url = "/lu/teamproject/popupTeamproject.do?teamprojectId="+teamprojectId;
		var wndName = "Teamproject";
		var wWidth = "680";
		var wHeight = "840";
	
		popOpenWindow( url, wndName, wWidth, wHeight, 0, 0, 'scrollbars=yes' );
	}
	
	function fn_search(subjectClass,companyId,scrollNum,companyName){
		
		$("#subjectClass").val(subjectClass);
		$("#subClass").val(subjectClass);
		$("#companyId").val(companyId);
		$("#companyName").val(companyName);
		$("#scrollNum").val(scrollNum);
		$("#scoreCnt").val("0");
		$("#submitCnt").val("0");
		
		var reqUrl = "/lu/teamproject/listTeamproject.do";
	 	
		$("#frmTeamproject").attr("target", "_self");
		$("#frmTeamproject").attr("action", reqUrl);
		$("#frmTeamproject").submit();
		

	}
	
	//--> 
</script>




<form:form modelAttribute="frmTeamproject" name="frmTeamproject" method="post"   >
	<input type="hidden" name="teamprojectId" id="teamprojectId"/>
	<input type="hidden" name="scoreCnt" id="scoreCnt"/>
	<input type="hidden" name="submitCnt" id="submitCnt"/>
	    <input type="hidden" id="subClass" name="subClass" value="" />
    <input type="hidden" id="subjectClass" name="subjectClass" value="" />
    <input type="hidden" id="classId" name="classId" value="" />
	<input type="hidden" id="companyId" name="companyId" value="" />
	<input type="hidden" id="companyName" name="companyName" value="" />
	<input type="hidden" id="scrollNum" name="scrollNum" value="" />
	
						<h2>팀프로젝트 목록</h2>
						<div class="group-area">
							<div class="table-responsive">
							<table class="type-2">
								<caption>회차 팀프로젝트주테 팀프로젝트기간 팀수 제출현황 채점현황에 대한 정보를 제공합니다</caption>
								<colgroup>
									<col style="width:6%" />
									<col style="width:6%" />
									<col style="width:*" />
									<col style="width:15%" />
									<col style="width:8%" />
									<col style="width:6%" />
									<col style="width:8%" />
									<col style="width:8%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">선택</th>
										<th scope="col">회차</th>
										<th scope="col">팀프로젝트 주제</th>
										<th scope="col">팀프로젝트 기간</th>
										<th scope="col">과제 마감일</th>
										<th scope="col">팀수</th>
										<th scope="col">제출현황</th>
										<th scope="col">채점현황</th>
									</tr>
									<c:forEach var="result" items="${result}" varStatus="status">
									<tr>
										<td>
											<%-- <c:if test="${result.scoreCnt==0}">
												<input type="radio" name="teamprojectId"  value="${result.teamprojectId}" class="choice"  <c:if test="${result.submitCnt > 0 }"> disabled="disabled" </c:if>  />
											</c:if> --%>
											<label for="">선택</label>
											<input type="radio" name="teamprojectArr" id="teamprojectArr"  value="${result.teamprojectId}|${result.scoreCnt}|${result.submitCnt}" class="choice"  /> 
										</td>
										<td>${status.index+1}</td>
										<td class="left"><a href="/lu/teamproject/getTeamproject.do?teamprojectId=${result.teamprojectId}" class="text">${result.projectName}</a></td>
										<td>${result.projectStartDate} ~ ${result.projectEndDate}</td>
										
										<td>${result.submitEndDate}</td>
										<td>${result.teamCnt}</td>
										<td><a href="#!" onclick="javascript:fn_popupTeamproject('${result.teamprojectId}');" class="btn-full-blue">${result.submitCnt}/${result.totCnt}</a></td>
										<td>
											<c:choose>
										       <c:when test="${result.scoreOn eq 'N' }">
													<a href="/lu/teamproject/goScoreTeamproject.do?teamprojectId=${result.teamprojectId}" class="btn-line-gray">미채점</a>
										       </c:when>
										       <c:when test="${result.scoreOn ne 'Y' }">
													<a href="/lu/teamproject/goScoreTeamproject.do?teamprojectId=${result.teamprojectId}" class="btn-line-blue">열기</a>
										       </c:when>
 											   <c:otherwise>
													<a href="/lu/teamproject/goScoreTeamproject.do?teamprojectId=${result.teamprojectId}" class="btn-line-gray">미채점</a>
										       </c:otherwise>										       
										    </c:choose>
											 
											
										</td>
									</tr>
									</c:forEach>
								<c:if test="${empty result}">
						          <tr>
						            <td colspan="8">자료가 없습니다.</td>
						          </tr>
						        </c:if>
								</tbody>
							</table>
							</div>
							<!-- E : 팀프로젝트관리 -->
							<c:if test="${!empty result}">
							<div class="btn-area mt-010">
								<div class="float-right">
									<a href="#" onclick="javascript:fn_formSave('D');" class="gray-1">삭제</a><a href="#"  onclick="javascript:fn_formSave('U');" class="yellow">수정</a>
								</div>
							</div><!-- E : btn-area -->
							</c:if>
						</div>
</form:form>