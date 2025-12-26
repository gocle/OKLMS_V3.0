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
function fn_preview(yyyy,term,subjectCode,subClass,subjectName,weekId,weekMobileNotCnt){
	if(weekMobileNotCnt != '0'){
		alert("모바일 학습을 지원하지 않는 콘텐츠입니다.");
		return;
	}
	$("#curri_yyyy").val(yyyy);
	$("#curri_term").val(term);
	$("#curri_subjectCode").val(subjectCode);
	$("#curri_subjectName").val(subjectName);
	$("#curri_subClass").val(subClass);
	$("#curri_classId").val(subClass);
	$("#curri_subjectClass").val(subClass);
	$("#curri_weekId").val(weekId);
	var reqUrl = "/mm/curriculum/getCurriculumOnlineStudyPreview.do";
	 
	$("#frmCurriculum").attr("target", "_self");
	$("#frmCurriculum").attr("action", reqUrl);
	$("#frmCurriculum").submit();
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
								<th>훈련일지<br />작성</th>
								<th>학습활동서<br />확인</th>
								<th>Q&A</th>
								<th>개별과제<br />확인</th>
								<th>팀프로젝트<br />확인</th>
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

					<h3>학습근로자관리 (Off-JT)</h3>
		
					<table class="type-2">
					<colgroup>
						<col width="*" />
						<col width="70px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="50px" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th rowspan="2">개설교과</th>
							<th rowspan="2">대상학년</th>
							<th rowspan="2">주차</th>
							<th rowspan="2">인원</th>
							
							<th colspan="2">결석</th>
							<th colspan="2">지각</th>
							<th rowspan="2">활동서 미작성</th>
						</tr>
						<tr>
							<th class="border-left">집체</th>
							<th>온라인</th>
							<th>집체</th>
							<th>온라인</th>
						</tr>
					</thead>
					<tbody> 
						
						<c:forEach var="rs" items="${offStatus}" varStatus="status">
						<tr>
							<td class="left"><a href="#!" class="text">${rs.subjectName}</a></td>
							<td>${rs.schoolYear}</td>
							<td>${rs.weekCnt}/${rs.maxWeekCnt}</td>
							<td>${rs.totalCnt}</td>
							
							<td>${rs.totalTime - rs.attend}</td>
							<td>${rs.onTotalCnt - rs.onAttend}</td>
							
							<td>${rs.lateness}</td>
							<td>${rs.onLateness}</td>
							
							<td>${rs.activityNoteCnt}</td>
						</tr>						
						</c:forEach>
					<c:if test="${ empty offStatus}">
						<tr>
							<td colspan="9">강의가 없습니다.</td>
						</tr>					 
					</c:if>
					</tbody>
				</table>
				
				<br/><br/><br/><br/>
				
				<h3>학습근로자관리(OJT)</h3>
				
				<table class="type-2">
					<colgroup>
						<col width="*" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="60px" />
						<col width="90px" />
					</colgroup>
					<thead>
						<tr>
							<th>개설교과</th>
							<th>대상학년</th>
							<th>참여기업</th>
							
							<th>주차</th>
							<th>인원</th>
							
							<th>결석</th>
							<th>지각</th>
							<th>활동서 미작성</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rs" items="${ojtStatus}" varStatus="status">
						<tr>
							<td class="left"><a href="#!" class="text">${rs.subjectName}</a></td>
							<td>${rs.schoolYear}</td>
							
							<td>${rs.companyCnt}</td>
							
							<td>${rs.weekCnt}/${rs.maxWeekCnt}</td>
							<td>${rs.totalCnt}</td>
							
							<td>${rs.totalTime - rs.attend}</td>							
							<td>${rs.lateness}</td>
							
							<td>${rs.activityNoteCnt}</td>
						</tr>						
						</c:forEach>					
 					<c:if test="${ empty ojtStatus}">
						<tr>
							<td colspan="8">강의가 없습니다.</td>
						</tr>					 
					</c:if>
					</tbody>
				</table>
					

					<%-- <c:if test="${not empty noticeResultList}">
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
					</c:if>  --%>
					
					<h3>Q &amp; A</h3>
					<ul class="board-list">
					<c:if test="${fn:length(quAndAnResultList) == 0}">
						<li>등록된 Q &amp; A가 없습니다.</li>
					</c:if>
					<c:forEach var="quAndAnResult" items="${quAndAnResultList}" varStatus="status">
						<li>
							<a href="#!" onclick="fn_egov_inqire_notice('${status.count}','${quAndAnResult.nttId}','${quAndAnResult.bbsId}');">
								<span>[ ${quAndAnResult.subjectName} ]</span><c:if test="${'Y' == quAndAnResult.topNoticeYn}"><B></c:if> ${quAndAnResult.nttSj}<c:if test="${'Y' == quAndAnResult.topNoticeYn}"></B></c:if>
							</a>	
								
						</li>
					</c:forEach>
					<li class="more"><a href="/mm/cop/bbs/BBSMSTR_000000000007/selectBoardList.do">Q&amp;A 더 보기</a></li>		
					</ul>
					
					<%-- <c:if test="${not empty qaResultList}"> 
					<h3>Q&amp;A</h3>
					<ul class="board-list">
					
					<c:forEach var="qaResult" items="${qaResultList}" varStatus="status">
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
					</c:if>  --%>
					

					<h3>강의일정</h3>
					
<c:forEach var="offListSchedule" items="${offListSchedule}" varStatus="status">						
					<table class="type-2">
						<colgroup>
							<col width="30%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>교과형태</th>
								<td class="left">Off-JT</td>
							</tr>
							<tr>
								<th>교과목명</th>
								<td class="left"><a href="javascript:fn_curri('${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}');">${offListSchedule.subjectName}</a></td>
							</tr>
							<tr>
								<th>시간</th>
								<td class="left">
								<c:if test="${not empty offListSchedule.traningStHour}"> 
									${offListSchedule.traningStHour}:${offListSchedule.traningStMin} ~ ${offListSchedule.traningEdHour}:${offListSchedule.traningEdMin}
								</c:if>
								</td>
							</tr>
							<tr>
								<th>분반 / 주차</th>
								<td class="left">${offListSchedule.subClass} / ${offListSchedule.weekCnt}</td>
							</tr>
							<tr>
								<th>온라인 강의</th>
								<td class="left">
								<c:if test="${offListSchedule.weekMappingCnt ne '0'}">
									<a href="javascript:fn_preview('${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.weekId}','${offListSchedule.weekMobileNotCnt}');" class="more">${offListSchedule.onlineTypeName}</a>
								</c:if>
								</td>
							</tr>
							<tr>
								<th>능력단위요소</th>
								<td class="left">
								<c:if test="${not empty offListSchedule.ncsUnitName}">${offListSchedule.ncsUnitName}</c:if>
								<c:if test="${not empty offListSchedule.ncsElemName}">(${offListSchedule.ncsElemName})</c:if>
								</td>
							</tr>
							<tr>
								<th>장소</th>
								<td class="left">${offListSchedule.lctrumNm}</td>
							</tr>
							</tbody>
					</table>
</c:forEach>	

						
<c:forEach var="ojtListSchedule" items="${ojtListSchedule}" varStatus="status">
						<table class="type-2">
						<colgroup>
							<col width="30%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>교과형태</th>
								<td class="left">OJT</td>
							</tr>
							<tr>
								<th>교과목명</th>
								<td class="left"><a href="#!" onclick="fn_curri('${ojtListSchedule.yyyy}','${ojtListSchedule.term}','${ojtListSchedule.subjectCode}','${ojtListSchedule.subClass}');">${ojtListSchedule.subjectName}</a></td>
							</tr>
							<tr>
								<th>시간</th>
								<td class="left">
								${ojtListSchedule.traningStHour}:${ojtListSchedule.traningStMin} ~ ${ojtListSchedule.traningEdHour}:${ojtListSchedule.traningEdMin}
								</td>
							</tr>
							<tr>
								<th>분반 / 주차</th>
								<td class="left">${ojtListSchedule.subClass} / ${ojtListSchedule.weekCnt}</td>
							</tr>
							<tr>
								<th>기업명</th>
								<td class="left">${ojtListSchedule.companyName}</td>
							</tr>
							<tr>
								<th>능력단위요소</th>
								<td class="left">
								<c:if test="${not empty ojtListSchedule.ncsUnitName}">${ojtListSchedule.ncsUnitName}</c:if>
								<c:if test="${not empty ojtListSchedule.ncsElemName}">(${ojtListSchedule.ncsElemName})</c:if>
								</td>
							</tr>
								
						</tbody>
					</table>
</c:forEach>
					<c:if test="${ empty ojtListSchedule and empty offListSchedule}">
					<table class="type-2">
						<colgroup>
							<col width="30%" />
							<col width="*" />
						</colgroup>
							<tbody>
								<tr>
									<td colspan="2">강의가 없습니다.</td>
								</tr>	
							</tbody>
						</table>				 
					 </c:if> 
				</div><!-- E : contents-area -->
			</div>
 