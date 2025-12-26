<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
 
 						<h2>훈련일지</h2> 
<script type="text/javascript">
<!--

function fn_search(classId,companyId){
	
	$("#classId").val(classId);
	$("#companyId").val(companyId);
	
	var reqUrl = "/lu/traning/listTraningNoteStd.do";
 
	$("#frmTraning").attr("target", "_self");
	$("#frmTraning").attr("action", reqUrl);
	$("#frmTraning").submit();

}
//--> 
</script> 
  
<form name="frmTraning" id="frmTraning" method="post">
				<input type="hidden" id="classId" name="classId" value="${TraningNoteVO.classId}" />
				<input type="hidden" id="companyId" name="companyId" value="${TraningNoteVO.companyId}" />
						
							<h4 class="mb-010"><span>${TraningNoteVO.subjectName} / ${TraningNoteVO.subjectCode }</span> (${TraningNoteVO.classId }분반_${SESSION_COMPANY_NAME})ㅣ ${TraningNoteVO.yyyy}학년도 ${TraningNoteVO.termName} </h4>
							
							<div class="training-info">
								 <div class="txt-box">
									<dl>
										<dt><label for="weekCnt">주차</label></dt>
										<dd>
											<select id="weekCnt" name="weekCnt" onchange="javascript:fn_search();">
												<c:forEach var="result" items="${weeklist}" varStatus="status">
												<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq TraningNoteVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
												</c:forEach>
											</select>	
										</dd>
									</dl>
									
									<dl>
										<dt>기간</dt>
										<dd>${TraningNoteVO.traningStDate} ~ ${TraningNoteVO.traningEndDate}</dd>
									</dl>
									
									
									
									
									<c:if test="${TraningNoteVO.subjectTraningType eq 'OJT'}">
									<dl>
										<dt>능력단위</dt>
										<dd>${TraningNoteVO.ncsUnitName}</dd>
									</dl>
									</c:if>
									<dl>
										<dt>주간 훈련시간</dt>
										<dd>${TraningNoteVO.timeHour}</dd>
									</dl>
									<c:if test="${TraningNoteVO.subjectTraningType eq 'OJT'}">
									<dl class="class-cont">
										<dt>능력단위요소</dt>
										<dd>${TraningNoteVO.ncsElemName}</dd>
									</dl>
									</c:if>
									<dl class="class-cont">
										<dt>수업내용</dt>
										<dd>${TraningNoteVO.lessonCn}</dd>
									</dl>
								</div>
							</div>
							
							<%-- 
							<table class="type-1-1 mb-040">
								<colgroup>
								<col style="width:70px" />
								<col style="width:170px" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:70px" />
								</colgroup>
								<thead>
									<tr>
										<th>주차</th>
										<th>기간</th>
										<th>능력단위</th>
										<th>능력단위요소</th>
										<th>수업내용</th>
										<th>주간<br />훈련시간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<select id="weekCnt" name="weekCnt" onchange="javascript:fn_search();">
												<c:forEach var="result" items="${weeklist}" varStatus="status">
												<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq TraningNoteVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
												</c:forEach>
											</select>
										</td>
										<td>${TraningNoteVO.traningStDate} ~ ${TraningNoteVO.traningEndDate}</td>
										<td>${TraningNoteVO.ncsUnitName}</td>
										<td>${TraningNoteVO.ncsElemName}</td>
										<td class="left">${TraningNoteVO.lessonCn}</td>
										<td>${TraningNoteVO.timeHour}</td>

									</tr>
								</tbody>
							</table>
							 --%>

</form>

							<div class="learner-training">
<c:forEach var="timeList" items="${timeList}" varStatus="status">
 
						<c:if test="${!empty resultSum[status.index].weekId}" >
						<form name="frmTraning${status.index}" id="frmTraning${status.index}" method="post">
							<input type="hidden" id="achievement" name="achievement" />
							<input type="hidden" id="studyDate" name="studyDate" value="${resultSum[status.index].traningDate }"/>
							<input type="hidden" id="startTime" name="startTime" value="${resultSum[status.index].traningDate }"/>
							<input type="hidden" id="finishTime" name="finishTime" value="${resultSum[status.index].traningDate }" />
							<input type="hidden" id="traningStHour" name="traningsthour" value="${resultSum[status.index].traningStHour }"/>
							<input type="hidden" id="traningStMin" name="TraningStMin" value="${resultSum[status.index].traningStMin }"/>
							<input type="hidden" id="traningEdHour" name="traningEdHour" value="${resultSum[status.index].traningEdHour }"/>
							<input type="hidden" id="traningEdMin" name="traningEdMin" value="${resultSum[status.index].traningEdMin }"/>
							<input type="hidden" id="planTime" name="planTime" value="${resultSum[status.index].timeHour}" />
							<input type="hidden" id="weekId" name="weekId" value="${resultSum[status.index].weekId}"/>
							<input type="hidden" id="timeId" name="timeId" value="${resultSum[status.index].timeId}"/>
							<input type="hidden" id="weekCntId${status.index}" name="weekCnt" value="${TraningNoteVO.weekCnt}"/>
							<input type="hidden"   name="addyn" value="N"/>
							
							<div class="sub_text blue_text mt-040">
 								 <i class="xi-label"></i> 정규수업 : ${resultSum[status.index].traningDate}(${resultSum[status.index].dayOfWeek}) ${resultSum[status.index].traningSt}~${resultSum[status.index].traningEd} (${resultSum[status.index].timeHour}시간)  ${result.traniningNoteMasterId } 
 							</div>	
							<div class="table-responsive mt-010">
								<table class="type-2">
									<caption>성명 훈련시간 성취도 등 정보제공</caption>
									<colgroup>
											<col width="15%" />
											<col width="15%" />
											<col width="20%" />
											<%-- <col width="*" /> --%>
									</colgroup>
									<thead>
										<tr>
											<th scope="col">성명</th>
											<th scope="col">훈련시간</th>
											<th scope="col">성취도</th>

											<!-- <th>비고 (교육 중 특이사항 등)</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach var="resultlist" items="${resultlistSum[status.index]}" varStatus="statuslist">
										<tr>
											<td>${resultlist.memName}</td>
											<td>${resultlist.studyTime}</td>									 
											<td>											
											<c:forEach var="i" begin="1" end="${resultlist.achievement}" step="1">
										      <img src="/images/oklms/std/inc/icon_star_on.png" />
										    </c:forEach>
											</td>																															
											<%-- <td class="left">${resultlist.bigo}</td> --%>
										</tr>
										</c:forEach>
										<tr>
											<th scope="row">총평</th>
											<td colspan="4" class="left">${resultSum[status.index].review}</td>
										</tr>
									</tbody>
								</table>									 
							</div><!-- E : 정규수업 -->
							</form>
							
							</c:if>
</c:forEach>							
<c:forEach var="TraningEnrichmentTimeVO" items="${TraningEnrichmentTimeVO}" varStatus="status">
							<div class="sub_text blue_text mt-040">
 								 <i class="xi-label"></i> 보강훈련 : ${TraningEnrichmentTimeVO.traningDate} 
									 ${TraningEnrichmentTimeVO.traningStHour}:${TraningEnrichmentTimeVO.traningStMin} ~ 
									 ${TraningEnrichmentTimeVO.traningEdHour}:${TraningEnrichmentTimeVO.traningStMin}
 							</div>	
							<div class="table-responsive mt-010">
									<table class="type-2">
										<colgroup>
											<col width="15%" />
											<col width="15%" />
											<col width="20%" />
											<col width="*" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">성명</th>
												<th scope="col">훈련시간 (결과)</th>
												<th scope="col">성취도</th>
												<th scope="col">비고 (교육 중 특이사항 등)</th>
											</tr>
										</thead>
										<tbody>

											<c:forEach var="resultlist" items="${TraningNoteList2}" varStatus="status">
											<tr id="tr${status.index}">
												<td>${resultlist.memName} <input type="hidden" name="memNmArr" id="memNmArr" value="${resultlist.memName}">  </td>
												<td>${resultlist.studyTime}</td>
												<td>
												<c:forEach var="i" begin="1" end="${resultlist.achievement}" step="1">
											      <img src="/images/oklms/std/inc/icon_star_on.png" />
											    </c:forEach>												
												</td>	
												<td class="left">${resultlist.bigo}</td>
											</tr>
											</c:forEach>
											
											 
											<tr>
												<th scope="row">보강총평</th>
												<td colspan="4" class="left"> ${TraningEnrichmentTimeVO.review} </td>
											</tr>
										</tbody>
									</table>
								</div>
 							    <!-- E : 보강수업 -->
</c:forEach>
							</div>		 
