<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">

	<!-- Admin Carousel -->
	<%@ include file="../includes/adminCarousel.jsp" %>

<div class="container">
	
	<div class="row my-5 gyoon-link" align="center">
	  <p class="fs-1 gyoon-redressed">Product</p>
	  
	  <form method="post" action="/admin/product.do" name="productSearchForm" class="mx-2"> 
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  <div class="d-flex justify-content-end align-items-center mb-3">
	  	  <div>
		      <select name="type">
			    <option value="">Select</option>
			    <option value="N">Name</option>
			    <option value="C">Content</option>
			    <option value="K">Category</option>
			    <option value="NCK">All</option>
		      </select>
	  	  </div>
	  	  <div class="mx-2">
			  <input class="form-control border-dark" type="search" name="keyword" placeholder="Product Name" aria-label="Search">
	          <input type="hidden" name="pageNum" value="1">
	          <input type="hidden" name="amount" value="10"> 
          </div>
          <div>
			  <span class="p-1 px-3 button-hover" onClick="return submitSearch()">Search</span>	
		  </div>
	  </div>
	  </form> 
	  
	  <hr>

	  <div class="gyoon-pd-mg"> 

		  <!-- Admin Nav -->
		  <%@ include file="../includes/adminNav.jsp" %>
		
		  <div class="row my-5">		  
			<div class="col-md-12">
	  		  <p class="fs-2 mt-5 gyoon-redressed">Product Write</p>
	  		  <hr>
	  		  <form method="post" action="productWrite.do" enctype="multipart/form-data" name="productForm">
	  		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  		  
			  <table class="table text-left fs-5 align-middle border_white">
			    <tr>
			      <td>Category</td>
			      <td colspan="5">
			        <select  name="kind" class="border_333">
				      <option value="electric" >Electric</option>
				      <option value="acoustic" >Acoustic</option>
				      <option value="amp" >Amplifier</option>
				      <option value="acc" >Accessory</option>
			        </select>
			      </td>
			    </tr>
			    <tr>
			      <td>Product Name</td>
			      <td colspan="5">
			      	<input type="text" class="form-control border-dark" name="pname">
			      </td>
			    </tr>
			    <tr>
			      <td>Quantity</td>
			      <td colspan="5">
			      	<input type="text" class="form-control border-dark" name="pquantity">
			      </td>
			    </tr>
			    <tr>
			      <td>Cost</td>
			      <td>
			      	<input type="text" class="form-control border-dark" name="price1">
			      </td>
			      <td>Selling Price</td>
			      <td>
			      	<input type="text" class="form-control border-dark" name="price2" onblur="go_ab()">
			      </td>
			      <td>Profit margin</td>
			      <td>
			      	<input type="text" class="form-control border-dark" name="price3">
			      </td>
			    </tr>
			    <tr>
			      <td>Best</td>
			      <td colspan="2">
			      	<input class="form-check-input" type="checkbox" id="best">
			      	<input type="hidden" name="bestyn" id="bestyn" value="0">
			      </td>
			      <td>Sale</td>
			      <td colspan="2">
			      	<input class="form-check-input" type="checkbox" id="sale">
			      	<input type="hidden" name="saleyn" id="saleyn" value="0">
			      </td>
			    </tr>
			    <tr>
			      <td>Content</td>
			      <td colspan="5">
			      	<textarea class="form-control border-dark scrollspy-example" name="pcontent" id="summernote"></textarea>
			      </td>
			    </tr>
				<tr>
			      <td>Thumbnail</td>
			      <td colspan="5">
			      	<input type="file" class="form-control border-dark" name="uploadfile" id="uploadfile">
			      </td>
			    </tr>
			  </table>
			  </form>
			  
			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-3 me-2 button-hover" onClick="return checkWrite()">Write</span>
				<span class="p-1 px-4 ms-2 button-hover" onClick="location.href='/admin/product.do'">List</span>
			  </div>
			  
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div>

</div><!-- /제일 바깥 container -->

</body>
</html>


<script type="text/javascript">

function submitSearch(){
	if(document.productSearchForm.keyword.value.length == 0){
		alert('Please input product name for searching.');
		document.productSearchForm.keyword.focus();
		return false;
	}
	document.productSearchForm.submit();
}

function checkWrite(){
	if( document.productForm.pname.value.length == 0 ){
		alert('Please input Product Name.'); document.productForm.pname.focus(); return false;
	}
	if( document.productForm.pquantity.value.length == 0 ){
		alert('Please input Quantity.'); document.productForm.pquantity.focus(); return false;
	}
	if( isNaN(document.productForm.pquantity.value) ){
		alert('Please input only number in Quantity.'); document.productForm.pquantity.focus(); return false;
	}
	if( document.productForm.price1.value.length == 0 || document.productForm.price2.value.length == 0 || document.productForm.price3.value.length == 0 ){
		alert('Please input all price.'); document.productForm.price1.focus(); return false;
	}
	if( isNaN(document.productForm.price1.value) || isNaN(document.productForm.price2.value) || isNaN(document.productForm.price3.value) ){
		alert('Please input only number in Price.'); document.productForm.price1.focus(); return false;
	}
	if( document.productForm.pcontent.value.length == 0 ){
		alert('Please input Content.'); document.productForm.pcontent.focus(); return false;
	}
	if($("#uploadfile").val() == "") {
	alert("Please upload image file.");
	$("#uploadfile").focus();
	return false;
	}
	if($("#uploadfile").val() != ""){
		var ext=$("#uploadfile").val().split('.').pop().toLowerCase();
		if($.inArray(ext,['gif','jpg','png','jpeg']) == -1) { /*하나라도 같으면 0이상의 값을 뱉는다.*/
			alert('Only Image file can be uploaded (gif,jpg,png,jpeg)');
			$("#uploadfile").val("");
			return false;
		}
	}
	if(document.getElementById("uploadfile").value != ""){
		var fileSize = document.getElementById("uploadfile").files[0].size;
		var maxSize = 3 * 1024 * 1024; //3mb
		if(fileSize > maxSize){
			alert('Image file can be upload max 3MB.');
			document.getElementById("uploadfile").value = "";
			return false;
		}
	}
	
	if( confirm('Go to Upload this product.') ){
		document.productForm.submit();
	}else{ return false }
	
}

function go_ab() {
   var theForm = document.productForm;
   var a = productForm.price2.value.replace(/,/g, '');
   var b = productForm.price1.value.replace(/,/g, '');
   var ab = parseInt(a) - parseInt(b);
   productForm.price3.value = ab;
}

$(document).ready(function(){
    $("#best").change(function(){
        if($("#best").is(":checked")){
        	$("#bestyn").val(1);
        }else{
        	$("#bestyn").val(0);
        }
    });
    $("#sale").change(function(){
        if($("#sale").is(":checked")){
        	$("#saleyn").val(1);
        }else{
        	$("#saleyn").val(0);
        }
    });
});

$('#summernote').summernote({
	height: 300,
	tabsize: 2,
	minHeight: null,         
	maxHeight: null,           
	focus: true,
	 toolbar: [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	    ['insert',['picture','link','video']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ],
	  // 추가한 글꼴
	fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
	 // 추가한 폰트사이즈
	fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50']
});
</script>


<%@ include file="../includes/footer.jsp" %>