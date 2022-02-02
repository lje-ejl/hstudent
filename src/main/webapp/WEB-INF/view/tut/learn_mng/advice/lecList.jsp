<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="nowDate" />  

<option value="" id="option1" selected="selected">전체 과정</option>
<c:forEach items="${list_lec}" var="list">
	<option value="${list.lec_id}">${list.lec_name }
	<c:if test="${nowDate < list.c_end }">(진행중)</c:if>
	<c:if test="${list.c_end < nowDate }">(종료)</c:if>
	</option>
</c:forEach>



