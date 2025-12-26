<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>
						<h2>학습활동서 조회</h2>

						<div class="gropu-area">
							<div class="table-responsive">
								<table class="type-2">
									<caption>기업명 소재지 선정일 훈련과정명에 대한 정보 제공</caption>
									<colgroup>
										<col style="width:250px" />
										<col style="width:*" />
										<col style="width:*" />
										<col style="width:*" />
									</colgroup>
									<tr>
										
										<th scope="col">기업명</th>
										<th scope="col">소재지</th>
										<th scope="col">선정일</th>
										<th scope="col">훈련과정명</th>
									</tr>
									
									<c:if test="${!empty result}">
										<c:forEach var="result" items="${result}" varStatus="status">
											<tr <c:if test="${result.companyId eq param.companyId and result.traningProcessId eq param.traningProcessId }">class="highlight"</c:if>>
												<td><a href="javascript:fn_traning_search('${result.companyId }','${result.traningProcessId }');">${result.companyName }</a></td>
												<td>${result.address }</td>
												<td>${result.insertDate }</td>
												<td>${result.hrdTraningName }</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty result}">
									<tr>
										<td colspan="4">기업체를 선택하세요</td>
									</tr>								
									</c:if> 
								</table>
							</div>

							<div class="btn-area mt-010">
								<div class="float-right">
									<!-- <a href="javascript:showCompanypop();" class="yellow">기업체검색</a> -->
									<a href="javascript:fn_company_search();" class="yellow">기업체검색</a>
								</div>
							</div><!-- E : btn-area -->
						</div>


<script type="text/javascript">
<!--
/*************************************************************
학습창 슬라이딩/목차 관련 스크립트
**************************************************************/

var showLearningpop = function(){
	$(".learning-area,.popup-bg").addClass("open"); 
	window.location.hash = "#open"; 
};
var hideLearningpop = function(){
	var reqUrl = "/lu/interview/listInterviewCenter.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	
	$(".learning-area,.popup-bg").removeClass("open"); 
};

$(function() {
	$('.list-zone dt').click(function(){
		$(this).parent().siblings().find('dd').slideUp();
		$(this).siblings('dd').slideToggle();
	});

	$('.list-zone dd a').click(function(){
		$(this).addClass('current');
		$(this).siblings().removeClass('current');
	});
});


var showCompanypop = function(){
	$(".company-area,.popup-bg").addClass("open"); 
	window.location.hash = "#open"; 
};
var hideCompanypop = function(){ 
	var reqUrl = "/lu/activity/listActivityHrd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	
	//$(".company-area,.popup-bg").removeClass("open"); 
};


$(document).ready(function() {
	/* $.ajax({
		  type: "POST",
		  url: "/lu/interview/ajaxInterviewCompany.do",
		  data: { "searchCompanyName": "","searchHrdTraningName":"","pageIndex":"1"},
		  success:function( html ) {
			$( "#interviewCompanyList" ).html( html );			
		  }
	}); */
});
 
function checkboxClick(companyIdstd,traningProcessIdstd){	 
   	$("#companyId").val( companyIdstd );
   	$("#traningProcessId").val( traningProcessIdstd );
}

function searchCompany(param){
	var searchCompanyName = $("#searchCompanyName1").val( );
	$.ajax({
		  type: "POST",
		  url: "/lu/interview/ajaxInterviewCompany.do",
		  data: { "searchCompanyName": searchCompanyName,"searchHrdTraningName":"","pageIndex":param},
		  success:function( html ) {
			$( "#interviewCompanyList" ).html( html );			
		  }
	});	
}
function fn_search(){ 
	var reqUrl = "/lu/activity/listActivityHrd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
};
function fn_detail(weekCnt,traningType){ 
	$("#weekCnt").val(weekCnt );
	$("#traningType").val(traningType );
	var reqUrl = "/lu/activity/selectActivityHrd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
};
function fn_excelDown(){ 
	var reqUrl = "/lu/activity/listActivityHrdExcel.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
};

function fn_print(){ 
	var reqUrl = "/lu/activity/printActivityHrd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_blank");
	$("#frmActivity").submit();	 
};

function sms(){
		  
	if(!$('input:radio[name=listweekCnt]').is(':checked')){
		alert("선택된 주차가 없습니다.");
		return;
	}
    var weekCnt = $(":radio[name='listweekCnt']:checked").val();

    var arr_value = $("#week"+weekCnt).val();
	var lastDate  = $("#lastDate"+weekCnt).val();

	fn_send_sms(weekCnt,arr_value,lastDate,'AC','');
	
}

function fn_traning_search(companyId,traningProcessId){ 
	var reqUrl = "/lu/activity/listActivityHrd.do";
	$("#companyId").val(companyId);
	$("#traningProcessId").val(traningProcessId);
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
}

function fn_company_search(){
	popOpenWindow("", "popSearchCompany", 670, 600);
	var reqUrl = "/lu/popup/goPopupSearchCcnCompany.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target", "popSearchCompany");
	$("#frmActivity").submit();
}

function fn_company_add(baseCheckCompanyIds){ 
	var reqUrl = "/lu/activity/listActivityHrd.do";
	
	$("#baseCheckCompanyIds").val(baseCheckCompanyIds);
	
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
}

//-->
</script>
<form:form commandName="frmActivity" name="frmActivity" method="post"  >
		<input type="hidden" name="companyId" id="companyId" value="${param.companyId }"  />
		<input type="hidden" name="traningProcessId" id="traningProcessId"  value="${param.traningProcessId }" />
		<input type="hidden" name="weekCnt" id="weekCnt"  />
		<input type="hidden" name="traningType" id="traningType"  />	
		<input type="hidden" name="baseCheckCompanyIds" id="baseCheckCompanyIds" value="${param.baseCheckCompanyIds }"  />	

						<div class="search-box-1 mt-020 ">
							<select id="yyyy" name="yyyy" onchange="javascript:fn_search();" > 
									<c:forEach var="i" begin="0" end="5" step="1">
								      <option value="${nowYear-i}" <c:if test="${activityVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
								    </c:forEach>								
							</select> 

							<select name="term" onchange="javascript:fn_search();"> 
								<option value="1" <c:if test="${activityVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
								<option value="2" <c:if test="${activityVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
								<option value="3" <c:if test="${activityVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
								<option value="4" <c:if test="${activityVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
							</select>
							<a href="#!" onclick="javascript:fn_search();">검색</a>
						</div><!-- E : search-box-1 -->

</form:form>

						<div class="table-responsive mt-010">
							<table class="type-2">
								<caption>선택 주차 학습기간 제출현황에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:50px" />
									<col style="width:*" />
									<col style="width:250px" />
									<col style="width:200px" />
									<col style="width:200px" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" rowspan="2">선택</th>
										<th scope="col" rowspan="2">주차</th>
										<th scope="col" rowspan="2">학습기간</th>
										<th scope="col" colspan="2">제출현황</th>
									</tr>
									<tr>
										<th scope="col" class="border-left">OJT</th>
										<th scope="col">Off-JT</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultlist}" varStatus="status">
										<tr>
											<td>
												<label for="listweekCnt" class="hidden">선택</label>
												<input type="radio" name="listweekCnt" id="listweekCnt"  value="${result.weekCnt}" class="choice" />
												<input type="hidden" name="week${result.weekCnt}" id="week${result.weekCnt}"  value="${result.workName}" />
												<input type="hidden" name="lastDate${result.weekCnt}" id="lastDate${result.weekCnt}"  value="${result.weekEdDate}" />
											</td>
											<td>${result.weekCnt}주차</td>
											<td>${result.weekStDate}-${result.weekEdDate}</td>
											<td>
	
										<c:if test="${result.ojtWorkCount eq '0' }">
										-
										</c:if>										
										<c:if test="${result.ojtWorkCount ne '0' }">
											<c:if test="${result.ojtCount ne result.ojtWorkCount}">
											<a href="#!" onclick="javascript:fn_detail('${result.weekCnt}','OJT');" >미제출(${result.ojtCount} / ${result.ojtWorkCount }) </a>
											</c:if>
											<c:if test="${result.ojtCount eq result.ojtWorkCount}">
											<a href="#!" onclick="javascript:fn_detail('${result.weekCnt}','OJT');" class="btn-line-blue">조회</a>
											</c:if>
										</c:if>
	
											</td>
											<td>
	
										<c:if test="${result.offWorkCount eq '0' }">
										-
										</c:if>										
										<c:if test="${result.offWorkCount ne '0' }">
											<c:if test="${result.offCount ne result.offWorkCount}">
											<a href="#!" onclick="javascript:fn_detail('${result.weekCnt}','OFF');" >미제출(${result.offCount} / ${result.offWorkCount }) </a>
											</c:if>
											<c:if test="${result.offCount eq result.offWorkCount}">
											<a href="#!" onclick="javascript:fn_detail('${result.weekCnt}','OFF');" class="btn-line-blue">조회</a>
											</c:if>
										</c:if>									
											
											</td>
										</tr>								
									</c:forEach>
									<c:if test="${empty resultlist}">
									<tr>
										<td colspan="5">등록된 데이터가 없습니다.</td>
									</tr>							
									</c:if>
	   
									
								</tbody>
							</table>
						</div>

						<div class="btn-area mt-010">
							<div class="float-right">
								<a href="#!" onclick="javascript:sms();" class="yellow">SMS 발송</a>
								<!-- <a href="#!" onclick="javascript:fn_excelDown();" class="orange">엑셀 저장</a> -->
								<a href="#!" onclick="javascript:fn_print();" class="gray-1">출력</a>
							</div>
						</div><!-- E : btn-area -->

			<ul id="student-popup">
				<li class="company-area" id="interviewCompanyList">
				</li>
				<li class="popup-bg"></li>
			</ul><!-- E : student-popup -->

