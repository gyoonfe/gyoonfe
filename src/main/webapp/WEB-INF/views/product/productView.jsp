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

	<!-- Index Carousel -->
	<%@ include file="../includes/indexCarousel.jsp" %>

<div class="gyoon-sidebar-container">

	<!-- Product Side Bar -->
	<%@ include file="../includes/productSide.jsp" %>

<div class="container">
	
	<div class="row my-5 gyoon-link" align="center">
	  <p class="fs-1 gyoon-redressed">Product Name</p>
	  
	  <form method="get" action="/product/productSearch.do" name="productSearchForm" class="mx-2"> 
	  <div class="d-flex justify-content-end align-items-center mb-3">
	  	  <div>
		      <select name="type">
			    <option value="">Select</option>
			    <option value="N">Name</option>
			    <option value="C">Content</option>
			    <option value="NC">Both</option>
		      </select>
	  	  </div>
	  	  <div class="mx-2">
			  <input class="form-control border-dark" type="search" name="keyword" placeholder="Search" aria-label="Search">
	          <input type="hidden" name="pageNum" value="1">
	          <input type="hidden" name="amount" value="12"> 
          </div>
          <div>
			  <span class="p-1 px-3 button-hover" onClick="return submitSearch()">Search</span>	
		  </div>
	  </div>
	  </form> 
	  
	  <hr>
	  
	  <div class="gyoon-pd-mg"> 
		  
		  <form method="post" action="/mypage/order.do" name="orderForm">
		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		  <input type="hidden" name="pseq" value="${pVO.pseq}">
		  <input type="hidden" name="userid" id="userid" value="${session_userid}">
		  <div class="row my-5">		  
			<div class="col-md-6 mb-5">
			  <div class="d-flex justify-content-center gyoon-redressed">
			  	<c:if test="${pVO.bestyn != null && pVO.bestyn == 1}">
			  	  <p class="px-3 mx-1 fs-3 border border-danger text-danger">Best</p>
			  	</c:if>
			  	<c:if test="${pVO.saleyn != null && pVO.saleyn == 1}">
			  	  <p class="px-3 mx-1 fs-3 border border-danger text-danger">Sale</p>
			  	</c:if>
			  </div>
			  <div class="gyoon-img-hover">
					<img src="/upload_gyoontar/product/${pVO.pimage}" class="img-thumbnail shadow-sm pimage-size" alt="...">
			  </div>
			</div>		
			
			<div class="col-md-6 d-flex flex-column">
			  <div class="fs-3 my-5 text-start">
			  
				<p class="mb-5"><c:out value="${pVO.pname}"/></p>
				<input type="hidden" name="pname" id="pname" value="${pVO.pname}">
				<hr>
				<p class="mb-5 fs-5">
				  	<c:choose>
				  	<c:when test="${pVO.kind eq 'electric'}">
				  		Electic Guitar
				  	</c:when>	  	
				  	<c:when test="${pVO.kind eq 'acoustic'}">
				  		Acoustic Guitar
				  	</c:when>
				  	<c:when test="${pVO.kind eq 'amp'}">
				  		Amplifier
				  	</c:when>
				  	<c:when test="${pVO.kind eq 'acc'}">
				  		Accessory
				  	</c:when>
				  	<c:otherwise>
				  		Category
				  	</c:otherwise>
				  	</c:choose>
				</p>
				<hr>
				<div class="gyoon-dropdown mb-5">
					<p class="fs-5 mb-0">In Stock.</p>
					<select class="form-select-sm border-dark rounded-0" name="odquantity" id="pquantity" aria-label=".form-select-sm example">
					  <option value="1"> 1 </option>
					  <option value="2"> 2 </option>
					  <option value="3"> 3 </option>
					  <option value="4"> 4 </option>
					  <option value="5"> 5 </option>
					  <option value="6"> 6 </option>
					  <option value="7"> 7 </option>
					  <option value="8"> 8 </option>
					  <option value="9"> 9 </option>
  					  <option value="10"> 10 </option>
					</select>
				</div>
				
				<div class="mb-5">
				  <p>
				  	Price : 
				  	<span class="onPrice">
				  		<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${pVO.price2}"/>
				  	</span>
				  </p>
				</div>
			  </div>
			  
			  <div class="d-flex justify-content-center">
				  <span class="p-1 px-3 mx-1 button-hover" onClick="return checkBuyNow()">BuyNow</span>
				  <span class="p-1 px-4 mx-1 button-hover" onClick="return checkCart()">Cart</span>    
			      <span class="p-1 px-4 mx-1 button-hover" onClick="location.href='/product/productCategory.do?category=${pVO.kind}'">List</span>
			      
			      <sec:authorize access="isAuthenticated()">
			      <c:set var="contain" value="n"/>
			      <c:forEach var="wish" items="${wish_list}">
			        <c:if test="${wish.userid eq session_userid}">
			          <c:set var="contain" value="y"/>
			        </c:if>
			      </c:forEach>
			      
			      <c:choose>
			        <c:when test="${contain eq 'y'}">
			          <i class="gyoon-heart bi bi-heart-fill fs-3 ms-2 align-self-center" id="btn-heart" data-status="fill"></i>
			          <span class="p-2" id="wishCount">${wishCount}</span>
			        </c:when>
			        <c:otherwise>
			          <i class="gyoon-heart bi bi-heart fs-3 ms-2 align-self-center" id="btn-heart" data-status="empty"></i>
			          <span class="p-2" id="wishCount">${wishCount}</span>
			        </c:otherwise>
			      </c:choose>
			      </sec:authorize>
			  </div>
			</div>	
		  </div>
	   	  </form>
	   	  
		<!-- comment & review (product) -->
		<div class="gyoon-com-rev">
		<ul class="nav nav-tabs gyoon-com-rev" id="myTab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Review</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Comment(QnA)</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#good" type="button" role="tab" aria-controls="good" aria-selected="false">Detail</button>
		  </li>
		</ul>
		<div class="tab-content" id="myTabContent">
		  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab"> <!-- REVIEW start -->
			  <form method="post" action="revWrite.do" name="revWrite">
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
			          <br>
			          <a class="text-white" href="revDelete.do?revno=${review.revno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Review?')">Delete</a>
			          </c:if>
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
			        	<textarea rows="5" class="form-control border-white bg-white scrollspy-example contentR${review.revno}" readonly><c:out value="${review.revcontent}"/></textarea>
			        </th>
			        <th>
			          <c:if test="${review.userid eq session_userid}">
			          <a href="" class="repUpdate" data-no="${review.revno}" data-rc="r">Update</a>
			          <br>
			          <a href="revDelete.do?revno=${review.revno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Review?')">Delete</a>
			          </c:if>
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
			  <form method="post" action="comWrite.do" name="comWrite">
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
			          <br>
			          <a class="text-white" href="comDelete.do?comno=${comment.comno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Comment?')">Delete</a>
			          </c:if>
			        </th>	        
			      </tr>
			      
			      <c:if test="${comment.comreply != null && comment.comreply ne ''}">
			      <tr>
			        <th><i class="bi bi-arrow-return-right text-white fs-3"></i></th>
			        <th><textarea rows="4" class="form-control text-white bg-transparent border_trans scrollspy-example" readonly><c:out value="${comment.comreply}"/></textarea></th>  
			        <th><i class="bi bi-check-lg text-white fs-3"></i></th>
			      </tr>
			      </c:if>
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
			        <th><textarea rows="4" class="form-control border-white bg-white scrollspy-example contentC${comment.comno}"><c:out value="${comment.comcontent}"/></textarea></th>
			        <th>
			          <c:if test="${comment.userid eq session_userid}">
			          <a href="" class="repUpdate" data-no="${comment.comno}" data-rc="c">Update</a>
			          <br>
			          <a href="comDelete.do?comno=${comment.comno}&userid=${session_userid}&pseq=${pVO.pseq}" onClick="return confirm('You sure to delete this Comment?')">Delete</a>
			          </c:if>
			        </th>	        
			      </tr>
			      
			      <c:if test="${comment.comreply != null && comment.comreply ne ''}">
			      <tr>
			        <th><i class="bi bi-arrow-return-right fs-3"></i></th>
			        <th><textarea rows="4" class="form-control border-white bg-white scrollspy-example"><c:out value="${comment.comreply}"/></textarea></th>  
			        <th><i class="bi bi-check-lg fs-3"></i></th>
			      </tr>
			      </c:if>
				</c:forEach>

			  	</table>
			  	
				<c:if test="${comment_list[0] == null}">
				  <p class="my-5 fs-3 gyoon-redressed">No Comment Yet</p>
				</c:if>
			  	
			  </div>
		  </div> <!-- COMMENT end -->
		  
		  <div class="tab-pane fade" id="good" role="tabpanel" aria-labelledby="good-tab"> <!-- Detail start -->
			<div class="mt_100 mb_100 px-2">
				${pVO.pcontent}
			</div>
		  </div> <!-- Detail end -->
		  
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
	  	
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div> <!-- /container with sidebar -->
    
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
		var cart_result = '<c:out value="${cart_result}"/>';
		if( cart_result != null && cart_result != "" && !history.state ){
			if( parseInt(cart_result) == 1 ){
				if( confirm('Cart Add Success ! You want to go MyCart?') ){
					location.href="/mypage/myCart.do?userid=${session_userid}";	
				}
			}else{
				alert('Cart Add Fail !');
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
	
	$("#pquantity").on("change", function(){
	    var price = <c:out value="${pVO.price2}" />
	    var quantity = $("option:selected", this).attr("value");
	    var quantity = parseInt(quantity);
	    var total = parseInt(price) * quantity;
	    var regexp=/\B(?=(\d{3})+(?!\d))/g;
	    var total = total.toString().replace(regexp,',');
	    $(".onPrice").html("&#8361;" + total);
	});
	
	function checkBuyNow(){
		if( $("#userid").val() != '' ){
			if(confirm('Go to order ' + document.getElementById("pquantity").value + ' of ' + document.getElementById("pname").value)){
				document.orderForm.submit();
			}else{
				return false;
			}
		}else{
			alert('You must have account to buy products.');
			return false;
		}
	}
	
	function checkCart(){
		if( $("#userid").val() != '' ){
			if(confirm('You want to add ' + document.getElementById("pquantity").value + ' of ' + document.getElementById("pname").value + ' in Cart?')){
				document.orderForm.action = '/mypage/myCart.do';
				document.orderForm.submit();
			}else{
				return false;
			}
		}else{
			alert('You must have account to add products in cart.');
			return false;
		}
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
	
	$("#btn-heart").on("click", function(){
		var userid = '<c:out value="${session_userid}"/>';
		var pseq = '<c:out value="${pVO.pseq}"/>';
		if( $(this).data("status") == 'empty' ){
			$.ajax({
				type:"get",
				url:"/product/addWish.do?pseq=" + pseq + "&userid=" + userid,
				success:function(data){
					console.log(data);
					$("#wishCount").html(data);
					$("#btn-heart").removeClass("bi-heart");
					$("#btn-heart").addClass("bi-heart-fill");
					$("#btn-heart").data('status', 'fill');
					alert('Add Wish Success !');
				}, error:function(){
					alert("Error - Wish Update");
				}
			})
		}else{
			$.ajax({
				type:"get",
				url:"/product/deleteWish.do?pseq=" + pseq + "&userid=" + userid,
				success:function(data){
					console.log(data);
					$("#wishCount").html(data);
					$("#btn-heart").removeClass("bi-heart-fill");
					$("#btn-heart").addClass("bi-heart");
					$("#btn-heart").data('status', 'empty');
					alert('Delete Wish Success !');
				}, error:function(){
					alert("Error - Wish Update");
				}
			})
		}//else
	})
	
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
		e.preventDefault();
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
		}// /else
	})

	$("#repUpdate-write").on("click", function(e){
		e.preventDefault();
		if( confirm('You really want to update this Review/Comment?') ){
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
			}// /else
		}// /confirm
	})
	
	$("#repUpdate-cancel").on("click", function(e){
		e.preventDefault();
		$("#repUpdate-modal").css('display', 'none');
	})

</script>



<%@ include file="../includes/footer.jsp" %>