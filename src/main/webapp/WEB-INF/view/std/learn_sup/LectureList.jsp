<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>강의목록</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	// 강의목록 페이징 설정

	var currentPage;
	//var pageSizeLec = 10;

	// 그룹코드 페이징 설정
	var pageSizeLec = 10;
	var pageBlockSizeLec = 5;


	/** OnLoad event */
	$(document).ready(function() {

		// 강의목록 조회
		fListLec();

		/* enter = 13 */
		$(document).on('keydown', '#keyword', function(e) {
			if (e.keyCode == 13) {
				fListLec();
			}
		});
		
		//init();
	});

	
	
	
	/** 강의목록 조회 */
	function fListLec(currentPage) {
		var searchType = $("#searchType").val();
		var keyword = $("#keyword").val();

		
		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeLec,
			searchType : searchType,
			keyword : keyword
		}

		var resultCallback = function(data) {
			flistLecResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		// json으로 보내서 오류가 났음 , -> text
		callAjax("/std/selectLecList.do", "post", "text", true, param,resultCallback);
	}

	/** 강의 조회 콜백 함수 */
	function flistLecResult(data, currentPage) {

		//alert(data);
		console.log("gdgd" + data);

		// 기존 목록 삭제
		$('#listLecture').empty();
		//$('#listLec').find("tr").remove() 

		var $data = $($(data).html());

		// 신규 목록 생성
		var $listLecture = $data.find("#listLecture");
		$("#listLecture").append($listLecture.children());

		// 총 개수 추출
		var $totalCntLec = $data.find("#totalCntLec");
		var totalCntLec = $totalCntLec.text();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntLec,
				pageSizeLec, pageBlockSizeLec, 'fListLec');
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#lecPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageLec").val(currentPage);

	}

	
   function fPopModalLec( lec_id ) {
	   
       var param = {
    		   lec_id : lec_id
           }
       var resultCallback = function(data) {
         $('#layer1').empty().append(data);
         gfModalPop("#layer1");
       };
       callAjax("/std/detailLecList.do", "post", "text", true, param, resultCallback);
   }

   function fApplyLec(lec_id){
	
	   var param = {
    		   lec_id : lec_id
           }
	   
	   var resultCallback = function(data) {
		   fResultLec(data);
	   
	   }
	   callAjax("/std/applyLecture.do", "post", "json", true, param, resultCallback);
   }
   
   
   function fCancelLec(lec_id){
		
	   var param = {
    		   lec_id : lec_id
           }
	   
	   var resultCallback = function(data) {
		   fResultLec(data);
	   
	   }
	   callAjax("/std/cancelLecture.do", "post", "json", true, param, resultCallback);
   }
   
   
   function fResultLec(data){
	   
	   if (data.result == "수강신청이 완료되었습니다." || data.result == "수강취소가 완료되었습니다.") {
			
			// 모달 팝업
			gfCloseModal();
			alert(data.result);
			fListLec();
			
		} else {
			gfCloseModal();
			alert(data.result);
		}	
	   
   }
   //$("#applyBtn").hide();
   //$("#applyBtn").show();
   
   
	
</script>

<body>
<form>
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

				<li class="contents">
					<div class="content">
						<p class="Location">
							<a href="" class="btn_set home">메인으로</a> 
							<a href=""	class="btn_nav">학습지원</a> 
							<span class="btn_nav bold">강의목록</span>
							<a href="" class="btn_set refresh">새로고침</a>
						</p>
					<!-- 검색 시작 -->
						
						<p class="conTitle" id="searcharea">
							<span>강의 목록</span> 
							 <span class="fr"> 
								<select id="searchType" name="searchType" style="width: 80px;">
									<option value="name" id="option1" selected="selected">강사명</option>
									<option value="lec_name" id="option2">과목명</option>
								</select> 
								<input type="text" id="keyword" name="keyword" style="height: 28px;"> 
									<a class="btnType blue" href="javascript:fListLec()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span>
									</a>	
							</span>								 
						</p>
					<!-- 검색 끝  -->
							
									<!--div 영역 -->
								<table class="col2 mb10">
												<thead>
													<tr>
														<th scope="col">과목</th>
														<th scope="col">분류</th>
														<th scope="col">강사명</th>
														<th scope="col">강의시작일</th>
														<th scope="col">강의종료일</th>
														<th scope="col">신청인원</th>
														<th scope="col">정원</th>

													</tr>
												</thead>
												<tbody id="listLecture">
												</tbody>
											</table>
									
									
									 <!-- div 영역 끝 -->
									
										<div class="paging_area"  id="lecPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<!-- 모달팝업 -->
	
	<div id="layer1" class="layerPop layerType2" style="width: 800px;">
    
     </div>
	
		<!--// 모달팝업 -->
</form>

</body>
</html>