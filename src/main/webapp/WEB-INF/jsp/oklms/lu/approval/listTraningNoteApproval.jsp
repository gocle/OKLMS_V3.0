<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>



<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2017. 01. 09 오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>
<c:set var="targetUrl" value="/lu/apploval/"/>
<script type="text/javascript">

	var targetUrl = "${targetUrl}";

	$(document).ready(function() {
		loadPage();
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


	/* 리스트 조회 */
	function fn_search( pageIndex ){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listApproval.do";
		$("#frmApproval").attr("action", reqUrl);
		$("#frmApproval").submit();
	}
	
	function fn_note_approval( status ){
		
		var checkedVals = $("input:checkbox[name=traniningNoteMasterIds]:checked").length;
		
		if(checkedVals == 0){
			alert("처리 대상을 선택하세요.");
			return;
		}
		
		if( status == "3" ){
			if( $("#note_comment").val() == "" ){
				alert("반려사유를 입력하세요.");
				$("#comment").focus();
				return;
			}
		} else {
			$("#note_comment").val("");
		}
		$("#returnComment").val($("#note_comment").val());
		
		$("#status").val(status);
		var reqUrl = "/lu/apploval/saveApprovalNote.do";
		$("#frmApproval").attr("action", reqUrl);
		$("#frmApproval").submit();
	}
	
	function fn_act_approval( status ){
		
		var checkedVals = $("input:checkbox[name=activityNoteIds]:checked").length;
		
		if(checkedVals == 0){
			alert("처리 대상을 선택하세요.");
			return;
		}
		
		if( status == "3" ){
			if( $("#act_comment").val() == "" ){
				alert("반려사유를 입력하세요.");
				$("#act_comment").focus();
				return;
			}
		} else {
			$("#act_comment").val("");
		}
		$("#returnComment").val($("#act_comment").val());
		
		$("#status").val(status);
		var reqUrl = "/lu/apploval/saveApprovalAct.do";
		$("#frmApproval").attr("action", reqUrl);
		$("#frmApproval").submit();
	}
	
	
</script>

			
			
			
			
<form id="frmApproval" name="frmApproval"  method="post">
<input type="hidden" name="status" id="status"/>
<input type="hidden" id="returnComment" name="returnComment" value="" />
	
	
	<h2>OJT관리</h2>

			<div class="group-area-title">
						
						
						<select name="yyyy" id="yyyy" onchange="javascript:fn_search();"> 
									<c:forEach var="i" begin="0" end="2" step="1">
										<option value="${nowYear-i}" <c:if test="${subjectVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
									</c:forEach>								
								</select> 
								<select name="term" id="term" onchange="javascript:fn_search();">
									<option value="1" <c:if test="${subjectVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
									<option value="2" <c:if test="${subjectVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
									<option value="3" <c:if test="${subjectVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
									<option value="4" <c:if test="${subjectVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
								</select>
						
						<label for="searchSubjectCode" class="hidden">교과목 선택</label>
						<select id="searchSubjectCode" name="searchSubjectCode"   class="wpauto" onchange="javascript:fn_search();">
							<option value="">교과목 선택</option>
							<c:forEach var="result" items="${listOjtAunuriSubject}" varStatus="status">
								<option value="${result.subjectCode}" ${subjectVO.searchSubjectCode eq result.subjectCode ? 'selected' : ''}>${result.subjectName}</option>
							</c:forEach>
						</select>
						<!-- <a href="#!" onclick="javascript:fn_search();" class="wp20">검색</a> -->
						<!-- <label for="" class="hidden">선택</label>
						<select id="" name="" onchange=""  class="wpauto">
							<option value="">기업명+학습근로자명</option>
							<option value="">기업명</option>
							<option value="">학습근로자명</option>
						</select>
						
						<label for="" class="hidden">검색어 입력</label>
						<input type="text" name="" id="" placeholder="검색어를 입력하세요" class="wp20">
						<a href="" rel="" class="btn btn-black btn-md">검색</a> 
						<a href="" rel="" class="btn btn-black btn-md">검색 초기화</a>  -->
						
						
						<!--  기업명 & 학습근로자 검색 -->
						<!-- <p>
						<a href="#learner-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">기업명 검색 <i class="xi-search"></i></a> 
						<a href="#std-wrap_area" rel="modal:open" class="btn btn-black form-control mmd btn-radius50">학습근로자 검색 <i class="xi-search"></i></a>
						</p> -->

						<!--  기업명 & 학습근로자 검색 -->
				</div>
				
				<div class="lecture-date type2">
					<ul>
						<!-- OJT 훈련일지 -->
						<li>
							<div class="lecture-title">
								<strong class="tit"><i class="xi-label"></i> OJT 훈련일지</strong>
								<div class="radio-area">
			                        <div class="box-row valign-middle">
			                            <div class="box-cell"><label for="noteSearchStatus1"><input type="radio" id="noteSearchStatus1" name="noteSearchStatus" ${traningNoteVO.noteSearchStatus eq  '' ? 'checked' : ''} value="" onclick="fn_search();" /> 전체</label></div>
			                            <div class="box-cell"><label for="noteSearchStatus2"><input type="radio" id="noteSearchStatus2" name="noteSearchStatus" ${traningNoteVO.noteSearchStatus eq  '1' ? 'checked' : ''} value="1" onclick="fn_search();"/> 미승인</label></div>
			                            <div class="box-cell"><label for="noteSearchStatus3"><input type="radio" id="noteSearchStatus3" name="noteSearchStatus" ${traningNoteVO.noteSearchStatus eq  '2' ? 'checked' : ''} value="2" onclick="fn_search();"/> 승인</label></div>
			                            <div class="box-cell"><label for="noteSearchStatus4"><input type="radio" id="noteSearchStatus4" name="noteSearchStatus" ${traningNoteVO.noteSearchStatus eq  '3' ? 'checked' : ''} value="3" onclick="fn_search();"/> 반려</label></div>
			                        </div>
			                    </div>
							</div>
							<div class="lecture-box" style="max-height: 680px;">
								<div class="table-responsive">
									<table class="type-2 ">
										<caption>개설교과목명  분반 기업명 주차 능력단위명  기업현장교사 작성일자 상태 정보제공</caption>
										<colgroup>		
											<col width="5%" />
											<col width="*"/>
											<col width="10%" />									
									     	<col width="15%" />
											<col width="8%" />
											<col width="15%" />
											<col width="12%" />
											<col width="10%" />
											<col width="8%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col"></th>
												<th scope="col">개설 교과목명</th>
												<th scope="col">분반</th>
												<th scope="col">기업명</th>
												<th scope="col">주차</th>
												<th scope="col">능력단위명</th>
												<th scope="col">기업현장교사</th>
												<th scope="col">작성일자</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											
										<%-- <c:forEach var="result" items="${listOjtTraningNoteApproval}" varStatus="status">
											<c:set var="rowspan" value="0"/>
											<c:if test="${result.rn eq '1'}">
												<c:set var="rowspan" value="${result.rowspan}"/>
											</c:if>
											<tr>
											<c:if test="${result.rn eq '1'}">
												<td rowspan="${rowspan}"><input type="checkbox" name="traniningNoteMasterIds" id="traniningNoteMasterId${status.count}" value="${result.traniningNoteMasterId}"/></td>
											</c:if>
												<td>${result.subjectName}</td>
												<td>${result.subjectClass}</td>
												<td>${result.companyName}</td>									 
												<td>${result.weekCnt}</td>																															
												<td>${result.ncsUnitName}</td>
												<td>${result.tutNames}</td>	
												<td>${result.insertDate}</td>	
											</tr>
											<c:if test="${rowspan eq '0'}">
											<tr>
												<th>총평</th>
												<td colspan="7">${result.review}</td>
											</tr>	
											</c:if>
											<c:if test="${rowspan eq '1'}">
											<tr>
												<th>총평</th>
												<td colspan="7">${result.review}</td>
											</tr>
											</c:if>
										</c:forEach>	 --%>
										
										<c:forEach var="result" items="${listOjtTraningNoteApproval}" varStatus="status">
											<tr>
												<td><label for="traniningNoteMasterId${status.count}" class="hidden">선택</label><input type="checkbox" name="traniningNoteMasterIds" id="traniningNoteMasterId${status.count}" value="${result.traniningNoteMasterId}|${result.subjectType}|${result.timeId}|${result.memId}"/></td>
												<td><a href="javascript:fn_lec_url('OJT','${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','NORMAL','NONE','/lu/traning/listTraningNote.do?weekCnt=${result.weekCnt}');">${result.subjectName}</a></td>
												<td>${result.subjectClass}</td>
												<td>${result.companyName}</td>									 
												<td>${result.weekCnt}</td>																															
												<td>${result.ncsUnitName}</td>
												<td>${result.tutNames}</td>	
												<td>${result.insertDate}</td>	
												<td>
												
												<c:choose>
													<c:when test="${result.status eq '1'}"><font color="orange">승인대기</font></c:when>
													<c:when test="${result.status eq '2'}"><font color="blue">승인</font></c:when>
													<c:when test="${result.status eq '3'}"><a href="#companion-wrap" name="modalReturnNoteComment" data-comment="${result.returnComment}" rel="modal:open"><font color="red">반려</font></a></c:when>
												</c:choose>
												
												
												</td>	
											</tr>
											<tr>
												<th>총평</th>
												<td colspan="9" style="text-align: left;">${result.review}</td>
											</tr>	
										</c:forEach>
										
										
										<c:if test="${empty listOjtTraningNoteApproval}">
											<tr>
												<td colspan="9"><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>
										
										
										</tbody>
									</table>
								</div>
							</div>
							<div class="btn-area">
								<div class="align-right">
									<label for="note_comment" class="hidden">반려사유입력</label>
									<input type="text" name="note_comment" id="note_comment" placeholder="반려시 반려사유 필수 입력" style="width:70%">
									<a href="#" onclick="javascript:fn_note_approval('3');" class="orange">반려</a>
									<a href="javascript:fn_note_approval('2');" class="black ">승인</a>
								</div>
							</div>
						</li>
						
						<!--  OJT 학습활동서 -->
						<li>
							<div class="lecture-title">
								<strong class="tit"><i class="xi-label"></i> OJT 학습활동서</strong>
								<div class="radio-area">
			                        <div class="box-row valign-middle">
			                            
			                            <div class="box-cell"><label for="actSearchStatus1"><input type="radio" id="actSearchStatus1" name="actSearchStatus" ${activityVO.actSearchStatus eq  '' ? 'checked' : ''} value="" onclick="fn_search();" /> 전체</label></div>
			                            <div class="box-cell"><label for="actSearchStatus2"><input type="radio" id="actSearchStatus2" name="actSearchStatus" ${activityVO.actSearchStatus eq  '1' ? 'checked' : ''} value="1" onclick="fn_search();"/> 미승인</label></div>
			                             <div class="box-cell"><label for="actSearchStatus3"><input type="radio" id="actSearchStatus3" name="actSearchStatus" ${activityVO.actSearchStatus eq  '2' ? 'checked' : ''} value="2" onclick="fn_search();"/> 승인</label></div>
			                            <div class="box-cell"><label for="actSearchStatus4"><input type="radio" id="actSearchStatus4" name="actSearchStatus" ${activityVO.actSearchStatus eq  '3' ? 'checked' : ''} value="3" onclick="fn_search();"/> 반려</label></div>
			                        </div>
			                    </div>
							</div>
							<div class="lecture-box" style="max-height: 680px;">
								<div class="table-responsive">
									<table class="type-2">
										<caption>개설교과목명  분반 기업명 주차 능력단위명  기업현장교사 작성일자 상태 정보제공</caption>
										<colgroup>		
											<col width="5%" />
											<col width="*" />
											<col width="10%" />									
									     	<col width="15%" />
											<col width="8%" />
											<col width="15%" />
											<col width="12%" />
											<col width="10%" />
											<col width="8%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col"></th>
												<th scope="col">개설 교과목명</th>
												<th scope="col">분반</th>
												<th scope="col">기업명</th>
												<th scope="col">주차</th>
												<th scope="col">능력단위명</th>
												<th scope="col">학습근로자</th>
												<th scope="col">작성일자</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
										
										<c:forEach var="result" items="${listOjtActivityApproval}" varStatus="status">
											<tr>
												<td><label for="activityNoteIds" class="hidden">선택</label><input type="checkbox" id=" activityNoteIds" name="activityNoteIds" value="${result.activityNoteId}"  /></td>
												<td><a href="javascript:fn_lec_url('OJT','${result.yyyy}','${result.term}','${result.subjectCode}','${result.subjectClass}','${result.subjectName}','NORMAL','NONE','/lu/activity/listActivityPrt.do?weekCnt=${result.weekCnt}&classId=${result.subjectClass}&subClass=${result.subjectClass}');">${result.subjectName}</a></td>
												<td>${result.subjectClass}</td>
												<td>${result.companyName}</td>									 
												<td>${result.weekCnt}</td>																															
												<td>${result.ncsUnitName}</td>
												<td>${result.memName}</td>	
												<td>${result.insertDate}</td>	
												<td>
												<c:choose>
													<c:when test="${result.status eq '1'}"><font color="orange">승인대기</font></c:when>
													<c:when test="${result.status eq '2'}"><font color="blue">승인</font></c:when>
													<c:when test="${result.status eq '3'}"><a href="#companion-wrap" name="modalReturnActComment" data-comment="${result.returnComment}" rel="modal:open"><font color="red">반려</font></a></c:when>
												</c:choose>
												</td>	
											</tr>
											<tr>
												<th> 내용</th>
												<td colspan="9" style="text-align: left;">${result.content}</td>
											</tr>	
										</c:forEach>
										<c:if test="${empty listOjtActivityApproval}">
											<tr>
												<td colspan="9"><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>
										</tbody>
									</table>
								</div>
							</div>
							<div class="btn-area">
								<div class="align-right">
									<label for="act_comment" class="hidden">반려사유입력</label>
									<input type="text" name="act_comment" id="act_comment" placeholder="반려시 반려사유 필수 입력" style="width:70%">
									<a href="#" onclick="javascript:fn_act_approval('3');" class="orange">반려</a>
									<a href="javascript:fn_act_approval('2');" class="black ">승인</a>
								</div>
							</div>
						</div>
					</ul>
				</div>
			</div>
				

</form>
	
	
	
	
					

	