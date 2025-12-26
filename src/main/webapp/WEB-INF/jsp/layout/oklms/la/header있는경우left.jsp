<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- ############### LA Left ############### -->
			<li id="menu-area">
				<h1>LMS 관리자</h1>
				<dl class="menu-1">
					<dt><a href="#!">회원 관리</a></dt>
					<dd>
						<a href="#!">일반회원</a>
						<a href="#!">판매자</a>
						<a href="#!">운영강사</a>
						<a href="#!">관리자</a>
						<a href="#!">탈퇴현황</a>
					</dd>
				</dl>
				<dl class="menu-2">
					<dt><a href="#!">승인 관리</a></dt>
					<dd>
						<a href="#!">판매자 승인 관리</a>
						<a href="#!">콘텐츠 승인 관리</a>
					</dd>
				</dl>
				<dl class="menu-3">
					<dt><a href="#!">콘텐츠 관리</a></dt>
					<dd>
						<a href="#!">과정목록</a>
						<a href="#!">구매관리</a>
						<a href="#!">학습관리</a>
						<a href="#!">상품판매중지</a>
						<a href="#!">이벤트/세일관리</a>
						<a href="#!">모니터링</a>
					</dd>
				</dl>
				<dl class="menu-4">
					<dt><a href="#!">결제 관리</a></dt>
					<dd>
						<a href="#!">결제현황</a>
						<a href="#!">환불현황</a>
						<a href="#!">환불신청내역</a>
					</dd>
				</dl>
				<dl class="menu-5">
					<dt><a href="#!">정산 관리</a></dt>
					<dd>
						<a href="#!">정산 정보 및 설정</a>
						<a href="#!">포인트 정보 및 설정</a>
					</dd>
				</dl>
				<dl class="menu-6">
					<dt><a href="#!">게시판 관리</a></dt>
					<dd>
						<a href="#!">1:1 문의게시판</a>
						<a href="#!">팝업관리</a>
						<a href="#!">배너관리</a>
						<a href="#!">공지사항관리</a>
						<a href="#!">자주하는질문</a>
						<a href="#!">이벤트게시판</a>
					</dd>
				</dl>
				<dl class="menu-7">
					<dt><a href="#!">시스템 관리</a></dt>
					<dd>
						<a href="#!">메세지관리</a>
						<a href="#!">성절관리</a>
					</dd>
				</dl>
				<dl class="menu-8">
					<dt><a href="#!">통계</a></dt>
					<dd>
						<a href="#!">매출통계</a>
						<a href="#!">상품별 구매 통계</a>
						<a href="#!">로그인 통계</a>
						<a href="#!">정보공유 조회, 추천수 통계</a>
					</dd>
				</dl>
			</li>
			
			
			
			
			
			
			
			
			
		<c:set var="upperMenuNo" value="TOP"/>
		<c:set var="menuLevel" value="1"/>
		<c:set var="key1" value="${ upperMenuNo}_${menuLevel}"/>
		<c:if test="${not empty menuList[key1]}">
				<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
						<h2>${menu1.menuTitle }</h2>
						<c:set var="key2" value="${ menu1.menuId}_${menu1.menuLevel+1}"/>
						<c:if test="${not empty menuList[key2]}">
							<ul class="depth2">
								<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">
									<li><a id="a_${menu2.menuId }" href="#" onclick="javascript:com.subPageMove('${menu2.rootMenuId }', '${menu2.menuId }' , false);">${menu2.menuTitle }</a>
										<c:set var="key3" value="${ menu2.menuId}_${menu2.menuLevel+1}"/>
										<c:if test="${not empty menuList[key3]}">
											<ul class="depth3">
												<c:forEach var="menu3" items="${menuList[key3]}" varStatus="status3">
													<li><a id="a_${menu3.menuId }" href="#" onclick="javascript:com.subPageMove('${menu3.rootMenuId }', '${menu3.menuId }' , false);">${menu3.menuTitle }</a>
														<c:set var="key4" value="${ menu3.menuId}_${menu3.menuLevel+1}"/>
														<c:if test="${not empty menuList[key4]}">
															<ul class="depth4">
																<c:forEach var="menu4" items="${menuList[key4]}" varStatus="status3">
																	<li><a id="a_${menu4.menuId }" href="#" onclick="javascript:com.subPageMove('${menu4.rootMenuId }', '${menu4.menuId }' , false);">${menu4.menuTitle }</a></li>
																</c:forEach>														
															</ul>				
														</c:if>
													</li>
												</c:forEach>
											</ul>
										</c:if>
									</li>
								</c:forEach>
							</ul>
						</c:if>
				</c:forEach>
		</c:if>

<script type="text/javascript">
// $("#a_${menuId }").css('background', '#1b77d3 url("/images/lnb_bg.png") no-repeat right top');
// $("#a_${menuId }").css('color', '#FFF');

// $("#a_${menuId }").css('color', '#1b77d3');
// $("#a_${menuId }").css('background', 'white');

$("#a_${menuId }").parent().addClass("on");

</script>
		
<!-- ############### // LA Left ############### -->