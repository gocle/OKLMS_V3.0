<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("br", "<br/>");  //br 태그
      pageContext.setAttribute("cn", "\n"); //Space, Enter
%> 

						<h2>학습활동서</h2>



							
								

								<%-- <div class="table-responsive mt-030">
								<table class="type-2 ">
									<colgroup>
										<col style="width:5%" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:8%" />
										<col style="width:*" />
										<col style="width:8%" />
									</colgroup>
									<tr>
										<th><input type="checkbox" name="checkbox" id="checkbox"  class="choice" /></th>
										<th>성명</th>
										<th>훈련시간 (계획)</th>
										<th>훈련시간 (결과)</th>
										<th>작성여부</th>
										<th>내용</th>
										<th>첨부파일</th>
									</tr>									
									<c:forEach var="result" items="${memberlist}" varStatus="status1">
									<tr>
										<td><input type="checkbox" name="memSeqs" value="${result.memId},${result.atchFileId}"  class="choice" /></td>
										<td><a href="#!"  id="${result.memId}" onclick="javascript:showTabbtn2();$('#current_${status1.count}').click();" class="text">${result.memName } </a></td>
										<td>${subjweekStdVO.weekTimeHour}</td>
										<td>
										<c:if test="${result.studyTime != null and result.studyTime ne '' }">${result.studyTime }</c:if> 		
										</td>
										<td>
											<c:if test="${empty result.content }">
												<a href="#!" class="btn-line-orange">미작성</a>
											</c:if>
											<c:if test="${!empty result.content }">
												<a href="#!"  class="btn-line-gray">작성</a>
											</c:if>
										</td>
										<td>${result.content}</td>
										<td>
											<c:if test="${empty result.atchFileId }">
												<a href="#!" class="btn-line-orange">미제출</a>
											</c:if>
											<c:if test="${!empty result.atchFileId }">									
												<a  href="#!" onclick="javascript:com.downFile('${result.atchFileId}','1');" class="btn-line-gray">제출</a>
											</c:if>
										</td>
									</tr>									
									</c:forEach>

						 
								</table>
								</div> --%><!-- E :OJT 학습활동서 -->
								
								
									<h4 class="mt-020"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode } / ${currProcVO.subClass }반</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
<form:form commandName="frmActivity" name="frmActivity" method="post" >
<input type="hidden" name="activityNoteId"  value="${result.activityNoteId}" >

<input type="hidden" name="yyyy"  value="${activityVO.yyyy}" >
<input type="hidden" name="term"  value="${activityVO.term}" >
<input type="hidden" name="subjectCode"  value="${activityVO.subjectCode}" >
<input type="hidden" name="classId"  value="${activityVO.classId}" >
<input type="hidden" name="traningType"  value="${activityVO.traningType}" >
<input type="hidden" name="state"  value="${activityVO.state}" >

								
								
								<%-- <div class="training-info">
									 <div class="txt-box">
										<dl>
											<dt>주차</dt>
											<dd>
												<select id="weekCnt" name="weekCnt"  onchange="javascript:fn_Search(this.value);">
													<c:forEach var="result" items="${onlineTraningSchVO}" varStatus="status">
													<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq activityVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
													</c:forEach>
												</select>	
											</dd>
										</dl>
										
										<dl>
											<dt>기간</dt>
											<dd>${subjweekStdVO.traningStDate} ~ ${subjweekStdVO.traningEndDate}</dd>
										</dl>
										<dl>
											<dt>능력단위</dt>
											<dd>${subjweekStdVO.ncsUnitName}</dd>
										</dl>
										
										<dl>
											<dt>주간 훈련시간</dt>
											<dd>${subjweekStdVO.weekTimeHour}</dd>
										</dl>
										<dl class="class-cont">
											<dt>능력단위요소</dt>
											<dd>${subjweekStdVO.ncsElemName}</dd>
										</dl>
										<dl class="class-cont">
											<dt>수업내용</dt>
											<dd>${subjweekStdVO.contentName}</dd>
										</dl>
									</div>
								</div> --%>
								
								
								<!-- <div class="btn-area mt-010">
										<div class="float-right">
										<a href="#!" onclick="javascript:fn_Download();" class="orange">첨부파일 다운로드</a>

										<a href="#!" onclick="javascript:sms();" class="yellow">SMS 발송</a>
										<a href="#!" onclick="javascript:email();"class="gray-2">E-MAIL 발송</a> 
										</div>
								</div> --><!-- E : btn-area -->



								<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
								<script type="text/javascript" src="/js/oklms/iscroll.js"></script>
<%-- 
								<ul id="learner-wrap" class="mt-030 mb-010">
									<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
									<li id="wrap">
										<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
										<div id="scroller" style="width:${fn:length(memberlist)*128}px;">
											<ul id="thelist" class="name-tab-btn">											
											<c:forEach var="result" items="${memberlist}" varStatus="status">
												<c:if test="${status.index eq '0' }">
													<li id="current_${status.count}" class="current"><a href="#!">${result.memName }</a></li>
												</c:if><c:if test="${status.index ne '0' }">
													<li id="current_${status.count}" ><a href="#!">${result.memName }</a></li>
												</c:if>
											</c:forEach>											 	
											</ul>
										</div>
									</li>
									<li id="next" onclick="myScroll.scrollToPage('next', 0);return false">next</li>

								</ul><!-- E : learner-wrap -->
 --%>


								<%-- <div class="group-area name-tab-content">
									<div class="group-area-title">
										<h4><span>${currProcVO.subjectName } / ${currProcVO.subjectCode } / ${currProcVO.subClass }반</span>  ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
																	
										<!--  분반 검색 -->
										<p><a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">학습자 검색 <i class="xi-search"></i></a></p>
			
										<!--  분반 모달창 -->
										<div id="learner-wrap_area" class="modal">
											<div class="modal-title">학습근로자 검색 </div>
											<div class="modal-body">
												<!--  분반 검색 -->
												<div class="search_box"> 
													<fieldset>
													<legend>게시물 검색</legend>
														<input id="searchWrd" name="searchWrd" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText" type="text" value="">    
														<button class="btn btn-black btn-sch">검색</button> 
													</fieldset>
												 </div>
												
												<!--  분반 검색 결과 및 리스트 -->
												<div id="learner-wrap_box">
													<ul id="learner-wrap">
														<li id="wrap">
															<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
															<div id="scroller">
																<ul id="thelist" class="name-tab-btn li-w3">											
																<c:forEach var="result" items="${memberlist}" varStatus="status">
																	<c:if test="${status.index eq '0' }">
																		<li id="current_${status.count}" class="current"><a href="#!">${result.memName }</a></li>
																	</c:if><c:if test="${status.index ne '0' }">
																		<li id="current_${status.count}" ><a href="#!">${result.memName }</a></li>
																	</c:if>
																</c:forEach>											 	
																</ul>
															</div>
														</li>
													</ul><!-- E : learner-wrap -->
												</div>
											</div>
										</div>
										<!--  //분반 모달창 -->
										<!--  //분반 검색 -->
									
									</div> --%>
									
									
									
									<div class="training-info">
										 <div class="txt-box">
											<dl>
												<dt>주차</dt>
												<dd>
													<select id="weekCnt" name="weekCnt"   onchange="javascript:fn_Search(this.value);">
														<c:forEach var="result" items="${onlineTraningSchVO}" varStatus="status2">
														<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq activityVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
														</c:forEach>
													</select>
												</dd>
											</dl>
											
											<dl>
												<dt>기간</dt>
												<dd>${subjweekStdVO.traningStDate} ~ ${subjweekStdVO.traningEndDate}</dd>
											</dl>
											<dl>
												<dt>능력단위</dt>
												<dd>${subjweekStdVO.ncsUnitName}</dd>
											</dl>
											
											<dl>
												<dt>주간 훈련시간</dt>
												<dd>${subjweekStdVO.weekTimeHour}</dd>
											</dl>
											<%-- <dl class="class-cont">
												<dt>능력단위요소</dt>
												<dd>${subjweekStdVO.ncsElemName}</dd>
											</dl>
											<dl class="class-cont">
												<dt>수업내용</dt>
												<dd>${subjweekStdVO.contentName}</dd>
											</dl> --%>
										</div>
									</div>
									
									
									
																	
<c:forEach var="memberVO" items="${memberlist}" varStatus="status1">									
									

									<div class="table-responsive mt-030">
										<table class="type-2 ">
											<colgroup>
												<col style="width:20%" />
												<col style="width:20%" />
												<col style="width:20%" />
												<col style="width:20%" />
												<col style="width:20%" />
											</colgroup>
											<thead>
												<tr>
													<th>이름/학번</th>
													<th>실시일자</th>
													<th>훈련시간(계획)</th>
													<th>훈련시간(결과)</th>
													<th>성취도</th>
												</tr>
											</thead>
											<tbody>
											
											
											
								<c:set var="sumNumber" value="0" />
									<c:forEach var="result" items="${memberVO.arrActivityVO}" varStatus="status">
										<c:set var="sumNumber" value="${result.studyTime + sumNumber }" />
										<tr>
											<c:if test="${status.index eq '0'}"> 
												<td rowspan="${fn:length(memberVO.arrActivityVO)+1 }">${memberVO.memName }<br />( ${memberVO.memId } )</td>
												<td>${result.traningDate } (${result.dayOfWeek })</td>
											</c:if>
											<c:if test="${status.index ne '0'}">
											<td class="border-left">${result.traningDate } (${result.dayOfWeek })</td>
											</c:if>
											<td>
											
											<c:if test="${result.addyn eq 'N' }">${result.timeHour }시간</c:if>
											<c:if test="${result.addyn eq 'Y' }">보강훈련</c:if>
											
											</td>
											<td>
												<c:if test="${result.studyTime != null and result.studyTime ne '' }">${result.studyTime }시간</c:if> 																						
											</td>
											<td>																				
											<c:forEach var="i" begin="1" end="${result.achievement}" step="1">
										      <img src="/images/oklms/std/inc/icon_star_on.png" />
										    </c:forEach>
											</td>
										</tr>
										<c:if test="${status.last}"> 
										<tr>
											<td class="border-left">계</td>
											<td>${subjweekStdVO.weekTimeHour}시간</td>
											<td>${sumNumber}시간</td>
											<td>-</td>
										</tr>
										</c:if>							
									</c:forEach>						
												 
										</tbody>
									</table>
									</div>

									<div class="table-responsive mt-020">
										<table class="type-2">
											<caption>선택 교육내용 요청사항 과제물 첨부 성상태취도 정보제공</caption>
											<colgroup>
												<col style="width:10%" />
												<col style="width:*" />
												<!-- 
												<col style="width:*" />
												-->
												<col style="width:12%" />
												<col style="width:12%" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">교육내용</th>
													<th scope="col">실시일자</th>
													<th scope="col">첨부파일</th>
													
													<th scope="col">상태</th>
												</tr>
											</thead>
											<tbody>
											
												<c:forEach var="result" items="${memberVO.arrActivityVO}" varStatus="status">
													
													<tr>
														<td>${result.traningDate } <c:if test="${!empty result.dayOfWeek  }">(${result.dayOfWeek })</c:if></td>
														<c:choose>
															<c:when test="${empty result.activityNoteId}">
															<td colspan="3">등록 내용이 없습니다.</td>
															</c:when>
														
														<c:otherwise>
															<td>${result.content }</td>
															<!-- 
															<td>${result.reqContent }</td>
															 -->
															<td>
															<c:if test="${!empty result.atchFileStr }">
																<a href="#!"  onclick="javascript:com.downFile('${fn:split(result.atchFileStr, '_')[0]}','${fn:split(result.atchFileStr, '_')[1]}');" class="text-file">${fn:split(result.atchFileStr, '_')[2]}</a>&nbsp;&nbsp;&nbsp;									
																<%-- <a  href="#!" onclick="javascript:com.downFile('${fn:split(result.atchFileStr, '_')[0]}','${fn:split(result.atchFileStr, '_')[1]}');" class="btn-full-blue" >저장</a> --%>
															</c:if>
															</td>
															<td>
															<c:choose>
																<c:when test="${result.status eq '1'}"><span class="label gray">승인대기</span></c:when>
																<c:when test="${result.status eq '2'}"><span class="label blue">승인</span></c:when>
																<c:when test="${result.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnActComment"  data-comment="${result.returnComment}" rel="modal:open">반려</a></span></c:when>
															</c:choose>
															</td>
														</c:otherwise>
														</c:choose>
													</tr>	 
												</c:forEach>						
											</tbody>
										</table>
										</div>
</c:forEach>
</form:form>
									<%-- <div class="btn-area mt-010">
										<div class="float-left">
										<c:if test="${status1.first ne status1.last}" >
											<c:if test="${status1.first}" >
												<a href="#!" onclick="javascript:$('#current_${fn:length(memberlist)}').click();" class="gray-1">&lt; 이전 학생</a>
												<a href="#!" onclick="javascript:$('#current_${status1.count+1}').click();" class="gray-1">다음 학생 &gt;</a>
											</c:if>
																					
											<c:if test="${!status1.first and !status1.last  }" >
												<a href="#!" onclick="javascript:$('#current_${status1.count-1}').click();" class="gray-1">&lt; 이전 학생</a>
												<a href="#!" onclick="javascript:$('#current_${status1.count+1}').click();" class="gray-1">다음 학생 &gt;</a>
											</c:if>
											
											<c:if test="${status1.last }" >
												<a href="#!" onclick="javascript:$('#current_${status1.count-1}').click();" class="gray-1">&lt; 이전 학생</a>
												<a href="#!" onclick="javascript:$('#current_1').click();" class="gray-1">다음 학생 &gt;</a>										
											</c:if>
										</c:if>
										</div>
										<div class="float-right">
											<a href="#!" onclick="javascript:showTabbtn1();" class="gray-3">목록</a>
										</div>
									</div> --%><!-- E : btn-area -->
								


<script type="text/javascript">
	$(document).ready(function() {
		$("#checkbox").click(function(){
				
				if($("#checkbox").is(":checked")==true){
					$("input:checkbox[name='memSeqs']").prop("checked",true);
				}else{
					$("input:checkbox[name='memSeqs']").prop("checked",false);
				} 
		});
		<c:if test="${!empty activityVO.memId}">
	 	
		setTimeout(function() { $('#${activityVO.memId}').click();	 }, 1000); 
		</c:if>									
	});
		var tooltip=document.getElementById("tooltip");
		function showtip(text) {
			tooltip.innerText=text;
			tooltip.style.display="inline";
		}

		function hidetip() {
			tooltip.style.display="none";
		}

		function movetip() {
			if(tooltip){
				tooltip.style.pixelTop=event.y+document.body.scrollTop; 
				tooltip.style.pixelLeft=event.x+document.body.scrollLeft-240;											
			}

		}

		document.onmousemove=movetip;
		
		/* 조회 */
		function fn_Search(value){
			$("#weekCnt").val(value);
			var reqUrl =  "/lu/activity/listActivityOt.do";
			$("#frmActivity").attr("target", "_self");
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
		}
		/* 첨부파일다운로드 */
		function fn_Download(){
			if(!$("input:checkbox[name='memSeqs']").is(":checked")){
				alert("다운받을 학습근로자를 선택하세요.");
				return;
			}
			var reqUrl =  "/lu/activity/downloadActivityOt.do";
			$("#frmActivity").attr("target", "_self");
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
		}
		var myScroll;

		function loaded() {
			myScroll = new iScroll('wrap', {
				snap: true,
				momentum: false,
				hScrollbar: false,
			});
		}

		document.addEventListener('DOMContentLoaded', loaded, false);
		
		
		function sms(){
			var obj = document.getElementsByName("memSeqs");
			var temp = 0;
		    var arr_value = "";
		    for(var i = 0; i < obj.length; i++){
		         if(obj[i].checked){
		              arr_value += obj[i].value+",";
		              temp++;
		         }
		    }	
			if(temp==0){
				alert("선택된 대상이 없습니다.");
				return;
			}	  
			fn_send_sms('${activityVO.weekCnt }',arr_value,'${subjweekStdVO.traningEndDate}','AC','');										
		}

		function email(){	
			var obj = document.getElementsByName("memSeqs");
		    var temp = 0;
		    var arr_value = "";
		    for(var i = 0; i < obj.length; i++){
		         if(obj[i].checked){
		              arr_value += obj[i].value+",";
		              temp++;
		         }
		    }
			if(temp==0){
				alert("선택된 대상이 없습니다.");
				return;
			}
			fn_send_mail('${activityVO.weekCnt }',arr_value,'${subjweekStdVO.traningEndDate}','AC','');	
		}
		
	</script>



