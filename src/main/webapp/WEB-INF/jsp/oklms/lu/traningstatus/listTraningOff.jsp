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

var jsonObj = eval('${lms:objectToJson(popupList)}');
PopupOpenerAPI.dataList = jsonObj;
PopupOpenerAPI.contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
	//팝업 알림.
	
	$( "#table_1  tr" ).click(function() {
		  $( "#table_1  tr" ).removeClass("on");
		  $(this).addClass("on");
		});
	
});

function fn_std(yyyy,term,subjectCode,subjectClass,subjectName,termName,departmentName,insNames){
	$("#subject_term").html(yyyy+" 학년도 "+termName);
	$("#subject_name").html(subjectName);
	$("#subject_departmentName").html(departmentName);
	$("#subject_insNames").html(insNames);
	
	var html = "";
	var reqUrl = "/lu/main/listSubjectStdOff.json";
	var param = { "yyyy" : yyyy, "term" : term , "subjectCode" : subjectCode, "subjectClass" : subjectClass };
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
	if (200 == jqXHR.status ) {
		//com.alert( jqXHR.responseJSON.retMsg );
		
		var listSubjectStdOff = jqXHR.responseJSON.listSubjectStdOff;
		
		/* 
		var maxWeekNoteCnt = listSubjectStd[i].maxWeekNoteCnt;
		var maxWeekActCnt = listSubjectStd[i].maxWeekActCnt;
		var evalMStatus = listSubjectStd[i].evalMStatus;
		var evalFStatus = listSubjectStd[i].evalFStatus; 
		 */
		
		 listSubjectStdOff.length;
		 
		for (var i = 0; i < listSubjectStdOff.length; i++) {
			html += "<tr>";
			html += "	<td>"+listSubjectStdOff[i].memId+"</td>";
			html += "	<td>"+listSubjectStdOff[i].memName+"</td>";
			html += "	<td>"+(listSubjectStdOff[i].atnDay == null ? '' : listSubjectStdOff[i].atnDay)+"</td>";
			html += "	<td>"+(listSubjectStdOff[i].lteDay == null ? '' : listSubjectStdOff[i].lteDay)+"</td>";
			html += "	<td>"+(listSubjectStdOff[i].absDay == null ? '' : listSubjectStdOff[i].absDay)+"</td>";
			
			var progress = listSubjectStdOff[i].onProgressRate;

			if( listSubjectStdOff[i].onlineTypeName == '기타' ){
				progress = "-";
			} else {
				progress = progress+"%";
			}
			
			html += "	<td>"+progress+"</td>";
			html += "</tr>";
		}
		
		
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
<input type="hidden" name="nowDay"  id="nowDay" />
  <!-- 기업현장교사 -->

<h3>현장외훈련 현황</h3>
<div class="table-responsive mt-010">
	<table class="type-2" id="table_1">
		<caption>교과목명 구분 학점에 대한 정보 제공</caption>
		<colgroup>
			<col width="8%" />
			<col width="*" />
			<col width="*" />
			<col width="15%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">연번</th>
				<th scope="col">교과목명</th>
				<th scope="col">구분</th>
				<th scope="col">학점</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><a href="javascript:fn_std('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','${result.termName}','${result.departmentName}','${result.insNames}')" >${status.count}</a></td>
					<td><a href="javascript:fn_std('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','${result.termName}','${result.departmentName}','${result.insNames}')" >${result.subjectName}</a></td>
					<td><a href="javascript:fn_std('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','${result.termName}','${result.departmentName}','${result.insNames}')" class="btn-line-blue">${result.onlineTypeName}</a></td>
					<td><a href="javascript:fn_std('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','${result.termName}','${result.departmentName}','${result.insNames}')" >${result.point}</a></td>
				</tr>	
			 </c:forEach>		
			 <c:if test="${ empty resultList}">
				<tr>
					<td colspan="4">데이터가 없습니다.</td>
				</tr>					 
			 </c:if>	
		</tbody>
	</table>
</div>

<div class="training-info mt-040">
	<div class="txt-box">
		<dl class="week">
			<dt><span class="en">학과</span></dt>
			<dd id="subject_departmentName"></dd>
		</dl>
		
		<dl class="mgnone">
			<dt>진행학기</dt>
			<dd id="subject_term"></dd>
		</dl>
		<dl>
			<dt>교과목명</dt>
			<dd id="subject_name"></dd>
		</dl>
		<dl>
			<dt>교수명</dt>
			<dd id="subject_insNames"></dd>
		</dl>
	</div>
</div>



<div class="table-responsive mt-010">
	<table class="type-2">
		<caption>학번 학습근로자명 집체출석 지각 결석 온라인출석에 대한 정보 제공</caption>
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
				<th scope="col">출석(집체)</th>
				<th scope="col">지각</th>
				<th scope="col">결석</th>
				<th scope="col">출석(온라인)</th>
			</tr>
		</thead>
		<tbody id="std_body">
			<!-- <tr>
				<td>123456</td>
				<td>홍길동</td>
				<td>13</td>
				<td>0</td>
				<td>2</td>
				<td>-</td>
			</tr>
			<tr>
				<td>123456</td>
				<td>홍길동</td>
				<td>13</td>
				<td>0</td>
				<td>2</td>
				<td>-</td>
			</tr>
			<tr>
				<td>123456</td>
				<td>홍길동</td>
				<td>13</td>
				<td>0</td>
				<td>2</td>
				<td>-</td>
			</tr> -->
		</tbody>
	</table>
</div>




</form>
