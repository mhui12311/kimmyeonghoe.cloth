<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>
<script>
function getList(){
	$.ajax({
		method:'post',
		url:"<%=request.getContextPath() %>/admin/notice/list"
	}).done(notices => {
		if(notices.length) {
			let noticeList = [];
			
			$.each(notices, (idx, notice) => {
				noticeList.unshift(
					`<tr>
						<th></th>
						<th>
							<div class='form-check form-check-inline'>
								<input type='radio' class='form-check-input' 
									value='\${notice.noticeNum}' name='noticeNum' id='noticeNum'/>
								<label class='form-check-label' for='noticeNum'>&nbsp; \${notice.noticeNum}</label>
							</div>
						</th>
						<td>\${notice.title}</td>
						<td>\${notice.regDate}</td>
					</tr>`
				);
			});
			
			$('#noticeContent').append(noticeList.join(''));
		} else {
			$('#noticeContent').append('<tr><td colspan=4 class=text-center>x.</td></tr>');
		}
	});
}

function init(){
	getList();
	$('#delOkBtn').click(()=>{
		$('#testTr').empty();
	})
	
	$('#delQBtn').click(()=>{
		$('#delQModal').modal();
	})
}
$(init);
</script>	
<style>
</style>
<div class='container'>
	<%@ include file="../../include/adminHeader.jsp" %>

   <div class='row'>
      <%@ include file="../../include/adminGnb.jsp" %>

		<div class='col-9'>
			<div class='row mt-3 justify-content-start'>
				<h5><b>| 공지 사항</b></h5>
			</div>
			<table class='table'>
				<thead class='text-center'>
					<tr><th>번호</th><th>제목</th><th>작성일</th></tr>
				</thead>
				<tbody class='text-center' id='noticeContent'>
				</tbody>
			</table>
			<div class='row'>
				<div class='col d-flex justify-content-center'>
					<p>
						<a href='#'>< 이전</a>
						<a href='#'>[1]</a>
						<a href='#'>[2]</a>
						<a href='#'>[3]</a>
						<a href='#'>[4]</a>
						<a href='#'>[5]</a>
						<a href='#'>다음 ></a>
					</p>
				</div>
			</div>
			<div class='row'>
				<div class='col-3 d-flex justify-content-start'><button type='button' class='btn btn-outline-secondary mr-1' >상단</button></div>
				<div class='col d-flex justify-content-end'>
					<button type='button' class='btn btn-outline-secondary mr-1' id='delQBtn'>삭제</button>
					<button type='button' class='btn btn-outline-secondary mr-1' onclick='location.href="./03.html"'>수정</button>
						<button type='button' class='btn btn-outline-secondary mr-1' onclick='location.href="./02.html"'>작성</button>       			
					
				</div>
			</div>
		</div>
	</div>
</div>
<div class='row' style='height:30px'></div>

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
				<button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
				<button type='button' class='btn btn-secondary' id='delOkBtn' data-dismiss='modal'>예</button>
			</div>
		</div>
	</div>
</div>

	<%@ include file="../../include/footer.jsp" %>
</body>
</html>