<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<c:if test="${totalCnt_adv eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCnt_adv > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${list_advice}" var="list">
		<tr>
			<td>${list.adv_id }</td>
			<td>${list.lec_name }</td>
			<td><strong><a href="javascript:fPopModal_adv('${list.adv_id}',${list.lec_id})">${list.std_name} (${list.std_id})</a></strong></td>
		<td>${list.adv_date}</td> <td>${list.tut_name} (${list.tut_id})</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt_adv" name="totalCnt_adv"
	value="${totalCnt_adv}" />