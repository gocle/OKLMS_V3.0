<%@page import="kr.co.gocle.oklms.comm.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="kr.co.gocle.oklms.comm.util.Config" %>
<%
String retMsg = StringUtil.trimString((String)request.getAttribute("retMsg"),"");
%>

<link href="/js/jquery/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" type="text/css" />

<c:set var="targetUrl" value="/lu/member/"/>
<script type="text/javascript" src="${contextRootJS }/js/oklms/jquery.table2excel.js"></script>
<script type="text/javascript">
	var targetUrl = "${targetUrl}";

	$(document).ready(function() {
		loadPage();
	});

	/*====================================================================
		화면 초기화
	====================================================================*/
	function loadPage() {
		com.datepickerDateFormat('stdGoyongDate', 'button');
		com.datepickerDateFormat('stdCompOutDate', 'button');
		com.datepickerDateFormat('stdLeaveDate', 'button');
		com.datepickerDateFormat('outEvalPassDate', 'button');
	}
	
	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/*====================================================================
	사용자 정의 함수
	====================================================================*/

	

	/* 목록 페이지로 이동 */
	function fn_list(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listStdInfo.do";

		$("#frmMember").attr("method", "post" );
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}

	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	
	function memIdCheck(){
		var check = true;
		if( !$("#loginId").val() ){
			alert("아이디를 입력하세요.");
			check = false;
			return false;
		}
		
		if(check){
			$.ajax({
				url:"/commbiz/outmember/memIdCheck.do",
				type:"post",
				data:$('#frmMember').serialize(),
				success:function(data){
					
					if(data.memId){
						alert("등록된 아이디가 있습니다.");
						$("#memCheck").val("");	
					}else{
						$("#memCheck").val($("#loginId").val());
						alert("사용가능한 아이디입니다.");
					}
					
				},error:function(xhr,status,error){
					alert("등록된 아이디가 있습니다.");
					$("#memCheck").val("");	
					//alert(xhr.status);
				}
				
			});		
		}
	}
	
	
	function fn_formValidate() {
		if($("#companyId").val() == ""){
			alert("회사 선택은 필수입니다.");
			return false;
		}
		
		if($("#traningProcessId").val() == ""){
			alert("훈련과정 선택은 필수입니다.");
			return false;
		}
		return true;
	}	
	
	/* HTML Form 신규, 수정 */
	function fn_formSave(){
		if (fn_formValidate()) {
			if(doubleSubmitCheck()) return;
			if(confirm("수정 하시겠습니까?")){
				var reqUrl =  "/lu/member/updateStdInfo.do";
				$("#frmMember").attr("target","_self");
				$("#frmMember").attr("action", reqUrl);
				$("#frmMember").submit();
			}
		}
	}
	
	
	function fn_excel(){
		/* var reqUrl = "/lu/traningstatus/excelOnlineScheduleAttend.do";
		$("#frmTraningstatus").attr("target", "_self");
		$("#frmTraningstatus").attr("action", reqUrl);
		$("#frmTraningstatus").submit(); */
		
		$("#report_area").table2excel({
	        name: "Worksheet Name",
	        filename: "${memberVO.memName}",
	        fileext: ".xls"
	    }); 



	}
	
	function fn_traningPopup(  ){


		popOpenWindow("", "popSearch1", 850, 560);

		var reqUrl = "/lu/popup/goPopupSearchTraning.do";

		$("#frmMember").attr("target", "popSearch1");
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}
	
	function fn_companyPopup(  ){


		popOpenWindow("", "popSearch2", 850, 560);

		var reqUrl = "/lu/popup/goPopupSearchCompany.do";

		$("#frmMember").attr("target", "popSearch2");
		$("#frmMember").attr("action", reqUrl);
		$("#frmMember").submit();
	}


</script>


<form id="frmMember" name="frmMember" method="post">
<input type="hidden" name="memberType" id="memberType" value="${memberType}" />
<input type="hidden" id="companyId" name="companyId" value="${companyVO.companyId}" />
<input type="hidden" id="traningProcessId" name="traningProcessId" value="${memberVO.traningProcessId}" />
<input type="hidden" id="stdTraningYear" name="stdTraningYear" value="${memberVO.stdTraningYear}" />
<input type="hidden" name="memSeq" id="memSeq" value="${memberVO.memSeq}"  />

<div id="report_area">
	<h2>학습근로자 현황</h2>
	<br/><br/>
	<h2>기본정보</h2>
	<table class="type-write">
		<tbody>
			<colgroup>
				<col style="width:15%">
				<col style="width:18%">
				<col style="width:15%">
				<col style="width:18%">
				<col style="width:15%">
				<col style="width:18%">
			</colgroup>
			<tr>
				<th>기업명</th>
				<td colspan="5">
					<span id="companyName_text">${companyVO.companyName}</span>&nbsp;&nbsp;<a href="#fn_companyPopup" onclick="javascript:fn_companyPopup(); return false" class="btn-full-blue">변경</a>
				</td>
			</tr> 
			<tr>
				<tr>
				<th>성명</th>
				<td>
					${memberVO.memName}
				</td>
				<th>학번</th>
				<td>
					${memberVO.memId}
				</td>
				<th>학과</th>
				<td>
					${memberVO.deptNm}
				</td>
				
			</tr>
			<tr>
				<tr>
				<th>생년월일</th>
				<td>
					${memberVO.memBirth}
				</td>
				<th>사무실번호</th>
				<td>
					<input type="text" id="stdCompTelNo" name="stdCompTelNo"  onkeydown="onlyNumber(this);" maxlength="11" placeholder="숫자만입력"  value="${memberVO.stdCompTelNo}" style="width:80%;" />
				</td>
				<th>핸드폰번호</th>
				<td>
					${memberVO.hpNo}
				</td>
				
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					${memberVO.email}
				</td>
				<th>고용보험가입일자</th>
				<td>
					<input type="text" id="stdGoyongDate" name="stdGoyongDate"  maxlength="8" readonly="readonly" value="${memberVO.stdGoyongDate}" style="width:80%;" />
				</td>
				
				<th>퇴사일자</th>
				<td>
					<input type="text" id="stdCompOutDate" name="stdCompOutDate"  maxlength="10" readonly="readonly" value="${memberVO.stdCompOutDate}" style="width:80%;" />
				</td>
			</tr>
			<tr>
				<th>자퇴(제적일자)</th>
				<td>
					${memberVO.extDt}
				</td>
				
				<th>졸업일자</th>
				<td>
					${memberVO.gradDt}
				</td>
				<th>직급</th>
				<td>
					<input type="text" id="dutyNm" name="dutyNm"  maxlength="10"  value="${memberVO.dutyNm}" style="width:30%;" />
				</td>
			</tr> 
			</tbody>
			
	</table>
	<br/><br/>
	<h2>훈련정보</h2>
	<table class="type-write">
		<tbody>
			<colgroup>
				<col style="width:15%">
				<col style="width:18%">
				<col style="width:15%">
				<col style="width:18%">
				<col style="width:15%">
				<col style="width:18%">
			</colgroup>
			<tr>
			
				
				<th>과정명</th>
				<td colspan="5">
					<span id="traningProcessName_text">${memberVO.traningProcessName}</span>&nbsp;&nbsp;<a href="#fn_traningPopup" onclick="javascript:fn_traningPopup(); return false" class="btn-full-blue">변경</a>
				</td>
				
			</tr> 
			<tr>
			<th>실시년도</th>
				<td>
					${memberVO.year}
				</td>
				<th>회차</th>
				<td>
					${memberVO.traningProcessPeriod}
				</td>
				<th>실시구분</th>
				<td>
					${memberVO.stdTransferYn eq 'Y' ? '편입' : '신입'}
				</td>
			</tr>
			<tr>
				<th>OJT분반</th>
				<td>
					${memberVO.ojtClass}
				</td>
				<th>OJT지도교수-등급</th>
				<td>
					${memberVO.etcGrade1}/${memberVO.etcGrade2}/${memberVO.etcGrade3}
				</td>
				<th>OJT지도교수-특이사항</th>
				<td>
					${memberVO.bigo1}
				</td>
				
			</tr> 
			<tr>
				<th>센터전담자-특이사항</th>
				<td>
					${memberVO.bigo2}
				</td>
				<th>훈련기준-상태</th>
				<td>
					<select id="stdStatus" name="stdStatus"  >
						<option value="">선택 </option>
						<option value="1" ${memberVO.stdStatus eq '1' ? 'selected' : ''}>진행중</option>
						<option value="2" ${memberVO.stdStatus eq '2' ? 'selected' : ''}>이수</option>
						<option value="3" ${memberVO.stdStatus eq '3' ? 'selected' : ''}>수료</option>
						<option value="4" ${memberVO.stdStatus eq '4' ? 'selected' : ''}>중탈</option>
						<option value="5" ${memberVO.stdStatus eq '5' ? 'selected' : ''}>참여철회</option>
						<option value="7" ${memberVO.stdStatus eq '7' ? 'selected' : ''}>훈련중지</option>
						<option value="6" ${memberVO.stdStatus eq '6' ? 'selected' : ''}>미이수</option>
					</select>
					<!-- 학생 상태(1:진행중,2:이수,3:수료,4:중탈,5:훈련중지(철회)) -->
				</td>
				<th>학사기준-상태</th>
				<td>
					${memberVO.sknrgsSttusNm}
				</td>
			</tr> 
			<tr>
				<th>훈련시작일</th>
				<td>
					${memberVO.startDate}
				</td>
				<th>훈련종료예정일</th>
				<td>
					${memberVO.endDate}
				</td>
				<th>중탈일자</th>
				<td>
					<input type="text" id="stdLeaveDate" name="stdLeaveDate"  maxlength="10" readonly="readonly" value="${memberVO.stdLeaveDate}" style="width:80%;" />
				</td>
			</tr> 
</tbody>
			
	</table>
	<br/><br/>
	<h2>외부평가정보</h2>
	<table class="type-write">	
			<colgroup>
				<col style="width:10%">
				<col style="width:15%">
				<col style="width:10%">
				<col style="width:15%">
				<col style="width:10%">
				<col style="width:15%">
				<col style="width:10%">
				<col style="width:15%">
			</colgroup>
			<tbody>
			<tr>
				
				<th>필수능력단위<br/>(70%)</th>
				<td>
					
					<select id="outEvalNcsYn" name="outEvalNcsYn"  >
						<option value="Y" ${memberVO.outEvalNcsYn eq 'Y' ? 'selected' : ''}>Y</option>
						<option value="N" ${memberVO.outEvalNcsYn eq 'N' ? 'selected' : ''}>N</option>
					</select>
					
				</td>
				<th>훈련이수시간<br/>(80%)</th>
				<td>
					<select id="outEvalProgressYn" name="outEvalProgressYn"  >
						<option value="Y" ${memberVO.outEvalProgressYn eq 'Y' ? 'selected' : ''}>Y</option>
						<option value="N" ${memberVO.outEvalProgressYn eq 'N' ? 'selected' : ''}>N</option>
					</select>
				</td>
				<th>외부평가<br/>합격여부</th>
				<td>
					<select id="outEvalPassYn" name="outEvalPassYn">
						<option value="">선택 </option>
						<option value="Y" ${memberVO.outEvalPassYn eq 'Y' ? 'selected' : ''}>합격</option>
						<option value="N" ${memberVO.outEvalPassYn eq 'N' ? 'selected' : ''}>미합격</option>
					</select>
				</td>
				<th>외부평가<br/>합격일자</th>
				<td>
					<input type="text" id="outEvalPassDate" name="outEvalPassDate"  maxlength="10" readonly="readonly" value="${memberVO.outEvalPassDate}" style="width:80%;" />
				</td>
			</tr> 
			
		</tbody>
	</table>
	<br/><br/>
	<h2>이수현황</h2>
	<table class="type-write">
		<tbody>
			<colgroup>
				<col style="width:15%">
				<col style="width:18%">
				<col style="width:15%">
				<col style="width:18%">
				<col style="width:15%">
				<col style="width:18%">
			</colgroup>
			<tr>
				<th colspan="6">이수현황</th>
			</tr>
			<tr>
				<th colspan="4">교과목 기준</th>
				<th colspan="2" rowspan="2">능력단위 기준</th>
			</tr>  
			<tr>
				<th colspan="2">Off-JT</th>
				<th colspan="2">OJT</th>
			</tr>  
			<tr>
				<th>목표</th>
				<th>이수</th>
				<th>목표</th>
				<th>이수</th>
				<th>목표</th>
				<th>이수</th>
			</tr>
			<tr>
				<td style="text-align: center;">${memberVO.offGoal}</td>
				<td style="text-align: center;">${memberVO.offCompl}</td>
				<td style="text-align: center;">${memberVO.ojtGoal}</td>
				<td style="text-align: center;">${memberVO.ojtCompl}</td>
				<td style="text-align: center;">${memberVO.ncsGoal}</td>
				<td style="text-align: center;">${memberVO.ncsCompl}</td>
			</tr>
			
			
			
		</tbody>
	</table>

	

</div><!-- E : content-area -->
	<div class="btn-area mt-010">
		<div class="float-left">
			<a href="#fn_list" onclick="javascript:fn_list();" onkeypress="this.onclick;" class="gray-1">목록</a>
		</div>
		<div class="float-right">
			<!-- <a href="#fn_excel" onclick="javascript:fn_excel();" onkeypress="this.onclick;" class="gray-1">엑셀 다운로드</a> -->
			<a href="#fn_formSave" onclick="javascript:fn_formSave();" onkeypress="this.onclick;" class="orange">저장</a>
		</div>
	</div>

</form>

