<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

						<h2>학습근로자관리</h2>
<script type="text/javascript">
<!--

$(document).ready(function() {
	 
	<c:if test="${traningStatusVO.searchType eq 'C2' or traningStatusVO.searchType eq 'O2' }">
		showTabbtn2();
	</c:if>
});

function imgError()
{
	event.srcElement.src = "/images/oklms/nonimg.png";
}

function imgonerror(){
	var all_img=document.getElementsByTagName("img");
	if(all_img.length > 0)
	{
		for(var i=0;i<all_img.length;i++)
		{
		  all_img[i].onerror=imgError;
		}
	} 
}

function fn_search(){
	 
	var reqUrl = "/lu/traningstatus/listTraningstatusPrt.do";
	$("#mode").val("0");
	$("#frmTraningstatus").attr("target", "_self");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();

}
function fn_print(){
	 
	var reqUrl = "/lu/traningstatus/listTraningstatusPrt.do";
	$("#mode").val("1");
	$("#frmTraningstatus").attr("target", "_blank");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();

}

function fn_searchDetail(){
	 
	var reqUrl = "/lu/traningstatus/listTraningstatusPrt.do";
 
	$("#frmTraningstatusDetail").attr("target", "_self");
	$("#frmTraningstatusDetail").attr("action", reqUrl);
	$("#frmTraningstatusDetail").submit();

}

function fn_checkboxAll(){
	 
	$('#frmTraningstatus input:checkbox[name="lessonId"]').each(function(){
		if($(this).is(":checked") == true){
			$('.lessonId').prop('checked',false);
		}else{
			$('.lessonId').prop('checked',true);			
		}
	});
}
function fn_checkboxAllDetail(){
	 
	$('#frmTraningstatusDetail input:checkbox[name="memSeq"]').each(function(){
		if($(this).is(":checked") == true){
			$('.memSeq').prop('checked',false);
		}else{
			$('.memSeq').prop('checked',true);			
		}
	});
}


function fn_offPopup(){
	 
	var reqUrl = "/lu/traningstatus/popupTraningstatusPrt.do";
 
	$("#searchCondition").val("offline");
	$("#frmTraningstatus").attr("target", "_blank");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();

}


function sms(){		
	var obj = document.getElementsByName("memIdArr");
	var temp = 0;
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
              temp++;
         }
    }	
	if(temp==0){
		alert("선택된 대상이 없습니다.");
		return;
	}	  
	fn_send_sms(0,arr_value,'','','${currProcVO.subjectCode}');
	
}

function email(){	
	var obj = document.getElementsByName("memIdArr");
    var temp = 0;
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
              temp++;
         }
    }
	if(temp==0){
		alert("선택된 대상이 없습니다.");
		return;
	}	  
	fn_send_mail(0,arr_value,'','','${currProcVO.subjectCode}');	
}


function smsB(){		
	var obj = document.getElementsByName("memSeq");
	var temp = 0;
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
              temp++;
         }
    }	
	if(temp==0){
		alert("선택된 대상이 없습니다.");
		return;
	}	  
	fn_send_sms(0,arr_value,'','','${currProcVO.subjectCode}');
	
}

function emailB(){	
	var obj = document.getElementsByName("memSeq");
    var temp = 0;
    var arr_value = "";
    for(var i = 0; i < obj.length; i++){
         if(obj[i].checked){
              arr_value += obj[i].value+",";
              temp++;
         }
    }
	if(temp==0){
		alert("선택된 대상이 없습니다.");
		return;
	}	  
	fn_send_mail(0,arr_value,'','','${currProcVO.subjectCode}');	
}


//--> 
</script>
						<dl id="tab-type">
							<dt class="tab-name-11 on"><a href="javascript:showTabbtn1();">전체 조회</a></dt>
							<dd id="tab-content-11" style="display:block;">
								<h4 class="mt-020 mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>


 

								<div class="progress-area mb-030">
									<%-- <p>권장 진도율 (<fmt:formatNumber value="${ getProgress.allTimeHourNow/getProgress.totalTime }"  type="percent" />)</p>
									<progress value="${ getProgress.allTimeHourNow/getProgress.totalTime *100 }" max="100" style="width: 100%"></progress> --%>
								
								<c:set var="progressRate" value="0"/>
								<c:set var="lessonCnt" value="${fn:length(resultlist)}"/>
								<c:forEach var="resultlists" items="${resultlist}" varStatus="status">
									<c:set var="progressRate"	 value="${progressRate+resultlists.realProgressRate}"/>	
								</c:forEach>
								
									<p>실제 진도율 <c:if test="${progressRate > 0}" >(<fmt:parseNumber value="${ progressRate / lessonCnt }"   />%)</c:if></p>
								
									<progress value="<fmt:parseNumber value="${ progressRate / lessonCnt }"   />" max="100" style="width: 100%"></progress>								
								
								</div><!-- E : 진행율 -->
								

<form name="frmTraningstatus" id="frmTraningstatus" method="post">
<input type="hidden" id="yyyy" name="yyyy" value="${traningStatusVO.yyyy }"/>
<input type="hidden" id="term" name="term" value="${traningStatusVO.term}"/>
<input type="hidden" id="subjectCode" name="subjectCode" value="${traningStatusVO.subjectCode}"/>
<input type="hidden" id="mode" name="mode" value="0"/>
<input type="hidden" id="searchCondition" name="searchCondition" value=""/>

								<div class="search-box-1 mt-020 mb-020">
									<label for="searchType" class="hidden">진도 선택</label>
									<select id="searchType"  name="searchType" >
										<option value="C1" <c:if test="${traningStatusVO.searchType eq 'C1' }" >selected</c:if> > 강의실진도</option> 
										<!--option value="">강의실결석</option>
										<option value="">온라인결석</option-->
									</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<select name="searchStartRate"id="searchStartRate" >
										<option value="0" <c:if test="${traningStatusVO.searchStartRate eq '0' }" >selected</c:if>>-</option>									
										<option value="100" <c:if test="${traningStatusVO.searchStartRate eq '100' }" >selected</c:if> >100%</option>
										<option value="90" <c:if test="${traningStatusVO.searchStartRate eq '90' }" >selected</c:if>>90%</option>
										<option value="80" <c:if test="${traningStatusVO.searchStartRate eq '80' }" >selected</c:if>>80%</option>
										<option value="70" <c:if test="${traningStatusVO.searchStartRate eq '70' }" >selected</c:if>>70%</option>
										<option value="60" <c:if test="${traningStatusVO.searchStartRate eq '60' }" >selected</c:if>>60%</option>
										<option value="50" <c:if test="${traningStatusVO.searchStartRate eq '50' }" >selected</c:if>>50%</option>
										<option value="40" <c:if test="${traningStatusVO.searchStartRate eq '40' }" >selected</c:if>>40%</option>
										<option value="30" <c:if test="${traningStatusVO.searchStartRate eq '30' }" >selected</c:if>>30%</option>
										<option value="20" <c:if test="${traningStatusVO.searchStartRate eq '20' }" >selected</c:if>>20%</option>
										<option value="10" <c:if test="${traningStatusVO.searchStartRate eq '10' }" >selected</c:if>>10%</option>
									</select> <label for="searchStartRate">이상</label>
									<select  name="searchEndRate"id="searchEndRate">
										<option value="100" <c:if test="${traningStatusVO.searchEndRate eq '100' }" >selected</c:if>>100%</option>
										<option value="90" <c:if test="${traningStatusVO.searchEndRate eq '90' }" >selected</c:if>>90%</option>
										<option value="80" <c:if test="${traningStatusVO.searchEndRate eq '80' }" >selected</c:if>>80%</option>
										<option value="70" <c:if test="${traningStatusVO.searchEndRate eq '70' }" >selected</c:if>>70%</option>
										<option value="60" <c:if test="${traningStatusVO.searchEndRate eq '60' }" >selected</c:if>>60%</option>
										<option value="50" <c:if test="${traningStatusVO.searchEndRate eq '50' }" >selected</c:if>>50%</option>
										<option value="40" <c:if test="${traningStatusVO.searchEndRate eq '40' }" >selected</c:if>>40%</option>
										<option value="30" <c:if test="${traningStatusVO.searchEndRate eq '30' }" >selected</c:if>>30%</option>
										<option value="20" <c:if test="${traningStatusVO.searchEndRate eq '20' }" >selected</c:if>>20%</option>
										<option value="10" <c:if test="${traningStatusVO.searchEndRate eq '10' }" >selected</c:if>>10%</option>
									</select> <label for="searchEndRate">이하</label>
									
									<label for="searchMemName" class="hidden">검색어 입력</label>
									<input type="text" name="searchMemName" value="${traningStatusVO.searchMemName }" />
									<a href="#!" onclick="javascript:fn_search();">검색</a>
								</div><!-- E : search-box-1 -->



								<div class="table-responsive">
								<table class="type-2">
									<caption>번호 분반 기업명 학번 이름 학녕 학습현황에 대한 정보 제공</caption>
									<colgroup>
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:*" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:15%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2"><label for="check0" class="hidden">선택</label><input type="checkbox" id="check0" onclick="javascript:com.checkAll('check0','memIdArr');"   class="choice" /></th>
											<th scope="col" rowspan="2">번호</th>
											<th scope="col" rowspan="2">분반</th>
											<th scope="col" rowspan="2">기업명</th>
											<th scope="col" rowspan="2">학번</th>
											<th scope="col" rowspan="2">이름</th>
											<th scope="col" rowspan="2">사진</th>
											<th scope="col" rowspan="2">학년</th>
											<th scope="col" colspan="5">학습현황</th>
										</tr>
										<tr>
											<th class="border-left">총수업일</th>
											<th>출석</th>
											<th>지각</th>
											<th>결석</th>
											<th>진도율</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="resultlists" items="${resultlist}" varStatus="status">
										<tr>
											<td><label for="memIdArr" class="hidden">선택</label><input type="checkbox" id="memIdArr" name="memIdArr" value="${resultlists.memId }"   /></td>
											<td>${status.count}</td>
											
											<td>${resultlists.classId }</td>
											<td>${resultlists.companyName }</td>
											
											<td>${resultlists.memId }</td>
											<td>${resultlists.memName }</td>
											<td><img src="/commbiz/photo/getAunuriUserImage.do?memId=${resultlists.memId }" width="65" height="55" alt="${resultlists.memName }"  /></td>
											<td>${resultlists.subjectGrade}</td>
											
											<td>${resultlists.totalTime }</td>
											<td>${resultlists.attend }</td>
											<td>${resultlists.lateness }</td>
 											<td>${resultlists.absDay }</td>
											<td>
												<div class="progress-area2">
													<p>${resultlists.realProgressRate} %</p>
													<progress value="${resultlists.realProgressRate }" max="100"></progress>
												</div>
											</td>
 
										</tr>
											 
									</c:forEach>
								<c:if test="${empty resultlist}">
									<tr>
										<td colspan="11">등록된 데이터가 없습니다.</td>
									</tr>							
								</c:if>
 
									</tbody>
								</table>
								</div><!-- E : 전체 학습근로자관리-->
</form>
								<div class="btn-area mt-010"> 
									<div class="float-left">
									<a href="#!"  onclick="javascript:fn_offPopup();" class="black">출석부</a>
									</div>
									
									<div class="float-right">
									<a href="javascript:fn_print();" class="black">훈련현황 출력</a>

									<a href="javascript:sms();" class="yellow">SMS 발송</a>
									<a href="javascript:email();"  class="orange">E-MAIL 발송</a>
									</div>
	
								</div><!-- E : btn-area -->
							</dd>





							<dt class="tab-name-12"><a href="javascript:showTabbtn2();">주차별 조회</a></dt>
							<dd id="tab-content-12">
								<h4 class="mt-020 mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode } / ${currProcVO.subClass }반</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
<form name="frmTraningstatusDetail" id="frmTraningstatusDetail" method="post">		
								<div class="search-box-1 mb-020">
									
									<label for="weekCnt" class="hidden"> 주차</label>			
									<select id="weekCnt" name="weekCnt"  onchange="javascript:fn_searchDetail();">
										<c:forEach var="result" items="${onlineTraningSchVO}" varStatus="status">
										<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq traningStatusVO.weekCnt }">selected</c:if>>${result.weekCnt}주차</option>
										</c:forEach>
									</select>									
									
									<label for="searchType" class="hidden"> 훈련시간</label>			
									<select id="searchType"  name="searchType" >
										<option value="C2" <c:if test="${traningStatusVO.searchType eq 'C2' }" >selected</c:if> > 훈련시간</option> 
									</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="searchStartRateDetail" style= "width:100px;" value="${traningStatusVO.searchStartRateDetail}" /> <abel for=""searchStartRateDetail"">이상</abel>
									<input type="text" name="searchEndRateDetail" style= "width:100px;"  value="${traningStatusVO.searchEndRateDetail}" /> <label for="searchEndRateDetail" >이하</abel>
									
									 
									<label for="searchMemNameDetail" class="hidden"> 검색어 입력</label>			
									<input type="text" name="searchMemNameDetail" id="searchMemNameDetail"  value="${traningStatusVO.searchMemNameDetail }" />
									<a href="#!" onclick="javascript:fn_searchDetail();">검색</a>
								</div><!-- E : search-box-1 -->



								<table class="type-2">
									<caption>분반 기업명 학번 이름 실제와 계획 훈련시간 학습활동서에 대한 정보 제공</caption>
									<colgroup>
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:*" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:10%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col"><label for="check1" class="hidden">선택</label><input type="checkbox" id="check1" onclick="javascript:com.checkAll('check1','memSeq');"  class="choice" /></th>
											<th scope="col">분반</th>
											<th scope="col">기업명</th>
											<th scope="col">학번</th>
											<th scope="col">이름</th>
											<th scope="col">훈련시간 (실제/계획)</th>
											<th scope="col">학습활동서</th>
										</tr>
									</thead>
									<tbody>
									
									<c:forEach var="resultBottomlist" items="${resultBottomlist}" varStatus="status">
										<tr>
											<td><label for="memSeq" class="hidden">선택</label><input type="checkbox" name="memSeq" id="memSeq"  value="${resultBottomlist.memId }"  class="memSeq" /></td>
											<td>${resultBottomlist.classId }</td>
											<td>${resultBottomlist.companyName }</td>
																						
											<td>${resultBottomlist.memId }</td>
											<td>${resultBottomlist.memName}</td>
											<td>${resultBottomlist.studyTime}/${resultBottomlist.studyPlanTime}</td>
											<td>
												<c:if test="${!empty resultBottomlist.content}">
												<a href="/lu/activity/listActivityPrt.do?weekCnt=${traningStatusVO.weekCnt}&memId=${resultBottomlist.memId}&classId=${resultBottomlist.classId}" class="btn-line-gray">작성</a>
												</c:if>
												<c:if test="${empty resultBottomlist.content}">
												<a href="/lu/activity/listActivityPrt.do?weekCnt=${traningStatusVO.weekCnt}&memId=${resultBottomlist.memId}&classId=${resultBottomlist.classId}" class="btn-line-orange">미작성</a>
												</c:if>
												
											</td>
										</tr>
									</c:forEach>
																		
								<c:if test="${empty resultBottomlist}">
									<tr>
										<td colspan="7">등록된 데이터가 없습니다.</td>
									</tr>							
								</c:if>
									</tbody>
								</table><!-- E : 주차별 학습근로자관리-->

</form>

								<div class="btn-area mt-010">
 									<div class="float-right">
									<a href="#" onclick="javascript:smsB();" class="yellow">SMS 발송</a>
									<a href="#" onclick="javascript:emailB();" class="orange">E-MAIL 발송</a>
				 					</div>
								</div><!-- E : btn-area -->
							</dd>
						</dl>

