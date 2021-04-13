<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>

<script>
let questionNum = getParameter('questionNo');
let sessionId = "";
function changeView(address){
	window.location.href=address;
}
function getParameter(key){
	let queryString = window.location.search;
	queryString = queryString.replace('?','');
	let queryArr = queryString.split('&');
	
	let searchResult = '';
	let resultArr = '';
	for(let i = 0; i < queryArr.length; i++){
		resultArr = queryArr[i].split('=');
		if(resultArr[0] == key){
			searchResult = resultArr[1];
		}
	}
	return searchResult
}
function isVal(field){
	let check = false;
	let fieldName;
	
	if(field.length)
		if(field.val()) check = true;
	return check;
}

function getDetail(){
	$('#fixBtn').hide();
	$('#delBtn').hide();
	
	var question = [];
	$('#questionContent').empty();
	$.ajax({
		type:'post',
		url: '<%=request.getContextPath() %>/question/getId',
	}).done(id => {
		console.log('getId : '+id);
		sessionId = id;
	})
	
	$.ajax({
		type:'post',
		url: '<%=request.getContextPath() %>/question/find',
		data: JSON.stringify({
			questionNum: questionNum
		}), 
		contentType: 'application/json'
	}).done(question => {
		if(question != null){
			let questionDetail= []; 
			questionDetail.unshift(
				`<tr>
                  	<td><label for='title'><b>제목</b></label></td>
                  	<td id='title'>\${question.title}</td>
                  </tr>
                  <tr>
                  	<td><label for='userId'><b>작성자</b></label></td>
                  	<td id='userId'>\${question.userId}</td>
                  </tr>
                  <tr>
                  	<td><label for='regDate'><b>작성일자</b></label></td>
                  	<td id='regDate'>\${question.regDate}</td>
                  </tr>
                  <tr>
                 	 <td><label for='content'><b>문의 내용</b></label></td>
                 	 <td id='content'>\${question.content}</td>	
				 </tr>`
			);
			$('#detail').append(questionDetail.join(''));
			if(question.userId == sessionId){
				$('#fixBtn').show();
				$('#delBtn').show();
			}
		} else {
			$('#detail').append('<tr><td colspan=4 class=text-center>등록된 상품 문의가 없습니다.</td></tr>');			
		}
	});
}

function init(){
	getDetail();
	
	
	$('#delBtn').click(() => {
		$('#delQuestionModal').modal();
	});
	
	$('#fixBtn').click(()=>{
		console.log(questionNum);
		changeView(`<%=request.getContextPath() %>/question/fix?questionNo=\${questionNum}`);
	})
	$('#okBtn').click(()=> {
		$('#delQuestionModal').modal('hide');
		$.ajax({
			url:`${pageContext.request.contextPath}/question/del/\${questionNum}`,
			method: 'post'
		}).done(result => {
			if(result != null){
				changeView(`<%=request.getContextPath() %>/question/list`);				
			}
		});
	})
}
$(init);
</script>	
<style>
#subMenu {
	min-width: 120px;
}
</style>
<div class='container'>
	<%@ include file="../include/header.jsp" %>

   <div class='row'>
		<div class='col-3'>
			<table class='table table-bordered'>
	            <thead class='thead-light text-center'>
	               <tr>
	                  <th colspan='3'>고객센터</th>
	               </tr>
	            </thead>
	            <tbody class='text-center'>
	               <tr>
	                  <td><a href = "#">공지사항</a></td>
	               </tr>
	               <tr>
	                  <td><a href = "#">FAQ<br>(자주하는 질문)</a></td>
	               </tr>
	               <tr>
						<td><a href = "<%=request.getContextPath() %>/question/list"><b>상품 문의</b></a></td>
	               </tr>
	            </tbody>
	         </table>
		</div>

		<div class='col-9'>
		   <div class='row'>
		      <div class='col'>
		         <h5><b>| 상품 문의</b></h5>
		      </div>
		   </div> 		
			<form>
	            <table class='table'>
	               <tbody id='detail'>
	               </tbody>
	            </table>
	       		<nav>
					<button type='button' class='btn btn-secondary float-right' id='fixBtn'>수정</button>
					<button type='button' class='btn btn-secondary float-right mr-1' id='delBtn'>삭제</button>
	       		</nav>
    	  	</form>
       </div>
	</div>
</div>
<div id='delQuestionModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>			
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body'>
				<p>삭제하시겠습니까?</p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
				<button type='button' class='btn btn-secondary' id='okBtn'>예</button>
			</div>
		</div>
	</div>
</div>
<div id='commonModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>			
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body'>
				<p id='bodyMsg'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal'>예</button>
			</div>
		</div>
	</div>
</div>
<div class='row' style='height:200px'></div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>      