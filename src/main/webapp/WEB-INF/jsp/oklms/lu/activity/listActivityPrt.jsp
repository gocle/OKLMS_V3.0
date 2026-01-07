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

						<%-- <dl id="tab-type">
							<dt class="tab-name-11 on"><a href="#!" onclick="javascript:showTabbtn1();$('#company_0').click();" id="selectTab">개설교과별 결과</a></dt>
							<dd id="tab-content-11" style="display:block;">



								<div class="group-area name-tab-contents">
									<div class="group-area-title">
										<h4><span>${currProcVO.subClass }분반_${currProcVO.subjectName } / ${currProcVO.subjectCode }  </span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
										
										<!--  분반 검색 -->
										<p><a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">개설교과 분반 검색 <i class="xi-search"></i></a></p>
										<!--  분반 모달창 -->
										<div id="learner-wrap_area" class="modal">
											<div class="modal-title">개설교과 분반 검색 </div>
											<div class="modal-body">
												<!--  분반 검색 -->
												<div class="search_box"> 
													<fieldset>
													<legend>게시물 검색</legend>
														<label for="class_searchKeyword" class="hidden">검색어 입력</label>
														<input id="class_searchKeyword" name="searchKeyword" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText"  type="text" value="">    
														<button class="btn btn-black btn-sch" onclick="fn_comOjtClassSearch1();">검색</button> 
													</fieldset>
												 </div>
												
												<!--  분반 검색 결과 및 리스트 -->
												<div id="learner-wrap_box">
													<ul id="learner-wrap" >
														<li id="wrap">
															<!-- 기업수 * 128px의 값을 아래 style width에 넣어줘야함 -->
															<div id="scroller">
																<ul id="class_thelist" class="name-tab-btns">
					
																<c:forEach var="result" items="${companylist}" varStatus="status">
																	<c:if test="${result.classId eq activityVO.classId }">
																		<li class="current"><a href="#!"  id="company_0" onclick="javascript:fn_comp_search('${result.classId }');">${result.classId }분반_${result.companyName }</a></li>
																	</c:if><c:if test="${result.classId ne activityVO.classId}">
																		<li><a href="#!" onclick="javascript:fn_comp_search('${result.classId }');">${result.classId }분반_${result.companyName }</a></li>
																	</c:if>
																</c:forEach>												
																</ul>
															</div>
														</li>
													</ul>
												</div>
											</div>
										</div>
										<!--  //분반 모달창 -->
										<!--  //분반 검색 -->
									</div>
									
									<!-- <span>기전공학기초설계2</span> (02분반_기업명_B) ㅣ 2016학년도 2학기 -->
									<form:form modelAttribute="frmActivity" name="frmActivity" method="post" enctype="multipart/form-data" >
									<input type="hidden" name="activityNoteId"  value="${result.activityNoteId}" >
									
									<input type="hidden" name="yyyy"  value="${activityVO.yyyy}" >
									<input type="hidden" name="term"  value="${activityVO.term}" >
									<input type="hidden" name="subjectCode"  value="${activityVO.subjectCode}" >
									<input type="hidden" name="classId"  id="classId"  value="${activityVO.classId}" >
									<input type="hidden" name="traningType"  value="${activityVO.traningType}" >
									<input type="hidden" name="state"  value="${activityVO.state}" >
									<input type="hidden" name="searchCompanyName" id="searchCompanyNameTemp" value="${activityVO.searchCompanyName }" />
									<input type="hidden" name="searchName" id="searchMemName" value=""/>

	
									<div class="training-info">
										 <div class="txt-box">
											<c:if test="${empty subjweekStdVO.traningStDate}">
											<dl>
												<dt><label for="weekCnt">주차</label></dt>
												<dd>
													<select id="weekCnt" name="weekCnt"  onchange="javascript:fn_Search(this.value);">
														<c:forEach var="result" items="${onlineTraningSchVO}" varStatus="status">
														<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq activityVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
														</c:forEach>
													</select>
												</dd>
												<dt><span class="en">기업현장교사 입력 전 상태입니다.</span></dt>
											</dl>
											</c:if>
											
											<c:if test="${!empty subjweekStdVO.traningStDate}">
											<dl>
												<dt><label for="weekCnt">주차</label></dt>
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
												<dd>${fn:replace(subjweekStdVO.ncsElemName, cn , br )}</dd>
											</dl>
											
											<dl class="class-cont">
												<dt>수업내용</dt>
												<dd>${subjweekStdVO.lessonCn}</dd>
											</dl>
											</c:if>
										</div>
									</div>
									
									 
									<div class="clearfix"></div>
									
									
									<div class="table-responsive mt-030">
									<table class="type-2">
										<caption>분반과 기업명 성명 훈련시간 (계획) 훈련시간 (결과) 학습활동서 과제물 등 정보 제공</caption>
										<colgroup>
											<col style="width:5%" />
											<col style="width:*" />
											<col style="width:10%" />
											<col style="width:10%" />
											<!-- 
											<col style="width:10%" />
											-->
											<col style="width:10%" />
											<col style="width:10%" />
											<col style="width:10%" />
										</colgroup>
										<tr>
											<th scope="col"><label for="checkbox" class="hidden">선택</label><input type="checkbox" name="checkbox" id="checkbox" class="choice" /></th>
											<th scope="col">분반_기업명</th>
											<th scope="col">성명</th>
											<th scope="col">훈련시간 (계획)</th>
											<!-- 
											<th scope="col">훈련일자</th>
											 -->
											<th scope="col">훈련시간 (결과)</th>
											<th scope="col">학습활동서</th>
											<th scope="col">첨부파일</th>
										</tr>
									<c:forEach var="result" items="${memberlist}" varStatus="status1">
									<tr>
										<td><label for="memSeqs" class="hidden">선택</label><input type="checkbox" name="memSeqs"  id="memSeqs" value="${result.memId},${result.atchFileId}"  class="choice" /></td>
										<td class="left">${activityVO.classId }분반_${result.companyName } </td>
										<td><a href="#!" onclick="javascript:showTabbtn2();$('#current_${status1.count}').click();" class="text">${result.memName } </a></td>
										<td>${subjweekStdVO.weekTimeHour}</td>
										<!-- 
										<td>${subjweekStdVO.traningDate}</td>
										-->
										<td>
										<c:if test="${result.studyTime != null and result.studyTime ne '' }">${result.studyTime }</c:if> 		
										</td>
										<td>
											<c:if test="${empty result.content }">
												<a href="#!" class="btn-line-orange">미작성</a>
											</c:if>
											<c:if test="${!empty result.content }">
												<span id="tooltip"></span>
												<a href="#!" onmouseover="showtip('<c:out value="${fn:escapeXml(result.content)}"/>');" onmouseout="hidetip();" class="btn-line-gray">작성</a>
											</c:if>
										</td>
										<td>
											<c:if test="${empty result.atchFileId }">
												
											</c:if>
											<c:if test="${!empty result.atchFileId }">									
												<a  href="#!" onclick="javascript:com.downFile('${result.atchFileId}','1');" class="btn-line-gray">제출</a>
											</c:if>
										</td>
									</tr>									
									</c:forEach>										
									<c:if test="${empty memberlist}">
									<tr>
										<td colspan="7">
											학습근로자가 없습니다.
										</td>
									</tr>
									</c:if> 
									</table>
									</div>
									<!-- E :OJT 학습활동서 -->
									
									</form:form>
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
										function fn_comp_search_search(){
											$("#searchMemName").val($("#searchName").val());
											$("#searchCompanyNameTemp").val($("#searchCompanyName").val());
											var reqUrl =  "/lu/activity/listActivityPrt.do";
											$("#frmActivity").attr("target", "_self");
											$("#frmActivity").attr("action", reqUrl);
											$("#frmActivity").submit();

											
										}										
										function fn_comp_search(classId){
											
											$("#classId").val(classId);
											var reqUrl =  "/lu/activity/listActivityPrt.do";
											$("#frmActivity").attr("target", "_self");
											$("#frmActivity").attr("action", reqUrl);
											$("#frmActivity").submit();
											
										}
 
										/* 조회 */
										function fn_Search(value){
											$("#weekCnt").val(value);
											var reqUrl =  "/lu/activity/listActivityPrt.do";
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
											var reqUrl =  "/lu/activity/downloadActivityPrt.do";
											$("#frmActivity").attr("target", "_self");
											$("#frmActivity").attr("action", reqUrl);
											$("#frmActivity").submit();
										}
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
										
										
										function fn_approval( status ){
											
											var checkedVals = $("input:checkbox[name=activityNoteIds]:checked").length;
											alert(checkedVals);
											if(checkedVals == 0){
												alert("처리 대상을 선택하세요.");
												return;
											}
											
											if( status == "3" ){
												if( $("#comment").val() == "" ){
													alert("반려사유를 입력하세요.");
													$("#comment").focus();
													return;
												}
											} else {
												$("#comment").val("");
											}
											$("#frmAct_returnComment").val($("#comment").val());
											$("#frmAct_status").val(status);
											var reqUrl = "/lu/activity/saveActivity.do";
											$("#frmAct").attr("action", reqUrl);
											$("#frmAct").submit();
										}
										
									</script>


									<div class="clearfix"></div>
									
									<div class="btn-area mt-010">
										<div class="float-right">
											<a href="#!" onclick="javascript:fn_Download();" class="orange">첨부파일 다운로드</a>										
											<a href="#!" onclick="javascript:sms();" class="yellow">SMS 발송</a>
										</div>
									</div><!-- E : btn-area -->
								</div>
 
							</dd> --%>



							<!-- <dt class="tab-name-12"><a href="#!" onclick="javascript:showTabbtn2();">학습근로자별 결과</a></dt>
							<dd id="tab-content-12"> 

								<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
								<script type="text/javascript" src="/js/oklms/iscroll.js"></script> -->
								
								<!--  분반 검색 -->
										
										<!--  분반 모달창 -->
										<div id="learner-wrap_area" class="modal">
											<div class="modal-title">개설교과 분반 검색 </div>
											<div class="modal-body">
												<!--  분반 검색 -->
												<div class="search_box"> 
													<fieldset>
													<legend>게시물 검색</legend>
														<label for="class_searchKeyword" class="hidden">검색어 입력</label>
														<input id="class_searchKeyword" name="searchKeyword" title="검색어 입력" placeholder="검색어를 입력하세요." class="schText"  type="text" value="">    
														<button class="btn btn-black btn-sch" onclick="fn_comOjtClassSearch1();">검색</button> 
													</fieldset>
												 </div>
												
												<!--  분반 검색 결과 및 리스트 -->
												<div id="learner-wrap_box">
													<ul id="learner-wrap" >
														<li id="wrap">
															<!-- 기업수 * 128px의 값을 아래 style width에 넣어줘야함 -->
															<div id="scroller">
																<ul id="class_thelist" class="name-tab-btns">
					
																<c:forEach var="result" items="${companylist}" varStatus="status">
																	<c:if test="${result.classId eq activityVO.classId }">
																		<li class="current"><a href="#!"  id="company_0" onclick="javascript:fn_comp_search('${result.classId }');">${result.classId }분반_${result.companyName }</a></li>
																	</c:if><c:if test="${result.classId ne activityVO.classId}">
																		<li><a href="#!" onclick="javascript:fn_comp_search('${result.classId }');">${result.classId }분반_${result.companyName }</a></li>
																	</c:if>
																</c:forEach>												
																</ul>
															</div>
														</li>
													</ul>
												</div>
											</div>
										</div>
										<!--  //분반 모달창 -->
										<!--  //분반 검색 -->
								
								
								
								<!--  학습자 모달창 -->
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
														<c:forEach var="result" items="${memberlist}" varStatus="status">
															<c:if test="${status.index eq '0' }">
																<li id="current_${status.count}" class="current"><a href="#!" rel="modal:close">${result.memName }</a></li> 
															</c:if>
															<c:if test="${status.index ne '0' }">
																<li id="current_${status.count}" ><a href="#!" rel="modal:close">${result.memName }</a></li> 
															</c:if>
														</c:forEach>									 	
														</ul>
														
													</div>
												</li>
											</ul><!-- E : learner-wrap -->
										</div>
									</div>
								</div>
								<!--  //학습자 모달창 -->
								
								<c:set var="companyName" value=""/>
								<c:forEach var="memberVO" items="${lessonList}" varStatus="status1">
									<c:if test="${status1.count eq '1' }">
										<c:set var="companyName" value="${memberVO.companyName}"/>
									</c:if>
								</c:forEach>
								<div class="group-area-title">
										<h4><span>${currProcVO.subjectName } / ${currProcVO.subjectCode } / (${currProcVO.subClass }반_${subjweekStdVO.companyName})</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>
									
										<!-- <p><a href="#learner-wrap_area1" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">학습자 검색 <i class="xi-search"></i></a></p> -->
									<p><a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">개설교과 분반 검색 <i class="xi-search"></i></a></p>
									</div>

<form:form modelAttribute="frmActivity" name="frmActivity" method="post" enctype="multipart/form-data" >
									<input type="hidden" name="activityNoteId"  value="${result.activityNoteId}" >
									  
									<input type="hidden" name="yyyy"  value="${activityVO.yyyy}" >
									<input type="hidden" name="term"  value="${activityVO.term}" >
									<input type="hidden" name="subjectCode"  value="${activityVO.subjectCode}" >
									<input type="hidden" name="classId"  id="classId"  value="${activityVO.classId}" >
									<input type="hidden" name="traningType"  value="${activityVO.traningType}" >
									<input type="hidden" name="state"  value="${activityVO.state}" >
									<input type="hidden" name="searchCompanyName" id="searchCompanyNameTemp" value="${activityVO.searchCompanyName }" />
									<input type="hidden" name="searchName" id="searchMemName" value=""/>			
									
											<input type="hidden" id="frmAct_status" name="status" value=""/>
											<input type="hidden" id="frmAct_returnComment" name="returnComment" value=""/>	
															
									
								<div class="training-info">
										 <div class="txt-box">
											<dl>
												<dt><label for="weekCnt">주차</label></dt>
												<dd>
													<select   name="weekCnt" id="weekCnt"    onchange="javascript:fn_Search(this.value);">
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
											<dl class="class-cont">
												<dt>학습근로자</dt>
												
												<select  name="searchId" id="searchId"    onchange="javascript:fn_Search1();">
												<option value="" >전체</option>
														<c:forEach var="memberVO" items="${lessonList}" varStatus="status1">
														<option value="${memberVO.memId}" <c:if test="${memberVO.memId eq param.searchId }">selected</c:if>>${memberVO.memName}</option>
														</c:forEach>
													</select>
											</dl>
											<!-- 
											<dl class="class-cont">
												<dt>능력단위요소</dt>
												<dd>${fn:replace(subjweekStdVO.ncsElemName, cn , br )}</dd>
											</dl>
											<dl class="class-cont">
												<dt>수업내용</dt>
												<dd>${subjweekStdVO.lessonCn}</dd>
											</dl>
											 -->
										</div>
									</div>	
						

	

	
								<c:forEach var="memberVO" items="${memberlist}" varStatus="status1">

								<div class="clearfix"></div>
								
								
								
								
								
								<%-- <div class="group-area name-tab-content" id="act_member_area_${status1.count}""> --%>
									
									
																
								   
								   
 									
									<div class="table-responsive mt-030">
										<table class="type-2">
											<caption>이름과학번 실시일자 계획훈련시간 결과훈련시간 성취도 정보제공</caption>
											<colgroup>
												<col style="width:20%" />
												<col style="width:20%" />
												<col style="width:20%" />
												<col style="width:20%" />
												<col style="width:20%" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">이름/학번</th>
													<th scope="col">실시일자</th>
													<th scope="col">훈련시간(계획)</th>
													<th scope="col">훈련시간(결과)</th>
													<th scope="col">성취도</th>
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
												<col style="width:6%" />
												<col style="width:10%" />
												
												<col style="width:*" />
												
												<col style="width:12%" />
												<col style="width:12%" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">선택</th>
													<th scope="col">실시일자</th>
													<th scope="col">교육내용</th>
													
													
													<th scope="col">첨부파일</th>
													
													<th scope="col">상태</th>
												</tr>
											</thead>
											<tbody>
											
												<c:forEach var="result" items="${memberVO.arrActivityVO}" varStatus="status">
													
														<tr>
														<td>
															<label for="activityNoteIds" class="hidden">선택</label>
															<input type="checkbox" id="activityNoteIds" name="activityNoteIds" value="${result.activityNoteId}" ${empty result.activityNoteId ? 'disabled' : ''}  class="choice" />
														</td>
														
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
									<!-- </div> -->
									
								
</c:forEach>
</form:form>		

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
		function fn_comp_search_search(){
			$("#searchMemName").val($("#searchName").val());
			$("#searchCompanyNameTemp").val($("#searchCompanyName").val());
			var reqUrl =  "/lu/activity/listActivityPrt.do";
			$("#frmActivity").attr("target", "_self");
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();

			
		}										
		function fn_comp_search(classId){
			
			$("#classId").val(classId);
			var reqUrl =  "/lu/activity/listActivityPrt.do";
			$("#frmActivity").attr("target", "_self");
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
			
		}

		/* 조회 */
		function fn_Search(value){
			$("#weekCnt").val(value);
			var reqUrl =  "/lu/activity/listActivityPrt.do";
			$("#frmActivity").attr("target", "_self");
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
		}		
		
		/* 조회 */
		function fn_Search1(){
			var reqUrl =  "/lu/activity/listActivityPrt.do";
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
			var reqUrl =  "/lu/activity/downloadActivityPrt.do";
			$("#frmActivity").attr("target", "_self");
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
		}
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
		
		
		function fn_approval( status ){
			
			var checkedVals = $("input:checkbox[name=activityNoteIds]:checked").length;
		
			if(checkedVals == 0){
				alert("처리 대상을 선택하세요.");
				return;
			}
			
			if( status == "3" ){
				if( $("#comment").val() == "" ){
					alert("반려사유를 입력하세요.");
					$("#comment").focus();
					return;
				}
			} else {
				$("#comment").val("");
			}
			$("#frmAct_returnComment").val($("#comment").val());
			$("#frmAct_status").val(status);
			var reqUrl = "/lu/activity/saveActivity.do";
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
		}
		
	</script>


<div class="btn-area  mt-010" >
						<div class="align-right wp100">
							<label for="comment" class="hidden">반려사유입력</label>
							<input type="text" name="comment" id="comment"   class="wp50" placeholder="반려시 반려사유 필수 입력">
							<a href="#" onclick="javascript:fn_approval('3');" class="orange">반려</a>
							<a href="#" onclick="javascript:fn_approval('2');" class="orange">승인</a>
							
							
							<%-- <c:if test="${fn:length(memberlist)>1}">
								<c:if test="${status1.first}" >
									<a href="#!" onclick="javascript:$('#current_${fn:length(memberlist)}').click();" class="gray-1 float-left">&lt; 이전 학생</a>
									<a href="#!" onclick="javascript:$('#current_${status1.count+1}').click();" class="gray-1 float-left">다음 학생 &gt;</a>
								</c:if>
																		
								<c:if test="${!status1.first and !status1.last  }" >
									<a href="#!" onclick="javascript:$('#current_${status1.count-1}').click();" class="gray-1 float-left">&lt; 이전 학생</a>
									<a href="#!" onclick="javascript:$('#current_${status1.count+1}').click();" class="gray-1 float-left">다음 학생 &gt;</a>
								</c:if>
								
								<c:if test="${not status1.first and status1.last }" >
									<a href="#!" onclick="javascript:$('#current_${status1.count-1}').click();" class="gray-1 float-left">&lt; 이전 학생</a>
									<a href="#!" onclick="javascript:$('#current_1').click();" class="gray-1 float-left">다음 학생 &gt;</a>										
								</c:if>
							</c:if> --%> 
								<!-- <a href="#!" onclick="javascript:showTabbtn1();" class="gray-3">목록</a> -->
						</div>
					</div>

<script>
<%--
<c:if test="${!empty param.memId}">
showTabbtn2();
</c:if>
 --%> 
</script>

