<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>

<script>

function init(){
	let addChk = 0;
	$('#addQuestionBtn').click(() => {
		var titleContent = $('#titleContent').val();
		var content = $('#content').val();
		if(titleContent && content){
			$.ajax({
				url: "<%=request.getContextPath() %>/question/add",
				method: 'post',
				contentType: 'application/json',
				data: JSON.stringify({
					title: titleContent,
					content: content
				}),
				success: result => {
					addChk = 1;
					$('#bodyMsg').text('문의가 등록되었습니다.')
					$('#commonModal').modal();
					//$('#addSuccessModal').modal();
					//location.href="${pageContext.request.contextPath}/question/list";					
				}
			});
		} else {
			$('#bodyMsg').text('제목과 문의내용을 입력해주세요')
			$('#commonModal').modal();
		}
	});
	
	$("#okBtn").click(()=> {
		$('#commonModal').modal('hide');
		if(addChk == 1) {
			addChk = 0;
			location.href="${pageContext.request.contextPath}/question/list";	
		}
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
			<div class='form-group row'>
	            <table class='table'>
	               <tbody id='addQuestion'>
	                  <tr>
	                  	<td><label for='title'><b>제목</b></label></td>
	                  	<td><input type='text' class='form-control' id='titleContent'></td>
	                  </tr>
	                  <tr>
	                  	<td><label for='userId'><b>작성자</b></label></td>
	                  	<td id='userId'>${userId}</td>
	                  </tr>
	                  <tr>
	                  	<td><label for='content'><b>문의 내용</b></label></td>
	                  	<td><textarea cols='38' rows='5' class='form-control' name='content' id='content'></textarea></td>
	                  </tr>
	               </tbody>
	            </table>
    		</div>
    		<div class='row d-flex justify-content-end'>
	           	<button type='button' class='btn btn-secondary float-right' id='addQuestionBtn'>등록</button>
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
				<p id='bodyMsg'>상품 문의가 등록되었습니다.</p>
			</div>
			<div class='modal-footer'>
				<button type='submit' class='btn btn-secondary' data-dismiss='modal' id='okBtn'>확인</button>
			</div>
		</div>
	</div>
</div>
<div class='row' style='height:200px'></div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>           