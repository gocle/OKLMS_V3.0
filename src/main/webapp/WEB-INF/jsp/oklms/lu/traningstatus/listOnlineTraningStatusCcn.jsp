<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>

<style>
<!--
@media print																{.not_print {display: none;}}
-->
</style>

<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/popupApi.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.table2excel.js"></script>

<c:set var="targetUrl" value="/lu/traningstatus/"/>
<script type="text/javascript">

$(document).ready(function() {
		if($("#subject").val() != ""){
			initHtml( '${param.subject }');
		}
});

function initHtml(subject){
	
	var subjectStrArr = subject.split("|");
	var yyyy = subjectStrArr[0];
	var term = subjectStrArr[1];
	var subjectCode = subjectStrArr[2];
	var subjectClass = subjectStrArr[3];
	var onSceduleLen = subjectStrArr[4];
	
	console.log("onSceduleStrArr : "+subjectStrArr);
	console.log("yyyy : "+yyyy);
	console.log("term : "+term);
	console.log("subjectCode : "+subjectCode);
	console.log("subjectClass : "+subjectClass);
	console.log("onSceduleLen : "+onSceduleLen);
	
	var html = "";
	var len = Number(onSceduleLen);
	html += "<colgroup>";
	
	console.log("len :"+len);
	
	for(var i=0; i < len; i++){
		if( i < 5 ){
			if(i== 0){
				html += "<col style='width:5%'>";
			} else if (i==1){
				html += "<col style='width:11%'>";
			} else if (i==2){
				html += "<col style='width:9%'>";
			} else if (i==3){
				html += "<col style='width:15%'>";
			} else if (i==4){
				html += "<col style='width:9%'>";
			} 
		} else {
			html += "<col style='width:"+parseInt((51 / len))+"%'>";
		}
	}
	
	
	html += "</colgroup>";
	
	html += "<thead>";
	html += "<tr>";
	html += "<th rowspan='2'>번호</th>";
	html += "<th rowspan='2'>학번</th>";
	html += "<th rowspan='2'>이름</th>";
	html += "<th rowspan='2'>학과</th>";
	html += "<th rowspan='2'>학년</th>";
	html += "<th colspan='"+len+"'>차시</th>";
	html += "</tr>";
	html += "<tr>";
	for(var i=0; i < len; i++){
		html += "<th>"+(i+1)+"</th>";
	}
	html += "</tr>";
	html += "</thead>";
	html += "<tbody id='t_body'>";
	
	var reqUrl = "/lu/traningstatus/listOnlineScheduleAttend.json";
	var param = { "yyyy" : yyyy, "term" : term, "subjectCode" : subjectCode, "subjectClass" : subjectClass };
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
	if (200 == jqXHR.status ) {
		//com.alert( jqXHR.responseJSON.retMsg );
		
		var resultList = jqXHR.responseJSON.resultList;

		for (var i = 0; i < resultList.length; i++) {
			html += "<tr>";
			html += "	<td>"+(i+1)+"</th>";
			html += "	<td>"+resultList[i].memId+"</th>";
			html += "	<td>"+resultList[i].memName+"</th>";
			html += "	<td>"+resultList[i].deptName+"</th>";
			html += "	<td>"+resultList[i].subjectGrade+"학년</th>";
			for(var x=0; x < len; x++){
				
				var mark = "";
				var str = eval("resultList[i].as"+(x+1));
				
				if(str == "O") mark = "O"
				else mark = "X"
				
				html += "	<td>"+mark+"</td>";
			}
			html += "</tr>";
		}
		
		html += "</tbody>";
		html += "</table>";
		
		
		$("#report_area").append(html);
	} else {
		alert("교과정보를 읽어오는대 실패했습니다.")
	}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	}); 
	
}

/* 리스트 조회 */
function fn_search(){
	var subject = $("#subject").val();
	
	if(subject != ""){
		$("#yyyy").val( subject.split("|")[0] );
		$("#term").val( subject.split("|")[1] );
		$("#subjectCode").val( subject.split("|")[2] );
		$("#subjectClass").val( subject.split("|")[3] );
	}
	var reqUrl = "/lu/traningstatus/listOnlineTraningstatusCcn.do";
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();
}


function fn_excel(){
	var subject = $("#subject").val();
	if(subject != ""){
		$("#yyyy").val( subject.split("|")[0] );
		$("#term").val( subject.split("|")[1] );
		$("#subjectCode").val( subject.split("|")[2] );
		$("#subjectClass").val( subject.split("|")[3] );
	} else {
		alert("교과목 선택 후 출력이 가능합니다.");
		return;
	} 
	
	/* var reqUrl = "/lu/traningstatus/excelOnlineScheduleAttend.do";
	$("#frmTraningstatus").attr("target", "_self");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit(); */
	
	$("#report_area").table2excel({
        name: "Worksheet Name",
        filename: "온라인출석부_차시별",
        fileext: ".xls"
    }); 



}


</script>


<h2>온라인출석부관리</h2>
<form name="frmTraningstatus" id="frmTraningstatus" method="post">
<input type="hidden" name="yyyy" id="yyyy" >
<input type="hidden" name="term" id="term" >
<input type="hidden" name="subjectCode" id="subjectCode" >
<input type="hidden" name="subjectClass" id="subjectClass" >

			<div class="group-area mt-020">				
						


					<div class="search-box-1 mt-020 mb-020">
						<label for="departmentNo" class="hidden">학과명</label>
						<select name="departmentNo" id="departmentNo" onchange="javascript:fn_search();">
							<option value="">학과명</option>
							<c:forEach var="result" items="${deptCodeList}" varStatus="status">
								<option value="${result.codeId}" <c:if test="${subjectVO.departmentNo eq result.codeId }" > selected="selected"  </c:if>>${result.codeName}</option>
							</c:forEach>		
						</select>
						
						<label for="subjectGrade" class="hidden">대상학년</label>
						<select name="subjectGrade" id="subjectGrade" onchange="javascript:fn_search();">
							<option value="">대상학년</option>
							<option value="1" <c:if test="${subjectVO.subjectGrade eq '1' }" > selected="selected"  </c:if>>1학년</option>
							<option value="2" <c:if test="${subjectVO.subjectGrade eq '2' }" > selected="selected"  </c:if>>2학년</option>
							<option value="3" <c:if test="${subjectVO.subjectGrade eq '3' }" > selected="selected"  </c:if>>3학년</option>
							<option value="4" <c:if test="${subjectVO.subjectGrade eq '4' }" > selected="selected"  </c:if>>4학년</option>
							<option value="5" <c:if test="${subjectVO.subjectGrade eq '5' }" > selected="selected"  </c:if>>5학년</option>
						</select>
						
						<label for="subject" class="hidden">교과목</label>
						<select id="subject" name="subject" onchange="javascript:fn_search();">
							<option value="">교과목</option>
							<c:forEach var="result" items="${subjectList}" varStatus="status">
								<c:set var="subject" value="${result.yyyy}|${result.term}|${result.subjectCode}|${result.subjectClass}|${result.onSceduleLen}"/>
								<option value="${result.yyyy}|${result.term}|${result.subjectCode}|${result.subjectClass}|${result.onSceduleLen}" <c:if test="${subject eq param.subject }" > selected="selected"  </c:if>>${result.yyyy}학년도 ${result.termName} ${result.subjectName}(${result.subjectClass})</option>
							</c:forEach>	
							
						</select>

						<a href="#@" onclick="javascript:fn_search();">검색</a>
					</div><!-- E : search-box-1 -->

				 
							
							
					<div class="table-responsive mt-040" style="overflow-x: auto">
						<table class="type-2" id="report_area">
						</table>
					</div>
								  
							
							
							
				</div>			
				<div class="btn-area mt-010 not_print">
					<div class="float-right">
						<!-- <a href="#" onclick="javascript:window.print();" class="orange">프린트</a> -->
						<a href="#" onclick="javascript:fn_excel();" class="yellow">엑셀 다운로드</a>
					</div>
				</div>

</form>
