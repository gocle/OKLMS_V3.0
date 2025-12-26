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
<c:set var="scrollNum" value="${param.scrollNum}"/>
<c:set var="targetUrl" value="/lu/discuss/"/>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript">
   var scrollNum = "${scrollNum}";
	var targetUrl = "${targetUrl}";

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

	/*====================================================================
	사용자 정의 함수
	====================================================================*/
	/* 토론의견 목록 검색어 엔터 이벤트 */
	function press(event) {
		if (event.keyCode==13) {
		}
	}

	function fn_goMemberReport ( param1, param2, param3 ){

		//$("#memSeq").val( param1 );
		//$("#memId").val( param2 );
		
		$("#scrollNum").val( param1 );
		$("#scrollSeq").val( param2 );
		$("#searchKeyword").val( param3 );

		var reqUrl = "/lu/evalPlan/listEvalResultMember.do";

		$("#frmEvalResult").attr("action", reqUrl);
		$("#frmEvalResult").attr("target", "_self");
		$("#frmEvalResult").submit();
	}

	function fn_searchMember (  ){

		var reqUrl = "/lu/evalPlan/listEvalResultMember.do";

		$("#frmEvalResult").attr("action", reqUrl);
		$("#frmEvalResult").attr("target", "_self");
		$("#frmEvalResult").submit();
	}

</script>

<form id="frmEvalResult" name="frmEvalResult" method="post">
<input type="hidden" id="yyyy" name="yyyy" value="${planEvalVO.yyyy}" />
<input type="hidden" id="term" name="term" value="${planEvalVO.term}" />
<input type="hidden" id="subjectCode" name="subjectCode" value="${planEvalVO.subjectCode}" />
<input type="hidden" id="subClass" name="subClass" value="${planEvalVO.subClass}" />
<input type="hidden" id="memSeq" name="memSeq" />
<input type="hidden" id="memId" name="memId" />
<input type="hidden" id="scrollSeq" name="scrollSeq" />
<input type="hidden" id="scrollNum" name="scrollNum" />

<div id="">
	<h2>평가결과서</h2>

		<div class="search-box-1 mt-020">
			<input type="text" id="searchKeyword" name="searchKeyword" placeholder="(ex)이름 입력" value="${planEvalVO.searchKeyword}"/>
			<a href="#!" onclick="javascript:fn_searchMember(); return false">검색</a>
			<a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd " style="padding:0">학습자 검색 <i class="xi-search"></i></a>
		</div><!-- E : search-box-1 -->

			<c:if test="${memName != ''}">
			<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
			<script type="text/javascript" src="/js/oklms/iscroll.js"></script>

			<%-- <ul id="learner-wrap" class="mt-030 mb-010">
				<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
				<li id="wrap">
					<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
					<div id="scroller" style="width:${fn:length(resultMemberList)*128}px;">
						<ul id="thelist" class="name-tab-btn">
							<!-- <li class="current"><a href="#!">김수한무거북이와두루미</a></li> -->
							<c:forEach var="resultMember" items="${resultMemberList}" varStatus="status">
							<li <c:if test="${(resultMember.memSeq eq memSeq and empty param.scrollSeq) or (resultMember.memSeq eq param.scrollSeq)}"> class="current" </c:if>>
								<a href="#!" onclick="javascript:fn_goMemberReport('${resultMember.memSeq}','${resultMember.memId}'); return false">${resultMember.memName}</a>
								<a href="#!" onclick="javascript:fn_goMemberReport('${status.count}','${resultMember.memSeq}'); return false">${resultMember.memName}</a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</li>
				<li id="next" onclick="myScroll.scrollToPage('next', 0);return false">next</li>

				<script type="text/javascript">
					var myScroll;

					function loaded() {
						myScroll = new iScroll('wrap', {
							snap: true,
							momentum: false,
							hScrollbar: false,
						});
					}

					document.addEventListener('DOMContentLoaded', loaded, false);
				</script>
			</ul><!-- E : learner-wrap --> --%>
			<!--  학습자 모달창 -->
		<div id="learner-wrap_area" class="modal">
			<div class="modal-title">학습자 검색 </div>
			<div class="modal-body">
				<!--  분반 검색 -->
				<!-- 
				<div class="search_box"> 
					<fieldset>
					<legend>게시물 검색</legend>
						<input id="searchWrd" name="searchWrd" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
						<button class="btn btn-black btn-sch">검색</button> 
					</fieldset>
				 </div>
				  -->
				
				<!--  학습자 검색 결과 및 리스트 -->
				<div id="learner-wrap_box">
					<ul id="learner-wrap" >
						<li id="wrap">
							<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
							<div id="scroller">
								<ul id="thelist" class="name-tab-btn li-w3">											
								<c:forEach var="resultMember" items="${resultMemberList}" varStatus="status">
								<li <c:if test="${(resultMember.memSeq eq memSeq and empty param.scrollSeq) or (resultMember.memSeq eq param.scrollSeq)}"> class="current" </c:if>>
									<a href="#!" onclick="javascript:fn_goMemberReport('${status.count}','${resultMember.memSeq}','${resultMember.memName}'); return false">${resultMember.memName}</a>
								</li>
								</c:forEach>									 	
								</ul>
							</div>
						</li>
					</ul><!-- E : learner-wrap -->
				</div>
			</div>
		</div>
		<!--  //학습자 모달창 -->


			<div class="align-center mb-040">
				<c:if test="${memId != ''}">
					<iframe id="myframe" name="myframe" src="" width="100%" height="900px"></iframe>
				</c:if>
			</div><!-- E : btn-area -->
			</c:if>


</div><!-- E : content-area -->

</form>
<script>
	if( scrollNum > 9 ){
		setTimeout(function() { $("#next").trigger("click"); }, 1000);
	}
	if( scrollNum > 18 ) {
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 27 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 36 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 45 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 54 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 63 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 72 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 81 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	} 
	if( scrollNum > 90 ){
		setTimeout(function() { $("#next").trigger("click"); }, 500);
	}
</script>
