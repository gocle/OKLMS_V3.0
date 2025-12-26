<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@page import="kr.co.gocle.oklms.comm.util.StringUtil"%>

<link href="/js/jquery/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript">

	var evDivName = "";
	var memName = "";
	var clickNum = 0;

	$(document).ready(function() {
		loadPage();
	});

	/*====================================================================
		화면 초기화
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}

	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/* 화면이 로드된후 처리 초기화 */
	function initHtml() {

	}

	/*====================================================================
		사용자 정의 함수
	====================================================================*/
	
	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}
	
	function fn_search(  param1 ){
		var reqUrl = "/lu/eval/listInsideEvalPrt.do";
		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").submit();
	}
	
	function fn_approval( status ){
		
		var checkedVals = com.getCheckedVal('check0','insideEvalIds');
		
		if(checkedVals == ''){
			alert("처리 대상을 선택하세요.");
			return;
		}
		
		if( status == "3" ){
			if( $("#retunReason").val() == "" ){
				alert("반려사유를 입력하세요.");
				$("#retunReason").focus();
				return;
			}
		} else {
			$("#returnReason").val("");
		}
		$("#status").val(status);
		var reqUrl = "/lu/eval/updateInsideEvalPrt.do";
		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").submit();
	}
	
</script>


<h2>내부평가</h2>

<form id="frmEvalPlan" name="frmEvalPlan" method="post">
<input type="hidden" id="yyyy" name="yyyy" value="${subjectVO.yyyy}" />
<input type="hidden" id="term" name="term" value="${subjectVO.term}" />
<input type="hidden" id="subjectCode" name="subjectCode" value="${subjectVO.subjectCode}" />
<input type="hidden" id="subClass" name="subClass" value="${subjectVO.subjectClass}" />	
<input type="hidden" id="status" name="status"  />

<div class="group-area-title">
<h4><span>${subjectVO.subjectName} / ${subjectVO.subjectCode}</span> (${subjectVO.subjectClass}반) ㅣ ${subjectVO.yyyy}학년도 ${subjectVO.termName}</h4>

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
					<input id="class_searchKeyword" name="searchKeyword" title="검색어 입력" placeholder="검색어를 입력하세요."  class="schText" type="text" value="">    
					<button class="btn btn-black btn-sch" onclick="fn_comOjtClassSearch2();">검색</button> 
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
								<li <c:if test="${ result.classId eq param.classId }">  class="current" </c:if> >
									<a href="/lu/eval/listInsideEvalPrt.do?subClass=${result.classId}">${result.classId}분반_${result.companyName }</a>
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
</div>
<!--  //분반 모달창 -->
<!--  //분반 검색 -->
				
				<!-- <dl id="tab-type">
					<dt class="tab-name-11 on"><a href="javascript:showTabbtn1();">기업별</a></dt>
					<dd id="tab-content-11" style="display:block;"> -->

						<div class="group-area mt-020">
							<!--  검색 -->

								<div class="search-box-1 mb-020">
									<!-- <select name="yyyy"  onchange="" > 
											<option value="0">2020학년도</option>							
									</select> 	
									
									<select name="term" onchange="">
										<option value="1">1학기</option>
										<option value="2">2학기</option>
										<option value="3">여름학기</option>
										<option value="4">겨울학기</option>
									</select> -->
									
									<select id="searchPlanType" name="searchPlanType" onchange="">
										<option value="">평가유형 잔체</option>
										<option value="1" ${param.searchPlanType eq '1' ? 'selected' : ''}>중간</option>
										<option value="2" ${param.searchPlanType eq '2' ? 'selected' : ''}>기말</option>
									</select>

									<!-- <select id="" name="" onchange="">
										<option value="0">교과목명 전체</option>
									</select> -->

									<!-- <select id="" name="" onchange="">
										<option value="0">성적 전체</option>
									</select> -->
									
									<select id="searchStatus" name="searchStatus">
										<option value="">상태 전체</option>
										<option value="1" ${param.searchStatus eq '1' ? 'selected' : ''}>승인요청</option>
										<option value="2" ${param.searchStatus eq '2' ? 'selected' : ''}>승인</option>
										<option value="3" ${param.searchStatus eq '3' ? 'selected' : ''}>반려</option>
									</select>

									<select id="searchName" name="searchName">
										<option value="">이름+학번</option>
										<option value="NAME" ${param.searchName eq 'NAME' ? 'selected' : ''}>이름</option>
										<option value="ID" ${param.searchName eq 'ID' ? 'selected' : ''}>학번</option>
									</select>
									
									<input type="text" id="searchWord" name="searchWord" value="${param.searchWord}" maxlength="35" placeholder="검색어 입력">
									<a href="#fn_search" onclick="javascript:fn_search(1); return false" onkeypress="this.onclick;">검색</a>
								</div>	
							<!--  //검색 -->
							
							<ul class="page-sum mb-007">
								<li class="float-left">총 <b>${fn:length(resultList)}</b>건</li>
								<li class="float-right">
									<!-- <div class="list-layout">
								    <select name="" id="" title="목록수">
										<option value="0">목록수</option>
										<option value="1">10개</option>
										<option value="2">20개</option>
										<option value="3">30개</option>
										<option value="4">40개</option>
										<option value="5">50개</option>
									</select>
							    </div> -->
								</li>
							</ul>

							<div class="table-responsive">
								<table class="type-2">
									<colgroup>
										<col style="width:5%">
										
										
										<col style="width:10%">
										<col style="width:*">
										<col style="width:6%">
										<col style="width:6%">
										<col style="width:10%">
										<col style="width:14%">
										<col style="width:8%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:6%">
									</colgroup>
									<thead>
										<tr>  
											<th><input type="checkbox" id="check0" name="check0" onclick="javascript:com.checkAll('check0','insideEvalIds');" class="choice" /></th>
											<!-- 
											<th>학년도</th>
											<th>학기</th>
											<th>분반</th>
											<th>개설교과명</th>
											 -->
											<th>학번</th>
											<th>기업명</th>
											<th>이름</th>
											<th>성적</th>
											<th>평가유형</th>
											<th>첨부파일</th>
											<th>상태</th>
											<th>등록일</th>
											<th>승인일</th>
											<th>기업현장교사</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td><input type="checkbox" id="insideEvalIds" name="insideEvalIds" value='<c:out value="${result.insideEvalId}"/>' class="choice" /></td>
											<%-- 
											<td>${result.yyyy}</td>
											<td>${result.termName}</td>
											<td>${result.subjectClass}</td>
											<td>${result.subjectName}</td>
											 --%>
											<td>${result.stdMemId}</td>
											<td>${result.companyName}</td>
											<td>${result.stdMemName}</td>
											<td>${result.score}</td>
											<td>${result.planTypeName}</td>
											<td>
											<c:if test="${!empty result.atchFileId}">
												<a href="javascript:com.downFile('${result.atchFileId}','1');" >
													<i class="xi-diskette" style="font-size:20px"></i>
												</a>
											</c:if>
											<c:if test="${!empty result.atchFileId1}">
												<a href="javascript:com.downFile('${result.atchFileId1}','1');" >
													<i class="xi-diskette" style="font-size:20px"></i>
												</a>
											</c:if>
											<c:if test="${!empty result.atchFileId2}">
												<a href="javascript:com.downFile('${result.atchFileId2}','1');" >
													<i class="xi-diskette" style="font-size:20px"></i>
												</a>
											</c:if>
											<c:if test="${!empty result.atchFileId3}">
												<a href="javascript:com.downFile('${result.atchFileId3}','1');" >
													<i class="xi-diskette" style="font-size:20px"></i>
												</a>
											</c:if>
											</td>
											<td>
											<c:choose>
												<c:when test="${result.status eq '1'}"><span class="label gray">승인대기</span></c:when>
												<c:when test="${result.status eq '2'}"><span class="label blue">승인</span></c:when>
												<c:when test="${result.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnEvalComment" data-comment="${result.retunReason}" rel="modal:open">반려</a></span></c:when>
											</c:choose>
											</td>
											<td>${result.insertDate}</td>
											<td>${result.statusDate}</td>
											<td>${result.tutNames}</td>
										</tr>
									</c:forEach>	
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
										 	<td colspan="12"><spring:message code="common.nodata.msg" /></td>
										</tr>		
									</c:if>		
									</tbody>
								</table>
							
								<%-- <table class="type-2">
									<colgroup>
										<col style="width:60px">
										<col style="width:*">
										<col style="width:*">
										<col style="width:80px">
										<col style="width:100px">
										<col style="width:*">
										<col style="width:*">
										<col style="width:100px">
										<col style="width:80px">
										<col style="width:80px">
										<col style="width:100px">
										<col style="width:80px">
									</colgroup>
									<thead>
										<tr>
											<th>NO</th>
											<th>기업명</th>
											<th>훈련과정명</th>
											<th>평가<br />유형</th>
											<th>학년도<br />학기</th>
											<th>교과목명</th>
											<th>제목</th>
											<th>학생명</th>
											<th>성적</th>
											<th>파일</th>
											<th>지도교사</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>01</td>
											<td>기업명</td>
											<td>훈련과정명</td>
											<td>평가<br />유형</td>
											<td>20학년도<br />1학기</td>
											<td>교과목명</td>
											<td><a href="">제목</a></td>
											<td>학생명</td>
											<td>성적</td>
											<td><i class="xi-diskette" style="font-size:20px"></i></td>
											<td>지도교사</td>
											<td>상태</td>
										</tr>
										
										<tr>
										 	<td colspan="12">검색 결과가 없습니다.</td>
										</tr>				
									</tbody>
								</table> --%>
							</div>
						</div>
						<div class="btn-area  mt-010">
							<div class="align-right">
								<input type="text" name="retunReason" id="retunReason" maxlength="50" placeholder="반려시 반려사유 필수 입력(50자 미만) " style="width:50%">
								<a href="#" onclick="javascript:fn_approval('3');" class="yellow">반려</a>
								<a href="#" onclick="javascript:fn_approval('2');" class="orange">승인</a>
							</div>
						</div>
						
						
	</form>						
					<!--
					</dd>
					
					 <dt class="tab-name-12"><a href="javascript:showTabbtn2();">과정별</a></dt>
					<dd id="tab-content-12">
						<div class="group-area mt-020">
							과정별
						</div>
					</dd>
					
					<dt class="tab-name-13"><a href="javascript:showTabbtn3();">교과목별</a></dt>
					<dd id="tab-content-13">
						<div class="group-area mt-020">
							교과목별
						</div>
					</dd>
				</dl> -->




