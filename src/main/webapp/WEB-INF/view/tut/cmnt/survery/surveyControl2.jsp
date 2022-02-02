<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<caption>caption</caption>
<colgroup>
	<col width="100%">
</colgroup>
<thead>
</thead>

<c:forEach var="review" items="${survey10}" >
	<tr>
		<td scope="col" width="1000" class="rev">${review.lec_rv}</td>
	</tr>
</c:forEach>


<input type="hidden" id="survery10_Total" value="${survery10_Total}">