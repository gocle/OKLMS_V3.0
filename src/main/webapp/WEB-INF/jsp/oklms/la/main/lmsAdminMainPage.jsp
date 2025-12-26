<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<script type="text/javascript">

//엑셀 다운로드 ddd
function fn_exclDownload(){					
	var reqUrl = "/la/main/lmsAdminMainPageExcelDownload.do";
	
	$("#frmMember").attr("action", reqUrl);
	$("#frmMember").attr("target","_self");
	$("#frmMember").submit();
}

function fn_sync(){
	var reqUrl = "/la/main/stdMerge.json";
 	var param = {"":""};
	com.ajax(reqUrl, param, function(obj, data, textStatus, jqXHR){	
		if (200 == jqXHR.status ) {
			var retData 	= jqXHR.responseJSON.retData;
			var retCd 	= jqXHR.responseJSON.retCd;
			if(retCd == 10000 ){
				location.href = "/la/main/lmsAdminMainPage.do";
			} else {
				//alert("등록에 실패했습니다.")
			}
		} else {
			//alert("처리에 실패했습니다.")
		}
	}, {
		async : true,
		type : "POST",
		errorCallback : null
	});
}


</script>

<!-- 
						<ul class="main-content">
							<li class="type-1">
								<div class="board-title">판매자 승인신청 <span>승인대기 : 총 4건</span></div>

								<table border="0" cellpadding="0" cellspacing="0" class="list-1">
									<thead>
										<tr>
											<th>업체명</th>
											<th width="65px">ID</th>
											<th width="40px">구분</th>
											<th width="65px">신청일</th>
											<th width="40px">상태</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><a href="">온라인평생교육원</a></td>
											<td>mrHong</td>
											<td>무료</td>
											<td>2016.06.01</td>
											<td>대기</td>
										</tr>
										<tr>
											<td><a href="">온라인평생교육원</a></td>
											<td>mrHong</td>
											<td>유료</td>
											<td>2016.06.03</td>
											<td>완료</td>
										</tr>
									</tbody>
								</table>
-->
<!-- E : list -->
<!--

								<div class="more"><a href="">더 보기</a></div>
							</li>



							<li class="type-2">
								<dl id="main-tab-1">
									<dt class="tab-name-11 on"><a href="javascript:showNotice();">공지사항</a></dt>
									<dd id="tab-content-11" style="display:block;">
										<table border="0" cellpadding="0" cellspacing="0" class="list-1">
											<thead>
												<tr>
													<th width="50px">대상</th>
													<th>제목</th>
													<th width="65px">등록일</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>구매자</td>
													<td class="subject"><a href="">평생능력개발 21차 우수 학습자1</a></td>
													<td>2016.06.01</td>
												</tr>
												<tr>
													<td>구매자</td>
													<td class="subject"><a href="">시스템 점검안내</a></td>
													<td>2016.06.01</td>
												</tr>
											</tbody>
										</table>

										<div class="more"><a href="">더 보기</a></div>
									</dd>



									<dt class="tab-name-12"><a href="javascript:showEvent();">이벤트</a></dt>
									<dd id="tab-content-12">
										<table border="0" cellpadding="0" cellspacing="0" class="list-1">
											<thead>
												<tr>
													<th width="50px">대상</th>
													<th>제목</th>
													<th width="65px">등록일</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>구매자</td>
													<td class="subject"><a href="">평생능력개발 21차 우수 학습자2</a></td>
													<td>2016.06.01</td>
												</tr>
												<tr>
													<td>구매자</td>
													<td class="subject"><a href="">시스템 점검안내</a></td>
													<td>2016.06.01</td>
												</tr>
											</tbody>
										</table>

										<div class="more"><a href="">더 보기</a></div>
									</dd>
								</dl>
							</li>
						</ul>



						<ul class="main-content">
							<li class="type-1">
								<div class="board-title">콘텐츠 승인신청 <span>승인대기 : 총 4건</span></div>
								<table border="0" cellpadding="0" cellspacing="0" class="list-1">
									<thead>
										<tr>
											<th width="65px">업체명</th>
											<th>콘텐츠명</th>
											<th width="65px">신청일</th>
											<th width="40px">이력</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>구매자</td>
											<td class="subject"><a href="">평생능력개발 21차 연수 우수 학습자</a></td>
											<td>2016.06.01</td>
											<td>대기</td>
										</tr>
										<tr>
											<td>구매자</td>
											<td class="subject"><a href="">시스템 점검안내</a></td>
											<td>2016.06.03</td>
											<td>완료</td>
										</tr>
									</tbody>
								</table>
-->
<!-- E : list -->
<!--

								<div class="more"><a href="">더 보기</a></div>
							</li>



							<li class="type-2">
								<dl id="main-tab-2">
									<dt class="tab-name-21 on"><a href="javascript:showDaily();">일별 매출</a></dt>
									<dd id="tab-content-21" style="display:block;">
										<div class="date">2016.05.20. 16:00 기준</div>
										<div class="graph-area">
											그래프 영역
										</div>

										<div class="table-area">
											<table border="0" cellpadding="0" cellspacing="0" class="list-1">
												<thead>
													<tr>
														<th width="45px">날짜</th>
														<th>매출 (원)</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>오늘</td>
														<td class="re-subject">600,000 원</td>
													</tr>
													<tr>
														<td>1일 전</td>
														<td class="re-subject">400,000 원</td>
													</tr>
													<tr>
														<td>2일 전</td>
														<td class="re-subject">600,000 원</td>
													</tr>
													<tr>
														<td>3일 전</td>
														<td class="re-subject">800,000 원</td>
													</tr>
													<tr>
														<td>4일 전</td>
														<td class="re-subject">1,000,000 원</td>
													</tr>
												</tbody>
											</table>
-->
<!-- E : list -->
<!--

										</div>
									</dd>
									<dt class="tab-name-22"><a href="javascript:showMonthly();">월별 매출</a></dt>
									<dd id="tab-content-22">
										<div class="date">2016.06.07. 16:00 기준</div>
										<div class="graph-area">
											그래프 영역
										</div>

										<div class="table-area">
											<table border="0" cellpadding="0" cellspacing="0" class="list-1">
												<thead>
													<tr>
														<th width="45px">날짜</th>
														<th>매출 (원)</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>이번 달</td>
														<td class="re-subject">600,000 원</td>
													</tr>
													<tr>
														<td>1달 전</td>
														<td class="re-subject">400,000 원</td>
													</tr>
													<tr>
														<td>2달 전</td>
														<td class="re-subject">600,000 원</td>
													</tr>
													<tr>
														<td>3달 전</td>
														<td class="re-subject">800,000 원</td>
													</tr>
													<tr>
														<td>4달 전</td>
														<td class="re-subject">1,000,000 원</td>
													</tr>
												</tbody>
											</table>
-->
<!-- E : list -->
<!--
										</div>
									</dd>
								</dl>
							</li>
						</ul>



						<ul class="main-content">
							<li class="type-3">
								<dl id="main-tab-3">
									<dt class="tab-name-31 on"><a href="javascript:showQna();">1:1 문의 전체</a></dt>
									<dd id="tab-content-31" style="display:block;">
										<div class="stats"><span>답변대기</span> : 총 10건&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>답변요청</span> : 총 2건</div>
										<table border="0" cellpadding="0" cellspacing="0" class="list-1">
											<thead>
												<tr>
													<th width="30px">번호</th>
													<th width="50px">회원</th>
													<th width="80px">구분</th>
													<th>제목</th>
													<th width="80px">작성자</th>
													<th width="120px">작성일</th>
													<th width="40px">상태</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>31</td>
													<td>구매자</td>
													<td>결제/취소 관련</td>
													<td class="subject"><a href="">판매자 등록을 하면 언제쯤 사용이 가능한가요?</a></td>
													<td>mrHong</td>
													<td>2016.06.01 16:40:25</td>
													<td>대기</td>
												</tr>
												<tr>
													<td>30</td>
													<td>구매자</td>
													<td>관리자 문의</td>
													<td class="subject"><a href="">결제 시 카드사용 내역에 대한 문의</a></td>
													<td>mrHong</td>
													<td>2016.06.01 16:40:25</td>
													<td>완료</td>
												</tr>
											</tbody>
										</table>
-->										
<!-- E : list -->
<!--
										<div class="more"><a href="">더 보기</a></div>
									</dd>



									<dt class="tab-name-32"><a href="javascript:showPurchase();">구매 관련</a></dt>
									<dd id="tab-content-32">ㅊ2
										<div class="more"><a href="">더 보기</a></div>
									</dd>



									<dt class="tab-name-33"><a href="javascript:showPayment();">결제/취소 관련</a></dt>
									<dd id="tab-content-33">ㅊ3
										<div class="more"><a href="">더 보기</a></div>
									</dd>



									<dt class="tab-name-34"><a href="javascript:showSystem();">시스템</a></dt>
									<dd id="tab-content-34">ㅊ4
										<div class="more"><a href="">더 보기</a></div>
									</dd>



									<dt class="tab-name-35"><a href="javascript:showEtc();">기타</a></dt>
									<dd id="tab-content-35">ㅊ5
										<div class="more"><a href="">더 보기</a></div>
									</dd>



									<dt class="tab-name-36"><a href="javascript:showRequest();">판매자 요청</a></dt>
									<dd id="tab-content-36">ㅊ6
										<div class="more"><a href="">더 보기</a></div>
									</dd>
								</dl>
							</li>
						</ul>
 -->
<!--  <ul class="main-content">
 <li>
 <span>Main</span>
 </li>
 </ul> -->
 
 <div class="main-content">
  <ul class="board-info" style="margin-top: -20px;">
	<li class="btn-area"> 
		<a href="#fn_exclDownload" onclick="javascript:fn_sync( ); return false" onkeypress="this.onclick;" class="btn">학적상태 동기화</a>
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>
	</li>
</ul>
 	<h2 class="title">학습근로자 교육훈련 현황</h2>
 	<h3 class="title">대학연계형</h3>
 	<c:set var="n1_tot" value="0"/>
 	<c:set var="n2_tot" value="0"/>
 	<c:set var="n3_tot" value="0"/>
 	<c:set var="n4_tot" value="0"/>
 	<c:set var="n5_tot" value="0"/>
 	<c:set var="n6_tot" value="0"/>
 	<div class="table-responsive">
 	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<colgroup>		
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
			<col width="12.5%" />
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2" colspan="2">구분</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<th colspan="2"><c:out value="${resultList.deptName}" /></th>
			</c:if>
		</c:forEach>				

			</tr>
			<tr>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<th>훈련중 인원(재학인원)</th>
				<th>제적인원</th>
			</c:if>
		</c:forEach>
			</tr>
		</thead>
		<tbody>
		
			<tr>
				<th colspan="2">1학년</th>								
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt1}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt1}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt1}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt1}"/>
			</c:if>
		</c:forEach>		
			</tr>


			<tr>
				<th colspan="2">2학년</th>								
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt2}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt2}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt2}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt2}"/>
			</c:if>
		</c:forEach>		
			</tr>
			
			<tr>
				<th rowspan="2">3학년</th>
				<th>신입</th>							
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt3}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt3}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt3}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt3}"/>
			</c:if>
		</c:forEach>		
			</tr>
			<tr>
				<th>편입</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt32}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt32}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt32}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt32}"/>
			</c:if>
		</c:forEach>	
			</tr>	

			<tr>
				<th rowspan="2">4학년</th>
				<th>신입</th>							
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt4}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt4}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt4}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt4}"/>
			</c:if>
		</c:forEach>		
			</tr>
			<tr>
				<th>편입</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt42}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt42}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt42}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt42}"/>
			</c:if>
		</c:forEach>	
			</tr>	
			
			
			<tr>
				<th rowspan="2">5학년</th>
				<th>신입</th>							
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt5}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt5}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt5}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt5}"/>
			</c:if>
		</c:forEach>		
			</tr>
			<tr>
				<th>편입</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'N' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt52}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt52}" /></a></td>
				<c:set var="n1_tot" value="${n1_tot+resultList.runCnt52}"/>
 				<c:set var="n2_tot" value="${n2_tot+resultList.failCnt52}"/>
			</c:if>
		</c:forEach>	
			</tr>	
			
			<%-- <tr>
				<th colspan="2">합계</th>
				<td>${n1_tot}</td>
				<td>${n2_tot}</td>
			</tr>	  --%>
			
			<!-- <tr>
				<th colspan="2">합계</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr> -->
					
		</tbody>
	</table>
	</div>
	
	
	<h3 class="title">고숙련마이스터과정</h3>
 	<div class="table-responsive">
 	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<colgroup>		
			<col width="*" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2">구분</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<th colspan="2"><c:out value="${resultList.deptName}" /></th>
			</c:if>
		</c:forEach>	 
			</tr>
			<tr>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<th>훈련중 인원(재학인원)</th>
				<th>제적인원</th>
			</c:if>
		</c:forEach>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>1학년</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt1}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt1}" /></a></td>
			</c:if>
		</c:forEach> 
			</tr>
			<tr>
				<th>2학년</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt2}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt2}" /></a></td>
			</c:if>
		</c:forEach>
			</tr>
			<!-- 
			<tr>
				<th>3학년</th>
		<c:forEach items="${resultList}" var="resultList" varStatus="status">
			<c:if test="${resultList.mstYn eq 'Y' }">
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.runCnt3}" /></a></td>
				<td><a href="/la/statistics/traningstatus/listDepartmentStat.do"><c:out value="${resultList.failCnt3}" /></a></td>
			</c:if>
		</c:forEach>
			</tr>
			-->
			<!-- <tr>
				<th>합계</th>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr> -->
		</tbody>
	</table>
	</div>
	
	
	<h2 class="title mt_50">학습기업 현황</h2>
	<%-- <div class="table-responsive">
 	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<colgroup>		
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
			<col width="16.666%" />
		</colgroup>
		<thead>
			<tr>
				<th colspan="2">종합</th>
				<th colspan="2">대학연계형</th>
				<th colspan="2">고숙련마이스터과정</th>
			</tr>
			<tr>
				<th>참여기업 수</th>
				<th>훈련 중 기업 수</th>
				<th>참여기업 수</th>
				<th>훈련 중 기업 수</th>
				<th>참여기업 수</th>
				<th>훈련 중 기업 수</th>
			</tr>
		</thead>
		<tbody>
			<tr> 			
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.departmentA}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.departmentB}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.departmentC}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.departmentD}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.departmentE}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.departmentF}" /></a></td>
			</tr>
		</tbody>
	</table>
	</div> --%>
	<div class="table-responsive">
 	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<colgroup>		
			<col width="25%" />
			<col width="25%" />
			<col width="25%" />
			<col width="25%" />
		</colgroup>
		<thead>
			<tr>
				<th>합계</th>
				<th>훈련 징행중인 기업 수</th>
				<th>참여 대기중인 기업 수</th>
				<th>참여포기 기업 수</th>
			</tr>
		</thead>
		<tbody>
			<tr> 			
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.statusTotalCnt}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.status1}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.status2}" /></a></td>
				<td><a href="/la/statistics/company/listCompanyStat.do"><c:out value="${companyVO.status3}" /></a></td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<h2 class="title mt_50">훈련과정 현황</h2>
	<div class="table-responsive">
	
	<c:set var="dept_tot" value="0"/>
 	<c:set var="dept1_tot" value="0"/>
 	<c:set var="dept2_tot" value="0"/>
 	<c:set var="dept3_tot" value="0"/>
 	<c:set var="dept4_tot" value="0"/>
 	<c:set var="dept5_tot" value="0"/>
 	<c:set var="dept6_tot" value="0"/>
	
 	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<colgroup>		
			<col width="14.285%" />
			<col width="14.285%" />
			<col width="14.285%" />
			<col width="14.285%" />
			<col width="14.285%" />
			<col width="14.285%" />
			<col width="14.285%" />
		</colgroup>
		<thead>
			<tr>
				<th>학과명</th>
				<th>기전융합공학과</th>
				<th>기계설계공학과</th>
				<th>강소기업경영학과</th>
				<th>기계설비제어공학과</th>
				<th>IT융합소프트웨어공학과</th>
				<th>스마트팩토리융합학과</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${deptList}" var="result" varStatus="status">
			<tr> 			
				<td>
					<c:choose>
						<c:when test="${status.count eq '1'}">훈련 진행중인 과정 수</c:when>
						<c:otherwise>전체 중도탈락 과정 수</c:otherwise>
					</c:choose>
				</td>
				<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result.dept1}" /></a></td>
				<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result.dept2}" /></a></td>
				<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result.dept3}" /></a></td>
				<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result.dept4}" /></a></td>
				<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result.dept5}" /></a></td>
				<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result.dept6}" /></a></td>
				
			 	<c:set var="dept1_tot" value="${dept1_tot + result.dept1}"/>
			 	<c:set var="dept2_tot" value="${dept2_tot + result.dept2}"/>
			 	<c:set var="dept3_tot" value="${dept3_tot + result.dept3}"/>
			 	<c:set var="dept4_tot" value="${dept4_tot + result.dept4}"/>
			 	<c:set var="dept5_tot" value="${dept5_tot + result.dept5}"/>
			 	<c:set var="dept6_tot" value="${dept6_tot + result.dept6}"/>
				
			</tr>
		</c:forEach>
			<tr> 			
				<td>합계</td>
				<td><c:out value="${dept1_tot}" /></td>
				<td><c:out value="${dept2_tot}" /></td>
				<td><c:out value="${dept3_tot}" /></td>
				<td><c:out value="${dept4_tot}" /></td>
				<td><c:out value="${dept5_tot}" /></td>
				<td><c:out value="${dept6_tot}" /></td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<%-- <div class="left-area">
		<h3 class="title">대학연계형</h2>
		<div class="table-responsive">
	 	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
			<colgroup>		
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th>훈련실시 과정 수</th>
					<th>전체중탈 과정 수</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				 
					<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result[0].TRAINING_TOTAL}" /></a></td>
					<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result[1].TRAINING_TOTAL}" /></a></td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
	
	<div class="right-area">
		<h3 class="title">고숙련마이스터과정</h2>
		<div class="table-responsive">
	 	<table border="0" cellpadding="0" cellspacing="0" class="list-1" >
			<colgroup>		
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th>훈련실시 과정 수</th>
					<th>전체중탈 과정 수</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result[2].TRAINING_TOTAL}" /></a></td>
					<td><a href="/la/statistics/traningprocess/listTraningProcessStat.do"><c:out value="${result[3].TRAINING_TOTAL}" /></a></td>
				</tr>
			</tbody>
		</table>
		</div>
	</div> --%>
	<div class="clearfix"></div>
	
 </div>
<form name="frmMember" id="frmMember" method="post">
 
 </form>

