<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="list" items="${Std_list}" >
		<tr>
			<td>
				<c:if test="${list.rs_check eq 'o'}">
					<input type="checkbox" id="check${list.rownum}" name="check_E" value="${list.loginId}" checked/>
				</c:if>
				<c:if test="${list.rs_check eq 'x'}">
					<input type="checkbox" id="check${list.rownum}" name="" value="" checked disabled/>
				</c:if>
				
				<input type="hidden"   id="name${list.rownum}"     value="${list.name}">
				<input type="hidden"   id="stuid${list.rownum}"    value="${list.loginId}">
				<input type="hidden"   id="rs_fname${list.rownum}" value="${list.rs_fname}">
				<input type="hidden"   id="rs_url${list.rownum}"   value="${list.rs_url}">
				<input type="hidden"   id="rs_fsize${list.rownum}" value="${list.rs_fsize}">
			</td>
			<td>${list.name}</td>
			<td><a href="javascript:std_Detail('${list.loginId}')"><strong>${list.loginId}</strong></a></td>
			<td>${list.tel}</td>
			<td>${list.mail}</td>
			<td>
				<c:if test="${list.wp_state eq 'A'}">
					취업
				</c:if>
				<c:if test="${list.wp_state eq 'B'}">
					미취업
				</c:if>
			</td>
			<td>
				<c:if test="${list.rs_check eq 'o'}">
					<a href="javascript:rs_download('${list.rs_url}')"><strong>다운로드</strong></a>
				</c:if>				
			</td>
		</tr>
</c:forEach>
<input type="hidden" id="Max" value="${Max}">