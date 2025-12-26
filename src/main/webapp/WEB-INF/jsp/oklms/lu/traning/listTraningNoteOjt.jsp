<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
 <%
     //치환 변수 선언합니다.
      pageContext.setAttribute("br", "<br/>");  //br 태그
      pageContext.setAttribute("cn", "\n"); //Space, Enter
%> 

<h2>훈련일지</h2>
<script type="text/javascript" src="/js/oklms/ui_tab.js"></script>
<script type="text/javascript" src="/js/oklms/iscroll.js"></script>
						

<script type="text/javascript">
<!--
 

function fn_search(classId,companyId){
	
	$("#classId").val(classId);
	$("#companyId").val(companyId);
	
	var reqUrl = "/lu/traning/listTraningNote.do";
 
	$("#frmTraning").attr("target", "_self");
	$("#frmTraning").attr("action", reqUrl);
	$("#frmTraning").submit();

}
var myScroll;

function loaded() {
	myScroll = new iScroll('wrap', {
		snap: true,
		momentum: false,
		hScrollbar: false,
	});
}

function fn_approval( status ){
	
	var checkedVals = $("input:checkbox[name=traniningNoteMasterIds]:checked").length;
	
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
	$("#returnComment").val($("#comment").val());
	$("#status").val(status);
	var reqUrl = "/lu/traning/saveTraningNote.do";
	$("#frmTraning").attr("action", reqUrl);
	$("#frmTraning").submit();
}

document.addEventListener('DOMContentLoaded', loaded, false);

function fn_subj_main(subjectTraningType, year, term, subjectCode, subClass, subjectName, subjectType, onlineType){
	subjectName = encodeURIComponent(subjectName);
	location.href = "/lu/currproc/listCurrProc.do?subjectTraningType="+subjectTraningType+"&year="+year+"&term="+term+"&subjectCode="+subjectCode+"&subjectName="+subjectName+"&subClass="+subClass+"&lecMenuMarkYn=Y&subjectType="+subjectType+"&onlineType="+onlineType;
}

//--> 
</script>
<c:set var="tempCompany" value=""/>
<c:set var="tempClass" value=""/>
<c:set var="prevCompany" value=""/>
<c:set var="prevClass" value=""/>
<c:set var="nextCompany" value=""/>
<c:set var="nextClass" value=""/>
			<%-- 
			<ul id="learner-wrap" class="mb-010">
				<li id="prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</li>
				<li id="wrap">
					<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
					<div id="scroller" style="width:${fn:length(subjectNameList)*128}px;">
						<ul id="thelist" class="name-tab-btn">
						<c:forEach var="result" items="${subjectNameList}" varStatus="status">
							<li <c:if test="${ result.classId eq TraningNoteVO.classId }">  class="current" </c:if> >
								<a href="#!" onclick="javascript:fn_search('${result.classId}','${result.companyId }')">${result.classId}분반_${result.companyName }</a>
							</li>

							<c:if test="${result.companyId eq TraningNoteVO.companyId }">
								<c:set var="prevCompany" value="${tempCompany}"/>
								<c:set var="prevClass" value="${tempClass }"/>
								
								<c:if test="${status.first}">
									<c:set var="prevCompany" value="${subjectNameList[0].companyId }"/>
									<c:set var="prevClass" value="${subjectNameList[0].classId}"/>
								</c:if>	
								<c:if test="${!status.last}">
									<c:set var="nextCompany" value="${subjectNameList[status.index+1].companyId}"/>
									<c:set var="nextClass" value="${subjectNameList[status.index+1].classId}"/>
								</c:if>
								<c:if test="${status.last}">
									<c:set var="nextCompany" value="${subjectNameList[0].companyId }"/>
									<c:set var="nextClass" value="${subjectNameList[0].classId}"/>
								</c:if>											
							</c:if>
							<c:if test="${empty prevCompany }">
								<c:set var="tempCompany" value="${result.companyId }"/>
								<c:set var="tempClass" value="${result.classId}"/>									
							</c:if>		

							
						</c:forEach>
						</ul>
					</div>
				</li>
				<li id="next" onclick="myScroll.scrollToPage('next', 0);return false">next</li>
			</ul><!-- E : learner-wrap -->
			 --%>
			 
			<div class="group-area name-tab-content">
				<div class="group-area-title">
					<h4><span>${TraningNoteVO.subjectName} / ${TraningNoteVO.subjectCode }</span> (${TraningNoteVO.classId }분반_${TraningNoteVO.companyName}) ㅣ ${TraningNoteVO.yyyy}학년도 ${TraningNoteVO.termName} </h4>
										
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
									<label for="class_searchKeyword" class="hidden">검색</label>
									<input id="class_searchKeyword" name="searchKeyword" title="검색어 입력" placeholder="검색어를 입력하세요."  class="schText" type="text" value="">    
									<button class="btn btn-black btn-sch" onclick="fn_comOjtClassSearch();">검색</button> 
								</fieldset>
							 </div>
							
							<!--  분반 검색 결과 및 리스트 -->
							<div id="learner-wrap_box">
								<ul id="learner-wrap" >
									<li id="wrap">
										<!-- 학습자수 * 128px의 값을 아래 style width에 넣어줘야함 -->
										<div id="scroller" style="width:${fn:length(subjectNameList)*128}px;">
											<ul id="thelist" class="name-tab-btn">
											<c:forEach var="result" items="${subjectNameList}" varStatus="status">
												<li <c:if test="${ result.classId eq TraningNoteVO.classId }">  class="current" </c:if> >
													<a href="#!" onclick="javascript:fn_search('${result.classId}','${result.companyId }')">${result.classId}분반_${result.companyName }</a>
												</li>
		
												<c:if test="${result.companyId eq TraningNoteVO.companyId }">
													<c:set var="prevCompany" value="${tempCompany}"/>
													<c:set var="prevClass" value="${tempClass }"/>
													
													<c:if test="${status.first}">
														<c:set var="prevCompany" value="${subjectNameList[0].companyId }"/>
														<c:set var="prevClass" value="${subjectNameList[0].classId}"/>
													</c:if>	
													<c:if test="${!status.last}">
														<c:set var="nextCompany" value="${subjectNameList[status.index+1].companyId}"/>
														<c:set var="nextClass" value="${subjectNameList[status.index+1].classId}"/>
													</c:if>
													<c:if test="${status.last}">
														<c:set var="nextCompany" value="${subjectNameList[0].companyId }"/>
														<c:set var="nextClass" value="${subjectNameList[0].classId}"/>
													</c:if>											
												</c:if>
												<c:if test="${empty prevCompany }">
													<c:set var="tempCompany" value="${result.companyId }"/>
													<c:set var="tempClass" value="${result.classId}"/>									
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
				</div>
				
				
				<form name="frmTraning" id="frmTraning" method="post">
				<input type="hidden" id="classId" name="classId" value="${TraningNoteVO.classId}" />
				<input type="hidden" id="status" name="status" value="" />
				<input type="hidden" id="returnComment" name="returnComment" value="" />
				<input type="hidden" id="companyId" name="companyId" value="${TraningNoteVO.companyId}" />
							<%-- <h4 class="mb-010"><span>${TraningNoteVO.subjectName} / ${TraningNoteVO.subjectCode }</span> (${TraningNoteVO.classId }분반_${TraningNoteVO.companyName})ㅣ ${TraningNoteVO.yyyy}학년도 ${TraningNoteVO.termName} </h4> --%>
							 
							 <div class="training-info">
								 <div class="txt-box">
									<dl>
										<dt><label for="weekCnt">주차</label></dt>
										<dd>
											<select id="weekCnt" name="weekCnt" onchange="javascript:fn_search('${TraningNoteVO.classId}','${TraningNoteVO.companyId}');">
												<c:forEach var="result" items="${weeklist}" varStatus="status">
												<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq TraningNoteVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
												</c:forEach>
											</select>	
										</dd>
									</dl>
									
									<dl>
										<dt>기간</dt>
										<dd>${TraningNoteVO.traningStDate} ~ ${TraningNoteVO.traningEndDate}</dd>
									</dl>
									<dl>
										<dt>능력단위</dt>
										<dd>${TraningNoteVO.ncsUnitName}</dd>
									</dl>
									
									<dl>
										<dt>주간 훈련시간</dt>
										<dd>${TraningNoteVO.timeHour}</dd>
									</dl>
									<!--  
									<dl class="class-cont">
										<dt>능력단위요소</dt>
										<dd>${fn:replace(TraningNoteVO.ncsElemName, cn , br )}</dd>
									</dl>
									<dl class="class-cont">
										<dt>수업내용</dt>
										<dd>${TraningNoteVO.lessonCn}</dd>
									</dl>
									-->
								</div>
							</div>
							
							<%-- 
							<div class="table-responsive">
								<table class="type-1-2 mb-030">
									<colgroup>
										<col style="width:10%" />
										<col style="width:20%" />
										<col style="width:*" />
										<col style="width:*" />
										<col style="width:*" />
										<col style="width:8%" />
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
												<select id="weekCnt" name="weekCnt" onchange="javascript:fn_search('${TraningNoteVO.classId}','${TraningNoteVO.companyId}');">
													<c:forEach var="result" items="${weeklist}" varStatus="status">
													<option value="${result.weekCnt}" <c:if test="${result.weekCnt eq TraningNoteVO.weekCnt }">selected</c:if>>${result.weekCnt}</option>
													</c:forEach>
												</select>											
											</td>
											<td>${TraningNoteVO.traningStDate} ~ ${TraningNoteVO.traningEndDate}</td>
											<td>${TraningNoteVO.ncsUnitName}</td>
											<td>${fn:replace(TraningNoteVO.ncsElemName, cn , br )}</td>
											<td class="left">${TraningNoteVO.lessonCn}</td>
											<td>${TraningNoteVO.timeHour}</td>
	
										</tr>
									</tbody>
								</table>
							</div>
							 --%>

						<c:forEach var="timeList" items="${timeList}" varStatus="status">
						<c:if test="${!empty resultSum[status.index].weekId}" >
						

							<div class="">
	 							<div class="sub_text blue_text mt-040">
	 								 <i class="xi-label"></i> 정규수업 : 
	 								 ${resultSum[status.index].traningDate}(${resultSum[status.index].dayOfWeek}) ${resultSum[status.index].traningSt}~${resultSum[status.index].traningEd} (${resultSum[status.index].timeHour}시간)  ${result.traniningNoteMasterId } 
	 							</div>	

	 							<div class="table-responsive mt-010">
									<table class="type-2">
										<caption>학번 성명 훈련시간 성취도 비고 (교육 중 특이사항 등) 등 정보제공</caption>
										<colgroup>											
										     	<col width="5%" />						
												<col width="10%" />
												<col width="10%" />
												<col width="10%" />
												<col width="10%" />
												<col width="*" />
												<col width="10%" />
												<%-- <col width="8%" />
												<col width="20%" /> --%>
										</colgroup>
										<thead>
											<tr>
												<th scope="col">선택</th>
												<th scope="col">학번</th>
												<th scope="col">성명</th>
												<th scope="col">훈련시간</th>
												<th scope="col">성취도</th>
												<th scope="col">비고 (교육 중 특이사항 등)</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="rowNum" value="${fn:length(resultlistSum[status.index])}"/>
											<c:forEach var="resultlist" items="${resultlistSum[status.index]}" varStatus="statuslist">
											<%-- <c:set var="rowNum" value="${rowNum+1}"/> --%>
											<tr>
											<label for="traniningNoteMasterIds" class="hidden">선택</label>
											<c:if test="${statuslist.index eq '0'}">
												<td rowspan="${rowNum}"><input type="checkbox" id="traniningNoteMasterIds" name="traniningNoteMasterIds" value="${resultlist.traniningNoteMasterId}" ${empty resultlist.traniningNoteMasterId ? 'disabled' : ''}  class="choice" /></td>
											</c:if>											
												<td>${resultlist.memId} <input type="hidden" name="memIdArr" id="memIdArr" value="${resultlist.memId}"><input type="hidden" id="traniningNoteDetailIdArr1" name="traniningNoteDetailIdArr" value="${resultlist.traniningNoteDetailId}" /><input type="hidden" id="" name="traniningNoteMasterIdArr" value="${resultlist.traniningNoteMasterId}" /></td>
												<td>${resultlist.memName} <input type="hidden" name="memNmArr" id="memNmArr" value="${resultlist.memName}">  </td>
												<td>
													<%-- <c:if test="${!empty resultlist.studyTime }" >
													<input type="text" id="studyTimeArr" name="studyTimeArr" style="width:95%;" onchange="javascript:studyTimeArrZeor(this.value,'${resultSum[status.index].timeHour}','${resultlist.memId}','${status.index+1}');" value="${resultlist.studyTime}"/>
													</c:if>
													<c:if test="${empty resultlist.studyTime }" >
													<input type="text" id="studyTimeArr" name="studyTimeArr" style="width:95%;" onchange="javascript:studyTimeArrZeor(this.value,'${resultSum[status.index].timeHour}','${resultlist.memId}','${status.index+1}');"  value="${resultSum[status.index].timeHour}"/>
													</c:if> --%>
													<c:if test="${!empty resultlist.studyTime }" >
													${resultlist.studyTime}
													</c:if>
													<c:if test="${empty resultlist.studyTime }" >
													${resultSum[status.index].timeHour}
													</c:if>
												</td>									 
									<script type="text/javascript">
									<!--
									$(function() {
											$('#${resultlist.memId}result${status.index+1}').raty({ 
												cancel :true,
												<c:if test="${!empty resultlist.traniningNoteMasterId}">
												score: ${resultlist.achievement},
												</c:if>
												<c:if test="${empty resultlist.traniningNoteMasterId}">
												score:5,
												</c:if>												
												path : "/images/oklms/std/inc" 
											});
									});	
									//--> 
									</script>
												<td class="result${status.index+1}" id="${resultlist.memId}result${status.index+1}">${resultlist.achievement}</td>																															
												<%-- <td class="left"><input type="text" style="width:95%;" name="bigoArr" value="${resultlist.bigo}"/></td> --%>
												<td class="left">${resultlist.bigo}</td>
												<c:if test="${statuslist.index eq '0'}">
												<td rowspan="${rowNum}">
												<c:choose>
													<c:when test="${resultlist.status eq '1'}"><span class="label gray">승인대기</span></c:when>
													<c:when test="${resultlist.status eq '2'}"><span class="label blue">승인</span></c:when>
													<c:when test="${resultlist.status eq '3'}"><span class="label gray"><a href="#companion-wrap" name="modalReturnNoteComment" data-comment="${resultlist.returnComment}" rel="modal:open">반려</a></span></c:when>
												</c:choose>
												</td>
												</c:if>
											</tr>
											
											</c:forEach>
											<c:if test="${!empty resultSum[status.index].returnComment}">
											<tr>
												<th scope="row">반려사유</th>
												<td colspan="6" class="left">${resultSum[status.index].returnComment}</td>
											</tr>
											</c:if>
											<tr>
												<th scope="row">총평</th>
												<td colspan="6" class="left">${resultSum[status.index].review}</td>
											</tr>
										</tbody>
									</table>
								</div>
	 						</div>
							<!-- E : 정규수업 -->
						</c:if>
					</c:forEach>							

					<c:forEach var="TraningEnrichmentTimeVO" items="${TraningEnrichmentTimeVO}" varStatus="statustop">
 							<div class="">
	 							<div class="sub_text blue_text mt-040">
	 								 <i class="xi-label"></i> 보강훈련 :
									 ${TraningEnrichmentTimeVO.traningDate} 
									 ${TraningEnrichmentTimeVO.traningStHour}:${TraningEnrichmentTimeVO.traningStMin} ~ 
									 ${TraningEnrichmentTimeVO.traningEdHour}:${TraningEnrichmentTimeVO.traningStMin}
	 							</div>
	
	 							<div class="table-responsive">
									<table class="type-2">
										<caption>성명 훈련시간 성취도 비고 (교육 중 특이사항 등) 등 정보제공</caption>
										<colgroup>
											<col width="15%" />
											<col width="15%" />
											<col width="20%" />
											<col width="*" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">성명</th>
												<th scope="col">훈련시간 (결과)</th>
												<th scope="col">성취도</th>
												<th scope="col">비고 (교육 중 특이사항 등)</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="resultlist" items="${TraningNoteList2[statustop.index]}" varStatus="status">
											<tr id="tr${status.index}">
												<td>${resultlist.memName} <input type="hidden" name="memNmArr" id="memNmArr" value="${resultlist.memName}">  </td>
												<td>${resultlist.studyTime}</td>
												<td>
												 
												<c:forEach var="i" begin="1" end="${resultlist.achievement}" step="1">
											      <img src="/images/oklms/std/inc/icon_star_on.png" />
											    </c:forEach>												
												</td>	
												<td class="left">${resultlist.bigo}</td>
											</tr>
											</c:forEach> 
											<tr>
												<th scope="row">보강총평</th>
												<td colspan="3" class="left"> ${TraningEnrichmentTimeVO.review} </td>
											</tr>
										</tbody>
									</table>
								</div>
								
							</div>
							<!-- E : 보강수업 -->
					</c:forEach>		
					</div>							  
 </form>
					<div class="btn-area  mt-010">
						<div class="align-right wp100">
							<input type="text" name="comment" id="comment"  class="wp50" placeholder="반려시 반려사유 필수 입력">
							<a href="#" onclick="javascript:fn_approval('3');" class="yellow">반려</a>
							<a href="#" onclick="javascript:fn_approval('2');" class="orange">승인</a>
							<a href="#" onclick="javascript:fn_subj_main('${TraningNoteVO.subjectTraningType}','${TraningNoteVO.yyyy}','${TraningNoteVO.term}','${TraningNoteVO.subjectCode}','${TraningNoteVO.classId}','${TraningNoteVO.subjectName}','${TraningNoteVO.subjectType}','${TraningNoteVO.onlineType}');" class="black">교과목 정보</a>
							<a href="#!" onclick="javascript:fn_search('${prevClass}','${prevCompany }')" class="gray-1">&lt; 이전 분반</a> 
							<a href="#!" onclick="javascript:fn_search('${nextClass}','${nextCompany }')" class="gray-1">다음 분반 &gt;</a>
						</div>
					</div>
					
					


 