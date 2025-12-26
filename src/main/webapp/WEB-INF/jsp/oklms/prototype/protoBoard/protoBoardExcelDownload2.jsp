<%--
  Class Name : list.jsp 
  Description : 기본형
  Modification Information
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<style>
.num {
  mso-number-format:General;
}
.date1 {
/*    mso-number-format:"Short Date"; */
/*     mso-number-format:yyyy\/mm\/dd; */
    mso-number-format:\@;
}
.date2 {
/*   mso-number-format:"Short Date"; */
/*    mso-number-format:yyyy\/mm\/dd; */
   mso-number-format:\@;
}
<%--
	Styling Excel cells with mso-number-format
	mso-number-format:"0"							:		NO Decimals
	mso-number-format:"0\.000"						:		3 Decimals
	mso-number-format:"\#\,\#\#0\.000"				:		Comma with 3 dec
	mso-number-format:"mm\/dd\/yy"					:		Date7
	mso-number-format:"mmmm\ d\,\ yyyy"				:		Date9
	mso-number-format:"m\/d\/yy\ h\:mm\ AM\/PM"		:		D -T AMPM
	mso-number-format:"Short Date"					:		01/03/1998
	mso-number-format:"Medium Date"					:		01-mar-98
	mso-number-format:"d\-mmm\-yyyy"				:		01-mar-1998
	mso-number-format:"Short Time"					:		5:16
	mso-number-format:"Medium Time"					:		5:16 am
	mso-number-format:"Long Time"					:		5:16:21:00
	mso-number-format:"Percent"						:		Percent - two decimals
	mso-number-format:"0%"							:		Percent - no decimals
	mso-number-format:"0\.E+00"						:		Scientific Notation
	mso-number-format:"\@"							:		Text
	mso-number-format:"\#\ ???\/???"				:		Fractions - up to 3 digits (312/943)
	mso-number-format:"\0022£\0022\#\,\#\#0\.00"	:		£12.76
	mso-number-format:"\#\,\#\#0\.00_ \;\[Red\]\-\#\,\#\#0\.00\ "		:		2 decimals, negative numbers in red and signed	(1.56 -1.56)
--%>
</style>
	<table id="itemList" border="1" cellpadding="5" cellspacing="1" align="center" class="scrollable">
		<thead>
		<tr bgcolor="#d4e4fa">
			<th>순번</th>
			<th>프로토타입id</th>
			<th>조회수</th>
			<th>제목</th>
			<th>내용1</th>
			<th>내용2</th>
			<th>사용여부</th>
<!-- 			<th>생성자ID</th> -->
<!-- 			<th>생성일시</th> -->
			<th>수정자ID</th>
			<th>수정일시</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${dataList}" varStatus="status">
		<tr>
			<th nowrap="nowrap" scope="row">${status.count}</th>
			<td nowrap="nowrap">${result.prototypeId}</td>
			<td nowrap="nowrap" align="right"><fmt:formatNumber value="${result.prototypeViewCnt}" pattern="#,###"/></td>
<%-- 			<td nowrap="nowrap" align="right" class="num">${result.prototypeViewCnt}</td> --%>
			<td nowrap="nowrap">${result.prototypeTitle}</td>
			<td nowrap="nowrap">${result.prototypeContents1}</td>
			<td nowrap="nowrap">${result.prototypeContents2}</td>
			<td nowrap="nowrap">${result.useYsno}</td>
<%-- 			<td nowrap="nowrap">${result.crtrId}</td> --%>
<%-- 			<td nowrap="nowrap" class="date1"><fmt:parseDate value="${result.cretYmdtm}" pattern="yyyyMMddHHmmss" var="tempDateCretYmdtm"/> --%>
<%--             <fmt:formatDate value="${tempDateCretYmdtm}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
			<td nowrap="nowrap">${result.updtrId}</td>
			<td nowrap="nowrap" class="date2">${result.updtYmdtm}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
