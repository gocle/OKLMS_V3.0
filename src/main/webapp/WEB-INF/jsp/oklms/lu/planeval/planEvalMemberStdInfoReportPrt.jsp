<%@page import="kr.co.gocle.oklms.lu.planeval.vo.PlanEvalVO"%>
<%@page import="kr.co.gocle.oklms.comm.util.CommonUtil"%>
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

<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
<script type="text/javascript" src="/js/oklms/iscroll.js"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript">

	var scrollNum = "${scrollNum}";

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

	function fn_goCompnayReport ( param1, param2, param3 ){

		$("#searchSubClass").val( param1 );
		$("#companyId").val( param2 );
		$("#scrollNum").val( param3 );

		reqUrl = "/lu/evalPlan/listNcsEvalPlanMember.do";

		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").attr("target", "_self");
		$("#frmEvalPlan").submit();
	}

	function fn_goMemberReport ( param1, param2 ){

		$("#memSeq").val( param1 );
		$("#memId").val( param2 );

		var reqUrl = "/lu/evalPlan/listNcsEvalPlanMember.do";

		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").attr("target", "_self");
		$("#frmEvalPlan").submit();
	}

	function fn_searchMember (  ){

		if($("#companyId").val() == ""){
			alert("하나의 기업명_분반 선택후 검색해주세요.");
			return false;
		}

		var reqUrl = "/lu/evalPlan/listNcsEvalPlanMember.do";

		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").attr("target", "_self");
		$("#frmEvalPlan").submit();
	}

	/* Tab 클릭시 이벤트 */
	function fn_goTab( param1 ){
		var reqUrl = "";

		if(param1 == '01'){
			reqUrl = "/lu/evalPlan/listNcsEvalPlan.do";
		} else if(param1 == '02'){
			/* if($("#companyId").val( ) == '' || $("#searchSubClass").val( ) == ''){
				alert("회사명_분반을 클릭하세요");
				return false;
			} */

			$("#searchSubClass").val($("#subClass").val());

			reqUrl = "/lu/evalPlan/listNcsEvalPlanFirst.do";
		} else if(param1 == '03'){
			reqUrl = "/lu/evalPlan/listNcsEvalPlanSubject.do";
		} else {
			reqUrl = "/lu/evalPlan/listNcsEvalPlanMember.do";
		}

		$("#frmEvalPlan").attr("action", reqUrl);
		$("#frmEvalPlan").attr("target", "_self");
		$("#frmEvalPlan").submit();
	}

</script>

<form id="frmEvalPlan" name="frmEvalPlan" method="post">
<input type="hidden" id="yyyy" name="yyyy" value="${planEvalVO.yyyy}" />
<input type="hidden" id="term" name="term" value="${planEvalVO.term}" />
<input type="hidden" id="subjectCode" name="subjectCode" value="${planEvalVO.subjectCode}" />
<input type="hidden" id="subClass" name="subClass" value="${planEvalVO.subClass}" />
<input type="hidden" id="companyId" name="companyId" value="${planEvalVO.companyId}" />
<input type="hidden" id="searchSubClass" name="searchSubClass" value="${planEvalVO.searchSubClass}" />
<input type="hidden" id="cnt" name="cnt" value="${cnt}" />
<input type="hidden" id="memSeq" name="memSeq" />
<input type="hidden" id="memId" name="memId" />
<input type="hidden" id="scrollNum" name="scrollNum" value="" />

<div id="">
	<h2>직무수행능력평가</h2>

	<dl id="tab-type-2">
		<dt class="tab-name-11"><a href="#!"  onclick="javascript:fn_goTab('01'); return false">평가계획 확인</a></dt>
		<dt class="tab-name-12"><a href="#!" onclick="javascript:fn_goTab('02'); return false">1차 평가 확인</a></dt>
		<dt class="tab-name-13"><a href="#!" onclick="javascript:fn_goTab('03'); return false">개설교과별 결과조회</a></dt>
		<dt class="tab-name-14 on"><a href="#!" onclick="javascript:fn_goTab('04'); return false">학습근로자별 조회</a></dt>
		<dd id="tab-content-14" style="display:block;">

		<div class="search-box-1 mt-020">
			<input type="text" id="searchKeyword" name="searchKeyword" placeholder="(ex)이름 입력" value="${planEvalVO.searchKeyword}"/>
			<a href="#!" onclick="javascript:fn_searchMember(); return false">검색</a>
			<a href="#learner-wrap_area" rel="modal:open"  style="padding:0">분반 검색 </a>
			<a href="#learner-wrap_area1" rel="modal:open"  style="padding:0">학습자 검색</a>
		</div><!-- E : search-box-1 -->
		
		

		<%-- <ul id="learner-wrap" class="mt-030 mb-010">
				<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
				<li id="wrap">
					<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
					<div id="scroller" style="width:${fn:length(listOjtClassName)*128}px;">
						<ul id="thelist" class="name-tab-btn">
							<c:forEach var="result" items="${listOjtClassName}" varStatus="status">
							<li <c:if test="${result.companyId eq planEvalVO.companyId and result.subjectClass eq planEvalVO.subClass}"> class="current" </c:if>>
								<a href="#!" onclick="javascript:fn_goCompnayReport('${result.subjectClass}','${result.companyId }','${status.count }'); return false">${result.subjectClass}분반_${result.companyName }</a>
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
			<div class="modal-title">개설교과 분반 검색 </div>
			<div class="modal-body">
				
				<!--  학습자 검색 결과 및 리스트 -->
				<div id="learner-wrap_box">
					<ul id="learner-wrap" >
						<li id="wrap">
							<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
							<div id="scroller">
								<ul id="thelist">											
								<c:forEach var="result" items="${listOjtClassName}" varStatus="status">
								<li <c:if test="${result.companyId eq planEvalVO.companyId and result.subjectClass eq planEvalVO.subClass}"> class="current" </c:if>>
									<a href="#!" onclick="javascript:fn_goCompnayReport('${result.subjectClass}','${result.companyId }','${status.count }'); return false">${result.subjectClass}분반_${result.companyName }</a>
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

			<c:if test="${fn:length(resultMemberStdList) != 0}">
			<%-- <ul id="learner-wrap" class="mt-030 mb-010">
				<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
				<li id="wrap">
					<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
					<div id="scroller" style="width:${fn:length(resultMemberStdList)*128}px;">
						<ul id="thelist" class="name-tab-btn">
							<!-- <li class="current"><a href="#!">김수한무거북이와두루미</a></li> -->
							<c:forEach var="resultMember" items="${resultMemberStdList}" varStatus="status">
							<li <c:if test="${resultMember.memSeq eq memSeq}"> class="current" </c:if>>
								<a href="#!" onclick="javascript:fn_goMemberReport('${resultMember.memSeq}','${resultMember.memId}'); return false">${resultMember.memName}</a>
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
			
			<div id="learner-wrap_area1" class="modal">
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
								<c:forEach var="resultMember" items="${resultMemberStdList}" varStatus="status">
								<li <c:if test="${resultMember.memSeq eq memSeq}"> class="current" </c:if>>
									<a href="#!" onclick="javascript:fn_goMemberReport('${resultMember.memSeq}','${resultMember.memId}'); return false">${resultMember.memName}</a>
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
</c:if>

			<div class="group-area name-tab-content">
				<div class="align-center mb-040">
					<c:if test="${memId != ''}">
						<iframe id="myframe" name="myframe" src="" width="100%" height="900px"></iframe>
					</c:if>
				</div><!-- E : btn-area -->
			</div>
		</dd>
	</dl>
</div><!-- E : content-area -->

</form>


<script>
	if(scrollNum > 9){
		setTimeout(function() { $("#next").trigger("click"); }, 1000);
	}
</script>
