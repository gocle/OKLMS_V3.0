<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="kr.co.gocle.oklms.comm.util.Config" %>
<c:set var="targetUrl" value="/la/company/"/>
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
		
		var reqUrl = targetUrl + "goUpdateCompany.do";

		$("#frmCompany").attr("method", "post" );
		$("#frmCompany").attr("action", reqUrl);
		$("#frmCompany").submit();
	}
	
	/* 목록 페이지로 이동 */
	function fn_list(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listCompany.do";
		$("#companyId").val("");
		
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

<form id="frmCompany" name="frmCompany">
<input type="hidden" name="companyId" id="companyId" value="${companyVO.companyId}"/>
<!-- 검색조건유지 필드 시작 --> 
<input type="hidden" name="searchCompanyName" id="searchCompanyName" value="${companyVO.searchCompanyName}"/>
</form>
<table border="0" cellpadding="0" cellspacing="0" class="view-1" style="margin:0;">
	<tbody>
		<tr>
			<th width="132px">기업명</th>
			<td>
				${companyVO.companyName}	
			</td>      
			<th width="132px">사업자등록번호</th>
	  		<td>
				${companyVO.companyNo}	
	  		</td>  
		</tr>
		<tr>
			<th>고용보험관리번호</th>
			<td colspan="3">
				${companyVO.employInsManageNo}
			</td>
		</tr>		
		<%-- <tr>
			<th>업종</th>
			<td>
				${companyVO.businessType}
			</td>      
			<th>업태</th>
			<td>
				${companyVO.businessCondition}
			</td>    
		</tr> --%>
		<tr>
			<th>홈페이지</th>
			<td>
				${companyVO.homePage}
			</td>      
			<th>대표자명</th>
	  		<td>
				${companyVO.ceo}
	  		</td>  
		</tr>
		<tr>
			<th>주소</th>
			<td colspan="3">
				${companyVO.zipCode}&nbsp;&nbsp;${companyVO.address}
				</br>${companyVO.addressDtl}
			</td>      
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				${companyVO.telNo1}-${companyVO.telNo2}-${companyVO.telNo3}
			</td>   
			<th>팩스번호</th>
			<td>
				${companyVO.faxNo1}-${companyVO.faxNo2}-${companyVO.faxNo3}
			</td>   
		</tr>
		<tr>
				<th rowspan="4">담당자<br />연락처</th>
				<th class="sub-name">직위</th>
				<td colspan="2">${companyVO.position}</td>
			</tr>
			<tr>
				<th class="border-left sub-name">성명</th>
				<td colspan="2">${companyVO.name}</td>
			</tr>
			<tr>
				<th class="border-left sub-name">휴대폰</th>
				<td colspan="2">
					${companyVO.hpNo1}
					-
					${companyVO.hpNo2}
					-
					${companyVO.hpNo3}
				</td>
			</tr>
			<tr>
				<th class="border-left sub-name">E-mail</th>
				<td colspan="2">${companyVO.email}</td>
			</tr>
			<tr>
				<th>선정일</th>
				<td>${companyVO.choiceDay}</td>
				<th>상시근로자수</th>
				<td>${companyVO.regularEmploymentCnt}명</td>
			</tr>
			<tr>
				<th>기업구분</th>
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
				<th>홈페이지 URL</th>
				<td>${companyVO.homepageUrl}</td>
			</tr>
			
			<tr>
				<th>훈련참여상태</th>
				<td>
					<c:choose>
						<c:when test="${companyVO.traningStatusCd == '1'}">진행중</c:when>
						<c:when test="${companyVO.traningStatusCd == '2'}">참여대기</c:when>
						<c:when test="${companyVO.traningStatusCd == '3'}">참여포기</c:when>
					</c:choose>
				</td>
				<th>기업상태</th>
				<td>
					<c:choose>
						<c:when test="${companyVO.companyStatusCd == '1'}">정상</c:when>
						<c:when test="${companyVO.companyStatusCd == '2'}">폐업</c:when>
						<c:when test="${companyVO.companyStatusCd == '3'}">합병</c:when>
					</c:choose>
				</td>
			</tr>
			
			<tr>
				<th>관할 지부지사</th>
				<td colspan="3">${companyVO.controlPlaceName}</td>
			</tr>
			
			<tr>
				<th rowspan="3">재학생<br />단계</th>
				<th class="sub-name">도제(참여기관명)</th>
				<td colspan="2">${companyVO.stuLevelName1}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">Uni-Tech(참여기관명)</th>
				<td colspan="2">${companyVO.stuLevelName2}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">IPP(참여기관명)</th>
				<td colspan="2">${companyVO.stuLevelName3}</td>
			</tr>
			
			<tr>
				<th rowspan="4">재직자<br />단계</th>
				<th class="sub-name">단독기업형</th>
				<td colspan="2">${companyVO.compLevelName1}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">대학연계형(참여기관명)</th>
				<td colspan="2">${companyVO.compLevelName2}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">P-Tech(참여기관명)</th>
				<td colspan="2">${companyVO.compLevelName3}</td>
			</tr>
			
			<tr>
				<th class="border-left sub-name">고숙련마이스터(참여기관명)</th>
				<td colspan="2">${companyVO.compLevelName4}</td>
			</tr>
			
			<tr>
				<th>설립일자</th>
				<td>${companyVO.makeDay}</td>
				<th>신용등급</th>
				<td>${companyVO.creditLevel}</td>
			</tr>
			
			<tr>
				<th>자산총계</th>
				<td>${companyVO.assets}</td>
				<th>부채총계</th>
				<td>${companyVO.liabilities}</td>
			</tr>
			
			<tr>
				<th>자본총계</th>
				<td>${companyVO.equities}</td>
				<th>매출액</th>
				<td>${companyVO.revenue}</td>
			</tr>
			
			<tr>
				<th>영업이익</th>
				<td>${companyVO.operatingIncome}</td>
				<th>당기순이익</th>
				<td>${companyVO.netIncome}</td>
			</tr>
			
			<tr>
				<th>평가일자</th>
				<td>${companyVO.evalDay}</td>
				<th>조회기관</th>
				<td>${companyVO.searchPlaceName}</td>				
			</tr>
	</tbody>
</table><!-- E : view-1 -->
<div class="page-btn">
	<a href="#fn_updt" onclick="javascript:fn_updt();" onkeypress="this.onclick;">수정</a>
	<a href="#fn_list" onclick="javascript:fn_list();" onkeypress="this.onclick;">목록</a>
</div><!-- E : page-btn -->	
		
