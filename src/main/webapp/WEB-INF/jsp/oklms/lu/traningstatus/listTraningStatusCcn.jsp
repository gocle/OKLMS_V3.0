<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/popupApi.js"></script>
<script type="text/javascript">
<!--


$(document).ready(function() {
});

function fn_subject(year){
	var html = "";
	var reqUrl = "/lu/traning/listTraningStatusCcn.json";
	var param = { "year" : year };
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
	if (200 == jqXHR.status ) {
		//com.alert( jqXHR.responseJSON.retMsg );
		
		var listTraningStatusCcn= jqXHR.responseJSON.listTraningStatusCcn;
		
		
		$("#subject_year").html('<span>실시연도</span>'+year+"년도 ");
		
		for (var i = 0; i < listTraningStatusCcn.length; i++) {
			html += "<tr>";
			//html += "	<td><a href='javascript:fn_std( \""+listSubjectCot[i].yyyy+"\", \""+listSubjectCot[i].term+"\", \""+listSubjectCot[i].subjectCode+"\", \""+listSubjectCot[i].subjectClass+"\", \""+listSubjectCot[i].subjectName+"\", \""+listSubjectCot[i].termName+"\", \""+listSubjectCot[i].subjectTraningType+"\", \""+listSubjectCot[i].departmentName+"\");''>"+listSubjectCot[i].subjectName+"</a></td>";
			html += "	<td>"+listTraningStatusCcn[i].companyName+"</td>";
			html += "	<td><a href='javascript:fn_std(\""+year+"\",\""+listTraningStatusCcn[i].traningProcessName+"\", \""+listTraningStatusCcn[i].companyId+"\", \""+listTraningStatusCcn[i].traningProcessId+"\", \""+listTraningStatusCcn[i].traningProcessPeriod+"\" , \""+ listTraningStatusCcn[i].companyName+"\" );''>"+listTraningStatusCcn[i].traningProcessName+"</a></td>";
			html += "</tr>";
		}
		
		$("#subject_body").empty();
		$("#subject_body").append(html);
		
	} else {
		alert("교과정보를 읽어오는대 실패했습니다.")
	}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	});
}
function fn_std(year,traningProcessName,companyId,traningProcessId,traningProcessPeriod,companyName){
	$("#subject_yyy").html(year);
	$("#subject_companyName").html(companyName);
	$("#subject_traningProcessName").html(traningProcessName);
	$("#subject_traningProcessPeriod").html(traningProcessPeriod);
	
	
	
	var html = "";
	var reqUrl = "/lu/main/listSubjectStd.json";
	var param = { "traningProcessId" : traningProcessId, "companyId" : companyId  };
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
	if (200 == jqXHR.status ) {
		//com.alert( jqXHR.responseJSON.retMsg );
		
		var listSubjectStd = jqXHR.responseJSON.listSubjectStd;
		
		/* 
		var maxWeekNoteCnt = listSubjectStd[i].maxWeekNoteCnt;
		var maxWeekActCnt = listSubjectStd[i].maxWeekActCnt;
		var evalMStatus = listSubjectStd[i].evalMStatus;
		var evalFStatus = listSubjectStd[i].evalFStatus; 
		 */
		for (var i = 0; i < listSubjectStd.length; i++) {
			html += "<tr>";
			html += "	<td>"+listSubjectStd[i].memId+"</td>";
			html += "	<td>"+listSubjectStd[i].memName+"</td>";
			html += "	<td>"+listSubjectStd[i].yyyy+"학년도 "+listSubjectStd[i].termName+"</td>";
			html += "	<td>"+listSubjectStd[i].subjectName+"</td>";
			html += "	<td>"+(listSubjectStd[i].maxWeekNoteCnt == null ? '' : listSubjectStd[i].maxWeekNoteCnt+'주차')+"</td>";
			html += "	<td>"+(listSubjectStd[i].maxWeekActCnt == null ? '' : listSubjectStd[i].maxWeekActCnt+'주차')+"</td>";
			html += "</tr>";
		}
		
		/* <th>학번</th>
		<th>학습근로자명</th>
		<th>학습일지등록현황</th>
		<th>학습활동서작성현황</th>
		<th>내부평가현황</th>
		<th>성적</th> */
		
		$("#std_body").empty();
		$("#std_body").append(html);
		
	} else {
		alert("교과정보를 읽어오는대 실패했습니다.")
	}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	});
}

</script>


<form name="frmMainPage" id="frmMainPage" method="post">
<input type="hidden" name="nowDay" id="nowDay" >
<!-- 센터담당자 -->

<div class="half-left-area">
	<h3>훈련과정현황</h3>
	<div class="table-responsive">
		<table class="type-3 w640">
			<caption>실시년도 기업체수 전체학생수 중도탈작자에 대한 정보 제공</caption>
			<colgroup>
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">실시년도</th>
					<th scope="col">기업체수</th>
					<th scope="col">전체학생수</th>
					<th scope="col">중도탈락자</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="totcompanyCnt" value="0"/>
				<c:set var="totallStudentCnt" value="0"/>
				<c:set var="totdropoutCnt" value="0"/> 
				<c:forEach var="result" items="${listLmsUserMainPageStatusCnt}" varStatus="status">
				
					<c:set var="totcompanyCnt" value="${ totcompanyCnt+ result.companyCnt}"/>
					<c:set var="totallStudentCnt" value="${totallStudentCnt + result.allStudentCnt}"/>
					<c:set var="totdropoutCnt" value="${totdropoutCnt+ result.dropoutCnt}"/>
					<tr>
						<td><a href="javascript:fn_subject('${ result.schoolYear}')"> ${ result.schoolYear}</a></td>
						<td>${ result.companyCnt}</td>
						<td>${ result.allStudentCnt}명</td>
						<td>${ result.dropoutCnt}명</td>
					</tr>			
				</c:forEach>
				<c:if test="${!empty listLmsUserMainPageStatusCnt}">
					<tr>
						<td>계</td>
						<td>${ totcompanyCnt}</td>
						<td>${ totallStudentCnt}</td>
						<td>${ totdropoutCnt}</td>
					</tr>
				</c:if>	
	 			<c:if test="${ empty listLmsUserMainPageStatusCnt}">
					<tr>
						<td colspan="4">데이터가 없습니다.</td>
					</tr>					 
				 </c:if>
			</tbody>
		</table>
	</div>
</div>

<div class="half-right-area">
	<h3>과정실시현황</h3>
	<div class="compnay_year mt-000" id="subject_year"><!-- <span>실시연도</span>2016 --></div>
	<div class="company_view">
		<table class="type-2 wp100">
			<caption>기업명 과정명에 대한 정보 제공</caption>
			<colgroup>
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">기업명</th>
					<th scope="col">과정명</th>
				</tr>
			</thead>
			<tbody id="subject_body">
				<!-- 
				<tr>
					<td>기업명</td>
					<td><a href="">과정명</a></td>
				</tr>
				 -->
			</tbody>
		</table>
	</div>
</div>
	
<div class="clearfix"></div>
<div class="full-area bdb0 mt-040">
	<h3>과정 상세보기</h3>
	
	<div class="training-info">
		 <div class="txt-box">
			<dl>
				<dt><span class="en" >실시연도</span></dt>
				<dd id="subject_yyy"></dd>
			</dl>
			<dl>
				<dt>기업명</dt>
				<dd id="subject_companyName"></dd>
			</dl>
			<dl>
				<dt>과정명</dt>
				<dd id="subject_traningProcessName"></dd>
			</dl>
			<dl>
				<dt>회차</dt>
				<dd id="subject_traningProcessPeriod"></dd>
			</dl>
		</div>
	</div>
	
	<div class="table-responsive mt-010">
		<table class="type-2">
			<caption>학번 학습근로자명 진행학기 과목명 학습일지작성현황 학습활동서작성현황에 대한 정보 제공</caption>
			<colgroup>
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">학번</th>
					<th scope="col">학습근로자명</th>
					<th scope="col">진행학기</th>
					<th scope="col">과목명</th>
					<th scope="col">학습일지작성현황</th>
					<th scope="col">학습활동서작성현황</th>
				</tr>
			</thead>
			<tbody id="std_body">
			<!-- 
				<tr>
					<td>123456</td>
					<td>홍길동</td>
					<td>2019학년도 1학기</td>
					<td>A</td>
					<td><a href="">3주차</a></td>
					<td><a href="">2주차</a></td>								
				</tr>
				 -->
			</tbody>
		</table>
	</div>
</div>

</form>
