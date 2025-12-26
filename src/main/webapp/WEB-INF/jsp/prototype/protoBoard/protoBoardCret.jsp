<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script type="text/javascript" src="${contextRoot }js/FileSaver/FileSaver.js"></script>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>

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

// 		fn_formReset();
	}

	/*====================================================================
		조회버튼이나 페이지 클릭시 실행되는 함수는 꼭 doAction(sAction)으로 만들어 사용해 주시기 바랍니다.
	====================================================================*/
	/*
	* 화면 유효성 첵크
	*/
	function fn_formValidate() {
		return true;
	}

	/* 입력 필드 초기화 */
	function fn_formReset(){
		$("#frmProtoBoard").find("input,select").val("");
	}

	/* HTML Form 신규, 수정, 삭제 대상 레코드 적용 */
	function fn_formCret(){
		if (fn_formValidate() && confirm("저장 하시겠습니까?")) {
			var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/insertProtoBoard.do";
			$("#frmProtoBoard").attr("action", reqUrl);
			$("#frmProtoBoard").submit();
		}
	}
	function fn_formUpdtFile(){
		if (fn_formValidate() && confirm("수정 하시겠습니까?")) {
			var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/saveProtoBoardFile.do";

			$("#frmProtoBoard").attr("method", "post" );
			$("#frmProtoBoard").attr("enctype", "multipart/form-data" );
			$("#frmProtoBoard").attr("action", reqUrl);
			$("#frmProtoBoard").submit();
		}
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
</script>







<img id="displayBox" src="${contextRoot}js/jquery/plugins/blockUI/busy.gif" width="190" height="60" style="display:none">
<div align="center">
		
	<div style="float:left; border: 5px double #48BAE4; height: auto; padding: 10px;">
			<form:form commandName="frmProtoBoard">
				<double-submit:preventer tokenKey="frmProtoBoardToken"/>
			<div align="left">
				<h2>Validation Test Form</h2>
					<table>
						<tr><td>조회수</td><td><input type="text" id="prototypeViewCnt"   name="prototypeViewCnt"  value="${protoBoardVO.prototypeViewCnt}" />		<form:errors path="prototypeViewCnt" /></td></tr>
						<tr><td>제목</td><td><input type="text" id="prototypeTitle"       name="prototypeTitle"   value="${protoBoardVO.prototypeTitle}" />			<form:errors path="prototypeTitle" /></td>      </tr>
						<tr><td>내용1</td><td><input type="text" id="prototypeContents1"  name="prototypeContents1"   value="${protoBoardVO.prototypeContents1}" />	<form:errors path="prototypeContents1" /></td>  </tr>
						<tr><td>내용2</td><td><input type="text" id="prototypeContents2"  name="prototypeContents2"  value="${protoBoardVO.prototypeContents2}" />	<form:errors path="prototypeContents2" /></td>   </tr>
						<tr><td>첨부파일ID</td><td><input type="text" id="atchFileId"      name="atchFileId"   value="${protoBoardVO.atchFileId}" />					<form:errors path="atchFileId" /></td>             </tr>
						<tr><td>사용여부</td><td>
<%-- 							<input type="text" id="useYsno"          name="useYsno"   value="${protoBoardVO.useYsno}" />						 --%>
							<select id="useYsno"          name="useYsno">
								<option value="">선택하세요</option>
								<option value="Y" <c:if test="${'Y' eq protoBoardVO.useYsno}"> selected="selected"</c:if> >Y</option>
								<option value="N" <c:if test="${'N' eq protoBoardVO.useYsno}"> selected="selected"</c:if> >N</option>
							</select>
							<form:errors path="useYsno" />
						</td></tr>
<%-- 						<tr><td>생성자ID</td><td><input type="text" id="crtrId"           name="crtrId"   value="${protoBoardVO.crtrId}" />							<form:errors path="crtrId" /></td>              </tr> --%>
<%-- 						<tr><td>생성일시</td><td><input type="text" id="cretYmdtm"        name="cretYmdtm"   value="${protoBoardVO.cretYmdtm}" />					<form:errors path="cretYmdtm" /></td>           </tr> --%>
<%-- 						<tr><td>수정자ID</td><td><input type="text" id="updtrId"          name="updtrId"   value="${protoBoardVO.updtrId}" />						<form:errors path="updtrId" /></td>             </tr> --%>
<%-- 						<tr><td>수정일시</td><td><input type="text" id="updtYmdtm"        name="updtYmdtm"  value="${protoBoardVO.updtYmdtm}" />						<form:errors path="updtYmdtm" /></td>          </tr> --%>
					</table>
			<div><a class="btn01" role="button" href="#fn_formReset" onclick="javascript:fn_formReset();return false;" onkeypress="this.onclick;"><span>초기화</span></a></div>
			<div><a class="btn01" role="button" href="#fn_formCret" onclick="javascript:fn_formCret();return false;" onkeypress="this.onclick;"><span>insert 저장(VO)</span></a></div>
			<div><a class="btn01" role="button" href="#fn_formUpdtFile" onclick="javascript:fn_formUpdtFile();return false;" onkeypress="this.onclick;"><span>insert 저장(VO:파일 포함.)</span></a></div>

			<div style="height:10px"></div>
			
				
			<div style="float:left; border: 5px double #48BAE4; height: auto; padding: 10px;">
				<div align="left">
					<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
		    			<tr>
		        			<td>
<!-- 		        				<input type="file"   id="fileUploader" name="file_1" class="text" value="" title="첨부파일 입력" style="width:90%;" />			        				 -->
								<a class="btn01" role="button" href="#com.addInputForm" onclick="javascript:com.addInputForm('frmProtoBoard', 'file', 'atchFiles', '','','');return false;" onkeypress="this.onclick;">[FILE 객체 추가]</a>
		        			</td>
		    			</tr>
					</table>
				</div>
			</div>
			</form:form>
		</div>
	</div>
</div>
