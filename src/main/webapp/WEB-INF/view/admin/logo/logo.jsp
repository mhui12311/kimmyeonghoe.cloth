<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<%@ include file="../../include/lib.jsp" %>
<title>THEJOEUN ShoppingMall</title>
<script>
function showImg(input) {
   if(input.files[0]) {
      let reader = new FileReader();
      reader.readAsDataURL(input.files[0]);
      reader.addEventListener('load', () => {
         $('#previewImg').attr('src', reader.result);
         $('#previewImg').show();
      }, false);
   }
}


function loadImg(){
	$.ajax({
        method: 'post',
        url:"${pageContext.request.contextPath}/admin/logo/load",
        success: result => {
           if(result != "") {
           	$('#previewImg').show();
           	var filePlace = "/res/"+result;
           	var srcValue = `<c:url value="/res/\${result}"/>`
           	$('#previewImg').attr('src', srcValue);
           } else {
           	$('#previewImg').hide();
           }
        },
        error: err => {
        }
     })
}
function init() {
	 $('input').change(function() {
	      showImg(this);
	   });
	   
	   $('#addLogoBtn').click(() => {
		      let data = new FormData($('form')[0]); // formdata가 binary data를 가지고 있다.
		      $.ajax({
		         method: 'post',
		         url:"${pageContext.request.contextPath}/admin/logo/attach",
		         data,
		         processData: false, // text data가 아니므로 proccessData 처리를 하지말라는 뜻에서 false를 준다.
		         contentType: false, // text data가 아니므로 contentType을 false로 준다.
		         success: result => {
		            if(result) {
		            	$('#bodyMsg').text('이미지 제출 성공했습니다.');
		            	$('#commonModal').modal()
		            }
		         },
		         error: err => {
		        	 $('#bodyMsg').text('이미지 제출을 실패했습니다.');
		        	 $('#commonModal').modal()
		         }
		      });
		   });
	   
	   loadImg();
	      
	$('#delLogoBtn').click(() => {
		$('#delModalMsg').text('로고를 삭제하시겠습니까?');
		$('#delModal').modal()
	});
	
	$('#delOkBtn').click(()=>{
		$('#delModal').modal('hide');
		
		$.ajax({
			method:'post',
			url:"${pageContext.request.contextPath}/admin/logo/getNum",
			success: num => {
				$.ajax({
			         method: 'post',
			         url:"${pageContext.request.contextPath}/admin/logo/delete",
			         data:({
						logoNum: num
					 }),
			         success: result => {
			            if(result != "") {
			            	$('#bodyMsg').text('로고가 삭제되었습니다.');
			        		$('#commonModal').modal();
			        		$('#previewImg').hide();
			        		loadImg();
			            } else {
			            }
			         },
			         error: err => {
			         }
			      })
			}
		})
	})
};

$(init);
</script>
<style>
table {
	text-align: center;
	font-size: 13px;
}
#font {
	font-size: 13px;
}
.input-file-button {
  padding: 4px 8px;
  background-color: #A9A9A9;
  border-radius: 4px;
  color: white;
  cursor: pointer;
}

#previewImg{
	width:100px;
	height:100px;
}
</style>

<div class='container'>
	<%@ include file="../../include/adminHeader.jsp" %>
	
	<div class='row'>
		<%@ include file="../../include/adminGnb.jsp" %>
		
		<div class='col-9'>
			<div class='row mt-3 justify-content-start'>
				<h5><b>| 홈페이지</b></h5>
				<div class='col d-flex justify-content-end'>
					<button type='button' class='btn btn-outline-dark btn-sm' id='addLogoBtn'>등록</button>&nbsp;
					<button type='button' class='btn btn-outline-dark btn-sm' id='delLogoBtn'>삭제</button>
				</div>
			</div>
			<hr>
			<form>
				<div class='form-row'>
					<div class='col'>
						<div>
							<!-- 
							<label class='input-file-button border' for='attachFile'>업로드</label>
							<input type='file' id='attachFile' class='form-control-file' style='display:none;'/>  -->
							<input type='file' class='form-control-file' id='attachFile' name='attachFile'/>  
						</div>
					</div>
				</div>
			</form>
			<div class='row d-flex justify-content-center'>
				<img id='previewImg'/>	
			</div>
			<div class='row' style='height:400px'></div>
		</div>
	</div>
</div>

<div id='delModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body'>
				<p id='delModalMsg'><p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-dark btn-sm' data-dismiss='modal' >취소</button>
				<button type='button' class='btn btn-outline-dark btn-sm' data-dismiss='modal' id='delOkBtn'>확인</button>
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
				<p id='bodyMsg'><p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-dark btn-sm' data-dismiss='modal' id='okBtn'>확인</button>
			</div>
		</div>
	</div>
</div>

	<%@ include file="../../include/footer.jsp" %>
</body>
</html>