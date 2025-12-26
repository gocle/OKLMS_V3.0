<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>

<script type="text/javascript">


$(document).ready(function() {
	com.datepickerDateFormat('startDate', 'button');
	com.datepickerDateFormat('endDate', 'button');

});

WebFont.load({
	custom: {
		families: ['nbgM', 'nsM', 'play']
	}
});


function fn_listWeekTraningNote(){

	//alert("검색 ");
	var reqUrl = "/lu/weektraning/listWeekTraningNote.do";
	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").submit();
}


function fn_listTraningNote(subjectCode, subjectTraningType){
	$("#subjectCode").val(subjectCode);
	$("#subjectTraningType").val(subjectTraningType);
	var reqUrl = "/lu/traning/listTraningNote.do";


	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").submit();
}


function fn_company(){

	popOpenWindow("", "popSearch", 850, 560);
//	var reqUrl = "/lu/popup/goPopupSearchCompanyMappingMemberInfo.do";
	var reqUrl = "/lu/weektraning/popupWeekTraningNote.do";
	$("#frmWeekTraning").attr("target", "popSearch");
	$("#frmWeekTraning").attr("action", reqUrl);
	$("#frmWeekTraning").submit();

}

function fn_setWeekTraningCompanyInfo(obj){

	var objArr = obj.split("/");


	$("#subjectCode").val(objArr[0]);
	$("#companyName").val(objArr[1]);
	$("#address").val(objArr[2]);
	$("#traningStDate").val(objArr[3])
	$("#hrdTraningName").val(objArr[4]);

	$("#subjectCodeText").text(objArr[0]);
	$("#companyNameText").text(objArr[1]);
	$("#addressText").text(objArr[2]);
	$("#traningStDateText").text(objArr[3])
	$("#hrdTraningNameText").text(objArr[4]);


}

</script>
<form name="frmWeekTraning" id="frmWeekTraning" method="post">


					<div id="content-area">
						<h2>주간훈련일지</h2>
						<input type="hidden" id ="subjectCode" name="subjectCode"  value="${seachVO.subjectCode}"/>
						<input type="hidden" id="subjectTraningType" name="subjectTraningType" />
						<input type="hidden" id="companyName" name="companyName"  value="${seachVO.companyName }"/>
						<input type="hidden" id="address" name="address" value="${seachVO.address }" />
						<input type="hidden" id="traningStDate" name="traningStDate" value="${seachVO.traningStDate }" />
						<input type="hidden" id="hrdTraningName" name="hrdTraningName" value="${seachVO.hrdTraningName }" />

 						<!-- 센터 담당자일 경우에만  -->
						<c:if test="${seachVO.sessionMemType eq  'CCN'}">
						<div class="group-area">
							<table class="type-2">
								<colgroup>
									<col style="width:250px" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:*" />
								</colgroup>
								<tr>

									<th>기업명</th>
									<th>소재지</th>
									<th>선정일</th>
									<th>훈련과정명</th>
								</tr>
								<tr>
									<td id="companyNameText">${seachVO.companyName} &nbsp;</td>
									<td id="addressText">${seachVO.address }</td>
									<td id="traningStDateText">${seachVO.traningStDate }</td>
									<td id="hrdTraningNameText">${seachVO.hrdTraningName }</td>
								</tr>
							</table>
							<div class="btn-area align-right mt-010">
								<a href="javascript:fn_company();" class="yellow">기업체검색</a>
							</div><!-- E : btn-area -->
						</div>
						</c:if>

						<div class="search-box-1 mt-020 ">

							<select name="yyyy">
								<option>학년도 선택</option>
								<option value="2015" <c:if test="${seachVO.yyyy eq '2015' }" > selected="selected" </c:if>>2015학년도</option>
								<option value="2016" <c:if test="${seachVO.yyyy eq '2016' }" > selected="selected" </c:if>>2016학년도</option>
								<option value="2017" <c:if test="${seachVO.yyyy eq '2017' }" > selected="selected" </c:if>>2017학년도</option>
							</select>
							<select name="term">
								<option>학기 선택</option>
								<option value="1" <c:if test="${seachVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
								<option value="2" <c:if test="${seachVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
								<option value="3" <c:if test="${seachVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
								<option value="4" <c:if test="${seachVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
							</select>
							<select name="weekCnt">
									<option value="">선택</option>
									<option value="1" <c:if test="${seachVO.weekCnt eq '1' }" > selected="selected"  </c:if>  >1 주차</option>
									<option value="2" <c:if test="${seachVO.weekCnt eq '2' }" > selected="selected"  </c:if>  >2 주차</option>
									<option value="3" <c:if test="${seachVO.weekCnt eq '3' }" > selected="selected"  </c:if>  >3 주차</option>
									<option value="4" <c:if test="${seachVO.weekCnt eq '4' }" > selected="selected"  </c:if>  >4 주차</option>
									<option value="5" <c:if test="${seachVO.weekCnt eq '5' }" > selected="selected"  </c:if>  >5 주차</option>
									<option value="6" <c:if test="${seachVO.weekCnt eq '6' }" > selected="selected"  </c:if>  >6 주차</option>
									<option value="7" <c:if test="${seachVO.weekCnt eq '7' }" > selected="selected"  </c:if>  >7 주차</option>
									<option value="8" <c:if test="${seachVO.weekCnt eq '8' }" > selected="selected"  </c:if>  >8 주차</option>
									<option value="9" <c:if test="${seachVO.weekCnt eq '9' }" > selected="selected"  </c:if>  >9 주차</option>
									<option value="10" <c:if test="${seachVO.weekCnt eq '10' }" > selected="selected"  </c:if>  >10 주차</option>
									<option value="11" <c:if test="${seachVO.weekCnt eq '11' }" > selected="selected"  </c:if>  >11 주차</option>
									<option value="12" <c:if test="${seachVO.weekCnt eq '12' }" > selected="selected"  </c:if>  >12 주차</option>
									<option value="13" <c:if test="${seachVO.weekCnt eq '13' }" > selected="selected"  </c:if>  >13 주차</option>
									<option value="14" <c:if test="${seachVO.weekCnt eq '14' }" > selected="selected"  </c:if>  >14 주차</option>
									<option value="15" <c:if test="${seachVO.weekCnt eq '15' }" > selected="selected"  </c:if>  >15 주차</option>
							</select>

							<a href="javascript:fn_listWeekTraningNote();">조회</a>
						</div><!-- E : search-box-1 -->

						<c:if test="${seachVO.sessionMemType ne 'CCN'}">

						<table class="type-2 mt-010">
							<colgroup>
							<!--
								<col style="width:50px" />
							 -->
							 	<col style="width:80px" />
								<col style="width:80px" />
								<col style="width:80px" />
								<col style="width:50px" />
								<col style="width:50px" />
								<col style="width:*" />
								<col style="width:80px" />
							</colgroup>

							<thead>
								<tr>
								<!--
									<th><input type="checkbox" name="" value="" class="choice" /></th>
								 -->
									<th>훈련구분</th>
									<th>교과구분</th>
									<th>학년도</th>
									<th>학기</th>
									<th>주차</th>
									<th>개설교과</th>
									<th class="none">훈련일지</th>
								</tr>
							</thead>
								<tbody>

								 <c:forEach var="result" items="${weekTraningList}" varStatus="status" >
								<tr>

								 	<td>
								 	<c:if test="${result.type eq '01'}">
								 		정규훈련
								 	</c:if>
								 	<c:if test="${result.type eq '02'}">
								 		보강훈련
								 	</c:if>
								 	</td>
									<td>${result.subjectTraningTypeName}</td>
									<td>${result.yyyy}</td>
									<td>${result.term}</td>
									<td>${result.weekCnt}</td>
									<td class="left"><a href="#" class="text" onclick="fn_listTraningNote('${result.subjectCode}','${result.subjectTraningType}');">${result.subjectName} ${result.traningProcessId } </a></td>
									<td>
									<c:if test="${result.cnt > 1}">
										<a href="#" class="btn-line-gray">등록</a>
									</c:if>
									<c:if test="${result.cnt < 1}">
										<a href="#" class="btn-line-orange">미작성</a>
									</c:if>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="btn-area align-right mt-020">

							<a href="#!" class="orange">출력</a>

								<c:if test="${seachVO.sessionMemType eq  'CCN'}">
									<a href="#!" class="orange">제출</a>
								</c:if>
						</div><!-- E : btn-area -->
					</c:if>
					<c:if test="${seachVO.sessionMemType eq 'CCM'}">
						<table class="type-2 mt-010">
							<colgroup>

								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
							</colgroup>
							<thead>
								<tr>

									<th rowspan="2">주차</th>
									<th rowspan="2">학습기간</th>
									<th colspan="2">제출현황 (정규훈련)</th>
									<th colspan="2">제출현황(보강훈련)</th>
								</tr>
								<tr>
									<th class="border-left">OJT</th>
									<th>Off-JT</th>
									<th class="border-left">OJT</th>
									<th>Off-JT</th>
								</tr>
							</thead>
								<tbody>

								<c:forEach var="result" items="${weekTraningSubmitList}" varStatus="status" >
								<tr>
									<td>${result.weekCnt}</td>
									<td>${result.traningStDate} ~ ${result.traningEndDate}</td>
									<td>
										<c:if test="${result.rojtSubmitYn eq 'Y' }" >
										<a href="#!" class="btn-line-blue">제출</a>
										</c:if>
										<c:if test="${result.rojtSubmitYn eq 'N' }" >
										<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
									<td>
										<c:if test="${result.roffSubmitYn eq 'Y' }" >
										<a href="#!" class="btn-line-blue">제출</a>
										</c:if>
										<c:if test="${result.roffSubmitYn eq 'N' }" >
										<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
									<td>
										<c:if test="${result.eotjSubmitYn eq 'Y' }" >
										<a href="#!" class="btn-line-blue">제출</a>
										</c:if>
										<c:if test="${result.eotjSubmitYn eq 'N' }" >
										<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
									<td>
										<c:if test="${result.eoffSubmitYn eq 'Y' }" >
										<a href="#!" class="btn-line-blue">제출</a>
										</c:if>
										<c:if test="${result.eoffSubmitYn eq 'N' }" >
										<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						</c:if>

					<c:if test="${seachVO.sessionMemType eq  'CCN'}">
						<table class="type-2 mt-010">
							<colgroup>
								<col style="width:50px" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">선택</th>
									<th rowspan="2">주차</th>
									<th rowspan="2">학습기간</th>
									<th colspan="2">제출현황 (정규훈련)</th>
									<th colspan="2">제출현황(보강훈련)</th>
								</tr>
								<tr>
									<th class="border-left">OJT</th>
									<th>Off-JT</th>
									<th class="border-left">OJT</th>
									<th>Off-JT</th>
								</tr>
							</thead>
							<tbody>


								<c:forEach var="result" items="${weekTraningSubmitList}" varStatus="status" >
								<tr>
									<td><input type="radio" name="radio1" value="" class="choice" checked /></td>
									<td>${result.weekCnt}</td>
									<td>${result.traningStDate}~ ${result.traningEndDate}</td>
									<td>
										<c:if test="${result.rojtSubmitYn eq 'Y' }" >
											<a href="#!" class="btn-line-blue">조회</a>
										</c:if>
										<c:if test="${result.rojtSubmitYn eq 'N' }" >
											<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
									<td>
										<c:if test="${result.roffSubmitYn eq 'Y' }" >
											<a href="#!" class="btn-line-blue">조회</a>
										</c:if>
										<c:if test="${result.roffSubmitYn eq 'N' }" >
											<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
									<td>
										<c:if test="${result.eotjSubmitYn eq 'Y' }" >
											<a href="#!" class="btn-line-blue">조회</a>
										</c:if>
										<c:if test="${result.eotjSubmitYn eq 'N' }" >
											<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
									<td>
										<c:if test="${result.eoffSubmitYn eq 'Y' }" >
											<a href="#!" class="btn-line-blue">조회</a>
										</c:if>
										<c:if test="${result.eoffSubmitYn eq 'N' }" >
											<a href="#!" class="btn-line-orange">미제출</a>
										</c:if>
									</td>
								</tr>
								</c:forEach>
									<tr>
										<td colspan="7"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>

							</tbody>
						</table>
						<div class="btn-area align-right mt-010">
						<c:if test="${seachVO.sessionMemType eq  'CCN'}">
							<p><input type="checkbox" name="" value="" class="choice" /> 기업현장교사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" value="" class="choice" /> HRD담당자</p>
							<a href="#!" class=black>엑셀저장</a>	<a href="#!" class="black">출력</a>
						</c:if>
						<c:if test="${seachVO.sessionMemType eq  'CCM'}">

							<a href="#!" class="yellow">SMS 발송</a><a href="#!" class="orange">E-MAIL 발송</a>
						</c:if>
						</div>


					</div><!-- E : content-area -->

</form>

