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
  ~  * 이진근    2016. 12. 01 오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>


<script type="text/javascript">


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

//         com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}

	/* 리스트 조회 */
	function fn_search( param1 ){
		
		$("#pageIndex").val( param1 );
		
		var reqUrl = "/lu/member/listStdMember.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}

	function fn_save(  ){
		
		var checkedVals = com.getCheckedVal('check0','memSeqs');
		
		if(checkedVals == ''){
			alert("처리 대상을 선택하세요.");
			return;
		}
		
		var reqUrl = "/lu/member/updateStdMember.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}
	
	function fn_allSave(){
		
		var reqUrl = "/lu/member/saveStdMember.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}
	
	function fn_memberComplete(memId){
		$("#searchMemId").val(memId);
		var reqUrl = "/lu/traning/listTraningComplete.do";
		$("#frmTraningstatus").attr("action", reqUrl);
		$("#frmTraningstatus").submit();
	}
</script>

<form id="frmTraningstatus" name="frmTraningstatus"  method="post">
<input type="hidden" name="searchMemId" id="searchMemId" />
</form>
	
	
			
			<!-- 회원정보 팝업용 끝 -->
<form id="frmMember" name="frmMember" action="<c:url value='/lu/member/listStdMember.do'/>" method="post">
			
				<h2>학습근로자 조회</h2>
				<!--  검색 -->
				<div class="search-box-1 mb-020">
					<!-- <select id="searchName" name="searchCnd" onchange="">
						<option value="0">학교전체</option>
						<option value="1">학부</option>
						<option value="2">학과</option>
					</select>
					<select id="searchCnd2" name="searchCnd2" onchange="">
						<option value="0">기업전체</option>
						<option value="1">대기업</option>
						<option value="2">중소기업</option>
					</select> -->
					<select id="searchName" name="searchName" onchange="">
						<option value="">이름+학번+기업명</option>
						<option value="NAME" ${param.searchName eq 'NAME' ? 'selected' : ''}>이름</option>
						<option value="ID" ${param.searchName eq 'ID' ? 'selected' : ''}>학번</option>
						<option value="COMPANY_NAME" ${param.searchName eq 'COMPANY_NAME' ? 'selected' : ''}>기업명</option>
					</select>
					<input type="text" id="searchWord" name="searchWord" value="${param.searchWord}" maxlength="35" placeholder="검색어 입력" onkeypress="javascript:fn_search(1);">
					<a href="#fn_search" onclick="javascript:fn_search(1); return false" onkeypress="this.onclick;">검색</a>
				</div>	
				<!--  //검색 -->
				
				
				<ul class="mb-007">
					<li class="float-left">
						<div class="page-sum">
							총 <b>${fn:length(resultList)}</b>건
						</div>
					</li>
					<li class="float-right">
						<div class="btn-area">
							<c:if test="${loginAuthGroupId ne '2016AUTH0000006'}">
								<a href="#!" onclick="fn_allSave();" class="black">전체 저장하기</a>
							</c:if>
						</div>
					</li> 
				</ul>
			
				<div class="clearfix"></div>	
				
				<div class="table-responsive mt-010">
					<table class="type-2">
						<colgroup>
							<col style="width:50px">
							<col style="*">
							<col style="width:80px">
							<col style="width:50px">
							<col style="width:80px">
							<col style="width:80px">
							<col style="width:80px">
							<col style="width:150px">
							<col style="width:200px">
							<col style="width:60px">
							<col style="width:60px">
							<col style="width:60px">
							<col style="*">
							<col style="*">
							<!-- <col style="width:60px"> -->
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="check0" name="check0" onclick="javascript:com.checkAll('check0','memSeqs');" class="choice" /></th>
								<th>기업명</th>
								<th>학번</th>
								<th>분반</th>
								<th>사진</th>
								<th>성명<br />직급</th>
								<th>생년월일</th>
								<th>핸드폰</th>
								<th>이메일</th>
								<th>현장<br />훈련</th>
								<th>근무<br />환경</th>
								<th>학습<br />근로자</th>
								<th>특이사항</th>
								<th>센터</th>
								<!-- <th>비고</th> -->
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
							 	<td>
							 	<input type="checkbox" id="memSeq${status.count}" name="memSeqs" value='<c:out value="${result.memSeq}"/>' class="choice" />
							 	<input type="hidden" id="memSeqs${status.count}" name="memSeqss" value="${result.memSeq}">
							 	</td>
								<td>${result.companyName}
								<br/>
								${result.compAddress} ${result.compAddressDtl}
								
								</td>
								<td>${result.memId}</td>
								<td>${result.subjectClass}</td>
								<td>
									<div class="info-photo"><img src="/commbiz/photo/getAunuriUserImage.do?memId=${result.memId}" onerror="this.src='/images/oklms/nonimg.gif'" alt=""></div>
								</td>		
								<td><a href="javascript:fn_memberComplete(${result.memId});" style="color: blue; text-decoration: underline;">${result.memName}</a><br />${result.dutyNm}</td>			
								<td>${result.memBirth}</td>
								<td>${result.hp}</td>
								<td>${result.email}</td>
								<td>
									<select id="etcGrade1${status.count}" name="etcGrade1s">
										<option value="A" ${result.etcGrade1 eq 'A' ? 'selected' : ''}>A</option>
										<option value="B" ${result.etcGrade1 eq 'B' ? 'selected' : ''}>B</option>
										<option value="C" ${result.etcGrade1 eq 'C' ? 'selected' : ''}>C</option>
									</select>
								</td>
								<td>
									<select id="etcGrade2${status.count}" name="etcGrade2s">
										<option value="A" ${result.etcGrade2 eq 'A' ? 'selected' : ''}>A</option>
										<option value="B" ${result.etcGrade2 eq 'B' ? 'selected' : ''}>B</option>
										<option value="C" ${result.etcGrade2 eq 'C' ? 'selected' : ''}>C</option>
									</select>
								</td>
								<td>
									<select id="etcGrade3${status.count}" name="etcGrade3s">
										<option value="A" ${result.etcGrade3 eq 'A' ? 'selected' : ''}>A</option>
										<option value="B" ${result.etcGrade3 eq 'B' ? 'selected' : ''}>B</option>
										<option value="C" ${result.etcGrade3 eq 'C' ? 'selected' : ''}>C</option>
									</select>
								</td>
								<td>
									<textarea id="bigo1${status.count}" name="bigo1s"  style="width: 100%; border:1px solid #ddd" rows="3" maxlength="150" placeholder="(ex)내용 입력">${result.bigo1}</textarea>
								</td>
								
								
								<td>
									<textarea id="bigo2${status.count}" name="bigo2s" style="width: 100%; border:1px solid #ddd" rows="3"  maxlength="150"  placeholder="(ex)내용 입력">${result.bigo2}</textarea>
								</td>
								
								<!-- <td><a href="#!" class="btn btn-primary">저장</a></td>	  -->		
							</tr>
						</c:forEach>
							
							
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="13"><spring:message code="common.nodata.msg" /></td>
							</tr>
						</c:if>
									
						</tbody>
					</table>
				</div>
				<c:if test="${loginAuthGroupId ne '2016AUTH0000006'}">
					<div class="btn-area align-right mt-010">
						<a href="#!" onclick="fn_save();" class="yellow float-left">선택 저장하기</a>
						<a href="#!" onclick="fn_allSave();" class="black ">전체 저장하기</a>
					</div>
				</c:if>
</form>


<script>

<c:choose>
	<c:when test="${loginAuthGroupId eq '2016AUTH0000005'}">
		$('textarea[name="bigo1s"]').prop('disabled', true); // disable
		$('select[name="etcGrade1s"]').prop('disabled', true); // disable
		$('select[name="etcGrade2s"]').prop('disabled', true); // disable
		$('select[name="etcGrade3s"]').prop('disabled', true); // disable
	</c:when>
	<c:when test="${loginAuthGroupId eq '2016AUTH0000003'}">
		$('textarea[name="bigo2s"]').prop('disabled', true); // disable
	</c:when>
	<c:when test="${loginAuthGroupId eq '2016AUTH0000006'}">
		$('select[name="etcGrade1s"]').prop('disabled', true); // disable
		$('select[name="etcGrade2s"]').prop('disabled', true); // disable
		$('select[name="etcGrade3s"]').prop('disabled', true); // disable
		$('textarea[name="bigo1s"]').prop('disabled', true); // disable
		$('textarea[name="bigo2s"]').prop('disabled', true); // disable
	</c:when>
</c:choose>



</script>
	
	
<%-- <ul class="search-list-1">
	<li>
		<span>회원유형</span>
		<select name="searchAuthGroupId" id="searchAuthGroupId" style="width:120px">
	  			<option selected value=''>전체</option>
	  			<c:forEach var="searchAuthGroupCd" items="${searchAuthGroupCode}" varStatus="status">
					<option value="${searchAuthGroupCd.codeId}" ${searchAuthGroupCd.codeId == memberVO.searchAuthGroupId ? 'selected="selected"' : '' }>${searchAuthGroupCd.codeName}</option>
				</c:forEach>
		 </select>
		 &nbsp;
		 <select name="searchName" id="searchName" style="width:70px">
 			<option selected value=''>전체</option>
 			<c:forEach var="searchMemberCd" items="${searchMemberCode}" varStatus="status">
				<option value="${searchMemberCd.codeId}" ${searchMemberCd.codeId == memberVO.searchName ? 'selected="selected"' : '' }>${searchMemberCd.codeName}</option>
			</c:forEach>
		</select>
		&nbsp;
		<select name="searchScsnYn" id="searchScsnYn" style="width:70px">
 			<option selected value=''>전체</option>
 			<c:forEach var="searchScsnYnCd" items="${searchScsnYnCode}" varStatus="status">
				<option value="${searchScsnYnCd.codeId}" ${searchScsnYnCd.codeId == memberVO.searchScsnYn ? 'selected="selected"' : '' }>${searchScsnYnCd.codeName}</option>
			</c:forEach>
		</select>
		&nbsp;
		<input type="text" name="searchWord" id="searchWord" value="" style="width:410px;" />
	</li>
</ul><!-- E : search-list-1 -->
</form>
<div class="search-btn-area">
	<a href="#fn_search" onclick="javascript:fn_search(1); return false" onkeypress="this.onclick;">조회</a>
</div>

<ul class="board-info">
	<span>검색결과 : 총 </span><span id="totalRow">0</span><span> 건</span>
	<li class="btn-area">
		<span>선택 항목</span>
		<a href="#fn_allMailSend" onclick="javascript:fn_allMailSend( ); return false" onkeypress="this.onclick;" class="btn">전체메일보내기</a>
		<a href="#fn_mailSend" onclick="javascript:fn_mailSend( ); return false" onkeypress="this.onclick;" class="btn">메일보내기</a>
		<a href="#fn_smsSend" onclick="javascript:fn_smsSend( ); return false" onkeypress="this.onclick;" class="btn">SMS보내기</a>
	</li>
</ul><!-- E : board-info -->

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="2%" ><input type="checkbox" id="check0" name="check0" onclick="javascript:com.checkAll('check0','memSeqs');"/></th>
			<th width="18%">아이디</th>
			<th width="13%">성명</th>
			<th width="15%">권한그룹</th>
			<th width="8%">가입일</th>
			<th width="10%">접속</th>
			<th width="10%">비밀번호<br>초기화</th>
			<th width="7%">상세진입</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><input type="checkbox" name="memSeqs" id="memSeqs" value='<c:out value="${result.memSeq}"/>'></td>
			<td><c:out value="${result.memId}" /></td>
			<td><c:out value="${result.memName}" /></td>
			<td><c:out value="${result.authGroupName}" /></td>
			<td><c:out value="${result.insertDate}" /></td>
			<td><c:out value="${result.loginCnt}" /></td>
			<td>
				<a href="#fn_updatePassWordInit" onclick="javascript:fn_updatePassWordInit( '<c:out value="${result.memSeq}"/>','<c:out value="${result.memId}"/>'); return false" onkeypress="this.onclick;" class="btn-1">초기화</a>
			</td>
			<td>
				<a href="#fn_read" onclick="javascript:fn_read( '<c:out value="${result.memSeq}"/>'); return false" onkeypress="this.onclick;" class="btn-1">상세</a>
			</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
		<tr>
			<td colspan="7"><spring:message code="common.nodata.msg" /></td>
		</tr>
		</c:if>
	</tbody>
</table><!-- E : list -->


<div class="page-btn">
	<a href="#" onclick="fn_delt();">탈퇴</a>
	<a href="#" onclick="fn_cret();">등록</a>
</div><!-- E : page-btn --> --%>
					

	