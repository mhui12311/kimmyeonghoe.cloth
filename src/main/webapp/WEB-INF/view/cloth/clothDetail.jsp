<%@ page language='java' contentType='text/html; charset=utf-8'
	pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>
<%@ include file="../include/lib.jsp"%>
<script>
function changeView(address){
	window.location.href=address;
}
function findCloth() {
	$.ajax('find')
	.done(cloth => {
		console.log(cloth.clothName);
		$('#clothName').append(cloth.clothName);
		$('#price').append(cloth.price);
		$('#imageName').append(cloth.imageName);
		$('#content').append(cloth.content);
		$('#color').append(cloth.color);
		$('#clothSize').append(cloth.clothSize);
	});
}

function init() {
	findCloth();
	
	$('#plusBtn').click(() => {
		amount = $('input[name="quantity"]').val();
		$('input[name="quantity"]').val(parseInt(amount) + 1);
	})
	
	$('#minusBtn').click(() => {
		amount = $('input[name="quantity"]').val();
		if(parseInt(amount) > 1) {
			$('input[name="quantity"]').val(parseInt(amount) - 1);
		} else {
			$('input[name="quantity"]').val(1);
		}	
	});

	$('#purchaseBtn').click(()=>{
		$.ajax({
			type:'post',
			url:'<%=request.getContextPath() %>/purchase/detailPurchase',
			data:{
				purchaseAmount: $('#quantity').val()				
			}
		})
		.done(() => {
			changeView("<%=request.getContextPath() %>/purchase/insertInfo");
		});
	})
	$('#cart').click(()=>{
		$('.modal-title').text('장바구니');
		$('.modal-body').text('장바구니에 추가되었습니다.');
		$('#commonModal').modal();
		$('#noBtn').hide();
	});
	
	$('#okBtn').click(()=>{
		$('#commonModal').modal('hide');
	})
};

$(init);
</script>
<style>
[id*='ProductInfo'] {
	width: 150px;
	height: 100px;
	margin-top: 10px;
	margin-bottom: 5px;
	margin-left: 0;
	text-align: center;
}

.bold {
	font-weight: bold;
}

#Info {
	font-size: 12px;
}

[id*=productImg] {
	display: table;
	width: 100%;
	height: 100%;
	border: 1px solid lightgrey;
}

table {
	text-align: center;
}

#clothImage {
	width: 400px;
	height: 350px;
	border: 1px solid lightgrey;
}

.fileUpload {
	position: relative;
	overflow: hidden;
	margin: 10px;
}

.fileUpload input.upload {
	position: absolute;
	top: 0;
	right: 0;
	margin: 0;
	padding: 0;
	font-size: 20px;
	cursor: pointer;
	opacity: 0;
	filter: alpha(opacity = 0);
}
</style>
</head>
<body>
	<div class='container'>
		<%@ include file="../include/header.jsp"%>

		<div class='row form-group'>
			<div class='col-7'>
				<div class='row' id='clothImage'>
					<div class='col'>
						<div class='row' style="height: 150px"></div>
						<div class='row d-flex justify-content-center'>
							<p>옷 이미지</p><br>
						</div>
					</div>
				</div>
				<div class='row'>
					<div class='col'></div>
				</div>
			</div>
			<div class='col-5 mt-5'>
				<div class='row mt-3'>
					<h2><span id='clothName'></span></h2>
				</div>
				<div class='row mt-3'>
					<span id='price'></span>원
				</div>
				<div class='mt-3'>
					<div class='col'></div>
				</div>
				<div class='row mt-3'>
					<label for='color' class='col-3 col-form-label'>색상</label>
						<span id='color'></span>
				</div>
				<div class='row mt-3'>
					<label for='size' class='col-3 col-form-label'>사이즈</label>
						<span id='clothSize'></span>
				</div>
				<div class='row mt-3'>
					<label for='quantity' class='col-3 col-form-label'>수량</label>
					<button type='button' class='btn btn-outline-dark' id='minusBtn'>-</button>
					<input type='text' class='col-2' name='quantity' value='1'
						readonly='readonly' id='quantity' />
					<button type='button' class='btn btn-outline-dark' id='plusBtn'>+</button>
				</div>
				<div class='row mt-3'>
					<div class='col'>
						<div class='row d-flex justify-content-center'>
							<a href='<%=request.getContextPath() %>/cart' class='btn btn-outline-dark'>장바구니</a>
							<div style='width: 30px'></div>
							<a id='purchaseBtn' class='btn btn-outline-dark'>구매</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr>

		<div class='row'>
			<div class='col' id='info'>
				<p class='bold'>상품 상세</p>
				<p id='content'></p>
				<p class='bold mt-3'>세탁방법</p>
				<ul>
					<li class='status-bar'>드라이 클리닝 또는 단독 손세탁을 권장합니다.</li>
					<li class='status-bar'>찬물에 뒤집어 세탁해 주십시오.</li>
					<li class='status-bar'>다리미 사용 시 천을 올린 후 다림질해 주십시오.</li>
				</ul>
				<p class='bold'>MODEL SIZE</p>
				<ul>
					<li class='status-bar'>모델 착용 컬러 그레이, 착용사이즈 2XL, 키 186, 허리 25,
						신발 280</li>
				</ul>
			</div>
		</div>
		<hr>

		<div class='row'>
			<div class='col' id='info'>
				<table class='table table-bordered'>
					<thead class='thead-light'>
						<tr>
							<th>Size (cm)</th>
							<th>M</th>
							<th>L</th>
							<th>XL</th>
							<th>2XL</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>총기장</th>
							<td>70.5</td>
							<td>73</td>
							<td>76.5</td>
							<td>79</td>
						</tr>
						<tr>
							<th>어깨넓이</th>
							<td>60</td>
							<td>63</td>
							<td>65.5</td>
							<td>68.5</td>
						</tr>
						<tr>
							<th>가슴둘레</th>
							<td>60</td>
							<td>63</td>
							<td>66.5</td>
							<td>69</td>
						</tr>
						<tr>
							<th>어깨넓이</th>
							<td>58</td>
							<td>58</td>
							<td>59</td>
							<td>59</td>
						</tr>
					</tbody>
				</table>
				<p class='bold'>사이즈</p>
				<ul>
					<li class='status-bar'>상세 사이즈는 측정 방법과 위치에 따라 1~3cm 오차가 발생할 수
						있습니다.</li>
					<li class='status-bar'>기재된 상세 사이즈와 실측 오차(1~3cm)에 대한 불량처리는 어려우며
						교환 및 환불 사유가 될 수 없습니다.</li>
				</ul>
			</div>
		</div>
		<hr>

		<div class='row'>
			<div class='col' id='info'>
				<p class='bold'>유의사항</p>
				<ul>
					<li>상품마다 이미지 크기가 다르므로, 해당 상품의 이미지 가이드를 확인해 주세요.</li>
				</ul>
				<p class='bold mt-3'>교환/환불 불가 사항</p>
				<ul>
					<li>더좋은 쇼핑의 모든 상품은 고객 주문에 따라 개별 제작되는 방식으로 단순 변심을 포함, 아래의 경우에는
						교환/환불이 불가합니다.</li>
				</ul>
				<p class='bold mt-3'>디자인 시안 색상의 차이</p>
				<ul>
					<li>프린팅 방식과 원단 재질에 따른 경우의 수가 다양하므로 인쇄 후 모니터, 혹은 종이 출력물과 색상 차이가
						발생할 수 있습니다.</li>
				</ul>
			</div>
		</div>
		<hr>

		<div class='row' >
			<div class='col'>
				<table class='table table-bordered'>
					<thead class='thead-light'>
						<tr>
							<th>NO</th>
							<th>이미지</th>
							<th>제목</th>
							<th>아이디</th>
							<th>별점</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>1</th>
							<td><div id='productImg1'>
									<a href='#'><span>옷 이미지1</span> </a>
								</div></td>
							<td>좋아요</td>
							<td>id1</td>
							<td>★★★★★</td>
							<td>21.03.15</td>
						</tr>
						<tr>
							<th>2</th>
							<td><div id='productImg2'>
									<a href='#'><span>옷 이미지2</span> </a>
								</div></td>
							<td>편해요</td>
							<td>id2</td>
							<td>★★★★☆</td>
							<td>21.03.16</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class='row' style='height:100px'></div> 
	</div>
	
	<%@ include file="../include/footer.jsp"%>
</body>
</html>