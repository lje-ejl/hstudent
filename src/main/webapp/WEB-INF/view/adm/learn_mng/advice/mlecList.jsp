<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<option>과정명 선택 </option>
<c:forEach items="${mlist_lec}" var="lec">
<option value="${lec.lec_id}">${lec.lec_name }</option>
</c:forEach>