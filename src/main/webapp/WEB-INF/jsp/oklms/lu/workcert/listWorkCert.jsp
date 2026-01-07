<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

						<h2>재직증빙서류</h2>

<script type="text/javascript">
<!--
$(document).ready(function() {

	com.datepickerDateFormat('startTime');
	com.datepickerDateFormat('endTime');
	<c:if test="${workCertVO.seach eq 'detail'}">showTabbtn2();</c:if>

}); 

function fn_search(){
	var reqUrl = "/lu/workcert/listWorkCert.do";
	$("#frmWorkCert").attr("target", "_self");
	$("#frmWorkCert").attr("action", reqUrl);
	$("#frmWorkCert").submit();
}

function fn_searchdetail(){
	 
	if($("#searchCompanyName").val().trim() == '기업명'){
		$("#searchCompanyName").val("");
	}
	if($("#searchValue").val().trim() == '학생명,학번 검색'){
		$("#searchValue").val("");
	}
	var reqUrl = "/lu/workcert/listWorkCert.do";
	$("#frmWorkCertListDetail").attr("target", "_self");
	$("#frmWorkCertListDetail").attr("action", reqUrl);
	$("#frmWorkCertListDetail").submit();

}

//페이지 이동
function fn_orderBy(orderValue,orderType){
	$("#orderValue").val(orderValue);
	$("#orderType").val(orderType);
	var reqUrl = "/lu/workcert/listWorkCert.do";
	$("#frmWorkCertListDetail").attr("target", "_self");
	$("#frmWorkCertListDetail").attr("action", reqUrl);
	$("#frmWorkCertListDetail").submit();;	
}

function fn_save(){
	if($( "#startTime").val() == ""){
 		alert("기간을 입력해주세요.");
 		return;		
	}
	if($( "#endTime").val() == ""){
 		alert("기간을 입력해주세요.");
 		return;		
	}
 	if($( "#relativeRegulation").val().trim() == ""){
 		alert("관련규정을 입력해주세요.");
 		return;
 	}

 	if($('#insurance').is(':checked')){	
 		$( "#insuranceYn").val("Y");
 	}else{
 		$( "#insuranceYn").val("N");
 	}
 	if($('#receipt').is(':checked')){	
 		$( "#receiptYn").val("Y");
 	}else{
 		$( "#receiptYn").val("N");
 	}
 	
 	if($('#work').is(':checked')){	
 		$( "#workYn").val("Y");
 	}else{
 		$( "#workYn").val("N");
 	}

	var reqUrl = "/lu/workcert/insertWorkCertPeriod.do";
	$("#frmWorkCert").attr("target", "_self");
	$("#frmWorkCert").attr("action", reqUrl);
	$("#frmWorkCert").submit();

}

function fn_delete(){
	
	var reqUrl = "/lu/workcert/deleteWorkCertPeriod.do";
	$("#frmWorkCertList").attr("target", "_self");
	$("#frmWorkCertList").attr("action", reqUrl);
	$("#frmWorkCertList").submit();
}

function fn_update(){ 
 	if($(':radio[name="periodId"]:checked').val() == ""){
 		alert("수정할 대상을 선택해주세요.");
 		return;
 	}	
	var reqUrl = "/lu/workcert/listWorkCert.do";
	$("#frmWorkCertList").attr("target", "_self");
	$("#frmWorkCertList").attr("action", reqUrl);
	$("#frmWorkCertList").submit();
}
function fn_popup(){
	
	popOpenWindow("", "popSearch", 650, 710);
	var reqUrl = "/lu/workcert/popupWorkCert.do";
	$("#frmWorkCertListpopup").attr("action", reqUrl);
	$("#frmWorkCertListpopup").attr("target", "popSearch");
	$("#frmWorkCertListpopup").submit();
}
function fn_popupdeatil(){
	
	popOpenWindow("", "popSearch2", 850, 710);
	var reqUrl = "/lu/workcert/popupWorkCertDetail.do";
	$("#frmWorkCertListpopup").attr("action", reqUrl);
	$("#frmWorkCertListpopup").attr("target", "popSearch2");
	$("#frmWorkCertListpopup").submit();
}
function fn_checkboxAll(){
 
		if($('#checkMember').is(":checked") == true){
			$(".checkMember").attr('checked',true);
		}else{
			$(".checkMember").attr('checked',false);
		} 
	
}

function fn_popupdeatil(){
	
	popOpenWindow("", "popSearch2", 850, 710);
	var reqUrl = "/lu/workcert/popupWorkCertDetail.do";
	$("#frmWorkCertListpopup").attr("action", reqUrl);
	$("#frmWorkCertListpopup").attr("target", "popSearch2");
	$("#frmWorkCertListpopup").submit();
}

function fn_popupdeatil(){
	
	popOpenWindow("", "popSearch2", 850, 710);
	var reqUrl = "/lu/workcert/popupWorkCertDetail.do";
	$("#frmWorkCertListpopup").attr("action", reqUrl);
	$("#frmWorkCertListpopup").attr("target", "popSearch2");
	$("#frmWorkCertListpopup").submit();
}

// 승인,반려처리
function fn_updateDetail(type){

	var memIdArr = $('input:checkbox[name="memIdArr"]').is(":checked");
	$( "#state").val(type);
	setReturnReason();
	
	if(!memIdArr){
		if(type=="01"){
			alert("승인할 학생을 선택하세요.");	
		}else if(type=="02"){
			alert("반려할 학생을 선택하세요.");
		}else{
			alert("새로고침후 다시 시도해주세요.");
		}		
		 $('input:checkbox[name="memIdArr"]').focus();
		return;
	}

	if(type=="02"){
		if($("#returnReason").val().trim() == '반려시 반려사유 필수 입력'){
			$("#returnReason").val("");
		}	
		if($("#returnReason").val().trim() == ''){
			alert("반려시 반려사유 필수 입력해주세요.");
			return;
		}
	}
	
	var reqUrl = "/lu/workcert/updateWorkCertMember.do";
	$("#frmWorkCertListDetail").attr("action", reqUrl);
 	$("#frmWorkCertListDetail").submit();
}

function fn_fileDownload(){
	var memIdArr = $('input:checkbox[name="memIdArr"]').is(":checked");
 
	if(!memIdArr){

		alert("제출서류 다운로드 하실 학생을 선택하세요");
		 $('input:checkbox[name="memIdArr"]').focus();
		return;
	}
 
	var reqUrl = "/lu/workcert/downloadWorkCertMember.do";
	$("#frmWorkCertListDetail").attr("action", reqUrl);
	$("#frmWorkCertListDetail").submit();

}


function fn_updateoffwork(workProofId,type){
 
 
	var reqUrl = "/lu/workcert/updateOffWorkCertMember.do";
	$( "#workProofId").val(workProofId) ;
	if(type=="1"){
		$( "#offInsYn").val("Y") ;
	}else if(type=="2"){
		$( "#offRecYn").val("Y") ;
	}else if(type=="3"){
		$( "#offDocYn").val("Y") ;	
	}else if(type=="4"){
		$( "#offWokYn").val("Y") ;	
	}	
	$("#frmWorkCertListDetail").attr("action", reqUrl);
	$("#frmWorkCertListDetail").submit();

}


function fn_updateoffworkclear(workProofId,type){
	 
	var reqUrl = "/lu/workcert/updateOffWorkCertClearMember.do";
	$( "#workProofId").val(workProofId) ;
	if(type=="1"){
		$( "#offInsYn").val("Y") ;
	}else if(type=="2"){
		$( "#offRecYn").val("Y") ;
	}else if(type=="3"){
		$( "#offDocYn").val("Y") ;	
	}else if(type=="4"){
		$( "#offWokYn").val("Y") ;	
	}	
	$("#frmWorkCertListDetail").attr("action", reqUrl);
	$("#frmWorkCertListDetail").submit();

}

function sms(){		
	var obj = document.getElementsByName("memIdArr");
    var arr_value = "";
    var temp = 0;
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
	fn_send_sms(0,arr_value,'${workCertVO.endTime}','WC','');
	$('html').scrollTop(0);
	
}
function mail(){	
	var obj = document.getElementsByName("memIdArr");
    var arr_value = "";
    var temp = 0;
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
	fn_send_mail(0,arr_value,'${workCertVO.endTime}','WC','');	
	$('html').scrollTop(0);
}
//--> 

function fn_previewFile(atchFileId, fileSn){
    var url = "/lu/workcert/previewFile.do"
            + "?atchFileId=" + atchFileId
            + "&fileSn=" + fileSn;
    window.open(url, "preview", "width=900,height=700");
}

function fn_updateCol(btn, memId, type, state){
	
	var $row = $(btn).closest("tr");
	var reasonVal = $row.find("input.returnReason." + type).val();

    if(state === '02' && (!reasonVal || reasonVal.trim() === '')){
        alert("반려 사유를 입력하세요.");
        return;
    }
    
    $("input[name^='returnReason']").remove();
	$("input[name='state" + type + "']").remove();
	$("input[name='memId']").remove();
	$("input[name='returnType']").remove();

    $("<input>", {
        type: "hidden",
        name: "returnReason",
        value: reasonVal
    }).appendTo("#frmWorkCertListDetail");
    
	$("<input>", {
        type: "hidden",
        name: "state"+type,
        value: state,
    }).appendTo("#frmWorkCertListDetail");
	
	$("<input>", {
        type: "hidden",
        name: "memIdArr",
        value: memId
    }).appendTo("#frmWorkCertListDetail");
	
	 $("<input>", {
        type: "hidden",
        name: "returnType",
        value: type
   	 }).appendTo("#frmWorkCertListDetail");
	
	var reqUrl = "/lu/workcert/updateWorkCertMember.do";
	$("#frmWorkCertListDetail").attr("action", reqUrl);
 	$("#frmWorkCertListDetail").submit();
}


function setReturnReason() {
    var topVal = $.trim($("#returnReasonTop").val());
    var bottomVal = $.trim($("#returnReasonBottom").val());

    var finalReason = "";

    if (topVal !== "") {
        finalReason = topVal;
    } else if (bottomVal !== "") {
        finalReason = bottomVal;
    }

    $("#returnReason").val(finalReason);
}
</script>
 

						<dl id="tab-type">
							<dt class="tab-name-11 on"><a href="javascript:showTabbtn1();">제출기간</a></dt>
							<dd id="tab-content-11" style="display:block;">
								<div class="group-area">
							
							<form name="frmWorkCert" id="frmWorkCert" method="post" >
								<input type="hidden" name="seach" value="front" />
								<input type="hidden" name="search" value="top">
								<input type="hidden" name="periodId" value="${workCertVO.periodId }" />
								<input type="hidden" name="insuranceYn" id="insuranceYn" value="${workCertVO.insuranceYn }" />	
								<input type="hidden" name="receiptYn"  id="receiptYn" value="${workCertVO.receiptYn }" />
								<input type="hidden" name="workYn"  id="workYn" value="${workCertVO.workYn }" />	
																		
									<table class="type-write mt-025">
										<colgroup>
											<col style="width:130px" />
											<col style="width:*" />
										</colgroup>
																		
										<tbody>
												<tr>
													<th>학과</th>
													<td>
														<select id="deptNo" name="deptNo"  onchange="javascript:fn_search();" > 
																<c:forEach var="result" items="${listMyDept}" varStatus="status">
															      	<option value="${result.deptNo}" <c:if test="${workCertVO.deptNo eq result.deptNo }" > selected="selected"  </c:if>>${result.deptName}</option>
															    </c:forEach>								
														</select> 													
														
													</td>
												</tr>
											<tr>
												<th>학년도</th>
												<td>
 
													<select id="yyyy" name="yyyy"  onchange="javascript:fn_search();" > 
															<c:forEach var="i" begin="0" end="5" step="1">
														      <option value="${nowYear-i}" <c:if test="${workCertVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
														    </c:forEach>								
													</select> 													
													
												</td>
											</tr>
											<tr>
												<th>학기</th>
												<td>
													<select id="term" name="term" onchange="javascript:fn_search();">
														<option value="1" <c:if test="${workCertVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
														<option value="2" <c:if test="${workCertVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
														<option value="3" <c:if test="${workCertVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
														<option value="4" <c:if test="${workCertVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
													</select>
												</td>
											</tr>
											<tr>
												<th>증빙서류</th>
												<td>
													<input type="checkbox"   id="insurance" name="insurance" <c:if test="${workCertVO.insuranceYn eq 'Y' }" >checked</c:if> class="choice" /> 원천징수영수증 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="checkbox"   id="receipt"  name="receipt"  <c:if test="${workCertVO.receiptYn eq 'Y' }" >checked</c:if> class="choice" /> 4대보험 가입증명서 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="checkbox"   id="work"  name="work" <c:if test="${workCertVO.workYn eq 'Y' }" >checked</c:if>   class="choice" /> 재직증명서
												</td>
											</tr>
											<tr>
												<th>제출기간</th>
												<td>
													<input type="text"  id="startTime" name="startTime" value="${workCertVO.startTime}"  style="width:100px" /> ~
													<input type="text"  id="endTime" name="endTime" value="${workCertVO.endTime}" style="width:100px" />
												</td>
											</tr>
											<tr>
												<th>관련규정</th>
												<td>
													<textarea name="relativeRegulation" id="relativeRegulation">${workCertVO.relativeRegulation}</textarea>
												</td>
											</tr>														
										</tbody>
					
									</table><!-- E : 재직증비서류제출기간 -->
								</form>										
									<div class="btn-area align-right mt-010">
										<a href="#"  onclick="javascript:fn_save();" class="orange">저장</a>
									</div>
								</div>



								<div class="group-area mt-030">
								
<form name="frmWorkCertList" id="frmWorkCertList" method="post" >
<input type="hidden" name="search" value="bottom">
<input type="hidden" name="seach" value="front" />
									<table class="type-2">
										<colgroup>
											<col style="width:50px" />
											<col style="width:50px" />
											<col style="width:80px" />
											<col style="width:50px" />
											<col style="width:*" />
											<col style="width:*" />
											<col style="width:*" />
										</colgroup>
										<thead>
											<tr>
												<th>선택</th>
												<th>번호</th>
												<th>학년도</th>
												<th>학기</th>
												<th>증빙서류</th>
												<th>제출기간</th>
												<th>관련규정</th>
											</tr>
										</thead>
										<tbody>
										
										<c:forEach var="workCertList" items="${workCertList}" varStatus="status">
											<tr <c:if test="${workCertList.periodId eq workCertVO.periodId}" >class="highlight"</c:if> >
												<td><input type="radio" name="periodId" value="${workCertList.periodId}"  <c:if test="${workCertList.periodId eq workCertVO.periodId}" >checked</c:if>></td>
												<td>${status.count}</td>
												<td>${workCertList.yyyy}</td>
												<td>${workCertList.termName}</td>
												<td class="left">
													<c:if test="${workCertList.insuranceYn eq 'Y'}" > 원천징수영수증</c:if>
													<c:if test="${workCertList.receiptYn eq 'Y'}" >
														<c:if test="${workCertList.insuranceYn eq 'Y'}" >,</c:if>4대보험 가입증명서 
													</c:if>
													<c:if test="${workCertList.workYn eq 'Y'}" >
														<c:if test="${workCertList.insuranceYn eq 'Y'}" >,</c:if>재직증명서
													</c:if>			
												</td>
												<td>${workCertList.startTime}-${workCertList.endTime}</td>
												<td>${workCertList.relativeRegulation}</td>
											</tr>										
										</c:forEach>
										<c:if test="${empty workCertList}" >
											<tr>
												<td colspan="7"><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>
										</tbody>
									</table>
</form>
									<div class="btn-area align-right mt-010">
										<a href="#!" onclick="javascript:fn_popup();" class="orange float-left">학기별 제출현황 출력</a> 
										<a href="#" onclick="javascript:fn_delete();" class="gray-1">삭제</a> 
										<a href="#" onclick="javascript:fn_update();" class="yellow">수정</a>
									</div>

								</div><!-- E :  재직증비서류제출현황1-->
							</dd>





							<dt class="tab-name-12"><a href="javascript:showTabbtn2();">제출현황</a></dt>
							<dd id="tab-content-12">
<c:set var="total" value="0" />				
<c:set var="ins" value="0" />
<c:set var="rec" value="0" />
<c:set var="doc" value="0" />
<c:set var="wok" value="0" />
<form name="frmWorkCertListDetail" id="frmWorkCertListDetail" method="post" >
<input type="hidden" name="search" value="top">
<input type="hidden" name="seach" value="detail" />
<input type="hidden" name="state" id="state" />
<input type="hidden" name="periodId" value="${workCertVO.periodId }" />

<input type="hidden" name="returnReason" id="returnReason" />
<input type="hidden" name="workProofId" id="workProofId"  />
<input type="hidden" name="offInsYn" id="offInsYn"  />
<input type="hidden" name="offRecYn" id="offRecYn"  />
<input type="hidden" name="offDocYn" id="offDocYn"  />
<input type="hidden" name="offWokYn" id="offWokYn"  />
<input type="hidden" name="orderValue" id="orderValue"  />
<input type="hidden" name="orderType" id="orderType"  />
 
								<div class="search-box-1 mt-020">
								
									<select id="deptNo_1" name="deptNo"  onchange="javascript:fn_searchdetail();" > 
										<c:forEach var="result" items="${listMyDept}" varStatus="status">
										      	<option value="${result.deptNo}" <c:if test="${workCertVO.deptNo eq result.deptNo }" > selected="selected"  </c:if>>${result.deptName}</option>
										  </c:forEach>								
									</select> 		
								
									<select name="yyyy"  onchange="javascript:fn_searchdetail();" > 
											<c:forEach var="i" begin="0" end="5" step="1">
										      <option value="${nowYear-i}" <c:if test="${workCertVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
										    </c:forEach>								
									</select> 	
									
									<select name="term" onchange="javascript:fn_searchdetail();">
										<option value="1" <c:if test="${workCertVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
										<option value="2" <c:if test="${workCertVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
										<option value="3" <c:if test="${workCertVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
										<option value="4" <c:if test="${workCertVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
									</select>
									
									
									<select name="searchState" onchange="javascript:fn_searchdetail();">
										<option value="" <c:if test="${workCertVO.searchState eq '' }" > selected="selected"  </c:if>>상태</option>									
										<option value="00" <c:if test="${workCertVO.searchState eq '00' }" > selected="selected"  </c:if>>미승인</option>
										<option value="01" <c:if test="${workCertVO.searchState eq '01' }" > selected="selected"  </c:if>>승인</option>
										<option value="02" <c:if test="${workCertVO.searchState eq '02' }" > selected="selected"  </c:if>>반려</option>
										<option value="03" <c:if test="${workCertVO.searchState eq '03' }" > selected="selected"  </c:if>>미제출</option>
									</select>
									
									<select id="searchName" name="searchName" onchange="">
										<option value="">이름+학번+기업명</option>
										<option value="NAME" ${param.searchName eq 'NAME' ? 'selected' : ''}>이름</option>
										<option value="ID" ${param.searchName eq 'ID' ? 'selected' : ''}>학번</option>
										<option value="COMPANY_NAME" ${param.searchName eq 'COMPANY_NAME' ? 'selected' : ''}>기업명</option>
									</select>
					 
									<%-- <input type="text" name="searchCompanyName" id="searchCompanyName" placeholder="기업명" value="${workCertVO.searchCompanyName}"   style="width:150px;" /> --%>
									<input type="text" name="searchValue"  id="searchValue" value="${workCertVO.searchValue}"  />
									
									
									<a href="#!" onclick="javascript:fn_searchdetail();">검색</a>
								</div><!-- E : search-box-1 -->

							
								<div class="btn-area mt-010" style="margin-bottom: 50px;">
									<div class="float-left">
										<a href="#!" onclick="javascript:fn_popupdeatil();" class="orange ">제출현황 출력</a>
										<a href="#"  onclick="javascript:fn_fileDownload();" class="gray-1">제출서류 다운로드</a>
										<a href="javascript:sms();" class="yellow">SMS 발송</a>
										<a href="javascript:mail();" class="orange">E-MAIL발송</a>
									</div>
									<div class="float-right">
										<input type="text" id="returnReasonTop" placeholder="반려시 반려사유 필수 입력"  onfocus="if(this.value=='');this.value=''"  />
										<a href="#" onclick="javascript:fn_updateDetail('02');" class="orange">반려</a>
										<a href="#" onclick="javascript:fn_updateDetail('01');" class="orange">승인</a>
									</div>
								</div>

								<div class="group-area mt-020">
									<!--  디자인 추가 -->
									<!-- <ul class="page-sum mb-007">
										<li class="float-right">
											<div class="list-layout">
									    	<select name="s" id="" title="정렬">
												<option value="0">정렬</option>
												<option value="1">학번순</option>
												<option value="2">시간순</option>
												<option value="3">제출순</option>
												<option value="4">미제출순</option>
											</select>
									    </div>
										</li>
									</ul> -->
									<!--  //디자인 추가 -->
									

									<div class="table-responsive">
										<table class="type-2">
											<colgroup>
												<col style="width:40px" />
												<col style="width:*" />
												<col style="width:80px" />
												<col style="width:120px" />
												<col style="width:120px" />
												<col style="width:*" />
												<col style="width:*" />
												<col style="width:*" />
												<col style="width:*" />
												<col style="width:120px" />
											</colgroup>
											<thead>
												<tr>
													<th><input type="checkbox" id="checkMember" onclick="javascript:fn_checkboxAll();" class="choice" /></th>
													<th>기업명&nbsp;<a href="javascript:fn_orderBy('LC.COMPANY_NAME','DESC');">▼</a><a href="javascript:fn_orderBy('LC.COMPANY_NAME','ASC');">▲</a></th>
													<th>학년&nbsp;<a href="javascript:fn_orderBy('CM.MEM_ID','DESC');">▼</a><a href="javascript:fn_orderBy('COMPANY_NAME','ASC');">▲</a></th>
													<th>학번&nbsp;<a href="javascript:fn_orderBy('CM.MEM_ID','DESC');">▼</a><a href="javascript:fn_orderBy('CM.MEM_ID','ASC');">▲</a></th>
													<th>이름&nbsp;<a href="javascript:fn_orderBy('CM.MEM_NAME ','DESC');">▼</a><a href="javascript:fn_orderBy('CM.MEM_NAME ','ASC');">▲</a></th>												
													<th>원천징수영수증&nbsp;<a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_REC','DESC');">▼</a><a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_REC','ASC');">▲</a></th>
													<th>4대보험가입증명서&nbsp;<a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_INC','DESC');">▼</a><a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_INC','ASC');">▲</a></th>
													<th>재직증명서&nbsp;<a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_WOK','DESC');">▼</a><a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_WOK','ASC');">▲</a></th>
													<th>보완서류&nbsp;<a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_DOC','DESC');">▼</a><a href="javascript:fn_orderBy('LWP.ATCH_FILE_ID_DOC','ASC');">▲</a></th>
													<th>승인여부&nbsp;<a href="javascript:fn_orderBy('LWP.STATE','DESC');">▼</a><a href="javascript:fn_orderBy('LWP.STATE','ASC');">▲</a></th>
												</tr>
											</thead>
											<tbody>
											<c:forEach var="workCertDetailList" items="${workCertDetailList}" varStatus="status">
										
												<tr>
													<td><input type="checkbox" name="memIdArr" value="${workCertDetailList.memId}" class="checkMember" /></td>
													<td>${workCertDetailList.companyName}</td>
													<td>${workCertDetailList.subjectGrade}</td>
													<td>${workCertDetailList.memId}</td>
													<td>${workCertDetailList.memName}</td>
													<td>
														<c:if test="${!empty workCertDetailList.atchFileIdRec}" >
															<c:choose>
																<c:when test="${workCertDetailList.stateRec eq '02'}">
																	<a href="#companion-wrap" name="modalReturnWorkComment"  data-comment="${workCertDetailList.returnReasonsRec}" rel="modal:open"><font color="red">반려</font></a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdRec}','1')" class="btn-line-blue">보기</a>
																</c:when>
																<c:otherwise>
																	<c:set var="rec" value="${rec + 1}" /><a href="javascript:com.downFile('${workCertDetailList.atchFileIdRec}','1');"><font color="blue">제출</font>(<c:out value="${workCertDetailList.atchFileIdRecDate }" />)</a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdRec}','1')" class="btn-line-blue">보기</a>
																</c:otherwise>
															</c:choose>
															<div class="btn-area mt-010">
																<input type="text" name="returnReasonRec" class="returnReason Rec" placeholder="반려시 반려사유 필수 입력" />
																<a href="#" onclick="javascript:fn_updateCol(this, '${workCertDetailList.memId}', 'Rec', '02');" class="orange">반려</a>
															</div>
														</c:if>
														<c:if test="${empty workCertDetailList.atchFileIdRec}" >
															<c:if test="${workCertDetailList.offRecYn eq 'Y' }">
															<c:set var="rec" value="${rec + 1}" />오프라인 제출<a href="#!" onclick="javascript:fn_updateoffworkclear('${workCertDetailList.workProofId}','2');" class="btn-line-orange">취소</a>
															</c:if>
															<c:if test="${workCertDetailList.offRecYn ne 'Y' }">
															미제출<a href="#!" onclick="javascript:fn_updateoffwork('${workCertDetailList.workProofId}','2');" class="btn-line-blue">접수</a>
															</c:if>
														</c:if>													
													</td>
													<td>
														<c:if test="${!empty workCertDetailList.atchFileIdInc}" >
															<c:choose>
																<c:when test="${workCertDetailList.stateInc eq '02'}">
																	<a href="#companion-wrap" name="modalReturnWorkComment"  data-comment="${workCertDetailList.returnReasonsInc}" rel="modal:open"><font color="red">반려</font></a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdInc}','1')" class="btn-line-blue">보기</a>
																</c:when>
																<c:otherwise>
																	<c:set var="ins" value="${ins + 1 }" /><a href="javascript:com.downFile('${workCertDetailList.atchFileIdInc}','1');"><font color="blue">제출</font>(<c:out value="${workCertDetailList.atchFileIdIncDate }" />)</a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdInc}','1')" class="btn-line-blue">보기</a>
																</c:otherwise>
															</c:choose>
															<div class="btn-area mt-010">
																<input type="text" name="returnReasonInc" class="returnReason Inc" placeholder="반려시 반려사유 필수 입력" />
																<a href="#" onclick="javascript:fn_updateCol(this, '${workCertDetailList.memId}', 'Inc', '02');" class="orange">반려</a>
															</div>
														</c:if>
														<c:if test="${empty workCertDetailList.atchFileIdInc}" >
															<c:if test="${workCertDetailList.offInsYn eq 'Y' }">
															<c:set var="ins" value="${ins + 1 }" />오프라인 제출<a href="#!" onclick="javascript:fn_updateoffworkclear('${workCertDetailList.workProofId}','1');" class="btn-line-orange">취소</a>
															</c:if>
															<c:if test="${workCertDetailList.offInsYn ne 'Y' }">
															미제출<a href="#!"  onclick="javascript:fn_updateoffwork('${workCertDetailList.workProofId}','1');" class="btn-line-blue">접수</a>
															</c:if>
														</c:if>
													</td>
																										
													<td>
														<c:if test="${!empty workCertDetailList.atchFileIdWok}" >
															<c:choose>
																<c:when test="${workCertDetailList.stateWok eq '02'}">
																	<a href="#companion-wrap" name="modalReturnWorkComment"  data-comment="${workCertDetailList.returnReasonsWok}" rel="modal:open"><font color="red">반려</font></a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdWok}','1')" class="btn-line-blue">보기</a>
																</c:when>
																<c:otherwise>
																	<c:set var="wok" value="${wok + 1 }" /><a href="javascript:com.downFile('${workCertDetailList.atchFileIdWok}','1');"><font color="blue">제출</font>(<c:out value="${workCertDetailList.atchFileIdWokDate }" />)</a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdWok}','1')" class="btn-line-blue">보기</a>
																</c:otherwise>
															</c:choose>
															<div class="btn-area mt-010">
																<input type="text" name="returnReasonWok" class="returnReason Wok" placeholder="반려시 반려사유 필수 입력" />
																<a href="#" onclick="javascript:fn_updateCol(this, '${workCertDetailList.memId}', 'Wok', '02');" class="orange">반려</a>
															</div>
														</c:if>
														<c:if test="${empty workCertDetailList.atchFileIdWok}" >
															<c:if test="${workCertDetailList.offWokYn eq 'Y' }">
															<c:set var="ins" value="${wok + 1 }" />오프라인 제출<a href="#!" onclick="javascript:fn_updateoffworkclear('${workCertDetailList.workProofId}','4');" class="btn-line-orange">취소</a>
															</c:if>
															<c:if test="${workCertDetailList.offWokYn ne 'Y' }">
															미제출<a href="#!"  onclick="javascript:fn_updateoffwork('${workCertDetailList.workProofId}','4');" class="btn-line-blue">접수</a>
															</c:if>
														</c:if>
														
													</td>
													
													<td>
														<c:if test="${!empty workCertDetailList.atchFileIdDoc}" >
															<c:choose>
																<c:when test="${workCertDetailList.stateDoc eq '02'}">
																	<a href="#companion-wrap" name="modalReturnWorkComment"  data-comment="${workCertDetailList.returnReasonsDoc}" rel="modal:open"><font color="red">반려</font></a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdWok}','1')" class="btn-line-blue">보기</a>
																</c:when>
																<c:otherwise>
																	<c:set var="doc" value="${doc + 1}" /><a href="javascript:com.downFile('${workCertDetailList.atchFileIdDoc}','1');"><font color="blue">제출</font>(<c:out value="${workCertDetailList.atchFileIdDocDate }" />)</a>
																	<a href="#;" onclick="fn_previewFile('${workCertDetailList.atchFileIdWok}','1')" class="btn-line-blue">보기</a>
																</c:otherwise>
															</c:choose>
															<div class="btn-area mt-010">
																<input type="text" name="returnReasonDoc" class="returnReason Doc" placeholder="반려시 반려사유 필수 입력" />
																<a href="#" onclick="javascript:fn_updateCol(this, '${workCertDetailList.memId}', 'Doc', '02');" class="orange">반려</a>
															</div>
														</c:if>
														<c:if test="${empty workCertDetailList.atchFileIdDoc}" >
															<c:if test="${workCertDetailList.offDocYn eq 'Y' }">
															<c:set var="doc" value="${doc + 1}" />오프라인 제출<a href="#!"  onclick="javascript:fn_updateoffworkclear('${workCertDetailList.workProofId}','3');" class="btn-line-orange">취소</a>
															</c:if>
															<c:if test="${workCertDetailList.offDocYn ne 'Y' }">
															미제출<a href="#!"  onclick="javascript:fn_updateoffwork('${workCertDetailList.workProofId}','3');" class="btn-line-blue">접수</a>
															</c:if>
														</c:if>
													</td>
													<td>
													<c:choose>
														<c:when test="${workCertDetailList.sendYn eq 'N'}" >미제출</c:when>
														<c:when test="${workCertDetailList.sendYn eq 'Y'}" >
															 <c:choose>
													            <c:when test="${workCertDetailList.state eq '00'
													                          || workCertDetailList.stateRec eq '00'
													                          || workCertDetailList.stateInc eq '00'
													                          || workCertDetailList.stateWok eq '00'
													                          || workCertDetailList.stateDoc eq '00'}">
													                미승인
													            </c:when>
													
													            <c:when test="${workCertDetailList.state eq '02'
													                          || workCertDetailList.stateRec eq '02'
													                          || workCertDetailList.stateInc eq '02'
													                          || workCertDetailList.stateWok eq '02'
													                          || workCertDetailList.stateDoc eq '02'}">
													
													                <a href="#companion-wrap"
													                   name="modalReturnWorkComment"
													                   data-comment="${workCertDetailList.returnReasons}"
													                   rel="modal:open">반려</a>
													                <br/>
													                <b>${workCertDetailList.returnReason}</b>
													            </c:when>
													
													            <c:when test="${workCertDetailList.state eq '01'}">
													                <c:set var="total" value="${total + 1}" />
													                승인
													            </c:when>
													
													        </c:choose>
															
														</c:when>
													</c:choose>
													</td>
												</tr>										
											</c:forEach>
											<c:if test="${!empty workCertDetailList}" >
												<tr>
													<td colspan="3">계</td>
													<td colspan="2">${fn:length(workCertDetailList)} 명</td>
													<td>${rec} 명</td>
													<td>${ins} 명</td>
													<td>${wok} 명</td>
													<td>${doc} 명</td>
													<td>${total} 명</td>
												</tr>
											</c:if>
											<c:if test="${empty workCertDetailList}" >
												<tr>
													<td colspan="10"><spring:message code="common.nodata.msg" /></td>												
												</tr>
											</c:if>
												
											</tbody>
										</table>
									</div>

									<div class="btn-area mt-010">
										<div class="float-left">
											<a href="#!" onclick="javascript:fn_popupdeatil();" class="orange ">제출현황 출력</a>
											<a href="#"  onclick="javascript:fn_fileDownload();" class="gray-1">제출서류 다운로드</a>
											<a href="javascript:sms();" class="yellow">SMS 발송</a>
											<a href="javascript:mail();" class="orange">E-MAIL발송</a>
										</div>
										<div class="float-right">
											<input type="text" id="returnReasonBottom" placeholder="반려시 반려사유 필수 입력"  onfocus="if(this.value=='');this.value=''"  />
											<a href="#" onclick="javascript:fn_updateDetail('02');" class="orange">반려</a>
											<a href="#" onclick="javascript:fn_updateDetail('01');" class="orange">승인</a>
										</div>
									</div>

								</div><!-- E :  list-->

</form>

							</dd>
						</dl>
<form name="frmWorkCertListpopup" id="frmWorkCertListpopup" method="post" >
	<input type="hidden" name="yyyy" value="${workCertVO.yyyy}"/>
	<input type="hidden" name="term" value="${workCertVO.term}"/>
</form>						