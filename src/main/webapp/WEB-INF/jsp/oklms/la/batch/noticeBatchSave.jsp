<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2016. 12. 14 오후 1:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>

<c:set var="targetUrl" value="/la/batch/"/>

<script type="text/javascript">

	var targetUrl = "${targetUrl}";
	
	$(document).ready(function() {
	//	alert("${mailVO.trCallback}");
		loadPage();	
		
		$(document).on("keyup", "input:text[name='repDay']", function() {
			$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
		});
		
		$(document).on("keyup", "input:text[name='disDay']", function() {
			$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
		});
		
		$(document).on("keyup", "input:text[name='tprDay']", function() {
			$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
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

// 		doAction('formReset');
	}
	

	/*====================================================================
		조회버튼이나 페이지 클릭시 실행되는 함수는 꼭 doAction(sAction)으로 만들어 사용해 주시기 바랍니다.
	====================================================================*/

	

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
	
	function fn_insert_notice_batch(){
		if(confirm("저장하시겠습니까?")){
		  	var reqUrl = CONTEXT_ROOT + targetUrl + "insertNoticeBatch.do";
			$("#frmMail").attr("method", "post" );
			$("#frmMail").attr("action", reqUrl);
			$("#frmMail").submit();	
		}
	}
	

	
</script>
<!-- <div class="title-name-1"></div> -->

<form id="frmMail" name="frmMail"  method="post">

 


<table border="0" cellpadding="0" cellspacing="0" class="view-1">
	<tbody>
		
		<tr>
			<th width="10%" style="text-align: center;">설정항목</th>
			<th width="10%" style="text-align: center;" >알림일</th>
			<th width="10%" style="text-align: center;" >SMS 사용여부</th>
			<th width="10%" style="text-align: center;">이메일 사용여부</th>
			<th width="10%" style="text-align: center;">마감일까지 메일발송여부<br/>(알림일~마감일)</th>
		</tr>
		
		<tr>
			<td style="text-align: center;">과제</td>
			<td style="text-align: center;">제출&nbsp;&nbsp;<input type="text" name="repDay" id="repDay" value="${mailVO.repDay}" maxlength="2" size="2">&nbsp;&nbsp;일 전</td>
			<td style="text-align: center;"><input type="radio" name="repSmsUseYn" id="repSmsUseYn" value="Y" ${mailVO.repSmsUseYn eq 'Y' ? 'checked' : ''}/>&nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="repSmsUseYn" id="repSmsUseYn" value="N"  ${mailVO.repSmsUseYn eq 'N' ? 'checked' : ''}/>&nbsp;&nbsp;미사용</td>
			<td style="text-align: center;"><input type="radio" name="repMailUseYn" id="repMailUseYn" value="Y" ${mailVO.repMailUseYn eq 'Y' ? 'checked' : ''}/>&nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="repMailUseYn" id="repMailUseYn" value="N" ${mailVO.repMailUseYn eq 'N' ? 'checked' : ''}/>&nbsp;&nbsp;미사용</td>
			<td style="text-align: center;"><input type="radio" name="repDailyYn" id="repDailyYn" value="Y" ${mailVO.repDailyYn eq 'Y' ? 'checked' : ''}/>&nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="repDailyYn" id="repDailyYn" value="N" ${mailVO.repDailyYn eq 'N' ? 'checked' : ''}/>&nbsp;&nbsp;미사용</td>
		</tr>
		<tr>
			<td style="text-align: center;">토론</td>
			<td style="text-align: center;">마감&nbsp;&nbsp;<input type="text" name="disDay" id="disDay" value="${mailVO.disDay}" maxlength="2" size="2">&nbsp;&nbsp;일 전</td>
			<td style="text-align: center;"><input type="radio" name="disSmsUseYn" id="disSmsUseYn" value="Y" ${mailVO.disSmsUseYn eq 'Y' ? 'checked' : ''}/>&nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="disSmsUseYn" id="disSmsUseYn" value="N" ${mailVO.disSmsUseYn eq 'N' ? 'checked' : ''} />&nbsp;&nbsp;미사용</td>
			<td style="text-align: center;"><input type="radio" name="disMailUseYn" id="disMailUseYn" value="Y" ${mailVO.disMailUseYn eq 'Y' ? 'checked' : ''}/> &nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="disMailUseYn" id="disMailUseYn" value="N" ${mailVO.disMailUseYn eq 'N' ? 'checked' : ''} />&nbsp;&nbsp;미사용</td>
			<td style="text-align: center;"><input type="radio" name="disDailyYn" id="disDailyYn" value="Y" ${mailVO.disDailyYn eq 'Y' ? 'checked' : ''}/> &nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="disDailyYn" id="disDailyYn" value="N" ${mailVO.disDailyYn eq 'N' ? 'checked' : ''} />&nbsp;&nbsp;미사용</td>
		</tr>
		
		<tr>
			<td style="text-align: center;">팀 프로젝트</td>
			<td style="text-align: center;">제출&nbsp;&nbsp;<input type="text" name="tprDay" id="tprDay" value="${mailVO.tprDay}" maxlength="2" size="2">&nbsp;&nbsp;일 전</td>
			<td style="text-align: center;"><input type="radio" name="tprSmsUseYn" id="tprSmsUseYn" value="Y" ${mailVO.tprSmsUseYn eq 'Y' ? 'checked' : ''}/>&nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="tprSmsUseYn" id="tprSmsUseYn" value="N" ${mailVO.tprSmsUseYn eq 'N' ? 'checked' : ''} />&nbsp;&nbsp;미사용</td>
			<td style="text-align: center;"><input type="radio" name="tprMailUseYn" id="tprMailUseYn" value="Y" ${mailVO.tprMailUseYn eq 'Y' ? 'checked' : ''}/>&nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="tprMailUseYn" id="tprMailUseYn" value="N" ${mailVO.tprMailUseYn eq 'N' ? 'checked' : ''} />&nbsp;&nbsp;미사용</td>
			<td style="text-align: center;"><input type="radio" name="tprDailyYn" id="tprDailyYn" value="Y" ${mailVO.tprDailyYn eq 'Y' ? 'checked' : ''}/>&nbsp;&nbsp;사용&nbsp;&nbsp;<input type="radio" name="tprDailyYn" id="tprDailyYn" value="N" ${mailVO.tprDailyYn eq 'N' ? 'checked' : ''} />&nbsp;&nbsp;미사용</td>
		</tr>
		
		
	</tbody>
</table><!-- E : view-1 -->
</form>

<div class="page-btn">
	<a href="#fn_insert_notice_batch" onclick="javascript:fn_insert_notice_batch();" onkeypress="this.onclick;">저장</a>
</div><!-- E : page-btn -->	

