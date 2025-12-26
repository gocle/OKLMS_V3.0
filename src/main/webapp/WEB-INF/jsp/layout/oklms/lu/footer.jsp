<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ############### Footer ############### -->
<script>
function fn_pop_private(){
	popOpenWindow("", "popPrivate", 850, 750);
	var reqUrl = "/private/private_info.html";
	//$("#rowId").val(rowId);
	$("#frmPrivate").attr("action", reqUrl);
	$("#frmPrivate").attr("target", "popPrivate");
	$("#frmPrivate").submit();
}
</script>

<form name="frmPrivate" id="frmPrivate">
</form>
<div id="main-footer">
	<div class="container">
		<div class="privacy"><a href="javascript:void(0);" onclick="window.open('https://www.koreatech.ac.kr/menu.es?mid=a10903000000', '_blank');" style="color:#FFF;">개인정보처리방침</a></div>
		<p>(31253) 충청남도 천안시 동남구 병천면 충절로 1600 (가전리, 한국기술교육대학교)<br />
		사업자등록번호 : 312-82-03357 / 통신판매업신고 : 제2016-충남천안-0210호 한국기술교육대학교 대표자 : 이성기<br />
		</p>
		<copyright>
		COPYRIGHT <span>KOREA UNIVERSITY OF TECHNOLOGY AND EDUCATION</span>. ALL RIGHTS RESERVED.
		</copyright>
	</div>
</div>
<!-- E : main-footer -->
<!-- ############### // Footer ############### -->