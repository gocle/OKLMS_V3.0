<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@page import="kr.co.gocle.oklms.comm.util.StringUtil"%>


<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript">

	var evDivName = "";
	var memName = "";
	var clickNum = 0;

	$(document).ready(function() {
		loadPage();
		
		$("input:text[score]").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});

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
		//makeFileAttachment();
		com.datepickerDateFormat('startDate');
		com.datepickerDateFormat('endDate');
	}
  
	/*====================================================================
		사용자 정의 함수
	====================================================================*/


	function fn_save(){
		
		if( !$("input:radio[name='planType']").is(":checked") ){
			alert("[평가유형]을 선택하세요.");
			$("#planType1").focus();
			return;
		}
		
		if( $("#startDate").val() == "" ){
			alert("[평가 시작일]을 선택하세요.");
			$("#startDate").focus();
			return;
		}
		
		if( $("#endDate").val() == "" ){
			alert("[평가 종료일]을 선택하세요.");
			$("#endDate").focus();
			return;
		}
		
		if( $("#stdMemName").val() == "" || $("#stdMemSeq").val() == "" ){
			alert("[학생]을 선택하세요.");
			$("#btn-student-search").focus();
			return;
		}
		
		if($("#score").val()=="0" || $("#score").val()==""){
			alert("[성적]을 입력하세요.");
			$("#score").focus();
			return;
		}
		
		if( $("#atchFiles").val() == "" ){
			alert("[첨부파일]을 등록하세요.");
			$("#atchFiles").focus();
			return;
		}
		
		if(doubleSubmitCheck()) return;
		
		var reqUrl =  "/lu/eval/insertInsideEvalStd.do";
		$("#frmEvalPlan").attr("enctype", "multipart/form-data" );
		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").attr("target", "_self");
		$("#frmEvalPlan").submit();
	}

	function fn_choice(memSeq,memName){
		$("#stdMemSeq").val("");
		$("#stdMemName").val("");
		
		$("#stdMemSeq").val(memSeq);
		$("#stdMemName").val(memName);
		$(".close-modal").click();
	}
	

</script>


<h2>내부평가</h2>
<h4 class="mb-010"><span>${subjectVO.subjectName} / ${subjectVO.subjectCode}</span> (${subjectVO.subjectClass}반) ㅣ ${subjectVO.yyyy}학년도 ${subjectVO.termName}</h4>				
				
					<div class="group-area mt-020">
						
						<form id="frmEvalPlan" name="frmEvalPlan" method="post">
						<input type="hidden" id="yyyy" name="yyyy" value="${subjectVO.yyyy}" />
						<input type="hidden" id="term" name="term" value="${subjectVO.term}" />
						<input type="hidden" id="subjectCode" name="subjectCode" value="${subjectVO.subjectCode}" />
						<input type="hidden" id="subClass" name="subClass" value="${subjectVO.subjectClass}" />	
						<input type="hidden" id="status" name="status" value="0" />
						
						<table class="type-write mt-020">						
							<tbody>
								<tr>
									<th>평가유형</th>
									<td>
										<input type="radio" id="planType1" name="planType" class="choice" value="1"> <label for="planType1">중간고사</label>
										&nbsp;&nbsp;<input type="radio" id="planType2" name="planType" class="choice" value="2"> <label for="planType2">기말고사</label>
										<input type="hidden" id="stdMemName" name="stdMemName" value="${stdMemName}" >
										<input type="hidden" id="stdMemSeq" name="stdMemSeq" value="${stdMemSeq}"/>
									</td>
								</tr>	
								<tr>
									<th>시작일</th>
									<td><input type="text" id="startDate" name="startDate" value="" class="" readonly="readonly" style="width: 120px;"></td>  
								</tr>	
								<tr>
									<th>종료일</th>
									<td><input type="text" id="endDate" name="endDate" value="" class="" readonly="readonly" style="width: 120px;"></td>
								</tr>	
								<tr>  
									<th>성적</th>
									<td><input type="text" id="score" name="score" value="" class="" maxlength="1" placeholder="ex) 1~10점 내로 입력하세요." style="width: 240px;"></td>
								</tr>	
								<tr>
									<th>첨부파일</th>
									<td><input type="file" id="atchFiles" name="atchFiles"></td>
								</tr>	
								<tr>
									<th>첨부파일</th>
									<td><input type="file" id="atchFiles1" name="atchFiles1"></td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td><input type="file" id="atchFiles2" name="atchFiles2"></td>
								</tr>			
							</tbody>
						</table>
						
						</form>
						
						<div class="btn-area  mt-010">
							<div class="float-right">
								<a href="#!" onclick="fn_save();" class="yellow">등록</a>
								<a href="/lu/eval/listInsideEval.do" class="black ">취소</a>
							</div>
						</div>
						
						
						<!--  학생검색 팝업 -->
						<div id="student-search" class="modal">
							<div class="modal-title">학생 검색</div>
							<div class="modal-body hauto">
								<!--  검색 -->
								<!-- <div class="search_box2"> 
									<fieldset>
									<legend>게시물 검색</legend>
										<select id="" name="" class="select">
											<option value="" >학생명</option>
										</select>
										<input id="searchWrd" name="searchWrd" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
										<button class="btn btn-black btn-sch">검색</button> 
									</fieldset>
								 </div> -->
								 <!--  //검색 -->
								
								<!--  검색결과 -->
								<div class="table-box2">
									<table class="type-2 wp100">
										<thead>
											<tr>
												<th>학번</th>
												<th>학생명</th>
												<th>선택</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<tr>
												<td><a href="javascript:fn_choice('${result.memSeq}','${result.memName}');">${result.memId}</a></td>
												<td><a href="javascript:fn_choice('${result.memSeq}','${result.memName}');">${result.memName}</a></td>
												<td><a href="javascript:fn_choice('${result.memSeq}','${result.memName}');">[선택]</a></td>
											</tr>
										</c:forEach>	
										<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="2"><spring:message code="common.nodata.msg" /></td>
										</tr>
										</c:if>
										</tbody>
									</table>
								</div>
								<!--  검색결과 -->
							</div>
						</div>
						<!--  //학생검색 팝업  -->
						
						
					</div>
				



