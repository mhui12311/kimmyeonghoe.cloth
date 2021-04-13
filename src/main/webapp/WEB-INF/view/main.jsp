<%@ page language='java' contentType='text/html; charset=utf-8'
	pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<title>THEJOEUN ShoppingMall</title>
<%@ include file ="./include/lib.jsp"%>

<style>
table {
	width: auto;
	text-align: center;
	margin-left: 0;
}

thead {
	justify-content: center;
}

td {
	justify-content: center;
}

[id*='cloth'] {
	width: 150px;
	height: 150px;
	border: 1px solid lightgrey;
	text-align: center;
	margin-left: 0;
}

[id*='ProductInfo'] {
	width: 150px;
	height: 100px;
	margin-top: 10px;
	margin-bottom: 5px;
	margin-left: 0;
}

#banner {
	width: auto;
	height: 100px;
	margin-top: 10px;
	text-align: center;
	border: 1px solid lightgrey;
}
</style>
</head>
<script>
	function init() {

	}
	$(init);
</script>

<body>
	<div class='container contents-wrap'>
	<%@ include file ="./include/header.jsp"%>
		<p>
			<strong>BEST</strong>&nbsp;&nbsp; 지금 이 순간, 가장 인기있는 아이템
		</p>
		<div class='row'>
			<div class='col'>
				<table class="table table-borderless" id="bestProductImg">
					<thead>
						<tr>
							<th><div id="cloth1">
									<br>
									<p>옷 이미지</p>
								</div></th>
							<th><div id="cloth2">
									<br>
									<p>옷 이미지</p>
								</div></th>
							<th><div id="cloth3">
									<br>
									<p>옷 이미지</p>
								</div></th>
							<th><div id="cloth4">
									<br>
									<p>옷 이미지</p>
								</div></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><div id="bestProductInfo1">
									<p>
										오버핏티셔츠<br>10,000원<span class='badge badge-secondary'>Best</span>
									</p>
								</div></td>
							<td><div id="bestProductInfo2">
									<p>
										무지 반팔<br>10,000원<span class='badge badge-secondary'>Best</span>
									</p>
								</div></td>
							<td><div id="bestProductInfo3">
									<p>
										더블코튼 무지 반팔<br>10,000원<span class='badge badge-secondary'>Best</span>
									</p>
								</div></td>
							<td><div id="bestProductInfo4">
									<p>
										시그니처 쿨론 반팔<br>10,000원<span class='badge badge-secondary'>Best</span>
									</p>
								</div></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<p>
			<strong>NEW</strong>&nbsp;&nbsp; 당신을 사로잡을 새로운 아이템
		</p>
		<div class='row'>
			<div class='col'>
				<table class="table table-borderless" id="newProductImg">
					<thead>
						<tr>
							<th><div id="cloth5">
									<br>
									<p>옷 이미지</p>
								</div></th>
							<th><div id="cloth6">
									<br>
									<p>옷 이미지</p>
								</div></th>
							<th><div id="cloth7">
									<br>
									<p>옷 이미지</p>
								</div></th>
							<th><div id="cloth8">
									<br>
									<p>옷 이미지</p>
								</div></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><div id="newProductInfo1">
									<p>
										오버핏티셔츠<br>10,000원<span class='badge badge-secondary'>New</span>
									</p>
								</div></td>
							<td><div id="newProductInfo2">
									<p>
										무지 반팔<br>10,000원<span class='badge badge-secondary'>New</span>
									</p>
								</div></td>
							<td><div id="newProductInfo3">
									<p>
										더블코튼 무지 반팔<br>10,000원<span class='badge badge-secondary'>New</span>
									</p>
								</div></td>
							<td><div id="newProductInfo4">
									<p>
										시그니처 쿨론 반팔<br>10,000원<span class='badge badge-secondary'>New</span>
									</p>
								</div></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@ include file ="./include/footer.jsp"%>
</body>
</html>

