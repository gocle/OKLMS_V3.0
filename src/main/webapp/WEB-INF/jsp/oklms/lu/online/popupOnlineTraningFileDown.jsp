<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 이진근    2017. 01. 09 오전 11:20         First Draft.
  ~  *
  ~  *******************************************************************************
 --%>
<c:set var="targetUrl" value="/lu/online/"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src="/js/oklms/popup.js"></script>
<script type="text/javascript"  src="/js/jquery/jquery.ui.widget.js"></script>
<script type="text/javascript"  src="/js/jquery/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="/js/jquery/jquery.fileupload.js"></script> 
<script type="text/javascript" src='/js/oklms/ajaxBase.js'></script>
<script type="text/javascript">

	
	$(document).ready(function() {
		
		$('#file').fileupload({
	        url : "/json/weekFileUpload.jsp?weekId="+$("#weekId").val(),
	        dataType: 'json',
	        add: function(e, data){
	        	var uploadFile = data.files[0];
	            var isValid = true;
	            
	            if ( (/exe/i).test(uploadFile.name.toLowerCase() ) 
	            || (/asp/i).test(uploadFile.name.toLowerCase() ) 
	            || (/apsx/i).test(uploadFile.name.toLowerCase() ) 
	            || (/php/i).test(uploadFile.name.toLowerCase() ) 
	            || (/jsp/i).test(uploadFile.name.toLowerCase() ) 
	            || (/cs/i).test(uploadFile.name.toLowerCase() ) 
	            || (/js/i).test(uploadFile.name.toLowerCase() ) 
	            || (/eml/i).test(uploadFile.name.toLowerCase() ) 
	            || (/htm/i).test(uploadFile.name.toLowerCase() ) 
	            || (/html/i).test(uploadFile.name.toLowerCase() ) 
	            || (/bin/i).test(uploadFile.name.toLowerCase() ) 
	            ) {
	                alert('업로드가 불가능한 파일입니다.');
	                isValid = false;
	            }
	             if ( uploadFile.size > 20000000 ) { // 2mb
	                alert('파일 용량은 20MB 이상을 초과할 수 없습니다.');
	                isValid = false;
	            }
	             
	            if (isValid) {
	            	$("#loadingImg").attr("style", "display:block;");
	                data.submit();              
	            }
	        }, progressall: function(e,data) {
	        	 $("#popup-wrapper").css('display','block');
	 	    	 $("#progress-box").css('display','block');
	 	    	
	 	        var progress = parseInt(data.loaded / data.total * 100, 10);
	 	       
	 			$("#bar").css(
	 	           'width',
	 	            progress + '%'
	 	        );
	 	        
	 	        if(progress == 100) {
	 	        	$("#popup-wrapper").css('display','none');
	 	        	$("#progress-box").css('display','none');
	 	        }
	        }, done: function (e, data) {
	        	//alert("done");
	           // var code = data.result.code;
	            $("#submit_chk").val("");
	            var msg = data.result.msg;
	            
	            if( msg == "0" ){
	            	 $("#loadingImg").attr("style", "display:none;");
	            	 
	            	 var uploadFile 			= data.files[0];
	            	 var fileSavePath 			=  data.result.fileSavePath;
	 	             var saveFileName 	=  data.result.saveFileName;
	 	             var orgFileName 	=  data.result.orgFileName;
	 	             
	 	            $("#fileSavePath").val(fileSavePath);
	 	            $("#saveFileName").val(saveFileName);
	 	            $("#orgFileName").val(orgFileName);
	 	            
	 	           	var reqUrl = CONTEXT_ROOT + "/lu/online/popupOnlineTraningFileSave.json";
		 	       	var param = $("#frmFile").serializeArray();
		 	      	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
		 	      	if (200 == jqXHR.status ) {
		 	      		var retCd = jqXHR.responseJSON.retCd;
		 	      		var fileSeq = jqXHR.responseJSON.fileSeq;
		 	      		if(retCd == "10000" && fileSeq !=""){
		 	      			alert("업로드가 완료 되었습니다.");
		 	      		 $("#fileList").append("<p id='p_"+fileSeq+"'><br/><a href='http://oklms.wizilearn.co.kr/movies/online/"+$("#weekId").val()+"/"+saveFileName+"'>"+orgFileName+"</a> <a href='javascript:fn_deleteFile("+fileSeq+");' class='btn-del'>삭제</a></p>");
		 	      		} else {
		 	      			alert("업로드에 실패했습니다.")
		 	      		}  
		 	      	}
		 	      	}, {
		 	      		async : true,
		 	      		type : "POST",
		 	      		errorCallback : null
		 	      	});
	            } 
	        }, fail: function(e, data){
	        	$("#popup-wrapper").css('display','none');
	        	$("#progress-box").css('display','none');
	            alert('서버와 통신 중 문제가 발생했습니다');
	        }
	    });  
		
		
		
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

	function fn_deleteFile(fileSeq) {
	 	$("#fileSeq").val(fileSeq);
		var reqUrl = CONTEXT_ROOT + "/lu/online/popupOnlineTraningFileDelete.json";
	    var param = $("#frmFile").serializeArray();
	      
      	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){			
      	if (200 == jqXHR.status ) {
      		var retCd = jqXHR.responseJSON.retCd;
      		if(retCd == "10000"){
      			alert("삭제가 완료 되었습니다.");
      		 	$("#p_"+fileSeq).remove();
      		} else {
      			alert("삭제에 실패했습니다.")
      		}
      	}
      	}, {
      		async : true,
      		type : "POST",
      		errorCallback : null
      	});
	}
	
	function fn_saveFile(){
		var reqUrl = "/lu/online/insertOnlineTraningFile.do";
		$("#frmFile").attr("action", reqUrl);
		$("#frmFile").attr("target","_self");
		$("#frmFile").submit();
	}
	
	function fn_deleteFile(atchFileId){
		var reqUrl = "/lu/online/updateOnlineTraningFile.do";
		$("#atchFileId").val(atchFileId);
		$("#frmFile").attr("action", reqUrl);
		$("#frmFile").attr("target","_self");
		$("#frmFile").submit();
	}
	
</script>
<div id="pop-wrapper">
<form id="frmFile" name="frmFile" method="post" enctype="multipart/form-data">
	<input type="hidden" id="weekId" name="weekId" value="${onlineTraningWeekFileVO.weekId}" />
	<input type="hidden" id="fileSn" name="fileSn" value="1" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="" />
	
					<h1>보조자료</h1>
				
<!-- 팝업 사이즈 : 가로 최소 650px 이상 설정 -->

					<!-- <ul id="popup-wrapper" style="display:none;"> 
					 	<li class="progress-box"  id="progress-box" style="margin-top: 200px; display:none;"> 
					<li class="progress-box"  id="progress-box" style="margin-top: 200px;">
						<dl>
							<dt>현재 파일이 <span>업로드 중</span>입니다.</dt>
							<dd class="bar" id="bar" style="width:0%;"></dd>
							<dd class="bg"></dd>
						</dl>
					</li>
					<li class="popup-bg"></li>
				</ul>E : popup layer -->
					<dl class="attach-file">
						<!-- <dt>첨부파일_01.hwp <a href="#!" class="btn-del">삭제</a></dt> -->
						<dd id="fileList">
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<p><br/><a href="javascript:com.downFile('${result.atchFileId}','${result.fileSn}');"><b>${result.orgFileName}</b></a> <a href="javascript:fn_deleteFile('${result.atchFileId}');" class='btn-del'>삭제</a></p>
						</c:forEach>
						</dd>
					</dl>
					<div class="btn-area align-right mt-010">
						<a href="#" onclick="window.self.close();" class="gray-3">닫기</a>
					</div><!-- E : btn-area -->
</form>
</div><!-- E : wrapper -->
