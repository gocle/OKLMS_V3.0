<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
    function fn_close(){
        self.close();
    }
    
    function fn_exclDownload() {
        var lessonId = "${lessonId}";
        var lessonTitle = "${lessonTitle}";

        location.href =
            "<c:url value='/la/statistics/content/excelUsedCourse.do'/>"
            + "?lessonId=" + encodeURIComponent(lessonId)
            + "&lessonTitle=" + encodeURIComponent(lessonTitle);
    }
    </script>
</script>

<form id="frmPop" method="post">

<div id="popup-wrarpr">
<div id="popup-header">
    <h1>
        <img src="/images/oklms/adm/inc/pop_border_02.png" alt="" />
        사용 과목 목록
    </h1>
    <p><a href="#" onclick="fn_close();">닫기</a></p>
</div>

<div id="popup-content-area">
<div id="popup-container">

<h1>${lessonTitle}</h1>
<ul class="board-info">
    <li class="btn-area"> 
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul>
<table class="list-1">
    <thead>
        <tr>
            <th>년도</th>
            <th>학기</th>
            <th>과목코드</th>
            <th>교과목명</th>
            <th>분반</th>
            <th>수강생수</th>
        </tr>
    </thead>

    <tbody>
        <c:if test="${empty resultList}">
            <tr>
                <td colspan="6" align="center">사용 중인 과목이 없습니다.</td>
            </tr>
        </c:if>

        <c:forEach var="row" items="${resultList}">
            <tr>
                <td>${row.yyyy}</td>
                <td>${row.term}</td>
                <td>${row.subjectCode}</td>
                <td class="left">${row.subjectName}</td>
                <td>${row.subjectClass}</td>
                <td>${row.studyCnt}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</div>
</div>

<div id="popup-footer"></div>
</div>
</form>