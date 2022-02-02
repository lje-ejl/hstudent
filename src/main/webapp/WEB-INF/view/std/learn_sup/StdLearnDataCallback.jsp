<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        
<div class="divEmpty">
   <div class="hiddenData">
      <span id="dataCount">${dataCount}</span>
   </div>
   <table class="col">
                          
      <tbody id="learnData">
      <c:if test="${dataCount eq 0 }">
         <tr>
            <td colspan="9">데이터가 존재하지 않습니다.</td>
         </tr>
      </c:if>
      
      <c:set var="nRow" value="${pageSize*(currentPage-1)}" />
         <c:forEach var="list" items="${dataList}">
            <tr>
            	<td>${list.learn_data_id}</td>
            	<td>
            	<a href="javascript:fPopModalLearn(${list.learn_data_id})">
            	<strong>${list.learn_tit}</strong></a>
            	</td>
            	<td>${list.w_date}</td>
            </tr>
         <c:set var="nRow" value="${nRow + 1}" />
      </c:forEach> 
         
      </tbody>
   </table>

</div>




