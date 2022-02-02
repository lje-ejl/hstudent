<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 강사가 제출한 과제 목록 -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

		<script>
		function updateProject(hwk_id, lec_id){
			var data = {
				"hwk_id" : hwk_id,
				"lec_id" : lec_id
			};
			var resultCallback = function(data) {
			    $('#layer1').empty().append(data);
			    gfModalPop("#layer1");
			};
			callAjax("/tut/newInputModal.do", "post", "text", true, data, resultCallback);
		}
		
		function downloadTutor(url, fname){
			$.ajax({
				success : function(){
					var params = "";
					params += "<input type='hidden' name='hwk_url' value='"+ url +"' />";
					params += "<input type='hidden' name='hwk_fname' value='"+ fname +"' />";
					jQuery("<form action='/tut/downloadTutor.do' method='post'>" + params + "</form>").appendTo('body').submit().remove();
					alert("다운로드 성공");
				}
			});
		}
	</script>
</head>




<body>
<dl>
	<dt>
    	<strong>과제</strong>
    </dt>
    <dd class="content">
    	<table class="col2 mb10" id="adv_info">
        	<caption>caption</caption>
            	<colgroup>
                	<col width="20%">
                	<col width="40%">
                	<col width="10%">
                	<col width="10%">
                	<col width="20%">
                </colgroup>
				
			<thead>
				<tr>
					<th>제목</th>
					<th>내용</th>
					<th>제출일</th>
					<th>마감일</th>
					<th>파일</th>
				</tr>
			</thead>
			
            <tbody>
	                <tr>
	                	<td>${projectInfo.hwk_name}</td>
	                	<td>${projectInfo.hwk_con}</td>
	                	<td>${projectInfo.start}</td>
	                	<td>${projectInfo.dead}</td>
	                	<td>
	                		<c:if test="${not empty projectInfo.hwk_fname}">
	                			<a href="javascript:downloadTutor('${projectInfo.hwk_url}', '${projectInfo.hwk_fname}');">${projectInfo.hwk_fname}</a>
	                		</c:if>
	                	</td>
	                </tr> 
           	</tbody>
          </table>
     
     	<p style="text-align:center;">
     		<a href="javascript:updateProject('${projectInfo.hwk_id}', '${projectInfo.lec_id}');" class="btnType blue" name="btn" id="btn"><span id="">수정</span></a>
     	</p>
     </dd>
</dl>
<a href="" class="closePop"><span class="hidden">닫기</span></a>

</body>
</html>