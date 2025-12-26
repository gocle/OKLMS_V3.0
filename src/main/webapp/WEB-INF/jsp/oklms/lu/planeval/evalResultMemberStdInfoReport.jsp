<%@page import="kr.co.gocle.oklms.comm.util.CommonUtil"%>
<%@page import="kr.co.gocle.oklms.lu.planeval.vo.PlanEvalVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
 <%
 
 PlanEvalVO planEvalVO = new PlanEvalVO();
 planEvalVO = (PlanEvalVO)request.getAttribute("planEvalVO");
 
 
 //System.out.println("============== planEvalVO.getYyyy() : "+planEvalVO.getYyyy());
 //System.out.println("============== planEvalVO.getTmpTerm() : "+planEvalVO.getTmpTerm());
 //System.out.println("============== planEvalVO.getSubjectCode() : "+planEvalVO.getSubjectCode());
 //System.out.println("============== planEvalVO.getSubClass() : "+planEvalVO.getSubClass());
String memId = CommonUtil.AESenc((String)request.getAttribute("memId"));
String ls_estbl_yy = CommonUtil.AESenc(planEvalVO.getYyyy());
String ls_estbl_semstr_cd =  CommonUtil.AESenc(planEvalVO.getTmpTerm());
String ls_course_no =  CommonUtil.AESenc(planEvalVO.getSubjectCode());
String ls_partitn_clas_se_cd =  CommonUtil.AESenc(planEvalVO.getSubClass());

//System.out.println("============== ls_estbl_yy : "+ls_estbl_yy);
//System.out.println("============== ls_estbl_semstr_cd : "+ls_estbl_semstr_cd);
//System.out.println("============== ls_course_no : "+ls_course_no);
//System.out.println("============== ls_partitn_clas_se_cd : "+ls_partitn_clas_se_cd);

%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript">

	$(document).ready(function() {
		loadPage();
	});

	/*====================================================================
		화면 초기화
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}

	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/* 화면이 로드된후 처리 초기화 */
	function initHtml() {
		var ls_estbl_yy              = encodeURIComponent("<%=ls_estbl_yy %>");
		var ls_estbl_semstr_cd       = encodeURIComponent("<%=ls_estbl_semstr_cd %>");
		var ls_course_no             = encodeURIComponent("<%=ls_course_no %>");
		var ls_partitn_clas_se_cd    = encodeURIComponent("<%=ls_partitn_clas_se_cd %>");
		var I_STUD_ID    = encodeURIComponent("<%=memId %>");
		//https://kut90.koreatech.ac.kr/oz/NCS/NC0213R.jsp?I_ESTBL_YY=${planEvalVO.yyyy}&I_ESTBL_SEMSTR_CD=${planEvalVO.tmpTerm}&I_COURSE_NO=${planEvalVO.subjectCode}&I_PARTITN_CLAS_SE_CD=${planEvalVO.subClass}&I_STUD_ID=${memId}
		var ls_url = "https://kut90.koreatech.ac.kr/oz/NCS/NC0213R.jsp?I_ESTBL_YY="+ls_estbl_yy+"&I_ESTBL_SEMSTR_CD="+ls_estbl_semstr_cd+"&I_COURSE_NO="+ls_course_no+"&I_PARTITN_CLAS_SE_CD="+ls_partitn_clas_se_cd+"&I_STUD_ID="+I_STUD_ID;
		$("#myframe").attr("src",ls_url);
	}

</script>

<form id="frmEvalResult" name="frmEvalResult" method="post">
<input type="hidden" id="yyyy" name="yyyy" value="${planEvalVO.yyyy}" />
<input type="hidden" id="term" name="term" value="${planEvalVO.term}" />
<input type="hidden" id="subjectCode" name="subjectCode" value="${planEvalVO.subjectCode}" />
<input type="hidden" id="subClass" name="subClass" value="${planEvalVO.subClass}" />
<input type="hidden" id="memSeq" name="memSeq" value="${memSeq}" />

<div id="">
	<h2>평가결과서</h2>

	<div class="align-center mb-040">
		<c:if test="${memId != ''}">
			<iframe id="myframe" name="myframe" src="" width="100%" height="900px"></iframe>
		</c:if>
	</div><!-- E : btn-area -->

</div><!-- E : content-area -->

</form>

