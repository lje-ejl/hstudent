<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					

						    
						

							<c:if test="${totalCount eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCount > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
								<c:forEach items="${selHwkList}" var="list" >
									<tr id = "hwklistdata" >
										<td>${nRow + 1}</td>
										<td>${list.lec_name}</td>
										<c:if test="${list.hwk_id eq list.hwk_id_sub}">
											<td onClick="fshowSubModal('${list.hwk_id}')" class="cursor"><strong style="color:black;">${list.hwk_name} (제출완료)</strong></td>
										</c:if>
										<c:if test="${list.hwk_id ne list.hwk_id_sub}">
											<td onClick="fshowSubModal('${list.hwk_id}')" class="cursor"><strong style="color:black;">${list.hwk_name}</strong></td>
										</c:if>
										<td>${list.tutor_name}</td>
										<td>${list.start} ~ ${list.dead}</td> 
										<td>
											<c:if test="${not empty list.hwk_url}">
												<%-- <input type="button" value="다운로드" onclick="ffiledownload('${list.hwk_url}','${list.hwk_id}');" /> --%>
                        			 			<a href="javascript:ffiledownload('${list.hwk_url}','${list.hwk_id}','${list.hwk_fname}');" class="btnType blue" name="btn"><span>다운로드</span></a> 
                        			 		</c:if>
                       			 		</td>
									</tr>
								<c:set var="nRow" value="${nRow + 1}" />
								
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}"/>
