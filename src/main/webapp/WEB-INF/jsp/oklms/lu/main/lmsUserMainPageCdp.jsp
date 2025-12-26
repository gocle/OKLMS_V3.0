<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/popupApi.js"></script>
<script type="text/javascript">
<!--

//var jsonObj = eval('${lms:objectToJson(popupList)}');
var jsonObj = ${lms:objectToJson(popupList)};
PopupOpenerAPI.dataList = jsonObj;
PopupOpenerAPI.contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
	//팝업 알림.
	for (var i=0; i < PopupOpenerAPI.dataList.length; i++) {
		var popup = PopupOpenerAPI.dataList[i];
		PopupOpenerAPI.open(popup, true);
	}
});

function fn_board_list(bbsId) {
	var reqUrl = "/lu/cop/bbs/"+bbsId+"/selectBoardList.do";

	$("#frmMainPage").attr("action", reqUrl);
	$("#frmMainPage").submit();
}

function fn_board_detail(nttId, bbsId) {
	var reqUrl = "/lu/cop/bbs/"+bbsId+"/selectBoardArticle.do?nttId="+nttId;

	$("#frmMainPage").attr("action", reqUrl);
	$("#frmMainPage").submit();
}

/* 리스트 조회 */
function fn_search(  ){
	var reqUrl =  "/lu/main/lmsUserMainPage.do";
	$("#frmSubject").attr("action", reqUrl);
	$("#frmSubject").submit();
}
/* 교과로 이동 */
function fn_move_subject(subjectTraningType, year, term, subjectCode, subClass, subjectName, subjectType, onlineType,preSubjectCode){
	subjectName = encodeURIComponent(subjectName);
	if(preSubjectCode != ""){
		location.href = "/lu/currproc/listCurrProc.do?subjectTraningType="+subjectTraningType+"&year="+year+"&term="+term+"&subjectCode="+subjectCode+"&subjectName="+subjectName+"&subClass="+subClass+"&lecMenuMarkYn=Y&subjectType="+subjectType+"&onlineType="+onlineType+"&preSubjectCode="+preSubjectCode;
	} else {
		location.href = "/lu/currproc/listCurrProc.do?subjectTraningType="+subjectTraningType+"&year="+year+"&term="+term+"&subjectCode="+subjectCode+"&subjectName="+subjectName+"&subClass="+subClass+"&lecMenuMarkYn=Y&subjectType="+subjectType+"&onlineType="+onlineType;
	}
}
//-->
</script>
 

<!-- 학과전담자 -->

<div class="full-area" style="border-top:0; margin-top:0;">

<%-- <h3>TODAY</h3>
<table class="type-3  wp100" style="table-layout:fixed;">
		<thead>
			<tr>
				<th>Q&amp;A 답변대기</th>
				<th>개별과제미체출</th>
				<th>팀프로젝트과제 미체출</th>
				<th>토론 미체출</th>

				<th>재직증빙서류 미승인</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_1"><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</a></td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_2"><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</a></td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_3"><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</a></td>
				<td><a href="/lu/today/lmsUserTodayPage.do#f_4"><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</a></td>
				
				<td><a href="/lu/today/lmsUserTodayPage.do#f_5"><span>${readTodayCnt[0].myPageTodayCnt6}</span>건</a></td>
			</tr>
		</tbody>
	</table>
</div> --%>
<form name="frmMainPage" id="frmMainPage" method="post">
	<div class="half-left-area">
		<h3 class="notice-tit">
			공지사항
			<a href="#!" onclick="fn_board_list('BBSMSTR_000000000000');" title="더 보기"><i class="xi-plus"></i><span class="hidden">공지사항 더보기</span></a>
		</h3>
		<div class="scroll-height02">
			<ul class="notice-list">
				<c:if test="${fn:length(noticeAllResultList) == 0}">
					<li class="no-text">등록된 공지사항이 없습니다.</li>
				</c:if>
				<c:forEach var="noticeResult" items="${noticeAllResultList}" varStatus="status">
					<li>
						<a href="#!" onclick="fn_board_detail('${noticeResult.nttId}','${noticeResult.bbsId}');">
							<span class="day">${noticeResult.frstRegisterPnttm}</span>
							<div class="txt">
								<span>
								<!-- 
									<em class="label orange">${noticeResult.subjectName}</em>
								 -->	
								 <em class="label orange">공지</em>
									<c:if test="${'Y' == noticeResult.topNoticeYn}"></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></c:if>
								</span>
							</div> 
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	

<%-- 	<div class="half-right-area">
		<h3 class="notice-tit">
			Q &amp; A
			<a href="#!" onclick="fn_board_list('BBSMSTR_000000000007');" title="더 보기"><i class="xi-plus"></i><span class="hidden">Q&A 더보기</span></a>
		</h3>
		<div class="scroll-height02">
			<ul class="notice-list">
			<c:if test="${fn:length(quAndAnResultList) == 0}">
				<li class="no-text">등록된 Q &amp; A가 없습니다.</li>
			</c:if>
			<c:forEach var="quAndAnResult" items="${quAndAnResultList}" varStatus="status">
				<li>
					<a href="#!" onclick="fn_board_detail('${quAndAnResult.nttId}','${quAndAnResult.bbsId}');">
						<span class="day">${quAndAnResult.frstRegisterPnttm}</span>
						<div class="txt">
						<em class="label orange">[ ${quAndAnResult.subjectName} ]</em>
						<c:if test="${'Y' == quAndAnResult.topNoticeYn}"></c:if>${quAndAnResult.nttSj}<c:if test="${'Y' == quAndAnResult.topNoticeYn}">></c:if>
						</div>
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div> --%>
	
	<div class="half-right-area">
		<h3 class="notice-tit">
			알림사항
			<a href="#!" onclick="fn_board_list('BBSMSTR_000000000050');" title="더 보기"><i class="xi-plus"></i><span class="hidden">알림사항 더보기</span></a>
		</h3>
		<div class="scroll-height02">
			<ul class="notice-list">
				<c:if test="${fn:length(newsResultList) == 0}">
					<li class="no-text">등록된 알림사항이 없습니다.</li>
				</c:if>
				<c:forEach var="newsResult" items="${newsResultList}" varStatus="status">
					<li>
						<a href="#!" onclick="fn_board_detail('${newsResult.nttId}','${newsResult.bbsId}');">
							<span class="day">${newsResult.frstRegisterPnttm}</span>
							<div class="txt">
								<span>
								 <em class="label orange">알림</em>
									<c:if test="${'Y' == noticeResult.topNoticeYn}"></c:if>${newsResult.nttSj}<c:if test="${'Y' == newsResult.topNoticeYn}"></c:if>
								</span>
							</div> 
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</form>


<div class="clearfix"></div>
<div class="full-area mt-40">
	<h3>Off-JT 2회 이상 결석자</h3>
	<div class="table-responsive scroll-height02">
		<table class="type-3">
			<caption>Off-JT 2회 이상 결석자 학년, 교과목, 학습근로자, 결석, 연락처 제공</caption>
			<colgroup>
				<col width="8%" />
				<col width="8%" />
				<col width="*" />
				<col width="12%" />
				<col width="8%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">No</th>
					<th scope="col">학년</th>
					<th scope="col">교과목</th>
					<th scope="col">학습근로자</th>
					<th scope="col">결석</th>
					<th scope="col">연락처</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="6">해당 기능은 모니터링중에 있습니다.</td>
				</tr>
				<!-- 
				<c:if test="${empty listOffCut}">
					<tr>
						<td colspan="6">Off-JT 2회 이상 결석데이터가 없습니다.</td>
					</tr>
				</c:if>
				
				 <c:forEach var="result" items="${listOffCut}" varStatus="status">
				 	<tr>
						<td>${status.count}</td>
						<td>${result.subjectGrade}학년</td>
						<td>${result.subjectName}</td>
						<td>${result.memName}</td>
						<td><span class="label orange">${result.cutCnt}</span></td>
						<td>${result.hpNo}</td>
					</tr>
				 </c:forEach>
				  -->
			</tbody>
		</table>
	</div>
</div>

<div class="clearfix"></div>
<form id="frmSubject" name="frmSubject" action="<c:url value='/lu/main/lmsUserMainPage.do'/>" method="post">
    <input type="hidden" id="pageSize" name="pageSize" value="10" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="1" /> 

						<div class="full-area">
							<h3>담당 개설교과 조회</h3>
					
						
							<div class="search-box-1 mt-020 mb-020">
								<%-- <label for="yyyy" class="hidden">학년도 선택</label>
								<select name="yyyy" id="yyyy" > 
									<option value="" >학년도</option>
									<c:forEach var="i" begin="0" end="2" step="1">
										<option value="${nowYear-i}" <c:if test="${subjectVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
									</c:forEach>								
								</select> 
								
								<label for="term" class="hidden">학기 선택</label>
								<select name="term" id="term">
									<option value="" >학기</option>
									<option value="1" <c:if test="${subjectVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
									<option value="2" <c:if test="${subjectVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
									<option value="3" <c:if test="${subjectVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
									<option value="4" <c:if test="${subjectVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
								</select> --%>
								
								<label for="deptCode" class="hidden">학과명 선택</label>
								<select name="deptCode" id="deptCode">
									<option value="">학과명</option>
									<c:forEach var="result" items="${deptCodeList}" varStatus="status">
										<option value="${result.codeId}" <c:if test="${subjectVO.deptCode eq result.codeId }" > selected="selected"  </c:if>>${result.codeName}</option>
									</c:forEach>		
								</select>
								
								<label for="subjectGrade" class="hidden">대상학년 선택</label>
								<select name="subjectGrade" id="subjectGrade">
									<option value="">대상학년</option>
									<option value="1" <c:if test="${subjectVO.subjectGrade eq '1' }" > selected="selected"  </c:if>>1학년</option>
									<option value="2" <c:if test="${subjectVO.subjectGrade eq '2' }" > selected="selected"  </c:if>>2학년</option>
									<option value="3" <c:if test="${subjectVO.subjectGrade eq '3' }" > selected="selected"  </c:if>>3학년</option>
									<option value="4" <c:if test="${subjectVO.subjectGrade eq '4' }" > selected="selected"  </c:if>>4학년</option>
									<option value="5" <c:if test="${subjectVO.subjectGrade eq '5' }" > selected="selected"  </c:if>>5학년</option>
								</select>
								
								<label for="subjectType" class="hidden">과정구분 선택</label>
								<select name="subjectType" id="subjectType">
									<option value="">과정구분</option>
									<option value="NORMAL" <c:if test="${subjectVO.subjectType eq 'NORMAL' }" > selected="selected"  </c:if>>학부</option>
									<option value="HSKILL" <c:if test="${subjectVO.subjectType eq 'HSKILL' }" > selected="selected"  </c:if>>고숙련</option>
								</select>
								
								<label for="subjectName" class="hidden">교과명 입력</label>
								<input type="text" name="subjectName" id="subjectName" value="${subjectVO.subjectName}" placeholder="교과명 검색" /><a href="#!" onclick="javascript:fn_search();">검색</a>
							</div><!-- E : search-box-1 -->


							<div class="table-responsive">
							<table class="type-2">
								<caption>학년도 학기 학과 대상학년 개설교과명 분반 담당교수 온라인교육형태</caption>
								<colgroup>

									<col style="width:8%" />
									<col style="width:8%" />
									<col style="width:15%" />
									<col style="width:8%" />
									
									<col style="width:*" />
									<col style="width:8%" />
									<col style="width:8%" />
									<col style="width:15%" />
								</colgroup>
								<thead>
									<tr>

										<th scope="col">학년도</th>
										<th scope="col">학기</th>
										<th scope="col">학과</th>
										<th scope="col">대상학년</th>
										
										<th scope="col">개설교과명</th>
										<th scope="col">분반</th>
										<th scope="col">담당교수</th>
										<th scope="col">온라인교육형태</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>

											<td>${result.yyyy}</td>
											<td>${result.termName}</td>
											<td>${result.deptName}</td>
											<td>${result.subjectGrade}학년</td>
											<td class="left"><a href="#fn_move_subject" onclick="fn_move_subject('${result.subjectTraningType}','${result.yyyy}','${result.term}','${result.subjectCode}','01','${result.subjectName}','${result.subjectType}','${result.onlineType}','${result.preSubjectCode}');" class="text">${result.subjectName }</a></td>
											<td>${result.subjectClass}</td>
											<td>${result.insName}</td>
											<td>${result.onlineTypeName}</td> 
										</tr>
									</c:forEach>
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="7"><spring:message code="common.nodata.msg" /></td>
										</tr>
									</c:if>	
								</tbody>
							</table><!-- E : type-2 -->
							</div>
</div>
							
</form>
