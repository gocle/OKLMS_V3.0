<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
 
 
 						<h2>훈련일지</h2>
 
<script type="text/javascript" src="/js/jquery/jquery.raty.js"></script>
						<h4 class="mb-010"><span>기전공학기초설계2</span>  2016학년도 2학기</h4>
						<table class="type-1-1 mb-030">
							<colgroup>
								<col style="width:6%" />
								<col style="width:15%" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:*" />
								<col style="width:8%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">주차</th>
									<th scope="col">기간</th>
									<th scope="col">능력단위</th>
									<th scope="col">능력단위요소</th>
									<th scope="col">수업내용</th>
									<th scope="col">주간<br />훈련시간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<label for="email3">주차</label>
										<select id="email3" onchange="">
											<option value="">1</option>
											<option value="">2</option>
											<option value="">3</option>
											<option value="">4</option>
											<option value="">5</option>
											<option value="">6</option>
											<option value="">7</option>
											<option value="">8</option>
										</select>
									</td>
									<td>20160919 ~ 20160923</td>
									<td>능력단위_01</td>
									<td>능력단위요소_02</td>
									<td class="left">강의계획서에 기재된 주차 수업내용</td>
									<td>3</td>
								</tr>
							</tbody>
						</table>



						<div class="learner-training">
							<dl>
								<dt>정규수업 : 2016.10.31(월) 14:00~17:00 (3시간)</dt>
								<dd style="display:block;">
									<script type="text/javascript" src="../../../js/jquery.raty.js"></script>
									<table class="type-2">
										<colgroup>
											<col width="15%" />
											<col width="15%" />
											<col width="15%" />
											<col width="8%" />
											<col width="17%" />
											<col width="8%" />
											<col width="*" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">기업명</th>
												<th scope="col">학번</th>
												<th scope="col">성명</th>
												<th scope="col">훈련시간</th>
												<th scope="col">성취도</th>
												<th scope="col">온라인</th>
												<th scope="col">비고 (교육 중 특이사항 등)</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>기업명_01</td>
												<td>2016000001</td>
												<td>학습근로자_01</td>
												<td>3</td>
												<td class="star"></td>
												<td>80%</td>
												<td class="left"><input type="text" style="width:95%;" /></td>
											</tr>
											<tr>
												<td>기업명_01</td>
												<td>2016000001</td>
												<td>학습근로자_01</td>
												<td>3</td>
												<td class="star"></td>
												<td>80%</td>
												<td class="left"><input type="text" style="width:95%;" /></td>
											</tr>
											<tr>
												<td>기업명_01</td>
												<td>2016000001</td>
												<td>학습근로자_01</td>
												<td>3</td>
												<td class="star"></td>
												<td>80%</td>
												<td class="left"><input type="text" style="width:95%;" /></td>
											</tr>
											<tr>
												<th>총평</th>
												<td colspan="6" class="left"><textarea name="textarea" rows="5">총평을 작성해주세요</textarea></td>
											</tr>
										</tbody>
									</table>

									<div class="btn-area align-center mt-010">
										<a href="#!" class="black">저장</a> <a href="#!" class="black">취소</a>
									</div>

									<script type="text/javascript">
										$(function() {
											$('.star').raty({
												score: 3
												,path : "../../../image/std/inc"
											});
										});
									</script>
								</dd>
							</dl><!-- E : 정규수업 -->


							<dl>
								<dt>보강수업 : 2016.10.31(월) 14:00~17:00 (3시간)</dt>
								<dd style="display:block;">
									<script type="text/javascript" src="../../../js/jquery.raty.js"></script>
									<table class="type-2">
										<colgroup>
											<col width="15%" />
											<col width="15%" />
											<col width="15%" />
											<col width="8%" />
											<col width="17%" />
											<col width="*" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">기업명</th>
												<th scope="col">학번</th>
												<th scope="col">성명</th>
												<th scope="col">훈련시간</th>
												<th scope="col">성취도</th>
												<th scope="col">보강비고 (교육 중 특이사항 등)</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>기업명_01</td>
												<td>2016000001</td>
												<td>학습근로자_01</td>
												<td>3</td>
												<td class="star"></td>
												<td class="left"><input type="text" style="width:97%;" /></td>
											</tr>
											<tr>
												<td>기업명_01</td>
												<td>2016000001</td>
												<td>학습근로자_02</td>
												<td>3</td>
												<td class="star"></td>
												<td class="left"><input type="text" style="width:97%;" /></td>
											</tr>
											<tr>
												<td>기업명_01</td>
												<td>2016000001</td>
												<td>학습근로자_03</td>
												<td>3</td>
												<td class="star" id="star3"></td>
																		<input type="text" name="score" id="star3score" valeu="">
																		
																		
												<td class="left"><input type="text" style="width:97%;" /></td>
											</tr>
											<tr>
												<th>보강총평</th>
												<td colspan="5" class="left"><textarea name="textarea" rows="5">총평을 작성해주세요</textarea></td>
											</tr>
										</tbody>
									</table>

									<div class="btn-area align-center mt-010">
										<a href="#!" class="black">저장</a> <a href="#!" class="black">취소</a>
									</div>

									<script type="text/javascript">
										$(function() {
											$('.star').raty({
												cancel :true
												,score: 5
												,path : "/images/oklms/std/inc"
												,mouseover : function(score, evt) {
													var target = $('#star3score');

													if (score == null) {
													  target.val("");
													} else if (score == undefined) {
													  target.val("");
													} else {
														target.val(score);
													}
												  }
											});
										});
									</script>
								</dd>
							</dl><!-- E : 보강수업 -->
						</div>


						<div class="btn-area align-right mt-010">
							<a href="#!" class="orange">훈련일지 등록</a>
						</div>