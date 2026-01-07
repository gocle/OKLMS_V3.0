<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="kr.co.gocle.oklms.comm.util.Config" %>
<c:set var="targetUrl" value="/lu/company/"/>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript">

	var targetUrl = "${targetUrl}";
	
	$(document).ready(function() {
		
	});
	
	/*====================================================================
		화면 초기화 
	====================================================================*/
	function loadPage() {
	
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

	/* 수정 페이지로 이동 */
	function fn_updt(){
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "goUpdateCompany.do";

		$("#frmCompany").attr("method", "post" );
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	/* 목록 페이지로 이동 */
	function fn_list(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompany.do";

		$("#frmCompany").attr("method", "post" );
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();	
	}
	
	/* 회원삭제 */
	function fn_del(){
		if( confirm("회원을 삭제하겠습니까?") ) {
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteCompany.do";

			$("#frmCompany").attr("method", "post" );
			$("#frmCompany").attr("action", reqUrl);
			$("#frmCompany").submit();	
		}
	}
	
</script>

<form:form modelAttribute="frmCompany">
<!-- 검색조건유지 필드 시작 -->
<input type="hidden" name="searchName" id="searchName" value="${companyVO.searchName}"/>
<input type="hidden" name="searchWord" id="searchWord" value="${companyVO.searchWord}"/>
</form:form>
<div id="">
	<h2>담당기업 현황</h2>
	<table class="type-write">
		<tbody>
			<tr>
				<th colspan="2">기업명</th>
				<td>${companyVO.companyName}></td>
			</tr>
			<tr>
				<th colspan="2">고용보험관리번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
				<td>
					${companyVO.employInsManageNo}
				</td>
			</tr>
			<tr>
				<th colspan="2">사업자등록번호</th>
				<td>
					${companyVO.companyNo}
				</td>
			</tr>
			<tr>
				<th colspan="2" rowspan="2">주소</th>
				<td>
				${companyVO.address}&nbsp;&nbsp;(${companyVO.zipCode})
				</td>
			</tr>
			<tr>
				<td class="border-left">${companyVO.addressDtl}</td>
			</tr>
			<tr>
				<th colspan="2">대표자</th>
				<td>${companyVO.ceo}</td>
			</tr>
			<tr>
				<th rowspan="6">담당자<br />연락처</th>
				<th class="sub-name">직위</th>
				<td>${companyVO.position}</td>
			</tr>
			<tr>
				<th class="border-left sub-name">성명</th>
				<td>${companyVO.name}</td>
			</tr>
			<tr>
				<th class="border-left sub-name">연락처</th>
				<td>
					${companyVO.telNo1}
					-
					${companyVO.telNo2}
					-
					${companyVO.telNo3}
				</td>
			</tr>
			<tr>
				<th class="border-left sub-name">휴대폰</th>
				<td>
					${companyVO.hpNo1}
					-
					${companyVO.hpNo2}
					-
					${companyVO.hpNo3}
				</td>
			</tr>
			<tr>
				<th class="border-left sub-name">팩스</th>
				<td>
					${ companyVO.faxNo1}
					-
					${companyVO.faxNo2}
					-
					${companyVO.faxNo3}
				</td>
			</tr>
			<tr>
				<th class="border-left sub-name">E-mail</th>
				<td>${companyVO.email}</td>
			</tr>
			<tr>
				<th colspan="2">선정일</th>
				<td>${companyVO.choiceDay}</td>
			</tr>
			<%-- <tr>
				<th colspan="2">업종</th>
				<td>
					<select id="bigBusinessType" name="bigBusinessType" onchange="" style="width:15%;" >
						<option value="00" ${companyVO.bigBusinessType == '00' ? 'selected="selected"' : '' }>::선택::</option>
						<option value="01" ${companyVO.bigBusinessType == '01' ? 'selected="selected"' : '' }>농업</option>
					</select>
					<select id="middleBusinessType" name="middleBusinessType" onchange="" style="width:15%;" >
						<option value="000" ${companyVO.middleBusinessType == '000' ? 'selected="selected"' : '' }>::선택::</option>
						<option value="011" ${companyVO.middleBusinessType == '011' ? 'selected="selected"' : '' }>작물 재배업</option>
						<option value="012" ${companyVO.middleBusinessType == '012' ? 'selected="selected"' : '' }>축산업</option>
						<option value="013" ${companyVO.middleBusinessType == '013' ? 'selected="selected"' : '' }>작물재배 및 축산 복합농업</option>
						<option value="014" ${companyVO.middleBusinessType == '014' ? 'selected="selected"' : '' }>작물재배 및 축산 관련 서비스업</option>
						<option value="015" ${companyVO.middleBusinessType == '015' ? 'selected="selected"' : '' }>수렵 및 관련 서비스업</option>
					</select>
					<select id="smailBusinessType" name="smailBusinessType" onchange="" style="width:15%;" >
						<option value="0000" ${companyVO.smailBusinessType == '0000' ? 'selected="selected"' : '' }>::선택::</option>
						<option value="0111" ${companyVO.smailBusinessType == '0111' ? 'selected="selected"' : '' }>곡물 및 기타 식량작물 재배업</option>
						<option value="0112" ${companyVO.smailBusinessType == '0112' ? 'selected="selected"' : '' }>채소, 화훼작물 및 종묘 재배업</option>
						<option value="0113" ${companyVO.smailBusinessType == '0113' ? 'selected="selected"' : '' }>과실, 음료용 및 향신용 작물 재배업</option>
						<option value="0114" ${companyVO.smailBusinessType == '0114' ? 'selected="selected"' : '' }>기타 작물 재배업</option>
						<option value="0115" ${companyVO.smailBusinessType == '0115' ? 'selected="selected"' : '' }>시설작물 재배업</option>
						<option value="0121" ${companyVO.smailBusinessType == '0121' ? 'selected="selected"' : '' }>소 사육업</option>
						<option value="0122" ${companyVO.smailBusinessType == '0122' ? 'selected="selected"' : '' }>양돈업</option>
						<option value="0123" ${companyVO.smailBusinessType == '0123' ? 'selected="selected"' : '' }>가금류 및 조류 사육업</option>
						<option value="0129" ${companyVO.smailBusinessType == '0129' ? 'selected="selected"' : '' }>기타 축산업</option>
						<option value="0130" ${companyVO.smailBusinessType == '0130' ? 'selected="selected"' : '' }>작물재배 및 축산 복합농업</option>
						<option value="0141" ${companyVO.smailBusinessType == '0141' ? 'selected="selected"' : '' }>작물재배 관련 서비스업</option>
						<option value="0142" ${companyVO.smailBusinessType == '0142' ? 'selected="selected"' : '' }>축산 관련 서비스업</option>
						<option value="0150" ${companyVO.smailBusinessType == '0150' ? 'selected="selected"' : '' }>수렵 및 관련 서비스업</option>
					</select>
				</td>
			</tr> --%>
			<tr>
				<th colspan="2">상시근로자수</th>
				<td>${companyVO.regularEmploymentCnt}명</td>
			</tr>
			<tr>
				<th colspan="2">기업구분</th>
				<td>
					<c:choose>
						<c:when test="${companyVO.companyDivCd == '01'}">대기업</c:when>
						<c:when test="${companyVO.companyDivCd == '02'}">중견기업</c:when>
						<c:when test="${companyVO.companyDivCd == '03'}">중소기업</c:when>
						<c:when test="${companyVO.companyDivCd == '04'}">공기업</c:when>
						<c:when test="${companyVO.companyDivCd == '05'}">교육기관</c:when>
						<c:when test="${companyVO.companyDivCd == '06'}"></</c:when>
					</c:choose>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">홈페이지 URL</th>
				<td>${companyVO.homepageUrl}</td>
			</tr>
			
			<tr>
				<th colspan="2">훈련참여상태</th>
				<td>
					<c:choose>
						<c:when test="${companyVO.traningStatusCd == '1'}">진행중</c:when>
						<c:when test="${companyVO.traningStatusCd == '2'}">참여대기</c:when>
						<c:when test="${companyVO.traningStatusCd == '3'}">참여포기</c:when>
					</c:choose>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">기업상태</th>
				<td>
					<c:choose>
						<c:when test="${companyVO.companyStatusCd == '1'}">정상</c:when>
						<c:when test="${companyVO.companyStatusCd == '2'}">폐업</c:when>
						<c:when test="${companyVO.companyStatusCd == '3'}">합병</c:when>
					</c:choose>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">관할 지부지사</th>
				<td>${companyVO.controlPlaceName}</td>
			</tr>
			
			
			
			<tr>
				<th rowspan="3">재학생<br />단계</th>
				<th class="sub-name">도제(참여기관명)</th>
				<td>${companyVO.stuLevelName1}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">Uni-Tech(참여기관명)</th>
				<td>${companyVO.stuLevelName2}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">IPP(참여기관명)</th>
				<td>${companyVO.stuLevelName3}</td>
			</tr>
			
			<tr>
				<th rowspan="4">재직자<br />단계</th>
				<th class="sub-name">단독기업형</th>
				<td>${companyVO.compLevelName1}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">대학연계형(참여기관명)</th>
				<td>${companyVO.compLevelName2}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">P-Tech(참여기관명)</th>
				<td>${companyVO.compLevelName3}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">고숙련마이스터(참여기관명)</th>
				<td>${companyVO.compLevelName4}</td>
			</tr>
			
			<tr>
				<th colspan="2">설립일자</th>
				<td>${companyVO.makeDay}</td>
			</tr>
			
			<tr>
				<th colspan="2">신용등급</th>
				<td>${companyVO.creditLevel}</td>
			</tr>
			
			<tr>
				<th colspan="2">자산총계</th>
				<td>${companyVO.assets}</td>
			</tr>
			
			<tr>
				<th colspan="2">부채총계</th>
				<td>${companyVO.liabilities}</td>
			</tr>
			
			<tr>
				<th colspan="2">자본총계</th>
				<td>${companyVO.equities}</td>
			</tr>
			<tr>
				<th colspan="2">매출액</th>
				<td>${companyVO.revenue}</td>
			</tr>
			
			<tr>
				<th colspan="2">영업이익</th>
				<td>${companyVO.operatingIncome}</td>
			</tr>
			<tr>
				<th colspan="2">당기순이익</th>
				<td>${companyVO.netIncome}</td>
			</tr>
			
			<tr>
				<th colspan="2">평가일자</th>
				<td>${companyVO.evalDay}</td>
			</tr>
			
			<tr>
				<th colspan="2">조회기관</th>
				<td>${companyVO.searchPlaceName}</td>
			</tr>
			
		</tbody>
	</table>

	<div class="btn-area align-right mt-010">
		<a href="#fn_list" onclick="javascript:fn_list();" onkeypress="this.onclick;" class="black">목록</a>
	</div>

</div><!-- E : content-area -->
