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

<div class="gyoon-sidebar-container">

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
	  		  <p class="fs-2 mt-5 gyoon-redressed">Product Detail</p>
	  		  <hr>
	  		  <form method="post" action="productUpdate.do" enctype="multipart/form-data" name="productForm">
	  		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  		  <input type="hidden" name="pseq" value="<c:out value="${pVO.pseq}"/>">
	  		  
			  <table class="table text-left fs-5 align-middle border_white">
			    <tr>
			      <td>Category</td>
			      <td colspan="5">
			        <select  name="kind" class="border_333">
				      <option value="electric" <c:if test="${pVO.kind eq 'electric'}">selected</c:if> >Electric</option>
				      <option value="acoustic" <c:if test="${pVO.kind eq 'acoustic'}">selected</c:if> >Acoustic</option>
				      <option value="amp" <c:if test="${pVO.kind eq 'amp'}">selected</c:if> >Amplifier</option>
				      <option value="acc" <c:if test="${pVO.kind eq 'acc'}">selected</c:if> >Accessory</option>
			        </select>
			      </td>
			    </tr>
			    <tr>
			      <td>Product Name</td>
			      <td colspan="5">
			      	<input type="text" class="form-control border-dark" name="pname" value="<c:out value="${pVO.pname}"/>">
			      </td>
			    </tr>
			    <tr>
			      <td>Quantity</td>
			      <td colspan="5">
			      	<input type="text" class="form-control border-dark" name="pquantity" value="<c:out value="${pVO.pquantity}"/>">
			      </td>
			    </tr>
			    <tr>
			      <td>Cost</td>
			      <td>
			      	<input type="text" class="form-control border-dark" name="price1" value="${pVO.price1}">
			      </td>
			      <td>Selling Price</td>
			      <td>
			      	<input type="text" class="form-control border-dark" name="price2" value="${pVO.price2}" onblur="go_ab()">
			      </td>
			      <td>Profit margin</td>
			      <td>
			      	<input type="text" class="form-control border-dark" name="price3" value="${pVO.price3}">
			      </td>
			    </tr>
			    <tr>
			      <td>Best</td>
			      <td colspan="2">
			      	<input class="form-check-input" type="checkbox" id="best" <c:if test="${pVO.bestyn == 1}">checked</c:if> >
			      	<input type="hidden" name="bestyn" id="bestyn" value="${pVO.bestyn}">
			      </td>
			      <td>Sale</td>
			      <td colspan="2">
			      	<input class="form-check-input" type="checkbox" id="sale" <c:if test="${pVO.saleyn == 1}">checked</c:if> >
			      	<input type="hidden" name="saleyn" id="saleyn" value="${pVO.saleyn}">
			      </td>
			    </tr>
			    <tr>
			      <td>Content</td>
			      <td colspan="5">
			      	<textarea class="form-control border-dark scrollspy-example" name="pcontent" id="summernote">${pVO.pcontent}</textarea>
			      </td>
			    </tr>
			    <c:if test="${pVO.pimage != null && pVO.pimage ne ''}">
			    <tr>
			      <td>Thumbnail</td>
			      <td colspan="5">
			      	<img src="/upload_gyoontar/product/${pVO.pimage}" class="mprofile-size">
			      	<input type="hidden" name="pimage" value="${pVO.pimage}">
			      </td>
			    </tr>
			    </c:if>
			    <tr>
			      <td>Thumbnail Change</td>
			      <td colspan="5">
			      	<input type="file" class="form-control border-dark" name="uploadfile" id="uploadfile">
			      </td>
			    </tr>
			  </table>
			  </form>
			  
			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-3 button-hover" onClick="return checkUpdate()">Update</span>
			  	<span class="p-1 px-3 ms-2 me-1 button-hover" onClick="return checkReset()">Reset</span>
				<span class="p-1 px-3 ms-1 me-2 button-hover" onClick="return checkDelete()">Delete</span>
				<span class="p-1 px-4 button-hover" onClick="location.href='/admin/product.do'">List</span>
			  </div>
			  

		<!-- comment & review (product) -->
		<div class="gyoon-com-rev">
		<ul class="nav nav-tabs gyoon-com-rev" id="myTab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-selected="true">Review</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-selected="false">Comment(QnA)</button>
		  </li>
		</ul>
		<div class="tab-content" id="myTabContent">
		  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab"> <!-- REVIEW start -->
			  <form method="post" action="/admin/revWrite.do" name="revWrite">
			      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				  <div class="d-flex justify-content-center my-5"> <!-- REVIEW Write---------------------------------- -->
				    <div>
				      <textarea rows="5" class="form-control border-dark scrollspy-example w_500" placeholder="Write review for this product" name="revcontent"></textarea>
				      <input type="hidden" name="pseq" value="${pVO.pseq}">
				      <input type="hidden" name="userid" value="${session_userid}">	    
				    </div>
				    <div class="align-self-center ms-2">
				      <span class="p-1 px-3 button-hover" onClick="return checkRevWrite()">Write</span>  
				    </div>
				  </div>
			  </form>

<div class="d-flex flex-row-reverse">
  <span class="p-1 px-4 mx-1 my-3 button-hover" id="btn-modal">More Review</span>
</div>

<!-- Modal (Review) -------------------------------------------------------------------------------- -->
<div id="modal" class="modal-overlay">
	<div class="container gyoon-container d-flex justify-content-center">
	    <div class="modal-window scrollspy-example container">
	        <div class="title">
	            <h2 class="gyoon-redressed">Review</h2>
	        </div>
	        <div class="close-area">X</div>
	        <div class="content">
			  <div class="gyoon-link gyoon-rep" align="center">
				<table class="table mt-5 text-center text-white align-middle">
				
				<c:forEach var="review" items="${review_list}">
			      <tr>
			        <th><c:out value="${review.nickname}"/><br><fmt:formatDate pattern="yyyy-MM-dd" value="${review.revregdate}"/></th>
			        <th>
			        	<textarea rows="5" class="form-control text-white bg-transparent border_trans scrollspy-example contentR${review.revno}" readonly><c:out value="${review.revcontent}"/></textarea>
			        </th>
			        <th>
			          <c:if test="${review.userid eq session_userid}">
			          <a href="" class="text-white repUpdate" data-no="${review.revno}" data-rc="r">Update</a>
			          </c:if>
			          <br>
			          <a class="text-white" href="revDelete.do?revno=${review.revno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Review?')">Delete</a>
			        </th>	        
			      </tr>
				</c:forEach>

			  	</table>
			  	
				<c:if test="${review_list[0] == null}">
				  <p class="my-5 fs-3 text-white gyoon-redressed">No Review Yet</p>
				</c:if>
			  	
			  </div>
	        </div>
	    </div>	
	</div>
</div>
<!-- /Modal -------------------------------------------------------------------------------- --> 
			  <div class="mb-5 gyoon-link" align="center"> <!-- wrap of REVIEW table -->
				<table class="table text-center align-middle">
				
				<c:forEach var="review" items="${review_list}" begin="0" end="9">
			      <tr>
			        <th><c:out value="${review.nickname}"/><br><fmt:formatDate pattern="yyyy-MM-dd" value="${review.revregdate}"/></th>
			        <th>
			        	<textarea rows="5" class="form-control border-white bg-white scrollspy-example contentR${review.revno}" readonly="readonly"><c:out value="${review.revcontent}"/></textarea>
			        </th>
			        <th>
			          <c:if test="${review.userid eq session_userid}">
			          <a href="" class="repUpdate" data-no="${review.revno}" data-rc="r">Update</a>
			          </c:if>
			          <br>
			          <a href="revDelete.do?revno=${review.revno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Review?')">Delete</a>
			        </th>	        
			      </tr>
				</c:forEach>

			  	</table>
			  	
				<c:if test="${review_list[0] == null}">
				  <p class="my-5 fs-3 gyoon-redressed">No Review Yet</p>
				</c:if>
			  	
			  </div>
		  </div>  <!-- REVIEW end -->
		  
		  

		  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab"> <!-- COMMENT start -->
			  <form method="post" action="/admin/comWrite.do" name="comWrite">
			  	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				  <div class="d-flex justify-content-center my-5"> <!-- COMMENT Write---------------------------------- -->
				    <div>
				      <textarea rows="5" class="form-control border-dark scrollspy-example w_500" placeholder="Write Comment or any Question for this product." name="comcontent"></textarea>
				      <input type="hidden" name="pseq" value="${pVO.pseq}">
				      <input type="hidden" name="userid" value="${session_userid}">	  	    
				    </div>
				    <div class="align-self-center ms-2">
				      <span class="p-1 px-3 button-hover" onClick="return checkComWrite()">Write</span>  
				    </div>
				  </div>
			  </form>
			  

<div class="d-flex flex-row-reverse">
  <span class="p-1 px-4 mx-1 my-3 button-hover" id="btn-modal2">More Comment</span>
</div>
<!-- Modal (Comment) -------------------------------------------------------------------------------- -->
<div id="modal2" class="modal-overlay2">
	<div class="container gyoon-container2 d-flex justify-content-center">
	    <div class="modal-window2 scrollspy-example container">
	        <div class="title2">
	            <h2 class="gyoon-redressed">Comment</h2>
	        </div>
	        <div class="close-area2">X</div>
	        <div class="content2">
			  <div class="gyoon-link gyoon-rep" align="center">
				<table class="table mt-5 text-center text-white align-middle">
				
				<c:forEach var="comment" items="${comment_list}">
			      <tr>
			        <th><c:out value="${comment.nickname}"/><br><fmt:formatDate pattern="yyyy-MM-dd" value="${comment.comregdate}"/></th>
			        <th>
			        	<textarea rows="4" class="form-control text-white bg-transparent border_trans scrollspy-example contentC${comment.comno}" readonly><c:out value="${comment.comcontent}"/></textarea>
			        </th>
			        <th>
			          <c:if test="${comment.userid eq session_userid}">
			          <a href="" class="text-white repUpdate" data-no="${comment.comno}" data-rc="c">Update</a>
			          </c:if>
			          <br>
			          <a href="" class="text-white repUpdate" data-no="${comment.comno}" data-rc="CR">Reply</a>
			          <br>
			          <a class="text-white" href="comDelete.do?comno=${comment.comno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Comment?')">Delete</a>
			        </th>	        
			      </tr>
			      
			      <tr class="trCRmodal${comment.comno}">
			      <c:if test="${comment.comreply != null && comment.comreply ne ''}">
			        <th><i class="bi bi-arrow-return-right text-white fs-3"></i></th>
			        <th><textarea rows="4" class="form-control text-white bg-transparent border_trans scrollspy-example contentCR${comment.comno}" readonly><c:out value="${comment.comreply}"/></textarea></th>  
			        <th><i class="bi bi-check-lg text-white fs-3"></i></th>
			      </c:if>
			      </tr>
				</c:forEach>

			  	</table>
			  	
				<c:if test="${comment_list[0] == null}">
				  <p class="my-5 fs-3 text-white gyoon-redressed">No Comment Yet</p>
				</c:if>
			  	
			  </div>
	        </div>
	    </div>	
	</div>
</div>

<!-- /Modal -------------------------------------------------------------------------------- --> 
			  <div class="mb-5 gyoon-link" align="center"> 
				<table class="table text-center align-middle">
				
				<c:forEach var="comment" items="${comment_list}" begin="0" end="9">
			      <tr>
			        <th><c:out value="${comment.nickname}"/><br><fmt:formatDate pattern="yyyy-MM-dd" value="${comment.comregdate}"/></th>
			        <th><textarea rows="4" class="form-control border-white bg-white scrollspy-example contentC${comment.comno}" readonly><c:out value="${comment.comcontent}"/></textarea></th>
			        <th>
			          <c:if test="${comment.userid eq session_userid}">
			          <a href="" class="repUpdate" data-no="${comment.comno}" data-rc="c">Update</a>
			          </c:if>
			          <br>
			          <a href="" class="repUpdate" data-no="${comment.comno}" data-rc="CR">Reply</a>
			          <br>
			          <a href="comDelete.do?comno=${comment.comno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Comment?')">Delete</a>
			        </th>	        
			      </tr>
			      
			      <tr class="trCR${comment.comno}">
			      <c:if test="${comment.comreply != null && comment.comreply ne ''}">
			        <th><i class="bi bi-arrow-return-right fs-3"></i></th>
			        <th><textarea rows="4" class="form-control border-white bg-white scrollspy-example contentCR${comment.comno}" readonly="readonly"><c:out value="${comment.comreply}"/></textarea></th>  
			        <th><i class="bi bi-check-lg fs-3"></i></th>
			      </c:if>
			      </tr>
			      
				</c:forEach>

			  	</table>
			  	
				<c:if test="${comment_list[0] == null}">
				  <p class="my-5 fs-3 gyoon-redressed">No Comment Yet</p>
				</c:if>
			  	
			  </div>

		  </div> <!-- COMMENT end -->
		</div> <!-- tab-content -->
	  	</div> <!-- /gyoon-com-rev -->


 <!-- Modal (Reply Update) -->
 <div id="repUpdate-modal">
   <div id="repUpdate-context">
     <p class="gyoon-redressed text-center text-white fs-2">Update</p>
     <textarea rows="5" class="form-control border-white bg-white scrollspy-example" id="repUpdate-content"></textarea>
     <button class="btn btn-repUpdate float-end mt-3 px-3 ms-3" id="repUpdate-write" data-no="" data-rc="">Write</button>
     <button class="btn btn-repUpdate float-end mt-3" id="repUpdate-cancel">Cancel</button>
   </div>
 </div>
 <!-- /Modal (Reply Update) -->
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div><!-- /container with sidebar -->

</div><!-- /gyoon-sidebar-container -->

</div><!-- /제일 바깥 container -->

</body>
</html>


<script type="text/javascript">

$(document).ready(function() {
	var reviewIN_result = '<c:out value="${reviewIN_result}"/>';
	if( reviewIN_result != null && reviewIN_result != "" && !history.state ){
		if( parseInt(reviewIN_result) == 1 ){
			alert('Review upload Success !');
		}else{
			alert('Review upload Fail !');
		}
	}
	var commentIN_result = '<c:out value="${commentIN_result}"/>';
	if( commentIN_result != null && commentIN_result != "" && !history.state ){
		if( parseInt(commentIN_result) == 1 ){
			alert('Comment upload Success !');
		}else{
			alert('Comment upload Fail !');
		}
	}
	var reviewDel_result = '<c:out value="${reviewDel_result}"/>';
	if( reviewDel_result != null && reviewDel_result != "" && !history.state ){
		if( parseInt(reviewDel_result) == 1 ){
			alert('Review delete Success !');
		}else{
			alert('Review delete Fail !');
		}
	}
	var commentDel_result = '<c:out value="${commentDel_result}"/>';
	if( commentDel_result != null && commentDel_result != "" && !history.state ){
		if( parseInt(commentDel_result) == 1 ){
			alert('Comment delete Success !');
		}else{
			alert('Comment delete Fail !');
		}
	}
	history.replaceState({},null,null);
})

function submitSearch(){
	if(document.productSearchForm.keyword.value.length == 0){
		alert('Please input product name for searching.');
		document.productSearchForm.keyword.focus();
		return false;
	}
	document.productSearchForm.submit();
}

function checkUpdate(){
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
	
	if( confirm('Go to Update this product.') ){
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

var reset_content = '${pVO.pcontent}';
function checkReset(){
	if( confirm('Sure to Reset this form?') ){
		document.productForm.reset();
		$("#summernote").summernote("code",reset_content);
	}
}

function checkDelete(){
	if( confirm('Sure to Delete this product?') ){
		location.href="/admin/productDelete.do?pseq=<c:out value="${pVO.pseq}"/>";
	}else{ return false }
}

function checkRevWrite(){
	if(document.revWrite.revcontent.value.length == 0){
		document.revWrite.revcontent.focus();
		alert("Check your Review content.");
		return false;
	}
	
	if(confirm('You sure write this Review?')){
		document.revWrite.submit();
	}else{
		return false;	
	}
}

function checkComWrite(){
	if(document.comWrite.comcontent.value.length == 0){
		document.comWrite.comcontent.focus();
		alert("Check your Comment content.");
		return false;
	}
	
	if(confirm('You sure write this Comment?')){
		document.comWrite.submit();
	}else{
		return false;	
	}
}

</script>

<script>
	/* REVIEW script */
	const modal = document.getElementById("modal")
	function modalOn() {
	    modal.style.display = "flex"
	}
	function isModalOn() {
	    return modal.style.display === "flex"
	}
	function modalOff() {
	    modal.style.display = "none"
	}
	const btnModal = document.getElementById("btn-modal")
	btnModal.addEventListener("click", e => {
	    modalOn()
	})
	const closeBtn = modal.querySelector(".close-area")
	closeBtn.addEventListener("click", e => {
	    modalOff()
	})
	modal.addEventListener("click", e => {
	    const evTarget = e.target
	    if(evTarget.classList.contains("modal-overlay") || evTarget.classList.contains("gyoon-container")) {
	        modalOff()
	    }
	})
	window.addEventListener("keyup", e => {
	    if(isModalOn() && e.key === "Escape") {
	        modalOff()
	    }
	})

	/* COMMENT script */
	const modal2 = document.getElementById("modal2")
	function modalOn2() {
	    modal2.style.display = "flex"
	}
	function isModalOn2() {
	    return modal2.style.display === "flex"
	}
	function modalOff2() {
	    modal2.style.display = "none"
	}
	const btnModal2 = document.getElementById("btn-modal2")
	btnModal2.addEventListener("click", e => {
	    modalOn2()
	})
	const closeBtn2 = modal2.querySelector(".close-area2")
	closeBtn2.addEventListener("click", e => {
	    modalOff2()
	})
	modal2.addEventListener("click", e => {
	    const evTarget = e.target
	    if(evTarget.classList.contains("modal-overlay2") || evTarget.classList.contains("gyoon-container2")) {
	        modalOff2()
	    }
	})
	window.addEventListener("keyup", e => {
	    if(isModalOn2() && e.key === "Escape") {
	        modalOff2()
	    }
	})
	
	/* Reply Update */
	$(".repUpdate").on("click", function(e){
		var no = $(this).data("no");
		var rc = $(this).data("rc");
		e.preventDefault();
		if( rc == 'r' ){
			$.ajax({
				type:"get",
				url:"/product/revUpdate.do?revno=" + no,
				dataType:"json",
				success:function(data){
					var revcontent = data.revcontent;
					$("#repUpdate-content").val(revcontent);
					$("#repUpdate-write").data("no", no);
					$("#repUpdate-write").data("rc", 'r');
					$("#repUpdate-modal").css('display', 'block');
				}, error:function(){
					alert("Error - Review Update");
				}
			})
		}else if( rc == 'c' ){
			$.ajax({
				type:"get",
				url:"/product/comUpdate.do?comno=" + no,
				dataType:"json",
				success:function(data){
					var comcontent = data.comcontent;
					$("#repUpdate-content").val(comcontent);
					$("#repUpdate-write").data("no", no);
					$("#repUpdate-write").data("rc", 'c');
					$("#repUpdate-modal").css('display', 'block');
				}, error:function(){
					alert("Error - Comment Update");
				}
			})
		}else if( rc == 'CR' ){
			$.ajax({
				type:"get",
				url:"/product/comUpdate.do?comno=" + no,
				dataType:"json",
				success:function(data){
					var comreply = data.comreply;
					$("#repUpdate-content").val(comreply);
					$("#repUpdate-write").data("no", no);
					$("#repUpdate-write").data("rc", 'CR');
					$("#repUpdate-modal").css('display', 'block');
				}, error:function(){
					alert("Error - Reply Update");
				}
			})
		}
	})

	$("#repUpdate-write").on("click", function(e){
		e.preventDefault();
		if( confirm('You really want to update this Reply?') ){
			var rc = $(this).data("rc");
			var content = $("#repUpdate-content").val();
			var no = $(this).data("no");
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			if( rc == 'r' ){
				$.ajax({
					type:"post",
					url:"/product/revUpdatePost.do",
					dataType:"json",
					data:{
						revno : no,
						revcontent : content
					},
					beforeSend : function(xhr)
					{   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader(header, token);
					},
					success:function(data){
						$("#repUpdate-modal").css("display", "none");
						if( parseInt(data) == 1 ){
							$('.contentR' + no).val( content );
							alert('Update Review Success !');
						}else{
							alert('Update Review Fail !');
						}
					}, error:function(){
						alert("Error - Update Review");
					}
				})
			}else if( rc == 'c' ){
				$.ajax({
					type:"post",
					url:"/product/comUpdatePost.do",
					dataType:"json",
					data:{
						comno : no,
						comcontent : content
					},
					beforeSend : function(xhr)
					{   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader(header, token);
					},
					success:function(data){
						$("#repUpdate-modal").css("display", "none");
						if( parseInt(data) == 1 ){
							$('.contentC' + no).val( content );
							alert('Update Comment Success !');
						}else{
							alert('Update Comment Fail !');
						}
					}, error:function(){
						alert("Error - Update Comment");
					}
				})
			}else if( rc == 'CR' ){
				$.ajax({
					type:"post",
					url:"/admin/comReplyUpdate.do",
					dataType:"json",
					data:{
						comno : no,
						comreply : content
					},
					beforeSend : function(xhr)
					{   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader(header, token);
					},
					success:function(data){
						$("#repUpdate-modal").css("display", "none");
						if( parseInt(data) == 1 ){
							if( content == null || content == '' ){
								$(".trCR" + no).html("");
								$(".trCRmodal" + no).html("");
							}else{
								$(".trCR" + no).html(
							        '<th><i class="bi bi-arrow-return-right fs-3"></i></th>' +
							        '<th><textarea rows="4" class="form-control border-white bg-white scrollspy-example contentCR'+no+'" readonly="readonly"></textarea></th>' +  
							        '<th><i class="bi bi-check-lg fs-3"></i></th>'
								);
								$(".trCRmodal" + no).html(
							        '<th><i class="bi bi-arrow-return-right text-white fs-3"></i></th>' + 
							        '<th><textarea rows="4" class="form-control text-white bg-transparent scrollspy-example contentCR'+no+'" style="border-color: transparent;" readonly="readonly"></textarea></th>' +  
							        '<th><i class="bi bi-check-lg text-white fs-3"></i></th>'
								);
							}
							$('.contentCR' + no).val( content );
							alert('Update Reply Success !');
						}else{
							alert('Update Reply Fail !');
						}
					}, error:function(){
						alert("Error - Update Reply");
					}
				})
			}
		}// /confirm
	})
	
	$("#repUpdate-cancel").on("click", function(e){
		e.preventDefault();
		$("#repUpdate-modal").css('display', 'none');
	})

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