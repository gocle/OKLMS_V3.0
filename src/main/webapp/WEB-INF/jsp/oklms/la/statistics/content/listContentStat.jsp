<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/>

<c:set var="targetUrl" value="/la/statistics/" />

<style>
a.link-toggle {
    color: #0066cc;          /* 파란색 */
    text-decoration: underline;
    cursor: pointer;
}

a.link-toggle:hover {
    color: #003366;          /* hover 시 진한 파랑 */
    text-decoration: underline;
}
</style>

<script type="text/javascript">
var targetUrl = "${targetUrl}";

function press(e) {
    if (e.keyCode === 13) {
        fn_search(1);
    }
}

function fn_search(pageNo) {
    $("#pageIndex").val(pageNo);
    $("#frmStat").attr("action", CONTEXT_ROOT + targetUrl + "content/listContentStat.do");
    $("#frmStat").submit();
}

function fn_toggleStatDetail(courseContentId, btn){

    var row = $("#stat_detail_" + courseContentId);

    if(row.is(":visible")){
        row.hide();
        btn.innerText = "차시보기 ▼";
        return;
    }

    row.show();
    btn.innerText = "차시닫기 ▲";

    if(row.data("loaded") === "Y") return;

    $.ajax({
        url : CONTEXT_ROOT + "/la/statistics/content/courseContentDetail.json",
        type : "POST",
        data : { courseContentId : courseContentId },
        success : function(res){

            var html = "";

            if(!res || res.length === 0){
                html += "<tr>";
                html += "<td colspan='3'>차시 정보 없음</td>";
                html += "</tr>";
            } else {
                $.each(res, function(i, item){
                    html += "<tr>";
                    html += "<td class='left'>" + item.lessonTitle + "</td>";
                    html += "<td>";
                    html += "<a href='#;' class='link-toggle' onclick=\"fn_openUsedCoursePopup('"
                         + item.lessonId + "', '"
                         + item.lessonTitle + "')\">";
                    html += item.usedCourseCnt;
                    html += "</a>";
                    html += "</td>";
                    html += "<td>" + item.studentCnt + "</td>";
                    html += "</tr>";
                });
            }

            $("#stat_detail_body_" + courseContentId).html(html);
            row.data("loaded", "Y");
        }
    });
}

function fn_openUsedCoursePopup(lessonId, lessonTitle){
    window.open(
        CONTEXT_ROOT + "/la/statistics/content/popupUsedCourse.do?lessonId=" + lessonId +"&lessonTitle=" + lessonTitle,
        "usedCoursePopup",
        "width=700,height=600,scrollbars=yes"
    );
}

function fn_exclDownload(){
    $("#frmStat")
        .attr("action", CONTEXT_ROOT + targetUrl + "content/listContentStatExcel.do")
        .submit();
}
</script>

<form id="frmStat" name="frmStat" method="post">
    <input type="hidden" id="pageSize" name="pageSize" value="${pageSize}" />
    <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />

    <ul class="search-list-1">
        <li>
            <span>산하기관</span>
            <select id="searchInstitutionId" name="searchInstitutionId">
				<option value="">산하기관</option>
				<option value="A"  <c:if test="${cmsCourseBaseVO.searchInstitutionId eq 'A'}">selected</c:if> >평생능력</option>
				<option value="B"  <c:if test="${cmsCourseBaseVO.searchInstitutionId eq 'B'}">selected</c:if> >코리아텍</option>
			</select>
        </li>

        <li>
            <span>개발년도</span>
            <select id="searchYear" name="searchYear"> 
				<option value="" >개발년도</option>
				<c:forEach var="i" begin="0" end="16" step="1">
					<option value="${nowYear-i}" <c:if test="${cmsCourseBaseVO.searchYear eq nowYear-i }" > selected="selected"  </c:if>>${nowYear-i}</option>
				</c:forEach>								
			</select>
        </li>

        <li>
            <span>콘텐츠명</span>
            <input type="text" name="searchWrd" id="searchWrd" value="${cmsCourseBaseVO.searchWrd}" onkeypress="press(event);"" style="width:150px"/>
        </li>
    </ul>
</form>

<div class="search-btn-area">
    <a href="#@" onclick="fn_search(1); return false;">조회</a>
</div>

<ul class="board-info">
    <li class="info-area">
        <span>전체</span> :
        <c:out value="${paginationInfo.totalRecordCount}" /> 건
    </li>
    <li class="btn-area"> 
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul>

<table class="list-1">
    <thead>
        <tr>
        	<th>번호</th>
        	<th>산하기관</th>
            <th>개발년도</th>
            <th>콘텐츠명</th>
            <th>사용 횟수</th>
            <th>수강생 수</th>
            <th>차시</th>
        </tr>
    </thead>

    <tbody>
        <c:if test="${empty resultList}">
            <tr>
                <td colspan="6">조회된 데이터가 없습니다.</td>
            </tr>
        </c:if>

        <c:set var="prevCourseCode" value="" />

        <c:forEach var="row" items="${resultList}" varStatus="status">
		    <tr>
		        <td>
		            <c:out value="${paginationInfo.totalRecordCount
		                - ((pageIndex-1) * pageSize + status.index)}"/>
		        </td>
		
		        <td rowspan="${row.row_number}">
		            ${row.institutionName}
		        </td>
		
		        <td rowspan="${row.row_number}">
		            ${row.year}
		        </td>
		
		        <td class="left">
		            ${row.subtitle}
		        </td>
		
				<td>${row.usedCourseCnt}</td>
				<td>${row.studentCnt}</td>
				
		        <td>
		            <a href="#;" class="link-toggle" onclick="fn_toggleStatDetail('${row.id}', this); return false;">
		                차시보기 ▼
		            </a>
		        </td>
		    </tr>
		
		    <!-- 차시 상세 -->
		    <tr id="stat_detail_${row.id}" style="display:none;" data-loaded="N">
		
		        <td colspan="7" class="pd-none">
		
		            <table class="list-1" style="margin:10px 0;">
		            	<colgroup>
			                <col style="width:70%;" />
			                <col style="width:15%;" />
			                <col style="width:15%;" />
			            </colgroup>
		                <thead>
		                    <tr>
		                        <th>차시명</th>
		                        <th>사용 횟수</th>
		                        <th>수강생 수</th>
		                    </tr>
		                </thead>
		
		                <tbody id="stat_detail_body_${row.id}">
		                    <tr>
		                        <td colspan="3">차시 정보를 불러오는 중...</td>
		                    </tr>
		                </tbody>
		            </table>
		
		        </td>
		    </tr>
		
		</c:forEach>
    </tbody>
</table>

<!-- ===================== 페이징 ===================== -->
<div class="page-num">
    <ui:pagination
        paginationInfo="${paginationInfo}"
        type="image"
        jsFunction="fn_search"/>
</div>