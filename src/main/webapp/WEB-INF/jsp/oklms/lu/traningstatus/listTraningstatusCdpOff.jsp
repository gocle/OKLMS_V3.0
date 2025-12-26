<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

						<h2>학습근로자 훈련현황</h2>
<script type="text/javascript">
<!--

$(document).ready(function() {
	 
 
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
	 
	var reqUrl = "/lu/traningstatus/listTraningstatusCdp.do";
	$("#mode").val("0");
	$("#frmTraningstatus").attr("target", "_self");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();

}
function fn_print(){
	 
	var reqUrl = "/lu/traningstatus/listTraningstatusCdp.do";
	$("#mode").val("1");
	$("#frmTraningstatus").attr("target", "_blank");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();

}
 
function fn_checkboxAll(){
	 
	$('#frmTraningstatus input:checkbox[name="memIdArr"]').each(function(){
		if($(this).is(":checked") == true){
			$('.memIdArr').prop('checked',false);
		}else{
			$('.memIdArr').prop('checked',true);			
		}
	});
} 

 
function fn_offonlinePopup(){
	$("#mode").val("0"); 
	var reqUrl = "/lu/traningstatus/popupTraningstatusCdp.do";
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
	fn_send_sms(0,arr_value,'','OC','${currProcVO.subjectCode}');
	
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
	fn_send_mail(0,arr_value,'','OC','${currProcVO.subjectCode}');	
}



//--> 
</script>
<c:set var="realProgressRateStd" value="0" />
<c:forEach var="resultlists" items="${resultlist}" varStatus="status">
<c:set var="realProgressRateStd" value="${realProgressRateStd + resultlists.onRealProgressRate}" />
	<c:if test="${fn:length(resultlist) > 1}">
		<c:if test="${realProgressRateStd > 0}">
			<c:if test="${status.last}"><c:set var="realProgressRateStd" value="${realProgressRateStd /  status.index}" /></c:if>
		</c:if>				
	</c:if>
</c:forEach>

<fmt:parseNumber var="realProgressRateStdint" integerOnly="true" value="${realProgressRateStd}" />


							<h4 class="mt-020 mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode } / ${currProcVO.subClass }반</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>

								<div class="progress-area mb-030">
									<p>권장 진도율 (<fmt:formatNumber value="${ getProgress.allTimeHourNow/getProgress.totalTime }"  type="percent" />)</p>
									<progress value="${ getProgress.allTimeHourNow/getProgress.totalTime *100 }" max="100" style="width: 100%"></progress>
									<p>실제 진도율 <c:if test="${ realProgressRateStdint > 0}" >(<fmt:formatNumber value="${ realProgressRateStdint /100 }"  type="percent" />)</c:if></p>
									<progress value="${ realProgressRateStdint }" max="100" style="width: 100%"></progress>								
								</div><!-- E : 진행율 -->
								
									<c:if test="${!empty onlineTraningVO}">
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
									
<form name="frmTraningstatus" id="frmTraningstatus" method="post">


<input type="hidden" id="yyyy" name="yyyy" value="${traningStatusVO.yyyy }"/>
<input type="hidden" id="term" name="term" value="${traningStatusVO.term}"/>
<input type="hidden" id="classId" name="classId" value="${traningStatusVO.classId}"/>
<input type="hidden" id="subjectCode" name="subjectCode" value="${traningStatusVO.subjectCode}"/>

<input type="hidden" id="mode" name="mode" value="0"/>

<input type="hidden" id="searchCondition" name="searchCondition" value=""/>

								<div class="search-box-1 mt-020 mb-020">
									
									<label for="searchType" class="hidden">온라인진도</label>
									<select id="searchType"  name="searchType" >
										<option value="O1" <c:if test="${traningStatusVO.searchType eq 'O1' }" >selected</c:if> > 온라인진도</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									
									<select name="searchStartRate" id="searchStartRate" >
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
									<select  name="searchEndRate" id="searchEndRate">
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
									</select> <label for="searchEndRate"">이하</label>
									
									<label for="searchMemName"">검색어입력</label>
									<input type="text" name="searchMemName"  id="searchMemName" value="${traningStatusVO.searchMemName }" />
									<a href="#!" onclick="javascript:fn_search();">검색</a>
								</div><!-- E : search-box-1 -->


								<div class="table-responsive">
								<table class="type-2">
									<caption>번호 학번 이름 학년 출석 지각 결석 진도율에 대한 정보를 제공합니다</caption>
									<colgroup>
										<col style="width:5%" />
										<col style="width:6%" />
										<col style="width:10%" />
										<col style="width:8%" />
										<col style="width:8%" />
										<col style="width:8%" />
										<col style="width:8%" />
										<col style="width:8%" />
										<col style="width:8%" />
										<col style="width:*" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col"><label for="check0" class="hidden">선택</label><input type="checkbox"  name="check0"  id="check0" onclick="javascript:com.checkAll('check0','memIdArr');" class="choice" /></th>
											<th scope="col">번호</th>
											<th scope="col">학번</th>
											<th scope="col">이름</th>
											<th scope="col">사진</th>
											<th scope="col">학년</th>
											<th scope="col">출석</th>
											<th scope="col">지각</th>
											<th scope="col">결석</th>
											<th scope="col">진도율</th>
										</tr>
									 
									</thead>
									<tbody>
									<c:forEach var="resultlists" items="${resultlist}" varStatus="status">
										<tr>
											<td><label for="memIdArr" class="hidden">선택</label><input type="checkbox"  name="memIdArr" id="memIdArr"  value="${resultlists.memId }"  /></td>
											<td>${status.count}</td>
											<td>${resultlists.memId }</td>
											<td>${resultlists.memName }</td>
											<td><img src="/commbiz/photo/getAunuriUserImage.do?memId=${resultlists.memId }" width="65" height="55" alt="${resultlists.memName }"  /> </td>
											<td>${resultlists.subjectGrade}</td>

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
													<p>${resultlists.onRealProgressRate}%</p>
													<progress value="${resultlists.onRealProgressRate}" max="100" style="width:90%;"></progress>
												</div>
											</td>
										</tr>
									</c:forEach> 
								<c:if test="${empty resultlist}">
									<tr>
										<td colspan="9">등록된 데이터가 없습니다.</td>
									</tr>							
								</c:if>
								
									</tbody>
								</table><!-- E : 전체 학습근로자관리-->
								</div>
</form>
								<div class="btn-area mt-010"> 
									<div class="float-left">
										<a href="#!" onclick="javascript:fn_offonlinePopup();" class="gray-1 ">온라인 출석부</a>		
									</div>	
									<div class="float-right">						
										<a href="javascript:fn_print();" class="orange">훈련현황 출력</a>
	 
										<a href="javascript:sms();" class="gray-2">SMS 발송</a>
										<a href="javascript:email();" class="gray-2">E-MAIL 발송</a>
									</div>
 
								</div><!-- E : btn-area -->
			  
 