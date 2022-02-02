<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 학생이 제출한 과제 자세히 보기 -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style type="text/css">
	</style>
	
	<script>
		function showStudentSubject(data1, data2 ) {
			var param = {
				"std_id" : data1,
				"hwk_id" : data2
			};
		    var resultCallback = function(param) {
		    	$('#layer1').empty().append(param);
		        gfModalPop("#layer1");
		    };
		   	callAjax("/tut/studentProjectCon.do", "post", "text", true, param, resultCallback);
		}
		
		function downloadHwk(url, fname){
			$.ajax({
				success : function(){
					var params = "";
					params += "<input type='hidden' name='submit_url' value='"+ url +"' />";
					params += "<input type='hidden' name='submit_fname' value='"+ fname +"' />";
					jQuery("<form action='/tut/downloadHwk.do' method='post'>" + params+ "</form>").appendTo('body').submit().remove();
					alert("다운로드 성공");
				}
			});
		}
	</script>
</head>




<body>
<dl>
	<dt>
    	<strong>과제 내용</strong>
    </dt>
    <dd class="content">
    	<table class="col2 mb10" id="adv_info">
        	<caption>caption</caption>
            	<colgroup>
                	<col width="60%">
                	<col width="15%">
                	<col width="14%">
                	<col width="11%">
                </colgroup>
				
			<thead>
				<tr>
					<th>내용</th>
					<th>파일 이름</th>
					<th>파일 받기</th>
					<th>제출일</th>
				</tr>
			</thead>
			
            <tbody>
	                <tr>
	                	<td>${ac.submit_con}</td>
	                	<td>${ac.submit_fname}</td>
	                	<td>
	                		<c:if test="${not empty ac.submit_url}">
	                			<a href="javascript:downloadHwk('${ac.submit_url}', '${ac.submit_fname}');">받기</a>
	                		</c:if>
	                	</td>
	                	<td>${ac.submit_date}</td>
	                </tr> 
           	</tbody>
          </table>
     </dd>
</dl>
<a href="" class="closePop"><span class="hidden">닫기</span></a>
</body>
</html>