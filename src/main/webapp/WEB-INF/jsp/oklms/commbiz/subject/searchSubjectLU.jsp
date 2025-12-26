<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

<div class="search-box-0"><input type="radio" name="searchType"  id="searchType1" value="TERM"  <c:if test="${subjectVO.searchType eq 'TERM' }" > checked="checked"  </c:if> class="choice" /> 학기단위로 보기&nbsp;&nbsp;&nbsp;<input type="radio" name="searchType"   id="searchType2" value="WEEK" <c:if test="${subjectVO.searchType eq 'WEEK' }" > checked="checked"  </c:if> class="choice" /> 주단위로 보기</div>
	<dl id="tab-type">
		<dt class="tab-name-11 on"><a href="javascript:showTabbtn1();">OJT</a></dt>
		<dd id="tab-content-11" style="display:block;">
	
			<div class="search-box-1 mt-020 mb-020">
				<input type="radio" name="radio1" class="choice" checked /> 학점형&nbsp;&nbsp;&nbsp;
				<input type="radio" name="radio1" class="choice" /> 비학점형&nbsp;&nbsp;&nbsp;
				<select name="yyyy" id="yyyy" > 
					<option value="" >학년도</option>
					<c:forEach var="i" begin="0" end="2" step="1">
						<option value="${nowYear-i}" <c:if test="${subjectVO.yyyy eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}학년도</option>
					</c:forEach>								
				</select> 
				<select name="term" id="term">
					<option value="" >학기</option>
					<option value="1" <c:if test="${subjectVO.term eq '1' }" > selected="selected"  </c:if>>1학기</option>
					<option value="2" <c:if test="${subjectVO.term eq '2' }" > selected="selected"  </c:if>>2학기</option>
					<option value="3" <c:if test="${subjectVO.term eq '3' }" > selected="selected"  </c:if>>여름학기</option>
					<option value="4" <c:if test="${subjectVO.term eq '4' }" > selected="selected"  </c:if>>겨울학기</option>
				</select>
				<select name="subjectGrade" id="subjectGrade">
					<option value="">대상학년</option>
					<option value="1" <c:if test="${subjectVO.subjectGrade eq '1' }" > selected="selected"  </c:if>>1</option>
					<option value="2" <c:if test="${subjectVO.subjectGrade eq '2' }" > selected="selected"  </c:if>>2</option>
					<option value="3" <c:if test="${subjectVO.subjectGrade eq '3' }" > selected="selected"  </c:if>>3</option>
					<option value="4" <c:if test="${subjectVO.subjectGrade eq '4' }" > selected="selected"  </c:if>>4</option>
				</select>
				<select id=subjectType id="subjectType">
					<option value="">과정구분</option>
					<option value="NORMAL" <c:if test="${subjectVO.subjectGrade eq 'NORMAL' }" > selected="selected"  </c:if>>학부</option>
					<option value="HSKILL" <c:if test="${subjectVO.subjectGrade eq 'HSKILL' }" > selected="selected"  </c:if>>고숙련</option>
				</select>
				<input type="text" name="" id="" value="" style="width:70px;" /><input type="text" name="" id="" value="" style="width:100px;" /><a href="#!" onclick="javascript:fn_search();">검색</a>
			</div><!-- E : search-box-1 -->
	
			<ul class="page-sum bg-none mb-007">
				<li class="float-right">
					PAGE VIEW : <input type="radio" name="radio" value="" checked> 10
					<input type="radio" name="radio" value=""> 20
					<input type="radio" name="radio" value=""> 50
					Lines
				</li>
			</ul>
	
	