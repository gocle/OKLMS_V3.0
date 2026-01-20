<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="lms" uri="/WEB-INF/tlds/lms.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

						<h2>제출서류 등록</h2>

<script type="text/javascript">
$(document).ready(function() {
 
}); 

function fn_search(periodId,workProofId){
	
	var reqUrl = "/lu/workcert/listWorkCertStd.do";	 
	$("#periodId").val(periodId);
	$("#workProofId").val(workProofId);
	
	$("#frmWorkCert").attr("target", "_self");
	$("#frmWorkCert").attr("action", reqUrl);
	$("#frmWorkCert").submit();
} 
function fn_insert(){
	if(confirm("제출하시겠습니까?")){
		var reqUrl = "/lu/workcert/insertWorkCertStd.do";
		$("#frmWorkCert").attr("action", reqUrl);
		$("#frmWorkCert").attr("target", "_self");
		$("#frmWorkCert").submit();		
	}
	return;
}

</script>
 								<div class="table-responsive mt-020">
	 								<table class="type-2">
										<colgroup>
											<col style="width:100px" />
											<col style="width:50px" />
											<col style="width:320px" />
											<col style="width:170px" />
											<col style="width:*" />
											<col style="width:100px" />
										</colgroup>
										<thead>
											<tr>
												<th>학년도</th>
												<th>학기</th>
												<th>증빙서류</th>
												<th>제출기간</th>
												<th>관련규정</th>
												<th>현황</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="workCertList" items="${workCertList}" varStatus="status">
											<tr>
													<td>${workCertList.yyyy}</td>
													<td>${workCertList.term}</td>
													<td class="left">
														<a href="#"  onclick="javascript:fn_search('${workCertList.periodId}','${workCertList.workProofId}');" >
															<c:if test="${workCertList.insuranceYn eq 'Y'}" > 원천징수영수증</c:if>
															<c:if test="${workCertList.receiptYn eq 'Y'}" >
																<c:if test="${workCertList.insuranceYn eq 'Y'}" >,</c:if>4대보험 가입증명서 
															</c:if>			
															<c:if test="${workCertList.workYn eq 'Y'}" >
																<c:if test="${workCertList.insuranceYn eq 'Y'}" >,</c:if>재직증명서
															</c:if>										
														</a>
													</td>
													<td>${workCertList.startTime}-${workCertList.endTime}</td>
													<td>${workCertList.relativeRegulation}</td>
													<td>
														<c:choose>
															<c:when test="${workCertList.sendYn eq 'N'}" >
																<span class="btn-line-gray" onclick="javascript:fn_search('${workCertList.periodId}','${workCertList.workProofId}');">미제출</span>
															</c:when>
															<c:when test="${workCertList.sendYn eq 'Y'}" >
																<c:choose>
																	<c:when test="${workCertList.state eq '02'
																		      || workCertList.stateRec eq '02'
																	          || workCertList.stateInc eq '02'
																	          || workCertList.stateWok eq '02'
																	          || workCertList.stateDoc eq '02'}" >
																		<span class="btn-line-orange" onclick="javascript:fn_search('${workCertList.periodId}','${workCertList.workProofId}');">반려</span>
																	</c:when>
																	<c:when test="${ workCertList.state eq '00'
																			  || workCertList.stateRec eq '00'
																	          || workCertList.stateInc eq '00'
																	          || workCertList.stateWok eq '00'
																	          || workCertList.stateDoc eq '00'}" >
																		<span class="btn-line-gray" onclick="javascript:fn_search('${workCertList.periodId}','${workCertList.workProofId}');">미승인</span>
																	</c:when>
																	<c:when test="${ workCertList.state eq '01'}" ><span class="btn-line-blue" onclick="javascript:fn_search('${workCertList.periodId}','${workCertList.workProofId}');">승인</span></c:when>
																</c:choose>
															</c:when>
														</c:choose>
													</td>										
											</tr>
											</c:forEach>
											<c:if test="${empty workCertList}">
											<tr>
												<td colspan="6"><spring:message code="common.nodata.msg" /></td>
											</tr>										
											</c:if>
											
										</tbody>
									</table> 
								</div>
<form:form modelAttribute="frmWorkCert" id="frmWorkCert" name="frmWorkCert" method="post" enctype="multipart/form-data" >
<input type="hidden" name="periodId" id="periodId"  value="${workCertVO.periodId}"/>
<input type="hidden" name="workProofId" id="workProofId"  value="${workCertVO.workProofId}"/>

<input type="hidden" name="yyyy" id="yyyy"  value="${workCertVO.yyyy}"/>
<input type="hidden" name="term" id="term"  value="${workCertVO.term}"/>

<c:if test="${!empty workCertVO.periodId}">

								<div class="mt-020">
									<table class="type-2 wp100">
										<colgroup>
											<col style="width:160px" />
											<col style="width:*" />
										</colgroup>
										<tbody>
											<tr>
												<th>학년 / 학기</th>
												<td class="left">${workCertVO.yyyy} 학년도 / ${workCertVO.termName}</td>
											</tr>
											<tr>
												<th>제출기간</th>
												<td class="left">${workCertVO.startTime} ~ ${workCertVO.endTime}</td>
											</tr>
											<tr>
												<th>관련 규정</th>
												<td class="left">${workCertVO.relativeRegulation}</td>
											</tr>
										</tbody>
									</table>
								</div>

								<div class="mt-020">
									<table class="type-2 wp100">
										<colgroup>
											<col style="width:160px" />
											<col style="width:*" />
										</colgroup>
										<tbody>
										<c:if test="${ workCertVO.insuranceYn eq 'Y' }" >
											<tr>
												<th >원천징수영수증 </th>
												
												<c:if test="${ !empty workCertVO.atchFileIdRec }" >
												<td class="left">
													
												<c:if test="${!empty resultFile2}">
												<a href="javascript:com.downFile('${resultFile2.atchFileId}','${resultFile2.fileSn}');" class="text-file">${resultFile2.orgFileName}</a>
												<c:if test="${ workCertVO.state ne '01'}" ><%-- 승인시 삭제금지 --%>
												<a href="javascript:com.deleteFile('${resultFile2.atchFileId}|${resultFile2.fileSn}', '/lu/workcert/listWorkCertStd.do?yyyy=${workCertVO.yyyy }&term=${workCertVO.term }&periodId=${workCertVO.periodId}&workProofId=${workCertVO.workProofId}' )"  class="btn-del">[삭제]</a>
												</c:if>
												</c:if>
												<c:if test="${empty resultFile2}">
													<input type="text" id="atchFileIdRec" name="atchFileIdRec" style="width:70%;" readonly="readonly">
													<p class="file-find">
														<a href="#@" class="checkfile">찾아보기</a>
														<input type="file" class="file_input_hidden" name="file_atchFileIdRec" onchange="javascript: document.getElementById('atchFileIdRec').value = this.value" />
													</p>
													<span style="display:inline-block; vertical-align:middle; color:orange;">※ 첨부파일은 pdf파일로 제출 바랍니다.</span>											
												</c:if>
	
												</td>
												</c:if>
												<c:if test="${empty workCertVO.atchFileIdRec }" >
												<td class="border-left left">
													<input type="text" id="atchFileIdRec" name="atchFileIdRec" style="width:70%;" readonly="readonly">
													<p class="file-find">
														<a href="#@" class="checkfile">찾아보기</a>
														<input type="file" class="file_input_hidden" name="file_atchFileIdRec" onchange="javascript: document.getElementById('atchFileIdRec').value = this.value" />
													</p>
													<span style="display:inline-block; vertical-align:middle; color:orange;">※ 첨부파일은 pdf파일로 제출 바랍니다.</span>
												</td>
												</c:if>
											</tr>
										</c:if>
										<c:if test="${ workCertVO.receiptYn eq 'Y' }" >
											<tr>
												<th>4대보험 가입증명서 </th>
												<c:if test="${ !empty workCertVO.atchFileIdInc }" >
												<td class="left">
													<c:if test="${!empty resultFile1}">
													<a href="javascript:com.downFile('${resultFile1.atchFileId}','${resultFile1.fileSn}');" class="text-file">${resultFile1.orgFileName}</a>
													<c:if test="${ workCertVO.state ne '01'}" ><%-- 승인시 삭제금지 --%>
													<a href="javascript:com.deleteFile('${resultFile1.atchFileId}|${resultFile1.fileSn}', '/lu/workcert/listWorkCertStd.do?yyyy=${workCertVO.yyyy }&term=${workCertVO.term }&periodId=${workCertVO.periodId}&workProofId=${workCertVO.workProofId}' )"  class="btn-del">[삭제]</a>
													</c:if>
													</c:if>
													<c:if test="${empty resultFile1}">
													<input type="text" id="atchFileIdInc"  name="atchFileIdInc" style="width:70%;" readonly="readonly">
														<p class="file-find">
															<a href="#@" class="checkfile">찾아보기</a>
															<input type="file" class="file_input_hidden" name="file_atchFileIdInc" onchange="javascript: document.getElementById('atchFileIdInc').value = this.value" />
														</p>
														<span style="display:inline-block; vertical-align:middle; color:orange;">※ 첨부파일은 pdf파일로 제출 바랍니다.</span>												
													</c:if>													
												</td>
												</c:if>
												<c:if test="${ empty workCertVO.atchFileIdInc }" >
												<td class="border-left left">
													<input type="text" id="atchFileIdInc"  name="atchFileIdInc" style="width:70%;" readonly="readonly">
													<p class="file-find">
														<a href="#@" class="checkfile">찾아보기</a>
														<input type="file" class="file_input_hidden" name="file_atchFileIdInc" onchange="javascript: document.getElementById('atchFileIdInc').value = this.value" />
													</p>
													<span style="display:inline-block; vertical-align:middle; color:orange;">※ 첨부파일은 pdf파일로 제출 바랍니다.</span>
												</td>
												</c:if>
											</tr>
										</c:if>	
										
										<c:if test="${ workCertVO.workYn eq 'Y' }" >
											<tr>
												<th>재직증명서 </th>
												<c:if test="${ !empty workCertVO.atchFileIdWok }" >
												<td class="left">
													<c:if test="${!empty resultFile4}">
													<a href="javascript:com.downFile('${resultFile4.atchFileId}','${resultFile4.fileSn}');" class="text-file">${resultFile4.orgFileName}</a>
													<c:if test="${ workCertVO.state ne '01'}" ><%-- 승인시 삭제금지 --%>
													<a href="javascript:com.deleteFile('${resultFile4.atchFileId}|${resultFile4.fileSn}', '/lu/workcert/listWorkCertStd.do?yyyy=${workCertVO.yyyy }&term=${workCertVO.term }&periodId=${workCertVO.periodId}&workProofId=${workCertVO.workProofId}' )"  class="btn-del">[삭제]</a>
													</c:if>
													</c:if>
													<c:if test="${empty resultFile4}">
													<input type="text" id="atchFileIdWok"  name="atchFileIdWok" style="width:70%;" readonly="readonly">
														<p class="file-find">
															<a href="#@" class="checkfile">찾아보기</a>
															<input type="file" class="file_input_hidden" name="file_atchFileIdWok" onchange="javascript: document.getElementById('atchFileIdWok').value = this.value" />
														</p>
														<span style="display:inline-block; vertical-align:middle; color:orange;">※ 첨부파일은 pdf파일로 제출 바랍니다.</span>												
													</c:if>													
												</td>
												</c:if>
												<c:if test="${ empty workCertVO.atchFileIdWok }" >
												<td class="border-left left">
													<input type="text" id="atchFileIdWok"  name="atchFileIdWok" style="width:70%;" readonly="readonly">
													<p class="file-find">
														<a href="#@" class="checkfile">찾아보기</a>
														<input type="file" class="file_input_hidden" name="file_atchFileIdWok" onchange="javascript: document.getElementById('atchFileIdWok').value = this.value" />
													</p>
													<span style="display:inline-block; vertical-align:middle; color:orange;">※ 첨부파일은 pdf파일로 제출 바랍니다.</span>
												</td>
												</c:if>
											</tr>
										</c:if>	
										
											<tr>
												<th>보완서류</th>
												<c:if test="${ !empty workCertVO.atchFileIdDoc }" >
												<td class="left">
													<c:if test="${!empty resultFile3}">
													<a href="javascript:com.downFile('${resultFile3.atchFileId}','${resultFile3.fileSn}');" class="text-file">${resultFile3.orgFileName}</a>
													<c:if test="${ workCertVO.state ne '01'}" ><%-- 승인시 삭제금지 --%>
													<a href="javascript:com.deleteFile('${resultFile3.atchFileId}|${resultFile3.fileSn}', '/lu/workcert/listWorkCertStd.do?yyyy=${workCertVO.yyyy }&term=${workCertVO.term }&periodId=${workCertVO.periodId}&workProofId=${workCertVO.workProofId}' )"  class="btn-del">[삭제]</a>
													</c:if>
													</c:if>
												</td>
												</c:if>
												<c:if test="${ empty workCertVO.atchFileIdDoc }" >
												<td class="border-left left">
													<input type="text" id="atchFileIdDoc" name="atchFileIdDoc" style="width:70%;" readonly="readonly">
													<p class="file-find">
														<a href="#@" class="checkfile">찾아보기</a>
														<input type="file" class="file_input_hidden" name="file_atchFileIdDoc" onchange="javascript: document.getElementById('atchFileIdDoc').value = this.value" />
													</p>
													<span style="display:inline-block; vertical-align:middle; color:orange;">※ 첨부파일은 pdf파일로 제출 바랍니다.</span>
												</td>
												</c:if>
											</tr>
	
											<tr>
												<th>제출상태</th>
											<%-- <c:if test="${ empty workCertVO.state}" ><td class="left">미제출</td></c:if>
											<c:if test="${ workCertVO.state eq '00'}" ><td class="left">미승인</td></c:if>
											<c:if test="${ workCertVO.state eq '01'}" ><td class="left">승인</td></c:if>
											<c:if test="${ workCertVO.state eq '02'}" ><td class="left">반려</td></c:if>	 --%>										
								 				<c:if test="${workCertVO.sendYn eq 'N'}" >
													<td class="left">미제출</td>
												</c:if>
												<c:if test="${workCertVO.sendYn eq 'Y'}" >
													<c:choose>
														<c:when test="${workCertVO.state eq '02'
															      || workCertVO.stateRec eq '02'
														          || workCertVO.stateInc eq '02'
														          || workCertVO.stateWok eq '02'
														          || workCertVO.stateDoc eq '02'}" >
															<td class="left">반려</td>
														</c:when>
														<c:when test="${ workCertVO.state eq '00'
																  || workCertVO.stateRec eq '00'
														          || workCertVO.stateInc eq '00'
														          || workCertVO.stateWok eq '00'
														          || workCertVO.stateDoc eq '00'}" >
															<td class="left">미승인</td>
														</c:when>
														<c:when test="${ workCertVO.state eq '01'}" >
															<td class="left">승인</td>
														</c:when>
													</c:choose>
												</c:if>
											</tr>
											
											<c:choose>
											    <c:when test="${workCertVO.state eq '02'}">
											        <tr>
											            <th>반려사유</th>
											            <td class="left">${workCertVO.returnReason}</td>
											        </tr>
											    </c:when>
											    
											    <c:when test="${workCertVO.stateRec eq '02'}">
											        <tr>
											            <th>반려사유 (원천징수)</th>
											            <td class="left">${workCertVO.returnReasonRec}</td>
											        </tr>
											    </c:when>
											
											    <c:when test="${workCertVO.stateInc eq '02'}">
											        <tr>
											            <th>반려사유 (4대보험)</th>
											            <td class="left">${workCertVO.returnReasonInc}</td>
											        </tr>
											    </c:when>
											
											    <c:when test="${workCertVO.stateWok eq '02'}">
											        <tr>
											            <th>반려사유 (재직증명서)</th>
											            <td class="left">${workCertVO.returnReasonWok}</td>
											        </tr>
											    </c:when>
											
											    <c:when test="${workCertVO.stateDoc eq '02'}">
											        <tr>
											            <th>반려사유 (보완서류)</th>
											            <td class="left">${workCertVO.returnReasonDoc}</td>
											        </tr>
											    </c:when>
											
											</c:choose>
										</tbody>
									</table>
								</div>
								<c:if test="${ workCertVO.state ne '01'}" ><%-- 승인시 제출금지 --%>
								
									<c:if test="${ workCertVO.startState eq 'Y' and  workCertVO.endState eq 'Y'}" >
								<div class="btn-area mt-020">
									<div class="float-right">
										<a href="#!" class="orange" onclick="javascript:fn_insert();">제출</a>
									</div>
								</div><!-- E : btn-area -->
									</c:if>
									
								</c:if>
  </c:if>
</form:form>