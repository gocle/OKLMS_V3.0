<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/popupApi.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/onlineStudyPreview.js"></script>
<script type="text/javascript">
<!--

var jsonObj  =  eval('${lms:objectToJson(popupList)}');
var pSubjectTraningType = "${param.subjectTraningType}";
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
function fn_searchDay(day){
	var reqUrl = "/lu/main/lmsUserMainPage.do";
	$("#nowDay").val(day);
	$("#frmMainPage").attr("action", reqUrl);
	$("#frmMainPage").submit();	
}

function goWeekLessonSubmit(lessonId,weekId,weekCnt,contentName,weekProgressRate ,attendProgress, cutProgress,progressAttendTypeCode){

	$("#attendProgress").val(attendProgress);
	$("#cutProgress").val(cutProgress);
	$("#progressAttendTypeCode").val(progressAttendTypeCode);
	goWeekLessonPreview(weekId,weekCnt,contentName);

}

function fn_setTraning(subjectTraningType){
	$("#subjectTraningType").val(subjectTraningType);
}

//-->
</script>

<form id="frmLesson" name="frmLesson" method="post">
	<input type="hidden" id="id" name="id" value="" /> 
	<input type="hidden" id="courseContentId" name="courseContentId"/>
	<input type="hidden" id="lessonId" name="lessonId" />
	<input type="hidden" id="lessonItemId" name="lessonItemId" />
	<input type="hidden" id="lessonSubItemId" name="lessonSubItemId" />
	<input type="hidden" id="contentsDir" name="contentsDir" />
	<input type="hidden" id="contentsIdxFile" name="contentsIdxFile" />
	<input type="hidden" id="contentsRealFile" name="contentsRealFile" />
	<input type="hidden" id="weekCnt" name="weekCnt" value="" />
	<input type="hidden" id="weekId" name="weekId" value="" />
	<input type="hidden" id="subjSchId" name="subjSchId" value="" />
	<input type="hidden" id="cmsLessonId" name="cmsLessonId" value="" />
	<input type="hidden" id="cmsLessonItemId" name="cmsLessonItemId" value="" />
	<input type="hidden" id="cmsLessonSubItem" name="cmsLessonSubItem" value="" />
	<input type="hidden" id="linkContentYn" name="linkContentYn" value="" />
	<input type="hidden" id="progressAttendId" name="progressAttendId" value="" />
	<input type="hidden" id="progressTimeId" name="progressTimeId" value="" />
	<input type="hidden" id="pageInfo" name="pageInfo" value="" />
	<input type="hidden" id="viewLessonId" name="viewLessonId" value="" />
	<input type="hidden" id="spanId" name="spanId" value="" />
	<input type="hidden" id="attendProgress" name="attendProgress" value="" />
	<input type="hidden" id="cutProgress" name="cutProgress" value="" />
	<input type="hidden" id="progressAttendTypeCode" name="progressAttendTypeCode" value="" />
	<input type="hidden" id="classId" name="classId" value="" />
	<input type="hidden" id="companyId" name="companyId" value="" />
</form>


<form name="frmMainPage" id="frmMainPage" method="post">
<input type="hidden" name="nowDay" id="nowDay" >
<input type="hidden" name="subjectTraningType" id="subjectTraningType" value="${param.subjectTraningType}" >

	<!-- 담당교수 -->
	<%-- 
	<div class="half-left-area">
		<h3>TODAY</h3>
		<div class="row-area">
			<div class="col-4">
				<div class="card p-3">
					<div class="stamp-area">
						<span class="stamp mr-3">
							<i class="xi-file-text-o"></i>
						</span>
						<p>훈련일지 작성</p>
					</div>
					
					<div class="job-num">
						<b><a href="/lu/today/lmsUserTodayPage.do#f_1">${readTodayCnt[0].myPageTodayCnt1} <small>건</small></a></b>
					</div>
				</div>
			</div>
			<div class="col-4">
				<div class="card p-3">
					<div class="stamp-area">
						<span class="stamp mr-3">
							<i class="xi-help-o"></i>
						</span>
						<p>Q&A</p>
					</div>
					<div class="job-num"><b><a href="/lu/today/lmsUserTodayPage.do#f_33">${readTodayCnt[0].myPageTodayCnt3} <small>건</small></a></b></div>
				</div>
			</div>
			<div class="col-4">
				<div class="card p-3">
					<div class="stamp-area">
						<span class="stamp mr-3">
							<i class="xi-file-check-o"></i>
						</span>
						<p>과제 확인</p>
					</div>
					<div class="job-num"><b><a href="/lu/today/lmsUserTodayPage.do#f_4">${readTodayCnt[0].myPageTodayCnt4} <small>건</small></a></b></div>
				</div>
			</div>
			<div class="col-4">
				<div class="card p-3">
					<div class="stamp-area">
						<span class="stamp mr-3">
							<i class="xi-users-o"></i>
						</span>
						<p>팀프로젝트 확인</p>
					</div>
					<div class="job-num"><b><a href="/lu/today/lmsUserTodayPage.do#f_5">${readTodayCnt[0].myPageTodayCnt5} <small>건</small></a></b></div>
				</div>
			</div>
		</div>
	 	--%>
		<%-- 
		<table class="type-3" style="table-layout:fixed;">
			<colgroup>
				<col width="20%" />
				<col width="23%" />
				<col width="14%" />
				<col width="20%" />
				<col width="23%" />
			</colgroup>
			<thead>
				<tr>
					<th>훈련일지<br />작성</th>
					<!-- <th>학습활동서<br />확인</th> -->
					<th>Q&A</th>
					<th>과제<br />확인</th>
					<th>팀프로젝트<br />확인</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_1"><span>${readTodayCnt[0].myPageTodayCnt1}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_2"><span>${readTodayCnt[0].myPageTodayCnt2}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_33"><span>${readTodayCnt[0].myPageTodayCnt3}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_4"><span>${readTodayCnt[0].myPageTodayCnt4}</span></a>건</td>
					<td><a href="/lu/today/lmsUserTodayPage.do#f_5"><span>${readTodayCnt[0].myPageTodayCnt5}</span></a>건</td>
				</tr>
			</tbody>
		</table> 
	</div>
	--%>
	
	<!-- Off-JT 2회 이상 결석자 -->
	<div class="half-left-area">
		<h3>Off-JT 2회 이상 결석자</h3>
		<div class="table-responsive scroll-height03">
			<table class="type-3">
				<caption>Off-JT 2회 이상 결석자 학년, 교과목, 학습근로자, 결석, 연락처 제공</caption>
				<colgroup>
					<col width="8%" />
					<col width="12%" />
					<col width="*" />
					<col width="15%" />
					<col width="8%" />
					<col width="25%" />
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
							<td>
							
							<c:choose>
								<c:when test="${result.outYn eq 'Y'}">
									<font color="red">${result.memName }</font> 
								</c:when>
								<c:otherwise>
									${result.memName }
								</c:otherwise>
							</c:choose>
							
							</td>
							<td><span class="label orange">${result.cutCnt}</span></td>
							<td>${result.hpNo}</td>
						</tr>
					 </c:forEach>
					  -->
				</tbody>
			</table>
		</div>
	</div>
	<!-- //Off-JT 2회 이상 결석자 -->
	
	<!-- 공지사항 -->
	<div class="half-right-area">
		<h3 class="notice-tit">
			공지사항
			<a href="#!" onclick="fn_board_list('BBSMSTR_000000000000');" title="더 보기"><i class="xi-plus"></i><span class="hidden">공지사항 더보기</span></a>
		</h3>
		<div class="scroll-height03">
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
	<!-- //공지사항 -->

	<div class="clearfix"></div>
	
	<!-- 강의일정 -->
	<div class="full-area">
		<h3>강의목록</h3>
		<div class="lecture-date">
			<ul>
				<!--  Off-JT -->
				<li>
					<div class="lecture-title">
						<strong class="tit"><i class="xi-label"></i> Off-JT</strong>
					</div>
					<div class="lecture-box">
						<ul class="lecture-list">
							<c:forEach var="offListSchedule" items="${offListSchedule}" varStatus="status">
							<!-- loop -->
							<li>
								<a href="#!" onclick="javascript:fn_lec_menu_display('${offListSchedule.subjectTraningType}','${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.subjectType}','${offListSchedule.onlineType}');">
									<div  class="text_wrap">
										<%-- <div class="level-area">
											<span class="level">${offListSchedule.subjectName}(${offListSchedule.subjectCode})</span>
											<!-- <span class="level">홍길동팀장</span> -->
										</div> --%>
										<p class="title">${offListSchedule.subjectName}(${offListSchedule.subjectCode})</p>
										<%-- <p class="title">${offListSchedule.traningStHour}:${offListSchedule.traningStMin} ~ ${offListSchedule.traningEdHour}:${offListSchedule.traningEdMin}</p> --%>
										<ul class="text_left">
											<li>대상학년 - ${offListSchedule.schoolYear}학년 / 분반 - ${offListSchedule.subClass}</li>
											<%-- <li>주차 : ${offListSchedule.weekCnt} / ${offListSchedule.maxWeekCnt}</li> --%>
										</ul>
										<div class="clearfix"></div>
									</div>
									<button type="button" class="btn-show-over" onclick="javascript:fn_lec_menu_display('${offListSchedule.subjectTraningType}','${offListSchedule.yyyy}','${offListSchedule.term}','${offListSchedule.subjectCode}','${offListSchedule.subClass}','${offListSchedule.subjectName}','${offListSchedule.subjectType}','${offListSchedule.onlineType}');" title="상세보기"><i class="xi-plus-thin"></i></button>
								</a>
							</li>
							<!-- //loop -->
							</c:forEach>
							
							<!-- loop -->
							<!-- <li>
								<a href="">
									<div  class="text_wrap">
										<div class="level-area">
											<span class="level">생활과 화학(TAm160-01)</span>
											<span class="level">홍길동팀장</span>
										</div>
										<p class="title"><span class="time">8시간</span> 1차시 01.Orientation, Science and the Environment</p>
										<ul class="text_left">
											<li>대상학년 - 2학년 / 분반 - 2</span>
											<li>(주)코아아이티</li>
											<li>주차 : 5/5</li>
										</ul>
										<div class="clearfix"></div>
									</div>
									<button type="button" class="btn-show-over " title="상세보기"><i class="xi-plus-thin"></i></button>
								</a>
							</li> -->
							<!-- //loop -->
							<c:if test="${ empty offListSchedule}">
							<li class="align-center">
								강의일정이 없습니다.
							</li>
							</c:if>
						</ul>
					</div>
				</li>
				<!--  //Off-JT -->
				
				<!--  ojt -->
				<li>
					<div class="lecture-title">
						<strong class="tit"><i class="xi-label"></i> OJT</strong>

						 <div class="payment-area">
	                        <div class="box-row valign-middle">
	                            <div class="box-cell payment">승인대기</div>
	                            <div class="box-cell">OJT훈련일지 <span> 
	                            <c:choose>
	                            	<c:when test="${empty noteApplovalCnt or noteApplovalCnt eq '0'}">
	                            		0건
	                            	</c:when>
	                            	<c:otherwise>
	                            		<a href="/lu/apploval/listApproval.do?noteSearchStatus=1"><font style="color: #76000">${noteApplovalCnt}건</font></a>
	                            	</c:otherwise>
	                            </c:choose>
	                            </span></div>
	                            <div class="box-cell">OJT학습활동서  <span> 
	                            <c:choose>
	                            	<c:when test="${empty actApplovalCnt or actApplovalCnt eq '0'}">
	                            		0건
	                            	</c:when>
	                            	<c:otherwise>
	                            		<a href="/lu/apploval/listApproval.do?actSearchStatus=1"><font style="color: #76000">${actApplovalCnt}건</font></a>
	                            	</c:otherwise>
	                            </c:choose>
	                            
	                            </span></div>
	                        </div>
	                    </div>
						<%-- <div class="daily-schedule">
							<a href="#!" class="btn-pre" onclick="javascript:fn_searchDay('${yesDay}');" >이전</a> ${nowDay} <c:if test="${not empty nowDayName }"> (${nowDayName })</c:if><a href="#!"  onclick="javascript:fn_searchDay('${tomDay}');"  class="btn-next">다음</a>
						</div> --%>
					</div>
					<div class="lecture-box">
						<ul class="lecture-list">
							<!-- loop -->
							 <c:forEach var="ojtListSchedule" items="${ojtListSchedule}" varStatus="status">
							<li>
								<a href="#!" onclick="javascript:fn_lec_menu_display('${ojtListSchedule.subjectTraningType}','${ojtListSchedule.yyyy}','${ojtListSchedule.term}','${ojtListSchedule.subjectCode}','${ojtListSchedule.subClass}','${ojtListSchedule.subjectName}','${ojtListSchedule.subjectType}','${ojtListSchedule.onlineType}');" >	
									<div  class="text_wrap">
										<%-- <div class="level-area">
											<span class="level">${ojtListSchedule.subjectName}(${ojtListSchedule.subjectCode})</span>
										</div> --%>
										<p class="title">${ojtListSchedule.subjectName}(${ojtListSchedule.subjectCode})</p>
										<%-- <p class="title">${ojtListSchedule.traningStHour}:${ojtListSchedule.traningStMin} ~ ${ojtListSchedule.traningEdHour}:${ojtListSchedule.traningEdMin}</p> --%>
										<%-- <ul class="text_left">
											<li>대상학년 - ${ojtListSchedule.schoolYear}학년 / 분반 - ${ojtListSchedule.subClass}</li>
											<li>주차 : ${ojtListSchedule.weekCnt} / ${ojtListSchedule.maxWeekCnt}</li>
										</ul> --%>
										<div class="clearfix"></div>
									</div>
									<button type="button" class="btn-show-over " onclick="javascript:fn_lec_menu_display('${ojtListSchedule.subjectTraningType}','${ojtListSchedule.yyyy}','${ojtListSchedule.term}','${ojtListSchedule.subjectCode}','${ojtListSchedule.subClass}','${ojtListSchedule.subjectName}','${ojtListSchedule.subjectType}','${ojtListSchedule.onlineType}');" title="상세보기"><i class="xi-plus-thin"></i></button>
								</a>
							</li>
							<!-- //loop -->
							</c:forEach>
							
							<!-- loop -->
							<!-- <li>
								<a href="">
									<div  class="text_wrap">
										<div class="level-area">
											<span class="level">생활과 화학(TAm160-01)</span>
											<span class="level">홍길동팀장</span>
										</div>
										<p class="title"><span class="time">8시간</span> 1차시 01.Orientation, Science and the Environment</p>
										<ul class="text_left">
											<li>대상학년 - 2학년 / 분반 - 2</span>
											<li>(주)코아아이티</li>
											<li>주차 : 5/5</li>
										</ul>
										<div class="clearfix"></div>
									</div>
									<button type="button" class="btn-show-over " title="상세보기"><i class="xi-plus-thin"></i></button>
								</a>
							</li> -->
							<!-- //loop -->
							<c:if test="${ empty ojtListSchedule}">
							<li class="align-center">
								강의일정이 없습니다.
							</li>
							</c:if>
						</ul>
					</div>
				</li>
				<!--  //ojt -->
			</ul>
		</div> 
	</div>	
	<!-- //강의일정 -->
	
	<!-- OJT 훈련일지  -->
	<!-- <div class="half-left-area mt-040">
		<h3>OJT 훈련일지</h3>
		<div class="box2">
			<ul class="training_list">
					<li>
						<div class="form_wrap">
							<input class="form-check-input"  type="checkbox" name="" id="" />
						</div>
						<div class="text_wrap">
							<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
							<ul class="text_left">
								<li>분반 : 2</span>
								<li>(주)코아아이티</li>
								<li>주차 : 5/5</li>
								<li>(기업특화)제도기본-유족</li>
							</ul>
							<div class="clearfix"></div>
							<div class="box07 mt-010">
								총평
							</div>
						</div>
					</li>
					
					<li>
						<div class="form_wrap">
							<input class="form-check-input"  type="checkbox" name="" id="" />
						</div>
						<div class="text_wrap">
							<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
							<ul class="text_left">
								<li>분반 : 2</span>
								<li>(주)코아아이티</li>
								<li>주차 : 5/5</li>
								<li>(기업특화)제도기본-유족</li>
							</ul>
							<div class="clearfix"></div>
							<div class="box07 mt-010">
								총평
							</div>
						</div>
					</li>
				</ul>
				
				<div class="btn-area mt-010">
					<div class="float-right">
						<a href="" class="btn btn-black">승인</a>
					</div>
				</div>
		</div>
	</div> -->
	<!-- //OJT 훈련일지  -->
	
	<!-- OJT 학습활동서  -->	
	<!-- <div class="half-right-area mt-040">
		<h3 class="notice-tit">OJT 학습활동서</h3>
		<div class="box2">
			<ul class="training_list">
					<li>
						<div class="form_wrap">
							<input class="form-check-input"  type="checkbox" name="" id="" />
						</div>
						<div class="text_wrap">
							<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
							<ul class="text_left">
								<li>분반 : 2</span>
								<li>(주)코아아이티</li>
								<li>주차 : 5/5</li>
								<li>(기업특화)제도기본-유족</li>
								<li>김필요</li>
							</ul>
							<div class="clearfix"></div>
							<div class="box07 mt-010">
								내용
							</div>
						</div>
					</li>
					
					<li>
						<div class="form_wrap">
							<input class="form-check-input"  type="checkbox" name="" id="" />
						</div>
						<div class="text_wrap">
							<strong class="title"><a href="#!" >1차시 01.Orientation, Science and the Environment</a></strong>
							<ul class="text_left">
								<li>분반 : 2</span>
								<li>(주)코아아이티</li>
								<li>주차 : 5/5</li>
								<li>(기업특화)제도기본-유족</li>
								<li>김필요</li>
							</ul>
							<div class="clearfix"></div>
							<div class="box07 mt-010">
								내용
							</div>
						</div>
					</li>
				</ul>
				
				<div class="btn-area mt-010 ">
					<div class="float-right">
						<a href="" class="btn btn-black">승인</a>
					</div>
				</div>
		</div>
	</div> -->
	<!-- //OJT 학습활동서  -->	
</form>
