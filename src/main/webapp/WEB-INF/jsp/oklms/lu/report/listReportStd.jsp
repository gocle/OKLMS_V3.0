<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
 
					 
						<h2>과제</h2>
						<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>

						<table class="type-1 mb-040">
								<caption>교과형태 과정구분 학점 교수 온라인 교육형태 선수여부에 대한 정보를 제공합니다</caption>
								<colgroup>
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
									<col style="width:15%" />
									<col style="width:*px" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">교과형태</th>
									<td>${currProcVO.subjectTraningTypeName}</td>
										<th scope="row">과정구분</th>
									<td>${currProcVO.subjectTypeName}</td>
										<th scope="row">학점</th>
										<td>${currProcVO.point }학점</td>
									</tr>
									<tr>
										<th scope="row">교수</th>
										<td>${currProcVO.insNames}</td>
										<th scope="row">온라인 교육형태</th>
										<td>${currProcVO.onlineTypeName} (성적비율 ${currProcVO.gradeRatio}%)</td>
										<th scope="row">선수여부</th>
										<td>${currProcVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}</td>
									</tr>
								</tbody>
							</table>
 


						<h2>과제 목록</h2>
						<div class="group-area">
							<table class="type-2">
								<caption>주차 제목 제출기간 제출현황 채점현황에 대한 정보를 제공합니다</caption>
								<colgroup>
									<col style="width:7%" />
									<col style="width:*" />
									<col style="width:20%" />
									<col style="width:10%" />
									<col style="width:10%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">주차</th>
										<th scope="col">제목</th>
										<th scope="col">제출기간</th>
										<th scope="col">제출현황</th>
										<th scope="col">상태</th>
									</tr>
 						
									<c:forEach var="result" items="${result}" varStatus="status">
									<tr>
										<td>${result.weekCnt}</td>
										<td class="left"><a href="/lu/report/getReportStd.do?reportId=${result.reportId}" class="text">${result.reportName}</a></td>
										<td>${result.submitStartDate} ${result.submitStartHour}:${result.submitStartMin} ~ ${result.submitEndDate} ${result.submitEndHour}:${result.submitEndMin}</td>
										<td>
										<c:if test="${result.checkYn eq 'Y'}" >
											<a href="#!" class="btn-full-gray" >제출</a>
										</c:if>
										<c:if test="${result.checkYn ne 'Y'}" >
											<a href="/lu/report/getReportStd.do?reportId=${result.reportId}"  class="btn-full-blue">미제출</a>
										</c:if>																		
										</td>
										<td>
										<c:if test="${result.submitStatus eq '완료'}">
											<span class="btn-line-gray">${result.submitStatus}</span>										
										</c:if>
										<c:if test="${result.submitStatus eq '진행'}">
											<span class="btn-line-blue">${result.submitStatus}</span>										
										</c:if>
										<c:if test="${result.submitStatus eq '예정'}">
											<span class="btn-line-blue">${result.submitStatus}</span>										
										</c:if>										
										</td>
									</tr>
									</c:forEach>
								<c:if test="${empty result}">
						          <tr>
						            <td colspan="5">자료가 없습니다.</td>
						          </tr>
						        </c:if>
								</tbody>
							</table><!-- E : 과제관리 -->							 
						</div>