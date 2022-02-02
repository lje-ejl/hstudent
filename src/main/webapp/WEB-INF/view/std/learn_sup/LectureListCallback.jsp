<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        
<div class="divEmpty">
   <div class="hiddenData">
      <span id="totalCntLec">${totalCntLec}</span>
   </div>
   <table class="col">
                          
      <tbody id="listLecture">
      <c:if test="${totalCntLec eq 0 }">
         <tr>
            <td colspan="9">데이터가 존재하지 않습니다.</td>
         </tr>
      </c:if>
      
      <c:set var="nRow" value="${pageSize*(currentPageLec-1)}" />
         <c:forEach var="list" items="${listLec}">
            <tr>
            	<td>
            	<a href="javascript:fPopModalLec(${list.lec_id});">
            	<strong>${list.lec_name}</strong></a>
            	
            	</td>
            	<td>${list.lec_sort}</td>
            	<td>${list.name}</td>
            	<td>${list.c_st}</td>
            	<td>${list.c_end}</td>
            	<td>${list.pre_pnum}</td>
            	<td>${list.max_pnum}</td>
            	
            </tr>
         <c:set var="nRow" value="${nRow + 1}" />
      </c:forEach> 
         
      </tbody>
   </table>

</div>




