<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<c:set var="targetUrl" value="/la/ncs/" />
<script type="text/javaScript" language="javascript">
	
	var targetUrl = "${targetUrl}";
	
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
	
	
	function fn_insertNcs(){					
		
		if($("#licenceName").val() == ""){
			alert("[자격명]은 필수 입력사항입니다.");
			$("#licenceName").focus();
			return;
		}
		
		if($("#licenceLevel").val() == ""){
			alert("[수준]은 필수 입력사항입니다.");
			$("#licenceLevel").focus();
			return;
		}
		
		if($("#licenceVersion").val() == ""){
			alert("[버전]은 필수 입력사항입니다.");
			$("#licenceVersion").focus();
			return;
		}
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "insertNcsLicence.do";
		$("#frmNcs").attr("action", reqUrl);
		$("#frmNcs").attr("target","_self");
		$("#frmNcs").submit();
	}
	
	
	function fn_insertNcsUnit(){		
		
		if($("#licenceId").val() == ""){
			alert("[자격]은 필수 선택사항입니다.");
			$("#licenceId").focus();
			return;
		}
		
		if($("#unitName").val() == ""){
			alert("[능력단위명]은 필수 입력사항입니다.");
			$("#unitName").focus();
			return;
		}
		
		if($("#unitCd").val() == ""){
			alert("[능력단위코드]는 필수 입력사항입니다.");
			$("#unitCd").focus();
			return;
		}
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "insertNcsLicenceUnit.do";
		$("#frmNcs").attr("action", reqUrl);
		$("#frmNcs").attr("target","_self");
		$("#frmNcs").submit();
	}
	
	
	function fn_updateNcs(index,licenceId){					
		
		if($("#licenceName"+index).val() == ""){
			alert("[자격명]은 필수 입력사항입니다.");
			$("#licenceName"+index).focus();
			return;
		}
		
		if($("#licenceLevel"+index).val() == ""){
			alert("[수준]은 필수 입력사항입니다.");
			$("#licenceLevel"+index).focus();
			return;
		}
		
		if($("#licenceVersion"+index).val() == ""){
			alert("[버전]은 필수 입력사항입니다.");
			$("#licenceVersion"+index).focus();
			return;
		}
		$("#frmNcsList_licenceId").val(licenceId);
		$("#frmNcsList_licenceName").val($("#licenceName"+index).val());
		$("#frmNcsList_licenceLevel").val($("#licenceLevel"+index).val());
		$("#frmNcsList_licenceVersion").val($("#licenceVersion"+index).val());
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "updateNcsLicence.do";
		$("#frmNcsList").attr("action", reqUrl);
		$("#frmNcsList").attr("target","_self");
		$("#frmNcsList").submit();
	}
	
	function fn_updateNcsUnit(index,unitId){		
		
		
		if($("#unitName"+index).val() == ""){
			alert("[능력단위명]은 필수 입력사항입니다.");
			$("#unitName"+index).focus();
			return;
		}
		
		if($("#unitCd"+index).val() == ""){
			alert("[능력단위코드]는 필수 입력사항입니다.");
			$("#unitCd"+index).focus();
			return;
		}
		
		$("#frmNcsList_unitId").val(unitId);
		$("#frmNcsList_unitName").val($("#unitName"+index).val());
		$("#frmNcsList_unitCd").val($("#unitCd"+index).val());
		
		
		var reqUrl = CONTEXT_ROOT + targetUrl + "updateNcsLicenceUnit.do";
		$("#frmNcsList").attr("action", reqUrl);
		$("#frmNcsList").attr("target","_self");
		$("#frmNcsList").submit();
	}
	
	
	function fn_deleteNcs(licenceId){					
		
		if(confirm("[NCS 기반자격] 을 삭제 하시겠습니까?\n삭제 시 연결된 능력단위도 함께 삭제 됩니다.")){
			$("#frmNcsList_licenceId").val(licenceId);
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteNcsLicence.do";
			$("#frmNcsList").attr("action", reqUrl);
			$("#frmNcsList").attr("target","_self");
			$("#frmNcsList").submit();
		}
		
	}
	
	function fn_deleteNcsUnit(unitId){		
		
		if(confirm("[NCS 능력단위] 를 삭제 하시겠습니까?")){
		
			$("#frmNcsList_unitId").val(unitId);
			
			var reqUrl = CONTEXT_ROOT + targetUrl + "deleteNcsLicenceUnit.do";
			$("#frmNcsList").attr("action", reqUrl);
			$("#frmNcsList").attr("target","_self");
			$("#frmNcsList").submit();
		}
	}
	
	function fn_exclDownload(){		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listNcsLicenceExcelDownload.do";
		$("#frmNcs").attr("action", reqUrl);
		$("#frmNcs").attr("target","_self");
		$("#frmNcs").submit();
	}
	
</script>
<%-- noscript 테그 --%>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
	기능을 사용하실 수 없습니다.</noscript>
<form name="frmNcs" id="frmNcs" method="post">
<!-- E : search-list-1 (검색조건 영역) -->
<ul class="search-list-1">
	<li class="display-b">
		<span>NCS 기반</span>
		<input type="text" name="licenceName" id="licenceName" value="" maxlength="20" placeholder="자격명을 입력하세요." style="width:210px;">
		<input type="text" name="licenceLevel" id="licenceLevel" value="" maxlength="5" placeholder="수준을 입력하세요." style="width:210px;">
		<input type="text" name="licenceVersion" id="licenceVersion" value="" maxlength="5" placeholder="버전을 입력하세요." style="width:210px;">
		<a href="#!" onclick="javascript:fn_insertNcs();" class="btn adm-btn">등록</a>
	</li>
	<li class="display-b">
		<span>NCS 능력단위</span>
		<select name="licenceId" id="licenceId" style="width:200px">
	  			<option selected="" value="">자격선택</option>
	  			<c:forEach var="result" items="${resultList}" varStatus="status">
	  				<c:if test="${result.rn eq '1'}">
						<option value="${result.licenceId}" ${result.licenceId eq ncsLicenceVO.licenceId ? 'selected' : ''}>${result.licenceName}_${result.licenceLevel}_${result.licenceVersion}</option>
					</c:if>
				</c:forEach>
		 </select>
		 <input type="text" name="unitName" id="unitName" value="" maxlength="20" placeholder="능력단위명을 입력하세요." style="width:210px;">
		<input type="text" name="unitCd" id="unitCd" value="" maxlength="20" placeholder="능력단위코드를 입력하세요." style="width:210px;">
		<a href="#!" onclick="javascript:fn_insertNcsUnit();" class="btn adm-btn">등록</a>
	</li>
</ul>
</form>
 
<ul class="board-info">
	<li class="btn-area"> 
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul>

 <form name="frmNcsList" id="frmNcsList" method="post"> 
 		<input type="hidden" name="licenceId" id="frmNcsList_licenceId" value="" />
 		<input type="hidden" name="licenceName" id="frmNcsList_licenceName" value="" />
		<input type="hidden" name="licenceLevel" id="frmNcsList_licenceLevel" value="" />
		<input type="hidden" name="licenceVersion" id="frmNcsList_licenceVersion" value="" />
		
		<input type="hidden" name="unitId" id="frmNcsList_unitId" value="" />
		<input type="hidden" name="unitName" id="frmNcsList_unitName" value="">
		<input type="hidden" name="unitCd" id="frmNcsList_unitCd" value="">

<div class="table-responsive">
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th colspan="4">NCS기반자격</th>
			<th colspan="3">필수NCS능력단위</th>	 
		</tr>
			
		<tr>
			<th style="width: 30%">자격명</th>
			<th style="width: 5%">수준</th>
			<th style="width: 5%">버전</th>
			<th style="width: 10%"></th>
			<th style="width: 20%">능력단위명</th>
			<th style="width: 20%">능력단위코드</th>
			<th style="width: 10%"></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
			<c:set var="rowspan" value="1"/>
			<c:if test ="${result.rn eq '1'}">
				<c:set var="rowspan" value="${result.rowspan}"/>
			</c:if>
			
			<c:if test="${result.rn eq '1'}">
				<td rowspan="${rowspan}">
				<input type="text" name="licenceNames" id="licenceName${status.count}" value="${result.licenceName}" maxlength="20" style="width: 90%; padding-left:1%" />
				</td>
				<td rowspan="${rowspan}">
				<input type="text" name="licenceLevels" id="licenceLevel${status.count}" value="${result.licenceLevel}" maxlength="5" style="width: 90%; padding-left:1%" />
				</td>
				<td rowspan="${rowspan}">
				<input type="text" name="licenceVersions" id="licenceVersion${status.count}" value="${result.licenceVersion}" maxlength="5" style="width: 90%; padding-left:1%" />
				</td>
				<td rowspan="${rowspan}">
				<a href="#!" onclick="javascript:fn_updateNcs('${status.count}','${result.licenceId}');" class="btn-2">수정</a>
				<a href="#!" onclick="javascript:fn_deleteNcs('${result.licenceId}');" class="btn-1" >삭제</a>
				</td>
			</c:if>
				<td><c:if test="${!empty result.unitId}"><input type="text" name="unitNames" id="unitName${status.count}" value="${result.unitName}" maxlength="20" style="width: 90%; padding-left:1%" /></c:if></td>
				<td><c:if test="${!empty result.unitId}"><input type="text" name="unitCds" id="unitCd${status.count}" value="${result.unitCd}" maxlength="20" style="width: 90%; padding-left:1%" /></c:if></td>
				<td>
					    <c:if test="${!empty result.unitId}"><a href="#!" onclick="javascript:fn_updateNcsUnit('${status.count}','${result.unitId}');" class="btn-2">수정</a></c:if>
						<c:if test="${!empty result.unitId}"><a href="#!" onclick="javascript:fn_deleteNcsUnit('${result.unitId}');" class="btn-1">삭제</a></c:if>
				</td>
			</tr>
		</c:forEach>	
	</tbody>
</table>
</div> 
</form>
