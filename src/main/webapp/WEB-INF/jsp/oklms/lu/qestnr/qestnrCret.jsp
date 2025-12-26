<%@page import="kr.co.gocle.oklms.comm.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="kr.co.gocle.oklms.comm.util.Config" %>

<link href="/js/jquery/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" type="text/css" />

<c:set var="targetUrl" value="/lu/qestnr/"/>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript" src="${contextRootJS }/common/smartEditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
	var targetUrl = "${targetUrl}";

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
		$(".requare").css("color", "red"); //필수값 * 빨간색 표시 css
		com.datepickerDateFormat('qustnrStartDate');
 	    com.datepickerDateFormat('qustnrEndDate');
 	    $("#qustnrSj").focus();
	}

	/*====================================================================
	사용자 정의 함수
	====================================================================*/

	/* 입력 필드 초기화 */
	function fn_formReset( param1 ){
	}

	/* .저장 */
	function fn_formSave(){
		if (fn_formValidate() && confirm("저장 하시겠습니까?")) {
			var reqUrl = CONTEXT_ROOT + targetUrl + "insertQestnr.do";

			$("#frmQestnr").attr("method", "post" );
			$("#frmQestnr").attr("action", reqUrl);
			$("#frmQestnr").submit();
		}
	}

	//저장버튼 클릭시 입력form Validate 체크
	function fn_formValidate(){
		var startDate = "";
		var endDate = "";

		if($("#qustnrSj").val() == ""){
			alert("설문 제목을 입력 주세요.");
			$("#qustnrSj").focus();
			return false;
		}

		if($("#qustnrStartDate").val() == ""){
			alert("설문 시작일을 선택 주세요.");
			$("#qustnrStartDate").focus();
			return false;
		}

		if($("#qustnrEndDate").val() == ""){
			alert("설문 종료일을 선택 주세요.");
			$("#qustnrEndDate").focus();
			return false;
		}

		startDate = $("#qustnrStartDate").val();
		endDate = $("#qustnrEndDate").val();

		startDate = startDate.replace(".","");
		startDate = startDate.replace(".","");
		endDate = endDate.replace(".","");
		endDate = endDate.replace(".","");

		// 시작일이 종료일보다 큰지 비교
		if(Number(startDate) > Number(endDate)){
			alert("설문 종료일이 시작일보다 전날짜입니다.");
			$("#qustnrEndDate").focus();
			return false;
		}

		if($("#qustnrPurps").val() == ""){
			alert("설문 내용을 입력 주세요.");
			$("#qustnrPurps").focus();
			return false;
		}
 

		return true;
	}

	/* 목록 페이지로 이동 */
	function fn_list(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listQestnr.do";

		$("#frmQestnr").attr("method", "post" );
		$("#frmQestnr").attr("action", reqUrl);
		$("#frmQestnr").submit();
	}

</script>

<%-- 팝업폼 --%>
<form id="frmQestnr" name="frmQestnr" method="post" >
<input type="hidden" id="yyyy" name="yyyy" value="${qestnrVO.yyyy}" />
<input type="hidden" id="term" name="term" value="${qestnrVO.term}" />
<input type="hidden" id="subjectCode" name="subjectCode" value="${qestnrVO.subjectCode}" />
<input type="hidden" id="subClass" name="subClass" value="${qestnrVO.subClass}" />

<div id="">
	<h2>설문</h2>
	<h4 class="mb-010"><span><c:if test="${currProcReadVO.onlineTypeName eq '온라인'}">[ONLINE]</c:if>${currProcReadVO.subjectName} / ${currProcReadVO.subjectCode} (${currProcReadVO.subClass}분반)</span> ㅣ {currProcReadVO.yyyy}학년도 / ${currProcReadVO.termName}</h4>

		<table class="type-1 mb-040">
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

	<h2>(${currProcReadVO.subjectName}) 설문 작성</h2>
	<table class="type-write mt-010">
		<colgroup>
			<col width="130px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th><span class="requare">*</span>제목</th>
				<td><input type="text" id="qustnrSj" name="qustnrSj"  maxlength="497" placeholder="(ex)설문제목 입력" value=""  /></td>
			</tr>
			<tr>
				<th><span class="requare">*</span>시작일</th>
				<td><input type="text" id="qustnrStartDate" name="qustnrStartDate"  placeholder="(ex)2016.09.01" value="" readonly="readonly"  style="width:130px" /></td>
			</tr>
			<tr>
				<th><span class="requare">*</span>종료일</th>
				<td><input type="text" id="qustnrEndDate" name="qustnrEndDate"  placeholder="(ex)2016.09.01" value="" readonly="readonly"  style="width:130px"  /></td>
			</tr>
			<tr>
				<th><span class="requare">*</span>설문내용</th>
				<td>
				<textarea class="form-control" id="qustnrPurps" name="qustnrPurps" placeholder="(ex)설문내용 입력" ></textarea></td>
			</tr>
			<tr>
				<th>설문정답</th>
				<td><input type="text" id="qustnrAnswer" name="qustnrAnswer"  maxlength="497" placeholder="(ex)설문정답 입력" value=""  /></td>
			</tr>			
			<tr>
				<th rowspan="11"><span class="requare">*</span>설문보기</th>
				<td><label for="qestnCn1" class="mr-010">[ 보기 01 ]</label><input type="text" id="qestnCn1" name="qestnCn1" maxlength="2047" placeholder="(ex)설문보기1 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn2" class="mr-010">[ 보기 02 ]</label><input type="text" id="qestnCn2" name="qestnCn2" maxlength="2047" placeholder="(ex)설문보기2 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn3" class="mr-010">[ 보기 03 ]</label><input type="text" id="qestnCn3" name="qestnCn3" maxlength="2047" placeholder="(ex)설문보기3 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn4" class="mr-010">[ 보기 04 ]</label><input type="text" id="qestnCn4" name="qestnCn4" maxlength="2047" placeholder="(ex)설문보기4 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn5" class="mr-010">[ 보기 05 ]</label><input type="text" id="qestnCn5" name="qestnCn5" maxlength="2047" placeholder="(ex)설문보기5 입력" value="" style="width:85%;" /></td>
			</tr>
			
			<tr>
				<td class="border-left"><label for="qestnCn6" class="mr-010">[ 보기 06 ]</label><input type="text" id="qestnCn6" name="qestnCn6" maxlength="2047" placeholder="(ex)설문보기6 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn7" class="mr-010">[ 보기 07 ]</label><input type="text" id="qestnCn7" name="qestnCn7" maxlength="2047" placeholder="(ex)설문보기7 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn8" class="mr-010">[ 보기 08 ]</label><input type="text" id="qestnCn8" name="qestnCn8" maxlength="2047" placeholder="(ex)설문보기8 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn9" class="mr-010">[ 보기 09 ]</label><input type="text" id="qestnCn9" name="qestnCn9" maxlength="2047" placeholder="(ex)설문보기9 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left"><label for="qestnCn10" class="mr-010">[ 보기 10 ]</label><input type="text" id="qestnCn10" name="qestnCn10" maxlength="2047" placeholder="(ex)설문보기10 입력" value="" style="width:85%;" /></td>
			</tr>
			<tr>
				<td class="border-left">기타&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>			
			<input type="hidden" name="etcAnswerAt" value="Y" />	
<!-- 			<tr>
				<td class="border-left">[ 기  타 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="" maxlength="" placeholder="(ex)기타입력있음 선택시 입력" value="" style="width:85%;" disabled="disabled" /></td>
			</tr> -->
<!-- 			<tr>
				<td class="border-left">
					<input type="radio" id="etcAnswerAt" name="etcAnswerAt" value="Y" class="choice" /> 기타 입력 있음&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" id="etcAnswerAt" name="etcAnswerAt" value="N" class="choice" checked /> 기타 입력 없음
				</td>
			</tr>
 -->			
		</tbody>
	</table>

	<div class="btn-area align-right mt-010">
		<a href="#!" onclick="javascript:fn_list(); return false" class="black">목록</a>
		<a href="#!" onclick="javascript:fn_formSave(); return false" class="black">저장</a>
	</div><!-- E : btn-area -->

</div><!-- E : content-area -->

</form>




