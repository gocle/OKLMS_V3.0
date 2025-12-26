<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@page import="kr.co.gocle.oklms.comm.util.StringUtil"%>

<c:set var="targetUrl" value="/lu/discuss/"/>
<script type="text/javascript">

	var targetUrl = "${targetUrl}";

	$(document).ready(function() {
		loadPage();
	});

	/*===================================================================
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

	/*===================================================================
		사용자 정의 함수
	====================================================================*/
	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}

	/* 토론 상세조회 페이지로 이동 */
	function fn_read( param1, param2, param3, param4, param5){
		var startDt = param2;
		var endDt = param3;
		var currentDt = param4;
		var title = param5;
/*
		if(startDt > currentDt){
			alert("토론 제목 = ["+title+"] 공개시작전 입니다.");
			return false;
		} else if(currentDt > endDt){
			alert("토론 제목 = ["+title+"] 마감 완료되없습니다.");
			return false;
		}
*/
		$("#discussId").val( param1 );

		var reqUrl = CONTEXT_ROOT + targetUrl + "getDiscuss.do";

		$("#frmDiscuss").attr("action", reqUrl);
		$("#frmDiscuss").submit();
	}

	/* 채점결과 상세화면 이동 */
	function fn_std_result_evalScore( param1, param2, param3, param4, param5){
		var startDt = param2;
		var endDt = param3;
		var currentDt = param4;
		var title = param5;
/*
		if(startDt > currentDt){
			alert("토론 제목 = ["+title+"] 공개시작전 입니다.");
			return false;
		} else if(currentDt > endDt){
			alert("토론 제목 = ["+title+"] 마감 완료되없습니다.");
			return false;
		}
*/
		$("#discussId").val( param1 );

		var reqUrl = CONTEXT_ROOT + targetUrl + "getDiscussEvalScoreResultStd.do";

		$("#frmDiscuss").attr("action", reqUrl);
		$("#frmDiscuss").submit();
	}

	/* 토론의견 상세조회 페이지로 이동 */
	function fn_opinionRead( param1, param2 ){

		$("#discussOpinionId").val( param1 );
		$("#discussId").val( param2 );

		var reqUrl = CONTEXT_ROOT + targetUrl + "getDiscussOpinion.do";

		$("#frmDiscuss").attr("action", reqUrl);
		$("#frmDiscuss").submit();
	}

	/* 토론 수정 페이지로 이동 */
	function fn_updt(  ){

		var checkedVal = "";
		checkedVal = $(":input:radio[name=discussIdSelect]:checked").val();

		if(undefined == checkedVal){
			alert("수정할 토론제목에 라디오버튼을 선택하여주십시오.");
			return false
		}

		$("#discussId").val( checkedVal );

		var reqUrl = CONTEXT_ROOT + targetUrl + "goUpdateDiscuss.do";
		$("#frmDiscuss").attr("action", reqUrl);
		$("#frmDiscuss").submit();
	}

	/* 토론 삭제 */
	function fn_delt(){
		if (confirm("삭제 하시겠습니까?")) {
			var checkedVal = "";
			checkedVal = $(":input:radio[name=discussIdSelect]:checked").val();

			if(undefined == checkedVal){
				alert("삭제할 토론제목에 라디오버튼을 선택하여주십시오.");
				return false
			}

			$("#discussId").val( checkedVal );

			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteDiscuss.do";

			$("#frmDiscuss").attr("action", reqUrl);
			$("#frmDiscuss").submit();
		}
	}

	/* 토론 신규 페이지로 이동 */
	function fn_cret(){

		var reqUrl = CONTEXT_ROOT + targetUrl + "goInsertDiscuss.do";

		$("#frmDiscuss").attr("action", reqUrl);
		$("#frmDiscuss").submit();
	}
	
	function fn_search(subjectClass,companyId,scrollNum,companyName){
		
		$("#subjectClass").val(subjectClass);
		$("#subClass").val(subjectClass);
		$("#companyId").val(companyId);
		$("#companyName").val(companyName);
		$("#scrollNum").val(scrollNum);
		
		var reqUrl = "/lu/discuss/listDiscuss.do";
	 	
		$("#frmDiscuss").attr("target", "_self");
		$("#frmDiscuss").attr("action", reqUrl);
		$("#frmDiscuss").submit();
		

	}

</script>


<form id="frmDiscuss" name="frmDiscuss" method="post">
<input type="hidden" id="discussId" name="discussId" />
<input type="hidden" id="discussOpinionId" name="discussOpinionId" />
<input type="hidden" id="yyyy" name="yyyy" value="${discussVO.yyyy}" />
<input type="hidden" id="term" name="term" value="${discussVO.term}" />
<input type="hidden" id="subjectCode" name="subjectCode" value="${discussVO.subjectCode}" />
<input type="hidden" id="subClass" name="subClass" value="${discussVO.subClass}" />
    <input type="hidden" id="subjectClass" name="subjectClass" value="" />
    <input type="hidden" id="classId" name="classId" value="" />
	<input type="hidden" id="companyId" name="companyId" value="" />
	<input type="hidden" id="companyName" name="companyName" value="" />
	<input type="hidden" id="scrollNum" name="scrollNum" value="" />


<div id="">
	<h2>토론</h2>
	<div class="group-area-title">
	
	<c:choose>
		<c:when test="${currProcReadVO.subjectTraningType eq 'OJT'}">
			<h4><span>${currProcReadVO.subjectName} / ${currProcReadVO.subjectCode}</span> (${currProcReadVO.subClass}분반_${empty param.companyName ? companyName : param.companyName}) ㅣ ${currProcReadVO.yyyy}학년도 ${currProcReadVO.termName}</h4>
		</c:when>
		<c:otherwise>
			<h4><span>${currProcReadVO.subjectName } / ${currProcReadVO.subjectCode }</span> ㅣ ${currProcReadVO.yyyy}학년도 / ${currProcReadVO.termName}</h4>
		</c:otherwise>
	</c:choose>
	
	<c:if test="${currProcReadVO.subjectTraningType eq 'OJT'}">
							
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
		<table class="type-1 responsive-tr">
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
					<th>교과형태</th>
				<td>${currProcReadVO.subjectTraningTypeName}</td>
					<th>과정구분</th>
				<td>${currProcReadVO.subjectTypeName}</td>
					<th>학점</th>
					<td>${currProcReadVO.point }학점</td>
				</tr>
				<tr>
					<th>교수</th>
					<td>${currProcReadVO.insNames}</td>
					<th>온라인 교육형태</th>
					<td>${currProcReadVO.onlineTypeName} (성적비율 ${currProcReadVO.gradeRatio}%)</td>
					<th>선수여부</th>
					<td>${currProcReadVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}</td>
				</tr>
		</tbody>
		</table>

		<div class="btn-area align-right mt-010">
			<a href="#fn_cret" onclick="javascript:fn_cret(); return false" class="orange">토론 생성</a>
		</div><!-- E : btn-area -->
	</div>

	<h2 class="mt-040">토론 목록</h2>
	<div class="group-area mt-010">
		<div class="table-responsive">
		<table class="type-2">
			<colgroup>
				<col style="width:6%" />
				<col style="width:6%" />
				<col style="width:*" />
				<col style="width:15%" />
				<col style="width:15%" />
				<col style="width:8%" />
				<col style="width:8%" />
			</colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>번호</th>
					<th>제목</th>
					<th>기간</th>
					<th>의견</th>
					<th>배점</th>
					<th>채점결과</th>
				</tr>
			</thead>
				<c:forEach var="result" items="${resultDiscussList}" varStatus="status">
				<tr>
					<td <c:if test="${result.opinionCnt != '0'}"> rowspan="2" </c:if>><input type="radio" id="discussIdSelect" name="discussIdSelect" value="${result.discussId}" class="choice" /></td>
					<td <c:if test="${result.opinionCnt != '0'}"> rowspan="2" </c:if>>${status.count}</td>
					<td class="left"><a href="#fn_read" onclick="javascript:fn_read('${result.discussId}','${result.startDt}','${result.endDt}','${result.currentDt}','${result.title}'); return false" class="text">${result.title}</a></td>
					<td>${result.startDate} ~ ${result.endDate}</td>
					<td>${result.opinionCnt}</td>
					<td>${result.evalScore}</td>
					<c:if test="${result.evalYn eq 'N'}">
					<td>
						<c:choose>
							<c:when test="${result.currentDt > result.endDt}">
								<a href="#!" class="btn-line-orange">마감</a>
							</c:when>
							<c:otherwise>
								<a href="#!" class="btn-line-gray">미평가</a>
							</c:otherwise>
						</c:choose>
					</td>
					</c:if>
					<c:if test="${result.evalYn eq 'Y'}">
					<td>
						<c:choose>
						<c:when test="${result.stdMarkResultState eq '완료'}">
							<c:choose>
								<c:when test="${result.currentDt > result.endDt}">
									<a href="#!" onclick="javascript:fn_std_result_evalScore('${result.discussId}','${result.startDt}','${result.endDt}','${result.currentDt}','${result.title}'); return false"   class="btn-line-orange">마감</a>
								</c:when>
								<c:otherwise>
									<a href="#fn_std_result_evalScore" onclick="javascript:fn_std_result_evalScore('${result.discussId}','${result.startDt}','${result.endDt}','${result.currentDt}','${result.title}'); return false"  class="btn-line-blue">${result.stdMarkResultState}</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${result.currentDt > result.endDt}">
									<a href="#!" onclick="javascript:fn_std_result_evalScore('${result.discussId}','${result.startDt}','${result.endDt}','${result.currentDt}','${result.title}'); return false"  class="btn-line-orange">마감</a>
								</c:when>
								<c:otherwise>
									<a href="#fn_std_result_evalScore" onclick="javascript:fn_std_result_evalScore('${result.discussId}','${result.startDt}','${result.endDt}','${result.currentDt}','${result.title}'); return false"  class="btn-line-blue">${result.stdMarkResultState}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
						</c:choose>
					</td>
					</c:if>
				</tr>
				<c:if test="${result.opinionCnt != '0'}">
					<tr>
						<td colspan="5" class="border-left left text-area">
							<ul class="table-discuss-area">
								<c:forEach var="resultOpinion" items="${resultDiscussOpinionList}" varStatus="status">
								<c:if test="${result.discussId eq resultOpinion.discussId}">
								<li>
									<%-- <a href="#fn_opinionRead" onclick="javascript:fn_opinionRead('${resultOpinion.discussOpinionId}','${resultOpinion.discussId}'); return false" class="text"><b>${resultOpinion.title}</b></a> [ ${resultOpinion.memName} ㅣ ${resultOpinion.insertDt} ] --%>
									<b>${resultOpinion.title}</b> [ ${resultOpinion.memName} ㅣ ${resultOpinion.insertDt} ]
									<p>${resultOpinion.content}</p>
								</li>
								</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</c:if>
				</c:forEach>
				<c:if test="${fn:length(resultDiscussList) == 0}">
				<tr>
					<td colspan="7"><spring:message code="common.nosarch.nodata.msg" /></td>
				</tr>
				</c:if>
			</tbody>
		</table>
		</div>
		<!-- E : 토론 -->

		<c:if test="${fn:length(resultDiscussList) != 0}">
		<div class="btn-area mt-010">
			<div class="float-right">
				<a href="#fn_delt" onclick="javascript:fn_delt(); return false" class="black">삭제</a>
				<a href="#fn_updt" onclick="javascript:fn_updt(); return false" class="black">수정</a>
			</div>
		</div><!-- E : btn-area -->
		</c:if>
	</div>

</div><!-- E : content-area -->

</form>



