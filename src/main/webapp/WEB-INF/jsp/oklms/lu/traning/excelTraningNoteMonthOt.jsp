<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<c:choose>

 <c:when test="${empty result}">
 <table  width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
								<colgroup>
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
								</colgroup>
								<tr>
									<td colspan="6">조회내용이 없습니다.</td>
								</tr>
								</tbody>
							</table>
 
 </c:when>
 
<c:otherwise>
						<table  width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
								<colgroup>
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
								</colgroup>
								<tr>
									<th>훈련과정명</th>
									<td style="text-align: center">${result.traningProcessName}</td>
									<th>교과목명</th>
									<td style="text-align: center">${result.subjectName}</td>
									
								</tr>
								
								<tr>
									<th>훈련기간</th>
									<td style="text-align: center">${result.monthStrDate}~${result.monthEndDate}</td>
									<th>현장교사명</th>
									<td style="text-align: center">${result.tutNames}</td>
									
								</tr>
								<tr>
									<th>훈련시간</th>
									<td style="text-align: center">${result.masTotStudyTime}</td>
									<th>능력단위명</th>
									<td style="text-align: center">${result.ncsUnitNames}</td>
									
								</tr>
								
								<tr>
									<th>지도교수명</th>
									<td style="text-align: center">${result.insNames}</td>
									<th>학습근로자명</th>
									<td style="text-align: center">${result.stdNames}</td>
									
								</tr>
								<tr>
									<th>훈련시간</th>
									<td>${result.masTotStudyTime}</td>
									<th>능력단위명</th>
									<td>${result.ncsUnitNames}</td>
								</tr>
								<tr>
									<th>월간학습근로자성취도</th>
									<td colspan="3" style="text-align: center">${result.avgAchievement}</td>
								</tr>
								
									
									
								
								</tbody>
							</table>
							
							
							<br/>

							<table  width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
								<colgroup>
											<col style="width:70px" />
											<col style="width:*" />
											<col style="width:80px" />
											<col style="width:120px" />
											<col style="width:120px" />
											<col style="width:120px" />
											<col style="width:180px" />
										</colgroup>
										<thead>
											<tr>
												<th>주차</th>
												<th>훈련일자</th>
												<th>시간</th>
												<th>총평</th>
												<th>지도교수승인여부</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<tr>
												<td style="text-align: center">${result.weekCnt}주차</td>
												<td style="text-align: center">${result.traningDate}</td>
												<td style="text-align: center">${result.detTotStudyTime}</td>
												<td style="text-align: center">${result.review}</td>
												<td style="text-align: center">${result.status eq '2' ? 'O' : 'X'}</td>
											</tr>
										</c:forEach>	
										</tbody>
									</table>
 </c:otherwise>
 </c:choose>									