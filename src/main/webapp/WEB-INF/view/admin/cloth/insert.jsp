<%@ page language='java' contentType='text/html; charset=utf-8'
	pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>
<%@ include file="../../include/lib.jsp"%>
<script>
function isVal(field) {
	let check = false;
	if(field.length && field.val()) check = true;
	
	return check;
}

function init() {
	$('#failOkBtn').click(() => {
		$('#failMessage').empty();
	});
	
	$('#addClothBtn').click(() => {
		if(isVal($('#kind')) && isVal($('#clothName')) && isVal($('#color')) && isVal($('#imageName')) && isVal($('#price')) && isVal($('#content'))) {
			$.ajax({
				url: 'add',
				method: 'post',
				contentType: 'application/json',
				data: JSON.stringify({
					kind: $('#kind').val(),
					clothName: $('#clothName').val(),
					price: $('#price').val(),
					imageName: $('#imageName').val(),
					content: $('#content').val(),
					displayState: $('#displayState').val(),
					clothLevel: $('#clothLevel').val(),
					color: $('#color').val(),
					clothSize: $('#clothSize').val(),
					quantity: $('#quantity').val()
				}),
				success: result => {
					$('#completeModal').modal();
				}
			})
		} else if(!(isVal($('#kind')))) {
			$('#failModal').modal();
			$('#failMessage').append("카테고리를 선택해 주세요.");
		} else if(!(isVal($('#clothName')))) {
			$('#failModal').modal();
			$('#failMessage').append("옷 이름을 입력해 주세요.");
		} else if(!(isVal($('#color')))) {
			$('#failModal').modal();
			$('#failMessage').append("색상을 입력해 주세요.");
		} else if(!(isVal($('#imageName')))) {
			$('#failModal').modal();
			$('#failMessage').append("옷 이미지를 등록해 주세요.");
		} else if(!(isVal($('#price')))) {
			$('#failModal').modal();
			$('#failMessage').append("가격을 입력해 주세요.");
		} else if(!(isVal($('#content')))) {
			$('#failModal').modal();
			$('#failMessage').append("상품 설명을 입력해 주세요.");
		} else if(!(isVal($('#quantity')))) {
			$('#failModal').modal();
			$('#failMessage').append("수량을 입력해 주세요.");
	}
	});
}

$(init);
</script>
<style>
</style>
</head>
<body>
	<div class='container'>
		<%@ include file="../../include/adminHeader.jsp"%>
		<div class='row'>
			<%@ include file="../../include/adminGnb.jsp" %>

			<div class='col-9'>
				<div class='row mt-3 justify-content-start'>
					<h5>
						<b>| 상품 등록</b>
					</h5>
				</div>
				<hr>
				<div class='row mt-3 justify-content-start'>
					<h6>
						<b>카테고리 선택</b>
					</h6>
					&nbsp;
					<p id='font'>※필수선택</p>
				</div>
				<hr>
				<div class='form-group row mt-3'>
					<label for='kind' class='col-2 col-form-label'>카테고리</label> 
					<select	name='kind' class='col-4' id='kind'>
						<option value=''>카테고리 선택</option>
						<option value='tShirt'>티셔츠</option>
						<option value='shirt'>셔츠</option>
						<option value='mtm'>맨투맨</option>
						<option value='hood'>후드</option>
					</select>
				</div>
				<hr>
				<div class='row mt-3 justify-content-start'>
					<h6>
						<b>노출 및 판매상태 설정</b>
					</h6>
					&nbsp;
					<p id='font'>※각 항목별 한가지 이상 선택</p>
				</div>
				<div class='form-group row mt-3'>
					<label for='showCloth' class='col-4 col-form-label'>쇼핑몰 노출상태</label>
					<div class='form-check form-check-inline'>
						<input type='radio' class='form-check-input' id='displayState' name='displayState' value='yes' checked /> 
						<label class='form-check-label' for='showCheck'>노출함</label>
					</div>
					<div class='form-check form-check-inline'>
						<input type='radio' class='form-check-input' id='displayState' name='displayState' value='no'/>
						<label class='form-check-label' for='unShowCheck'>노출안함</label>
					</div>
				</div>
				<div class='form-group row mt-3'>
					<label for='display' class='col-4 col-form-label'>옷 등급</label>
					<div class='form-check form-check-inline'>
						<input type='radio' class='form-check-input' id='clothLevel' name='clothLevel' value='new' checked /> 
						<label class='form-check-label' for='newProduct'>신상품</label>
					</div>
					<div class='form-check form-check-inline'>
						<input type='radio' class='form-check-input' id='clothLevel' name='clothLevel' value='hot' /> 
						<label class='form-check-label'	for='popularProduct'>인기상품</label>
					</div>
					<div class='form-check form-check-inline'>
						<input type='radio' class='form-check-input' id='clothLevel' name='clothLevel' value='normal'/> 
						<label class='form-check-label'	for='popularProduct'>일반상품</label>
					</div>
				</div>
				<hr>
				<div class='row mt-3 justify-content-start'>
					<h6>
						<b>상품 기본 사항</b>
					</h6>
					&nbsp;
					<p id='font'>※필수입력</p>
				</div>
				<div class='form-group row mt-3'>
					<label for='productName' class='col-3 col-form-label'>상품명</label>
					<div class='col'>
						<input type='text' class='form-control' name='clothName' id='clothName'>
					</div>
				</div>
				<div class='form-group row mt-3'>
					<label for='productColor' class='col-3 col-form-label'>색상</label>
					<div class='col'>
						<input type='text' class='form-control' name='color' id='color'>
					</div>
				</div>
				<div class='form-group row mt-3'>
					<label for='productImg' class='col-3 col-form-label'>상품 이미지</label>
					<div class='col-4'>
						<input type='text' class='form-control' name='imageName' id='imageName' />
					</div>
				</div>
				<div class='form-group row mt-3'>
					<label for='productInfo' class='col-3 col-form-label'>상품 가격</label>
					<div class='col'>
						<div class='row'>
							<div class='col-5'>
								<input type='number' class='form-control' id='price' name='price' />
							</div>
							<div class='col'>원</div>
						</div>
					</div>
				</div>
				<div class='form-group row mt-3'>
					<label for='clothSize' class='col-3 col-form-label'>사이즈</label>
					<div class='col'>
						<select name='clothSize' class='form-control' id='clothSize'>
							<option value='S'>S</option>
							<option value='M'>M</option>
							<option value='L'>L</option>
							<option value='XL'>XL</option>
						</select>
					</div>
				</div>
				<div class='form-group row mt-3'>
					<label for='content' class='col-3 col-form-label'>상품 설명</label>
					<div class='col'>
						<textarea class='form-control' rows='2' name='content' id='content'></textarea>
					</div>
				</div>
				<div class='form-group row mt-3'>
					<label for='quantity' class='col-3 col-form-label'>수량</label>
					<div class='col'>
						<input class='form-control' type='number' name='quantity' id='quantity'/>
					</div>
				</div>
				<hr>
				<div class='row justify-content-end'>
					<div class='col d-flex justify-content-end'>
						<button type='button' class='btn btn-outline-dark' id='addClothBtn'>등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id='completeModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<p>상품이 등록되었습니다.</p>
				</div>
				<div class='modal-footer'>
					<button type='submit' class='btn btn-outline-dark' data-dismiss='modal' id='addClothBtn'>확인</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id='failModal' class='modal fade' tabindex='-1'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<button type='button' class='close' data-dismiss='modal'>
						<span>&times;</span>
					</button>
				</div>
				<div class='modal-body'>
					<span id='failMessage'></span>
				</div>
				<div class='modal-footer'>
					<button type='submit' class='btn btn-outline-dark' data-dismiss='modal' id='failOkBtn'>확인</button>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../include/footer.jsp"%>
</body>
</html>