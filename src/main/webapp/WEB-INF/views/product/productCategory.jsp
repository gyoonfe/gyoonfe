﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	  <p class="fs-1 gyoon-redressed">
	  	<c:choose>
	  	<c:when test="${pageVO.cri.category eq 'electric'}">
	  		Electic Guitar
	  	</c:when>	  	
	  	<c:when test="${pageVO.cri.category eq 'acoustic'}">
	  		Acoustic Guitar
	  	</c:when>
	  	<c:when test="${pageVO.cri.category eq 'amp'}">
	  		Amplifier
	  	</c:when>
	  	<c:when test="${pageVO.cri.category eq 'acc'}">
	  		Accessory
	  	</c:when>
	  	<c:otherwise>
	  		Category
	  	</c:otherwise>
	  	</c:choose>
	  </p>
	  
	  <form method="get" action="/product/productCategory.do" name="productSearchForm" class="mx-2"> 
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
			  <input type="hidden" name="category" value="${pageVO.cri.category}">
	          <input type="hidden" name="pageNum" value="1">
	          <input type="hidden" name="amount" value="12"> 
          </div>
          <div>
			  <span class="p-1 px-3 button-hover" onClick="return submitSearch()">Search</span>	
		  </div>
	  </div>
	  </form> 
	  
	  <hr>
	  
	  <div class="row gyoon-pd-mg">
		
		<!-- Best product Carousel -->
		<%@ include file="../includes/productBest.jsp" %>
		  
		<p class="fs-2 mt-5 gyoon-redressed">Product <span class="fs-3">( Total : ${pageVO.total} )</span></p>
		<hr>  
		
		<c:forEach var="product" items="${product_list}">
		  <div class="col-md-3 mb-5">
		  	<div class="gyoon-img-hover">
	   		  <a href="/product/productView.do?pseq=${product.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
	   		  	<img src="/upload_gyoontar/product/${product.pimage}" class="img-thumbnail pimage-size" alt="...">
	   		  </a>
		  	</div>
		    <div class="d-flex flex-column my-3">
		      <a href="/product/productView.do?pseq=${product.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
		      	<span class="fw-bolder"><c:out value="${product.pname}"/></span>
		      </a>
		      <a href="/product/productView.do?pseq=${product.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
		      	<span class="gyoon-price"><fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${product.price2}"/></span>
		      </a>
		    </div>
		  </div>
		</c:forEach>
		  
		<c:if test="${product_list[0] == null}">
		  <p class="my-5 fs-3 gyoon-redressed">No Results found for '${pageVO.cri.keyword}'</p>
		</c:if>
		
		  <div class="d-flex justify-content-center my-5">
		    <div class=" fs-4">
			  
			  <c:if test="${pageVO.prev}">
			    <a href="productCategory.do?category=${pageVO.cri.category}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=1&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-left"></i></a> 
			    <a href="productCategory.do?category=${pageVO.cri.category}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.startPage - 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-left-square"></i></a> 
			  </c:if>
	
			  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
				<a href="productCategory.do?category=${pageVO.cri.category}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${num}&amount=${pageVO.cri.amount}" class="${pageVO.cri.pageNum == num ? 'border border-dark rounded-3 px-2' : ''}">${num}</a> 			
			  </c:forEach>
			  
			  <c:if test="${pVO.next}">
			    <a href="productCategory.do?category=${pageVO.cri.category}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.startPage + 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-right-square"></i></a> 
			    <a href="productCategory.do?category=${pageVO.cri.category}&type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.realEnd}&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-right"></i></a> 
			  </c:if>
			  
		    </div>
		  </div>
		
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div> <!-- /container with sidebar -->
    
</div><!-- /gyoon-sidebar-container -->

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
</script>

<%@ include file="../includes/footer.jsp" %>