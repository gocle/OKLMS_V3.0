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

// 		doAction('formReset');
	}

	/*====================================================================
		조회버튼이나 페이지 클릭시 실행되는 함수는 꼭 doAction(sAction)으로 만들어 사용해 주시기 바랍니다.
	====================================================================*/

	function fn_formValidate() {
		return true;
	}

	/* 수정 페이지로 이동 */
	function fn_formUpdt(){
		if (fn_formValidate() && confirm("수정 페이지로 이동 하시겠습니까?")) {
			var reqUrl = CONTEXT_ROOT + "/prototype/protoBoard/goUpdateProtoBoard.do";

			$("#frmProtoBoard").attr("method", "post" );
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
			<form:form modelAttribute="frmProtoBoard">
				<input type="hidden" id="prototypeId" name="prototypeId" value="<c:out value="${protoBoardVO.prototypeId}" />"/>
			</form:form>
			<div align="left">
				<h2>Validation Test Form</h2>
					<table>
						<tr><td>프로토타입id</td><td><c:out value="${protoBoardVO.prototypeId}" /></td></tr>
						<tr><td>조회수</td><td><c:out value="${protoBoardVO.prototypeViewCnt}" /></td></tr>
						<tr><td>제목</td><td><c:out value="${protoBoardVO.prototypeTitle}" /></td></tr>
						<tr><td>내용1</td><td><c:out value="${protoBoardVO.prototypeContents1}" /></td></tr>
						<tr><td>내용2</td><td><c:out value="${protoBoardVO.prototypeContents2}" /></td></tr>
						<tr><td>첨부파일ID</td><td><c:out value="${protoBoardVO.atchFileId}" /></td></tr>
						<tr><td>사용여부</td><td><c:out value="${protoBoardVO.useYsno}" /></td></tr>
						<tr><td>생성자ID</td><td><c:out value="${protoBoardVO.crtrId}" /></td></tr>
						<tr><td>생성일시</td><td><c:out value="${protoBoardVO.cretYmdtm}" /></td></tr>
						<tr><td>수정자ID</td><td><c:out value="${protoBoardVO.updtrId}" /></td></tr>
						<tr><td>수정일시</td><td><c:out value="${protoBoardVO.updtYmdtm}" /></td></tr>
					</table>
			<div><a class="btn01" role="button" href="#fn_formUpdt" onclick="javascript:fn_formUpdt();" onkeypress="this.onclick;"><span>수정</span></a></div>

			<div style="height:10px"></div>
			
				
			<div style="float:left; border: 5px double #48BAE4; height: auto; padding: 10px;">
				<div align="left">
					<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
		    			<tr>
		        			<td>
<!-- 		        				<input type="file"   id="fileUploader" name="file_1" class="text" value="" title="첨부파일 입력" style="width:90%;" />			        				 -->

		        			</td>
		    			</tr>
					</table>
				</div>
				<div style="float:left; border: 5px double #48BAE4; width: 90%; height: auto; padding: 10px;">
					<table>
		    			<tr>
		        			<td>
								<h2>첨부파일 조회 Test Form</h2> <br/>
								해당 Row를 더블 클릭하면 <br/> 포함된 첨부파일 목록을 조회 합니다.<br/>
								(넘겨줄 파일 아이디 : ${protoBoardVO.atchFileId})
								<c:import url="/commbiz/atchfle/atchFileListImport.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${protoBoardVO.atchFileId}" />
									<c:param name="param_deleYn" value="N"/>
								</c:import>
		        			</td>
		    			</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
