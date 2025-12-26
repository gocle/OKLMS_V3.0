<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">


<!--
var oEditors = [];

$(document).ready(function() {


	
	
});


function loadPage() {
}


/* 각종 버튼에 대한 액션 초기화 */ 
function initEvent() {
}
/* 화면이 로드된후 처리 초기화 */
function initHtml() {
}
function pop_closeWin() {
	self.close();
}



//-->
</script>

	<body>
<form name="frmSend" id="frmSend" action=""  method="post" >
</form>

		<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<div id="pop-wrapper" class="min-w650">

			<h1>발송결과</h1>

			<table class="type-1 mb-020">
				<colgroup>
					<col style="width:110px" />
					<col style="width:200px" />
					<col style="width:110px" />
					<col style="width:*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">발송일</th>
						<td colspan="3">${mstVO.insertDate}</td>
					</tr>
					<c:if test="${!empty mstVO.sendDate}">
						<tr>
							<th scope="row">예약일</th>
							<td colspan="3">
							<fmt:parseDate value="${mstVO.sendDate}" var="sendDate" pattern="yyyyMMddHHmm"/>
							<fmt:formatDate value="${sendDate}" pattern="yyyy.MM.dd HH:mm"/>
							</td>
						</tr>
					</c:if>
					<c:if test="${mstVO.sendType eq 'EMAIL'}">
						<tr>
							<th scope="row">제목</th>
							<td colspan="3">${mstVO.title}</td>
						</tr>
					</c:if>
					<tr>
						<th scope="row">내용</th>
						<td colspan="3">${mstVO.content}</td>
					</tr>
					<%-- <c:if test="${!empty mstVO.atchFileId}">
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3"><a href="${mstVO.atchFileId}" class="btn-line-gray">다운로드</a></td>
						</tr>
					</c:if> --%>
				</tbody>
			</table>


			<table class="type-2">
				<colgroup>
					<col style="width:200px" />
					<col style="width:200px" />
					<col style="width:200px" />
					<col style="width:200px" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">학번</th>
						<th scope="col">이름</th>
						<th scope="col">발신일</th>
						<th scope="col">발신여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td>${result.memId }</td>
							<td>${result.memName }</td>
							<td>${result.insertDate }</td>
							<c:choose>
								<c:when test="${mstVO.sendYn eq 'N'}">
									<td>발송준비</td>
								</c:when>
								<c:otherwise>
									<c:if test="${mstVO.sendType eq 'EMAIL'}">
										<td>${result.reciveYn eq 'Y' ? '성공' : '실패'}</td>
									</c:if>
									<c:if test="${mstVO.sendType eq 'SMS'}">
										<td>발송완료</td>
									</c:if>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			

			<div class="btn-area align-center mt-010">
				<a href="javascript:pop_closeWin();" class="black">닫기</a>
			</div>


		</div><!-- E : wrapper -->
	</body>