<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

							<c:if test="${totalCount eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<tbody id="surveyQue">
							<c:if test="${totalCount > 0 }">
						<%-- 	<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> --%>
							<c:forEach items="${surveyList}" var="svy" >
									<tr id="svylistdata">
										<th scope="row">Q${svy.que_num}. ${svy.que}</th>
										<td colspan="6">
											<!-- 문제 보기 영역 for하나더...-->
												<input type="radio" name="answer${svy.que_num}" id="answer" value="1">
													${svy.que_one}
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="2">
													${svy.que_two}
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="3">
													${svy.que_three}
											<c:if test="${svy.que_four ne null}">
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="4">
													${svy.que_four} </c:if>
											<c:if test="${svy.que_five ne null}">	
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="5">
													${svy.que_five}</c:if>
										</td>  
									</tr>
								<%-- <c:set var="nRow" value="${nRow + 1}" /> --%>
								</c:forEach>
							</c:if>
							</tbody>
							<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}"/>
							<!-- lec_id insert할 때 값 필요 -->
							<input type="hidden" id="lec_id2" name="lec_id" value="${registermodel.lec_id}"/>
