<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <script type="text/javascript" src="${contextRootJS }/js/jquery/plugins/blockUI/jquery.blockUI.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/jquery/jquery.maskedinput.js"></script> --%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

<script type="text/javascript">
    var count = 2;
	var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
	var totalCount = '${totalCount}'; //전체 데이터 갯수
	var pageIndex = '${pageIndex}'; //현재 페이지 정보

	$(document).ready(function() {
		if ('' == pageSize) {
			pageSize = 10;
		}
		if ('' == totalCount) {
			totalCount = 0;
		}
		if ('' == pageIndex) {
			pageIndex = 1;
		}

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
		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
		//기업체 검색 팝업 조회 성공여부
		var returnMsg = "";
		returnMsg = '${returnMsg}';
		var cnt = '${resultTraningProcessListCnt}';
		var tdOffJtTotalCnt = '${tdOffJtTotalCnt}';

		$("#companyId").val('${tempCompanyId}');
	//	$("#companyName").html('${tempCompanyName}');
		$("#address").html('${tempAddress}');
		$("#choiceDay").html('${tempChoiceDay}');
		$("#employInsManageNo").html('${tempEmployInsManageNo}');

		$("#tempCompanyName").val('${tempCompanyName}');
		$("#tempAddress").val('${tempAddress}');
		$("#tempChoiceDay").val('${tempChoiceDay}');
		$("#tempEmployInsManageNo").val('${tempEmployInsManageNo}');

		if('POPUP_LIST_FAIL' != returnMsg && returnMsg != ''){
			$("#searchKeyword").val('${searchKeyword}');
			fn_showCompanypop();
		}
		
		if(cnt == '' || cnt == '0'){
			if(cnt == '0'){
				$(".list-show").hide();
				$(".list-hide").show();
			} else {
				$(".list-show").show();
				$(".list-hide").hide();
			}

			$("#styleDisplay1").hide();
			$("#styleDisplay2").hide();
		} else {
			$(".list-show").hide();
			$(".list-hide").show();
			$("#styleDisplay1").show();

			if(tdOffJtTotalCnt != '' && tdOffJtTotalCnt != '0'){
				$("#styleDisplay2").show();
			}
		}
	}

	/*====================================================================
		사용자 정의 함수
	====================================================================*/

	
	
	//Off-JT 교과목 검색 메핑
	function fn_lectureSearchPopup(gubun){
		//$("#uiGubun").val( 'tableTraningProcessPop' );
		//$("#returnUrl").val( '/lu/popup/searchSubjectNameListPopup' );
		$("#count").val( '1' );
		$("#subjectTraningType").val( gubun );

		popOpenWindow("", "popSearch", 850, 560);

		var reqUrl = CONTEXT_ROOT + "/lu/popup/goPopupSearchSubjectName.do";

		$("#frmPopupSearch").attr("target", "popSearch");
		$("#frmPopupSearch").attr("action", reqUrl);
		$("#frmPopupSearch").submit();
	}
	
	//OJT 행추가
	function fn_addTR(subjType, subjInfo){
		//행추가할때마다 행개수 +1
        ++count;
        var htmlStr = "";
        if( subjInfo )
        {
			var arrInfo = subjInfo.split("||");
			var yyyy = arrInfo[0];
			var term = arrInfo[1];
			var subjectCode = arrInfo[2];
			var subClass = arrInfo[3];
			var subjectName = arrInfo[4];
			var parmCount = arrInfo[5];
			
			
	        if(subjType == "OFF")
	       	{
	        	if($("#offSubjectNameTd").html() == "")
	       		{
		        	//첫줄인경우
	        		$("#offSubjectNameTd").text(subjectName);
	        		$("#offSubjectClassTd").text(subClass);
	
	        		htmlStr = $("#offSubjTr").html();
	        		htmlStr += "<input type='hidden' id='yyyy' name='yyyy' value='"+yyyy+"' />";
	                htmlStr += "<input type='hidden' id='term' name='term' value='"+term+"' />";
	                htmlStr += "<input type='hidden' id='subjectCode' name='subjectCode' value='"+subjectCode+"' />";
	                htmlStr += "<input type='hidden' id='subClass' name='subClass' value='"+subClass+"'/>";
	                htmlStr += "<input type='hidden' id='subjectName' name='subjectName' value='"+subjectName+"' />";
	                htmlStr += "<input type='hidden' id='subjType' name='subjType' value='"+subjType+"' />";
	                htmlStr += "<input type='hidden' id='subjInfo' name='subjInfo' value='"+subjInfo+"' />";
	                
	                $("#offSubjTr").html(htmlStr);
	       		}
	        	else
	       		{
		        	//두번째줄 이상인경우
	                htmlStr += "<tr id='"+subjType+"tr-"+count+"'>";
	                //htmlStr += "<td>"+count+"</td>";
	                htmlStr += "<td>Off-JT</td>";
	                htmlStr += "<td class='left'>"+subjectName+"</td>";
	                htmlStr += "<td>"+subClass+"</td>";
	                htmlStr += "<td> - </td>";
	                htmlStr += "<td><a href='#fn_delTR' onclick='javascript:fn_delTR(\""+subjType+"tr-"+count+"\");' class='btn-minus'>삭제</a>";
	
	                htmlStr += "<input type='hidden' id='yyyy' name='yyyy' value='"+yyyy+"' />";
	                htmlStr += "<input type='hidden' id='term' name='term' value='"+term+"' />";
	                htmlStr += "<input type='hidden' id='subjectCode' name='subjectCode' value='"+subjectCode+"' />";
	                htmlStr += "<input type='hidden' id='subClass' name='subClass' value='"+subClass+"'/>";
	                htmlStr += "<input type='hidden' id='subjectName' name='subjectName' value='"+subjectName+"' />";
	                htmlStr += "<input type='hidden' id='subjType' name='subjType' value='"+subjType+"' />";
	                htmlStr += "<input type='hidden' id='subjInfo' name='subjInfo' value='"+subjInfo+"' />";
	                htmlStr += "</td>";
	
	                htmlStr += "</tr>";
	
	                if($("[id^='OFFtr-']").length == 0)
                	{
	                	 $("#offSubjTr").after(htmlStr);
                	}
	                else
                	{
	                	$("[id^='OFFtr-']").last().after(htmlStr);
                	}
	       		}
	       	}
	        else
	       	{
	        	if($("#ojtSubjectNameTd").html() == "")
	       		{
	        		//첫줄인경우
	        		$("#ojtSubjectNameTd").html(subjectName);
	        		$("#ojtSubjectClassTd").html(subClass);
	
	        		htmlStr = $("#ojtSubjTr").html();
	        		htmlStr += "<input type='hidden' id='yyyy' name='yyyy' value='"+yyyy+"' />";
	                htmlStr += "<input type='hidden' id='term' name='term' value='"+term+"' />";
	                htmlStr += "<input type='hidden' id='subjectCode' name='subjectCode' value='"+subjectCode+"' />";
	                htmlStr += "<input type='hidden' id='subClass' name='subClass' value='"+subClass+"'/>";
	                htmlStr += "<input type='hidden' id='subjectName' name='subjectName' value='"+subjectName+"' />";
	                htmlStr += "<input type='hidden' id='subjType' name='subjType' value='"+subjType+"' />";
	                htmlStr += "<input type='hidden' id='subjInfo' name='subjInfo' value='"+subjInfo+"' />";
	                
	                $("#ojtSubjTr").html(htmlStr);
	       		}
	        	else
	       		{
	        		//두번째줄 이상인경우
	                htmlStr += "<tr id='"+subjType+"tr-"+count+"'>";
	                //htmlStr += "<td>"+count+"</td>";
	                htmlStr += "<td>"+subjType+"</td>";
	                htmlStr += "<td class='left'>"+subjectName+"</td>";
	                htmlStr += "<td>"+subClass+"</td>";
	                htmlStr += "<td> - </td>";
	                htmlStr += "<td><a href='#fn_delTR' onclick='javascript:fn_delTR(\""+subjType+"tr-"+count+"\");' class='btn-minus'>삭제</a>";
	
	                htmlStr += "<input type='hidden' id='yyyy' name='yyyy' value='"+yyyy+"' />";
	                htmlStr += "<input type='hidden' id='term' name='term' value='"+term+"' />";
	                htmlStr += "<input type='hidden' id='subjectCode' name='subjectCode' value='"+subjectCode+"' />";
	                htmlStr += "<input type='hidden' id='subClass' name='subClass' value='"+subClass+"'/>";
	                htmlStr += "<input type='hidden' id='subjectName' name='subjectName' value='"+subjectName+"' />";
	                htmlStr += "<input type='hidden' id='subjType' name='subjType' value='"+subjType+"' />";
	                htmlStr += "<input type='hidden' id='subjInfo' name='subjInfo' value='"+subjInfo+"' />";
	                htmlStr += "</td>";
	
	                htmlStr += "</tr>";
	
	                $("#traningLecTable").append(htmlStr);
	       		}
	       	}
        }
	}
	
	//OJT 행삭제
	function fn_delTR(param1){

		if(param1 == "OFFALL")
		{
			$("[id^='OFFtr-']").each(function(index)
			{
				$(this).remove();
			});
			
			$("#offSubjTr").find(":hidden").each(function(index)
			{
				$(this).remove();
			});
			
			$("#offSubjectNameTd").html("");
			$("#offSubjectClassTd").html("");
		}
		else if(param1 == "OJTALL")
		{
			$("[id^='OJTtr-']").each(function(index)
			{
				$(this).remove();
			});
			
			$("#ojtSubjTr").find(":hidden").each(function(index)
			{
				$(this).remove();
			});
			
			$("#ojtSubjectNameTd").html("");
			$("#ojtSubjectClassTd").html("");
		}
		else
		{
			$('#'+param1).remove();
		}
	}
	
	function fn_formSave(){
		if($("#nextYyyy").val() == ""){
			alert("변경할 학년도를 선택 해주세요.");
			return false;
		}

		if($("#nextTerm").val() == ""){
			alert("변경 할 학기를 선택 해주세요.");
			return false;
		}

		//개셜강좌 메핑 행추가 없이 저장시
		//if($("#offSubjTr").find(":hidden").length == 0)
		//{
		//	alert("Off-JT 과정이 선택되지 않았습니다.\n과정을 추가해 주세요.");
		//	return false;
		//}
		
		if($("#ojtSubjTr").find(":hidden").length == 0)
		{
			alert("OJT 과정이 선택되지 않았습니다.\n과정을 추가해 주세요.");
			return false;
		}
		
		var count = 0;
		var insForm = "";
		$("#frmTraning").find("[id^='yyyy']").each(function(index)
		{
			insForm = $("<input type='hidden' name='yyyy"+(index+1)+"' value='"+$(this).val() +"' />");
			$("#frmTraning").append(insForm);
			count++;
		});
		
		$("#frmTraning").find("[id^='term']").each(function(index)
		{
			insForm = $("<input type='hidden' name='term"+(index+1)+"' value='"+$(this).val()+"' />");
			$("#frmTraning").append(insForm);
		});
		
		$("#frmTraning").find("[id^='subjectCode']").each(function(index)
		{
			insForm = $("<input type='hidden' name='subjectCode"+(index+1)+"' value='"+$(this).val()+"' />");
			$("#frmTraning").append(insForm);
		});
		
		$("#frmTraning").find("[id^='subClass']").each(function(index)
		{
			insForm = $("<input type='hidden' name='subClass"+(index+1)+"' value='"+$(this).val()+"' />");
			$("#frmTraning").append(insForm);
		});
		
		$("#frmTraning").find("[id^='subjectName']").each(function(index)
		{
			insForm = $("<input type='hidden' name='subjectName"+(index+1)+"' value='"+$(this).val()+"' />");
			$("#frmTraning").append(insForm);
		});
		
		$("#count").val( count );
		
		var reqUrl = "/lu/term/updateTermSubject.do";
		
		if(confirm("변경하시겠습니까?")){
			$("#frmTraning").attr("action", reqUrl);
			$("#frmTraning").attr("target", "_self");
			$("#frmTraning").submit();
		}
	}



</script>

<form id="frmPopupSearch" name="frmTraning" method="post">
<input type="hidden" id="pageSize" name="pageSize" value="20" />
<input type="hidden" id="pageIndex" name="pageIndex" value="1" />
<input type="hidden" id="subjectTraningType" name="subjectTraningType" />
<input type="hidden" id="pointNotUseMigYn" name="pointNotUseMigYn" value="Y" />
</form>

<!-- 훈련과정관리용 끝 -->
<form id="frmTraning" name="frmTraning" method="post">
<input type="hidden" name="pageSize" value="${pageSize }" />
<input type="hidden" name="pageIndex" value="${pageIndex }" />
<input type="hidden" id="traningProcessId" name="traningProcessId" />
<input type="hidden" id="count" name="count" />
<input type="hidden" id="companyId" name="companyId" value="${companyId}" />
<input type="hidden" id="tempTraningProcessId" name="tempTraningProcessId" />
<input type="hidden" id="searchKeywordNull" name="searchKeywordNull"/>



	<div id="">
			<h2>학기 관리</h2>
	</div><!-- E : container -->

	<div class="search-box-1 mt-020 mb-010">
			학년도 : <select name="nextYyyy" id="nextYyyy"> 
						<option value="" >선택</option>
						<c:forEach var="i" begin="0" end="4" step="1">
							<option value="${nowYear-i+2}" <c:if test="${subjectVO.yyyy eq nowYear-i+2 }" > selected="selected"  </c:if>>${nowYear-i+2}학년도</option>
						</c:forEach>								
					</select> 

			
			
			&nbsp;&nbsp;학기 : <select name="nextTerm" id="nextTerm">
				<option value="">선택</option>
				<option value="1">1학기</option>
				<option value="2">2학기</option>
				<option value="3">여름학기</option>
				<option value="4">겨울학기</option>
			</select>
		</div><!-- E : search-box-1 -->
	
	<table class="type-2 mt-020" id="traningLecTable">
		<colgroup>
			<%-- <col style="width:40px" /> --%>
			<col style="width:80px" />
			<col style="width:*" />
			<col style="width:60px" />
			<col style="width:90px" />
			<col style="width:80px" />
		</colgroup>
		<thead>
			<tr>
				<!-- <th>번호</th> -->
				<th>구분</th>
				<th>개설강좌명</th>
				<th>분반</th>
				<th>교과목추가</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<tr id="ojtSubjTr">
				<td>OJT</td>
				<td class="left" id="ojtSubjectNameTd"></td>
				<td id="ojtSubjectClassTd"></td>
				<td><a href="#fn_ojtLectureSearchPopup" onclick="javascript:fn_lectureSearchPopup('OJT'); return false" class="btn-line-blue">검색</a></td>
				<td>
					<a href="#fn_delTR" onclick="javascript:fn_delTR('OJTALL'); return false">전체삭제</a>
				</td>
			</tr>
		</tbody>
				</table>


	<div class="btn-area align-right mt-010">
	<br/>
	<p><font color="blue"><b>추가 된 과정 (학년도,학기,담당교수,학습근로자,기업현장교사 등) 의 정보(학년도,학기)를 선택한 학년도,학기로 변경합니다.</b></font></p>
	<br/><br/>
		<!-- <a href="#fn_ojtLectureSearchPopup" class="gray-1" onclick="javascript:fn_lectureSearchPopup('OJT'); return false">검색</a> -->
		<a href="#fn_formSave" class="orange" onclick="javascript:fn_formSave();">수정</a>
	</div><!-- E : btn-area -->
</div><!-- E : 훈련과정명 -->

<script type="text/javascript">

 
</script>

</form>


