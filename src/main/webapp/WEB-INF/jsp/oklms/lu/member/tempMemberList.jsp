<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2017. 02.27  오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>

<style type="text/css">
</style>

<c:set var="targetUrl" value="/lu/temp/"/>
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
		
	}

	/*====================================================================
		사용자 정의 함수
	====================================================================*/

/* 	function press(event) {
		if (event.keyCode==13) {
			fn_search();
		}
	} */

	/* 기업체 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompanyMember.do";

		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").attr("target", "_self");
		$("#frmMember").submit();
	}
	
	/* 기업체 리스트 조회 */
	function fn_approval( emplNo ){
		$("#emplNo").val( emplNo );

		var reqUrl = "/lu/temp/approvalTempMember.do";
		if(confirm("승인처리 하시겠습니까?")){
			$("#frmTemp").attr("action", reqUrl);
			$("#frmTemp").attr("target", "_self");
			$("#frmTemp").submit();
		}
	}
	
	/* 기업체 리스트 조회 */
	function fn_delete( emplNo ){
		$("#emplNo").val( emplNo );
		
		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = "/lu/temp/deleteTempMember.do";
		if(confirm("삭제 하시겠습니까?")){
			$("#frmTemp").attr("action", reqUrl);
			$("#frmTemp").attr("target", "_self");
			$("#frmTemp").submit();
		}
	}
	
	
</script>


<!--  회원정보용 -->
<form id="frmTemp" name="frmTemp" method="post">
<input type="hidden" name="memSeq" id="memSeq" />

<input type="hidden" id="emplNo" name="emplNo" />

<ul id="student-popup" style="display:none;">
	<li class="company-area" style="margin-left:-350px; margin-top:-119px;">
		<h1>기업체 검색</h1>
		<div class="search-box-1 mb-020">
			<input type="text" id="searchKeyword" name="searchKeyword" style="width:200px" placeholder="기업명을 입력" value="${searchKeyword}" />
			<a href="#!" onclick="javascript:fn_search(1); return false">조회</a>
			<a href="#!" onclick="javascript:fn_searchKeywordNo(1); return false">전체 조회</a>
		</div><!-- E : search-box-1 -->


			<c:if test="${fn:length(resultCompanyList) != 0}">
			<div class="page-num mt-015">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_searchPaging" />
			</div>
			</c:if>

		<div class="btn-area align-center mt-010">
			<a href="#fn_closeCompanypop" class="yellow close" onclick="javascript:fn_closeCompanypop(); return false" onkeypress="this.onclick();">닫기</a>
			<a href="#fn_hideCompanypop" class="orange close" onclick="javascript:fn_hideCompanypop(); return false" onkeypress="this.onclick();">확인</a>
		</div><!-- E : btn-area -->
	</li>

	<li class="popup-bg"></li>
</ul><!-- E : student-popup -->

	<div id="">
			<h2>기업전담자 신규 승인</h2>
			

			<div class="group-area mt-010">
				<div class="table-responsive">
					<table class="type-2">
						<colgroup>
							<col style="*" />
							<col style="width:8%" />
							<col style="width:8%" />
							<col style="width:10%" />
							<col style="width:12%" />
							<col style="width:20%" />
							<col style="width:8%" />
							<col style="width:8%" />
						</colgroup>
						<thead>
							<tr>
								<th>회사명</th>
								<th>회원유형</th>
								<th>성명</th>
								<th>아이디</th>
								<th>핸드폰</th>
								<th>이메일</th>
								<th>등록일</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td>${result.companyName}</td>
								<td>${fn:indexOf(result.authGroupId, 'COT') > 0 ? '기업현장교사' : ''}${fn:indexOf(result.authGroupId, 'CCM') > 0 ? 'HRD전담자' : ''}</td>
								<td>${result.koreanNm}</td>
								<td>${result.loginId}</td>
								<td>${result.mbtlnum}</td>
								<td>${result.email}</td>
								<td>${fn:substring(result.regDt,0,10)}</td>
								<td>
									<a href="#fn_addTraingSearchPopup" onclick="javascript:fn_approval('${result.emplNo}'); return false" class="btn-full-blue">승인</a>
									<a href="#fn_addTraingSearchPopup" onclick="javascript:fn_delete('${result.emplNo}'); return false" class="btn-full-gray">삭제</a>
								</td>	
								</tr>
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="8">자료가 없습니다.</td>
							</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				

			</div><!-- E :  list-->


	</div><!-- E : container -->

	<script type="text/javascript">

	</script>
</form>






