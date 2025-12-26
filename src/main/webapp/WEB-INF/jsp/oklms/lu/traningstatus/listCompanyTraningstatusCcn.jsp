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

<c:set var="targetUrl" value="/lu/traningstatus/"/>
<script type="text/javascript">

$(document).ready(function() {
});

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
	
	var reqUrl = "/lu/traningstatus/excelTraningstatusPrt.do";
	$("#frmTraningstatus").attr("target", "_self");
	$("#frmTraningstatus").attr("action", reqUrl);
	$("#frmTraningstatus").submit();

}


</script>



<h2>온라인출석부관리</h2>
<form name="frmTraningstatus" id="frmTraningstatus" method="post">
<input type="hidden" name="yyyy" id="yyyy" >
<input type="hidden" name="term" id="term" >
<input type="hidden" name="subjectCode" id="subjectCode" >
<input type="hidden" name="subjectClass" id="subjectClass" >

					<div class="search-box-1 mb-020">
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
								<c:set var="subject" value="${result.yyyy}|${result.term}|${result.subjectCode}|${result.subjectClass}"/>
								<option value="${result.yyyy}|${result.term}|${result.subjectCode}|${result.subjectClass}" <c:if test="${subject eq param.subject }" > selected="selected"  </c:if>>${result.yyyy}학년도 ${result.termName} ${result.subjectName}(${result.subjectClass})</option>
							</c:forEach>	
							
						</select>

						<a href="#@" onclick="javascript:fn_search();">검색</a>
					</div><!-- E : search-box-1 -->
</form>

				<div class="table-responsive mt-040">
					<table class="type-2">
						<caption>번호 학번 이름 학과 학년 주차에 대한 정보 제공</caption>
						<colgroup>
							<col style="width:40px">
							<col style="width:90px">
							<col style="width:*">
							<col style="width:120px">
							<col style="width:40px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
							<col style="width:30px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" rowspan="2">번호</th>
								<th scope="col" rowspan="2">학번</th>
								<th scope="col" rowspan="2">이름</th>
								<th scope="col" rowspan="2">학과</th>
								<th scope="col" rowspan="2">학년</th>
								<th scope="col" colspan="15">주차</th>
							</tr>
							<tr>
								<c:choose>
									<c:when test="${currProcVO.term eq '3' or currProcVO.term eq '4'}">
										<c:choose>
											<c:when test="${currProcVO.onlineType eq '101'}">
													<th class="border-left">1</th>
													<th>2</th>
													<th>3</th>
													<th>4</th>
											</c:when>
											<c:otherwise>
												<th class="border-left">1</th>
												<th>2</th>
												<th>3</th>
												<th>4</th>
												<th>5</th>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<th scope="col" class="border-left">1</th>
										<th scope="col">2</th>
										<th scope="col">3</th>
										<th scope="col">4</th>
										<th scope="col">5</th>
										<th scope="col">6</th>
										<th scope="col">7</th>
										<th scope="col">8</th>
										<th scope="col">9</th>
										<th scope="col">10</th>
										<th scope="col">11</th>
										<th scope="col">12</th>
										<th scope="col">13</th>
										<th scope="col">14</th>
										<th scope="col">15</th>
									</c:otherwise>
								</c:choose>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="resultlist" items="${resultlist}" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${resultlist.memId }</td>
									<td class="left">${resultlist.memName }</td>
									<td>${resultlist.deptName }</td>
									<td>${resultlist.level}</td>
									
									<c:choose>
										<c:when test="${currProcVO.term eq '3' or currProcVO.term eq '4'}">
											<c:choose>
												<c:when test="${currProcVO.onlineType eq '101'}">
													<td>
														<c:if test="${resultlist.nextWeek>=1 }">
														<c:if test="${resultlist.te1 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te1 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te1 eq '2'}" >△</c:if>
														</c:if>
													</td>
													<td>
														<c:if test="${resultlist.nextWeek>=2 }">
														<c:if test="${resultlist.te2 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te2 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te2 eq '2'}" >△</c:if>
														</c:if>
													</td>
													<td>
														<c:if test="${resultlist.nextWeek>=3 }">
														<c:if test="${resultlist.te3 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te3 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te3 eq '2'}" >△</c:if>
														</c:if>
													</td>
													<td>
														<c:if test="${resultlist.nextWeek>=4 }">
														<c:if test="${resultlist.te4 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te4 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te4 eq '2'}" >△</c:if>
														</c:if>
													</td>
												</c:when>
												<c:otherwise>
													<td>
														<c:if test="${resultlist.nextWeek>=1 }">
														<c:if test="${resultlist.te1 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te1 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te1 eq '2'}" >△</c:if>
														</c:if>
													</td>
													<td>
														<c:if test="${resultlist.nextWeek>=2 }">
														<c:if test="${resultlist.te2 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te2 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te2 eq '2'}" >△</c:if>
														</c:if>
													</td>
													<td>
														<c:if test="${resultlist.nextWeek>=3 }">
														<c:if test="${resultlist.te3 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te3 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te3 eq '2'}" >△</c:if>
														</c:if>
													</td>
													<td>
														<c:if test="${resultlist.nextWeek>=4 }">
														<c:if test="${resultlist.te4 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te4 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te4 eq '2'}" >△</c:if>
														</c:if>
													</td>
													<td>
														<c:if test="${resultlist.nextWeek>=5 }">
														<c:if test="${resultlist.te5 eq '0'}" >X</c:if>
														<c:if test="${resultlist.te5 eq '1'}" >O</c:if> 
														<c:if test="${resultlist.te5 eq '2'}" >△</c:if>
														</c:if>
													</td>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<td>
												<c:if test="${resultlist.nextWeek>=1 }">
												<c:if test="${resultlist.te1 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te1 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te1 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=2 }">
												<c:if test="${resultlist.te2 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te2 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te2 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=3 }">
												<c:if test="${resultlist.te3 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te3 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te3 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=4 }">
												<c:if test="${resultlist.te4 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te4 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te4 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=5 }">
												<c:if test="${resultlist.te5 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te5 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te5 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=6 }">
												<c:if test="${resultlist.te6 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te6 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te6 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=7 }">
												<c:if test="${resultlist.te7 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te7 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te7 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=8 }">
												<c:if test="${resultlist.te8 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te8 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te8 eq '2'}" >△</c:if> 
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=9 }">
												<c:if test="${resultlist.te9 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te9 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te9 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=10 }">
												<c:if test="${resultlist.te10 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te10 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te10 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=11 }">
												<c:if test="${resultlist.te11 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te11 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te11 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=12 }">
												<c:if test="${resultlist.te12 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te12 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te12 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=13 }">
												<c:if test="${resultlist.te13 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te13 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te13 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=14 }">
												<c:if test="${resultlist.te14 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te14 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te14 eq '2'}" >△</c:if>
												</c:if>
											</td>
											<td>
												<c:if test="${resultlist.nextWeek>=15 }">
												<c:if test="${resultlist.te15 eq '0'}" >X</c:if>
												<c:if test="${resultlist.te15 eq '1'}" >O</c:if> 
												<c:if test="${resultlist.te15 eq '2'}" >△</c:if> 
												</c:if>
											</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
							<c:if test="${empty resultlist}">
								<tr><td colspan="20">조회 된 데이터가 없습니다.</td></tr>
							</c:if>
						</tbody>
					</table>
				</div>
				
				<div class="btn-area mt-010 not_print">
					<div class="float-right">
						<!-- <a href="#" onclick="javascript:window.print();" class="orange">프린트</a> -->
						<a href="#" onclick="javascript:fn_excel();" class="yellow">엑셀 다운로드</a>
					</div>
				</div>


