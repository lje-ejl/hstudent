<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">

<!-- 과제를 수정하는 모달 -->

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style type="text/css">
	</style>

	<script>
		function updateProject(){
			var frm = document.getElementById("myForm");
			frm.enctype = 'multipart/form-data';
			var fileData = new FormData(frm);
			var resultCallback = function(param) {
				makeProjectCallback(param);
			};
			callAjaxFileUploadSetFormData("/tut/updateProject.do", "post", "json", true, fileData, resultCallback);
		}
		
		function updateProjectCallback(param){
			alert("수정 완료");
			location.href="/tut/projectControl.do";
		}
		
		function updateSubmit(){
			$("#myForm").submit();
		}
	</script>
</head>


<body>
	<div>
    <form id="myForm" action="javascript:updateProject();">
    	<div id="layer2" class="layerType2" style="width: 600px; margin-top: -200px">
			<dl>
				<dt>
	    			<strong>과제 수정</strong>
	    		</dt>
    			<dd class="content">
		    		<table class="row">
						<caption>caption</caption>
							<colgroup>
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
							</colgroup>
							<p align="center">※<strong style="color:red">제출일</strong>과 <strong style="color:red">마감일</strong>을 반드시 입력하세요※</p><br>
						<tbody>
							<tr>
								<th scope="row">제목</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="hwk_name" id="hwk_name" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="hwk_con" id="hwk_con" /></td>
							</tr>
							<tr>
								<th scope="row">제출일</th>
								<td colspan="3"><input type="date" class="inputTxt p100" name="start" id="start" /></td>
							</tr>
							<tr>
								<th scope="row">마감일</th>
								<td colspan="3"><input type="date" class="inputTxt p100" name="dead" id="dead" /></td>
							</tr>
							<tr>
								<th scope="row">파일</th>
								<td colspan="3"><input type="file" class="inputTxt p100" name="hwk_url" id="hwk_url" /></td>
							</tr>			
						</tbody>
					</table>
	        
			        <br>    
					<p style="text-align:center;">
						<a href="javascript:updateSubmit();" class="btnType blue"><span>수정하기</span></a>
			        	<input type="hidden" name="hwk_id" value="${abc}">
			        	<input type="hidden" name="lec_id" value="${abcd}">
			        </p>
     			</dd>
	
			</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
	</div>
</body>
</html>