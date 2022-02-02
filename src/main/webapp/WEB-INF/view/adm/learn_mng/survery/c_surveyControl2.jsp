<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="list" items="${lec_List}" >
	<tr>
		<td>
			<c:if test="${list.srvy_Pnum==null}">${list.lec_name}</c:if>
			<c:if test="${list.srvy_Pnum>=1}" ><a href="javascript:c_surveryDetail_1('${list.lec_id}')"><strong>${list.lec_name}</strong></a></c:if>
		</td>
		<td>${list.tutor_name}</td>
		<td>${list.c_st}</td>
		<td>${list.c_end}</td>
		<td>${list.srvy_Pnum}/${list.pre_pnum}</td>
	</tr>
</c:forEach>

<input type="hidden" id="lec_Total" value="${lec_Total}">