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
	$('#mainBtn').click(()=>{
		changeView("${pageContext.request.contextPath}/")
	})
}
$(init);
</script>

<body>
<div class='container'>
<%@ include file="../include/header.jsp"%>          

	<div class='row'>
		<h4>| 결제 완료</h4><hr>
	</div>
		<div class='row' style="height:50px"></div>
		<div class='row d-flex justify-content-center' style="height:30px"><p>결제가 완료되었습니다.</p> </div>
		<div class='row d-flex justify-content-center'>
			<button type="button" class="btn btn-outline-secondary" 
			 id='mainBtn'>메인 화면으로</button>
		</div>
</div>



<%@ include file="../include/footer.jsp"%>

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
				<button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
				<button type='button' class='btn btn-primary' id='okBtn'>예</button>
			</div>
		</div>
	</div>
</div>  
</body>
</html>