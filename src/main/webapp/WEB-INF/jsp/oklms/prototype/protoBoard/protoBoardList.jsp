<%--
  Class Name : list.jsp 
  Description : 기본형
  Modification Information
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src="${contextRoot }js/FileSaver/FileSaver.js"></script>

<script type="text/javascript">
	var lastSel = 0;

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

//         com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_adbkInfs('1');
		}
	}
	
	
// 	function fn_getProtoBoard(targetUrl , param1){
// 		var reqUrl = CONTEXT_ROOT + targetUrl;
// 		$("#prototypeId").val( param1 );
// 		$("#frmProtoBoard").attr("method", "post" );
// 		$("#frmProtoBoard").attr("action", reqUrl);
// 		$("#frmProtoBoard").submit();
// 	}




	/* 첵크된 Row 처리 */
	function fn_checkRowVals( thisObj ){

		var checkedCnt = $("#myGridTable input[name='" + thisObj.name + "']:checked").length;
// 		if( 1 < checkedCnt ){
// 			com.alert("한건만 선택해주세요.");
// 		}else{

			var valuesStr = "";
			$.each($("#myGridTable input[name='" + thisObj.name + "']:checked").parents("td").siblings(), function() {
				
				var inputObj = $(this).find("input");
				var inputName = inputObj.attr("name");
				var inputVal = inputObj.val();
				
				if( undefined != inputName ){

					inputName = inputName.replace("result_", "frm_");
					
					$("#" + inputName ).val(inputVal);
				}
			});
			
// 			$('#myGridTable th').each(function() {
// 				var thObj = this;
// 				com.log( thObj.cellIndex + " , " + thObj.textContent);
// 			});
// 		}
	}
	
	
	/* 리스트 조회 */
	function fn_search( pageNo ){
		$("#pageIndex").val( pageNo );
			
		var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/listProtoBoard.do";
		$("#frmProtoBoard").attr("action", reqUrl);
		$("#frmProtoBoard").submit();
	}
	
	/* 추가 */
	function fn_cret(){
		
		var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/goInsertProtoBoard.do";
		$("#frmProtoBoard").attr("action", reqUrl);
		$("#frmProtoBoard").submit();
	}

	/* 상세조회 */
	function fn_read( param1 ){
		
		$("#prototypeId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/getProtoBoard.do";
		$("#frmProtoBoard").attr("action", reqUrl);
		$("#frmProtoBoard").submit();
	}

	/* 수정 */
	function fn_updt( param1 ){
		
		$("#prototypeId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/goUpdateProtoBoard.do";
		$("#frmProtoBoard").attr("action", reqUrl);
		$("#frmProtoBoard").submit();
	}
			
	/* save(추가/수정) */
	function fn_save( param1 ){
		
		$("#prototypeId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/goSaveProtoBoard.do";
		$("#frmProtoBoard").attr("action", reqUrl);
		$("#frmProtoBoard").submit();
	}
			
	/* 삭제 */
	function fn_delt(){
		
// 		$("#prototypeId").val( param1 );

		var checkedVals = com.getCheckedVal('check0','check1');
		com.log(checkedVals);

		$("#delPrototypeId").val( checkedVals );
		
		var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/deleteProtoBoard.do";
		$("#frmProtoBoard").attr("action", reqUrl);
		$("#frmProtoBoard").submit();
	}

	/*
	* simple 엑셀
	*/
	function fn_toExcel(){
		alert("작업예정");
	}

	/*
	* poi 엑셀
	*/
	function fn_toExcel1(){
		alert("작업예정");
	}

	/*
	* jsp 엑셀
	*/
	function fn_toExcel2(){
		var excelDownUrl = "/prototype/protoBoard/protoBoardExcelDownload2.do";
		
		//동적으로 iframe 생성
		var $iframe = $("#downIFrame");
		if($iframe.length < 1){
			var $iframe = $("<iframe id='downIFrame' name='downIFrame' frameBorder='0' scrolling='no' width='0' height='0'></iframe>");
			$(document.body).append($iframe);
		}
		
		//동적으로 다운로드용 form 생성
		var $form = $("#downForm");
		if($form.length < 1) {
			$form = $("<form id='downForm', method='post', action='"+excelDownUrl+"' target='downIFrame'></form>");
		  	$(document.body).append($form);
		}
		//이전에 처리한 다운로드파일정보 삭제
		$form.empty();

		//다운로드파일정보 세팅
//			$("<input></input>").attr({type:"hidden", name:"arg0", value:$.trim(arg0)}).appendTo($form);
//			$("<input></input>").attr({type:"hidden", name:"arg1", value:$.trim(arg1)}).appendTo($form);

		$form.submit();
		
	}
	
	/* AJAX 로 form 저장 */
	function fn_ajaxSave(){
		
		var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/saveProtoBoard.json";
// 			var param 	= $("#frmProtoBoard").serialize();
		var param = $("#frmProtoBoardAJAX").serializeArray();

		
		com.ajax4confirm( "저장 하시겠습니까?" , reqUrl, param, function(obj, data, textStatus, jqXHR){						
			if (200 == jqXHR.status ) {
				
				com.alert( jqXHR.responseJSON.retMsg );
				
				if( "SUCCESS" == jqXHR.responseJSON.retCd ){
					fn_search( 1 );
				}
			}
		}, {
    		async : true,
    		type : "POST",
    		spinner : true,
			errorCallback : null,
    		timeout : 30000			// 기본 30초
    	});
	}
</script>


<img id="displayBox" src="${contextRoot}js/jquery/plugins/blockUI/busy.gif" width="190" height="60" style="display: none">
<div>

	<div style="height: 20px"></div>

	<div style="width:70%; float: left; border: 5px double #48BAE4; height: auto; padding: 10px;">
		<div align="right">
			<span>총 </span><span id="totalRow">0</span><span>건</span>
		</div>
		<div style="float: none;">


			<div id="border">
				<form id="frmProtoBoard" name="frmProtoBoard" action="<c:url value='/prototype/protoBoard/listProtoBoard.do'/>" method="post">
					<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
					<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
					<input type="hidden" id="prototypeId" name="prototypeId" /> 
					<input type="hidden" id="delPrototypeId" name="delPrototypeId" />
<%-- 					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" /> --%>

					<table cellpadding="3" class="table-search" border="0">
						<tr>
							<td width="10%" class="title_left">
								<h1>
									제목
								</h1>
							</td>
							<td width="50%"><input name="searchPrototypeTitle" type="text" size="35" value='<c:out value="${protoBoardVO.searchPrototypeTitle}" />' maxlength="35" onkeypress="press(event);" title="검색단어입력"></td>
							<th>
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><span class="button"><input type="submit" value="<spring:message code="button.inquire" />" onclick="javascript:fn_search(1); return false;" onkeypress="this.onclick;"></span></td>
										<td>&nbsp;&nbsp;</td>
										<td><span class="button"><a class="btn01" role="button" href="#fn_cret" onclick="javascript:fn_cret(); return false;" onkeypress="this.onclick;"><spring:message code="button.create" /></a></span></td>
									</tr>
								</table>
							</th>
						</tr>
					</table>
		
					<table id="myGridTable" border="1" class="table-line"  summary="번호,제목 , 내용1, 내용2, 첨부파일 , 조회수 목록입니다">
						<thead>
							<tr>
								<th scope="col" class="title" width="2%" nowrap><input type="checkbox" id="check0" name="check0" class="check2" onclick="javascript:com.checkAll('check0','check1');"/></th>
								<th scope="col" class="title" width="10%" nowrap>번호</th>
								<th scope="col" class="title" width="30%" nowrap>제목</th>
								<th scope="col" class="title" width="10%" nowrap>내용1</th>
								<th scope="col" class="title" width="10%" nowrap>내용2</th>
								<th scope="col" class="title" width="4%" nowrap>첨부파일</th>
								<th scope="col" class="title" width="4%" nowrap>조회수</th>
								<th scope="col" class="title" width="8%" nowrap>사용여부</th>
								<th scope="col" class="title" width="15%" nowrap>생성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="lt_text3" nowrap>
										<input type="checkbox" name="check1" class="check2" value='<c:out value="${result.prototypeId}"/>'  onclick="javascript:fn_checkRowVals(this);">
									</td>
									<td class="lt_text3" nowrap>
										<c:out value="${totalCount-((pageIndex-1) * pageSize + status.count)+1}"/>
										<input type="hidden" name="result_prototypeId" value='<c:out value="${result.prototypeId}"/>' /> 
									</td>
									<td class="lt_text3" nowrap>
										<c:out value="${result.prototypeTitle}" />
<%-- 										<a href="/prototype/protoBoard/getProtoBoard.do" onclick="javascript:fn_getProtoBoard(this.href, '<c:out value="${result.prototypeId}"/>'); return false">[Read]</a> --%>
										<a href="#fn_read" onclick="javascript:fn_read( '<c:out value="${result.prototypeId}"/>'); return false" onkeypress="this.onclick;">[Read]</a>
										<a href="#fn_updt" onclick="javascript:fn_updt( '<c:out value="${result.prototypeId}"/>'); return false" onkeypress="this.onclick;">[Updt]</a>
										<a href="#fn_save" onclick="javascript:fn_save( '<c:out value="${result.prototypeId}"/>'); return false" onkeypress="this.onclick;">[Save(수정)]</a>
										<a href="#fn_save" onclick="javascript:fn_save( ''); return false">[Save(추가)]</a>
										<input type="hidden" name="result_prototypeTitle" value='<c:out value="${result.prototypeTitle}"/>' />
									</td>
									<td class="lt_text3" nowrap><c:out value="${result.prototypeContents1}" /><input type="hidden" name="result_prototypeContents1" value='<c:out value="${result.prototypeContents1}"/>' /></td>
									<td class="lt_text3" nowrap><c:out value="${result.prototypeContents2}" /><input type="hidden" name="result_prototypeContents2" value='<c:out value="${result.prototypeContents2}"/>' /></td>
									<td class="lt_text3" nowrap><c:out value="${result.atchFileId}" /><input type="hidden" name="result_atchFileId" value='<c:out value="${result.atchFileId}"/>' /></td>
									<td class="lt_text3" nowrap><c:out value="${result.prototypeViewCnt}" /><input type="hidden" name="result_prototypeViewCnt" value='<c:out value="${result.prototypeViewCnt}"/>' /></td>
									<td class="lt_text3" nowrap><c:if test="${result.useYsno == 'N'}">사용 안함<input type="hidden" name="result_useYsno" value='N' /></c:if> <c:if test="${result.useYsno == 'Y'}">사용<input type="hidden" name="result_useYsno" value='Y' /></c:if></td>
									<td class="lt_text3" nowrap><c:out value="${result.cretYmdtm}" /><input type="hidden" name="result_cretYmdtm" value='<c:out value="${result.cretYmdtm}"/>' /></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td class="lt_text3" nowrap colspan="6"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="10"></td>
						</tr>
					</table>
				</form>
			</div>


		</div>
		<div style="height: 40px"></div>
<!-- 		<div id="pageNavi" name="pageNavi" style="height: 30px;"></div> -->
		
		<div class="page-num">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
		</div>
	
	
		<div align="right" style="height: 100px;">

			<a class="btn01" role="button" href="#" onclick="fn_cret();">신규</a>
			<a class="btn01" role="button" href="#" onclick="fn_delt();">삭제</a>
<!-- 			<a class="btn01" role="button" href="#" onclick="fn_toExcel();">simple 엑셀</a> -->
<!-- 			<a class="btn01" role="button" href="#" onclick="fn_toExcel1();">poi 엑셀</a> -->
			<a class="btn01" role="button" href="#" onclick="fn_toExcel2();">jsp 엑셀</a>
		</div>
	</div>











	<div style="height:20px;width: 30px"></div>
	<div style="float:left;"></div>
	<div style="float:left; border: 5px double #48BAE4; height: auto; padding: 10px;">
		<div align="left">
			<form:form modelAttribute="frmProtoBoardAJAX">
				<table id="myInputTable">
					<tr><th>프로토타입id</th><td><input type="text" id="frm_prototypeId"  name="prototypeId"   value="${infoMap.prototypeId}" /></td>     </tr>
					<tr><th>조회수</th><td><input type="text" id="frm_prototypeViewCnt"   name="prototypeViewCnt"  value="${infoMap.prototypeViewCnt}" /></td></tr>
					<tr><th>제목</th><td><input type="text" id="frm_prototypeTitle"       name="prototypeTitle"   value="${infoMap.prototypeTitle}" /></td>      </tr>
					<tr><th>내용1</th><td><input type="text" id="frm_prototypeContents1"  name="prototypeContents1"   value="${infoMap.prototypeContents1}" /></td>  </tr>
					<tr><th>내용2</th><td><input type="text" id="frm_prototypeContents2"   name="prototypeContents2"  value="${infoMap.prototypeContents2}" /></td>   </tr>
					<tr><th>사용여부</th><td><input type="text" id="frm_useYsno"          name="useYsno"   value="${infoMap.useYsno}" /></td>             </tr>
					<tr><th>생성자ID</th><td><input type="text" id="frm_crtrId"           name="crtrId"   value="${infoMap.crtrId}" /></td>              </tr>
					<tr><th>생성일시</th><td><input type="text" id="frm_cretYmdtm"        name="cretYmdtm"   value="${infoMap.cretYmdtm}" /></td>           </tr>
					<tr><th>수정자ID</th><td><input type="text" id="frm_updtrId"          name="updtrId"   value="${infoMap.updtrId}" /></td>             </tr>
					<tr><th>수정일시</th><td><input type="text" id="frm_updtYmdtm"       name="updtYmdtm"  value="${infoMap.updtYmdtm}" /></td>          </tr>
				</table>
			</form:form>
			<table>
    			<tr>
        			<td>
						<h2>첨부파일 조회 Test Form</h2> <br/>
						해당 Row를 첵크박스를 클릭하면 <br/> 포함된 첨부파일 목록을 조회 합니다.<br/>
						(넘겨줄 파일 아이디 : ${infoMap.atchFileId})
						<c:import url="/cais/commbiz/atchfle/caisFileListImport.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${infoMap.atchFileId}" />
						</c:import>
        			</td>
    			</tr>
			</table>
		</div>
		<div style="clear:both;" align="left">
			<div><a class="btn01" href="javascript://" onclick="javascript:fn_ajaxSave();"><span>AJAX 추가 & 수정 저장</span></a></div>
		</div>	
		
	</div>
	
	
	
	
</div>
