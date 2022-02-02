<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                    
                        <dl>
                           <dt>
                           <strong>강의 계획서</strong>
                           </dt>
                           <dd class="content">

                        <table class="row" id="edit_table" style="text-align: center;">
                          
                              <colgroup>
                                 <col width="80px">
                                 <col width="100px">
                                 <col width="80px">
                                 <col width="100px">
                              </colgroup>
            
                           <tbody>
                              <tr>
                                 <th scope="row">과목</th>
                                    <td id="lec_name">${lecInfo.lec_name}</td>
                                 <th scope="row">분류</th>
                                    <td id="lec_sort">${lecInfo.lec_sort}</td>
                              </tr>
                              <tr>
                                 <th scope="row">강사명</th>
                                    <td id="name">${lecInfo.name}</td>
                                 <th scope="row">연락처</th>
                                    <td id="tel">${lecInfo.tel}</td>
                              </tr>
                              <tr>
                                 <th scope="row">이메일</th>
                                    <td id="mail">${lecInfo.mail}</td>
                                 <th scope="row">강의실</th>
                                    <td id="lecrm_name">${lecInfo.lecrm_name}</td>
                              </tr>
                              <tr>
                                 <th scope="row">수업목표</th>
                                 <td id="lec_goal" colspan="3">${lecInfo.lec_goal}</td>
                              </tr>
                              <tr>
                                 <th scope="row">출석</th>
                                 <td id="atd_plan" colspan="3">${lecInfo.atd_plan}</td>
                              </tr>
                              <tr>
                                 <th scope="row">강의계획</th>
                                 
                                 <td colspan="3">
                                 <div style="overflow:auto; height:400px;">

                                 <table class="col2 mb10">
                                 	<colgroup>
		                                 <col width="70px">
		                                 <col width="150px">
                              		</colgroup>
									<thead>
										<tr>
											<th scope="col">주차수</th>
											<th scope="col">학습목표</th>
											<th scope="col">학습내용</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="wp" items="${lecWeekPlan}">
										<tr>
											<td>${wp.week}</td>
											<td>${wp.learn_goal}</td>
								        	<td>${wp.learn_con}</td>
								        </tr>
								    </c:forEach>
									</tbody>
								</table>
								</div>
                              </td>
                           </tr>
                        </tbody>
                     </table>

                     <div class="btn_areaC mt30">
                     <c:set var="lecture" value="${idCheck.lec_id}"/>
                     <c:choose>
                     	<c:when test="${lecture eq lecInfo.lec_id}">
                     		<a href="javascript:fCancelLec(${lecInfo.lec_id})" class="btnType blue" id="cancelBtn"><span id="">신청취소</span></a>
                        </c:when>
                        <c:when test="${!empty lecture}">
                        	
                        </c:when>
                        <c:otherwise>
                        	<a href="javascript:fApplyLec(${lecInfo.lec_id})" class="btnType blue" id="applyBtn"><span id="">신청</span></a>
                        </c:otherwise>
                     </c:choose>
                        <a href="" class="btnType blue" id="closeBtn"><span id="">닫기</span></a>
                     </div>
                  </dd>
               </dl>
               <a href="" class="closePop"><span class="hidden">닫기</span></a>