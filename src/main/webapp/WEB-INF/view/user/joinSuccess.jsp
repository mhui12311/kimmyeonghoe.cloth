<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>
<script>
function changeView(address){
	window.location.href=address;
	}
function init(){
	$('#goToMain').click(()=>{
 		changeView("${pageContext.request.contextPath}/");
	 })	
}
$(init);
</script>

<style>
</style>

<body>
<div class='container'>
	<%@ include file="../include/header.jsp" %>
	<div class='row' style='height:30px'></div>
		<h4>가입 완료</h4><hr>
		<div class='row' style='height:50px'></div>
	
		<div class='row' style='height:400px'>
			<div class='col'>
				<div class='row' style='height:30px'></div>
					<div class="mid">
						<div class='row' style='height:50px'></div>
						<div class='row d-flex justify-content-center'">
							<p>회원가입에 성공하셨습니다.</p>
						</div>
							
					</div>
					<div class='row d-flex justify-content-center'> 
						<button type="button" class="btn btn-outline-secondary m-5"  style='width:120px; height:50px;'  id="goToMain">메인으로 이동</button>
					</div>
		
			</div>
		
	</div>
	</div>
	<div id='commonModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<h5 class='modal-title'></h5>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<p></p>
				</div>
				<div class='modal-footer'>
					<button type='button' class='btn btn-outline-secondary' data-dismiss='modal'>아니오</button>
					<button type='button' class='btn btn-outline-secondary' id='okBtn'>예</button>
				</div>
			</div>
		</div>
	</div>  
	
	<%@ include file='../include/footer.jsp' %>
</body>
</html>