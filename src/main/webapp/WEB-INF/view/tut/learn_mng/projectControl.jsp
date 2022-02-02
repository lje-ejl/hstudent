<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">

<!-- 김창규 작성      강사,과제관리페이지 -->

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>과제 관리</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style type="text/css">
		.searchBtn{
			cursor: pointer;
		}
	</style>
	
	<script type="text/javascript">
		
		function sending_hwk_id(data1) {
			var param = {
				"hwk_id" : data1
			};
		    var resultCallback = function(param) {
		    	$('#layer1').empty().append(param);
		        gfModalPop("#layer1");
		    };
		   	callAjax("/tut/submitInfo.do", "post", "text", true, param, resultCallback);
		}
		
		function sending_hwk_id2(data1){
			var param = {
				"hwk_id" : data1
			};
			var resultCallback = function(param) {
			    $('#layer1').empty().append(param);
			    gfModalPop("#layer1");
			};
			callAjax("/tut/projectInfo2.do", "post", "text", true, param, resultCallback);
		}

		function makeProject(){
			//12.03
			var frm = document.getElementById("myForm2");
			frm.enctype = 'multipart/form-data';
			var fileData = new FormData(frm);
			
			var resultCallback = function(param) {
				makeProjectCallback(param);
			};
			callAjaxFileUploadSetFormData("/tut/makeProject.do", "post", "json", true, fileData, resultCallback);
		}
		
		function makeProjectCallback(param){
			alert("등록 완료 되었습니다");
			location.href="/tut/projectControl.do";
		}
		
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
								<span class="btn_nav bold">과제 관리</span>
								<a href="projectControl.do" class="btn_set refresh">새로고침</a>
							</p>
					<ul>
                        <li>
	<!--강사가 강의하는 수업목록 셀렉트박스-->
							<form action="selectedLectureInfo2.do" name="lecture_List" id="lecture_List">
								<p class="conTitle"><span>수업 목록</span>
	                            	<span class="fr">
	                              		<select id="lectureList" name="lec_id">
	                                		<option value="" id="all" selected="selected">수업 선택</option>
	                                	<c:forEach var="n" items="${lectureList}">
	                                    	<option value="${n.lec_id}">${n.lec_name}</option>
	                                 	</c:forEach>
	                              		</select>
	                              		<a class="btnType blue" name="btn" id="btn"><span id="searchEnter" class="searchBtn">검색</span></a>
	                        			<c:if test = "${not empty lectureInfo}">
	                              			<a href="javascript:gfModalPop('#layer1');" class="btnType blue" name="btn" id="btn"><span id="">과제 올리기</span></a>
	                        			</c:if>
									</span>
								</p>
							</form>
	<!-- 강의번호가 있어야 과제올리기 버튼이 보인다 -->	
						
							 
							<div class="col">
								<br>
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
 <!-- 선택한 강의정보를 불러온다 -->                                
                                 <tbody id="lectureInfo">
                                       <c:forEach var="a" items="${lectureInfo}">
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
                           
                           <div class="">
                           		<br>
                               <p class="tit">
                                   <em>과제 관리</em>
                               </p>
                           
								<table class="col2 mb10" >
                                	<colgroup>
                                    	<col width="10%">
                                    	<col width="60%">
                                    	<col width="10%">
                                    	<col width="10%">
                                    	<col width="10%">
                                 	</colgroup>
	
	<!--select box 클릭하면 해당 강의 과제 목록 불러오기-->
                                 <thead>
                                    <tr>
                                       <th>과제 번호</th>
                                       <th>과제 이름</th>
                                       <th>제출일</th>
                                       <th>마감일</th>
                                       <th>제출 현황</th>
                                    </tr>
                                 </thead>
                                 
                                <tbody>
                                  <c:forEach var="b" items="${bbbb}">
                                    <tr>
                                    	<td>${b.hwk_id}</td>
         <!--과제 제목 클릭하면 해당과제 상세정보, 수정과 삭제 가능-->   
         								<td><a href="javascript:sending_hwk_id2('${b.hwk_id}');"><strong>${b.hwk_name}</strong></a></td>
                                        <td>${b.start}</td>
                                        <td>${b.dead}</td>
                                      	<td>
         <!--제출현황 클릭하면 hwk_id전송해서 제출한 학생 명단 불러오기-->
								       		<a href="javascript:sending_hwk_id('${b.hwk_id}');"><span><strong>자세히 보기</strong></span></a>       
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
 
 

 <!-- 과제만들기 버튼 누르면 생성되는 모달 -->
 	<form id="myForm2" action="javascript:makeProject();">
  		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>과제 등록하기</strong>
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
								<th scope="row">과제명</th>
								<td><input type="text" class="inputTxt p100" name="hwk_name" id="hwk_name" /></td>
							</tr>
							<tr>
								<th scope="row">과제 내용</th>
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
								<th scope="row">파일업로드</th>
								<td>
									<input type="file" id="bbs_files_1" name="bbs_files_1" class="upload-hidden">
								</td>
							</tr>
						</tbody>
					</table>
				
				<!-- cccc : lec_id  // 저장버튼 누르면 form의 action으로 이동 // makeProject -->
				<div class="btn_areaC mt30">
					<input type="hidden" value="${cccc}" name="cccc" id="cccc">
					<a href="javascript:makeProject();" class="btnType blue"><span>저장</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
  </form>	
</body>
</html>