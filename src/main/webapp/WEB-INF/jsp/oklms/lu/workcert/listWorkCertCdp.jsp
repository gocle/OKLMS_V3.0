<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>

<script type="text/javascript">
var curView;
var curPage=1;
var totPage=0;
var contentArray = [];
//var cmsData ='${cmsData}';

$(document).ready(function() {
	com.datepickerDateFormat('startDate', 'button');
	com.datepickerDateFormat('endDate', 'button');
	init();
});


function init(){


	var seach ='${seachVO.seach}';

	//alert(seach);

	if(seach == "1"){
		$(".tab-name-12").addClass('on');
		$(".tab-name-11").removeClass('on');
		$(".tab-name-13").removeClass('on');
		$(".tab-name-14").removeClass('on');
		$(".tab-name-15").removeClass('on');

		$("#tab-content-11").css('display','none');
		$("#tab-content-13").css('display','none');
		$("#tab-content-14").css('display','none');
		$("#tab-content-15").css('display','none');
		$("#tab-content-12").css('display','block');
	}else{
	//$("tab-name-12").removeClass("on");
		$(".tab-name-11").addClass('on');
		$(".tab-name-12").removeClass('on');
		$(".tab-name-13").removeClass('on');
		$(".tab-name-14").removeClass('on');
		$(".tab-name-15").removeClass('on');

		$("#tab-content-12").css('display','none');
		$("#tab-content-13").css('display','none');
		$("#tab-content-14").css('display','none');
		$("#tab-content-15").css('display','none');
		$("#tab-content-11").css('display','block');

	}

}
/**
 * 제출기간 등록
 */
function fn_insert(){
	$("#serch").val("");
	if($("#yyyy").val() == "" ){
		alert("학년도를 선택하세요. ");
		$("#yyyy").focus();
		return;

	}
	if($("#term").val() == "" ){
		alert("학기를 선택하세요. ");
		$("#term").focus();
		return;
	}

	var insurance = $('input:checkbox[name="insurance"]').is(":checked");
	if(insurance){
		$("#insuranceYn").val("Y");
	}else{
		$("#insuranceYn").val("N");
	}


	var receipt = $('input:checkbox[name="receipt"]').is(":checked");
	if(receipt){
		$("#receiptYn").val("Y");
	}else{
		$("#receiptYn").val("N");
	}


	if($("#startDate").val() == "" ){
		alert("제출기간 시작날짜를 입력하세요. ");
		$("#startDate").focus();
		return;
	}

	if($("#endDate").val() == "" ){
		alert("제출기간 종료날짜를 입력하세요. ");
		$("#endDate").focus();
		return;
	}


	var reqUrl = "/lu/workcert/goInsertWorkCertPeriod.do";
	$("#frmWorkCert").attr("action", reqUrl);
	$("#frmWorkCert").submit();

}
//수정 조회
function fn_update(){

	$("#serch").val("");
	var periodIdRadio = $('input:radio[name="periodIdRadio"]').is(":checked");
	if(!periodIdRadio){
		alert("수정 하실 증빙서류를 선택 하세요.");
		$('input:radio[name="periodIdRadio"]').focus();
		return;
	}

	$("input:radio[name='periodIdRadio']:checked").each(function(){
		$("#periodId").val(this.value);
	});

	var reqUrl = "/lu/workcert/listWorkCert.do";
	$("#frmWorkCert").attr("action", reqUrl);
	$("#frmWorkCert").submit();

}
/**
 * 제출기간 삭제
 */
function fn_delete(){
	$("#periodId").val("");
	$("#serch").val("");
	var periodIdRadio = $('input:radio[name="periodIdRadio"]').is(":checked");
	if(!periodIdRadio){
		alert("삭제 하실 증빙서류를 선택 하세요.");
		$('input:radio[name="periodIdRadio"]').focus();
		return;
	}
	$("input:radio[name='periodIdRadio']:checked").each(function(){
		$("#periodId").val(this.value);
	});

	var reqUrl = "/lu/workcert/deleteWorkCertPeriod.do";
	$("#frmWorkCert").attr("action", reqUrl);
	$("#frmWorkCert").submit();
}

/**
 * 전체 선택
 */
function fn_checkboxAll(){

	var checkAll = $('#frmWorkCertList input:checkbox[name="checkAll"]').is(":checked");
	//alert(checkAll);

	if(checkAll){
		$('#frmWorkCertList input:checkbox[name="memIdArr"]').each(function(){
			$(this).prop('checked', true);
		});
	}else{
		$('#frmWorkCertList input:checkbox[name="memIdArr"]').each(function(){
			$(this).prop('checked', false);
		});
	}


}
/**
 * 제출현황 검색
 */
function fn_search(){
	//alert("검색 ");
	$("#seach").val("1");
	var reqUrl = "/lu/workcert/listWorkCert.do";
	$("#frmWorkCertList").attr("action", reqUrl);
	$("#frmWorkCertList").submit();
	//tab-name-12

}
/**
 * 제출현황 승인
 */
function fn_approve(){

	$("#serch").val("");
	$("#returnReason").val("");
	$("#state").val("01");
	var reqUrl = "/lu/workcert/updateWorkCertMember.do";
	$("#frmWorkCertList").attr("action", reqUrl);
	$("#frmWorkCertList").submit();
}
/**
 * 제출현황 반려
 */
function fn_return(){
	$("#serch").val("");
	if($("#returnReason").val() == ""){
		alert("반려 사유는 필수 값입니다. ");
		$("#returnReason").focus();
		return;
	}
	$("#state").val("02");
	var reqUrl = "/lu/workcert/updateWorkCertMember.do";
	$("#frmWorkCertList").attr("action", reqUrl);
	$("#frmWorkCertList").submit();

}
/**
 * 학기별 제출현황 출력
 */
function fn_yaerTot(){
	//alert("학기별 제출현황 출력 ")
	//onclick="window.open('13_재직증빙서류_popup_1.html','popup1','width=650, height=710, left=300, top=150')"
	popOpenWindow("", "popSearch", 650, 710);
	var reqUrl = "/lu/workcert/popupWorkCert.do";
	$("#frmPop").attr("action", reqUrl);
	$("#frmPop").attr("target", "popSearch");
	$("#frmPop").submit();

}
/**
 * 제직증빙서류 제출현황 출력 팝업
 */
function fn_newPopup(){
	//<a href="javascirpt:fn_newPopup();" onclick="window.open('13_재직증빙서류_popup_2.html','popup1','width=850, height=710, left=300, top=150')" class="orange float-left">제출현황 출력</a>
	//alert("제출현황 출력");
	popOpenWindow("", "popSearch", 850, 710);
	var reqUrl = "/lu/workcert/popupWorkCertState.do";
	$("#frmWorkCertList").attr("action", reqUrl);
	$("#frmWorkCertList").attr("target", "popSearch");
	$("#frmWorkCertList").submit();


}
/**
 * 제출서류 다운로드
 */
function fn_fileDownload(){
	//alert("제출서류 다운로드");
	var reqUrl = "/lu/workcert/downloadWorkCertMember.do";
	$("#frmWorkCertList").attr("action", reqUrl);
	$("#frmWorkCertList").submit();

}


</script>
	<div id="content-area">
			<h2>재직증빙서류</h2>
			<form name="frmWorkCert" id="frmWorkCert" method="post">
			<input type="hidden" name="periodId" id="periodId" value="${result.periodId}"/>
			<input type="hidden" id="insuranceYn" name="insuranceYn" value=""  />
			<input type="hidden" id="receiptYn" name="receiptYn" value=""  />


						<dl id="tab-type">
							<dt class="tab-name-11"><a href="javascript:showTabbtn1();">제출기간</a></dt>
							<dd id="tab-content-11" style="display:block;">
								<div class="group-area">
									<table class="type-write mt-025">
										<colgroup>
											<col style="width:130px" />
											<col style="width:*" />
										</colgroup>
										<tbody>
											<tr>
												<th>학년도</th>
												<td>
													<select name="yyyy" id="yyyy">
														<option value="">학년도 선택</option>
														<option value="2017" <c:if test="${result.yyyy eq '2017' }" > selected="selected" </c:if>>2017학년도</option>
														<option value="2016" <c:if test="${result.yyyy eq '2016' }" > selected="selected" </c:if>>2016학년도</option>
														<option value="2015" <c:if test="${result.yyyy eq '2015' }" > selected="selected" </c:if>>2015학년도</option>
													</select>
												</td>
											</tr>
											<tr>
												<th>학기</th>
												<td>
												<select name="term" id="term">
													<option value="">학기 선택</option>
													<option value="1" <c:if test="${result.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
													<option value="3" <c:if test="${result.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
													<option value="2" <c:if test="${result.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
													<option value="4" <c:if test="${result.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
												</select>
												</td>
											</tr>
											<tr>
												<th>증빙서류</th>
												<td>
													<input type="checkbox" name="insurance" value="Y" class="choice" <c:if test="${result.insuranceYn eq 'Y' }"> checked="checked"</c:if>  /> 4대보험 가입증명서&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="checkbox" name="receipt" value="Y" class="choice" <c:if test="${result.receiptYn eq 'Y' }"> checked="checked"</c:if>  /> 원천징수영수증
												</td>
											</tr>
											<tr>
												<th>제출기간</th>
												<td>
													<input type="text" name="startTime" id="startDate" value="${result.startTime}" style="width:65px" />
													<input type="text" name="endTime" id="endDate" value="${result.endTime}" style="width:65px" />
												</td>
											</tr>
											<tr>
												<th>관련규정</th>
												<td><textarea name="relativeRegulation" maxlength="150">${result.relativeRegulation }</textarea></td>
											</tr>
										</tbody>
									</table><!-- E : 재직증비서류제출기간 -->

									<div class="btn-area align-right mt-010">
										<a href="javascript:fn_insert();" class="orange">저장</a>
									</div>
								</div>



								<div class="group-area mt-030">
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
										<c:forEach var="result" items="${resultList}" varStatus="status" >
											<tr>
												<td><input type="radio" name="periodIdRadio" value="${result.periodId}"></td>
												<td>${status.index +1}</td>
												<td>${result.yyyy }</td>
												<td>${result.term }</td>
												<td class="left">
												<c:if test="${result.insuranceYn eq 'Y' }">
												4대보험 가입증명서
												</c:if>
												<c:if test="${result.receiptYn eq 'Y' }">
												원천징수영수증
												</c:if>
												</td>
												<td>${result.startTime}-${result.endTime }</td>
												<td>${result.relativeRegulation }</td>
											</tr>
										</c:forEach>

										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td colspan="7"><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>

										</tbody>
									</table>

									<div class="btn-area align-right mt-010">
										<a href="javascript:fn_yaerTot();"  class="orange float-left">학기별 제출현황 출력</a> <a href="javascript:fn_delete();" class="gray-1">삭제</a> <a href="javascript:fn_update();" class="yellow">수정</a>
									</div>

								</div><!-- E :  재직증비서류제출현황1-->
							</dd>

						</form>


						<form name="frmWorkCertList" id="frmWorkCertList" method="post">

							<input type="hidden" id="seach" name="seach" value="${seachVO.seach}"/>
							<dt class="tab-name-12"><a href="javascript:showTabbtn2();">제출현황</a></dt>
							<dd id="tab-content-12">

								<div class="search-box-1 mt-020">
									<select name="yyyy" id="yyyy">
										<option value="">학년도 선택</option>
										<option value="2017" <c:if test="${seachVO.yyyy eq '2017' }" > selected="selected" </c:if>>2017학년도</option>
										<option value="2016" <c:if test="${seachVO.yyyy eq '2016' }" > selected="selected" </c:if>>2016학년도</option>
										<option value="2015" <c:if test="${seachVO.yyyy eq '2015' }" > selected="selected" </c:if>>2015학년도</option>
									</select>
									<select name="term" id="term">
										<option value="">학기 선택</option>
										<option value="1" <c:if test="${seachVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
										<option value="3" <c:if test="${seachVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
										<option value="2" <c:if test="${seachVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
										<option value="4" <c:if test="${seachVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
									</select>
									<select id="seachGrade" name="seachGrade" onchange="">
										<option value="">학년</option>
										<option value="2017" <c:if test="${seachVO.seachGrade eq '2017' }" > selected="selected" </c:if>>1학년</option>
										<option value="2016" <c:if test="${seachVO.seachGrade eq '2016' }" > selected="selected" </c:if>>2학년</option>
										<option value="2015" <c:if test="${seachVO.seachGrade eq '2015' }" > selected="selected" </c:if>>3학년</option>
										<option value="2014" <c:if test="${seachVO.seachGrade eq '2014' }" > selected="selected" </c:if>>4학년</option>
									</select>
									<input type="text" name="companyName" placeholder="기업명"  value="${seachVO.companyName}" style="width:150px;" />
									<input type="text" name="memName" placeholder="학생명  검색" value="${seachVO.memName}" style="width:150px;" />
									<input type="text" name="memId"  placeholder="학번 검색" value="${seachVO.memId}" style="width:150px;" />
									<select id="seachState" name="seachState" onchange="">
										<option value="">미승인</option>
										<option value="01" <c:if test="${seachVO.seachState eq '01' }" > selected="selected" </c:if>>승인</option>
										<option value="02" <c:if test="${seachVO.seachState eq '02' }" > selected="selected" </c:if>>반려</option>
									</select>
									<a href="javascript:fn_search();">검색</a>
								</div><!-- E : search-box-1 -->



								<div class="group-area mt-010">
									<table class="type-2">
										<colgroup>
											<col style="width:40px" />
											<col style="width:*" />
											<col style="width:50px" />
											<col style="width:120px" />
											<col style="width:120px" />
											<col style="width:*" />
											<col style="width:*" />
											<col style="width:*" />
											<col style="width:70px" />
										</colgroup>
										<thead>
											<tr>
												<th><input type="checkbox" name="checkAll" value="" class="choice" onclick="fn_checkboxAll();"/></th>
												<th>기업명</th>
												<th>학년</th>
												<th>학번</th>
												<th>이름</th>
												<th>4대보험가입증명서</th>
												<th>원천징수영수증</th>
												<th>보완서류</th>
												<th>승인여부</th>
											</tr>
										</thead>
										<tbody>

										<c:forEach var="result" items="${resultList2}" varStatus="status" >
											<tr>
												<td>
												<!--
													<input type="checkbox" name="workProofIdArr" value="${result.workProofId}" class="choice" />
												 -->
													<input type="checkbox" name="memIdArr" value="${result.memId}" />
												</td>
												<td>${result.companyName}</td>
												<td>${result.year - result.grade +1}</td>
												<td>${result.memId}</td>
												<td>${result.memName}</td>
												<td>
												<c:if test="${result.file1Yn eq '1'}">
													제출
												</c:if>
												<c:if test="${result.file1Yn ne '1'}">
													마제출
												</c:if>
												</td>
												<td>
												<c:if test="${result.file2Yn eq '1'}">
													제출
												</c:if>
												<c:if test="${result.file2Yn ne '1'}">
													미제출
												</c:if>

												</td>
												<td>
												<c:if test="${result.file3Yn eq '1'}">
													제출
												</c:if>
												<c:if test="${result.file3Yn ne '1'}">
													미제출
												</c:if>

													</td>
												<td>
												<c:if test="${result.state eq '01'}">
													<a href="#!" class="btn-line-blue">승인</a>
												</c:if>
												<c:if test="${result.state eq '02'}">
													<a href="#!" class="btn-line-blue">반려</a>
												</c:if>
												<c:if test="${result.state eq null}">
													<a href="#!" class="btn-line-blue">미승인</a>
												</c:if>
												</td>
											</tr>
										</c:forEach>
											<tr>
												<td colspan="3">계</td>
												<td colspan="2">${resultTot.memberTot} 명</td>
												<td>${resultTot.insTot} 명</td>
												<td>${resultTot.recTot}명</td>
												<td>${resultTot.docTot} 명</td>
												<td>${resultTot.stateTot} 명</td>
											</tr>

										</tbody>
									</table>

									<div class="btn-area align-right mt-010">
										<a href="javascript:fn_newPopup();"  class="orange float-left">제출현황 출력</a>
										<a href="javascript:fn_fileDownload();" class="gray-1 float-left">제출서류 다운로드</a>
										<a href="javascript:alert('준비중입니다.');" class="yellow float-left">SMS 발송</a>
										<a href="javascript:alert('준비중입니다.')"" class="orange float-left">E-MAIL발송</a>
										<input type="text" name="returnReason" id="returnReason" value="" />
										<a href="javascript:fn_return();" class="orange">반려</a>
										<a href="javascript:fn_approve();" class="orange">승인</a>
									</div>

								</div><!-- E :  list-->

							</dd>
						</dl>

						<input type="hidden" id="state" name="state" />
						</form>


					</div><!-- E : content-area -->

<form name="frmPop" id="frmPop" method="post">
</form>

