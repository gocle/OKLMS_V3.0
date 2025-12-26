
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- Prototype body -->

<script type="text/javascript">
</Script>
Prototype body !! (PrototypeMain)
<br/>
<br/>
<br/>
message 프로퍼티 사용 예
<br/>
1) <spring:message code="success.request.msg" />
<br/>
2) errors.minlength={0}은(는) {1}자 이상 입력해야 합니다.    ==>>    <spring:message code='errors.minlength' arguments='aaa,bbbb' />
<br/>
	
<!-- // Prototype body -->