<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<script type="text/javascript" src="${contextRootJS }/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/jquery/jquery-ui-1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/jquery/plugins/blockUI/jquery.blockUI.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/jquery/jquery.maskedinput.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/common.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/ajaxBase.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/oklms/mobileStudyPreview.js"></script>
<script type="text/javascript">
<!--

var weekId = '${onlineTraningSchVO.weekId}';
var weekCnt = '${onlineTraningSchVO.weekCnt}';
var contentName = '${onlineTraningSchVO.contentName}';

$(document).ready(function(){
	goWeekPreview(weekId,weekCnt,contentName);
});

function fn_list(){
	var reqUrl = "/mm/curriculum/listCurriculum.do";
	$("#frmMovie").attr("target", "_self");
	$("#frmMovie").attr("action", reqUrl);
	$("#frmMovie").submit();
}
//--> 
</script>

<form id="frmMovie" name="frmMovie" method="post">
<input type="hidden" name="yyyy" id="yyyy" value="${onlineTraningSchVO.yyyy}">
<input type="hidden" name="term" id="term" value="${onlineTraningSchVO.term}">
<input type="hidden" name="subjectCode" id="subjectCode" value="${onlineTraningSchVO.subjectCode}">
<input type="hidden" name="subClass" id="subClass" value="${onlineTraningSchVO.subjectClass}">
<input type="hidden" name="classId" id="classId" value="${onlineTraningSchVO.subClass}">
<input type="hidden" name="subjectClass" id="subjectClass" value="${onlineTraningSchVO.subjectClass}">
</form>


<form id="frmLesson" name="frmLesson" method="post">
	<input type="hidden" id="id" name="id" value="" /> 
	<input type="hidden" id="courseContentId" name="courseContentId"/>
	<input type="hidden" id="lessonId" name="lessonId" />
	<input type="hidden" id="lessonItemId" name="lessonItemId" />
	<input type="hidden" id="lessonSubItemId" name="lessonSubItemId" />
	<input type="hidden" id="contentsDir" name="contentsDir" />
	<input type="hidden" id="contentsIdxFile" name="contentsIdxFile" />
	<input type="hidden" id="contentsRealFile" name="contentsRealFile" />
	<input type="hidden" id="weekCnt" name="weekCnt" value="${onlineTraningSchVO.weekCnt}" />
	<input type="hidden" id="weekId" name="weekId" value="${onlineTraningSchVO.weekId}" />
	<input type="hidden" id="subjSchId" name="subjSchId" value="" />
	<input type="hidden" id="stdLessonId" name="stdLessonId" value="" />
	<input type="hidden" id="cmsLessonId" name="cmsLessonId" value="" />
	<input type="hidden" id="cmsLessonItemId" name="cmsLessonItemId" value="" />
	<input type="hidden" id="cmsLessonSubItem" name="cmsLessonSubItem" value="" />
	<input type="hidden" id="linkContentYn" name="linkContentYn" value="" />
	<input type="hidden" id="progressAttendId" name="progressAttendId" value="" />
	<input type="hidden" id="progressTimeId" name="progressTimeId" value="" />
	<input type="hidden" id="pageInfo" name="pageInfo" value="" />
	<input type="hidden" id="viewLessonId" name="viewLessonId" value="" />
	<input type="hidden" id="weekProgressYn" name="weekProgressYn" value="" />
	<input type="hidden" id="spanId" name="spanId" value="" />
	<input type="hidden" id="attendProgress" name="attendProgress" value="${onlineTraningVO.attendProgress}" />
	<input type="hidden" id="cutProgress" name="cutProgress" value="${onlineTraningVO.cutProgress}" />
	<input type="hidden" id="progressAttendTypeCode" name="progressAttendTypeCode" value="${onlineTraningVO.progressAttendTypeCode}" />
</form>

			<div id="leaning-area">
					<div class="movie-zone">
						<div class="wait-img">잠시만 기다려주세요.</div>
						<iframe id="contentFrame" width="100%" height="198px" frameborder="0" allowfullscreen></iframe>
						<div class="movie-control">
							<a href="javascript:prevView();" class="pre">이전</a>
							<span id="contentPage"><b>01</b> / 24</span>
							<a href="javascript:nextView();" class="next">다음</a>
						</div>
					</div><!-- E : movie-zone -->
					
					
					<div class="index-title" id="index-title">${param.subjectName}</div>
					<div class="index-name" id="index-name"></div>
					<!-- <div class="index-title" id="index-title">기전공학 기초설계</div>
					<div class="index-name" id="index-name">[01주차] 01차시 - <b>전기공압의 기초회로</b></div> -->


					<dl class="index-list" id="index-schedule">
						<!-- <dt><span><b>01</b> 주차</span> <b>출석 : ○</b></dt>
						<dd class="highlight">
							<div><a href="#!"><b>[01차시]</b> 전기공압의 기초회로</a></div>
							<ul class="on">
								<li><a href="#!"><span>○</span>과정소개</a></li>
								<li><a href="#!"><span>○</span>학습에 앞서</a></li>
								<li class="current"><a href="#!"><span>○</span>사전지식체크</a></li>
								<li><a href="#!"><span>○</span>시퀀스 제어란?</a></li>
								<li><a href="#!"><span>○</span>전기접점의 종류와 특징</a></li>
							</ul>
						</dd> -->
						


						<!-- <dd>
							<div><a href="#!"><b>[02차시]</b> 타이머 및 카운터회로</a></div>
							<ul>
								<li><a href="#!"><span>○</span>과정소개</a></li>
								<li><a href="#!"><span>○</span>학습에 앞서</a></li>
								<li><a href="#!"><span>○</span>전기접점의 종류와 특징</a></li>
							</ul>
						</dd>



						<dt><span><b>02</b> 주차</span> <b>출석 : △</b></dt>
						<dd>
							<div><a href="#!"><b>[03차시]</b> 전기공압의 기초회로</a></div>
							<ul>
								<li><a href="#!"><span>○</span>과정소개</a></li>
								<li><a href="#!"><span>○</span>학습에 앞서</a></li>
								<li><a href="#!"><span>○</span>전기접점의 종류와 특징</a></li>
							</ul>
						</dd>

						<dd>
							<div><a href="#!"><b>[04차시]</b> 타이머 및 카운터회로</a></div>
							<ul>
								<li><a href="#!"><span>○</span>과정소개</a></li>
								<li><a href="#!"><span>○</span>학습에 앞서</a></li>
								<li><a href="#!"><span>○</span>전기접점의 종류와 특징</a></li>
							</ul>
						</dd>



						<dt><span><b>03</b> 주차</span> <b>출석 : ×</b></dt>
						<dd>
							<div><a href="#!"><b>[05차시]</b> 전기공압의 기초회로</a></div>
							<ul>
								<li><a href="#!"><span>○</span>과정소개</a></li>
								<li><a href="#!"><span>○</span>학습에 앞서</a></li>
								<li><a href="#!"><span>○</span>전기접점의 종류와 특징</a></li>
							</ul>
						</dd>

						<dd>
							<div><a href="#!"><b>[06차시]</b> 타이머 및 카운터회로</a></div>
							<ul>
								<li><a href="#!"><span>○</span>과정소개</a></li>
								<li><a href="#!"><span>○</span>학습에 앞서</a></li>
								<li><a href="#!"><span>○</span>전기접점의 종류와 특징</a></li>
							</ul>
						</dd> -->
					</dl><!-- E : index-list -->
				</div><!-- E : learn-area -->
				
				<div class="btn-area align-center mt-010"><a class="orange" onclick="fn_list();" href="#!">나가기</a></div>
			</div><!-- E : container -->