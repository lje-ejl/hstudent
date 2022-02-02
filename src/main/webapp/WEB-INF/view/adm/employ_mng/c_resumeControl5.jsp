<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<dl>
            <dt>
               <strong>이력서를 전송 할 기업을 선택해주세요</strong>
            </dt>
            
            <dd class="content">
               <table class="row" id="adv_info">
                  <caption>caption</caption>
                  <colgroup>
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                  </colgroup>

                  <tbody>
		                  <tr>
		                  	<th scope="col"><input type="checkbox" id="checkall_C" name="checkall_C" checked onclick="javascript:check_All()"/></th>
		                  	<th scope="row">회 사 이 름</th>
		                  	<th scope="row">회 사 번 호 </th>
		                  	<th scope="row">회 사 메 일</th>
		                  	<th scope="row">아이디</th>
		                  	<th scope="row">전화 번호</th>
		                  </tr>
                  	<c:forEach var="list" items="${rpstt_List}" >
	                     <tr>
	                     	<th>
								<c:if test="${list.mail ne 'X'}">
									<input type="checkbox" id="check${list.mail}" name="check_C" value="${list.mail},${list.comp_name}" checked/>
								</c:if>
								<c:if test="${list.mail eq 'X'}">
									<input type="checkbox" checked disabled/>
								</c:if>	                     	
	                     	</th>
	                        <td>${list.comp_name}</td>
	                        <td>${list.comp_tel}</td>
	                        <td>${list.mail}</td>
	                        <td>${list.loginId}</td>
	                        <td>${list.tel}</td>                                                                        
	                     </tr>                  
                     </c:forEach>
                  </tbody>
               </table>

				<div class="btn_areaC mt30">
					<a href="javascript:email_send_check()" class="btnType gray" id="btnClose" name="btn"><span>전송</span></a>
					<a href="javascript:popupclose()" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
               
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>