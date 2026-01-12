 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<style>

td {mso-number-format:"@";}

</style> 

 <div class="main-content">
 	<h2 class="title">학습근로자 교육훈련 현황</h2>
 	<h3 class="title">대학연계형</h3>
 		
		
 	<div class="table-responsive">
 	<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
		<colgroup>		
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2" colspan="2">구분</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<th colspan="2"><c:out value="${resultList.deptName}" /></th>
			</c:if>
		</c:forEach>				

			</tr>
			<tr>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<th>훈련중 인원(재학인원)</th>
				<th>제적인원</th>
			</c:if>
		</c:forEach>
			</tr>
		</thead>
		<tbody>

			<tr>
				<th colspan="2">1학년</th>								
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt1}" /></td>
				<td><c:out value="${resultList.failCnt1}" /></td>
			</c:if>
		</c:forEach>		
			</tr>


			<tr>
				<th colspan="2">2학년</th>								
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt2}" /></td>
				<td><c:out value="${resultList.failCnt2}" /></td>
			</c:if>
		</c:forEach>		
			</tr>
			
			<tr>
				<th rowspan="2">3학년</th>
				<th>신입</th>							
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt3}" /></td>
				<td><c:out value="${resultList.failCnt3}" /></td>
			</c:if>
		</c:forEach>		
			</tr>
			<tr>
				<th>편입</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt32}" /></td>
				<td><c:out value="${resultList.failCnt32}" /></td>
			</c:if>
		</c:forEach>	
			</tr>	

			<tr>
				<th rowspan="2">4학년</th>
				<th>신입</th>							
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt4}" /></td>
				<td><c:out value="${resultList.failCnt4}" /></td>
			</c:if>
		</c:forEach>		
			</tr>
			<tr>
				<th>편입</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt42}" /></td>
				<td><c:out value="${resultList.failCnt42}" /></td>
			</c:if>
		</c:forEach>	
			</tr>	
			
			
			<tr>
				<th rowspan="2">5학년</th>
				<th>신입</th>							
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt5}" /></td>
				<td><c:out value="${resultList.failCnt5}" /></td>
			</c:if>
		</c:forEach>		
			</tr>
			<tr>
				<th>편입</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><c:out value="${resultList.runCnt52}" /></td>
				<td><c:out value="${resultList.failCnt52}" /></td>
			</c:if>
		</c:forEach>	
			</tr>	
			
					  
		</tbody>
	</table>
	</div>
	
	
	<h3 class="title">고숙련마이스터과정</h3>
 	<div class="table-responsive">
 	<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
		<colgroup>		
			<col width="*" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2">구분</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<th colspan="2"><c:out value="${resultList.deptName}" /></th>
			</c:if>
		</c:forEach>	 
			</tr>
			<tr>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<th>훈련중 인원(재학인원)</th>
				<th>제적인원</th>
			</c:if>
		</c:forEach>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>1학년</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<td><c:out value="${resultList.runCnt1}" /></td>
				<td><c:out value="${resultList.failCnt1}" /></td>
			</c:if>
		</c:forEach> 
			</tr>
			<tr>
				<th>2학년</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<td><c:out value="${resultList.runCnt2}" /></td>
				<td><c:out value="${resultList.failCnt2}" /></td>
			</c:if>
		</c:forEach>
			</tr>
			<!-- 
			<tr>
				<th>3학년</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt3}" /></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt3}" /></td>
			</c:if>
		</c:forEach>
			</tr>
			 -->
		</tbody>
	</table>
	</div>
	
	
	<h2 class="title mt_50">학습기업 현황</h2>
	<%-- <div class="table-responsive">
 	<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
		<colgroup>		
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
		</colgroup>
		<thead>
			<tr>
				<th colspan="2">종합</th>
				<th colspan="2">대학연계형</th>
				<th colspan="2">고숙련마이스터과정</th>
			</tr>
			<tr>
				<th>참여기업 수</th>
				<th>훈련 중 기업 수</th>
				<th>참여기업 수</th>
				<th>훈련 중 기업 수</th>
				<th>참여기업 수</th>
				<th>훈련 중 기업 수</th>
			</tr>
		</thead>
		<tbody>
			<tr> 			
				<td><c:out value="${companyVO.departmentA}" /></td>
				<td><c:out value="${companyVO.departmentB}" /></td>
				<td><c:out value="${companyVO.departmentC}" /></td>
				<td><c:out value="${companyVO.departmentD}" /></td>
				<td><c:out value="${companyVO.departmentE}" /></td>
				<td><c:out value="${companyVO.departmentF}" /></td>
			</tr>
		</tbody>
	</table>
	</div> --%>
	
	<div class="table-responsive">
 	<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
		<colgroup>		
			<col width="25%" />
			<col width="25%" />
			<col width="25%" />
			<col width="25%" />
		</colgroup>
		<thead>
			<tr>
				<th>합계</th>
				<th>훈련 징행중인 기업 수</th>
				<th>참여 대기중인 기업 수</th>
				<th>참여포기 기업 수</th>
			</tr>
		</thead>
		<tbody>
			<tr> 			
				<td><c:out value="${companyVO.statusTotalCnt}" /></td>
				<td><c:out value="${companyVO.status1}" /></td>
				<td><c:out value="${companyVO.status2}" /></td>
				<td><c:out value="${companyVO.status3}" /></td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<h2 class="title mt_50">훈련과정 현황</h2>
	<%-- <div class="left-area">
		<h3 class="title">대학연계형</h2>
		<div class="table-responsive">
	 	<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
			<colgroup>		
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th>훈련실시 과정 수</th>
					<th>전체중탈 과정 수</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				 
					<td><c:out value="${result[0].TRAINING_TOTAL}" /></td>
					<td><c:out value="${result[1].TRAINING_TOTAL}" /></td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
	
	<div class="right-area">
		<h3 class="title">고숙련마이스터과정</h2>
		<div class="table-responsive">
	 	<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
 
			<thead>
				<tr>
					<th>훈련실시 과정 수</th>
					<th>전체중탈 과정 수</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><c:out value="${result[2].TRAINING_TOTAL}" /></td>
					<td><c:out value="${result[3].TRAINING_TOTAL}" /></td>
				</tr>
			</tbody>
		</table>
		</div>
	</div> --%>
	<div class="table-responsive">
	
	<c:set var="dept_tot" value="0"/>
 	<c:set var="dept1_tot" value="0"/>
 	<c:set var="dept2_tot" value="0"/>
 	<c:set var="dept3_tot" value="0"/>
 	<c:set var="dept4_tot" value="0"/>
 	<c:set var="dept5_tot" value="0"/>
 	<c:set var="dept6_tot" value="0"/>
 	<c:set var="dept7_tot" value="0"/>
 	<c:set var="dept8_tot" value="0"/>
	
 	<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
		<colgroup>		
			<col width="11.111%" />
		    <col width="11.111%" />
		    <col width="11.111%" />
		    <col width="11.111%" />
		    <col width="11.111%" />
		    <col width="11.111%" />
		    <col width="11.111%" />
		    <col width="11.111%" />
		    <col width="11.111%" />
		</colgroup>
		<thead>
			<tr>
				<th>학과명</th>
				<th>기전융합공학과</th>
				<th>기계설계공학과</th>
				<th>강소기업경영학과</th>
				<th>기계설비제어공학과</th>
				<th>IT융합소프트웨어공학과</th>
				<th>스마트팩토리융합학과</th>
				<th>반도체디스플레이공학과 학사</th>
				<th>반도체디스플레이공학과 석사</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${deptList}" var="result" varStatus="status">
			<tr> 			
				<td>
					<c:choose>
						<c:when test="${status.count eq '1'}">훈련 진행중인 과정 수</c:when>
						<c:otherwise>전체 중도탈락 과정 수</c:otherwise>
					</c:choose>
				</td>
				<td><c:out value="${result.dept1}" /></td>
				<td><c:out value="${result.dept2}" /></td>
				<td><c:out value="${result.dept3}" /></td>
				<td><c:out value="${result.dept4}" /></td>
				<td><c:out value="${result.dept5}" /></td>
				<td><c:out value="${result.dept6}" /></td>
				<td><c:out value="${result.dept7}" /></td>
				<td><c:out value="${result.dept8}" /></td>
				
			 	<c:set var="dept1_tot" value="${dept1_tot + result.dept1}"/>
			 	<c:set var="dept2_tot" value="${dept2_tot + result.dept2}"/>
			 	<c:set var="dept3_tot" value="${dept3_tot + result.dept3}"/>
			 	<c:set var="dept4_tot" value="${dept4_tot + result.dept4}"/>
			 	<c:set var="dept5_tot" value="${dept5_tot + result.dept5}"/>
			 	<c:set var="dept6_tot" value="${dept6_tot + result.dept6}"/>
			 	<c:set var="dept7_tot" value="${dept7_tot + result.dept7}"/>
			 	<c:set var="dept8_tot" value="${dept8_tot + result.dept8}"/>
				
			</tr>
		</c:forEach>
			<tr> 			
				<td>합계</td>
				<td><c:out value="${dept1_tot}" /></td>
				<td><c:out value="${dept2_tot}" /></td>
				<td><c:out value="${dept3_tot}" /></td>
				<td><c:out value="${dept4_tot}" /></td>
				<td><c:out value="${dept5_tot}" /></td>
				<td><c:out value="${dept6_tot}" /></td>
				<td><c:out value="${dept7_tot}" /></td>
				<td><c:out value="${dept8_tot}" /></td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<div class="clearfix"></div>
	
 </div>