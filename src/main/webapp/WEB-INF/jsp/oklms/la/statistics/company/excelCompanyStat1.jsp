<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>

td {mso-number-format:"@";}

</style> 
									

<table   width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
	<thead>
 
		<tr>
			<th>기업명</th>
			<th>기업코드</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<tr>
				<td><c:out value="${resultList.companyName}" /></td>
				<td><c:out value="${resultList.companyId}" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>