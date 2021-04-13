<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../include/lib.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<title>THEJOEUN ShoppingMall</title>
<script>
var IMP = window.IMP; // 생략가능
IMP.init('imp36655846'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
let price = "";
let deliveryFee = 2500;
let deliveryState ="배송 대기중";
let amount = 0;
let totalPrice = 0;
let userName = "";
let contact = "";
let postcode = "";
let address = "";
let email = "";
let chkPay = 0;
function changeView(address){
	window.location.href=address;
}

function searchAddr(){
	 new daum.Postcode({
	        oncomplete: function(data) {
	        	$('#postcode').val(data.zonecode); 
				$('#address').val(data.address);
				$('#addressDetail').val(data.buildingName);
       }
   }).open();
	
	 $('#address2').attr('disabled',false);
}
function getInfo(){
	$.ajax({
		type:'post',
		url:'<%=request.getContextPath() %>/purchase/getPurType'
	})
	.done(result => {
		if(result == 1){
			$.ajax({
				type:'post',
				url:'<%=request.getContextPath() %>/purchase/getPurAmount'
			}).done(purchaseAmount => {
				$.ajax({
					url:'<%=request.getContextPath() %>/cloth/clothDetail/find'
				})
				.done(cloth => {
					amount = purchaseAmount;
					price = cloth.price * purchaseAmount;
					let purchaseList = [];
					purchaseList.push(
							`<tr>
								<th>
									<p>\${cloth.clothName} [ \${cloth.color} : \${cloth.clothSize} ]</p>
								</th>
								<td>
									<p>\${purchaseAmount}</p>
								</td>	
								<td>\${price}</td>							
							</tr>`
						);
					$('#purchaseList').append(purchaseList.join(''));
					getTotalPrice();
				});
			});
		} else {
			console.log('cart에서 구매');
		}
	});
}
function getTotalPrice(){
	totalPrice = price + deliveryFee;
	$('#summaryPurchase').append(
		`
		<tr>
			<td>
				<div class='row d-flex justify-content-end'>
					<h5><b>상품 금액 : \${price} 원</b></h5> 
				</div>
				<div class='row d-flex justify-content-end'>
					<h5><b>배송비 : \${deliveryFee} 원</b></h5> 
				</div>
				<div class='row d-flex justify-content-end'>
					<h5><b>최종 결제 금액 : \${totalPrice} 원</b></h5> 
				</div>
			</td>
		</tr>
		`		
	);
}
function pay(){
	IMP.request_pay({
	    pg : 'html5_inicis.더조은쇼핑',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '옷 구매',
	    amount : 100,//totalPrice,
	    buyer_email : email,
	    buyer_name : userName,
	    buyer_tel : contact,
	    buyer_addr : address,
	    buyer_postcode : postcode
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        /*
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        */
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
		chkPay = 1;
	    $('#bodyMsg').text(msg);
	    $('#commonModal').modal();
	});
}

function getUserAddress(){
	$.ajax({
		method:'post',
		url:"<%=request.getContextPath() %>/user/userDetail"
	}).done(userData => {
		console.log('userData: '+userData.userName);
		$('#userName').val(userData.userName);
		$('#contact').val(userData.contact);
		$('#postcode').val(userData.postcode);
		$('#address').val(userData.address);
		$('#addressDetail').val(userData.addressDetail);
		email = userData.email;
		userName = userData.userName;
		contact = userData.contact;
		postcode = userData.postcode;
		address = userData.address +" "+ userData.addressDetail;
	});
}
function init(){
	getInfo();
	getUserAddress();
	$('#oldPlace').click(()=>{
		getUserAddress();
		$('[name = "deliveryDetail"]').attr('disabled', true);
	})
	$('#newPlace').click(()=>{
		$('#userName').val('');
		$('#contact').val('');
		$('#postcode').val('');
		$('#address').val('');
		$('#addressDetail').val('');
		$('[name = "deliveryDetail"]').attr('disabled', false);
	})
	
	$('#searchAddr').click(()=>{
		searchAddr();
	})
	
	$('#pay').click(()=>{
		var terms = $('#terms:checked').val();
		var chkName = $('#userName').val();
		var chkContact = $('#contact').val();
		var chkpostcode = $('#postcode').val();
		var chkaddr = $('#address').val();
		var chkaddrDetail = $('#addressDetail').val();
		if(terms){
			if(chkName){
				if(chkContact){
					if(chkpostcode){
						if(chkaddr){
							if(chkaddrDetail){
								//pay();
								$.ajax({
				type:'post',
				url:"<%=request.getContextPath() %>/purchase/insertInfo",
				data:JSON.stringify({
					price:totalPrice,
					deliveryFee:deliveryFee,
					deliveryState: deliveryState,
					purchaseAmount:amount
				}),
				contentType:'application/json'
			}).done(result=>{
				if(result != 0){
					console.log('테이블 작성 성공');
					//changeView("${pageContext.request.contextPath}/purchase/success");	
				} else {
					console.log('테이블 작성 실패');
				}
			})
							} else {
								$('#bodyMsg').text('상세 주소를 입력해주세요');
								$("#commonModal").modal();
							}
						}
					} else {
						$('#bodyMsg').text('배송지 주소를 입력해주세요');
						$("#commonModal").modal();
					}
				} else {
					$('#contact').focus();
				}
			} else {
				$('#userName').focus();
			}
			
		} else {
			$('#bodyMsg').text('약관에 동의해주세요');
			$("#commonModal").modal();
		}
	})
	
	$('#okBtn').click(()=>{
		if(chkPay == 1){
			chkPay = 0;
			
			/*
			$.ajax({
				type:'post',
				url:"<%=request.getContextPath() %>/purchase/insertInfo",
				data:JSON.stringify({
					price:totalPrice,
					deliveryFee:deliveryFee,
					deliveryState: deliveryState,
					purchaseAmount:amount
				}),
				contentType:'application/json'
			}).done(result=>{
				if(result != 0){
					console.log('테이블 작성 성공');
					//changeView("${pageContext.request.contextPath}/purchase/success");	
				} else {
					console.log('테이블 작성 실패');
				}
			})
			*/
		}
		$('#commonModal').modal('hide');
	})
}
$(init);

</script>
<style>
th{
	min-width:50px;
}
</style>

<body>
<div class='container'>
<%@ include file="../include/header.jsp" %>

		<div class='row'>
			<h5><b>| 결제 상품</b></h5>
		</div>
		<div class='row'>
			<table class='table'>
				<thead>
					<tr><th>옷 정보</th><th>수량</th><th>금액</th></tr>
				</thead>
				<tbody id='purchaseList'>
				</tbody>
			</table>
		</div>
		<div class='row'>
				<h5><b>| 배송지 입력</b></h5>
				<table class="table">
					<tr>
						<th>배송지</th>
						<td><input type='radio' name='address' value='existing' id='oldPlace' checked><label>기본주소</label> &nbsp;
							<input type='radio' name='address' value='new' id='newPlace'><label>신규 배송주소</label> </td>
					</tr>
					<tr>
						<th>수령인</th>
						<td><input type='text' name='deliveryDetail' id='userName'disabled>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type='number' name='deliveryDetail' id='contact' disabled>
						</td>
					</tr>
					<tr style="height:200px">
						<th>주소</th>
						<td>
							<div class='row'>
								<input type='number' id='postcode' disabled> &nbsp;
								<button type='button'name='deliveryDetail' class='btn btn-outline-secondary' id='searchAddr' disabled>주소검색</button>
							</div>
							<div class='row'>
								<input type="text" style='width:300px' id='address'disabled />
									 
							</div>
							<div class='row'>
								<input type="text" name="deliveryDetail" style='width:300px' id='addressDetail' disabled/>
							</div>
						</td>
					</tr>
				</table>
		</div>
		<div class='row'>
			<h5><b>| 최종 결제금액 확인</b></h5>
			<table class="table">
				<tbody id='summaryPurchase'></tbody>
			</table>
		</div>
		<div class='row'>
			<div class ='col'>
				<input type='checkbox' id='terms'><label for="termsChk"> 약관에 동의하시겠습니까?</label>
				<button type='button' class='btn btn-outline-secondary ml-3'>약관보기</button>
			</div>
		</div>
		<div class='row d-flex justify-content-center mt-5'>
			<button type='button' class='btn btn-secondary' id='pay'>결제하기</button>
		</div>
		
		<div class='row' style='height:300px'></div>
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
					<button type='button' class='btn btn-outline-secondary' id='okBtn'>확인</button>
				</div>
			</div>
		</div>
	</div>  

<%@ include file='../include/footer.jsp' %>

	
</body>
</html>