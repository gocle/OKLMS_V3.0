<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of gocle LEARN.
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근C    2016. 10. 27 오후 1:20         Modify Draft.
  ~  *
  ~  *******************************************************************************
 --%>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	var pageIndex = '${pageIndex}'; //현재 페이지 정보
	
	
	if ('' == pageIndex) {
		pageIndex = 1;
	}
		/* opener.window.location.replace("/la/company/listCcnCompany.do?pageIndex="+pageIndex+"&searchKeyword="+searchKeyword+"");
		window.self.close();	 */

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
		com.datepickerDateFormat('weekStartDate', 'button');
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
	
	/* 아우누리 연계 */
	function fn_insert_link(){
		
		var reqUrl = CONTEXT_ROOT + "/la/aunuri/insertAunuriLinkTerm.json";
		var param = $("#frmLink").serializeArray();
		var yyyy = $("#yyyy").val();
		var term = $("#term").val();
		var weekStartDate = $("#weekStartDate").val();
		
		if( yyyy == "" || term == "" ){
			alert("연계 가능한 학기가 없습니다.");
			return;
		}
		
		if( weekStartDate == "" ){
			alert("Off-JT 주차 시작일을 선택해야 합니다.");
			return;
		}
		
		com.ajax4confirm( "저장 하시겠습니까?" , reqUrl, param, function(obj, data, textStatus, jqXHR){						
			if (200 == jqXHR.status ) {
				
				//com.alert( jqXHR.responseJSON.retMsg );
				
				if( "SUCCESS" == jqXHR.responseJSON.retCd ){
					opener.window.location.replace("/la/subject/listSubjectAdm.do");
					window.self.close();
				} else {
					alert("처리에 실패했습니다.");
				}
			}
		}, {
    		async : true,
    		type : "POST",
    		spinner : true,
			errorCallback : null,
    		timeout : 300000000			// 기본 30초
  
    	});
	}

</script>

<form id="frmLink" name="frmLink" method="post">
<input type="hidden" name="yyyy" id ="yyyy" value ="${subjectVO.yyyy}"/>
<input type="hidden" name="term" id ="term" value ="${subjectVO.term}"/>
<div id="popup-wrarpr">
<div id="popup-header">
	<h1><img src="/images/oklms/adm/inc/pop_border_02.png" alt="" />교과목 연계</h1>
	<p><a href="#" onclick="parent.close();">닫기</a></p>
</div><!-- E : p-header -->

<div id="popup-content-area">
	<div id="popup-container">

<!-- 팝업 내용 영역 시작 : 가로 650px , 세로 560px -->

<p><font color="red">
교과목 개설 및 수강신청 완료 후 진행 하시길 바랍니다.
</font>
</p>
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="15%">학년도</th>
			<th width="15%">학기</th>
			<th width="15%">Off-JT 1주차 시작일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${!empty subjectVO}">
				<tr>
					<td>${subjectVO.yyyy}학년도</td>
					<td>${subjectVO.termName}</td>
					<td><input type="text" name="weekStartDate" id="weekStartDate" readonly="readonly" style="width:125px;" /></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="3">연계 가능한 학기가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table><!-- E : view-1 -->

<!-- 팝업 내용  영역 끝 -->

<div class="page-btn">
	<a href="#fn_send_mail" onclick="javascript:fn_insert_link();" onkeypress="this.onclick;">교과목 연계</a>
</div><!-- E : page-btn -->

	</div><!-- E : p-contentiner -->
</div><!-- E : p-content-area -->
	<div id="popup-footer"></div><!-- E : p-footer -->
</div><!-- E : p-wrapper -->
</form>		
		
		