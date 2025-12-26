<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>

td {mso-number-format:"@";}

</style> 

<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
	<thead>
		<tr>
			<th colspan="3">NCS기반자격</th>
			<th colspan="2">필수NCS능력단위</th>	 
		</tr>
			
		<tr>
			<th style="width: 30%">자격명</th>
			<th style="width: 10%">수준</th>
			<th style="width: 10%">버전</th>
			<th style="width: 25%">능력단위명</th>
			<th style="width: 25%">능력단위코드</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
			<c:set var="rowspan" value="1"/>
			<c:if test ="${result.rn eq '1'}">
				<c:set var="rowspan" value="${result.rowspan}"/>
			</c:if>
			
			<c:if test="${result.rn eq '1'}">
				<td rowspan="${rowspan}">
				${result.licenceName}
				</td>
				<td rowspan="${rowspan}">
				${result.licenceLevel}
				</td>
				<td rowspan="${rowspan}">
				${result.licenceVersion}
				</td>
			</c:if>
				<td><c:if test="${!empty result.unitId}">${result.unitName}</c:if></td>
				<td><c:if test="${!empty result.unitId}">${result.unitCd}</c:if></td>
			</tr>
		</c:forEach>	
	</tbody>
</table>