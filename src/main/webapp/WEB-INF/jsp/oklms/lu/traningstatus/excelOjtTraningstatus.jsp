<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

 
	
			<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
				  	<caption>OJT 운영현황에 대한 정보를 제공합니다</caption>
					<tr>
						<th scope="col" rowspan="2">학년도</th>
						<th scope="col" rowspan="2">학기</th>
						<th scope="col" rowspan="2">개설교과명</th>
						<th scope="col" rowspan="2">분반</th>
						<th scope="col" rowspan="2">담당교수</th>
						<th scope="col" rowspan="2">기업현장교사</th>
						<th scope="col" rowspan="2">학습근로자 수</th>
						<th scope="col" colspan="4">훈련일지</th>
						<th scope="col" colspan="4">학습활동서</th>
					</tr>
					<tr>
						<th scope="col">승인대기</th>
						<th scope="col">승인</th>
						<th scope="col">반려</th>
						<th scope="col">작성주차</th>
						<th scope="col">승인대기</th>
						<th scope="col">승인</th>
						<th scope="col">반려</th>
						<th scope="col">작성주차</th>
					</tr>
		 
				
						
						
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${result.yyyy}년도</td>
						<td>${result.termName}</td>
						<td class="left">${result.subjectName }</td>
						<td>${result.subjectClass}</td>
						<td>${result.insNames}</td>
						<td>${result.tutNames}</td>
						<td>${result.lessonCnt}</td>
						<td>${result.noteCnt1}</td>
						<td>${result.noteCnt2}</td>
						<td>${result.noteCnt3}</td>
						<td>${result.noteMaxCnt}</td>
						<td>${result.actCnt1}</td>
						<td>${result.actCnt2}</td>
						<td>${result.actCnt3}</td>
						<td>${result.actMaxCnt}</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="15"><spring:message code="common.nodata.msg" /></td>
					</tr>
				</c:if>
  
			</table><!-- E : 전체 학습근로자관리-->
  