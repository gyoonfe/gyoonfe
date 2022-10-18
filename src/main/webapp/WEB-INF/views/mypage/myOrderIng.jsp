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

	<!-- Mypage Carousel -->
	<%@ include file="../includes/mypageCarousel.jsp" %>

<div class="gyoon-sidebar-container">

<!-- Mypae Side Bar -->
<%@ include file="../includes/mypageSide.jsp" %>

<div class="container">
	
	<div class="row my-5 gyoon-link" align="center">
	  <p class="fs-1 gyoon-redressed">Order List<br>( Processing )</p>
	  
	  <div class="d-flex justify-content-end align-items-center mb-3">
		<form method="post" action="/product/productSearch.do" name="productSearchForm" class="me-3">
		  <input class="form-control border-dark " type="search" name="pname" placeholder="Search" aria-label="Search">
		</form>  
		<span class="p-1 px-3 button-hover" onClick="return submitSearch()">Search</span>	
	  </div>
	  
	  <hr>

	  <div class="gyoon-pd-mg"> 
	  
		  <!-- Mypae Nav Bar -->
		  <%@ include file="../includes/mypageNav.jsp" %>
		
		  <div class="row my-5">		  
			<div class="col-md-12">
			  
			  <table class="table text-center mt-5">
			    <thead class="fs-5">
			    <tr>
			      <td>
			        Date
			      </td>
			      <td>
			        Order Code
			      </td>
			      <td>
			        Product
			      </td>
			      <td>
			        Payment Amount
			      </td>
			    </tr>
			    </thead>
			    <tbody>
			    
			    <c:forEach var="oVO" items="${order_list}" begin="0" end="9">
			  	<tr> 
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${oVO.oregdate}"/>
			      </td>
			      <td>
			        <c:out value="${oVO.oseq}"/>
			      </td>
			      <td>
			        <a href="/mypage/myOrderDetail.do?userid=${session_userid}&oseq=${oVO.oseq}"><c:out value="${oVO.pname}"/></a>
			      </td>
			      <td>
			        <fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${oVO.price2}"/>
			      </td>
			  	</tr>
			  	</c:forEach>
			  	
			  	</tbody>
			  </table>

			  <c:if test="${order_list[0] == null}">
			  	<p class="my-5 fs-3 gyoon-redressed">'No orders in List'</p>
			  </c:if>

			  <c:if test="${order_list[10] != null}">
			  <div class="d-flex justify-content-center my-5">
			    <span class="p-1 px-4 button-hover" id="btn-modal">Show All</span>
			  </div>
			  </c:if>
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	   	  
<!-- Modal -------------------------------------------------------------------------------- -->
<div id="modal" class="modal-overlay">
	<div class="container gyoon-container d-flex justify-content-center">
	    <div class="modal-window scrollspy-example container">
	        <div class="title">
	            <h2 class="gyoon-redressed">Order (Processing)</h2>
	        </div>
	        <div class="close-area">X</div>
	        <div class="content">
			  <div class="gyoon-link gyoon-rep" align="center">
				<table class="table mt-5 text-center text-white">
				    <thead class="fs-5">
				    <tr>
				      <td>
				        Date
				      </td>
				      <td>
				        Order Code
				      </td>
				      <td>
				        Product
				      </td>
				      <td>
				        Payment Amount
				      </td>
				    </tr>
				    </thead>
				    <tbody>
				    
				    <c:forEach var="oVO" items="${order_list}">
				  	<tr> 
				      <td>
				        <fmt:formatDate pattern="yyyy-MM-dd" value="${oVO.oregdate}"/>
				      </td>
				      <td>
				        <c:out value="${oVO.oseq}"/>
				      </td>
				      <td>
				        <a href="/mypage/myOrderDetail.do?userid=${session_userid}&oseq=${oVO.oseq}" class="text-white"><c:out value="${oVO.pname}"/></a>
				      </td>
				      <td>
				        <fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${oVO.price2}"/>
				      </td>
				  	</tr>
				  	</c:forEach>
				  	
				  	</tbody>
			  	</table>
			  </div>
	        </div>
	    </div>	
	</div>
</div>
<!-- /Modal -------------------------------------------------------------------------------- --> 
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div> <!-- /container with sidebar -->
    
</div><!-- /gyoon-sidebar-container -->

</div><!-- /제일 바깥 container -->

</body>
</html>

<script type="text/javascript">
	function submitSearch(){
		if(document.productSearchForm.pname.value.length == 0){
			alert('Please input product name for searching.');
			document.productSearchForm.pname.focus();
			return false;
		}
		document.productSearchForm.submit();
	}

	$(document).ready(function() {
		var detail_result = '<c:out value="${detail_result}"/>';
		if( detail_result != null && detail_result != "" && !history.state ){
			if( parseInt(detail_result) == 1 ){
				alert('Order Success !');
			}else{
				alert('Error - Order Fail !');
			}
		}
		var cart_result = '<c:out value="${cart_result}"/>';
		var len_result = '<c:out value="${len_result}"/>';
		if( cart_result != null && cart_result != "" && len_result != null && len_result != "" && !history.state ){
			if( parseInt(cart_result) == parseInt(len_result) ){
				alert('Order Success ! ' + '( ' + cart_result + ' )');
			}else{
				alert('Error - Order Fail ( ' + cart_result + ' / ' + len_result + ' )');
			}
		}
		history.replaceState({},null,null);
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
</script>

<%@ include file="../includes/footer.jsp" %>