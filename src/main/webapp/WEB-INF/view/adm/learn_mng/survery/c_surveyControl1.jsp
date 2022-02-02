<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:forEach var="tutor" items="${tutor_List}" >
	<tr>
		<td><a href="javascript:tut_Lec_List('${tutor.loginId}')"><strong>${tutor.loginId}</strong></a></td>
		<td>${tutor.name}</td>
		<td>${tutor.tel}</td>
		<td>${tutor.mail}</td>
		<td>${tutor.join_date}</td>
	</tr>
</c:forEach>

<input type="hidden" id="tut_Total" value="${tut_Total}">