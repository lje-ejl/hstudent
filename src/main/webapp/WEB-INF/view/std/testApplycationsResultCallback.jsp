<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalCntComnGrpCod"></span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">과정명</th>
									<th scope="col">시험명</th>
									<th scope="col">응시기간</th>
									<th scope="col">강사명</th>
									<th scope="col">결과</th>
									<th scope="col">시험응시</th>
								</tr>
							</thead>
							
							<tbody id="testResult">
								<tr>
									<th scope="row">시험명</th>
									<td>${testList[0].test_name}</td>
									<th scope="row">점수</th>
									<td>${ansList.test_sco}점 (
										<c:choose>
											<c:when test="${ansList.pass eq 'A'}">합격</c:when>
											<c:when test="${ansList.pass eq 'B'}">재시험</c:when>
											<c:when test="${ansList.pass eq 'C'}">불합격</c:when>
											<c:otherwise>미응시</c:otherwise>
										</c:choose>)
									</td>
								</tr>
								<tr>
									<th scope="row">강의이름</th>
									<td>${testList[0].lec_name}</td>
									<th scope="row">강사명</th>
									<td>${testList[0].tutor_name}</td>
								</tr>
								<tr>
									<th colspan="4">시험문제확인</th>
								</tr>
								
								<c:set var="testAns" value="${fn:split(ansList.test_ans,',')}"/>



								<c:forEach items="${testList}" var="testList" varStatus="vs">
									<!--  여기서 :  ${testAns[vs.count-1]} = 학생의 답안
									 			        ${testList.que_ans} = 실제 답안-->
									
											<tr>
												<td colspan="4" id="test_que"><span>${vs.count}번. </span>${testList.test_que}</td>
											</tr>
											<tr style="line-height: 23px;">
												<td colspan="4">
											<!-- 여기서 ${testAns[vs.count-1]} : 학생의 답안 -->
												<input type="radio" name="test${testList.que_num}" value="1"
													<c:if test="${testAns[vs.count-1] eq '1' }">checked="checked"</c:if>
													<c:if test="${testAns[vs.count-1] ne '1'}">disabled="disabled"</c:if>
												>&nbsp; ${testList.que_ex1} <br>
												
												<input type="radio" name="test${testList.que_num}" value="2" 
													<c:if test="${testAns[vs.count-1] eq '2' }">checked="checked"</c:if>
													<c:if test="${testAns[vs.count-1] ne '2'}">disabled="disabled"</c:if>
												>&nbsp; ${testList.que_ex2} <br>
												
												<input type="radio" name="test${testList.que_num}" value="3" 
													<c:if test="${testAns[vs.count-1] eq '3' }">checked="checked"</c:if>
													<c:if test="${testAns[vs.count-1] ne '3'}"> disabled="disabled"</c:if>
												>&nbsp; ${testList.que_ex3} <br>
												
												<input type="radio" name="test${testList.que_num}" value="4" 
													<c:if test="${testAns[vs.count-1] eq '4' }">checked="checked"</c:if>
													<c:if test="${testAns[vs.count-1] ne '4'}">disabled="disabled"</c:if>
												>&nbsp; ${testList.que_ex4}
												
												<br>
												<span class="font_red" style="font-size: 7px;">
													<c:if test="${testAns[vs.count-1] ne testList.que_ans}">정답 : ${testList.que_ans}번</c:if>
												</span>
												</td>
											</tr> 
									
									<%-- </c:if> --%>
								</c:forEach>
							</tbody>
						</table>
					</div>
							