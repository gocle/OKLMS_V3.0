<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<c:if test="${!empty onlineTraningVO}">
			<table  class="type-3">
				<tr>
					<th>ON-LINE 출석정책</th>
					<th> 출석 </th>
					<td>${onlineTraningVO.attendProgress}이상</td>
					<th>지각</th>
					<td> ${onlineTraningVO.attendProgress} 미만&nbsp; ${onlineTraningVO.cutProgress}이상 </td>
					<th> 결석 </th>
					<td>${onlineTraningVO.cutProgress}이상</td>
				</tr>
			</table>		
			</c:if>

			<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
				  <caption>학번 이름 학년 출석 지각 결석 진도율에 대한 정보를 제공합니다</caption>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">학번</th>
											<th scope="col">이름</th>
											<th scope="col">학년</th>
											<th scope="col">출석</th>
											<th scope="col">지각</th>
											<th scope="col">결석</th>
											<th scope="col">진도율</th>
										</tr>
		 
									<c:forEach var="resultlists" items="${resultlist}" varStatus="status">
										<tr>
											<td>${status.count}</td>
											<td>${resultlists.memId }</td>
											<td class="left">${resultlists.memName }</td>
											<td>${resultlists.level}</td>
											<td>${resultlists.onAttend }</td>
											<td>${resultlists.onLateness }</td>
 											<td>
 											<c:if test="${!empty onlineTraningVO}">
 											${resultlists.onTotalTime - resultlists.onAttend - resultlists.onLateness}
 											</c:if>
 											<c:if test="${empty onlineTraningVO}">
 											0
 											</c:if>
 											</td>
											<td>
												<div class="progress-area2">
													<p>${resultlists.onRealProgressRate}%</p>
													<progress value="${resultlists.onRealProgressRate}" max="100" style="width: 100%"></progress>
												</div>
											</td>
										</tr>
									</c:forEach>
  
			</table><!-- E : 전체 학습근로자관리-->
  