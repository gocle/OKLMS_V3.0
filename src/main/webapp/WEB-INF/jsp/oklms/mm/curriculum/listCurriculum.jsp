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

function fn_lec_menu_display(value){
	
	var reqUrl = "/mm/curriculum/listCurriculum.do";
	var params = value.split("||");
	
	$("#subjectTraningType").val(params[0]);
	$("#yyyy").val(params[1]);
	$("#term").val(params[2]);
	$("#subjectCode").val(params[3]);
	$("#subClass").val(params[4]);
	$("#subjectName").val(params[5]); 
	 
	$("#frmCurriculum").attr("target", "_self");
	$("#frmCurriculum").attr("action", reqUrl);
	$("#frmCurriculum").submit();
	 
}
function fn_traning(weekCnt){
	
	$("#weekCnt").val(weekCnt);
	var reqUrl = "/mm/traning/listTraning.do";
	 
	$("#frmCurriculum").attr("target", "_self");
	$("#frmCurriculum").attr("action", reqUrl);
	$("#frmCurriculum").submit();
	 
}
function fn_activity(weekCnt){
	
	$("#weekCnt").val(weekCnt);
	var reqUrl = "/mm/activity/listActivity.do";
	 
	$("#frmCurriculum").attr("target", "_self");
	$("#frmCurriculum").attr("action", reqUrl);
	$("#frmCurriculum").submit();
	 
}

function fn_online(){
	$("#weekCnt").val(weekCnt);
	var reqUrl = "/mm/curriculum/getCurriculumOnlineStudy.do";
	 
	$("#frmCurriculum").attr("target", "_self");
	$("#frmCurriculum").attr("action", reqUrl);
	$("#frmCurriculum").submit();
}

//--> 
</script>

			<div id="container">

<form name="frmCurriculum" id="frmCurriculum" method="post">

<input type="hidden" name="subjectTraningType" id="subjectTraningType" value="${currProcVO.subjectTraningType}">
<input type="hidden" name="yyyy" id="yyyy" value="${currProcVO.yyyy}">
<input type="hidden" name="term" id="term" value="${currProcVO.term}">
<input type="hidden" name="subjectCode" id="subjectCode" value="${currProcVO.subjectCode}">

<input type="hidden" name="subjectName" id="subjectName" value="${currProcVO.subjectName}">
<input type="hidden" name="subClass" id="subClass" value="${currProcVO.subClass}">
<input type="hidden" name="classId" id="classId" value="${currProcVO.subClass}">
<input type="hidden" name="weekCnt" id ="weekCnt" >
				<ul id="search-area">				
					<li>
						<select id="subjectCodeValue" name="subjectCodeValue" style="margin: 3px 0px; width: 100%;" onchange="javascript:fn_lec_menu_display(this.value);">
							<option value="">개설교과 선택</option>
							
						<c:forEach var="menuProc" items="${listOffJtAunuriSubject}" varStatus="statusProc">
							<option value="${menuProc.subjectTraningType}||${menuProc.year}||${menuProc.term}||${menuProc.subjectCode}||${menuProc.subClass}||${menuProc.subjectName}||${menuProc.subjectType}||${menuProc.onlineType}" <c:if test="${menuProc.year eq currProcVO.yyyy and menuProc.term eq currProcVO.term and menuProc.subjectCode eq currProcVO.subjectCode  and menuProc.subClass eq currProcVO.subClass}">selected</c:if> ><c:if test="${menuProc.onlineType == 'ONLINE'}">[${menuProc.onlineType}]</c:if> ${menuProc.subjectName} ${menuProc.subClass}반</option>
						</c:forEach>
						<c:forEach var="menuProc" items="${listOjtAunuriSubject}" varStatus="statusProc">
							<option value="${menuProc.subjectTraningType}||${menuProc.year}||${menuProc.term}||${menuProc.subjectCode}||${menuProc.subClass}||${menuProc.subjectName}||${menuProc.subjectType}||${menuProc.onlineType}"  <c:if test="${menuProc.year eq currProcVO.yyyy and menuProc.term eq currProcVO.term and menuProc.subjectCode eq currProcVO.subjectCode  and menuProc.subClass eq currProcVO.subClass}">selected</c:if> >${menuProc.subjectName} ${menuProc.subClass}반 </option>
						</c:forEach>							
							
						</select> 
						<a href="#!" class="type-2" onclick="javascript:fn_lec_menu_display($('#subjectCodeValue').val());">검색</a>
					</li>
				</ul><!-- E : search-area -->
</form>				


				<div id="contents-area">
<c:if test="${not empty currProcVO.subjectCode }">
					<h4>
						<p>${currProcVO.subjectName }</p>
						<span> ${currProcVO.yyyy}학년도 ${currProcVO.termName}</span>
					</h4>

					<table class="type-1">
						<colgroup>
							<col width="25%" />
							<col width="*" />
							<col width="20%" />
							<col width="18%" />
						</colgroup>
						<tbody>
							<tr>
								<th>교과형태</th>
								<td>${currProcVO.subjectTraningTypeName }</td>
								<th>과정구분</th>
								<td>${currProcVO.subjectTypeName}</td>
							</tr>
							<tr>
								<th>훈련시간</th>
								<td>${currProcVO.traningHour }시간</td>
								<th>학점</th>
								<td>${currProcVO.point }학점</td>
							</tr>
							<tr>
								<th>온라인 교육형태</th>
								<td> ${currProcVO.onlineTypeName} (성적비율 ${currProcVO.gradeRatio}%)</td> 
								<th>선수여부</th>
								<td>
									${currProcVO.firstStudyYn eq 'Y' ? '필수' : '필수X'}								
								</td>
							</tr>
						</tbody>
					</table>



					<h3>진행율</h3>
					<div class="progress-area">
						<p>전체 진행율 [ 22% : 11 페이지 / 50 페이지 ]</p>
						<progress value="22" max="100"></progress>
					</div>



					<h3>훈련정보</h3>

					<table class="type-2">
						<colgroup>
							<col width="10%" />
							<col width="*" />
							<col width="14%" />
							<col width="14%" />							
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
						</colgroup>
						<thead>
							<th>주차</th>
							<th>훈련일자</th>
							<th>NCS<br />정보</th>
							<th>교육<br />시간</th>
							<th>온라인<br />학습</th>
							<th>훈련<br />일지</th>
							<th>학습<br />활동서</th>
						</thead>
						<tbody>
						<c:set var="tempId" value="xx"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${result.weekCnt}</td>
					<td>${result.traningDate}(${result.dayWeek})<br />${result.traningSt} ~ ${result.traningEd}</td>
					<td class="left">${result.ncsName}</td>
					<td>${result.timeHour}</td>
					<td>
					<!-- 교수 -->
					<c:if test="${loginAuthGroupId eq '2016AUTH0000003'}">
						<c:choose>
							<c:when test="${result.weekMappingCnt ne '0'}">
								${currProcVO.onlineTypeName}<br/><a href="javascript:goWeekLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}',${result.weekProgressRate});" class="btn-full-gray">미리보기</a>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<!-- 학습근로자 -->
					<c:if test="${loginAuthGroupId eq '2016AUTH0000001'}">
						<c:choose>
							<c:when test="${result.weekMappingCnt ne '0'}">
								${currProcVO.onlineTypeName}<br/><p id="weekProgress_${result.weekId}">${result.weekProgressRate}%</p><a href="javascript:goWeekLesson('${result.lessonId}','${result.weekId}','${result.weekCnt}','${result.contentName}',${result.weekProgressRate});" class="btn-full-gray">${result.btnText}</a>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</c:if>
					</td>
					
					<c:set var="btn_traning_Text" />
					<c:set var="btn_activity_Text" />
					<c:choose>
						<c:when test="${result.nowWeekYn eq 'Y'}">
							<c:set var="btn_traning_Text" value="진행" />
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${result.traNoteCnt eq '0'}">
									<c:set var="btn_traning_Text" value="미작성 " />
								</c:when>
								<c:otherwise>
									<c:set var="btn_traning_Text" value="완료" />
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${result.nowWeekYn eq 'Y'}">
							<c:set var="btn_activity_Text" value="진행" />
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${result.actNoteCnt eq result.lessonCnt}">
									<c:set var="btn_activity_Text" value="완료" />
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${loginAuthGroupId eq '2016AUTH0000003'}"><c:set var="btn_activity_Text" value="${result.actNoteCnt} / ${result.lessonCnt}" /></c:when>
										<c:otherwise><c:set var="btn_activity_Text" value="완료" /></c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<td><a href="javascript:fn_traning('${result.weekCnt}');" >${btn_traning_Text}</a></td>
					<td><a href="javascript:fn_activity('${result.weekCnt}');" >${btn_activity_Text}</a></td>
				</tr>
			</c:forEach>
			<c:if test="${empty resultList }">
			<tr>
				<td colspan="6">진행중인 개설교과가 없습니다.</td>
			</tr>
			</c:if>						


						</tbody>
					</table><!-- E : 훈련정보 -->
	

</c:if>
<c:if test="${empty currProcVO.subjectCode }">
					<h4>
						<p>개설교과를 선택하세요.</p>
					
					</h4>
					
</c:if>

				</div><!-- E : contents-area -->
			</div><!-- E : container -->