<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

      <dl>
            <dt class="dttitle">
            <strong class="testt">출석부 상세 보기</strong>
            </dt>
            <div style="width:800px; overflow:auto;">
            <dd class="content" >
               <table class="row" id="adv_info">
                  <caption>caption</caption>
                 <%--  <colgroup>
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                     <col width="80px">
                  </colgroup> --%>
                  <tbody>
                        <tr>
                           <th scope="row" style="width: 20px !important;"></th>
                            <c:forEach var="atd_Date" items="${atd_Date_List}" >
                             <th scope="row">${atd_Date.len_date}</th>
                         </c:forEach>
                     </tr>
               <c:forEach var="atd_list" items="${atd_std_List}" >   
                 <tr>                   
                        <c:forEach var="atd" items="${atd_list}" varStatus="i">
                        <c:if test="${atd != i.first}">
                        <td style="background-color:#F3F3F3;color:black;text-align:center;">${atd}</td>
                        </c:if>
                        <c:if test="${atd == i.first}">
                        <td style="color:black;text-align:center;">${atd=="1"?"출석":atd=="2"?"지각":atd=="3"?"조퇴":atd=="4"?"결석":atd}</td>
                        </c:if>
                        </c:forEach>
                     </tr>
                     </c:forEach>
                     
                  </tbody>
               </table>
            <!-- <div class="btn_areaC mt30">
               <a href="javascript:popupclose()" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
            </div> -->
            </dd>
            </div>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>