<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach items="${lec_stu_list}" var="std">
<option value="${std.std_id}">${std.std_name }</option>
</c:forEach>