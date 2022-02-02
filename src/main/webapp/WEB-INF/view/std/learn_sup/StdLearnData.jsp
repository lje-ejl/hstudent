<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>학습자료</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	// 강의목록 페이징 설정

	var currentPage;
	//var pageSizeLec = 10;

	// 그룹코드 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;


	/** OnLoad event */
	$(document).ready(function() {

		// 학습자료목록 조회
		fListData();

		//init();
	});
	
	/** 학습자료목록 조회 */
	function fListData(currentPage) {
		
		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
		}

		var resultCallback = function(data) {
			fListDataResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		// json으로 보내서 오류가 났음 , -> text
		callAjax("/std/selectDataList.do", "post", "text", true, param,resultCallback);
	}

	/** 강의 조회 콜백 함수 */
	function fListDataResult(data, currentPage) {

		// 기존 목록 삭제
		$("#learnData").empty();
		//$('#listLec').find("tr").remove() 

		var $data = $($(data).html());

		// 신규 목록 생성
		var $learnData = $data.find("#learnData");
		$("#learnData").append($learnData.children());

		// 총 개수 추출
		var $dataCount = $data.find("#dataCount");
		var dataCount = $dataCount.text();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, dataCount,
				pageSize, pageBlockSize, "fListData");
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#dataPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);

	}

	function fPopModalLearn( learn_data_id ) {
		
		var param = {
				learn_data_id : learn_data_id
				}
   
		var resultCallback = function(data) {
         
			$('#layer1').empty().append(data);
			gfModalPop("#layer1");
			
		};
		callAjax("/std/detailData.do", "post", "text", true, param, resultCallback);
		
	}

	function fDataDownload(learn_url,learn_fname) {
		
		alert(learn_url + "     주소    이름        " + learn_fname);
		var params = "";
		params += "<input type='hidden' name='learn_url' value='"+ learn_url +"' />";
		params += "<input type='hidden' name='learn_fname' value='"+ learn_fname +"' />";
		jQuery("<form action='/std/dataDownload.do' method='post'>" + params+ "</form>").appendTo('body').submit().remove();

	}
   
/*   
   function fApplyLec(lec_id){
	
	   var param = {
    		   lec_id : lec_id
           }
	   
	   var resultCallback = function(data) {
		   fResultLec(data);
	   
	   }
	   callAjax("/std/applyLecture.do", "post", "json", true, param, resultCallback);
   }
   
   
 
   
   function fResultLec(data){
	   
	   if (data.result == "SUCCESS") {
			
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
   
  */
	
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
							<span class="btn_nav bold">학습자료</span>
							<a href="" class="btn_set refresh">새로고침</a>
						</p>
					<!-- 검색 시작 -->
						
						<p class="conTitle" id="searcharea">
							<span>${myLecture.lec_name} 학습 자료</span> 
							
						</p>
							
					<!-- 검색 끝  -->
							
									<!--div 영역 -->
								<table class="col2 mb10">
												<thead>
													<tr>
														<th scope="col">등록번호</th>
														<th scope="col">제목</th>
														<th scope="col">등록일자</th>
													</tr>
												</thead>
												<tbody id="learnData">
												</tbody>
								</table>
									
									
									 <!-- div 영역 끝 -->
									
										<div class="paging_area"  id="dataPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<!-- 모달팝업 -->
	
	<div id="layer1" class="layerPop layerType2" style="width: 650px;">
    
     </div>
	
		<!--// 모달팝업 -->
</form>

</body>
</html>