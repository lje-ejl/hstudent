<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 작성자 김창규 : 강사가 진도를 관리하는 페이지 -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>진도 관리</title>
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
	</script>
</head>




<!-------------------------------------------------------------------------------------------------------------->
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
							<a href="" class="btn_set home">메인으로</a>
							<a href="" class="btn_nav">학습 관리</a>
							<span class="btn_nav bold">진도 관리</span>
							<a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
						</p>
 <!-- 강사가 진행하는 과제를 불러와서 셀렉트박스만들기 -->              
                <ul>
                	<li>
						<form action="selectedLedtureInfo.do" name="lecture_List" id="lecture_List">
							<p class="conTitle"><span>수업 목록</span>
								<span class="fr">
                              	<select id="lectureList" name="lec_id">
                                	<option value="">수업 선택</option>
                                <c:forEach var="n" items="${lectureList}">
                                    <option value="${n.lec_id}">${n.lec_name}</option>
                                </c:forEach>
                              	</select>
                           			<a class="btnType blue" name="btn" id="btn"><span id="searchEnter" class="searchBtn">검색</span></a>
                              		<a href="javascript:history.back();" class="btnType blue" name="btn" id="btn"><span id="searchEnter">뒤로가기</span></a>
								</span>
							</p>
						</form>
							      <br>
						<div class="col">
                        	<p class="tit">
                            	<em>수업 정보</em>
                            </p>
                              
                            <table class="col2 mb10" >
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
        <!-- 셀렉트박스 클릭하면 강의정보 불러오기 -->                         
                                <tbody id="lectureInfo">
                                	<c:forEach var="a" items="${aaa}">
                                    	<tr>
                                        	<td>${a.lec_name}</td>
                                          	<td>${a.tutor_name}</td>
                                          	<td>${a.c_st}</td>
                                          	<td>${a.c_end}</td>
                                          	<td>${a.lecrm_name}</td>
                                          	<td>${a.pre_pnum}</td>
                                          	<td>${a.max_pnum}</td>
                                       	</tr>
                                 	</c:forEach>
                              	</tbody>
                      		</table>
                  		</div>
                           <br>
                        <div class="">
                        	<p class="tit">
                            	<em>주차별 계획</em>
                        	</p>
                           	<table class="col2 mb10" >
                            	<colgroup>
                                	<col width="10%">
                                    <col width="40%">
                                    <col width="50%">
                                </colgroup>

                                <thead>
                                	<tr>
                                    	<th>주차</th>
                                        <th>내용</th>
                                        <th>목표</th>
                                    </tr>
                                </thead>
                                 
                                <tbody>
                                	<c:forEach var="b" items="${bbb}">
                                    <tr>
                                    	<td>${b.week}</td>
                                        <td>${b.learn_con}</td>
                                        <td>${b.learn_goal}</td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                          	</table>
        <!-- 셀렉트박스 클릭하면 진도 정보 불러오기 -->       
        <br>             
                           	<p class="tit">
                           		<em>진도 현황</em>
                            </p>
                            <table class="col2 mb10" >
                            	<colgroup>
                                	<col width="33%">
                                    <col width="33%">
                                    <col width="34%">
                                </colgroup>

                                <thead>
                                	<tr>
                                    	<th>총 수업 수</th>
                                        <th>현 수업 수</th>
                                        <th>진행률</th>
                                    </tr>
                                 </thead>
                                 
                                 <tbody>
                                       <c:forEach var="c" items="${ccc}">
                                    <tr>
                                    	<td>${c.process_day}일</td>
                                        <td>${c.pre_day}일</td>
                                        <td style="color:red;"><strong>${Math.round(c.p_count)}%</strong></td>
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