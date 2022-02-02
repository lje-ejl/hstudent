<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 학습자료 상세페이지 조회  -->

<dl>
	<dt>
		<strong>자료 내용</strong>
	</dt>
	<dd class="content">

		<table class="row" id="edit_table" name="edit_table">

			<colgroup>
				<col width="80px">
				<col width="200px">
				<col width="80px">
				<col width="100px">
			</colgroup>

			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td id="data_name">${dataInfo.learn_tit}</td>
					<th scope="row">등록일자</th>
					<td id="regidate" style="text-align: center;">${dataInfo.w_date}</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td id="con" colspan="3">${dataInfo.learn_con}</td>
				</tr>
				<tr>
					<th scope="row">첨부파일</th>
					<td colspan="3"><c:set var="file"
							value="${dataInfo.learn_fname}" /> <c:if test="${!empty file}">
							<a href="javascript:fDataDownload('${dataInfo.learn_url}', '${dataInfo.learn_fname}');"><span
								id=""><strong>${dataInfo.learn_fname}</strong></span></a>
						</c:if></td>
				</tr>
			</tbody>
		</table>

		<div class="btn_areaC mt30">
			<a href="" class="btnType blue" id="closeBtn"><span id="">닫기</span></a>
		</div>
	</dd>
</dl>
<a href="" class="closePop"><span class="hidden">닫기</span></a>