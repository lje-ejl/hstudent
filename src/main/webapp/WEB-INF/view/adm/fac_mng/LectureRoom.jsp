<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<!-- 이민하 작업중 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>LectureRoom</title>


<!-- 밑의 위치에 있는 jsp 에 있는 모든 것들을 포함해준다! -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
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
<script type="text/javascript">
	//페이지 설정들
	var pageSizeLecrm = 5;
	var pageBlockSizeLecrm = 5;
	var pageSizeEquip = 5;
	var pageBlockSizeEquip = 5;
	/* vue 사용 메소드들 */
	var vm;
	var cvm;
	var svm;
	var evm;

	/** OnLoad event */
	/** onload 는 페이지가 뜨자마자 실행되는 이벤트*/
	$(document).ready(function() {

		init();

		$('#divEquipList').hide();
		//강의실 리스트 조회
		fListLecrm();

		/** 버튼 이벤트 등록 */
		fRegisterButtonClickEvent();
		

	});

	//검색시 엔터키 구동
	$(document).on('keydown', '#searchWord', function(e) {
		if (e.keyCode == 13) {
			fListLecrm();
		}
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSaveLecrm':
				fSaveLecrm();
				break;
			case 'btnCloseLecrm':
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
		                        	      searchKey : 'lecrm_name'
		                        	     ,searchWord : ''		                        	    
		                               }
		            });

		//vm 이란 변수로 관리 해 줄 거야!
		vm = new Vue({
			//div 밑의 html 에서 저 부분 적힌거 찾아봐! div 도 들어올 수 있고 엘리먼트 (인풋 태그 하나같은거!)도 들어올 수 있어!
			//구역별로 뜯어서 관리하겠다는 의도야!
			el : '#divLecrmList',
			//components 는 뷰js 에서 사용할 수 있는 API 같은거라고 생각하면 돼!
			components : {
				//common폴더 안에 common_include 들어가면  저 부트스트랩 쓸거라는 걸 알 수 있어!
				//src=//-> 인터넷에서 가져오는 것 //는 www와 같다
				//<script>="text/javascript" src="//rawgit.com/wenzhixin/vue-bootstrap-table/develop/docs/static/dist/vue-bootstrap-table.js">

				'bootstrap-table' : BootstrapTable
			},
			//data div 안에서 이  밑에 것들을 써먹겠다 . 변수이다. 여기서 선언했어! item 은 배열 변수 loginid 는 문자열 변수
			data : {
				items : [],
				lecrm_id : ''
			},
			//div 안에서 관리할 메소드 
			//rowClicked라는 메소드를 만들었어!
			methods : {
				//해당 줄을 클릭했을때 함수  변수 이름이 row . 받아 올때 row 에서 받아오겠다!
				//rowClicked는 함수 이름 / row는 변수 이름
				
				
				LEquiplist : function(lecrm_id) {
						
					console.log(lecrm_id);
					fListEquip(lecrm_id);
						
				},
				
				
				lecrmmod : function(lecrm_id) {
					fLecrmsel(lecrm_id);
				},
				lecrmdel : function(lecrm_id) {
					confirmter(lecrm_id);
				}
			}
		});

		cvm = new Vue({
			el : '#layer1',
			
			data : {
				lecrm_id : '',
				lecrm_name : '',
				lecrm_size : '',
				lecrm_snum : '',
				lecrm_note : ''

			}
		});

		evm = new Vue({
			el : '#divEquipList',
			 components : {
				'bootstrap-table' : BootstrapTable
			}, 
			data : {
				items : [],
				equ_id : ''
			},
			method : {
		
			}

		});

	}

	//강의실 리스트 조회
	function fListLecrm(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage + " svm.searchKey : " + svm.searchKey + " svm.searchWord : " + svm.searchWord);


		//alert("지금 현재 페이지를 찍어봅시다. " + currentPage); 
		//여기서 currentPage,pageSize 다 나온다
		//alert(" svm.searchWord : " + svm.searchWord );

		var param = {
			//이름 (가방)  : 값(안에 있는 물건)
			currentPage : currentPage
			//위에서 정의해줬다 var PageSizeEquip = 5;
			,
			pageSize : pageSizeLecrm,
			searchKey : svm.searchKey,
			searchWord : svm.searchWord

		}

		/* pageSizeEquip로 뜬다
		alert("지금 현재 페이지를 찍어봅시다. " + pageSizeEquip); 
		 */
		//resultCallback이란 이름의 함수를 생성 이 함수는 fListequipResult안에 data, currentPage를 받아와!
		var resultCallback = function(data) {
			fListLecrmResult(data, currentPage);
		};

		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/adm/listLecrm.do", "post", "json", true, param, resultCallback);
	}

	/* 강의실 리스트  data 목록에 뿌리기!	 */
	/*강의실 조회 콜백 함수*/
	function fListLecrmResult(data, currentPage) {


		//alert(data);
		console.log(data);
		//받아온 데이터가 vm.item에 들어가도록 해줘! 
		vm.items = [];
		vm.items = data.listLecrm;

		//evm.items = [];

		// 총 개수 추출
		// ("totalcnt", totalCount)-> 서비스 다오에서 받아온 totalCount 데이터를 totalcnt 라는 이름으로 jsp 에서 쓸거야!!
		var totalCntLecrm = data.totalCount;
		// alert("totalcnt 찍어봄!! " + totalCntEquip);
		var paginationHtml = getPaginationHtml(currentPage, totalCntLecrm,pageSizeLecrm, pageBlockSizeLecrm, 'fListLecrm');

		// 페이지 네이게이션
		console.log("paginationHtml : " + paginationHtml);
		//#EquipPagination 저 장소에 데이터를 일단 비웠다가 붙여줘.  paginationHtml값 받아온것들 있지?
		$("#LecrmPagination").empty().append(paginationHtml);
		$("#currentPageLecrm").val(currentPage);

	}

	/** 장비 조회 */
	function fListEquip(lecrm_id,currentPage) {

		$('#divEquipList').show();
		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage + " lecrm_id : " + lecrm_id);

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeEquip,
			lecrm_id : lecrm_id
		}

		
		var resultCallback = function(data) {
			flistEquipResult(data, currentPage);
		};
		//Ajax실행 방식
		callAjax("/adm/listeEquip.do", "post", "json", true, param,
				resultCallback);
	}

	/** 장비 조회 콜백 함수 */
	function flistEquipResult(data, currentPage) {

		//alert(data);
		console.log("data : " + JSON.stringify(data));
		console.log("data.listEquip : " + JSON.stringify(data.listEquip));

		evm.items = [];
		evm.items = data.listEquip;

		// 총 개수 추출
		var totalCntEquip = data.totalCount;

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntEquip,
				pageSizeEquip, pageBlockSizeEquip, 'fListEquip');

		console.log("paginationHtml : " + paginationHtml);

		//alert(paginationHtml);
		$("#EquipPagination").empty().append(paginationHtml);

		$("#delCourseno").val(data.no);

	}

	/** 강의실 폼 초기화 */

	function fInitFormLecrm(object) {
		$("#lecrm_id").focus();

		if (object == "" || object == null || object == undefined) {
			cvm.lecrm_id = "";
			cvm.lecrm_name = "";
			cvm.lecrm_size = "";
			cvm.lecrm_snum = "";
			cvm.lecrm_note = "";

			$("#lecrm_name").prop("readonly", false);
			$("#lecrm_id").css("background", "#FFFFFF");
			$("#lecrm_id").focus();
			$("#btnDeleteCourse").hide();

			$("#delLecrmno").val("");
			//$("#Coursestudent").val("");
			$("#action").val("I");

		} else {
			cvm.lecrm_id = object.lecrm_id;
			cvm.lecrm_name = object.lecrm_name;
			cvm.lecrm_size = object.lecrm_size;
			cvm.lecrm_snum = object.lecrm_snum;
			cvm.lecrm_note = object.lecrm_note;

			$("#lecrm_name").prop("readonly", true);
			$("#lecrm_id").css("background", "#FFFFFF");
			$("#lecrm_id").focus();
			$("#btnDeleteCourse").show();

			$("#delLecrmno").val(object.equ_id);
			//$("#Coursestudent").val(object.equ_id);

			$("#action").val("U");

		}
		// 모달 팝업
		gfModalPop("#layer1");
	}

	function fPopModalLecrm() {
		fInitFormLecrm();
	}

	/** 강의실 등록 */
	function fSaveLecrm() {

		// vaildation 체크
		//과정 저장 fValidateEquip이 아니라면 ?
		if (!fValidateLecrm()) {
			return;
		}

		console.log("lecrm_id : " + cvm.lecrm_id);
		/* console.log("lecrm_id : " + cvm.equ_id); */
		console.log("lecrm_name : " + cvm.lecrm_name);
		console.log("lecrm_size : " + cvm.lecrm_size);
		console.log("lecrm_snum : " + cvm.lecrm_snum);
		console.log("lecrm_note : " + cvm.lecrm_note);

		console.log("action : " + $("#action").val());

		var param = {
			//이름 (가방)  : 값(안에 있는 물건)
			lecrm_id : cvm.lecrm_id
			/* 	,	lecrm_id : cvm.lecrm_id */
			,
			lecrm_name : cvm.lecrm_name,
			lecrm_size : cvm.lecrm_size,
			lecrm_snum : cvm.lecrm_snum,
			lecrm_note : cvm.lecrm_note,
			action : $("#action").val()
		}

		var resultCallback = function(data) {
			fSaveLecrmResult(data);
		};

		callAjax("/adm/saveLecrm.do", "post", "json", true, param,
				resultCallback);
	}

	/** 강의실 등록 validation */
	function fValidateLecrm() {

		var chk = checkNotEmpty([ 
		                          [ "lecrm_id", "강의실ID" ],
								  [ "lecrm_name", "강의실명을 입력하세요" ],
								  
                                 
		]);

		if (!chk) {
			return;
		}

		return true;
	}

	
	
	//강의 삭제 확인창
	   function confirmter(lecrm_id) {
	      if(confirm("삭제하시겠습니까?")){
	    	  fLecrmdel(lecrm_id);
	      }else{
	         return false;
	      }
	   }
	

	
	
	
	
	/** 강의실 삭제 */
	function fLecrmdel(lecrm_id) {

		
		
		var param = {
			lecrm_id : lecrm_id
		}

		var resultCallback = function(data) {
			fSaveLecrmResult(data);
		};
		//Ajax실행 방식
		callAjax("/adm/Lecrmdel.do", "post", "json", true, param,
				resultCallback);
	}

	/** 강의실 한건  조회 */
	function fLecrmsel(lecrm_id) {

		console.log("fLecrmsel  lecrm_id : " + lecrm_id);

		var param = {
			lecrm_id : lecrm_id
		}

		var resultCallback = function(data) {
			fLecrmselResult(data);
		};

 		
		
		//Ajax실행 방식
		callAjax("/adm/Lecrmsel.do", "post", "json", true, param,
				resultCallback);
	}

	/** 과정 한건  조회 콜백 함수 */
	function fLecrmselResult(data) {

		fInitFormLecrm(data.Lecrminfo);
	}

	/** 장비 삭제, 저장 콜백 함수 */
	//장비 메인 페이지로 돌아오기 위한 함수
	function fSaveLecrmResult(data) {

		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageLecrm").val();
		}

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 입력폼 초기화
			fInitFormLecrm();

			// 모달 닫기
			gfCloseModal();

			// 목록 조회
			fListLecrm(currentPage);

			//응답 오류 메세지가 뜨는 부분이다. 빈 입력 뒤에 저장을 눌렀을때 '장비명'이라 나오는 이유
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

	}
	
	
	$('#listLecrm td')
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
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">시설 관리</a> 
							<span class="btn_nav bold">강의실 정보</span> 
							<a href="javascript:location.reload();" class="btn_set refresh">새로고침</a>
						</p>
						<p class="search"></p>
						<p class="conTitle" id="searcharea">
							<span>강의실 관리</span> 
							<span class="fr"> 
							<span>강의실 명</span>
								<input type="text" id="searchWord" name="searchWord" v-model="searchWord" 
								placeholder="" style="height: 28px;">
								<a class="btnType blue" href="javascript:fListLecrm()"
								onkeydown="enterKey()" name="search">
								<span id="searchEnter">검색</span></a>
								<a class="btnType blue" href="javascript:fPopModalLecrm()" id="modal">
								<span>신규등록</span></a>
							</span>
						</p>
						<p class="serch" id="searcharea"></p>
						
						<div class="divLecrmList" id="divLecrmList">
							<table class="col">
								<thead>
									<th scope="col" colspan="6">강의실 목록</th>
								</thead>
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="35%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
								</colgroup>

								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">강의실 명</th>
										<th scope="col">크기</th>
										<th scope="col">자리수</th>
										<th scope="col">비고</th>
										<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody id="listLecrm">
									<template v-for="(row,index) in items" v-if="items.length">
									<tr>
										<td>{{index + 1}}</td>
										<td class="cursorArea"><a @click="LEquiplist(row.lecrm_id)"><strong>{{row.lecrm_name}}</strong></a></td>
										<td>{{row.lecrm_size}}</td>
										<td>
											<c:if test="{{row.lecrm_snum}} eq 0">
												""
											</c:if>
											<c:if test="{{row.lecrm_snum}} ne 0">
												{{row.lecrm_snum}}
											</c:if>
										</td>
										<td>{{row.lecrm_note}}</td>
										<td align="center">
										    <table border=0>
										       <tr>
										          <p style="display: inline-block" class="btnType3 color1" @click="lecrmmod(row.lecrm_id)"><a class="btnType3 color1"><span id="searchEnter" class="cursorArea">수정</span></a></p>
										          <p style="display: inline-block; margin-left:5px;" class="btnType3 color1" @click="lecrmdel(row.lecrm_id)"><a class="btnType3 color1"><span id="searchEnter" class="cursorArea">삭제</span></a></p>
										       </tr>
										    </table>
										</td>
									</tr>
									</template>
								</tbody>
							</table>
							<div class="paging_area" id="LecrmPagination"></div>
						</div>
						
					</div> 
					 <!-- 장비내역 -->
					<div class="divEquipList" id="divEquipList">
						<table class="col">
							<thead>
								<tr>
									<th scope="col" colspan="4">강의실 장비리스트</th>
								</tr>
							</thead>
							<caption>caption</caption>
							<colgroup>
								<col width="20%">
								<col width="50%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">장비명</th>
									<th scope="col">갯수</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody id="listEquip">
								<template v-for="(row,index) in items" v-if="items.length">
								<tr>
									<td>{{index + 1}}</td>
									<td>{{row.equ_name}}</td>
									<td>{{row.equ_num}}</td>
									<td>{{row.equ_note}}</td>
								</tr>
								</template>
							</tbody>
						</table>
						<div class="paging_area" id="LecrmPagination"></div> 
					</div> 
					
					
					<!--// content -->
					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
<form id="myForm" action="" method="">
			<input type="hidden" name="action" id="action" value=""> 
			<input type="hidden" name="currentPageLecrm" id="currentPageLecrm" value="">
			<input type="hidden" name="delLecrmno" id="delLecrmno" value="">
	<!--  모달 팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">

			<dl>
				<dt>
					<strong>강의실 등록</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>


						<tbody>
							<tr>
								<th scope="row">강의실명<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									v-model="lecrm_name" name="lecrm_name" id="lecrm_name" readonly="bVal"/></td>
								<th scope="row">자리수</th>
								<td><input type="number" class="inputTxt p100"
									v-model="lecrm_snum" name="lecrm_snum" id="lecrm_snum" /></td>
							<tr>
								<th scope="row">크기</th>
								<td><input type="text" class="inputTxt p100"
									name="lecrm_size" id="lecrm_size" v-model="lecrm_size" /></td>
								<th scope="row">비고</th>
								<td><input type="text" class="inputTxt p100"
									name="lecrm_note" id="lecrm_note" v-model="lecrm_note" /></td>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveLecrm" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnCloseLecrm" name="btn"><span>취소</span></a>

					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		
	</div>
	<!--// 모달팝업 -->

</form>

</body>
</html>