<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<c:if test="${totalCnt_lec eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCnt > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${list_lec}" var="list">
		<tr>
	<td>${list.lec_sort}</td>
	<td><strong><a href="javascript:fPopModal('${list.lec_id}')">${list.lec_name}</a></strong></td>
			<td>${list.c_st}~${list.c_end}</td>
	<td>${list.pre_pnum } / ${list.max_pnum } </td>	
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt" name="totalCnt"
	value="${totalCnt}" />