<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>

<script>
let questionNum = getParameter('questionNo');
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
	$.ajax({
		type:'post',
		url: '<%=request.getContextPath() %>/admin/question/find',
		data: JSON.stringify({
			questionNum: questionNum
		}), 
		contentType: 'application/json'
	}).done(question => {
		$('#title').text(question.title);
		$('#userId').text(question.userId);
		$('#regDate').text(question.regDate);
		$('#content').text(question.content);
		$('#answerContent').val(question.answerContent);
	});
}

function init(){
	getDetail();
	
	$('#answerBtn').click(()=>{
		$.ajax({
			type:'post',
			url: '<%=request.getContextPath() %>/admin/question/answer',
			data: JSON.stringify({
				questionNum: questionNum,
				answerContent: $('#answerContent').val()
			}), 
			contentType: 'application/json'
		}).done(result => {
			if(result != 0){
				$('#bodyMsg').text('답변을 성공적으로 마쳤습니다.');
				$('#commonModal').modal();
			}
		});
	})
	
	$('#okBtn').click(()=>{
		$('#commonModal').modal('hide');
		changeView('<%=request.getContextPath() %>/admin/question/list');
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
	<%@ include file="../../include/adminHeader.jsp" %>

   <div class='row'>
      <%@ include file="../../include/adminGnb.jsp" %>
		<div class='col-9'>
		   <div class='row'>
		      <div class='col'>
		         <h5><b>| 상품 문의</b></h5>
		      </div>
		   </div> 		
			<form>
	            <table class='table'>
	               <tbody id='questionContent'>
	                  <tr>
	                  	<td><label for='title'><b>제목</b></label></td>
	                  	<td><p id='title'></p></td>
	                  </tr>
	                  <tr>
	                  	<td><label for='userId'><b>작성자</b></label></td>
	                  	<td><p id='userId'></p></td>
	                  </tr>
	                  <tr>
	                  	<td><label for='regDate'><b>작성일자</b></label></td>
	                  	<td><p id='regDate'></p></td>
	                  </tr>
	                  <tr>
	                 	 <td><label for='content'><b>문의 내용</b></label></td>
	                 	 <td><p id='content'></p></td>
	                 </tr>
	                 <tr>
	                 	 <td><label for='content'><b>답변</b></label></td>
	                 	 <td><textarea cols='38' rows='5' id='answerContent'></textarea></td>
	                 </tr>
	               </tbody>
	            </table>
	       		<nav>
	       			<button type='button' class='btn btn-secondary float-right' id='answerBtn'>답변</button>
	       		</nav>
    	  	</form>
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
				<button type='button' class='btn btn-secondary' id='okBtn'>예</button>
			</div>
		</div>
	</div>
</div>
<div class='row' style='height:200px'></div>
	<%@ include file="../../include/footer.jsp" %>
</body>
</html>      