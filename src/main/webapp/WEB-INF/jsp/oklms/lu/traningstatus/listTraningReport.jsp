<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

						
<script type="text/javascript">

$(document).ready(function() {
	<c:forEach var="result" items="${resultList}" varStatus="status">
		initHtml('${result.subjectTraningType}','${result.subjectTraningTypeName}','${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','${result.subjectType}','${result.onlineType}','${result.onlineTypeName}','${result.weekLen}');
	</c:forEach>
});

function initHtml(subjectTraningType, subjectTraningTypeName, yyyy, term, subjectCode, subjectClass, subjectName, subjectType, onlineType, onlineTypeName, weekLen){
	
	var html = "";
	var len = Number(weekLen);
	html += "<div class='sub_text blue_text mt-040'>";
	html += "	<i class='xi-label'></i> "+subjectName+"("+subjectTraningTypeName+")";
	if(onlineTypeName != "없음"){
		html += "	<a href='javascript:fn_lec_menu_display(\""+subjectTraningType+"\", \""+yyyy+"\", \""+term+"\", \""+subjectCode+"\", \""+subjectClass+"\", \""+subjectName+"\", \""+subjectType+"\", \""+onlineType+"\");' class='btn btn-primary  btn-sm'>"+onlineTypeName+"</a>";
	}
	html += "</div>";
	html += "<div class='table-responsive mt-010'>";
	html += "	<table class='type-2'>";
	html += "		<thead>";
	html += "			<tr>";
	html += "			<th width='10%'>주차</th>"; 
	for(var i = 1; i <= len; i++){
		html += "				<th width='"+(90/len)+"%'><a href='javascript:fn_lec_url(\""+subjectTraningType+"\", \""+yyyy+"\", \""+term+"\", \""+subjectCode+"\", \""+subjectClass+"\", \""+subjectName+"\", \""+subjectType+"\", \""+onlineType+"\", \"/lu/activity/listActivityStd.do?weekCnt="+i+"\");'>"+i+"주차</a></th>";
	}
	html += "			<tr>";
	html += "		</thead>";
	html += "		<tbody id='body_"+subjectCode+"'>";
	html += "		</tbody>";
	html += "	</table>";
	html += "</div>";
	
	$("#report_area").append(html);
	$("#report_area").show();
	var reqUrl = "/lu/traning/listTraningReport.json";
	var param = { "yyyy" : yyyy, "term" : term, "subjectCode" : subjectCode, "subjectClass" : subjectClass, "subjectTraningType" : subjectTraningType};
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
	if (200 == jqXHR.status ) {
		//com.alert( jqXHR.responseJSON.retMsg );
		
		var listSubjectTraning = jqXHR.responseJSON.listSubjectTraning;
		var listSubjectReport = jqXHR.responseJSON.listSubjectReport;
		var listSubjectActivity = jqXHR.responseJSON.listSubjectActivity;
		var listSubjectOnline = jqXHR.responseJSON.listSubjectOnline;
		
		html = "";
		
		console.log("listSubjectTraning.length : "+listSubjectTraning.length);
		console.log("listSubjectReport.length : "+listSubjectReport.length);
		console.log("listSubjectActivity.length : "+listSubjectActivity.length);
		console.log("listSubjectOnline.length : "+listSubjectOnline.length);
		
		if(onlineTypeName != ""){
			for (var i = 0; i < listSubjectOnline.length; i++) {
				html += "<tr>";
				html += "	<th>온라인학습</th>";
				for(var x=0; x < len; x++){
					
					var mark = "";
					var str = eval("listSubjectOnline[i].week"+(x+1))
				
					if(str == null) {
						mark = "-";
					} else {
						mark = str+"%";
					}
						
					html += "	<td>"+mark+"</td>";
				}
				html += "</tr>";
			}
		}
		
		
		for (var i = 0; i < listSubjectTraning.length; i++) {
			html += "<tr>";
			html += "	<th>출결 현황</th>";
			for(var x=0; x < len; x++){
				
				var mark = "";
				var str = eval("listSubjectTraning[i].week"+(x+1));
				
				if(str == "1") mark = "O"
				else mark = "X"
				
				html += "	<td>"+mark+"</td>";
			}
			html += "</tr>";
		}
		
		
		for (var i = 0; i < listSubjectReport.length; i++) {
			html += "<tr>";
			html += "	<th>과제 제출</th>";
			for(var x=0; x < len; x++){
				
				var mark = "";
				var str = eval("listSubjectReport[i].week"+(x+1))
			
				if(str == null) {
					mark = "-";
				} else {
					mark = str;
					if(mark == "제출"){
						mark = "<span class='btn-line-blue'>제출</span>";
					} else {
						mark = "<span class='btn-line-orange'>미제출</span>";
					}
				}
					
				html += "	<td>"+mark+"</td>";
			}
			html += "</tr>";
		}
		
		for (var i = 0; i < listSubjectActivity.length; i++) {
			html += "<tr>";
			html += "	<th>학습활동서</th>";
			for(var x=0; x < len; x++){
				
				var mark = "";
				var str = eval("listSubjectActivity[i].week"+(x+1));
				
				if(str == null) {
					mark == "<span class='btn-line-orange'>미작성</span>";
				} else {
					if(subjectTraningType == "OFF"){
						mark = "<span class='btn-line-blue'>작성</span>";
					} else {
						if(str == "1"){
							mark = "<span class='btn-line-gray'>승인대기</span>";
						} else if(str == "2"){
							mark = "<span class='btn-line-blue'>승인</span>";
						} else if(str == "3"){
							mark = "<span class='btn-line-orange'>반려</span>";
							
						}
					}
				}
				
				html += "	<td>"+mark+"</td>";
			}
			html += "</tr>";
		}
		
		console.log("html : "+html);
		
		$("#body_"+subjectCode).append(html);
		
		
		
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


<h2>교과목별 훈련현황</h2>
		
<div id="report_area" style="display: none;">

</div>
		
		
<!-- 

<div class="sub_text blue_text mt-040">
			 <i class="xi-label"></i> 교과목명(Off-JT/OJT) <a href="" class="btn btn-primary  btn-sm">온라인강의</a>
		</div>
		<div class="table-responsive mt-010">
			<table class="type-2">
				<thead>
					<tr>
						<th>주차</th>
						<th><a href="">1</a></th>
						<th><a href="">2</a></th>
						<th><a href="">3</a></th>
						<th><a href="">4</a></th>
						<th><a href="">5</a></th>
						<th><a href="">6</a></th>
						<th><a href="">7</a></th>
						<th><a href="">8</a></th>
						<th><a href="">9</a></th>
						<th><a href="">10</a></th>
						<th><a href="">11</a></th>
						<th><a href="">12</a></th>
						<th><a href="">13</a></th>
						<th><a href="">14</a></th>
						<th><a href="">15</a></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>출결 현황</th>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
					</tr>	
					<tr>
						<th>과제 제출</th>
						<td><a href="#none" class="btn-line-yellow">미제출</a></td>
						<td><a href="#none" class="btn-line-blue">제출</a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>	
					<tr>
						<th>학습활동서</th>
						<td><a href="#none" class="btn-line-gray">완료</a></td>
						<td><a href="#none" class="btn-line-yellow">반려</a></td>
						<td><a href="#none" class="btn-line-blue">승인</a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>		
				</tbody>
			</table>
		</div>
		<div class="sub_text blue_text mt-040">
			 <i class="xi-label"></i> 교과목명(Off-JT/OJT) <a href="" class="btn btn-primary  btn-sm">온라인강의</a>
		</div>
		<div class="table-responsive mt-010">
			<table class="type-2">
				<thead>
					<tr>
						<th>주차</th>
						<th><a href="">1</a></th>
						<th><a href="">2</a></th>
						<th><a href="">3</a></th>
						<th><a href="">4</a></th>
						<th><a href="">5</a></th>
						<th><a href="">6</a></th>
						<th><a href="">7</a></th>
						<th><a href="">8</a></th>
						<th><a href="">9</a></th>
						<th><a href="">10</a></th>
						<th><a href="">11</a></th>
						<th><a href="">12</a></th>
						<th><a href="">13</a></th>
						<th><a href="">14</a></th>
						<th><a href="">15</a></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>출결 현황</th>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
						<td>O</td>
					</tr>	
					<tr>
						<th>과제 제출</th>
						<td><a href="#none" class="btn-line-yellow">미제출</a></td>
						<td><a href="#none" class="btn-line-blue">제출</a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>	
					<tr>
						<th>학습활동서</th>
						<td><a href="#none" class="btn-line-gray">완료</a></td>
						<td><a href="#none" class="btn-line-yellow">반려</a></td>
						<td><a href="#none" class="btn-line-blue">승인</a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>		
				</tbody>
			</table>
		</div>
 -->
 