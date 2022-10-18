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
	  <p class="fs-1 gyoon-redressed">History of Order</p>
	  
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
			  
			  <table class="table text-center">
			    <thead class="fs-5">
			    <tr>
			      <td>
			        Quantity
			      </td>
			      <td>
			        Price
			      </td>
			      <td>
			        Product
			      </td>
			      <td>
			        Result
			      </td>
			    </tr>
			    </thead>
			    <tbody>
			  	<tr> 
			      <td>
			        QUANTITY
			      </td>
			      <td>
			        PRICE2
			      </td>
			      <td>
			        PNAME
			      </td>
			      <td>
			      	<c:choose>
			      	  <c:when test="${ODRESULT == 0}">
				        Processing
			          </c:when>
			      	  <c:when test="${ODRESULT == 1}">
			            Completed
			          </c:when>
			          <c:otherwise>
			          	Error
			          </c:otherwise>
					</c:choose>
			      </td>
			  	</tr>
			  	</tbody>
			  </table>

			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-4 mx-1 button-hover" onclick="location.href='/mypage/myOrderIng.do'">Ordered</span>
			    <span class="p-1 px-3 mx-1 button-hover" onclick="location.href='/product/productCategory.do?kind=electric'">Shopping</span>
			  </div>
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	  	
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

</script>


<%@ include file="../includes/footer.jsp" %>