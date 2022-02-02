<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강생 정보</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style>
.searchBtn{
	cursor: pointer;
}
</style>
<script type="text/javascript">
	window.onload = function(){
		$("#btn").click(function(){
			 lec_id= $("#lectureList").val();
			 if(lec_id ==""){
				 
			 }else{
				 $("#lecture_List").submit();
			 }
		});
	}
	
	function approveUpdate1( data1, data2 ) {
		var data = {
				"loginID" :data1,
				"lec_id" :data2
		};
		
		$.ajax({
			url : "approveUpdate1.do",
			type : "POST",
			data : data,
			
			success : function(data) {
				alert("성공");
				location.href="lectureStudentInfo.do";
			},
			error : function() {
				alert("실패");
			}
		});
	}
	
	function approveUpdate2( data1, data2 ) {
		var data = {
				"loginID" :data1,
				"lec_id" :data2
		};
		
		$.ajax({
			url : "approveUpdate2.do",
			type : "POST",
			data : data,
			
			success : function(data) {
				alert("성공");
				location.href="lectureStudentInfo.do";
			},
			error : function() {
				alert("실패");
			}
		});
	}
	
	function setApv(lec_id){
		var data = {
			"lec_id" : lec_id
		};
		$.ajax({
			url : "setApv.do",
			type : "POST",
			data : data,
		});
	}
	
</script>
</head>



<body>
	<div id="mask"></div>
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2>
    	<h2 class="hidden">컨텐츠 영역</h2>
      		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
      
      	<div id="container">
      		<ul>
            	<li class="lnb">
      				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
            	</li>

            	<li class="contents">
            		<h3 class="hidden">contents 영역</h3>
            		<div class="dashboard2 mb20">
            
           				<div class="content">
            				<p class="Location">
								<a href="#" class="btn_set home">메인으로</a>
								<a href="#" class="btn_nav">학습 관리</a>
								<span class="btn_nav bold">수강생 정보</span>
								<a href="" class="btn_set refresh">새로고침</a>
							</p>
                     		<ul>
                        		<li>
<!-- 강사의 수업목록 셀렉트박스에 불러오기 -->                        		
								<form action="selectedLectureInfo.do" name="lecture_List" id="lecture_List" >
									<p class="conTitle"><span>수업 정보</span>
										<span class="fr">
	                              			<select id="lectureList" name="lec_id">
	                                 			<option value="">수업 선택</option>
		                              		<c:forEach var="list" items="${lectureList}">
		                                 		<option value="${list.lec_id}">${list.lec_name}</option>
		                              		</c:forEach>
	                              			</select>
	                                		<a class="btnType blue" name="btn" id="btn"><span id="searchEnter" class="searchBtn">검색</span></a>
	                                		<a href="javascript:history.back();" class="btnType blue" name="btn" id="btn"><span id="searchEnter">뒤로가기</span></a>   
								 		</span>
									</p>
	                      			</form>
	                           
<!-------강의정보 불러오기--------->      
							<div class="col">
								<table class="col2 mb10">
                                	<colgroup>
                                    	<col width="25%">
                                    	<col width="20%">
                                    	<col width="10%">
                                    	<col width="10%">
                                    	<col width="15%">
                                    	<col width="10%">
                                    	<col width="10%">
                                 	</colgroup>

                                 	<thead>
                                    	<tr>
                                       		<th>강의명</th>
                                       		<th>강사명</th>
                                       		<th>개강일</th>
                                       		<th>종강일</th>
                                       		<th>강의실</th>
                                       		<th>현재인원</th>
                                       		<th>정원</th>
                                    	</tr>
                                 	</thead>
                                 
                                 	<tbody>
                                    	<c:forEach var="n" items="${lectureInfo}">
                                        	<tr>
                                          		<td>${n.lec_name}</td>
                                          		<td>${n.tutor_name}</td>
                                          		<td>${n.c_st}</td>
                                          		<td>${n.c_end}</td>
                                          		<td>${n.lecrm_name}</td>
                                          		<td>${n.pre_pnum}</td>
                                          		<td>${n.max_pnum}</td>
                                          	</tr>
                                          	
<!-- 강의날짜랑 오늘날짜 비교해서 강의끝났으면 수강생 apv 'N'으로 세팅하기 -->
					                        <jsp:useBean id="today" class="java.util.Date"/>
					                        <fmt:formatDate value="${today}" pattern="yyyy.MM.dd" var="nowDate"/>
					                        <c:if test="${nowDate > n.c_end}">
					                        	<script>setApv('${n.lec_id}');</script>
					                        </c:if>
                                       
                                       </c:forEach>
                                	</tbody>
                              </table>
                           </div>
<!-------학생목록 불러오기--------->             
        					<div class="">
        						<p class="conTitle" style="margin-top:50px"><span>수강생 명단</span></p>
                              		<table class="col2 mb10">
                                 		<colgroup>
                                    		<col width="25%">
                                    		<col width="20%">
                                    		<col width="15%">
                                    		<col width="15%">
                                    		<col width="5%">
                                    		<col width="5%">
                                    		<col width="8%">
                                    		<col width="7%">
                                 		</colgroup>

                                 		<thead>
                                    	<tr>
                                       		<th>이름</th>
                                       		<th>학번</th>
                                       		<th>연락처</th>
                                       		<th>생년월일</th>
                                       		<th>설문</th>
                                       		<th>점수</th>
                                       		<th>승인여부</th>
                                       		<th>승인/취소</th>
                                    	</tr>
                                 </thead>
                                 
                                 <tbody>
                                       <c:forEach var="a" items="${studentsInfo}">
                                          <tr>
                                          	<td>${a.name}</td>
                                          	<td>${a.std_num}</td>
                                          	<td>${a.tel}</td>
                                          	<td>${a.birth}</td>
                                          	<td>${a.srvy_chk}</td>
                                          	<td>${a.test_sco}</td>
                                          	<td>${a.apv}</td>
<!-- 수강신청이 끝나면 버튼이 안보인다 -->             
             <!--  학생승인여부가 N일때 승인버튼 띄우기-->
                                          	<td>
                                            	<c:if test="${a.apv eq 'N'}">
                                          	    	<a href="javascript:approveUpdate1('${a.loginID}', '${a.lec_id}');" class="btnType blue"><span>승인</span></a>
                                            	</c:if>
             <!--  학생승인여부가 y일때 취소버튼 띄우기-->
                                            	<c:if test="${a.apv eq 'Y'}">
                                          	    	<a href="javascript:approveUpdate2('${a.loginID}', '${a.lec_id}');" class="btnType blue"><span>취소</span></a>
                                            	</c:if>
                                          	</td>
                                          </tr>
                                       </c:forEach>
                                 </tbody>
                                 
                              </table>
                           </div>
                        </li>
                     </ul>
                  </div>
               </div>
            </li>
         </ul>
      </div>
   </div>
</body>
</html>