<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.table2excel.js"></script>						
<script type="text/javascript">
<!--

$(document).ready(function() {
	 
});
function fn_excel(){
	$("#report_area").table2excel({
	    name: "이수현황",
	    filename: "${memberVO.memName}(${memberVO.memId})_${memberVO.deptNm}_이수현황"+".xls",
	    fileext: ".xls"
	}); 
}

function fn_passYn(obj) { 
	
	$("#passYn").val(obj.value.split("|")[0]);
	$("#lessonId").val(obj.value.split("|")[1]);
	
	var reqUrl = "/lu/traning/updateLessonPassYn.json";
 	var param = $("#frmLes").serializeArray();
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){	
		if (200 == jqXHR.status ) {
			var retData 	= jqXHR.responseJSON.retData;
			var retCd 	= jqXHR.responseJSON.retCd;
			if(retCd == 10000 ){
				//alert("저장 되었습니다.")
			} else {
				alert("등록에 실패했습니다.")
			}
		} else {
			alert("처리에 실패했습니다.")
		}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	});
} 

function fn_grade(obj) { 
	
	$("#grade").val(obj.value.split("|")[0]);
	$("#lessonId").val(obj.value.split("|")[1]);
	var reqUrl = "/lu/traning/updateLessonGrade.json";
 	var param = $("#frmLes").serializeArray();
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){	
		if (200 == jqXHR.status ) {
			var retData 	= jqXHR.responseJSON.retData;
			var retCd 	= jqXHR.responseJSON.retCd;
			if(retCd == 10000 ){
				//alert("저장 되었습니다.")
			} else {
				alert("등록에 실패했습니다.")
			}
		} else {
			alert("처리에 실패했습니다.")
		}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	});
} 



//--> 
</script>

<div id="report_area">
<h2>이수현황</h2>
				
				<div class="training-info mt-010">
					 <div class="txt-box ptnone">
						<dl class="mgnone">
							<dt>성명</dt>
							<dd>${memberVO.memName}</dd>
						</dl>
						<dl>
							<dt>학과</dt>
							<dd>${memberVO.deptNm}</dd>
						</dl>
						
						<dl>
							<dt>학번</dt>
							<dd>${memberVO.memId}</dd>
						</dl>
						
						<dl>
							<dt>기업명</dt>
							<dd>${memberVO.companyName}</dd>
						</dl>
					</div>
				</div>
				
				<c:choose>
					<c:when test="${loginAuthGroupId ne '2016AUTH0000002'}">
						<div class="btn-area mt-010">
								<div class="float-right">
								<a href="javascript:history.back(-1);" class="black">뒤로</a><a href="#" onclick="fn_excel();" class="orange">엑셀다운로드</a>
								</div>
							</div>
							<br/>
					</c:when>
				</c:choose>
				
					
				<div class="table-responsive mt-040">
					<form name="frmLes" id="frmLes" method="post">
					<input type="hidden" name="lessonId" id="lessonId"/>
					<input type="hidden" name="passYn" id="passYn" />
					<input type="hidden" name="grade" id="grade" />
					<table class="type-2">
						<caption>학년 해당학기 교과목명 능력단위 Off-JT출석시간 이수여부 재수강여부 등에 대한 정보 제공</caption>
						<thead>
							<tr>
								<th scope="col" rowspan="4">학년</th>
								<th scope="col" rowspan="4">해당학기</th>
								<th scope="col" rowspan="4">교과목명</th>
								<th scope="col" rowspan="3" colspan="2">능력단위<br />(NCS, 비NCS)</th>
								<th scope="col" rowspan="2" colspan="4">Off-JT 출석시간(대학)</th>
								<th scope="col" colspan="6">이수여부</th>
								<th scope="col" rowspan="4">재수강여부</th>
							</tr>
							<tr>
								<th scope="col" colspan="4">Off-JT</th>
								<th scope="col" rowspan="2" colspan="2">OJT</th>
							</tr>
							<tr>
								<th scope="col" colspan="2">집체(아우누리)</th>
								<th scope="col" colspan="2">원격(OK-LMS)</th>
								<th scope="col" colspan="2">학사</th>
								<th scope="col" colspan="2">훈련</th>
							</tr>
							<tr>
								<th scope="col">능력단위명</th>
								<th scope="col">필수여부</th>
								<th scope="col">목표</th>
								<th scope="col">이수</th>
								<th scope="col">목표</th>
								<th scope="col">이수</th>
								<th scope="col">능력단위</th>
								<th scope="col">교과목(학점)</th>
								<th scope="col">능력단위</th>
								<th scope="col">교과목</th>
								<th scope="col">능력단위</th>
								<th scope="col">교과목</th>
							</tr>
						</thead>
						<tbody>
						
						
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td>${result.subjectGrade}학년</td>
									<td>
									${fn:replace(fn:replace(result.yySemstrNm, '-01' , '-1학기' ),'-02','-2학기')}
									</td>
									<td>${result.subjectName}</td>
									<td>${result.ncsUnitName}</td>
									<td><!-- 훈련과정에 매핑된 자격기반으로 같은 NCS 코드기 있으면 필수 --></td>
									<td>${result.offAttGoal}</td>
									<td>${result.offAttCompl}</td>
									<td>${result.onAttGoal}</td>
									<td>${result.onAttCompl}</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OFF'}">
									${result.ncsUnitName}
									 </c:if>
									</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OFF'}">
									${result.grd}
									</c:if>
									</td>
									<td>
									<select name="passYns" id="passYn${status.count}" onchange="javascript:fn_passYn(this);">
										<option value="|${result.lessonId}">선택</option>
										<option value="P|${result.lessonId}" ${result.passYn eq 'P' ? 'selected' : ''}>P</option>
										<option value="F|${result.lessonId}" ${result.passYn eq 'F' ? 'selected' : ''}>F</option>
									</select>
									<!-- 센터가입력-담당학습근로자에서 입력(P/F) -->
									</td>
									<td>
									<select name="grades" id="grade${status.count}" onchange="javascript:fn_grade(this);">
										<option value="|${result.lessonId}">선택</option>
										<option value="A|${result.lessonId}" ${result.grade eq 'A' ? 'selected' : ''}>A</option>
										<option value="B|${result.lessonId}" ${result.grade eq 'B' ? 'selected' : ''}>B</option>
										<option value="C|${result.lessonId}" ${result.grade eq 'C' ? 'selected' : ''}>C</option>
										<option value="D|${result.lessonId}" ${result.grade eq 'D' ? 'selected' : ''}>D</option>
										<option value="E|${result.lessonId}" ${result.grade eq 'E' ? 'selected' : ''}>E</option>
										<option value="F|${result.lessonId}" ${result.grade eq 'F' ? 'selected' : ''}>F</option>
									</select>
									<!-- 센터가입력-담당학습근로자에서 입력(A/B/C/D/E/F) -->
									</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OJT'}">
									${result.ncsUnitName}
									</c:if>
									</td>
									<td>
									<c:if test="${result.subjectTraningType eq 'OJT'}">
									${result.grd}
									</c:if>
									</td>
									<td>${result.reCorsYn}</td>
								</tr>	
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
								 	<td colspan="16"><spring:message code="common.nodata.msg" /></td>
								</tr>		
							</c:if>	
						</tbody>
					</table>
					</form>
				</div>
</div>

<iframe id="txtArea1" style="display:none"></iframe>

 