<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalCntComnGrpCod">${totalCntComnGrpCod}</span>
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
							
							<tbody id="testExam">
							<%-- <c:if test="${testList eq null }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if> --%>
							<%-- <c:set var="testList"  value="${testList}"/> --%>
							
							<tr>
								<th scope="row">시험명</th>
								<td colspan="3">${testList[0].test_name}</td>
							</tr>
							<tr>
								<th scope="row">강의이름</th>
								<td>${testList[0].lec_name}</td>
								<th scope="row">강사명</th>
								<td>${testList[0].tutor_name}</td>
							</tr>
							<tr>
								<th colspan="4">시험문제</th>
							</tr>
							<input type="hidden" value="${testList[0].test_id}" name="test_id">
							<input type="hidden" value="${testList[0].lec_id}" name="lec_id">
							
						<%-- 	<c:set var="j" value="${fn:length(testList)}" /> --%>
							
							<c:forEach items="${testList}" var="testList" varStatus="vs">
							
							
							<!-- 문제 for문 돌릴영역 -->
								<tr>
									<td colspan="4" id="test_que">
									<span>${vs.count}번. </span>${testList.test_que}
									</td>
								</tr>
								
								<tr style="line-height: 23px;">
									<td colspan="4">
									<!-- 문제 보기 영역 -->
										<%-- <c:set var="i" begin="1" end="${j}" /> --%>
										
											<input type="radio" name="test${testList.que_num}" value="1">
											${testList.que_ex1} <br>
											<input type="radio" name="test${testList.que_num}" value="2">
											${testList.que_ex2} <br>
											<input type="radio" name="test${testList.que_num}" value="3">
											${testList.que_ex3} <br>
											<input type="radio" name="test${testList.que_num}" value="4">
											${testList.que_ex4} <br>
								   	
									</td>   
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
							