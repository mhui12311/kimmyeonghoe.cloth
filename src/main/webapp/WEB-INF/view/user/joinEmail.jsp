
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>

<title>THEJOEUN ShoppingMall</title>

<script>

function activateBtn(){
	$('#sendMail').prop('disabled',false);
}

function changeView(address){
	window.location.href=address;
	}

function init(){
	$('#sendMail').click(()=>{
		$('#sendMail').text('인증메일 재발송');
		$('#sendMail').prop('disabled', true);
		var valicode = $('#verificationCode').val();
		$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/joinEmail",
			data:JSON.stringify({
				subject:'회원가입 인증메일 입니다.',
				phase:'1'
			}),
			contentType:'application/json'
		}).done(result =>{
			$('#msg').text('인증메일을 발송했습니다.');
			$('#noBtn').hide();
			$('#commonModal').modal();
			
		}).fail(err =>{
			$('#msg').text('메일 발송에 실패했습니다. 메일주소를 확인해주세요.');
			$('#noBtn').hide();
			$('#commonModal').modal();
		})
		setTimeout(activateBtn, 180000);
	});
    
    $('#checkValid').click(()=>{
    	var valicode = $('#verificationCode').val();
    	$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/compareCode",
			data:JSON.stringify({
				code:valicode
			}),
			contentType:'application/json'
		}).done(result => {
			if(result != ""){
				changeView("${pageContext.request.contextPath}/user/joinSuccess");
			} else {
				changeView("${pageContext.request.contextPath}/user/joinFail");
			}
		})
    });
    
    $('#okBtn').click(()=>{
    	$('#commonModal').modal('hide');
    	$('#noBtn').hide();
    })
    $('#goBack').click(()=>{
    	changeView("${pageContext.request.contextPath}/user/join");
    })
    
}
$(init);
</script>

<body>
<div class='container'>
	<%@ include file="../include/header.jsp" %>
		<div class='row' style='height:30px'></div>
		<h4>이메일 인증</h4><hr>
		<div class='row' style='height:50px'></div>
		<p class='joinNav d-flex justify-content-center'><span class='joinProcess'>정보입력</span>><span class='joinProcess'><strong>이메일 인증</strong></span>><span class='joinProcess'>가입 완료</span></p>
	
	<div class="row d-flex justify-content-center">
		<div class='row m-3'>
			<label for='email' class='form-label' style="width:70px">인증번호: </label>
			<div class='col' style="width:300px">
				<input type='email' class='form-control' id='verificationCode' name='verificationCode' value=''required/>
			</div>
			<div class='col-3' style="width:180px">
				<button type='button' class='btn btn-outline-secondary' style='width:150px' id='sendMail'>인증메일 발송</button>
			</div>	
		</div>
	</div>
	<div class="row d-flex justify-content-center" style='height:200px'>
			<button type="button" class="btn btn-outline-secondary m-5" style="width:120px; height:50px;" id="goBack">이전</button>
			<button type="button" class="btn btn-outline-secondary m-5" style="width:120px; height:50px;" id="checkValid">확인</button>
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
					<p id='msg'></p>
				</div>
				<div class='modal-footer'>
					<button type='button' class='btn btn-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
					<button type='button' class='btn btn-outline-secondary' id='okBtn'>확인</button>
				</div>
			</div>
		</div>
	</div>  
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>
