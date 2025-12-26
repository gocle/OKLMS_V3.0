<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
				<caption>학년도 학기 교과목명 과목코드 학점 담당교수명에 대한 정보 제공</caption>
				<colgroup>
					<col style="width:15%" />
					<col style="width:*px" />
					<col style="width:15%" />
				</colgroup>
				<tr>
					<th scope="row">학년도</th>
					<td>${currProcVO.yyyy}학년도</td>
					<th scope="row">학기</th>
					<td>${currProcVO.termName}</td>
				</tr>
				<tr>
					<th scope="row">교과목명</th>
					<td>${currProcVO.subjectName}</td>
					<th scope="row">과목코드</th>
					<td>${currProcVO.subjectCode}</td>
				</tr>
				<tr>
					<th scope="row">학점</th>
					<td>${currProcVO.point}</td>
					<th scope="row">담당교수명</th>
					<td>${currProcVO.insNames}</td>
				</tr>
				<tr>
					<th>표기예시</th>
					<td colspan="3">( O : 출석 , △ : 지각 , X : 결석 ,  : 미체크 )</td>
				</tr>
			</table>
 
	
			<table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
				  	<caption>번호 학변 이름 학과 학년 주차 출석일수 지각일수 결석일수에 대한 정보를 제공합니다</caption>
					<tr>
						<th scope="col" rowspan="2">번호</th>
						<th scope="col" rowspan="2">학번</th>
						<th scope="col" rowspan="2">이름</th>
						<th scope="col" rowspan="2">학과</th>
						<th scope="col" rowspan="2">학년</th>
						<th scope="col" colspan="15">주차</th>
						<th scope="col" rowspan="2">출석일수</th>
						<th scope="col" rowspan="2">지각일수</th>
						<th scope="col" rowspan="2">결석일수</th>
					</tr>
					<tr>
						<th scope="col" class="border-left">1</th>
						<th scope="col">2</th>
						<th scope="col">3</th>
						<th scope="col">4</th>
						<th scope="col">5</th>
						<th scope="col">6</th>
						<th scope="col">7</th>
						<th scope="col">8</th>
						<th scope="col">9</th>
						<th scope="col">10</th>
						<th scope="col">11</th>
						<th scope="col">12</th>
						<th scope="col">13</th>
						<th scope="col">14</th>
						<th scope="col">15</th>
					</tr>
		 
				
						
						
				<c:forEach var="resultlist" items="${resultlist}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${resultlist.memId }</td>
						<td class="left">${resultlist.memName }</td>
						<td>${resultlist.deptName }</td>
						<td>${resultlist.level}</td>
						<td>
						
						<c:set var="x_cnt" value="0"/>
						<c:set var="o_cnt" value="0"/>
						<c:set var="t_cnt" value="0"/>
						
							<c:if test="${resultlist.nextWeek>=1 }">
								<c:if test="${resultlist.te1 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
								<c:if test="${resultlist.te1 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
								<c:if test="${resultlist.te1 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=2 }">
								<c:if test="${resultlist.te2 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
								<c:if test="${resultlist.te2 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
								<c:if test="${resultlist.te2 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=3 }">
							<c:if test="${resultlist.te3 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te3 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te3 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=4 }">
							<c:if test="${resultlist.te4 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te4 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te4 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=5 }">
							<c:if test="${resultlist.te5 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te5 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te5 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=6 }">
							<c:if test="${resultlist.te6 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te6 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te6 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=7 }">
							<c:if test="${resultlist.te7 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te7 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te7 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=8 }">
								<c:if test="${param.searchCondition eq 'offline' }">
									<c:if test="${resultlist.te8 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
									<c:if test="${resultlist.te8 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
									<c:if test="${resultlist.te8 eq '2'}" >△</c:if>
								</c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=9 }">
							<c:if test="${resultlist.te9 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te9 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te9 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=10 }">
							<c:if test="${resultlist.te10 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te10 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te10 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=11 }">
							<c:if test="${resultlist.te11 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te11 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te11 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=12 }">
							<c:if test="${resultlist.te12 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te12 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te12 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=13 }">
							<c:if test="${resultlist.te13 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te13 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te13 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=14 }">
							<c:if test="${resultlist.te14 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
							<c:if test="${resultlist.te14 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
							<c:if test="${resultlist.te14 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
							</c:if>
						</td>
						<td>
							<c:if test="${resultlist.nextWeek>=15 }">
								<c:if test="${param.searchCondition eq 'offline' }">
									<c:if test="${resultlist.te15 eq '0'}" >X<c:set var="x_cnt" value="${x_cnt+1}"/></c:if>
									<c:if test="${resultlist.te15 eq '1'}" >O<c:set var="o_cnt" value="${o_cnt+1}"/></c:if> 
									<c:if test="${resultlist.te15 eq '2'}" >△<c:set var="t_cnt" value="${t_cnt+1}"/></c:if>
								</c:if>
							</c:if>
						</td>	
						<td>${o_cnt}</td>
						<td>${t_cnt}</td>
						<td>${x_cnt}</td>				
					</tr>
				</c:forEach>
  
			</table><!-- E : 전체 학습근로자관리-->
  