<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript">

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

	function press(event) {
		if (event.keyCode==13) {
			fn_search();
		}
	}

	/* 리스트 조회 */
	function fn_search( ){

		var reqUrl = "/lu/weektraning/popupWeekTraningNote.do";
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();


	}

	//선택 버튼을 클릭시 부모창에 필요항목 셋팅
	function fn_selectInfo(){
		if( opener ){
			var obj = "";
			obj = $("input:radio[name='tempId']:checked").val();

			if(undefined == obj){
				alert("기업체를 선택하여주십시오. ")
				return false;
			}

			opener.fn_setWeekTraningCompanyInfo(obj);

			window.close();
		}
	}

	function fn_closeWin(){
		window.close();
	}

</script>

<!-- 회원정보 팝업용 끝 -->
<form id="frmMember" name="frmMember" method="post">
	<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->
		<div id="pop-wrapper" class="min-w650">

			<h1>재직증빙서류 제출현황 (학기별)</h1>
			<table class="type-1 mb-010">
				<colgroup>
					<col style="width:120px" />
					<col style="width:190px" />
					<col style="width:120px" />
					<col style="width:*" />
				</colgroup>
				<tbody>
					<tr>
						<th>학년도</th>
						<td>${workCertVO.yyyy } 학년도</td>
						<th>학기</th>
						<td>${workCertVO.term } 학기</td>
					</tr>
				</tbody>
			</table>



			<table class="type-2">
				<colgroup>

					<col style="width:70px" />
					<col style="width:115px" />
					<col style="width:*" />
					<col style="width:115px" />
					<col style="width:100px" />
				</colgroup>
				<thead>
					<tr>

						<th>입학년도</th>
						<th>학습근로자 인원</th>
						<th>4대보험 가입증명서</th>
						<th>원천징수 영수증</th>
						<th>보완서류</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status" >
					<tr>
						<td>${result.yyyy }</td>
						<td>${result.insTot }명</td>
						<td>${result.recTot } 명</td>
						<td>${result.docTot } 명</td>
						<td>${result.stateTot }</td>
					</tr>
				</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="5"><spring:message code="common.nodata.msg" /></td>
						</tr>
					</c:if>

				</tbody>
			</table>



			<div class="btn-area align-center mt-010" style="border-top:1px solid #CCC; padding-top:20px;">
				<a href="#!" class="yellow">프린트</a><a href="#!" class="orange">엑셀 다운로드</a><a href="javascript:fn_closeWin();" class="gray-3">닫기</a>
			</div>


		</div><!-- E : wrapper -->
</form>


