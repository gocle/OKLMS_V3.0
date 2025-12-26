<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>



<!doctype html>



<html lang="ko">
	<head>
		<title>OK-LMS</title>
		<link rel="stylesheet" type="text/css" href="/css/oklms/font.css" />
		<script type="text/javascript" src="/js/oklms/webfont.js"></script>
		<script type="text/javascript">
			WebFont.load({
				custom: {
					families: ['nsM' , 'play' , 'nbgM',]
				}
			});
		</script>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
		
		<script type="text/javascript">
			var CONTEXT_ROOT = "";
		</script>
		
		
		<link href= "/css/oklms/default.css" rel="stylesheet" type="text/css" />
		
		

<!-- includeJs -->

  
<script type="text/javascript" src="/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-ui-1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/blockUI/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/jquery/jquery.maskedinput.js"></script>
<script type="text/javascript" src="/js/oklms/popup.js"></script>
<script type="text/javascript" src="/js/oklms/ajaxBase.js"></script>
<script type="text/javascript" src="/js/oklms/message.js"></script>








<script type="text/javascript" src="/js/oklms/jquery-common.js"></script>


 <!-- //includeJs -->
		
<link href="/js/jquery/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" type="text/css">

<c:set var="targetUrl" value="/lu/currproc/"/>
<script type="text/javascript" src="/js/oklms/onlineStudy.js"></script>
<script type="text/javascript" src="/js/oklms/common.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		
		
		/* 온라인 학습 좌측 슬라이드 메뉴 */
		$menuLeft = $('.pushmenu-left');
		$nav_list = $('#nav_list');
		
		var isMobileOrTablet = window.innerWidth <= 1024;
		
		if (!isMobileOrTablet) {
	        $(this).toggleClass('active');
	        $('.play_container').toggleClass('pushmenu-cont-toright');
	        $menuLeft.toggleClass('pushmenu-open');
	    }
		
		$nav_list.click(function() {
			$(this).toggleClass('active');
			$('.play_container').toggleClass('pushmenu-cont-toright');
			$menuLeft.toggleClass('pushmenu-open');
		});
		
		//goWeekScheduleLesson();
	    goWeekLesson();
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
		
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
	
	
	function fn_curriproc(){
		$("#frmLesson").attr("action", "/lu/currproc/listCurrProc.do");
		$("#frmLesson").submit();
	}
	
	function fn_lec_menu_display(subjectTraningType, year, term, subjectCode, subClass, subjectName, subjectType, onlineType){
		endAttend();
		subjectName = encodeURIComponent(subjectName);
		location.href = "/lu/currproc/listCurrProc.do?subjectTraningType="+subjectTraningType+"&year="+year+"&term="+term+"&subjectCode="+subjectCode+"&subjectName="+subjectName+"&subClass="+subClass+"&lecMenuMarkYn=Y&subjectType="+subjectType+"&onlineType="+onlineType;
		/* <a id="a_${menu1.menuId }" href="/lu/currproc/listCurrProc.do?year=${menuProc.year}&term=${menuProc.term}&subjectCode=${menuProc.subjectCode}&subClass=${menuProc.subClass}" >${menuProc.subjectName} ${menuProc.subClass}반</a> */
	}
	
</script>



</head>
	
	
	<body class="bg-w">
	
	
	<form id="frmLesson" name="frmLesson" method="post">
		<input type="hidden" id="id" name="id" value="" /> 
		<input type="hidden" id="courseContentId" name="courseContentId"/>
		<input type="hidden" id="lessonId" name="lessonId" />
		<input type="hidden" id="contentName" name="contentName" />
		<input type="hidden" id="weekProgressRate" name="weekProgressRate" value="${param.weekProgressRate}"/>
		<input type="hidden" id="lessonItemId" name="lessonItemId" />
		<input type="hidden" id="lessonSubItemId" name="lessonSubItemId" />
		<input type="hidden" id="contentsDir" name="contentsDir" />
		<input type="hidden" id="contentsIdxFile" name="contentsIdxFile" />
		<input type="hidden" id="contentsRealFile" name="contentsRealFile" />
		<input type="hidden" id="weekCnt" name="weekCnt" value="${weekCnt}" />
		<input type="hidden" id="weekId" name="weekId" value="${weekId}" />
		<input type="hidden" id="subjSchId" name="subjSchId" value="${subjSchId}" />
		<input type="hidden" id="stdLessonId" name="stdLessonId" value="${lessonId}" />
		<input type="hidden" id="cmsLessonId" name="cmsLessonId" value="" />
		<input type="hidden" id="cmsLessonItemId" name="cmsLessonItemId" value="" />
		<input type="hidden" id="cmsLessonSubItem" name="cmsLessonSubItem" value="" />
		<input type="hidden" id="linkContentYn" name="linkContentYn" value="" />
		<input type="hidden" id="progressAttendId" name="progressAttendId" value="" />
		<input type="hidden" id="progressTimeId" name="progressTimeId" value="" />
		<input type="hidden" id="pageInfo" name="pageInfo" value="" />
		<input type="hidden" id="viewLessonId" name="viewLessonId" value="" />
		<input type="hidden" id="weekProgressYn" name="weekProgressYn" value="N" />
		<input type="hidden" id="spanId" name="spanId" value="" />
		<input type="hidden" id="attendProgress" name="attendProgress" value="${onlineTraningVO.attendProgress}" />
		<input type="hidden" id="cutProgress" name="cutProgress" value="${onlineTraningVO.cutProgress}" />
		<input type="hidden" id="progressAttendTypeCode" name="progressAttendTypeCode" value="${onlineTraningVO.progressAttendTypeCode}" />
		
		<input type="hidden" id="estblYy" name="estblYy" value="${subjectVO.estblYy}" />
		<input type="hidden" id="estblSemstrCd" name="estblSemstrCd" value="${subjectVO.estblSemstrCd}" />
		<input type="hidden" id="courseNo" name="courseNo" value="${subjectVO.courseNo}" />
		<input type="hidden" id="partitnClasSeCd" name="partitnClasSeCd" value="${subjectVO.partitnClasSeCd}" />
		
		<input type="hidden" id="yyyy" name="yyyy" value="${subjectVO.yyyy}" />
		<input type="hidden" id="term" name="term" value="${subjectVO.term}" />
		<input type="hidden" id="subjectCode" name="subjectCode" value="${subjectVO.subjectCode}" />
		<input type="hidden" id="subjectClass" name="subjectClass" value="${subjectVO.subjectClass}" />
		
	
	</form>
	
	
	<div id="wrapper" class="learning-wrap">
		
		<header class="header">
			<div class="logo_wrap">
				<h1 class="logo"><img src="/images/oklms/std/inc/logo2.png" alt="한국기술교육대학교"></h1>
			</div>
			
			<h2 class="online-subject">${subjectVO.subjectName}</h2>
			<div id="nav_list"><i class="xi-bars"></i><span class="text">목차보기</span></div>
			<a id="viewAllmenu" href="javascript:fn_lec_menu_display('${subjectVO.subjectTraningType}','${subjectVO.yyyy}','${subjectVO.term}','${subjectVO.subjectCode}','${subjectVO.subjectClass}','${subjectVO.subjectName}','${subjectVO.subjectType}','${subjectVO.onlineType}');"><i class="xi-close-thin"></i><span class="text">나가기</span></a>
			
			
			<div class="location">
                <div class="inner">
					<p><span class="week-title">[${weekCnt}주자] ${subjStep}차시 - ${subjTitle}</span><!-- <span class="week-line"></span> --><!-- <span class="week-stitle"></span> --></p>
				</div>               
   				</div>
		</header>	
		
		  
		<div class="learning-cont">
			<nav class="pushmenu pushmenu-left">
				<div class="week-check">
					<span class="week" id="lesson_week">1주차</span>
					<span class="check" id="lesson_check">출석 : ○</span>
				</div>
				
				<h3>[${subjStep}차시] ${subjTitle}</h3>
				<ul class="links">
				   <!-- <li><a href="#" class="on"><span><i class="icon-circle1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-triangle1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-triangle1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-triangle1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li>
				   <li><a href="#"><span><i class="icon-none1"></i></span>$차시_서브강좌재목</a> </li> -->
				</ul>
				
				
				<div class="ex-box">
					<ul>
						<li class="icon-circle">출석인정 진도율 이상</li>
						<li class="icon-triangle">지각인정 진도율 이상<br />출석인정 진도율 미만</li>
						<li class="icon-none">지각인정 진도율 미만</li>
					</ul>
				</div>
			</nav>
		  
		
	    	<div class="play_container">
		    	<div class="movie-cont">
		      		<div class="inner" style="text-align: center;">
		      			<iframe id="contentFrame" class="inner" width="100%" height="auto" frameborder="0"  allowfullscreen="" allowtransparency="true" title="movie-cont"></iframe>
		      			<!--<iframe src="" id="contentFrame" class="inner" width="100%" height="760px" frameborder="0" scrolling="no" allowfullscreen="" allowtransparency="true" style="float: none; margin: 0px auto; display: block; height: 740px;"></iframe>-->
		      		</div>    
		    	</div>
		    	
		    	<div class="buttonset">
		           <ul class="nav-btn"> 
		           		<li class="prev"><a href="javascript:prevView();">이전</a> </li> 
		           		<li class="active" id="contentPage"><!-- <span class="orange_text">2</span>/ <span>9</span> --></li> 
		           		<li class="next"><a href="javascript:nextView();">다음</a> </li>
		           </ul> 
		        </div>
	        </div>
		
		</div>
	
	</div><!-- wrapper -->
</body>
</html>
	
					

	