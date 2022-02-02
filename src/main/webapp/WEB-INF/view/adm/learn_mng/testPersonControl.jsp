<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">
   .cursorArea{
      cursor: pointer;
   }

</style>
<script type="text/javascript">

	//등록된 강의 목록 페이징
	var pageSize = 5;
	var pageBlockSize = 5;
	
	var pageSizeStd = 5;
	var pageBlockSizeStd = 5;
	
	var sa; //서치값_취업정보 목록
	var lec; //강의 목록
	var test; //시험 목록
	var std; //학생 목록

	$(document).ready(function() {
		
		init();
		//학생목록 숨기기
		$('#stdList').hide();
		//  목록 조회 함수
		fListLec();

		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; 
		var yyyy = today.getFullYear();
		today = yyyy+'.'+mm+'.'+dd; //데이트 피커 날짜 포멧으로 바꾼후 today변수에 넣기
		console.log(today); //현재 날짜 확인~!~!
	});
	function init(){
		
		sa = new Vue({
								el:'#searcharea',
								data:{
									 	searchKey: 'all'
										,searchWord : ''
										}
								});
		
		lec = new Vue({
								el:'#div_lec_list',
							data:{
									items:[]
									,lec_id:''
									,test_id:''
									,today :new Date()
							},
							methods:{
								b_std_list:function(lec_id,test_id){
						
									this.lec_id =lec_id;
									this.test_id =test_id; 
									fListStd();
								} 
							}
					}); //lec 끝 
					
		std = new Vue({
				el:'#div_std_list',
				 components: {
					    'bootstrap-table': BootstrapTable
					  },
				data:{
						items:[]
				}			 
		});  
	};//init 끝			 
	//시험 강의 목록
	function fListLec(currentPage){
			currentPage = currentPage || 1;
		
			var param = {
					currentPage : currentPage
				,	pageSize : pageSize
				,   searchKey : sa.searchKey
				,   searchWord : $("#searchWord").val()      
			}
			var resultCallback = function(data){
				fListLecResult(data, currentPage);
			};
			
			callAjax("/adm/testListLec.do","post","json", true, param, resultCallback);
		}
		
	//시험 강의 목록 콜백
	function fListLecResult(data, currentPage){
			lec.items = [];
			lec.items = data.list_lec;
			std.items=[]; 
			
			var totalCount = data.totalCount;
			var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlockSize, 'fListLec');
			console.log("paginationHtml : " + paginationHtml);
			$("#LecPagination").empty().append(paginationHtml);
			 $("#currentPageCourse").val(currentPage);  
	};
	
	function fListStd(currentPage){
		currentPage = currentPage || 1;
		
		var param = {
				currentPage : currentPage
				,pageSize : pageSizeStd
				,lec_id : lec.lec_id
				,test_id: lec.test_id
		};
		var resultCallback = function(data){
			fListStdResult(data,currentPage)
		};
		
		callAjax("/adm/stdTest.do", "post", "json", true, param, resultCallback);
		};

		/** 학생 조회 콜백 함수 */
		function fListStdResult(data, currentPage) {
			
		std.items=[];
		std.items=data.std_test;
		
		$('#stdList').show();
	
		var totalCount = data.totalCount;
		var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSizeStd, pageBlockSizeStd, 'fListStd');
		
		console.log("paginationHtml : " + paginationHtml);
		$("#studentPagination").empty().append( paginationHtml );
		}	
</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentPageCourse" id="currentPageCourse" value="">
	<input type="hidden" name="delCourseno" id="delCourseno" value="">
 	<input type="hidden" name="Coursestudent" id="Coursestudent" value="">

	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">
	
	<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 -->
					 <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">학습 관리</a> <span class="btn_nav bold">시험 대상자 관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
					
						<p class="conTitle" id="searcharea">
							<span>시험 목록</span> 
							 <span class="fr"> 
								<select id="searchWord" name="searchWord" style="width: 80px;">
								    <option value="all" id="option1" selected="selected">전체</option>
									<c:forEach items="${list_selval}" var="lec">
									<c:if test ="${lec.lec_name ne null}" >
									<option value="${lec.lec_name}">${lec.lec_name}</option>
									</c:if>
									</c:forEach>
								</select> 
							<a class="btnType blue" href="javascript:fListLec()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
							</span>
						</p>
						
						<div class="div_lec_list" id="div_lec_list">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
									    <th scope="col">강의명</th>
										<th scope="col">시험명</th>
										<th scope="col">상태</th>
										<th scope="col">대상자 수</th>
										<th scope="col">응시자 수</th>
										<th scope="col">미응시자 수</th>
									</tr>
								</thead>
								<tbody id="listLecture">
									<template v-for="(row, index) in items" v-if="items.length">
									<tr> 
									    <td>{{ row.lec_name }}</td>
										<td class="cursorArea"><a @click="b_std_list(row.lec_id, row.test_id)" ><strong> {{ row.test_name }}</strong></a></td>
										<td>{{ row.c_end }}</td>
										<td>{{ row.pre_pnum }}</td>
										<td>{{ row.sco}}</td>
										<td>{{ row.minNum }}</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
	
				<div class="paging_area"  id="LecPagination"> </div>
				
				<div  id="stdList">
						<p class="conTitle mt50">
							<span>응시자 목록</span> <span class="fr"> 
							</span>
						</p>
	
						<div class="div_std_list" id="div_std_list">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
									
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">학번</th>
										<th scope="col">학생명</th>
										<th scope="col">점수</th>
										<th scope="col">상태</th>
										
									</tr>
								</thead>
								<tbody id="liststudent">
								<template v-for="(row, index) in items" v-if="items.length">
										<tr>
											<td>{{row.std_num}}</td>
											<td>{{row.name}}</td>
											<td>{{row.test_sco}}</td>
											<td v-if = 'row.test_sco >= 60' >통과</td>
											<td v-else >과락</td> 
										</tr>
									</template>
								</tbody>
							</table>
						</div>
								<div class="paging_area"  id="studentPagination"> </div>
					</div> 
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>
</body>
</html>