<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
<!--
@media print																{.not_print {display: none;}}
-->
</style>

<script type="text/javascript">

$(document).ready(function() {
	//self.resizeTo(400, 300); //창크기
});
//--> 
</script>
		<!-- 팝업 사이즈 : 가로 850px 이상 설정 -->
		<div id="sms-wrapper" \>
			<ul id="sms-header">
				<li><h1>OK-LMS 회원가입 결과</h1></li>
				<li class="btn"><a href="javascript:self.close();">닫기</a></li>
			</ul><!-- E : sms-header -->
	
			<dl class="agree-wrap">
				<!-- <dt>OK-LMS 회원가입 결과</dt> -->
				
				<dd class="agree-check">
					<label for="check-1">
					
					회원가입에 성공하였습니다.
					센터전담자 승인 후 이용 가능합니다.
					<c:if test="${memType eq 'COT'}">
					<br/><br/>
					임시 아이디는 ${emplNo} 이며 비밀번호는 아이디와 같습니다.
					</c:if>
					</label>
				</dd>
			</dl>




		</div><!-- E : wrapper -->
