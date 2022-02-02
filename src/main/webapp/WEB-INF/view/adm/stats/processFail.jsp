<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>processFail</title>


<!-- 밑의 위치에 있는 jsp 에 있는 모든 것들을 포함해준다! -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>

<script type="text/javascript">

//시험 과락 점수 60점 이하면 과락 이상이면 수료 null이면 미응시



	var pageSize = 5;
	var pageBlockSize = 5;

	var vm;
	var svm;
	var lvm;

	
 
	
	$(document).ready(function(){
		
		lec_List();
		
		//date 들어있음
		init(); 
		
	})
	
	
		//검색시 엔터키 구동
	$(document).on('keydown', '#searchWord'||'#startdate'||'#enddate', function(e) {
		if (e.keyCode == 13) {
			lec_List();
			
			Chart_lec();
		}
	});
	
	
	function init(){
		
		svm = new Vue({
			
            el: '#searcharea',  
          data: {
         	     
         	     searchWord : ''	
         	     ,startdate : ''
         	     ,enddate : ''
                }
		});
		
		
		vm = new Vue({
			el : '#divlec_List',
			components : {
				'bootstrap-table' : BootstrapTable
			},
			data : {
				items : [],
				lec_id : ''
			},
			methods : {
				
			
				selChart : function(lec_id) {
				
					console.log("lec_id:" + lec_id);
					Chart_lec(lec_id);
				
				}
			
				
			
			}
		
		});
		

		  $("#enddate").datepicker({defaultDate: $.datepicker.formatDate('yyyy.mm.dd', new Date())});
		 $("#startdate").datepicker({ dateFormat: 'yyyy.mm.dd' }).bind("change",function(){
	         var minValue = $(this).val();
	         minValue = $.datepicker.parseDate("yyyy.mm.dd", minValue);
	         minValue.setDate(minValue.getDate()+1);
	         $("#enddate").datepicker( "option", "minDate", minValue );
	     });
	}
		
	

	function lec_List(currentPage) {
		//현재 페이지 처음에는 값이 없으니까 1, 다음번엔 들어온 값 우선순위
		currentPage = currentPage || 1;
	 
		console.log("searchWord : " + searchWord);
		
		var param = {
				currentPage : currentPage,
				 pageSize   : pageSize,
				 searchWord : $("#searchWord").val(), // document.getElementById("searchWord").value
				  startdate : $("#startdate").val(),
				    enddate : $("#enddate").val()
			
			    
		}
		
		//lec_List_Result으로 갈거야 data 랑 currentPage 가지고!
		var resultCallback = function(data) {
			lec_List_Result(data, currentPage);
		};
		
		callAjax("/adm/lec_List_Select.do", "post", "json", true, param, resultCallback);
	}
	
	
	function lec_List_Result(data, currentPage) {
		
		vm.items= [];
		vm.items = data.lec_List_Select;
		
		console.log(currentPage);
		
		var lec_Total = data.lec_Total;
		var paginationHtml = getPaginationHtml(currentPage, lec_Total, pageSize, pageBlockSize, 'lec_List');
		
		//밑의 내용에 들어오는 데이터 비워주고 다시 내용 붙여!

		
		$("#Pagination_Lec").empty().append(paginationHtml);
		
		//여기서 다른 함수로 보내야 하나?
	}
	
	
	$(function () {
		
		$('#searchEnter').click(function(e){
		
			if($('#searchWord').val()==""){
				alert("강의명을 입력하세요");
			
				 return false;
			}
		});
	});
			
	//Chart_lec 은 lec_id라는 이름으로 데이터를 받을거야
	function Chart_lec(lec_id) {
		//lec_id라는 이름을 가진 lec_id 데이터 값
		/* alert("1"); */
		console.log("lec_id : " + lec_id);
		
		var param= {
				lec_id : lec_id,
			searchWord : $("#searchWord").val(), // document.getElementById("searchWord").value
			 startdate : $("#startdate").val(),
			   enddate : $("#enddate").val()
		}
		var resultCallback1 = function(data) {
			/* alert("3");
			alert(JSON.stringify(data.lec_Name_List));
			alert(JSON.stringify(data.lec_Name_List)) */
			
			Chart_lec_Result(lec_id);
			lec_Chart (data);
		};
		
		/* alert("2"); */
		callAjax("/adm/lec_Name_List.do", "post", "json", true, param, resultCallback1);
		
		
	}
	
	 function Chart_lec_Result(data) {
		
		$('#lec_Name_List').empty().append(data);
		
		
	}
	 
	//차트 꾸미기
	function lec_Chart(data) { 
		//document.getElementById(id);  주어진 ID와 일치하는 DOM 요소를 나타내는 Element 객체. 문서 내에 주어진 ID가 없으면 null.
		var ctx = document.getElementById("myChart").getContext('2d');
		
		
		
		var myChart = new Chart(ctx, {
		    type: 'bar',
		    data: {
				
				//차트 강의명 데이터 배열로 넣어줬어!
		        labels: data.lec_Name_List,
		        datasets: [{
		            label: "통과",
		        	//차트에 데이터 넣어주는 곳!
		            data: data.lec_Name_List31,
		            
		           
		            backgroundColor: [
		                'rgba(29, 178, 245, 0.8)',
		                'rgba(29, 178, 245, 0.8)',
		                'rgba(29, 178, 245, 0.8)',
		                'rgba(29, 178, 245, 0.8)',
		                'rgba(29, 178, 245, 0.8)',
		                
		            ],
		            borderColor: [
		                'rgba(29, 178, 245, 1)',
		                'rgba(29, 178, 245, 1)',
		                'rgba(29, 178, 245, 1)',
		                'rgba(29, 178, 245, 1)',
		                'rgba(29, 178, 245, 1)',
		            
		            ],
		            borderWidth: 1,
		           
		        },
		        {
		            label: "과락",
		            data: data.lec_Name_List41,
		            
		            
		            backgroundColor: [
		                'rgba(245, 86, 132, 0.8)',
		                'rgba(245, 86, 132, 0.8)',
		                'rgba(245, 86, 132, 0.8)',
		                'rgba(245, 86, 132, 0.8)',
		                'rgba(245, 86, 132, 0.8)',
		                
		            ],
		            borderColor: [
		                'rgba(245, 86, 132, 1)',
		                'rgba(245, 86, 132, 1)',
		                'rgba(245, 86, 132, 1)',
		                'rgba(245, 86, 132, 1)',
		                'rgba(245, 86, 132, 1)',
		            
		            ],
		            borderWidth: 1,
		           
		        },
		      ]
		
		
		
		    },
		    options: {
		    	title: {
		    		display: true,
		    		text: '강의별 수료 과락 통계',
		    		fontSize : 18,
		    	},
		    	legend: {
		    		display: true,
		    		position: 'right'
		    	},
				
		        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
		        scales: {
		            yAxes: [{
		                ticks: {
		                	
		                	stepSize : 1,
		                	fontSize : 14,
		                    beginAtZero:true
		                }
		            }]
		        },
		    }
	   
		});
		
	}
	
	
	
	/* 
	function lec_Chart_sel(data) { 
		//document.getElementById(id);  주어진 ID와 일치하는 DOM 요소를 나타내는 Element 객체. 문서 내에 주어진 ID가 없으면 null.
		var ctx = document.getElementById("myChart").getContext('2d');
		
		var myChart = new Chart(ctx, {
		    type: 'bar',
		    data: {
				
				//차트 강의명 데이터 배열로 넣어줬어!
		        labels: data.Chart_lec_sel1,
		        datasets: [{
		            label: "통과",
		        	//차트에 데이터 넣어주는 곳!
		            data: data.lec_Name_List31,
		            
		           
		            backgroundColor: [
		                'rgba(29, 178, 245, 0.8)'
		             
		                
		            ],
		            borderColor: [
		                'rgba(29, 178, 245, 1)'
		              
		            
		            ],
		            borderWidth: 1,
		           
		        },
		        {
		            label: "과락",
		            data: data.lec_Name_List41,
		            
		            
		            backgroundColor: [
		                'rgba(245, 86, 132, 0.8)'
		            
		                
		            ],
		            borderColor: [
		                'rgba(245, 86, 132, 1)'
		            ],
		            borderWidth: 1,
		        },
		      ]
		
		    },
		    options: {
		    	title: {
		    		display: true,
		    		text: '강의별 수료 과락 통계',
		    		fontSize : 18,
		    	},
		    	legend: {
		    		display: true,
		    		position: 'right'
		    	},
				
		        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
		        scales: {
		            yAxes: [{
		                ticks: {
		                	
		                	stepSize : 1,
		                	fontSize : 14,
		                    beginAtZero:true
		                }
		            }]
		        },
		    }
	   
		});
		
	} */
	 
	
	



</script>
</head>
<body>

	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div id="wrap_area">
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	
		<div id="container">
			<ul>
				<li class="lnb">
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include></li>
				<li class="contents">
					<h3 class="hidden">contents 영역</h3>
					<div class="content">
						<p class="Location">
							<a href="" class="btn_set home">메인으로</a> 
							<a href="" class="btn_nav">시스템 관리</a> 
							<span class="btn_nav bold">강의 과락 비율</span>
							<a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
						</p>
						<!-- 강의 과락 비율 -->
						<div class="divComGrpCodList">
							<div>
							
								<!-- <p class="search"></p> -->
								<p class="conTitle" id="searcharea">
								<span>과락 비율</span>
								<!-- 밑의 클래스 f() 는 r,l,c에 따라 오른쪽 왼쪽 가운데로 나뉜다. -->
								<span class="fr" >
									<span>강의명</span>
									<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
									style="height: 28px;" placeholder="" >
									<span>개강일</span>
									<input type="text" name="startdate" id="startdate" v-model="startdate" data-date-format='yyyy.mm.dd' style="height:28px;">
									<span>종강일</span>
									<input type="text" name="enddate" id="enddate" v-model="enddate" data-date-format='yyyy.mm.dd' style="height:28px" >
									<a class="btnType blue" href="javascript:lec_List(),Chart_lec()" name="search">
									<span id="searchEnter">검색</span></a>
								</span>
								</p>
							</div>
							<div class = "divlec_List" id="divlec_List">
								<table class="col">
									<colgroup>
										<col width="30%">
										<col width="25%">
										<col width="25%">
										<col width="10%">
										<col width="10%">
									<thead>
										<tr>
											<th scope="col" colspan="6">강의 과락 비율</th>
										</tr>
										<tr>
											<th>과정명</th>
											<th>개강일</th>
											<th>종강일</th>
											<th>과정일수</th>
											<th>수강인원</th>
										</tr>
									</thead>
									<tbody id="lec_List">
										<template v-for="(row,index) in items" v-if="items.length">
									
											<tr>
												<td><a @click="selChart(row.lec_id)">{{row.lec_name}}</a></td>
												<td>{{row.startdate}}</td>
												<td>{{row.enddate}}</td>
												<td>{{row.process_day}}</td>
												<td>{{row.pre_pnum}}</td>
											</tr>
										</template>
									</tbody>
								</table>
							</div>	
							<div class="paging_area" id="Pagination_Lec"></div> 
							<!--// content -->
							<h3 class="hidden">풋터 영역</h3> 
							<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
						</div>
						<div style="width:1000px">
							<canvas  id="myChart"></canvas>
						</div> 
					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>