<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>
<script>
let processChkId = 0;
let emailChecked = 0;
let checkedId = 0;

function activateBtn(){
	$('#sendMail').prop('disabled',false);
}

function validateEmail(email){
	filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(filter.test(email)){
		return true;
	} else {
		return false;
	}
}

function changeView(address){
	window.location.href=address;
}

function init(){
    $('#idChk').click(()=>{
    	var userId = $('#userId').val();
		$.ajax({
			url:"${pageContext.request.contextPath}/user/idChk",
			data:{
				userId:userId
			}
		}).done(result => {
			if(result == userId){
				checkedId = 1;
				$('#bodyMsg').text('존재하는 회원입니다.');
				$('#commonModal').modal();	
				
			} else {
				$('#bodyMsg').text('아이디가 존재하지 않습니다.');
				$('#commonModal').modal();
				
			}
		});
    });
    
    $('#sendMail').click(()=>{
    	var email = $('#userEmail').val();
    	var userId = $('#userId').val();
		$('#sendMail').text('인증메일 재발송');
		$('#sendMail').prop('disabled', true);
		var valicode = $('#verificationCode').val();
		$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/findId",
			data:JSON.stringify({
				to:$('#userEmail').val(),
				userId: userId
			}),
			contentType:'application/json'
		}).done(result => {
			if(result != ""){
				$.ajax({
					type:'post',
					url:"${pageContext.request.contextPath}/user/sendMail",
					data:JSON.stringify({
						to:$('#userEmail').val(),
						subject:'비밀번호 찾기 인증메일 입니다.',
						textUp:`안녕하세요.<br>
								비밀번호 찾기를 위한 인증번호 입니다.<br>
								다음 인증 번호를 이메일 인증번호 란에 입력해주세요.<br>
								인증번호: 
								`,
						textDown:`<br>
								항상 더 좋은 서비스로 보답하는 더조은쇼핑이 되겠습니다.<br>
								감사합니다.
								`
					}),
					contentType:'application/json'
				}).done(result =>{
					$('#bodyMsg').text('인증메일을 발송했습니다.');
					$('#commonModal').modal();
					emailChecked = 1;
				}).fail(err =>{
					$('#bodyMsg').text('메일 발송에 실패했습니다. 메일주소를 확인해주세요.');
					$('#sendMail').text('인증메일 발송');
					activateBtn();
					$('#commonModal').modal();
				})
			} else{
				$('#bodyMsg').text('아이디와 저장된 이메일 주소와 다릅니다.');
				$('#sendMail').text('인증메일 발송');
				activateBtn();
    			$('#commonModal').modal();
			}
		})
		setTimeout(activateBtn, 180000);
	});
    
    $('#checkValid').click(()=>{
    	if(!$('#userEmail').val()){
    		$('#userEmail').focus();
    	} else if(checkedId == 1 && emailChecked == 1){
    		var valicode = $('#verificationCode').val();
    		//세션에 저장된 인증번호와 입력값 비교
    		$.ajax({
    			type:'post',
    			url:"${pageContext.request.contextPath}/user/compareCode",
    			data:JSON.stringify({
    				code:valicode
    			}),
    			contentType:'application/json'
    		}).done(result => {
    			if(result != ""){
    				processChkId = 1;
    				$('#bodyMsg').text('인증에 성공하셨습니다.');
            		$('#commonModal').modal();
            		emailChecked = 0;
            		checkedId = 0; 
    			} else {
    				$('#bodyMsg').text('인증번호가 올바르지 않습니다.');
           			$('#commonModal').modal();
    			}
    		})
    	} else if((checkedId == 0 && emailChecked == 1) || checkedId == 1 && emailChecked == 0){
    		$('#bodyMsg').text('아이디와 이메일을 확인해주세요.');
    		$('#commonModal').modal();
    	}
    	
    	else{
    		$('#bodyMsg').html("<p>올바르지 않은 접근방식입니다.<br>아이디와 이메일을 다시 입력하여 진행하세요.</p>");
    		$('#userId').val('');
    		$('#userEmail').val('');
    		$('#commonModal').modal();
    		
    	}
		
		
    })

    $('#okBtn').click(()=>{
    	if(processChkId == 1) {
    		$.ajax({
    			type:'post',
    			url:"${pageContext.request.contextPath}/user/changePw",
    			data:JSON.stringify({
    				userId: $('#userId').val()
    			}),
    			contentType:'application/json'
    		}).done(result => {
    			changeView("${pageContext.request.contextPath}/user/changePw");
    		})
    	}
    	$('#commonModal').modal('hide');
    })
    
    $('#goToLogin').click(()=>{
		changeView('${pageContext.request.contextPath}/user/login');
	})
}

$(init);
</script>

<style>
</style>

<body>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
		<h4>비밀번호 찾기</h4><hr>
		
	
	<div class="mid">
		<div class='row m-3' style="width:50vw">
			<label for='email' class='form-label' style="width:70px">아이디: </label>
			<div class='col' style="width:300px">
				<input type="text" id="userId" title="아이디" name="userId" class="form-control" value=""/> 
			</div>
			<div class='col-3' style="width:180px">
				<input type="button" value="아이디 조회" class="btn btn-outline-secondary" id="idChk" style="border:0.1em solid lightgray; margin-left:5px;"/>
				<div class="inputDeco">
		    		<span style="color:#a94442;" class="text-danger" id="id-danger"></span>
		    		<span title="아이디 검증결과" id="resultChkId"></span>
		    	</div>
			</div>
		</div>
		
		<div class='row m-3' style="width:50vw">
			<label for='email' class='form-label' style="width:70px">이메일: </label>
			<div class='col' style="width:300px">
				<input type='email' class='form-control' id='userEmail' name='userEmail' value=''/>
			</div>
			<div class='col-3' style="width:180px">
				<button type='button' class='btn btn-outline-secondary btn-block' id='sendMail' style="width:140px; height:50px;">인증번호 발송</button>
			</div>	
		</div>
		<div class='row m-3' style="width:50vw">
			<label for='verification code' class='form-label' style="width:70px" >인증번호: </label>
			<div class='col'>
				<input type='text' class='form-control' id='verificationCode' name='verificationCode' value=''/>
			</div>
			<div class='col-3'></div>
		</div>
			
	</div>
	<div class="midBottom">
			<button type="button" class="btn btn-outline-secondary m-5" style="width:120px; height:50px;" id="goToLogin">로그인 페이지</button>
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
					<p id='bodyMsg'></p>
				</div>
				<div class='modal-footer'>
					<button type='button' class='btn btn-outline-secondary' id='okBtn'>예</button>
				</div>
			</div>
		</div>
	</div>  

	
	<%@ include file='../include/footer.jsp' %>
</body>
</html>