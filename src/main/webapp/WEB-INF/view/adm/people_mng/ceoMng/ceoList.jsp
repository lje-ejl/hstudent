<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>




<c:if test="${totalCnt eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCnt > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${list_ceo}" var="list">
		<tr>	
			<td>${list.comp_name }</td>
			<td><strong><a href="javascript:fceo_info('${list.loginID}')">${list.name} (${list.loginID })</a></strong></td>
			<td>${list.tel}</td>
			<td>${list.mail}</td>
			<td>${list.join_date}</td>
			<td><a class="btnType3 color1" href="javascript:ban_user('${list.loginID}')"><span>탈퇴</span></a>
			</td>
	
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt" name="totalCnt"
	value="${totalCnt}" />