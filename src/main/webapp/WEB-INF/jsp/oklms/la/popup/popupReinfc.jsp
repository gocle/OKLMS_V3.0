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
		<c:forEach var="result" items="${resultList}" varStatus="status">
			com.datepickerDateFormat("reinfcTraningDate${result.weekCnt}" , 'button');
		</c:forEach>
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
	
	/* 리스트 조회 */
	function fn_search(  ){
		
		
		var reqUrl = "/la/popup/popup/popupSubjectAdmReinfcPop.do";
		$("#frmWeek").attr("action", reqUrl);
		$("#frmWeek").attr("target","_self");
		$("#frmWeek").submit();
	}
	
	function fn_reinfcTraningDateInit(id){
		$("#"+id).val("");
	}
	
	function fn_allReinfcTraningDateInit(){
		<c:forEach var="result" items="${resultList}" varStatus="status">
			fn_reinfcTraningDateInit("reinfcTraningDate${result.weekCnt}");
		</c:forEach>
	}
	
	/* 아우누리 연계 */
	function fn_saveSubjectAdmReinfc(){
		
		var reqUrl = "/la/popup/popup/popupSubjectAdmReinfcSave.json";
		var yyyy = $("#yyyy").val();
		var term = $("#term").val();
		
		if( yyyy == "" ){
			alert("학년도를 선택하세요.");
			$("#yyyy").focus();
			return;
		}
		
		if( term == "" ){
			alert("학기를 선택하세요.");
			$("#term").focus();
			return;
		}
		
		<c:if test="${fn:length(resultList) == 0}">
			alert("주차정보가 없습니다.");
			return;
		</c:if>
		
		var param = $("#frmWeek").serializeArray();
		
		com.ajax4confirm( "저장 하시겠습니까?" , reqUrl, param, function(obj, data, textStatus, jqXHR){						
			if (200 == jqXHR.status ) {
				
				//com.alert( jqXHR.responseJSON.retMsg );
				
				if( "SUCCESS" == jqXHR.responseJSON.retCd ){
					
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


<div id="popup-wrarpr">
<div id="popup-header">
	<h1><img src="/images/oklms/adm/inc/pop_border_02.png" alt="" />Off-JT 휴보강 관리</h1>
	<p><a href="#" onclick="parent.close();">닫기</a></p>
</div><!-- E : p-header -->

<div id="popup-content-area">
	<div id="popup-container">

<!-- 팝업 내용 영역 시작 : 가로 650px , 세로 560px -->
<form id="frmWeek" name="frmWeek" method="post">
<ul class="search-list-1">
	<li>
		<select name="yyyy" id="yyyy" style="width: 120px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">학년도</option>
			<option value="2019"  <c:if test="${subjectVO.yyyy eq '2019' }" > selected="selected"  </c:if>>2019</option>
			<option value="2018"  <c:if test="${subjectVO.yyyy eq '2018' }" > selected="selected"  </c:if>>2018</option>
			<option value="2017"  <c:if test="${subjectVO.yyyy eq '2017' }" > selected="selected"  </c:if>>2017</option>
			<option value="2016"  <c:if test="${subjectVO.yyyy eq '2016' }" > selected="selected"  </c:if>>2016</option>
			<option value="2015"  <c:if test="${subjectVO.yyyy eq '2015' }" > selected="selected"  </c:if>>2015</option>
		</select>
		&nbsp;&nbsp;&nbsp;
		<select name="term" id="term" style="width: 100px; margin-right: 10px;" onchange="javascript:fn_search(1);">
			<option value="">학기</option>
			<option value="1" <c:if test="${subjectVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
			<option value="2" <c:if test="${subjectVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
			<option value="3" <c:if test="${subjectVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
			<option value="4" <c:if test="${subjectVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
		</select>
		<!-- <a href="#fn_search()" onclick="javascript:fn_search(1); return false;" onkeypress="this.onclick;"  class="btn-1">검색</a> -->
	</li>
</ul>
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="15%">주차</th>
			<th width="24%">훈련일자</th>
			<th width="24%">보강일자</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>${result.weekCnt} 주차</td>
			<td>${result.traningDate}</td>
			<td>
				<input type="text" name="reinfcTraningDates" id="reinfcTraningDate${result.weekCnt}" value="${result.reinfcTraningDate}" style="width:65px" readonly /> &nbsp;<a href="#fn_reinfcTraningDateInit()" onclick="javascript:fn_reinfcTraningDateInit('reinfcTraningDate${result.weekCnt}');"  class="btn-1">초기화</a>
				<input type="hidden" name="weekCnts"  id="weekCnt${result.weekCnt}"  value="${result.weekCnt}"/>
			</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="3">학년도 학기 선택 후 진행하십시요.</td>
			</tr>
		</c:if>
	</tbody>
</table><!-- E : view-1 -->
</form>		
<!-- 팝업 내용  영역 끝 -->

<div class="page-btn">
	<a href="#fn_send_mail" onclick="javascript:fn_saveSubjectAdmReinfc();" onkeypress="this.onclick;">저장</a>
</div><!-- E : page-btn -->

	</div><!-- E : p-contentiner -->
</div><!-- E : p-content-area -->
	<div id="popup-footer"></div><!-- E : p-footer -->
</div><!-- E : p-wrapper -->

		
		