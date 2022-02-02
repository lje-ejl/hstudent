<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<!-- 이민하 작업중 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>EquipmentControl</title>
<style type="text/css">
	.cursorArea{
		cursor: pointer;
	}
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
    	-webkit-appearance: none;
   	 	margin: 0;
	}
</style>
<!-- 밑의 위치에 있는 jsp 에 있는 모든 것들을 포함해준다! -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	
	// 페이징 설정 이름 장비 페이지에서 사용하는 페이지 용으로 변경!
	//한 페이지에 나오는 목록 갯수!!
	var pageSizeEquip = 5;
	//페이지 하단에 있는 번호들 갯수 5로 하겠다.
	var pageBlockSizeEquip = 5;	
	
	/* vue 에서 쓸 변수명들 추가내놓기! */
	var vm;
	var cvm;
	var svm;

/** OnLoad event */ 
/** onload 는 페이지가 뜨자마자 실행되는 이벤트*/
	$(document).ready(function() {
		
		init();
		
		//장비 리스트 조회
		fListequip();
		
		/** 버튼 이벤트 등록 */
		fRegisterButtonClickEvent();
	
    });


	//검색시 엔터키 구동
	$(document).on('keydown', '#searchWord', function(e) {
		   if(e.keyCode == 13){
			   fListequip();
		   }
		});

	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveEquip' :
					fSaveEquip();
					break;
				case 'btnCloseEquip' :
					gfCloseModal();
					break;
			}
		});
	}

	function init() {
		
		//변수에 넣어서 가져다 쓰기 위해서 변수를 사용한거다.
		svm = new Vue({
							
		                           el: '#searcharea',  
		                         data: {
		                        	      searchKey : 'equ_name'
		                        	     ,searchWord : ''		                        	    
		                               }
		            });
	    
		
		
		//vm 이란 변수로 관리 해 줄 거야!
		vm = new Vue({
			//div 밑의 html 에서 저 부분 적힌거 찾아봐! div 도 들어올 수 있고 엘리먼트 (인풋 태그 하나같은거!)도 들어올 수 있어!
			//구역별로 뜯어서 관리하겠다는 의도야!
			  el: '#divEquipList',
			  //components 는 뷰js 에서 사용할 수 있는 API 같은거라고 생각하면 돼!
			  components: {
				  //common폴더 안에 common_include 들어가면  저 부트스트랩 쓸거라는 걸 알 수 있어!
				  //src=//-> 인터넷에서 가져오는 것 //는 www와 같다
			//<script>="text/javascript" src="//rawgit.com/wenzhixin/vue-bootstrap-table/develop/docs/static/dist/vue-bootstrap-table.js">

			    'bootstrap-table': BootstrapTable
			  },
			  //data div 안에서 이  밑에 것들을 써먹겠다 . 변수이다. 여기서 선언했어! item 은 배열 변수 loginid 는 문자열 변수
			  data: {
			    items: []
			   ,equ_id: ''
			  },
			  //div 안에서 관리할 메소드 
			  //rowClicked라는 메소드를 만들었어!
			  methods:{		
				  //해당 줄을 클릭했을때 함수  변수 이름이 row . 받아 올때 row 에서 받아오겠다!
				  //rowClicked는 함수 이름 / row는 변수 이름
				  		  
				  equipmod:function(equ_id){					  
					  fequipsel(equ_id);	
				  },
				  equipdel:function(equ_id){					  
					  confirmter (equ_id);
				  }
			  }
			});	  	
		
		
		
		cvm = new Vue({
			  el: '#layer1',
			  data: {
				 equ_id: ''
				, lecrm_id: '' 
				,equ_name: ''
			   ,equ_num: '' 
			   ,equ_note: '' 
		
			  }
			});	
		
	
	}


 	//장비 리스트 조회
	function fListequip(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage + " svm.searchKey : " + svm.searchKey + " svm.searchWord : " + svm.searchWord);

		//alert("지금 현재 페이지를 찍어봅시다. " + currentPage); 
		//여기서 currentPage,pageSize 다 나온다
		//alert(" svm.searchWord : " + svm.searchWord );
		
		var param = {
					//이름 (가방)  : 값(안에 있는 물건)
					currentPage : currentPage
					//위에서 정의해줬다 var PageSizeEquip = 5;
				,	pageSize : pageSizeEquip
				,   searchKey : svm.searchKey
				,   searchWord : svm.searchWord
				

				
		}
		/* pageSizeEquip로 뜬다
		alert("지금 현재 페이지를 찍어봅시다. " + pageSizeEquip); 
 */
		//resultCallback이란 이름의 함수를 생성 이 함수는 fListequipResult안에 data, currentPage를 받아와!
		var resultCallback = function(data) {
			fListequipResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/adm/listEquip.do", "post", "json", true, param, resultCallback);
	}
 		
 	/* 장비 목록 리스트  data 목록에 뿌리기!	 */
	/*장비 조회 콜백 함수*/	
	function fListequipResult(data, currentPage) {
		
		//alert(data);
		console.log(data);
		//받아온 데이터가 vm.item에 들어가도록 해줘! 
		vm.items = [];
		vm.items = data.listEquip;
		
		// 총 개수 추출
		// ("totalcnt", totalCount)-> 서비스 다오에서 받아온 totalCount 데이터를 totalcnt 라는 이름으로 jsp 에서 쓸거야!!
		var totalCntEquip = data.totalCount;
 	    // alert("totalcnt 찍어봄!! " + totalCntEquip);
        var paginationHtml = getPaginationHtml(currentPage, totalCntEquip, pageSizeEquip,pageBlockSizeEquip, 'fListequip');

		// 페이지 네이게이션
		console.log("paginationHtml : " + paginationHtml);
 		//#EquipPagination 저 장소에 데이터를 일단 비웠다가 붙여줘.  paginationHtml값 받아온것들 있지?
		$("#equipPagination").empty().append( paginationHtml );
		$("#currentPageEquip").val(currentPage);

	}	
	
	/** 장비 폼 초기화 */
	function fInitFormEquip(object) {
		$("#equ_id").focus();
		
		if( object == "" || object == null || object == undefined) {
			cvm.equ_id = "";
		 	cvm.lecrm_id = ""; 
			cvm.equ_name = "";
			cvm.equ_num = "";
			cvm.equ_note = ""; 
	
			$("#equ_id").css("background", "#FFFFFF");
			$("#equ_id").focus();
			$("#btnDeleteCourse").hide();
			
			$("#delEquipno").val("");
			//$("#Coursestudent").val("");
			$("#action").val("I");

			
		} else {
			cvm.equ_id = object.equ_id;
			 cvm.lecrm_id = object.lecrm_id; 
			cvm.equ_name = object.equ_name;
			cvm.equ_num = object.equ_num;
			cvm.equ_note = object.equ_note; 
			
			$("#equ_id").css("background", "#FFFFFF");
			$("#equ_id").focus();
			$("#btnDeleteCourse").show();

			$("#delEquipno").val(object.equ_id);
			//$("#Coursestudent").val(object.equ_id);
			
			$("#action").val("U");
 			
		}		
		// 모달 팝업
		gfModalPop("#layer1");
	}
	
	function fPopModalequip() {
		fInitFormEquip();		
	}
 	
	

 	
 	//밑에 부분 자바스크립트로 버튼 구현한건데 버튼 등록 이벤트로 대체하는 것 같다.
 /* 	$(document).ready(function(){
 		$("#modal-btn").click(function(){
 			$("#layer1").modal();
 		});
 	});
 */
 	
	/** 장비 등록 */
	function fSaveEquip() {

		// vaildation 체크
		//과정 저장 fValidateEquip이 아니라면 ?
		if ( ! fValidateEquip() ) {
			return;
		}
		
		console.log("equ_id : " + cvm.equ_id);
		console.log("lecrm_id : " + cvm.equ_id); 
		console.log("equ_name : " + cvm.equ_name);
		console.log("equ_num : " + cvm.equ_num);
		console.log("equ_note : " + cvm.equ_note);
		console.log("action : " + $("#action").val());
		
		var param = {
				//이름 (가방)  : 값(안에 있는 물건)
				equ_id : cvm.equ_id
			,	lecrm_id : cvm.lecrm_id 
			,	equ_name : cvm.equ_name
			,	equ_num : cvm.equ_num
			,	equ_note : cvm.equ_note
			,	action : $("#action").val()
	    }      
		
		
		
		var resultCallback = function(data) {
			fSaveEquipResult(data);
		};
		
		callAjax("/adm/saveEquip.do", "post", "json", true, param, resultCallback);
	}
	

	/** 장비 등록 validation */
	function fValidateEquip() {

		var chk = checkNotEmpty(
				[
						[ "equ_id", "장비명를 입력하세요" ]
					,	[ "equ_name", "장비명을 입력하세요" ]
					,	[ "lecrm_id", "강의실을 선택하세요" ] 
					,	[ "equ_num", "장비 갯수를 입력하세요"]
						
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	/** 과정 한건  조회 */
	 function  fequipsel(equ_id) {
		
		console.log("fequipsel  equ_id : " + equ_id);
		
		var param = {
				equ_id : equ_id
		}
		
		var resultCallback = function(data) {
			fEquipselResult(data);
		};
		
		
		//Ajax실행 방식
		callAjax("/adm/Equipsel.do", "post", "json", true, param, resultCallback);
	}
	 
	
	/** 과정 한건  조회 콜백 함수 */
	 function fEquipselResult(data) {
		
		fInitFormEquip(data.equipinfo);
	}	
	 
	
	
	//장비 삭제 확인창
	function confirmter(equ_id) {
		if(confirm("삭제하시겠습니까?")){
			fEquipdel(equ_id);
		}else{
			return false;
		}
	}
	
	
	/** 장비  삭제 */
	function fEquipdel(equ_id) {
		
		
		var param = {
				equ_id : equ_id
		}
		
		var resultCallback = function(data) {
			fSaveEquipResult(data);
		};
		//Ajax실행 방식
		callAjax("/adm/Equipdel.do", "post", "json", true, param, resultCallback);
	}
	
 		
	
	
	
	
	

	/** 장비 삭제, 저장 콜백 함수 */
	//장비 메인 페이지로 돌아오기 위한 함수
	function fSaveEquipResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageEquip").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			alert(data.resultMsg);
			
			// 입력폼 초기화
			fInitFormEquip();			
			
			// 모달 닫기
			gfCloseModal();
			
			
			
			// 목록 조회
			fListequip(currentPage);
			
			//응답 오류 메세지가 뜨는 부분이다. 빈 입력 뒤에 저장을 눌렀을때 '장비명'이라 나오는 이유
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
	}	

	

	


	
	
	


</script>
</head>
<body>
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
		
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<!-- 왼쪽의 메뉴 목록 부분 -->
				<li class="lnb">
				<!-- lnb 영역 --> 
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
				<!--// lnb 영역 -->
				</li>
				<li class="contents">
				<!-- 메뉴 목록 끝 -->
				
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> 
					<div class="content">

						<p class="Location">
							<a href="" class="btn_set home">메인으로</a> 
							<a href="" class="btn_nav">시설 관리</a> 
							<span class="btn_nav bold">장비 관리</span> 
							<a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
						</p>
						<p class="search"></p>
						<p class="conTitle" id="searcharea">
							<span>장비 관리</span> 
							<span class="fr">
							<span >장비명</span>
								<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
									placeholder="" style="height: 28px;"> 
									<a class="btnType blue" href="javascript:fListequip()" onkeydown="enterKey()" name="search">
									<span id="searchEnter">검색</span></a>							 
									<a class="btnType blue" href="javascript:fPopModalequip()"  id="modal">
									<span>신규등록</span></a>
							</span>
						</p>
						<p class="serch" id="searcharea"></p>
						
						<div class="divEquipList" id="divEquipList">
							<table class="col">
								<thead>
									<th scope="col" colspan="6">장비 목록</th>
								</thead>
								<caption>caption</caption>
								<colgroup>
								    <col width="10%">
									<col width="35%">
									<col width="20%">
									<col width="20%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">번호</th>
										<th scope="col">장비명</th>
										<th scope="col">갯수</th>
										<th scope="col">비고</th>
										<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody id="listEquip">
									<template v-for="(row, index) in items" v-if="items.length">
<!-- 									밑에는 뷰 문법을 각기 다른 방법을 이용해서 사용한 것이다. 가장 간편하게는 @뒤에 바로 선언 해줄 수 있다.
										onclick 은 클릭시 발생하는 이벤트!
 -->									<tr>
<!-- 									<tr v-on::click="rowClicked(this)">
										<tr @click="rowClicked(this)"> -->
									    <td>{{ index + 1 }}</td>
									    <td>{{ row.equ_name }}</td>
										<td>{{ row.equ_num }}</td>
										<td>{{ row.equ_note }}</td>
										<td align="center">
										    <table border=0>
										       <tr>
										          <p style="display: inline-block" class="btnType3 color1" @click="equipmod(row.equ_id)"><a class="btnType3 color1"><span id="searchEnter" class="cursorArea">수정</span></a></p>
										          <p style="display: inline-block; margin-left:5px;" class="btnType3 color1" @click="equipdel(row.equ_id)"><a class="btnType3 color1"><span id="searchEnter" class="cursorArea">삭제</span></a></p>
										       </tr>
										    </table>
										</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
						<div class="paging_area" id="equipPagination"></div> 
					</div> <!--// content -->
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	
	<!-- 모달 팝업 -->
	<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentPageEquip" id="currentPageEquip" value=""> 
	<input type="hidden" name="delEquipno" id="delEquipno" value="">
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		
		
		
		<!-- 	<input type="hidden" name="Coursestudent" id="Coursestudent" value="">
		 -->	
	
		<dl>
			<dt>
				<strong>장비 등록</strong>
			</dt>
			<dd class="content">	
			<!-- s : 여기에 내용입력 -->
			<table class="row">
				<caption>caption</caption>
				
					
					<tbody>
						<tr>
							<th scope="row">장비명<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="equ_name" name="equ_name" id="equ_name" /></td>
						
						
						
							<th scope="row">강의실<span class="font_red">*</span></th>
							<td><select  class="inputTxt p100" v-model="lecrm_id" name="lecrm_id" id="lecrm_id">
							<c:forEach items="${listLecrm}" var="lec"> <!-- EquipMentControlcontoller 28줄 -->
							<option value="${lec.lecrm_id}">${lec.lecrm_name}</option>
							</c:forEach>
							</select></td>  
						<tr>
							<th scope="row">갯수<span class="font_red">*</span></th>
							<td><input type="number" class="inputTxt p100" name="equ_num" id="equ_num" v-model="equ_num" /></td>
							<th scope="row">비고 </th>
							<td><input type="text" class="inputTxt p100" name="equ_note" id="equ_note" v-model="equ_note" /></td>							
						
				</tbody>
			</table>
			
			<!-- e : 여기에 내용입력 -->

			<div class="btn_areaC mt30">
				<a href="" class="btnType blue" id="btnSaveEquip" name="btn"><span>저장</span></a> 
				<a href=""	class="btnType gray"  id="btnCloseEquip" name="btn"><span>취소</span></a>
			
			</div>
		</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		
	</div>
	</form>
	<!--// 모달팝업 -->

</body>
</html>