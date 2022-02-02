<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이동 성공</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script>

$(document).ready(function(){
	
	$( function() { $( "#test_start" ).datepicker({dateFormat:"yymmdd"}); }).val();	
	$( function() { $( "#test_end" ).datepicker({dateFormat:"yymmdd"}); }).val();	
});

	function search() {
		var tb = document.getElementById("select");
		var tbIndex = document.getElementById("select").options.selectedIndex;
		var selval = tb.options[tbIndex].value;
		var SendId = document.getElementById('send_lecId');
		var test = document.getElementById('test_name');
		var result = "";		
		 $.ajax({ 
			 url :'getLecId'
			,type : 'post'
			,async : false
			,dataType : 'json'
			,data : {'lec_name':selval}
			,success: function(data){
				result = data;
				console.log("성공"); 
				SendId.value = result;	
			} 
			});
		 
		 		
		 		
				var data = {'lec_id':result};
				$.ajax({
					method : 'get'
					,url : 'listTest'
					,data : data
					,success : function(resp){ 
							var d = "<table border='1'>"
					          d += "<tr>";
					          d += "<th>시험이름</th>";
					          d += "<th>시작일자</th>";
					          d += "<th>마감일자</th>";
					        //  d += "<th>응시현황</th>";
					          d += "</tr>";
							$.each(resp,function(index,item){
								d+= "<tr>"+"<td>"+'<a href="examRegist?test_id='+item.test_id+'">'+item.test_name+'</a>'+"</td>";
								d+= "<td>"+item.test_start+"</td>";
								//d+= "<td>"+item.test_end+"</td>";
								d+= "<td>"+item.test_end+"</td>"+"</tr>";
							})
							d += "</table>";
							$("#wrapper").html(d);
						}
				})  
	}
	
	
	 function SendInfo(){
    $.ajax({
        url : "testEnroll",
        type : "get",
        data : $('#form1').serialize(),
        success : function(data) {
           console.log("모달성공");
        },
        error : function() {
           alert("[ 시험 등록 에러 ]");
        }
     });
	}
	 
</script>
</head>
<body>
<form name="frm">
			<a>${lec_id}</a>
			<a href="test">테스트트</a>
          <table border="1">
              <tr>
              </tr>
              <tr>
                   <td><select id="select" name="select" size="1">
                    		 <option value="none">과정선택</option>
                             <option value="java">자바 웹개발자</option>
                             <option value="자바의이해">자바의이해</option>
                  	   </select></td>
                   <td>
                   <input type="button" name="button" value="검색" onclick="search()">
                   </td>
              </tr>
              <tr>
                   </tr>
          </table>
       </form>      
          <a href="#ex1" rel="modal:open"><button type="button">시험 등록</button></a>
          <div id="ex1" class="modal">
            <form id="form1">
            	<input type="hidden" id="send_lecId" name="lec_id" value="">
  				<input type="text" id="test_name" name ="test_name" placeholder="시험명" /><br>
  				<input type="text" id="test_sort" name="test_sort" placeholder="분류" /><br>
  				<!-- <input type="text" id="test_start" name="test_start" placeholder="시작일" /><br> -->
  				<input type="text" id="test_start" name="test_start"  class="inputTxt p100"><br>
  				<input type="text" id="test_end" name="test_end"  class="inputTxt p100"><br>
  				<button type="button" id="enroll">완료</button>
  				<a href="javascript:SendInfo();" class="btnType blue" id="RegisterCom" name="btn"> <span>등록 완료</span></a>
  				<a href="#" rel="modal:close"><button type="button">닫기</button></a>
  				<br><br><br>
  			</form>
		</div>
 			<div id="wrapper">
          </div>
        	
         
</body>
</html>