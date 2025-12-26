<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
<!--
@media print																{.not_print {display: none;}}
td { mso-number-format:\@; } 
-->

</style>

<script type="text/javascript">
<!-- 
function fn_excel(){ 
 
	var reqUrl = "/lu/workcert/excelWorkCert.do";
	$("#frmWorkCertListpopup").attr("target", "_self");
	$("#frmWorkCertListpopup").attr("action", reqUrl);
	$("#frmWorkCertListpopup").submit();
} 

//--> 
</script>
		<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<div id="pop-wrapper" class="min-w650">

			<h1>성적조회 (학기별)</h1>
			<table class="type-1 mb-010">
				<caption>학년도 학기 기업명에 대한 정보제공</caption>
				<colgroup>
					<col style="width:10%" />
					<col style="width:17%" />
					<col style="width:10%" />
					<col style="width:17%" />
					<col style="width:10%" />
					<col style="width:17%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">학년도</th>
						<td style="text-align: center">${param.yy } 학년도</td>
						<th scope="row">학기</th>
						<td style="text-align: center">${param.termNm }</td>
						<th scope="row">기업명</th>
						<td style="text-align: center">${param.companyName }</td>
					</tr>
				</tbody>
			</table>


			<table class="type-2">
				<caption>학년 학번 성명 과목명평정 평점평균에 대한 정보 제공</caption>
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:6%" />
					
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:12%" />
					
					<col style="width:4%" />
					<col style="width:4%" />
					<col style="width:4%" />
					<col style="width:6%" />
					<col style="width:6%" />
					
				</colgroup>
				<thead>
					<tr>
						<th scope="col">학년</th>
						<th scope="col">학번</th>
						<th scope="col">성명</th>
						<th scope="col">과목명 평점</th>
						<th scope="col">과목명 평점</th>
						<th scope="col">과목명 평점</th>
						<th scope="col">과목명 평점</th>
						<th scope="col">과목명 평점</th>
						<th scope="col">학</th>
						<th scope="col">강</th>
						<th scope="col">실</th>
						<th scope="col">취/신</th>
						<th scope="col">평점평균</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${gradeList}" varStatus="status">
					<tr>
						<td>${result.subjectGrade }학년</td>
						<td>${result.memId}</td>
						<td>${result.memName }</td>
						<td>${result.subject1 }</td>
						<td>${result.subject2 }</td>
						<td>${result.subject3 }</td>
						<td>${result.subject4 }</td>
						<td>${result.subject5 }</td>
						<td>${result.totPnt }</td>
						<td>${result.totLctrePnt }</td>
						<td>${result.totReqstPnt }</td>
						<td>${result.totGetPnt}/${result.totPnt}</td>
						<td>
						
						<c:choose>
							<c:when test="${fn:substring(result.totMarkAvrg,0,1) == '.'}">0${result.totMarkAvrg }</c:when>
							<c:otherwise>${result.totMarkAvrg }</c:otherwise>
						</c:choose>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty gradeList}" >
					<tr>
						<td colspan="13"><spring:message code="common.nodata.msg" /></td>
					</tr>
				</c:if>
				</tbody>
			</table>


			<div class="btn-area align-center mt-010 not_print" style="border-top:1px solid #CCC; padding-top:20px;">
				<a href="javascript:self.close();" class="gray-3">닫기</a>
			</div>


		</div><!-- E : wrapper -->
