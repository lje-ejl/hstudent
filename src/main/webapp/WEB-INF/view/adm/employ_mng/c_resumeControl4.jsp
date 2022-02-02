<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<dl>
            <dt>
               <strong>이력서 전송</strong>
            </dt>
            
            <dd class="content">
               <table class="row" id="adv_info">
                  <caption>caption</caption>
                  <colgroup>
                     <col width="120px">
                     <col width="*">
                     <col width="120px">
                     <col width="*">
                  </colgroup>

                  <tbody>
                  	<tr>
                  		<td colspan="1" class="a_pop" id="a_pop"> 강의명  </td>
                  		<td colspan="3" class="b_pop" id="b_pop"> ${lec_name}</td>
                  	</tr>
                  	<tr>
                  		<td colspan="4" class="a_pop" id="a_pop">선택된 학생들의 이력서를</td>
                  	</tr>
                  	<tr>
                  		 <th scope="row">이 름</th>
                  		 <th scope="row">아이디</th>
                  	</tr>
                  	<c:forEach var="list" items="${std_mail}" >
                     <tr>
                        <td>${list.name}</td>
                        <td>${list.loginId}</td>
                     </tr>                  
                     </c:forEach>
                     
                  	<tr>
                  		<td colspan="4" class="a_pop" id="a_pop">선택한 기업들에게 보내시겠습니까?</td>
                  	</tr>
                  	
                  	<tr>
                  		 <th scope="row">기업명</th>
                  		 <th scope="row">기업 이메일</th>
                  	</tr>                  	
                  	<c:forEach var="list" items="${rps_mail}" >
                     <tr>
                        <td>${list.comp_name}</td>
                        <td>${list.mail}</td>
                     </tr>                  
                     </c:forEach>                     
                  </tbody>
               </table>

				<div class="btn_areaC mt30">
					<a href="javascript:email_send()" class="btnType gray" id="btnClose" name="btn"><span>전송</span></a>
					<a href="javascript:popupclose()" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
               
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>

