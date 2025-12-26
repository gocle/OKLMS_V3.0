<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
		<div id="pop-wrapper" class="min-w850">
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>
						<h2>주차별 학습활동서</h2>

					<div class="gropu-area">
						<div class="table-responsive">
							<table class="type-2">
								<caption>구분 기업명 소재지 선정일 훈련과정명 대한 정보 제공</caption>
								<colgroup>
									<col style="width:120px" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:*" />
								</colgroup>
								<tr>
									<th scope="col">구분</th>
									<th scope="col">기업명</th>
									<th scope="col">소재지</th>
									<th scope="col">선정일</th>
									<th scope="col">훈련과정명</th>
								</tr>
								
								<c:if test="${!empty result}">
								<tr>
									<td>${activityVO.traningType }</td>
									<td>${result.companyName }</td>
									<td>${result.address }</td>
									<td>${result.insertDate }</td>
									<td>${result.hrdTraningName }</td>
								</tr>
								</c:if>
							  
							</table>
						</div>					 
					</div>
						
					<div class="gropu-area">
						<div class="table-responsive mt-030">
  						<table class="type-2 ">
							<caption>성명 주민등록번호 주차 학습기간 대한 정보 제공</caption>
							<colgroup>
								<col style="width:180px" />
								<col style="width:*" />
								<col style="width:120px" />
								<col style="width:250px" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">성명</th>
									<th scope="col">주민등록번호</th>
									<th scope="col">주차</th>
									<th scope="col">학습기간</th>
								</tr>
							</thead>
							<c:set var="memName" value="" />
							<c:forEach var="result" items="${resultlist}" varStatus="status">
							<c:set var="memName" value="${result.memName }" />	
							</c:forEach>
							<tbody>
								<tr>
									<td>${memName}</td>
									<td> </td>
									<td>${activityVO.weekCnt } 주차</td>
									<td>${subjweekStdVO.traningStDate} ~ ${subjweekStdVO.traningEndDate}</td>
								</tr>
							</tbody>
						</table>
						</div>
					</div>
						
					<div class="gropu-area">
						<div class="table-responsive mt-030">
							<table class="type-2">
								<caption>개설강좌명 능력단위요소 교육시간 성취도 학습활동내역 대한 정보 제공</caption>
								<colgroup>
									<col style="width:*" />
									<col style="width:*" />
									<col style="width:80px" />
									<col style="width:80px" />
									<col style="width:80px" />
									<col style="width:100px" />
									<col style="width:*" />
								</colgroup>
								<tr>
									<th scope="col" rowspan="2">개설강좌명</th>
									<th scope="col" rowspan="2">능력단위요소</th>
									<th scope="col" colspan="3">교육시간</th>
									<th scope="col" rowspan="2">성취도</th>
									<th scope="col" rowspan="2">학습활동내역</th>
								</tr>
								<tr>
									<th scope="col" class="border-left">전체</th>
									<th scope="col">계획</th>
									<th scope="col">결과</th>
								</tr>
								<c:forEach var="result" items="${resultlist}" varStatus="status">
								
								<tr>								
									<td>${result.subjectName}</td>
									<td>${result.ncsUnitName} ${result.ncsElemName}</td>
									
									<td>${result.allTimeHour}시간</td>
									<td>${result.weekTimeHour}시간</td>
									<td>
									<c:if test="${!empty result.weekAddTimeHour}">
									${result.weekWorkTimeHour} + ${result.weekAddTimeHour}시간
									</c:if>
									<c:if test="${empty result.weekAddTimeHour}">
									${result.weekWorkTimeHour} 시간									
									</c:if>									
	
									</td>
									<td>
									<c:if test="${!empty result.weekAddTimeHour}">
										${result.weekWorkAchievement} / ${result.weekAddAchievement}
									</c:if>
									<c:if test="${empty result.weekAddTimeHour}">
										${result.weekWorkAchievement} 
									</c:if>									
									</td> 																										
									<td>${result.content}</td>
								</tr>
								
								</c:forEach>
								 
							</table>
						</div>


						<table class="type-write mt-020	">
							<caption>요청사항 첨부파일첨부 대한 정보 제공</caption>
							<colgroup>
								<col style="width:150px" />
								<col style="width:*" />
							</colgroup>
							<tbody>
							<c:forEach var="result" items="${resultlist}" varStatus="status">
							
								<c:if test="${!empty result.reqContent and !empty result.atchFileId}">
								<tr>
									<th scope="row">요청사항</th>
									<td>${result.reqContent}</td>
								</tr>
								<tr>
									<th scope="row">첨부파일첨부</th>
									<td class="left">
										<a href="javascript:com.downFile('${result.atchFileId}','1');" class="text-file">첨부파일파일</a>											 
									</td>
								</tr>
								</c:if>
								<c:if test="${empty result.reqContent and !empty result.atchFileId}">
								<tr>
									<th scope="row">첨부파일첨부</th>
									<td class="left">
										<a href="javascript:com.downFile('${result.atchFileId}','1');" class="text-file">첨부파일파일</a>											 
									</td>
								</tr>
								</c:if>
								<c:if test="${!empty result.reqContent and empty result.atchFileId}">
								<tr>
									<th>요청사항</th>
									<td>${result.reqContent}</td>
								</tr>
								</c:if>
								
							</c:forEach>	
							</tbody>
						</table>
					</div>
				 	<div class="btn-area mt-010">
				 		<div class="float-right">
							<a href="#!" onclick="javascript:window.print();" class="gray-1">인쇄</a>
							<a href="#!" onclick="javascript:self.close();" class="gray-1">닫기</a>
						</div>
					</div><!-- E : btn-area -->
			</div>