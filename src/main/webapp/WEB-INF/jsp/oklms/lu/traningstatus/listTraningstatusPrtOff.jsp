<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

						<h2><c:out value="${curMenu.menuTitle }" /></h2>
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
	$("#mode").val("0");
	$("#searchCondition").val("offline");
	$("#frmTraningstatus").attr("target", "_blank");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();

}

function fn_offonlinePopup(){
	$("#mode").val("0"); 
	var reqUrl = "/lu/traningstatus/popupTraningstatusPrt.do";
	$("#searchCondition").val("online");	
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

							<h4 class="mt-020 mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode } / ${currProcVO.subClass }반</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
<!-- 
								<div class="progress-area mb-030">
									<p>권장 진도율 (<fmt:formatNumber value="${ getProgress.allTimeHourNow/getProgress.totalTime }"  type="percent" />)</p>
									<progress value="${ getProgress.allTimeHourNow/getProgress.totalTime *100 }" max="100" style="width: 100%"></progress>
									<p>실제 진도율<c:if test="${ getProgress.realProgressRate > 0}" > (<fmt:formatNumber value="${ getProgress.realProgressRate/100 }"  type="percent" />)</c:if></p>
									<progress value="${ getProgress.realProgressRate }" max="100" style="width: 100%"></progress>								
								</div>
 -->								
								<!-- E : 진행율 -->
								
									<c:if test="${!empty onlineTraningVO}">
<c:if test="${currProcVO.onlineType ne 'NONE'}"> 
									<table  class="type-3 wp100">
										<caption>출석 지각 결석에 대한 정보 제공</caption>
										<tr>
											<th scope="row">ON-LINE 출석정책</th>
											<th scope="row"> 출석 </th>
											<td>${onlineTraningVO.attendProgress}이상</td>
											<th scope="row">지각</th>
											<td> ${onlineTraningVO.attendProgress} 미만&nbsp; ${onlineTraningVO.cutProgress}이상 </td>
											<th scope="row"> 결석 </th>
											<td>${onlineTraningVO.cutProgress}이상</td>
										</tr>
									</table>		
</c:if>
									</c:if>
									
<form name="frmTraningstatus" id="frmTraningstatus" method="post">


<input type="hidden" id="yyyy" name="yyyy" value="${traningStatusVO.yyyy }"/>
<input type="hidden" id="term" name="term" value="${traningStatusVO.term}"/>
<input type="hidden" id="classId" name="classId" value="${traningStatusVO.classId}"/>
<input type="hidden" id="subjectCode" name="subjectCode" value="${traningStatusVO.subjectCode}"/>

<input type="hidden" id="mode" name="mode" value="0"/>

<input type="hidden" id="searchCondition" name="searchCondition" value=""/>

								<div class="search-box-1 mt-020 mb-020">
								
<c:if test="${currProcVO.onlineType ne 'NONE'}"> 
									<label for="searchType" class="hidden">진도 선택</label>
									<select id="searchType"  name="searchType" >
										<option value="O1" <c:if test="${traningStatusVO.searchType eq 'O1' }" >selected</c:if> > 온라인진도</option>
										<!--option value="">강의실결석</option>
										<option value="">온라인결석</option-->
									</select>
									
									
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
									</select>  <label for="searchEndRate">이하</label>
</c:if>									
									<label for="searchMemName" class="hidden"> 검색어 입력</label>		
									<input type="text" name="searchMemName" id="searchMemName"  placeholder="학생명을 입력하세요." value="${traningStatusVO.searchMemName }" />
									<a href="#!" onclick="javascript:fn_search();">검색</a>
								</div><!-- E : search-box-1 -->

 

								<div class="table-responsive">
								<table class="type-2">
									<caption>번호 학번 이름 학년 강의실 ON-LINE 출석 지각 결석 진도율에 대한 정보 제공</caption>
									<colgroup>
<c:choose>

<c:when test="${currProcVO.onlineType eq 'NONE'}"> 
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:15%" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:6%" />
										<col style="width:6%" /> 
										<col style="width:6%" />
										<col style="width:6%" />
										<col style="width:6%" />
</c:when>

<c:otherwise>
										<col style="width:5%" />
										<col style="width:5%" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:6%" />
										<!-- 
										<col style="width:6%" />
										-->
										<col style="width:6%" /> 
										<col style="width:6%" />
										<col style="width:*" />
										<col style="width:6%" />
										<col style="width:6%" />
										<col style="width:6%" />
										<col style="width:*" />
</c:otherwise>
</c:choose>

										
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2"><label for="check0" class="hidden">선택</label><input type="checkbox" id="check0" onclick="javascript:com.checkAll('check0','memIdArr');" class="choice" /></th>
											<th scope="col" rowspan="2">번호</th>
											<th scope="col" rowspan="2">기업명</th>
											<th scope="col" rowspan="2">학번</th>
											<th scope="col" rowspan="2">이름</th>
											<th scope="col" rowspan="2">사진</th>
											<th scope="col" rowspan="2">학년</th>
											<!-- 
											<th scope="col" colspan="4">강의실</th>
											 -->
											<th scope="col" colspan="3">강의실</th>
<c:if test="${currProcVO.onlineType ne 'NONE'}"> 
											<th scope="col" colspan="4">ON-LINE</th>
</c:if>											
										</tr>
										<tr>
											<th scope="col" class="border-left">출석</th>
											<th scope="col">지각</th>
											<th scope="col">결석</th>
											<!-- 
											<th scope="col">진도율</th>
											 -->
<c:if test="${currProcVO.onlineType ne 'NONE'}"> 
											<th scope="col" class="border-left">출석</th>
											<th scope="col">지각</th>
											<th scope="col">결석</th>
											<th scope="col">진도율</th>
</c:if>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="resultlists" items="${resultlist}" varStatus="status">
										<tr>
											<td><label for="memIdArr" class="hidden">선택</label><input type="checkbox" id="memIdArr" name="memIdArr" value="${resultlists.memId }"  /></td>
											<td>${status.count}</td>
											<td>${resultlists.companyName }</td>
											<td>${resultlists.memId }</td>
											<td>
												<c:choose>
													<c:when test="${resultlists.outYn eq 'Y'}">
														<font color="red">${resultlists.memName }</font> 
													</c:when>
													<c:otherwise>
														${resultlists.memName }
													</c:otherwise>
												</c:choose>
											</td>
											<td><img src="/commbiz/photo/getAunuriUserImage.do?memId=${resultlists.memId }" width="65" height="55" alt="${resultlists.memName }"  /> </td>
											<td>${resultlists.subjectGrade}</td>
											
											<td>${resultlists.attend }</td>
											<td>${resultlists.lateness }</td>
											
											
 											<td>${resultlists.absDay}</td>
 											
 											<!-- 
											<td>
												<div class="progress-area2">
													<p>
														<c:if test="${resultlists.realProgressRate >100}">100</c:if>
														<c:if test="${resultlists.realProgressRate <=100}">${resultlists.realProgressRate}</c:if>													
													 %</p>
													<progress value="${resultlists.realProgressRate }" max="100"></progress>
												</div>
											</td>
											-->
<c:if test="${currProcVO.onlineType ne 'NONE'}"> 
											<td>${resultlists.onAttend }</td>
											<td>${resultlists.onLateness }</td>
 											<td>
 											<c:if test="${!empty onlineTraningVO}">
 											${resultlists.onTotalTime - resultlists.onAttend - resultlists.onLateness}
 											</c:if>
 											<c:if test="${empty onlineTraningVO}">
 											0
 											</c:if>
 											</td>
											<td>
												<div class="progress-area2">
													<p><c:if test="${resultlists.onRealProgressRate >100}">100</c:if>
														<c:if test="${resultlists.onRealProgressRate <=100}">${resultlists.onRealProgressRate}</c:if>%</p>
													<progress value="${resultlists.onRealProgressRate}" max="100"></progress>
												</div>
											</td>
</c:if>											
										</tr>
									</c:forEach>
<!-- script type="text/javascript"> imgonerror(); </script -->
								<c:if test="${empty resultlist}">
									<tr>
										<td colspan="13">등록된 데이터가 없습니다.</td>
									</tr>							
								</c:if>
								
									</tbody>
								</table>
								</div>
								<!-- E : 전체 학습근로자관리-->
</form>
								<div class="btn-area mt-010"> 
									<div class="float-left">
										<a href="#!" onclick="javascript:fn_offPopup();" class="black">강의실 출석부</a>
										<a href="#!" onclick="javascript:fn_offonlinePopup();" class="black">온라인 출석부</a>
									</div>
									
									<div class="float-right">
									<a href="javascript:fn_print();" class="orange">훈련현황 출력</a>
 
									<a href="#" onclick="javascript:sms();" class="yellow">SMS 발송</a>
									<a href="#" onclick="javascript:email();" class="orange">E-MAIL 발송</a>
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
										<option value="O2" <c:if test="${traningStatusVO.searchType eq 'O2' }" >selected</c:if> > 온라인진도</option>
									</select>
									<input type="text" name="searchStartRateDetail" id="searchStartRateDetail" class="wp10"  value="${traningStatusVO.searchStartRateDetail}" /> <label for="searchStartRateDetail">이상</label>
									<input type="text" name="searchEndRateDetail" id="searchEndRateDetail" class="wp10"  value="${traningStatusVO.searchEndRateDetail}" /> <label for="searchEndRateDetail">이하</label>

									
									<label for="searchMemNameDetail" class="hidden"> 검색어 입력</label>		
									<input type="text" name="searchMemNameDetail" id="searchMemNameDetail" value="${traningStatusVO.searchMemNameDetail }" />
									<a href="#!" onclick="javascript:fn_searchDetail();">검색</a>
								</div><!-- E : search-box-1 -->
 


								<table class="type-2">
									<caption>학번 이름 실제및계획의 훈련시간 온라인진도 학습활동서에 대한 정보 제공</caption>
									<colgroup>
										<col style="width:6%" />
										<col style="width:*" />
										<col style="width:*" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:10%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col"><label for="check1" class="hidden">선택</label><input type="checkbox"  id="check1" onclick="javascript:com.checkAll('check1','memSeq');" class="choice" /></th>
											<th scope="col">학번</th>
											<th scope="col">이름</th>
											<th scope="col">훈련시간 (실제/계획)</th>
											<th scope="col">온라인진도</th>
											<th scope="col">학습활동서</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="resultBottomlist" items="${resultBottomlist}" varStatus="status">
										<tr>
											<td><label for="memSeq" class="hidden">선택</label><input type="checkbox" name="memSeq" id="memSeq" value="${resultBottomlist.memId }"   class="memSeq" /></td>
											<td>${resultBottomlist.memId }</td>
											<td>
											
											<c:choose>
													<c:when test="${resultBottomlist.outYn eq 'Y'}">
														<font color="red">${resultBottomlist.memName }</font> 
													</c:when>
													<c:otherwise>
														${resultBottomlist.memName }
													</c:otherwise>
												</c:choose>
											
											</td>
											
											
											<td>${resultBottomlist.studyTime}/${resultBottomlist.studyPlanTime}</td>
											<td>${resultBottomlist.onRealProgressRate}%</td>
											<td>
												<c:if test="${!empty resultBottomlist.content}">
												<a href="/lu/activity/listActivityPrt.do?weekCnt=${traningStatusVO.weekCnt}&memId=${resultBottomlist.memId}" class="btn-line-gray">작성</a>
												</c:if>
												<c:if test="${empty resultBottomlist.content}">
												<a href="/lu/activity/listActivityPrt.do?weekCnt=${traningStatusVO.weekCnt}&memId=${resultBottomlist.memId}" class="btn-line-orange">미작성</a>
												</c:if>
												
											</td>
										</tr>
									</c:forEach>
 								<c:if test="${empty resultBottomlist}">
									<tr>
										<td colspan="6">등록된 데이터가 없습니다.</td>
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

 