<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
							<tbody id="listComnGrpCod">
							<c:if test="${totalCntComnGrpCod eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
							<c:forEach items="${TestList}" var="list">
								<tr>
									<td>${list.lec_name}</td>
									<%-- <td>${list.lec_id}</td> --%>
									<td>${list.test_name}</td>
									<td>${list.test_start}<br> ~ <br>${list.test_end}</td>
									<td>${list.tutor_name}</td>
									
									<!-- 시험 결과 표시 부분 -->
									<td>
										<c:choose>
											<c:when test="${list.pass eq 'A'}">합격</c:when>
											<c:when test="${list.pass eq 'B'}">재시험</c:when>
											<c:when test="${list.pass eq 'C'}">불합격</c:when>
											<c:otherwise>미응시</c:otherwise>
										</c:choose>
									</td>
									
									<!-- 미응시일경우 check위한 현재시간 date -->
									<jsp:useBean id="today" class="java.util.Date"/>
									<fmt:formatDate value="${today}" pattern="yyyy.MM.dd" var="nowDate"/>
									
									<!-- 시험 미응시인 경우 응시 버튼 생성 -->
									<td>
										<c:if test="${list.pass ne 'A' && list.pass ne 'B' && list.pass ne 'C' && list.test_end > nowDate}">
											<a href="javascript:applyTest(${list.test_id});">
												<span><strong>시험응시</strong></span>
											</a>
										</c:if>
										
										<c:if test="${list.pass eq 'A' || list.pass eq 'B' || list.pass eq 'C'}">
											<a href="javascript:checkResult(${list.test_id},${list.lec_id});">
												<span><strong>결과확인</strong></span>
											</a>
										</c:if>
										
										<c:if test="${list.pass ne 'A' && list.pass ne 'B' && list.pass ne 'C' && list.test_end < nowDate}">
												<span></span>
										</c:if>
										
									</td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
							