<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%-- <script type="text/javascript" src="${contextRootJS }/js/jquery/plugins/blockUI/jquery.blockUI.js"></script>
<script type="text/javascript" src="${contextRootJS }/js/jquery/jquery.maskedinput.js"></script> --%>
<script type="text/javascript">

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
	//	$("#address").html('${tempAddress}');
	//	$("#choiceDay").html('${tempChoiceDay}');
	//	$("#employInsManageNo").html('${tempEmployInsManageNo}');

	//	$("#tempCompanyName").val('${tempCompanyName}');
	//	$("#tempAddress").val('${tempAddress}');
	//	$("#tempChoiceDay").val('${tempChoiceDay}');
	//	$("#tempEmployInsManageNo").val('${tempEmployInsManageNo}');

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
		
			//if(tdOffJtTotalCnt != '' && tdOffJtTotalCnt != '0'){
				$("#styleDisplay2").show();
				$("#styleDisplay3").show();
			//}
		}
	}

	/*====================================================================
		사용자 정의 함수
	====================================================================*/
	function press(event) {
		if (event.keyCode==13) {
			fn_search('1');
		}
	}

	/* 기업체 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = "/lu/traning/listTraningProcessSubject.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//초기화 기업체 리스트 조회
	function fn_searchKeywordNo( param1 ){
		$("#searchKeywordNull").val('allSearch');
		$("#frmTraningpageIndex").val( param1 );

		//var reqUrl = "/lu/popup/goPopupSearch.do";
		var reqUrl = "/lu/traning/listTraningProcessSubject.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//기업체검색 목록에서 페이징 번호 클릭시 리스트 조회
	function fn_searchPaging( param1 ){
		$("#pageIndex").val( param1 );
		var reqUrl = "/lu/traning/listTraningProcessSubject.do";
		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//훈련과정 추가 신규입력화면 이동
	function fn_goInsert(){

		if($("#companyId").val() == ''){
			alert("기업체 정보가 없습니다. 기업체 검색 버튼을 클릭하여 기업체를 선택하여주십시오.");
			return false;
		}

		var reqUrl = "/lu/traning/goInsertTraningProcessManageList.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//훈련과정관리에 메핑된 개설강좌 목록 조회
	function fn_detail(param1, param2, param3){
		$("#companyId").val(param1);
		$("#traningProcessId").val(param2);
		$("#traningProcessManageId").val(param3);
		
		$("#tempTraningProcessId").val('noDivPopup');

		var reqUrl = "/lu/traning/listTraningProcessSubject.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//기업체검색후 기업체 훈련과정 메핑 목록 조회
	function fn_listTraningProcessManage( param1 ){

		$("#companyId").val(param1);
		$("#tempTraningProcessId").val('noDivPopup');
		$("#pageIndex").val("1");
		

		var reqUrl = "/lu/traning/listTraningProcessSubject.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	function fn_showCompanypop( ){
		$("#student-popup").show();
		$(".company-area,.popup-bg").addClass("open");
		window.location.hash = "#open";
	}

	function fn_closeCompanypop( ){
		$("#student-popup").hide();
		$(".company-area,.popup-bg").removeClass("open");
	}

	function fn_hideCompanypop( ){
		var obj = "";
		obj = $("input:radio[name='tempCompanyId']:checked").val();
		if(undefined == obj){
			alert("훈련과정관리를 처리할 하나의 기업체를 선택하여주십시오. ")
			return false;
		} else {
			$(".company-area,.popup-bg").removeClass("open");
			fn_setCompanypopInfo(obj);
		}
	}

	// 기업체 정보 셋팅
	function fn_setCompanypopInfo(obj){
		if( obj ){
			var arrInfo = obj.split("||");
			var companyId = arrInfo[0];
			var companyName = arrInfo[1];
			var address = arrInfo[2];
			var choiceDay = arrInfo[3];
			var employInsManageNo = arrInfo[4];

			$("#companyId").val(companyId);
			$("#companyName").html(companyName);
			$("#address").html(address);
			$("#choiceDay").html(choiceDay);
			$("#employInsManageNo").html(employInsManageNo);

			//서버단에서 사용하기위해 Temp성 항목정의
			$("#tempCompanyName").val(companyName);
			$("#tempAddress").val(address);
			$("#tempChoiceDay").val(choiceDay);
			$("#tempEmployInsManageNo").val(employInsManageNo);
			//companyId 값이 있으면 훈련과정명 및 훈련과정번호 정보를 가지고올 Json 서버로직을 수행한다.
			if(companyId != ''){
				fn_listTraningProcessManage( companyId );
			} //companyId 비교 if문 End
		} //obj 훈련과정마스터에 메핑된 개설강좌 정보 if문 End
	}

	//훈련과정 마스터 및 개설강좌 메핑 데이타 삭제
	function fn_delete(){
		if (confirm("삭제 하시겠습니까?")) {

			var obj = "";
			obj = $("input:radio[name='traningProcessIdArr']:checked").val();
			if(undefined == obj){
				alert("삭제 처리할 훈련과정을 선택하여주십시오. ")
				return false;
			}

			var reqUrl = "/lu/traning/deleteTraningProcessManage.do";

			$("#frmTraning").attr("action", reqUrl);
			$("#frmTraning").attr("target", "_self");
			$("#frmTraning").submit();
		}
	}

	//훈련과정 수정화면으로 이동
	function fn_goUpdate( ){

		var obj = "";
		obj = $("input:radio[name='traningProcessIdArr']:checked").val();
		if(undefined == obj){
			alert("수정 처리할 훈련과정을 선택하여주십시오. ")
			return false;
		}

		var reqUrl = "/lu/traning/goUpdateTraningProcessManageList.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	//훈련과정 첫화면으로 이동
	function fn_goList( ){
		$("#companyId").val('');
		$("#traningProcessId").val('');
		$("#tempTraningProcessId").val('noDivPopup');

		var reqUrl = "/lu/traning/listTraningProcessSubject.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}
	
	function fn_info_save( ){
		var reqUrl = "/lu/traning/saveTraningProcessManage.json";
		var param = $("#frmTraning").serializeArray();
		com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		if (200 == jqXHR.status ) {
			
		} else {
			alert("저장에 실패했습니다.")
		}
		}, {
			async : true,
			type : "POST",
			errorCallback : null
		});
		
	}
	
	var count = '${ojtCnt}';
	++count;
	
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
			var termName = arrInfo[6];
			
			
	        if(subjType == "OFF")
	       	{
	        	if($("#offSubjectNameTd").html() == "")
	       		{
		        	//첫줄인경우
	        		$("#offSubjectNameTd").text(subjectName);
	        		$("#offSubjectClassTd").text(subClass);
	        		$("#offSubjectYyyyTd").text(yyyy+"년도");
	        		$("#offSubjectTermTd").text(term+"학기");
	
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
	                htmlStr += "<td>"+yyyy+"년도</td>";
	                htmlStr += "<td>"+termName+"</td>";
	                htmlStr += "<td>"+subClass+"</td>";
	                htmlStr += "<td> - </td>";
	                htmlStr += "<td><a href='#fn_delTR' onclick='javascript:fn_delTR(\""+subjType+"tr-"+count+"\");'>삭제</a>";
	
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
	         		$("#ojtSubjectYyyyTd").text(yyyy+"년도");
	        		$("#ojtSubjectTermTd").text(term+"학기");
	
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
	                htmlStr += "<td>"+yyyy+"년도</td>";
	                htmlStr += "<td>"+termName+"</td>";
	                htmlStr += "<td>"+subClass+"</td>";
	              
	                htmlStr += "<td> - </td>";
	                htmlStr += "<td><a href='#fn_delTR' onclick='javascript:fn_delTR(\""+subjType+"tr-"+count+"\");'>삭제</a>";
	
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

	// 교과목 검색 메핑
	function fn_lectureSearchPopup(gubun){
		//$("#uiGubun").val( 'tableTraningProcessPop' );
		//$("#returnUrl").val( '/lu/popup/searchSubjectNameListPopup' );
		$("#count").val( '1' );
		$("#frmPopupSearch_subjectTraningType").val( gubun );

		popOpenWindow("", "popSearch", 850, 560);

		var reqUrl = CONTEXT_ROOT + "/lu/popup/goPopupSearchSubjectName.do";

		$("#frmPopupSearch").attr("target", "popSearch");
		$("#frmPopupSearch").attr("action", reqUrl);
		$("#frmPopupSearch").submit();
	}

	function fn_formUpdate(){
		if($("#traningProcessName").val() == ""){
			alert("훈련과정명을 넣어 주세요.");
			return false;
		}

		if($("#traningProcessNo").val() == ""){
			alert("훈련과정번호를 넣어 주세요.");
			return false;
		}

		//개셜강좌 메핑 행추가 없이 저장시
		if($("#offSubjTr").find(":hidden").length == 0)
		{
			alert("Off-JT 과정이 선택되지 않았습니다.\n과정을 추가해 주세요.");
			return false;
		}
		
		//if($("#ojtSubjTr").find(":hidden").length == 0)
		//{
		//	alert("OJT 과정이 선택되지 않았습니다.\n과정을 추가해 주세요.");
		//	return false;
		//}
		
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
		
		$("#frmTraning").find("[id^='subjectName']").each(function(index)
		{
			insForm = $("<input type='hidden' name='subjectName"+(index+1)+"' value='"+$(this).val()+"' />");
			$("#frmTraning").append(insForm);
		});
		
		$("#count").val( count );

		var reqUrl = "/lu/traning/updateTraningProcessManageList.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").attr("target", "_self");
		$("#frmTraning").submit();
	}
	
	function fn_formInsert(){
		if($("#traningProcessName").val() == ""){
			alert("훈련과정명을 선택 해주세요.");
			return false;
		}

		if($("#traningProcessNo").val() == ""){
			alert("훈련과정번호를 선택 해주세요.");
			return false;
		}

		//개셜강좌 메핑 행추가 없이 저장시
		if($("#offSubjTr").find(":hidden").length == 0)
		{
			alert("Off-JT 과정이 선택되지 않았습니다.\n과정을 추가해 주세요.");
			return false;
		}
		
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
		
		var reqUrl = "/lu/traning/insertTraningProcessManageList.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").attr("target", "_self");
		$("#frmTraning").submit();
	}

	//훈련과정 첫화면으로 이동
	function fn_goList( ){
		$("#companyId").val('');
		$("#traningProcessId").val('');
		$("#tempTraningProcessId").val('noDivPopup');

		var reqUrl = "/lu/traning/listTraningProcessManage.do";

		$("#frmTraning").attr("action", reqUrl);
		$("#frmTraning").submit();
	}

	
	function fn_formDelete(yyyy,term,subjectCode,subjectClass){
		
		$("#del_yyyy").val(yyyy);
		$("#del_term").val(term);
		$("#del_subjectCode").val(subjectCode);
		$("#del_subjectClass").val(subjectClass);
		
		var reqUrl = "/lu/traning/deleteTraningProcessManageList.do";

		$("#frmTraningDel").attr("action", reqUrl);
		$("#frmTraningDel").attr("target", "_self");
		$("#frmTraningDel").submit();
	}

</script>

<form id="frmTraningDel" name="frmTraningDel" method="post">
<input type="hidden" id="del_pageSize" name="pageSize" value="${pageSize }" />
<input type="hidden" id="del_pageIndex" name="pageIndex" value="${pageIndex }" />
<input type="hidden" id="del_companyId" name="companyId" value="${param.companyId }"/>
<input type="hidden" id="del_traningProcessId" name="traningProcessId" value="${param.traningProcessId }" />
<input type="hidden" id="del_uiGubun" name="uiGubun" value="traningProcessCompanyPop" />
<input type="hidden" id="del_menuGubun" name="menuGubun" value="subject" />
<input type="hidden" id="del_returnUrl" name="returnUrl" value="/lu/traning/traningProcessManageList" />
<input type="hidden" id="del_traningProcessManageId" name="traningProcessManageId" value="${param.traningProcessManageId }" />
<input type="hidden" id="del_yyyy" name="yyyy" value="" />
<input type="hidden" id="del_term" name="term" value="" />
<input type="hidden" id="del_subjectCode" name="subjectCode" value="" />
<input type="hidden" id="del_subjectClass" name="subClass" value="" />
<input type="hidden" id="del_tempCompanyId" name="tempCompanyId" value="${param.companyId }" />


</form>

<form id="frmPopupSearch" name="frmPopupSearch" method="post">
<input type="hidden" id="frmPopupSearch_pageSize" name="pageSize" value="20" />
<input type="hidden" id="frmPopupSearch_pageIndex" name="pageIndex" value="1" />
<input type="hidden" id="frmPopupSearch_subjectTraningType" name="subjectTraningType" />
</form>


<!-- 훈련과정관리용 끝 -->
<form id="frmTraning" name="frmTraning" method="post">
<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" />
<input type="hidden" id="companyId" name="companyId"/>
<input type="hidden" id="traningProcessId" name="traningProcessId" value="${param.traningProcessId }" />
<input type="hidden" id="uiGubun" name="uiGubun" value="traningProcessCompanyPop" />
<input type="hidden" id="menuGubun" name="menuGubun" value="subject" />
<input type="hidden" id="returnUrl" name="returnUrl" value="/lu/traning/traningProcessManageList" />
<input type="hidden" id="traningProcessManageId" name="traningProcessManageId" value="${param.traningProcessManageId }" />

<!-- Temp용 항목 -->
<input type="hidden" id="tempCompanyName" name="tempCompanyName"/>
<input type="hidden" id="tempAddress" name="tempAddress"/>
<input type="hidden" id="tempChoiceDay" name="tempChoiceDay"/>
<input type="hidden" id="tempEmployInsManageNo" name="tempEmployInsManageNo"/>
<input type="hidden" id="tempTraningProcessId" name="tempTraningProcessId" />
<input type="hidden" id="searchKeywordNull" name="searchKeywordNull"/>
<input type="hidden" id="count" name="count" />

<ul id="student-popup" style="display:none;">
	<li class="company-area" >
		<h1>기업체 검색</h1>
		<div class="search-box-1 mb-020">
			<input type="text" id="searchKeyword" name="searchKeyword" placeholder="기업명을 입력" value="${searchKeyword }"  class="mb-005" />
			<a href="#!" onclick="javascript:fn_search(1); return false"  class="mb-005" >조회</a>
			<a href="#!" onclick="javascript:fn_searchKeywordNo(1); return false"  class="mb-005" >전체조회</a>
		</div><!-- E : search-box-1 -->

		<div class="table-responsive">
			<table class="type-2 w800">
					<colgroup>
						<col width="7%" />
						<col width="24%" />
						<col width="*" />
						<col width="12%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>기업명</th>
							<th>소재지</th>
							<th>선정일</th>
							<th>고용보험관리번호</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultCompanyList}" varStatus="status">
						<tr>
							<td><input type="radio" name="tempCompanyId" id="tempCompanyId" value="${result.companyId}||${result.companyName}||${result.address}||${result.choiceDay}||${result.employInsManageNo}"></td>
							<td>${result.companyName}</td>
							<td class="left">${result.address}</td>
							<td>${result.choiceDay}</td>
							<td>${result.employInsManageNo}</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(resultCompanyList) == 0}">
						<tr>
							<td colspan="5"><spring:message code="common.nodata.msg" /></td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div><!-- E : 기업체검색 -->

			<c:if test="${fn:length(resultCompanyList) != 0}">
			<div class="page-num mt-015">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_searchPaging" />
			</div>
			</c:if>

		<div class="btn-area align-center mt-010">
			<a href="#fn_closeCompanypop" class="yellow close" onclick="javascript:fn_closeCompanypop(); return false" onkeypress="this.onclick();">닫기</a>
			<a href="#fn_hideCompanypop" class="orange close" onclick="javascript:fn_hideCompanypop(); return false" onkeypress="this.onclick();">확인</a>
		</div><!-- E : btn-area -->
	</li>

	<li class="popup-bg"></li>
</ul> <!-- E : student-popup -->

	<div id="">
			<h2><c:out value="${curMenu.menuTitle }" /></h2>
			<div class="group-area">
				<div class="table-responsive mt-010">
					<table class="type-2">
						<colgroup>
							<col style="width:*" />
							<col style="width:*" />
							<col style="width:*" />
							<col style="width:*" />
						</colgroup>
						<thead>
							<tr>
								<th>기업명</th>
								<th>소재지</th>
								<th>선정일</th>
								<th>기업고용보험관리번호</th>
							</tr>
						</thead>
						<tbody>
							<tr class="list-hide" style="display:none">
								<td id="companyName">${companyVO.companyName}</td>
								<td id="address">${companyVO.address}</td>
								<td id="choiceDay">${companyVO.choiceDay}</td>
								<td id="employInsManageNo">${companyVO.employInsManageNo}</td>
							</tr>
							<tr class="list-show">
								<td colspan="4">자료가 없습니다. 기업체 검색버튼을 클릭하여 하나의 기업체를 선택해주세요</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="btn-area  mt-010">
					<div class="float-right">
						<a href="#fn_showCompanypop" class="yellow" onclick="javascript:fn_showCompanypop(); return false" onkeypress="this.onclick();">기업체 검색</a>
					</div>
				</div><!-- E : btn-area -->
			</div>
	</div><!-- E : container -->


	<table id="styleDisplay1" class="type-2 mt-020 wp100" style="display:none">
		<colgroup>
			<col style="width:*" />
			<col style="width:100px;" />
			<col style="width:400px;" />
		</colgroup>
		<thead>
		<tr>
			<th>훈련과정명</th>
			<th>회차</th>
			<th>훈련과정번호</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultTraningProcessList}" varStatus="status">
		<tr>
			<td><a href="#fn_detail" onclick="javascript:fn_detail('${result.companyId}','${result.traningProcessId}','${result.traningProcessManageId}')" class="text">${result.hrdTraningName}</a></td>
			<td>${result.traningProcessPeriod}</td>
			<td>${result.hrdTraningNo}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	
	

	<div id="styleDisplay2" class="group-area mt-020" style="display: none;">
	<div class="group-area">
	
   <c:if test="${!empty param.traningProcessManageId}">

	<table class="type-2 mt-020" id="traningLecTable">
		<colgroup>
			<%-- <col style="width:40px" /> --%>
			<col style="width:120px" />
			<col style="width:*" />
			<col style="width:120px" />
			<col style="width:120px" />
			<col style="width:120px" />
			<col style="width:120px" />
			<col style="width:120px" />
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>개설교과명</th>
				<th>학년도</th>
				<th>학기</th>
				<th>분반</th>
				<th>교과목검색</th>
				<th>추가/삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${!empty resultOffJtSubjectInfoList}">
					<c:forEach var="resultOffJt" items="${resultOffJtSubjectInfoList}" varStatus="status">
						<c:choose>
							<c:when test="${status.count == 1}">
							<tr id="offSubjTr">
								<td>Off-JT</td>
								<td class="left" id="offSubjectNameTd">${resultOffJt.subjectName}</td>
								<td>${resultOffJt.yyyy}년도</td>
								<td>${resultOffJt.termName}</td>
								<td id="offSubjectClassTd">${resultOffJt.subClass}</td>
								<td><a href="#fn_offJtLectureSearchPopup" onclick="javascript:fn_lectureSearchPopup('OFF'); return false" class="btn-line-blue">검색</a></td>
								<td>
									<!-- <a href="#fn_delTR" onclick="javascript:fn_delTR('OFFALL'); return false">전체삭제</a> -->
									<input type="hidden" id="yyyy" name="yyyy" value="${resultOffJt.yyyy}" />
									<input type="hidden" id="term" name="term" value="${resultOffJt.term}" />
									<input type="hidden" id="subjectCode" name="subjectCode" value="${resultOffJt.subjectCode}" />
									<input type="hidden" id="subClass" name="subClass" value="${resultOffJt.subClass}" />
									<input type="hidden" id="subjectName" name="subjectName" value="${resultOffJt.subjectName}" />
									<input type="hidden" id="subjType" name="subjType" value="OFF" />
									<input type="hidden" id="subjInfo" name="subjectName" value="${resultOffJt.yyyy}||${resultOffJt.term}||${resultOffJt.subjectCode}||${resultOffJt.subClass}||${resultOffJt.subjectName}||" />
									<a href="#fn_delTR" onclick="javascript:fn_formDelete('${resultOffJt.yyyy}','${resultOffJt.term}','${resultOffJt.subjectCode}','${resultOffJt.subClass}'); return false" >삭제</a>
								</td>
							</tr>
							</c:when>
							<c:otherwise>
							<tr id="OFFtr-${status.index}">
								<td>Off-JT</td>
								<td class="left" id="offSubjectNameTd">${resultOffJt.subjectName}</td>
								<td>${resultOffJt.yyyy}년도</td>
								<td>${resultOffJt.termName}</td>
								<td id="offSubjectClassTd">${resultOffJt.subClass}</td>
								<td> - </td>
								<td>
									<a href="#fn_delTR" onclick="javascript:fn_delTR('OFFtr-${status.index}'); return false" >삭제</a>
									<input type="hidden" id="yyyy" name="yyyy" value="${resultOffJt.yyyy}" />
									<input type="hidden" id="term" name="term" value="${resultOffJt.term}" />
									<input type="hidden" id="subjectCode" name="subjectCode" value="${resultOffJt.subjectCode}" />
									<input type="hidden" id="subClass" name="subClass" value="${resultOffJt.subClass}" />
									<input type="hidden" id="subjectName" name="subjectName" value="${resultOffJt.subjectName}" />
									<input type="hidden" id="subjType" name="subjType" value="OFF" />
									<input type="hidden" id="subjInfo" name="subjectName" value="${resultOffJt.yyyy}||${resultOffJt.term}||${resultOffJt.subjectCode}||${resultOffJt.subClass}||${resultOffJt.subjectName}||" />
								</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr id="offSubjTr">
						<!-- <td>1</td> -->
						<td>Off-JT</td>
						<td class="left" id="offSubjectNameTd"></td>
						<td id="offSubjectYyyyTd"></td>
						<td id="offSubjectTermTd"></td>
						<td id="offSubjectClassTd"></td>
						<td><a href="#fn_offJtLectureSearchPopup" onclick="javascript:fn_lectureSearchPopup('OFF'); return false" class="btn-line-blue">검색</a></td>
						<td>
							<a href="#fn_delTR" onclick="javascript:fn_delTR('OFFALL'); return false" class="btn-line-gray">전체삭제</a>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${!empty resultOjtSubjectInfoList}">
					<c:forEach var="resultOjt" items="${resultOjtSubjectInfoList}" varStatus="status">
						<c:choose>
						<c:when test="${status.count == 1}">
						<tr id="ojtSubjTr">
							<td>OJT</td>
							<td class="left" id="ojtSubjectNameTd">${resultOjt.subjectName}</td>
							<td>${resultOjt.yyyy}년도</td>
							<td>${resultOjt.termName}</td>
							<td id="ojtSubjectClassTd">${resultOjt.subClass}</td>
							<td><a href="#fn_addOjtLectureSearchPopup" onclick="javascript:fn_lectureSearchPopup('OJT'); return false" class="btn-line-blue">검색</a></td>
							<td>
								<!-- <a href="#fn_delTR" onclick="javascript:fn_delTR('OJTALL'); return false">전체삭제</a> -->
							<input type="hidden" id="yyyy" name="yyyy" value="${resultOjt.yyyy}" />
							<input type="hidden" id="term" name="term" value="${resultOjt.term}" />
							<input type="hidden" id="subjectCode" name="subjectCode" value="${resultOjt.subjectCode}" />
							<input type="hidden" id="subClass" name="subClass" value="${resultOjt.subClass}" />
							<input type="hidden" id="subjectName" name="subjectName" value="${resultOjt.subjectName}" />
							<input type="hidden" id="subjType" name="subjType" value="OJT" />
							<input type="hidden" id="subjInfo" name="subjectName" value="${resultOjt.yyyy}||${resultOjt.term}||${resultOjt.subjectCode}||${resultOjt.subClass}||${resultOjt.subjectName}||" />
							<a href="#fn_delTR" onclick="javascript:fn_formDelete('${resultOjt.yyyy}','${resultOjt.term}','${resultOjt.subjectCode}','${resultOjt.subClass}'); return false" >삭제</a>
							</td>
						</tr>
						</c:when>
						<c:otherwise>
						<tr id="OJTtr-${status.index}">
							<td>OJT</td>
							<td class="left">${resultOjt.subjectName}</td>
							<td>${resultOjt.yyyy}년도</td>
							<td>${resultOjt.termName}</td>
							<td>${resultOjt.subClass}</td>
							<td> - </td>
							<td>
								<a href="#fn_delTR" onclick="javascript:fn_delTR('OJTtr-${status.index}'); return false" >삭제</a>
							<input type="hidden" id="yyyy" name="yyyy" value="${resultOjt.yyyy}" />
							<input type="hidden" id="term" name="term" value="${resultOjt.term}" />
							<input type="hidden" id="subjectCode" name="subjectCode" value="${resultOjt.subjectCode}" />
							<input type="hidden" id="subClass" name="subClass" value="${resultOjt.subClass}" />
							<input type="hidden" id="subjectName" name="subjectName" value="${resultOjt.subjectName}" />
							<input type="hidden" id="subjType" name="subjType" value="OJT" />
							<input type="hidden" id="subjInfo" name="subjectName" value="${resultOjt.yyyy}||${resultOjt.term}||${resultOjt.subjectCode}||${resultOjt.subClass}||${resultOjt.subjectName}||" />
							</td>
						</tr>
						</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr id="ojtSubjTr">
						<td>OJT</td>
						<td class="left" id="ojtSubjectNameTd"></td>
						<td id="ojtSubjectYyyyTd"></td>
						<td id="ojtSubjectTermTd"></td>
						<td id="ojtSubjectClassTd"></td>
						<td><a href="#fn_ojtLectureSearchPopup" onclick="javascript:fn_lectureSearchPopup('OJT'); return false" class="btn-line-blue">검색</a></td>
						<td>
							<a href="#fn_delTR" onclick="javascript:fn_delTR('OJTALL'); return false" class="btn-line-gray">전체삭제</a>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>
	</c:if>
	<div class="btn-area align-right mt-010">
	
	
		<a href="/lu/traning/listTraningProcessSubject.do" class="black">목록</a>
	
	<c:if test="${!empty resultOffJtSubjectInfoList or !empty resultOffJtSubjectInfoList}">
		<a href="#fn_formUpdate" class="black" onclick="javascript:fn_formUpdate(); return false" onkeypress="this.onclick();">저장</a>
	</c:if>
	
	<c:if test="${empty resultOffJtSubjectInfoList and empty resultOffJtSubjectInfoList}">
		<a href="#fn_formInsert" class="black" onclick="javascript:fn_formInsert(); return false" onkeypress="this.onclick();">저장</a>
	</c:if>
		
	</div><!-- E : btn-area -->
</div>

	<!-- <div class="btn-area mt-010">
		<div class="float-left">
			<a href="#fn_goList" class="gray-1t" onclick="javascript:fn_goList();">목록</a>
		</div>
		<div class="float-right">
			<a href="#fn_delete" class="gray-1" onclick="javascript:fn_delete();">삭제</a>
			<a href="#fn_goUpdate" class="yellow" onclick="javascript:fn_goUpdate();">수정</a>
		</div>
	</div> --><!-- E : btn-area -->
</div><!-- E : 훈련과정명 -->

<script type="text/javascript">

 
</script>

</form>


