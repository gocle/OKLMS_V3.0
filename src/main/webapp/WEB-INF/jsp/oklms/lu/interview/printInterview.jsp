<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="kr.co.gocle.oklms.comm.vo.LoginInfo" %>
<%
	LoginInfo loginInfo = new LoginInfo();
%>
<style>
<!--
@media print																{.not_print {display: none;}}
-->
</style>
<c:set var="indexnum" value="8" />
			<c:if test="${!empty result.tempSj1}">
<c:set var="indexnum" value="${indexnum+1 }" />
			</c:if>
			<c:if test="${!empty result.tempSj2}">
<c:set var="indexnum" value="${indexnum+1 }" />
			</c:if>
			<c:if test="${!empty result.tempSj3}">
<c:set var="indexnum" value="${indexnum+1 }" />			
			</c:if>				
			<div id="pop-wrapper" class="min-w650" >									
 
<% 
if(loginInfo!=null && loginInfo.getMemType().equals("PRT")){
%>		
						<h2>기업 방문 지도 및 면담일지</h2>
						<br/>

						<div>
							<span>
								<li>담당교수&nbsp;:&nbsp; ${result.interviewMemName }</li>

								<li>방문기업&nbsp;:&nbsp; ${result.companyName }</li>

								<li>참석자&nbsp;:&nbsp;${result.interviewMemberNames }</li>

								<li>방문일시&nbsp;:&nbsp;${result.interviewNoteDate }</li>
							</span>
						</div> 						
						 
<% }else{%>

						<h2>학습근로자 면담일지</h2>
						<table width="100%">
							<tr>									
								<td width="40%">
									No.${result.interviewNoteDate }<br />
									<font size="4">학습근로자 면담일지</font>
								</td>
								<td width="20%">&nbsp;</td> 
								<td width="40%">
												<div>
													<span>
														<li>협약기업명&nbsp;:&nbsp; ${result.companyName }</li>
													 							
														<li>기업현장교사/담당자&nbsp;:&nbsp; ${result.interviewMemName }</li>
									 								
														<li>학습근로자명&nbsp;:&nbsp;${result.interviewMemberNames }  </li>
										 									
														<li>일시&nbsp;:&nbsp;${result.interviewNoteDate }</li>
													</span>
												</div> 						
								</td>
							</tr>
						</table>
						 
						<br />
						<table width="100%">
							<tr>									
								<td width="25%">&nbsp;</td>
								<td width="25%">&nbsp;</td>
								<td width="25%">&nbsp;</td>
								<td width="25%">
									<table border="2" width="150px">
										<tr align="center">									
											<td align="center" rowspan="2" width="30px">결<br/><br/>재</td>
											<td align="center" height="50px">총괄책임자<br/>(훈련책임자)</td>
										</tr>
										<tr>									
											<td height="60px" >&nbsp;</td>
										</tr>										
									</table> 									
								</td>
							</tr>
						</table> 
<%
}
%>						
						<br/>
						<table class="type-write">
							<colgroup> 
								<col style="width:100px" />
								<col style="width:*" />
							</colgroup>
							<tr> 
								<th>구분</th>
								<th>면담내용</th>
							</tr>
 <c:if test="${!empty result.traningProcessName}">
							<tr>
								<th class="sub-name">훈련과정</th>
								<td>${result.traningProcessName }</td>
							</tr>
</c:if>
<c:if test="${!empty result.trainingTalk}">	
							<tr>
								<th class="sub-name">훈련</th>
								<td>${result.trainingTalk }</td>
							</tr>
</c:if>
<c:if test="${!empty result.workTalk}">	
							<tr>
								<th class="sub-name">근로</th>
								<td>${result.workTalk }</td>
							</tr>
</c:if>
<c:if test="${!empty result.tempTalk}">	
							<tr>
								<th class="sub-name">기타</th>
								<td>${result.tempTalk }</td>
							</tr>
</c:if>
<c:if test="${!empty resultFile2}">
							<tr>
								<th class="sub-name">지도상황</th>
								<td> 
											<a href="javascript:com.downFile('${resultFile2.atchFileId}','${resultFile2.fileSn}');" class="text-file">
											<img src="/cmm/fms/getImageAtch.do?atchFileId=${resultFile2.atchFileId}" alt="${resultFile2.orgFileName}"/>
											</a>
								</td>
							</tr>
</c:if>
							<tr>
								<th rowspan="2" class="sub-name">면담내용</th>
								<td><textarea name="textarea" rows="5">${result.totalTalk }</textarea></td>
							</tr>
							<tr>
								<td class="border-left">
									<c:if test="${!empty resultFile1}">
											<a href="javascript:com.downFile('${resultFile1.atchFileId}','${resultFile1.fileSn}');" class="text-file">${resultFile1.orgFileName}</a>
									</c:if>								
								</td>
							</tr>
							
							<c:if test="${!empty result.tempSj1}">
							<tr>
								<th class="sub-name">${result.tempSj1 }</th>
								<td>${result.tempCn1 }</td>
							</tr>
							</c:if>
							<c:if test="${!empty result.tempSj2}">
							<tr>
								<th class="sub-name">${result.tempSj2 }</th>
								<td>${result.tempCn2 }</td>
							</tr>
							</c:if>
							<c:if test="${!empty result.tempSj3}">
							<tr>
								<th class="sub-name">${result.tempSj3 }</th>
								<td>${result.tempCn3 }</td>
							</tr>							
							</c:if>							
 
							
						</table>

						<div class="btn-area align-right mt-010">
							<a href="#!" onclick="javascript:fn_formSave('P');" class="gray-2">인쇄</a>											

						</div><!-- E : btn-area -->
				</div>		
<script type="text/javascript">
<!--

$(document).ready(function() {

	
});
/*  수정,삭제 */
function fn_formSave(type){ 
	  
	if(type=="P"){
		window.print();
	}
 
 
} 
function fn_cancel(){

	var reqUrl =  "/lu/interview/listInterview.do";
	$("#frmInterview").attr("target", "_self");
	$("#frmInterview").attr("action", reqUrl);
	$("#frmInterview").submit();		

}
//--> 
</script>						