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
		
		/* if( $("#atchFiles").val() == "" || $("#atchFiles1").val() == "" || $("#atchFiles2").val() == "" || $("#atchFiles3").val() == ""){
			alert("[첨부파일]을 등록하세요.");
			$("#atchFiles").focus();
			return;
		} */
		
		if(doubleSubmitCheck()) return;
		
		var reqUrl =  "/lu/eval/updateInsideEval.do";
		$("#frmEvalPlan").attr("enctype", "multipart/form-data" );
		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").attr("target", "_self");
		$("#frmEvalPlan").submit();
	}
	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	
	function fn_delete(){
		if(confirm("삭제 하시겠습니까?")){
			if(doubleSubmitCheck()) return;
			var reqUrl =  "/lu/eval/deleteInsideEval.do";
			$("#frmEvalPlan").attr("action", reqUrl);
			$("#frmEvalPlan").attr("target", "_self");
			$("#frmEvalPlan").submit();
		}
	}
	
	function fn_statusl(){
		if(confirm("승인요청 하시겠습니까?")){
			if(doubleSubmitCheck()) return;
			$("#status").val("1");
			var reqUrl =  "/lu/eval/saveInsideEval.do";
			$("#frmEvalPlan").attr("enctype", "multipart/form-data" );
			$("#frmEvalPlan").attr("action", reqUrl);
			$("#frmEvalPlan").attr("target", "_self");
			$("#frmEvalPlan").submit();
		}
	}

	function fn_choice(memSeq,memName){
		$("#stdMemSeq").val("");
		$("#stdMemName").val("");
		$("#stdMemSeq").val(memSeq);
		$("#stdMemName").val(memName);
		$(".close-modal").click();
	}
	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	         
	         var score = $(this).val();
	         
	         if(score > 100){
	        	 $(this).val("");
	         }
	    }); 
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
						<input type="hidden" id="status" name="status" value="" />
						<input type="hidden" id="insideEvalId" name="insideEvalId" value="${result.insideEvalId}" />
						
						<table class="type-write mt-020">						
							<tbody>
								<tr>
									<th>평가유형</th>
									<td>
										<input type="radio" id="planType1" name="planType" class="choice" value="1" ${result.planType eq '1' ? 'checked' : ''}> <label for="planType1">중간고사</label>
										&nbsp;&nbsp;<input type="radio" id="planType2" name="planType" class="choice" value="2" ${result.planType eq '2' ? 'checked' : ''}> <label for="planType2">기말고사</label>
									</td>
								</tr>	
								<tr>
									<th>시작일</th>
									<td><input type="text" id="startDate" name="startDate" value="${result.startDate}" class="" readonly="readonly" style="width: 120px;"></td>  
								</tr>	
								<tr>
									<th>종료일</th>
									<td><input type="text" id="endDate" name="endDate" value="${result.endDate}" class="" readonly="readonly" style="width: 120px;"></td>
								</tr>	
								<tr>
									<th>학생명</th>
									<td>
										<input type="text" id="stdMemName" name="stdMemName" value="${result.stdMemName}" class="input-inline" readonly="readonly">
										<a  href="#student-search" rel="modal:open" class="btn btn-black" id="btn-student-search" style="width:105px; height:35px; line-height:30px">학생 검색</a>
										<input type="hidden" id="stdMemSeq" name="stdMemSeq" value="${result.stdMemSeq}"/>
									</td>
								</tr>	
								<tr>  
									<th>성적</th>
									<td><input type="text" id="score" name="score" value="${result.score}" class="" maxlength="3" placeholder="ex) 1~100점 내로 입력하세요."  onkeydown="onlyNumber(this);" style="width: 240px;"></td>
								</tr>	
								<tr>
									<th>첨부파일</th>
									<td>
									<c:if test="${!empty resultFile}">
											<a href="javascript:com.downFile('${resultFile.atchFileId}','${resultFile.fileSn}');" class="text-file">${resultFile.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a href="javascript:com.deleteFile('${resultFile.atchFileId}|${resultFile.fileSn}', '/lu/eval/getInsideEval.do?insideEvalId=${ result.insideEvalId}');"  class="btn-del">[삭제]</a><br />
									</c:if>					
									<c:if test="${empty resultFile}">				
										<input type="file" id="atchFiles" name="atchFiles">
									</c:if>	
									
									
								<tr>
								
								<tr>
									<th>첨부파일</th>
									<td>
									<c:if test="${!empty resultFile1}">
											<a href="javascript:com.downFile('${resultFile1.atchFileId}','${resultFile1.fileSn}');" class="text-file">${resultFile1.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a href="javascript:com.deleteFile('${resultFile1.atchFileId}|${resultFile1.fileSn}', '/lu/eval/getInsideEval.do?insideEvalId=${ result.insideEvalId}');"  class="btn-del">[삭제]</a><br />
									</c:if>					
									<c:if test="${empty resultFile1}">				
										<input type="file" id="atchFiles1" name="atchFiles1">
									</c:if>	
									</td>
									
								<tr>
								
								<tr>
									<th>첨부파일</th>
									<td>
									<c:if test="${!empty resultFile2}">
											<a href="javascript:com.downFile('${resultFile2.atchFileId}','${resultFile2.fileSn}');" class="text-file">${resultFile2.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a href="javascript:com.deleteFile('${resultFile2.atchFileId}|${resultFile2.fileSn}', '/lu/eval/getInsideEval.do?insideEvalId=${ result.insideEvalId}');"  class="btn-del">[삭제]</a><br />
									</c:if>					
									<c:if test="${empty resultFile2}">				
										<input type="file" id="atchFiles2" name="atchFiles2">
									</c:if>	
									</td>
									
									
								</tr>		
								
								<tr>
									<th>첨부파일</th>
									<td>
									<c:if test="${!empty resultFile3}">
											<a href="javascript:com.downFile('${resultFile3.atchFileId}','${resultFile3.fileSn}');" class="text-file">${resultFile3.orgFileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a href="javascript:com.deleteFile('${resultFile3.atchFileId}|${resultFile3.fileSn}', '/lu/eval/getInsideEval.do?insideEvalId=${ result.insideEvalId}');"  class="btn-del">[삭제]</a><br />
									</c:if>					
									<c:if test="${empty resultFile3}">				
										<input type="file" id="atchFiles3" name="atchFiles3">
									</c:if>	
									</td>
									
									
								</tr>		
								
								
								<tr>
									<th>상태</th>
									<td>
									<%-- <span class="label ${result.status eq '2' ? 'blue' : 'gray'}">
									${result.statusName}
									</span> --%>
									<c:choose>
										<c:when test="${resultlist.status eq '1'}"><span class="label gray">승인대기</span></c:when>
										<c:when test="${resultlist.status eq '2'}"><span class="label blue">승인</span></c:when>
										<c:when test="${resultlist.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnEvalComment"  data-comment="${result.returnComment}" rel="modal:open">반려</a></span></c:when>
									</c:choose>
									</td>
								</tr>	
								<c:if test="${result.status eq '3'}">
								<tr>
									<th>반려사유</th>
									<td>
									${result.statusName}
									</td>
								</tr>		
								</c:if>	
							</tbody>
						</table>
						
						</form>
						
						<div class="btn-area  mt-010">
							<div class="float-right">
								<c:if test="${result.status ne '2'}">
									<a href="#!" onclick="fn_save();" class="yellow">수정</a>
								</c:if>
									<a href="#!" onclick="fn_statusl();" class="yellow">승인요청</a>
								<a href="#!" onclick="fn_delete();" class="black ">삭제</a>
								<a href="/lu/eval/listInsideEval.do" class="black ">취소</a>
							</div>
						</div>
						
						
						
					</div>
				



