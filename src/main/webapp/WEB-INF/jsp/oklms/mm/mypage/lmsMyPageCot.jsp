 <%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<script type="text/javascript">
<!--
function fn_egov_inqire_notice(i, nttId, bbsId) {
	 if(bbsId == "") return false;
	document.frm.nttId.value = nttId;
	document.frm.bbsId.value = bbsId;
	document.frm.action = "<c:url value='/mm/cop/bbs/"+bbsId+"/selectBoardArticle.do'/>";
	document.frm.submit();
}

function fn_curri(yyyy,term,subjectCode,subClass){
	$("#curri_yyyy").val(yyyy);
	$("#curri_term").val(term);
	$("#curri_subjectCode").val(subjectCode);
	$("#curri_subClass").val(subClass);
	$("#curri_classId").val(subClass);
	$("#curri_subjectClass").val(subClass);
	var reqUrl = "/mm/curriculum/listCurriculum.do";
	 
	$("#frmCurriculum").attr("target", "_self");
	$("#frmCurriculum").attr("action", reqUrl);
	$("#frmCurriculum").submit();
}

//-->
</script>

<form name="frmCurriculum" id="frmCurriculum" method="post">
<input type="hidden" name="subjectTraningType" id="curri_subjectTraningType" value="">
<input type="hidden" name="yyyy" id="curri_yyyy" value="">
<input type="hidden" name="term" id="curri_term" value="">
<input type="hidden" name="subjectCode" id="curri_subjectCode" value="">
<input type="hidden" name="subjectName" id="curri_subjectName" value="">
<input type="hidden" name="subClass" id="curri_subClass" value="">
<input type="hidden" name="classId" id="curri_classId" value="">
<input type="hidden" name="subjectClass" id="curri_subjectClass" value="">
<input type="hidden" name="weekCnt" id ="curri_weekCnt" >
<input type="hidden" name="weekId" id ="curri_weekId" >
</form>
<form name="frm"   method="post">
<input type="hidden" name="bbsId"  />
<input type="hidden" name="nttId"   />  
</form>
 			<div id="container">
				<div id="contents-area">
 
					<h3>TODAY</h3>
					<table class="today-type" style="table-layout:fixed;">
						<thead>
							<tr>
								<th>훈련일지 작성</th>
								<th>학습활동서 확인</th>
								<th>질문과 답변</th>
								<th>공지사항</th>
								<th>면담일지 작성</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span>${readTodayCnt[0].myPageTodayCnt1}</span>건</td>
								<td><span>${readTodayCnt[0].myPageTodayCnt2}</span>건</td>
								<td><span>${readTodayCnt[0].myPageTodayCnt3}</span>건</td>
								<td><span>${readTodayCnt[0].myPageTodayCnt4}</span>건</td>
								<td><span>${readTodayCnt[0].myPageTodayCnt5}</span>건</td>
							</tr>
						</tbody>					
					</table>

					<h3>학습근로자관리</h3>
					<table class="type-2">
						<colgroup>
							<col width="*" />
								<col width="*" />
								<col width="50px" />
								<col width="50px" />
								<col width="50px" />
						</colgroup>
						<thead>
							<tr>
								<th>교과목</th>
								<th>주차</th>
								<th>결석</th>
								<th>활동서<br />미작성</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="rs" items="${listLmsUserMainPageStatusCnt }" varStatus="status">
								<tr>
								 	<td>${rs.subjectName}</td>
								 	<td>${rs.weekCnt}</td>
								 	<td>${rs.totalTime-rs.attend}</td>
								 	<td>${rs.activityNoteCnt}</td>
								</tr>				
							</c:forEach>
							<c:if test="${ empty listLmsUserMainPageStatusCnt}">
								<tr>
									<td colspan="4">강의가 없습니다.</td>
								</tr>					 
							</c:if>	
						</tbody>
					</table>

					<c:if test="${not empty noticeResultList}">
					<h3>공지사항</h3>
					<ul class="board-list">
 
					<c:forEach var="noticeResult" items="${noticeResultList}" varStatus="status">
						<li> 
						<a href="#!" onclick="fn_egov_inqire_notice('${status.count}','${noticeResult.nttId}','${noticeResult.bbsId}');" >
							<span>[ ${noticeResult.subjectName} ]</span>
							<c:if test="${'Y' == noticeResult.topNoticeYn}"><B></c:if>${noticeResult.nttSj}<c:if test="${'Y' == noticeResult.topNoticeYn}"></B></c:if>
						</a> 
 
						</li>	
					</c:forEach>
					<li class="more"><a href="/mm/cop/bbs/BBSMSTR_000000000005/selectBoardList.do">공지사항 더 보기</a></li>
					 
					</ul>
					</c:if> 

<%-- 					<c:if test="${not empty qaResultList}"> 
 --%>					
					<c:if test="${not empty quAndAnResultList}"> 
					<h3>Q&amp;A</h3>
					<ul class="board-list">	
						<c:if test="${fn:length(quAndAnResultList) == 0}">
							<li>등록된 Q &amp; A가 없습니다.</li>
						</c:if>
						<c:forEach var="quAndAnResult" items="${quAndAnResultList}" varStatus="status">
							<li>
								<a href="#!" onclick="fn_board_detail('${quAndAnResult.nttId}','${quAndAnResult.bbsId}');">
									<span>[ ${quAndAnResult.subjectName} ]</span>
									<c:if test="${'Y' == quAndAnResult.topNoticeYn}"><B></c:if>${quAndAnResult.nttSj}<c:if test="${'Y' == quAndAnResult.topNoticeYn}"></B></c:if>
								</a>
							</li>
						</c:forEach>
					<li class="more"><a href="/mm/cop/bbs/BBSMSTR_000000000007/selectBoardList.do">Q&amp;A 더 보기</a></li>			
					</ul>
					</c:if> 
					
					<%-- <c:forEach var="qaResult" items="${qaResultList}" varStatus="status">
						<li>
							<c:choose>
									<c:when test="${qaResult.isExpired == 'T' && qaResult.isExpired !='Y'}">
										<c:if test="${'Y' == qaResult.topNoticeYn}">
											<span>[(<c:out value="${qaResult.subjectName}"/>)<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]</span> <B><c:out value="${qaResult.nttSj}" /> [<c:out value="${qaResult.commnetCount}" />]</B>
										</c:if>
										<c:if test="${'N' == qaResult.topNoticeYn}">
											<span>[<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]</span> <c:out value="${qaResult.nttSj}" /> [<c:out value="${qaResult.commnetCount}" />]
										</c:if>
									</c:when>
									<c:when test="${qaResult.isExpired !='T' && qaResult.isExpired =='Y'}">
										<c:if test="${'Y' == qaResult.topNoticeYn}">
											<span>[<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]</span> <B><c:out value="${qaResult.nttSj}" /> [<c:out value="${qaResult.commnetCount}" />]</B>
										</c:if>
										<c:if test="${'N' == qaResult.topNoticeYn}">
											<span>[<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]</span> <c:out value="${qaResult.nttSj}" /> [<c:out value="${qaResult.commnetCount}" />]
										</c:if>
									</c:when>
									<c:when test="${qaResult.useAt == 'N'}">
								  		<c:if test="${qaResult.replyLc!=0}">
								  		<c:forEach begin="0" end="${qaResult.replyLc}" step="1">
								  			&nbsp;
								  		</c:forEach>
								  		<img src="<c:url value='/images/egovframework/com/cmm/icon/reply_arrow.gif'/>" alt="reply arrow">
								  		</c:if>
										<c:if test="${'Y' == qaResult.topNoticeYn}">
											<span>[<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]</span> <B><c:out value="${qaResult.nttSj}" /> [<c:out value="${qaResult.commnetCount}" />]</B>
										</c:if>
										<c:if test="${'N' == qaResult.topNoticeYn}">
											 [<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]<c:out value="${qaResult.nttSj}" /> [<c:out value="${qaResult.commnetCount}" />]
										</c:if>
									</c:when>
									<c:otherwise>
								   	<c:if test="${qaResult.replyLc!=0}">
								   		<c:forEach begin="0" end="${qaResult.replyLc}" step="1">
								   			&nbsp;
								   		</c:forEach>
								   		<img src="<c:url value='/images/egovframework/com/cmm/icon/reply_arrow.gif'/>" alt="reply arrow">
								   	</c:if>
							  		<c:if test="${'Y' == qaResult.topNoticeYn}">
										<a href="#"  class="text" onclick="fn_egov_inqire_notice('${status.count}','${qaResult.nttId}','${qaResult.bbsId}');"><span>[<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]</span> <B><c:out value="${qaResult.nttSj}"/> [<c:out value="${qaResult.commnetCount}" />]</B></a>
									</c:if>
									<c:if test="${'N' == qaResult.topNoticeYn}">
										<a href="#"  class="text" onclick="fn_egov_inqire_notice('${status.count}','${qaResult.nttId}','${qaResult.bbsId}');"><span>[<c:out value="${qaResult.subjectName}"/>(<c:out value="${qaResult.subClass}"/>)분반]</span> <c:out value="${qaResult.nttSj}"/> [<c:out value="${qaResult.commnetCount}" />]</a>
									</c:if>
									</c:otherwise>
							</c:choose>
						</li>	
					</c:forEach>
					<li class="more"><a href="/mm/cop/bbs/BBSMSTR_000000000007/selectBoardList.do">Q&amp;A 더 보기</a></li>			
					</ul>
					</c:if> 
				 --%>

					<h3>강의일정</h3>
					<table class="type-2">
						<colgroup>
							<col width="30%" />
							<col width="*" />
						</colgroup>
						<tbody>
<c:forEach var="result" items="${listLectureCotSchedule}" varStatus="status">
							<tr>
								<th>시간</th>
								<td class="left">${result.traningStHour}:${result.traningStMin} ~ ${result.traningEdHour}:${result.traningEdMin}</td>
							</tr>
							<tr>
								<th>개설교과명</th>
								<td class="left"><a href="#!" onclick="fn_curri('${result.yyyy}','${result.term}','${result.subjectCode}','${result.subClass}');">${result.subjectName}</a></td>
							</tr>
							<tr>
								<th>대상학년</th>
								<td class="left">${result.schoolYear}</td>
							</tr>
							<tr>
								<th>분반</th>
								<td class="left">${result.subClass}</td>
							</tr>
							<tr>
								<th>주차</th>
								<td class="left">${result.weekCnt} / ${result.maxWeekCnt}</td>
							</tr>
							<tr>
								<th>단원 (능력단위요소)</th>
								<td class="left">${result.ncsUnitName}</td>
							</tr>
							<tr>
								<th>교수</th>
								<td class="left">${result.memberPrtName}</td>
							</tr>
</c:forEach>	
							<c:if test="${ empty listLectureCotSchedule}">
							<tr>
								<td colspan="2">강의가 없습니다.</td>
							</tr>
							</c:if>		 
						</tbody>
					</table>


				</div><!-- E : contents-area -->
			</div>
 