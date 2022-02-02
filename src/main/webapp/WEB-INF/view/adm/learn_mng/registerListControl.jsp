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

	// 강의 목록 페이징 설정
	var pageSizeCourse = 5;
	var pageBlockSizeCourse = 5;
	
	// 학생 목록 페이징 설정
	var pageSizeStudent = 5;
	var pageBlockSizeStudent = 10;
	
	var sa; //서치값
	var lec; // 강의 목록
	var stvm; //학생 목록 
	var cvm; //강의 등록 폼


	
	$(document).ready(function() {
			
			init();
			// 강의목록 조회
			fListLec();		
			// 버튼 이벤트 등록
			
			$('#stdList').hide();
			
			fRegisterButtonClickEvent();

			$(document).on('keydown', '#searchWord', function(e) {
				if(e.keyCode == 13){
					fListLec();//강의 목록 조회
				}
			});
	
		 $("input:text[numberOnly]").on("keyup", function() {
			    $(this).val($(this).val().replace(/[^0-9]/g,""));
		
			});
			
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveCourse' :
					fSaveCourse();
					break;
				case 'btnCloseCourse' :
					gfCloseModal();
					break;
			}
		});
	}

	
	function init() {
		
		//변수에 넣어서 가져다 쓰기 위해
		sa = new Vue({
		                         el: '#searcharea' 
		                         ,data: {
		                        	      searchKey : 'all'
		                        	     ,searchWord : ''		                        	    
		                               }
		            });
	    
		lec= new Vue({
							  el: '#div_lec_list',
							  components: {
							    'bootstrap-table': BootstrapTable
							  },
							  data: {
									    items: []
									   ,lec_id: ''
							  },
							  methods:{					
											  b_stdList:function(lec_id){
												  this.lec_id = lec_id;
												  fListStd();
												},
											  b_update_lec:function(lec_id){					  
													 fLecSel(lec_id);
											  },
											  b_del_lec:function(lec_id,c_st){	
												 //현재 날짜 가져오는 자바 스크립트
													var today = new Date();
													var dd = today.getDate();  
													var mm = today.getMonth()+1;     
													var yyyy = today.getFullYear();
													
												    if ((dd+"").length < 2) {     
												    	dd = "0" + dd;
												    }
												    
												    if ((mm+"").length < 2) {     
												    	mm = "0" + mm;
												    }											    
													
													today = yyyy+'.'+mm+'.'+dd; //데이트 피커 날짜 포멧으로 바꾼후 today변수에 넣기
													
												  if(c_st<today){ //현재 날짜가 지나면 삭제 X
													 console.log(c_st, today);
												 	alert("개강 이후는 삭제할 수 없습니다.");
												  }else{
													  fLecdel(lec_id); 	  
												  }
											  } //del
			 					 }
			
			});	 //lec
	//학생 목록 뿌리기!!
	
	stvm = new Vue({
								  el: '#divStudentList',
								  components: {
								    'bootstrap-table': BootstrapTable
								  },
								  data: {
								    items: []
								  , lec_id: ''
								  }
		});	

	//과정 폼 추가
	cvm = new Vue({
							  el: '#layer1',
							  data: {
								lec_id:''
						       ,lec_name: ''
						       ,tutor_id:""
							   ,name: '' 
							   ,lecrm_id: '' 
							   ,lecrm_name: '' 
							   ,c_st: '' 
							   ,c_end: ''
							   ,max_pnum:''
							   ,process_day:''
							  }
		});	
/* 	
	$(selector).datepicker({
		  dateFormat: 'yy-mm-dd',
		  minDate: 0
		});
	 */
	$("#c_end").datepicker({
		dateFormat: 'yy.mm.dd',
		showAnim: "slide",
		
/*         onClose: function( selectedDate ) {    
            // 시작일(fromDate) datepicker가 닫힐때
            // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            $("#c_end").datepicker( "option", "maxDate", $("#c_st").val() );
         // defaultDate: $.datepicker.formatDate('yy.mm.dd', new Date()),
        }     */          
      
			   onClose: function( selectedDate ) {
                   // 종료일(toDate) datepicker가 닫힐때
                   // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                   $("#c_st").datepicker( "option", "minDate",  $("#c_end").val());
               }                
		});
	
	 
	 
	 
	$("#c_st").datepicker({ 
		dateFormat: 'yy.mm.dd', 
		showAnim: "slide",
		maxDate: 0,    
            onClose: function( selectedDate ) {    
                // 시작일(fromDate) datepicker가 닫힐때
                // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
               /*  $("#c_st").datepicker( "option", "minDate", $("#c_end").val() ); */
            	 $("#c_end").datepicker( "option", "maxDate", $("#c_st").val());
            }
	
		}).bind("change",function(){
                   var minValue = $(this).val();
                   var disdate; 
                   //console.log("1 minValue : " + minValue);
                   
                   
                    minValue = $.datepicker.parseDate("yy.mm.dd", minValue);
      
                     minValue.setDate(minValue.getDate()+1);
                     
                     var day = new Date(minValue);
					 var dd = day.getDate();  
					 var mm = day.getMonth()+1;     
					 var yyyy = day.getFullYear();
						
					 if ((dd+"").length < 2) {     
					      dd = "0" + dd;
					 }
					    
					 if ((mm+"").length < 2) {     
					   	 mm = "0" + mm;
					 }											    
						
					  disdate = yyyy+'.'+mm+'.'+dd; //데이트 피커 날짜 포멧으로 바꾼후 today변수에 넣기
     
                     // console.log("2 disdate : " + disdate);
                     
                     $("#c_end").datepicker( "option", "minDate", minValue );
                     $("#c_end").val(disdate);
       });
	
};	//init();


	//강의 목록
	function fListLec(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage + " sa.searchKey : " + sa.searchKey + " sa.searchWord : " + sa.searchWord);
		
		var param = {
					currentPage : currentPage
				,	pageSize : pageSizeCourse
				,   searchKey : sa.searchKey
				,   searchWord : sa.searchWord
		}
		
		var resultCallback = function(data) {
			fListLecResult(data, currentPage);
		};
		
		callAjax("/adm/listLec.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 과정 조회 콜백 함수 */
	function fListLecResult(data, currentPage) {
		
		lec.items=[];
		lec.items=data.list_lec;
		
		stvm.items=[]; //학생 조회 후 살리기!
		// 총 개수 추출
		var totalCntCourse = data.totalCount;

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntCourse, pageSizeCourse, pageBlockSizeCourse, 'fListLec');
		
		console.log("paginationHtml : " + paginationHtml);
		
		//alert(paginationHtml); 확인해보기
		
		$("#coursePagination").empty().append( paginationHtml );
		
		
		$("#currentPageCourse").val(currentPage);  
		
	}
	
	
	//학생 조회
	function fListStd(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage + " lec_id : " + lec.lec_id);
		
		var param = {
				currentPage : currentPage
				,pageSize : pageSizeStudent
				,lec_id : lec.lec_id
		}
		
		var resultCallback = function(data) {
			fListStdResult(data, currentPage);
		};
		//Ajax실행 방식
		callAjax("/adm/listStd.do", "post", "json", true, param, resultCallback);
	}
		

	/** 학생 조회 콜백 함수 */
	function fListStdResult(data, currentPage) {

		stvm.items=[];
		stvm.items=data.list_std;
		
		// 총 개수 추출
		var totalCntStudent = data.totalCount;
		/* var totalCntStudent = data.totalCount; */
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntStudent, pageSizeStudent, pageBlockSizeStudent, 'fListStd');
		
		console.log("paginationHtml : " + paginationHtml);
		
		//alert(paginationHtml);
		$("#studentPagination").empty().append( paginationHtml );
		
		$("#delCourseno").val(data.lec_id);	
	
		$('#stdList').show();
		
	}	

	

	/** 과정 한건  조회 */
	function fLecSel(lec_id) {
		
		console.log("과정한건 조회 : " + lec_id);
		
		var param = {
				lec_id : lec_id
		}
		
		var resultCallback = function(data) {
			fLecSelResult(data);
		};
		//Ajax실행 방식
		callAjax("/adm/lecSel.do", "post", "json", true, param, resultCallback);
	}
	
	/** 과정 한건  조회 콜백 함수 */
	function fLecSelResult(data) {
		
		fInitFormLec(data.sel_lec);
	
	}	
	
	
	/** 과정 폼 초기화 */
	function fInitFormLec(object) {
		$("#lec_name").focus();
		
		if( object == "" || object == null || object == undefined) {
			cvm.lec_id = "";
			cvm.lec_name = "";
			cvm.lecrm_id = "";
			cvm.tutor_id = ""; 
			cvm.lecrm_name = "";
			cvm.max_pnum = "";
			cvm.process_day ="";
			cvm.c_st = ""; 
			cvm.c_end = "";
			$("#lec_name").css("background", "#FFFFFF");
			$("#lec_name").focus();
			$("#btnDeleteCourse").hide();
			$("#delCourseno").val("");
			$("#action").val("I");
			
			
			
			
		} else {
			
			cvm.lec_id = object.lec_id;
			cvm.lec_name = object.lec_name;
			cvm.lecrm_id = object.lecrm_id; 
			cvm.tutor_id = object.tutor_id; 
			cvm.lecrm_name = object.lecrm_name;
			cvm.max_pnum = object.max_pnum;
			cvm.process_day = object.process_day;
			cvm.c_st = object.c_st; 
			cvm.c_end = object.c_end;
			console.log(object.tutor_id);
			$("#lec_name").css("background", "#F5F5F5");
			$("#lec_name").focus();
			$("#btnDeleteCourse").show();
			$("#delCourseno").val(object.lec_id);
			$("#action").val("U");
		}		
		// 모달 팝업
		gfModalPop("#layer1");
	}
	
	function fPopModalcourse() {
		fInitFormLec();		
	}

	function fSaveCourse() {

		// vaildation 체크
		var resultCallback = function(data) {
			fSaveCourseResult(data);
		};
		callAjax("/adm/saveLec.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}
	

	
	function fSaveCourseResult(data) {
		
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageCourse").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
			// 입력폼 초기화
			fInitFormLec();			
			// 모달 닫기
			gfCloseModal();
			stvm.items=[];
			// 목록 조회
			fListLec(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}	

	/** 과정 한건  삭제 */
	function fLecdel(lec_id) {
		
		console.log("과정삭제 강의번호 : " + lec_id);
		var param = {
					lec_id : lec_id
		}
		var resultCallback = function(data) {
			fSaveCourseResult(data);
		};
		//Ajax실행 방식
		callAjax("/adm/delLec.do", "post", "json", true, param, resultCallback);
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentPageCourse" id="currentPageCourse" value="">
	<input type="hidden" name="delCourseno" id="delCourseno" value="">


	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">학습 관리</a> <span class="btn_nav bold">수강 목록 관리</span> <a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
						</p>
					
						<p class="conTitle" id="searcharea">
							<span>강의 목록</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
								    <option value="all" id="option1" selected="selected">전체</option>
									<option value="lec_nm" id="option1">강의명</option>
									<option value="t_nm" id="option2">강사명</option>
								</select> 
								<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fListLec()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
							
								 
							    <a class="btnType blue" href="javascript:fPopModalcourse();" name="modal"><span>과정 등록</span></a>
							</span>
						</p>
						
						<div class="div_lec_list" id="div_lec_list">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="10%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="25%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">강의 번호</th>
										<th scope="col">강의명</th>
										<th scope="col">담당교수</th>
										<th scope="col">강의실</th>
										<th scope="col">수강인원</th>
										<th scope="col">기간</th>
										<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody id="listLecture">
									<template v-for="(row, index) in items" v-if="items.length">
									<!-- <tr onclick="lec.rowClicked(this)"> -->
									<tr>
									    <td>{{ row.lec_id }}</td>
										<td class="cursorArea"><a @click="b_stdList(row.lec_id)" ><strong>{{ row.lec_name }}</strong></a></td>
										<td>{{ row.name }}</td>
										<td>{{ row.lecrm_name }}</td>
										<td>{{ row.pre_pnum }}</td>
										<td>{{ row.c_st }} - {{ row.c_end }}</td>
										<td align="center">
										    <table border=0>
										       <tr>
										          <p style="display: inline-block" class="btnType3 color1" @click="b_update_lec(row.lec_id)"><a class="btnType3 color1"><span id="searchEnter">수정</span></a></p>
										          <p style="display: inline-block; margin-left:5px;" class="btnType3 color1" @click="b_del_lec(row.lec_id, row.c_st)"><a class="btnType3 color1"><span id="searchEnter">삭제</span></a></p></span>
										       </tr>
										    </table>
										</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="coursePagination"> </div>
						<div  id="stdList">
						<p class="conTitle mt50" >
							<span>학생정보</span> <span class="fr"> 
							</span>
						</p>
	
						<div class="divStudentList" id="divStudentList">
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
										<th scope="col">과정명</th>
										<th scope="col">출석률</th>
										
									</tr>
								</thead>
								<tbody id="liststudent">
								
									<template v-for="(row, index) in items"  v-if="items.length">
										<tr>
											<td>{{ row.std_num }}</td>
											<td>{{ row.name }}</td>
											<td>{{ row.lec_name }}</td>
											<td>{{ row.atd }}%</td>
										</tr>
									</template>
								</tbody>
							</table>
						</div>
						<!-- <div v-if = 'row.totalCount != 0' > -->
								<div class="paging_area"  id="studentPagination"> </div>
						</div><!--  stdlist -->
					</div> <!--// content -->
					
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<!-- 모달팝업 -->
<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>강의 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명<span class="font_red">*</span></th>
							<td> <input type="hidden" class="inputTxt p100" v-model="lec_id" name="lec_id" id="lec_id" />
									<input type="text" class="inputTxt p100" v-model="lec_name" name="lec_name" id="lec_name" /></td>
							</tr>
							<tr>
							<th scope="row">최대인원 </th>
							<td><input type="text" class="inputTxt p100" v-model="max_pnum" name="max_pnum" id="max_pnum"   placeholder="숫자만 입력하세요." numberOnly/></td>		
						</tr>
						
						<tr>
							<th scope="row">강사명</th>
							<td>
							<select id="tutor_id" name="tutor_id"  v-model="tutor_id" class="inputTxt p100">
									<c:forEach items="${tutor_list}" var="lec">
									<c:if test ="${lec.name ne null}" >
									<option value="${lec.loginID}">${lec.name}</option>
									</c:if>
									</c:forEach>
									<option value="미정" >미정</option>
								</select>
								
							</td>
							</tr>
							<tr>
							<th scope="row">강의실 </th>
							<td>
								<select id="lecrm_id" name="lecrm_id"  v-model="lecrm_id" class="inputTxt p100" >
									<c:forEach items="${list_rm}" var="rm">
									<c:if test ="${rm.lecrm_name ne null}" >
									<option value="${rm.lecrm_id}">${rm.lecrm_name}</option>
									</c:if>
									</c:forEach>
									<option value="미정" >미정</option>
								</select>
							</td>	
							</tr>
							<tr>
								<th scope="row">과정일수</th>
							<td>
								 <input type="text" class="inputTxt p100" v-model="process_day" name="process_day" id="process_day" placeholder="숫자만 입력하세요." numberOnly/>
							</td>					
						</tr>
						<tr>
					
							<th scope="row">시작일자</th>
							<td>
								 <input type="text" class="inputTxt p100" data-date-format='yyyy.mm.dd' v-model="c_st" name="c_st" id="c_st" />
							</td>
							</tr>
							<tr>
							<th scope="row">종료일자</th>
							<td>
							     <input type="text" class="inputTxt p100" data-date-format='yyyy.mm.dd' v-model="c_end" name="c_end" id="c_end" />
							</td>							
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveCourse" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseCourse" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="btnCloseCourse" name="btn"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>