<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <c:set var="memSeqs" value="" />
						<h2>학습활동서 조회</h2>

						<table class="type-1-1">
							<caption>구분 기업명 훈련과정명 학년도 학기 주차에 대한 정보 제공</caption>
							<colgroup>
								<col style="width:120px" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:120px" />
								<col style="width:100px" />
								<col style="width:100px" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구분</th>
									<th scope="col">기업명</th>
									<th scope="col">훈련과정명</th>
									<th scope="col">학년도</th>
									<th scope="col">학기</th>
									<th scope="col">주차</th>
								</tr>
							</thead>
							<tbody>
								<tr>
								 
									<td>${activityVO.traningType }</td>
									<td>${result.companyName }</td>
									<td>${result.hrdTraningName }</td>
									<td>${activityVO.yyyy }</td>
									<td>${activityVO.termName }</td>
									<td>${activityVO.weekCnt }</td>
					 
								</tr>
							</tbody>
						</table>



						<div class="table-responsive mt-020">
							<table class="type-2">
								<caption>성명 주민등록번호 개설강좌명 능력단위요소 주간훈련시간 실제훈련시간 성취도 보강결과 보강성취도 조회에 대한 정보 제공</caption>
								<colgroup>
									<col style="width:6%" />
									<col style="width:8%" />
									<col style="width:10%" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:12%" />
									<col style="width:12%" />
									<col style="width:12%" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:8%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">성명</th>
										<th scope="col">주민등록번호</th>
										<th scope="col">개설강좌명</th>
										<th scope="col">능력단위요소</th>
										<th scope="col">주간 훈련시간</th>
										<th scope="col">실제 훈련시간</th>
										<th scope="col">성취도</th>
										<th scope="col">보강결과</th>
										<th scope="col">보강 성취도</th>
										<th scope="col">조회</th>
									</tr>
								</thead>
								<tbody>
	 <c:set var="tempId" value="xxx" />
								<c:forEach var="result" items="${resultlist}" varStatus="status">
								<c:set var="newtempId" value="${result.memSeq}" />
									<tr> 
			<c:if test="${tempId ne newtempId }" >
										<td rowspan="${result.tableCnt }">${tableCount}</td>									
										<td rowspan="${result.tableCnt }">${result.memName}</td>
										<td rowspan="${result.tableCnt }"></td>
			</c:if>
			
										<td  <c:if test="${tempId eq newtempId }" > class="border-left" </c:if>>${result.subjectName}</td>
										<td>${result.ncsUnitName} ${result.ncsElemName}</td>
										<td>${result.weekTimeHour}시간  </td>
										<td>
											<c:if test="${!empty result.weekWorkTimeHour }">
											${result.weekWorkTimeHour}시간
											</c:if>
										</td>
										<td>
											<c:if test="${!empty result.weekWorkAchievement }">
											${result.weekWorkAchievement}
											</c:if>
										</td>
										<td>
											<c:if test="${!empty result.weekAddTimeHour }">
											${result.weekAddTimeHour}
											</c:if>
										</td>
										<td>
											<c:if test="${!empty result.weekAddAchievement }">
											${result.weekAddAchievement}
											</c:if>
										</td>
			
			<c:if test="${tempId ne newtempId }" >
										<td rowspan="${result.tableCnt }">									
											<c:if test="${empty result.activityNoteId }">
											<a href="#!" class="btn-line-gray">미제출</a>
											</c:if>
											<c:if  test="${!empty result.activityNoteId }">
											<a href="#!" onclick="javascript:fn_detail('${result.memSeq}');" class="btn-line-blue">조회</a>
											</c:if>										
										</td>
			</c:if>
								
									<c:set var="tempId" value="${result.memSeq}" />
									</tr>
															
								</c:forEach> 
								</tbody>
							</table>
						</div>
				 
<script type="text/javascript">
<!-- 
 
function fn_search(){ 
	var reqUrl = "/lu/activity/listActivityHrd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
}; 
function fn_detail(memSeq){
	$("#memSeq").val(memSeq );
	var reqUrl = "/lu/activity/getActivityHrd.do";
	$("#frmActivity").attr("action", reqUrl);
	$("#frmActivity").attr("target","_self");
	$("#frmActivity").submit();	 
};
//-->
</script>
<form:form modelAttribute="frmActivity" name="frmActivity" method="post"  >
		<input type="hidden" name="companyId" id="companyId" value="${activityVO.companyId }"  />
		<input type="hidden" name="traningProcessId" id="traningProcessId"  value="${activityVO.traningProcessId }" />
		<input type="hidden" name="weekCnt" id="weekCnt"  value="${activityVO.weekCnt}"  />
		<input type="hidden" name="traningType" id="traningType"  value="${activityVO.traningType}"  />
		<input type="hidden" name="yyyy" id="yyyy"   value="${activityVO.yyyy}"  />
		<input type="hidden" name="term" id="term" value="${activityVO.term}" />
		<input type="hidden" name="memSeq" id="memSeq"  />
		<input type="hidden" name="memSeqs" id="memSeqs" value="${memSeqs}"  />
		<input type="hidden" name="baseCheckCompanyIds" id="baseCheckCompanyIds" value="${param.baseCheckCompanyIds }"  />	
</form:form>
						<div class="btn-area mt-010"> 
							<div class="float-right">
								<a href="#!" onclick="javascript:fn_search();" class="gray-1 ">이전화면</a>
							</div>
						</div><!-- E : btn-area -->
				 