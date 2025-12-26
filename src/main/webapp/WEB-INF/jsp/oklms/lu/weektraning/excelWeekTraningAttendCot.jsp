<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

 
						<table   width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
							<colgroup>
								<col style="width:10%" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
							</colgroup>
							<thead>
								<tr>
									<th>기업명</th>
									<th>훈련과정명</th>
									<th>훈련시작일</th>
									<th>훈련종료일</th>
									<th>교과목명</th>
									<th>능력단위명</th>
									<th>훈련일자</th>
									<th>훈련 시작시간</th>
									<th>훈련 종료시간</th>
									<th>기업현장교사명</th>
									<th>학습근로자명</th>
									<th>훈련계획시간</th>
									<th>실제훈련시간</th>
									<th>비고</th>
									<th>총평</th>
								</tr>
							</thead>
							<tbody  id="tableList">
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td>${result.companyName}</td>
										<td>${result.traningProcessName}</td>
										<td>${result.startDate}</td>
										<td>${result.endDate}</td>
										<td>${result.subjectName}</td>
										<td>${result.ncsUnitName}</td>
										<td>${result.traningDate}</td>
										<td>${result.traningStHour}</td>
										<td>${result.traningEdHour}</td>
										<td>${result.tutName}</td>
										<td>${result.memName}</td>
										<td>${result.studyTimePlan}</td>
										<td>${result.studyTime}</td>
										<td>${result.bigo}</td>
										<td>${result.review}</td>						
									</tr>
							</c:forEach>
							</tbody>
						</table>