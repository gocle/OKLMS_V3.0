<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<br/>
<table  width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
	<caption>학번 이름 제출일 제출현황에 대한 정보를 제공합니다</caption>
	<colgroup>
		<col style="width:70px" />
		<col style="width:170px" />
		<col style="width:170px" />
		<col style="width:130px" />
		<col style="width:130px" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">학번</th>
			<th scope="col">이름</th>
			<th scope="col">제출일</th>
			<th scope="col">제출현황</th>
		</tr>
	</thead>
	<tbody>
	
	<c:forEach var="result" items="${result}" varStatus="status">
	
		<tr>
			<td>${status.count}</td>
			<td>${result.memId }</td>
			<td>${result.memName }</td>
			<td>${result.insertDate }</td>
			<td>
				<c:if test="${!empty result.atchFileId }">
					제출
				</c:if>
				<c:if test="${empty result.atchFileId }">
					미제출
				</c:if>										
			</td>
		</tr>									
		 				
	</c:forEach>
	<c:if test="${empty result}">
          <tr>
            <td colspan="6">자료가 없습니다.</td>
          </tr>
    </c:if>
	</tbody>
</table>