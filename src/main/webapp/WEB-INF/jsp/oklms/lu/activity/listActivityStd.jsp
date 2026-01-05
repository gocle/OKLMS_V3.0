<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

						<h2>학습활동서</h2>

						<div class="group-area mb-040">
							<div class="group-area-title">
								<h4 class="mb-010"><span>${currProcVO.subjectName } / ${currProcVO.subjectCode }</span> ㅣ ${currProcVO.yyyy}학년도 / ${currProcVO.termName}</h4>

<form:form modelAttribute="frmActivity" name="frmActivity" method="post" enctype="multipart/form-data" >
<%-- <input type="hidden" name="activityNoteId"  value="${result.activityNoteId}" > --%>

<input type="hidden" name="yyyy"  value="${activityVO.yyyy}" >
<input type="hidden" name="term"  value="${activityVO.term}" >
<input type="hidden" name="subjectCode"  value="${activityVO.subjectCode}" >
<input type="hidden" name="classId"  value="${activityVO.classId}" >
<input type="hidden" name="traningType"  value="${activityVO.traningType}" >
<input type="hidden" name="state"  value="${activityVO.state}" >

<c:set var="sumNumber" value="0" />
<c:set var="totalSumNumber" value="0" />  
<c:forEach var="result" items="${resultMember}" varStatus="status">
	<c:set var="sumNumber" value="${result.studyTime + sumNumber }" />
	<c:if test="${result.addyn eq 'N' }"><c:set var="totalSumNumber" value="${result.timeHour + totalSumNumber}" /></c:if>
</c:forEach>

								<p style="padding-left: 100px">
									<label for="searchMonth" class="hidden">월 선택</label>
									<select id="searchMonth" name="searchMonth" >
										<option value="">월 선택</option>
										<option value="01">1월</option>
										<option value="02">2월</option>
										<option value="03">3월</option>
										<option value="04">4월</option>
										<option value="05">5월</option>
										<option value="06">6월</option>
										<option value="07">7월</option>
										<option value="08">8월</option>
										<option value="09">9월</option>
										<option value="10">10월</option>
										<option value="11">11월</option>
										<option value="12">12월</option>
									</select>
									<span class="btn-area" style="display:inline-block; width:inherit;"><a href="#!" class="orange" onclick="javascript:fn_excel()">학습활동서 출력</a></span>
								</p>
							</div>
							
							
							

							
							
							<div class="training-info">
								 <div class="txt-box">
									<dl>
										<dt><label for="weekCnt">주차</label></dt>
										<dd>
											<select id="weekCnt" name="weekCnt"  onchange="javascript:fn_Search();">
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
									
									<c:if test="${currProcVO.subjectTraningType eq 'OJT' }">
									<dl>
										<dt>능력단위</dt>
										<dd>${subjweekStdVO.ncsUnitName}</dd>
									</dl>
									</c:if>
									
									<dl>
										<dt>주간 훈련시간</dt>
										<dd>${totalSumNumber}</dd>
									</dl>
									<c:if test="${currProcVO.subjectTraningType eq 'OJT' }">
									<%-- <dl class="class-cont">
										<dt>능력단위요소</dt>
										<dd>${subjweekStdVO.ncsElemName}</dd>
									</dl> --%>
									</c:if>
									<dl class="class-cont">
										<dt>수업내용</dt>
										<dd>${subjweekStdVO.lessonCn}</dd>
									</dl>
								</div>
							</div>
							
							
							<%-- 
							<table class="type-1-1 mb-030">
								<colgroup>
									<col style="width:60px" />
									<col style="width:150px" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:70px" />
								</colgroup>
								<thead>
									<tr>
										<th>주차</th>
										<th>기간</th>
										<th>능력단위</th>
										<th>능력단위요소</th>
										<th>수업내용</th>
										<th>주간<br />훈련시간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
										<select id="weekCnt" name="weekCnt"  onchange="javascript:fn_Search();">
											<c:forEach var="result" items="${onlineTraningSchVO}" varStatus="status">
											<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq activityVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
											</c:forEach>
										</select>
										</td>
										<td>${subjweekStdVO.traningStDate} ~ ${subjweekStdVO.traningEndDate}</td>
										<td>${subjweekStdVO.ncsUnitName}</td>
										<td>${subjweekStdVO.ncsElemName}</td>
										<td class="left">${subjweekStdVO.contentName}</td>
										<td>${totalSumNumber}</td>
									</tr>
								</tbody>
							</table>
							 --%>


						 <div class="table-responsive mt-030">
							<table class="type-2">
								<caption>이름과학번 실시일자 계획훈련시간 결과훈련시간 성취도 대한 정보 제공</caption>
								<colgroup>
									<col style="width:20%" />
									<col style="width:20%" />
									<col style="width:20%" />
									<col style="width:20%" />
									<col style="width:20%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">이름 (학번)</th>
										<th scope="col">실시일자</th>
										<th scope="col">훈련시간<br />(계획)</th>
										<th scope="col">훈련시간<br />(결과)</th>
										<th scope="col">성취도</th>
									</tr>
								</thead>
								<tbody>
	
								<c:forEach var="result" items="${resultMember}" varStatus="status">
								 
									<tr>
										<c:if test="${status.index eq '0'}"> 
											<td rowspan="${fn:length(resultMember)+1 }">${activityVO.sessionMemName}<br /><c:if test="${!empty activityVO.sessionMemId  }">( ${activityVO.sessionMemId} )</c:if></td>
											<td>${result.traningDate }
												<c:if test="${ !empty result.dayOfWeek }"> (${result.dayOfWeek })</c:if>
											</td>
										</c:if>
										<c:if test="${status.index ne '0'}">
										<td>${result.traningDate } <c:if test="${!empty result.dayOfWeek  }">(${result.dayOfWeek })</c:if></td>
										</c:if>
										<td>
										
										<c:if test="${result.addyn eq 'N' }">${result.timeHour }시간</c:if>
										<c:if test="${result.addyn eq 'Y' }">보강훈련</c:if>
										
										</td>
										<td>
											<c:if test="${!empty result.studyTime}">${result.studyTime }시간</c:if> 																						
										</td>
										<td>																				
										<c:forEach var="i" begin="1" end="${result.achievement}" step="1">
									      <img src="/images/oklms/std/inc/icon_star_on.png" />
									    </c:forEach>
										</td>
									</tr>
									<c:if test="${status.last}"> 
									<tr>
										<td>계</td>
										<td>${totalSumNumber}시간</td>
										<td>${sumNumber}시간</td>
										<td>-</td>
									</tr>
									</c:if>							
								</c:forEach>
	 
								</tbody>
							</table>
						</div>
						<!-- E : 교육시간 -->


</form:form> 

<c:forEach var="result" items="${resultMember}" varStatus="status">			
<form id="frmActivityWrite${status.count }" name="frmActivityWrite${status.count }" method="post" enctype="multipart/form-data" >
<input type="hidden" name="activityNoteId"  value="${result.activityNoteId}" >
<input type="hidden" name="yyyy"  value="${activityVO.yyyy}" >
<input type="hidden" name="term"  value="${activityVO.term}" >
<input type="hidden" name="subjectCode"  value="${activityVO.subjectCode}" >
<input type="hidden" name="classId"  value="${activityVO.classId}" >
<input type="hidden" name="traningType"  value="${activityVO.traningType}" >
<input type="hidden" name="state"  value="${activityVO.state}" >
<input type="hidden" name="weekCnt"  value="${result.weekCnt}" >
<input type="hidden" name="timeId"  value="${result.timeId}" >

				
						<table class="type-write mt-020">
							<caption>학습내용 과제물첨부에 대한 정보 제공</caption>
							<colgroup>
								<col class="wp20" />
								<col class="wp80" />
							</colgroup>
							<tbody>
								<%-- <tr>
									<th>교육내용 (${result.traningDate })</th>
									<td>										
										<p id="tooltip"></p><a href="#!" onmouseover="javascript:showtip('예시 : [ <c:out value="${fn:escapeXml(subjweekStdVO.contentName)}"/>  ]+ ~를 훈련하였습니다.');" onmouseout="javascript:hidetip();" class="checkfile">작성요령</a>
										<input type="text" name="content"  id="content" value="${result.content }"/>
									</td>
								</tr> --%>
								<%-- 
								<tr>
									<th>요청사항</th>
									<td colspan="2" class="left"><input type="text" name="reqContent" id="reqContent"   value="${result.reqContent }" /></td>
								</tr>
								 --%>
								 <tr>
									<th scope="row">학습내용 (${result.traningDate })</th>
									<td ><textarea name="content"  id="content"  rows="8" maxlength="1000" style="border:1px solid #ddd">${result.content }</textarea></td>
								</tr>
								<tr>
									<th scope="row">첨부파일</th>
					
									<td>
																				
									<c:if test="${!empty result.atchFileStr}">
											<a href="javascript:com.downFile('${fn:split(result.atchFileStr, '_')[0]}','${fn:split(result.atchFileStr, '_')[1]}');" class="text-file">${fn:split(result.atchFileStr, '_')[2]}</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a href="javascript:com.deleteFile('${fn:split(result.atchFileStr, '_')[0]}|${fn:split(result.atchFileStr, '_')[1]}', '/lu/activity/listActivityStd.do?weekCnt=${result.weekCnt}');"  class="btn-del">[삭제]</a><br />
									</c:if>					
									<c:if test="${empty result.atchFileStr}">				
										<input type="text" id="atchFiles" name="atchFiles" style="width:50%;" readonly  onchange="fileCheck(this.form.atchFiles)">
										<span>
											<a href="#@" class="checkfile">파일선택</a>
											<input type="file" class="file_input_hidden" name="file-input" id="file-input"  onchange="javascript:document.getElementById('atchFiles').value = this.value" />
										</span>
									</c:if>											
										
										
										
									</td>
								</tr>
								<tr>
									<th scope="row">상태</th>
									<td>
									<c:choose>
										<c:when test="${currProcVO.subjectTraningType eq 'OJT' }">
											<c:choose>
												<c:when test="${result.status eq '1'}"><span class="label gray">승인대기</span></c:when>
												<c:when test="${result.status eq '2'}"><span class="label blue">승인</span></c:when>
												<c:when test="${result.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnActComment"  data-comment="${result.returnComment}" rel="modal:open">반려</a></span></c:when>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:if test="${!empty result.activityNoteId}">
											작성
											</c:if>
											<c:if test="${empty result.activityNoteId}">
											미작성
											</c:if>
										</c:otherwise>
									</c:choose>									
										
									</td>
								</tr>
							</tbody>
						</table><!-- E : 교육정보 -->

</form>						

						<div class="btn-area mt-010">
							<div class="float-right">
							<c:choose>
								<c:when test="${empty result.timeId}">
									<a href="#!" onclick="javascript:alert('시간표 등록 후 등록이 가능합니다.');" class="black">등록</a>
								</c:when>
								<c:otherwise>
									<c:if test="${result.activityNoteId eq null}">
									<a href="#!" onclick="javascript:fn_formSave('frmActivityWrite${status.count}');" class="black">등록</a>
									</c:if>
									<c:if test="${result.activityNoteId ne null}">
										<a href="#!" onclick="javascript:fn_formSave('frmActivityWrite${status.count}');" class="black">수정</a>
									</c:if>
								</c:otherwise>
							</c:choose>
							
							</div>
						</div><!-- E : btn-area -->
	
						
						
						<br/><br/>
</c:forEach>	



</div>	

<script type="text/javascript">
<!--
		/* var tooltip=document.getElementById("tooltip");
		
		function showtip(text) {
			tooltip.innerText=text;
			tooltip.style.display="inline";
		}

		function hidetip() {
			tooltip.style.display="none";
		}

		function movetip() {					
			tooltip.style.pixelTop=event.y+document.body.scrollTop; 
			tooltip.style.pixelLeft=event.x+document.body.scrollLeft-240;		
		}

		document.onmousemove=movetip; */

		$(document).ready(function() {
			 
			$('#file-input').on("change", previewImages);
		});
		
		/* 조회 */
		function fn_Search(){

			var reqUrl =  "/lu/activity/listActivityStd.do";
			$("#frmActivity").attr("target", "_self");
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
			
		}
		
		function fn_excel(){
			if($("#searchMonth").val()==""){
				alert("[월] 선택은 필수항목입니다.");
				$("#searchMonth").focus();
				return;
			} 
			
			var reqUrl = "/lu/activity/excelActivityStd.do";
			$("#frmActivity").attr("action", reqUrl);
			$("#frmActivity").submit();
			
		}
		
		/* HTML Form 신규, 수정 */
		function fn_formSave(formId){
			
			if($("#"+formId+"  #content").val()==""){
				alert("학습내용을 입력해 주세요.");
				$("#"+formId+"  #content").focus(); 
				return;
			}
			
			if(doubleSubmitCheck()) return;
			
			var reqUrl =  "/lu/activity/insertActivityStd.do";
			$("#"+formId).attr("target", "_self");
			$("#"+formId).attr("action", reqUrl);
			$("#"+formId).submit();

		}
		
		function previewImages() { 
			  $("#fileName").val($('#file-input').val());
			  var filesize = 0;
			  if (this.files) {
				  $.each(this.files, readAndPreview);
			  }
			  
			  function readAndPreview(i, file) {
				if (window.FileReader) { // FireFox, Chrome, Opera 확인.
		
				    filesize = filesize + file.size;
					if(filesize > 1000000){ //Checking Sum 1M Size 
						alert("사이즈 1M이상 업로드 할수 없습니다.");
						
						$("#atchFiles").val("");
						
						return false;
					}
				}else{ // safari is not supported FileReader
			        alert('not supported Webbrowser!!');
			    }
			  }
		} 

//-->
</script>