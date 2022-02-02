<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="list" items="${Lec_list}" >
	<tr>
		<td>${list.lec_id}</td>
		<td><a href="javascript:std_List(${list.lec_id})">${list.lec_name}</a></td>
		<td>${list.tutor_name}</td>
		<td>${list.pre_pnum}</td>
		<td>${list.c_st} ~ ${list.c_end}</td>
	</tr>
</c:forEach>

<input type="hidden" id="lec_Total" value="${lec_Total}">
