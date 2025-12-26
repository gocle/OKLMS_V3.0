<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">

	
	var yyyy = '${subjectVO.yyyy}';
	var term = '${subjectVO.term}';
	var subjectCode = '${subjectVO.subjectCode}';
	var subjectClass = '${subjectVO.subjectClass}';
	var onSceduleLen = '${subjectVO.onSceduleLen}';
	
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
		html += "<th rowspan='2'>"+(i+1)+"</th>";
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
	



</script>

			
			<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
				<caption>학년도 학기 교과목명 과목코드 분반 온라인교육형태 학점 담당교수명에 대한 정보를 제공합니다</caption>
				<colgroup>
					<col style="width:15%" />
					<col style="width:*px" />
					<col style="width:15%" />
				</colgroup>
				<tr>
					<th scope="row">학년도</th>
					<td>${subjectVO.yyyy}학년도</td>
					<th scope="row">학기</th>
					<td>${subjectVO.termName}</td>
				</tr>
				<tr>
					<th scope="row">교과목명</th>
					<td>${subjectVO.subjectName}</td>
					<th scope="row">과목코드</th>
					<td>${subjectVO.subjectCode}</td>
				</tr>
				<tr>
					<th scope="row">분반</th>
					<td>${subjectVO.subjectClass}분반</td>
					<th scope="row">온라인교육형태</th>
					<td>${subjectVO.onlineTypeName}</td>
				</tr>
				<tr>
					<th scope="row">학점</th>
					<td>${subjectVO.point}</td>
					<th scope="row">담당교수명</th>
					<td>${subjectVO.onSceduleLen}</td>
				</tr>
			</table>

			<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder" id="report_area">
  
			</table>
			
			
  