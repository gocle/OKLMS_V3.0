<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


						<table  width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
								<colgroup>
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
								</colgroup>
						<c:set var="subjectTraningType" value=""/>
						<c:forEach var="result" items="${resultList}" varStatus="status">
						
						<c:if test="${status.count eq '1'}">
							<c:set var="subjectTraningType" value="${result.subjectTraningType}"/>
							<c:choose>
								<c:when test="${subjectTraningType eq 'OJT'}">
									<tr>
										<th>학습근로자명</th>
										<td style="text-align: center">${result.stdName}</td>
										<th>훈련과정명</th>
										<td style="text-align: center">${result.traningProcessName}</td>
									</tr>
									<tr>
										<th>훈련기간(월)</th>
										<td style="text-align: center">${result.monthStrDate}~${result.monthEndDate}</td>
										<th>교과목명</th>
										<td style="text-align: center">${result.subjectName}</td>
									</tr>
									<tr>
										<th>지도교수명</th>
										<td style="text-align: center">${result.insNames}</td>
										<th>기업현장교사명</th>
										<td style="text-align: center">${result.tutNames}</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<th>학습근로자명</th>
										<td style="text-align: center">${result.stdName}</td>
										<th>훈련기간(월)</th>
										<td style="text-align: center">${result.monthStrDate}~${result.monthEndDate}</td>
									</tr>
									<tr>
										<th>교과목명</th>
										<td style="text-align: center">${result.subjectName}</td>
										<th>지도교수명</th>
										<td style="text-align: center">${result.insNames}</td>
									</tr>
								</c:otherwise>
							</c:choose>
								
							</c:if>		
						</c:forEach>
								</tbody>
							</table>
							
							
							<br/>

							<table  width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
								<colgroup>
											<col style="width:70px" />
											<col style="width:80px" />
											<col style="width:*" />
											<c:if test="${subjectTraningType eq 'OJT'}">
											<col style="width:120px" />
											</c:if>
										</colgroup>
										<thead>
											<tr>
												<th>주차</th>
												<th>훈련일자</th>
												<th>내용</th>
												<c:if test="${subjectTraningType eq 'OJT'}">
												<th>지도교수승인여부</th>
												</c:if>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<tr>
												<td style="text-align: center">${result.weekCnt}주차</td>
												<td style="text-align: center">${result.traningDate}</td>
												<td style="text-align: center">${result.content}</td>
												<c:if test="${subjectTraningType eq 'OJT'}">
												<td style="text-align: center">${result.status eq '2' ? 'O' : 'X'}</td>
												</c:if>
											</tr>
										</c:forEach>	
										</tbody>
									</table>
								