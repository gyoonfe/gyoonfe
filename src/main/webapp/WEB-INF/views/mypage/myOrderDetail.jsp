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
	  <p class="fs-1 gyoon-redressed">Detail of Order</p>
	  
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

			  <p class="fs-3 gyoon-redressed mt_100">Order Information</p>
			  <hr>
			  
			  <table class="table text-center my-5">
			  	<thead class="fs-5">
			  	<tr>
			  	  <td style="width: 20%;">ZipCode</td>
			  	  <td>Address</td>
			  	  <td>Detail</td>
			  	</tr>
			  	</thead>
			  	<tr>
			  	  <td><input class="form-control bg-white box" type="text" name="ozipcode" id="sample2_postcode" value="${oVO.ozipcode}" readonly></td>
			  	  <td><input class="form-control bg-white box" type="text" name="oaddress1" id="sample2_address" value="${oVO.oaddress1}" readonly></td>
			  	  <td><input class="form-control bg-white box" type="text" name="oaddress2" id="sample2_detailAddress" value="${oVO.oaddress2}" readonly></td>
			  	</tr>
			  </table>
			  
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
			        Orderer
			      </td>
			      <td>
			        Payment Amount
			      </td>
			    </tr>
			    </thead>
			    <tbody>
			  	<tr> 
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${oVO.oregdate}"/>
			      </td>
			      <td>
			        <c:out value="${oVO.oseq}"/>
			      </td>
			      <td>
			        <c:out value="${oVO.userid}"/>
			      </td>
			      <td>
			        <fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${oVO.price2}"/>
			      </td>
			  	</tr>
			  	</tbody>
			  </table>

			  <p class="fs-3 gyoon-redressed mt_100">Details</p>
			  <hr>
			  
			  <table class="table text-center">
			    <thead class="fs-5">
			    <tr>
			      <td>
			        Detail Code
			      </td>
			      <td>
			        Product
			      </td>
			      <td>
			        Quantity
			      </td>
			      <td>
			        Price
			      </td>
			      <td>
			        Result
			      </td>
			    </tr>
			    </thead>
			    <tbody>
			    
			    <c:forEach var="odVO" items="${detail_list}">
			  	<tr> 
			      <td>
			        <c:out value="${odVO.odseq}"/>
			      </td>
			      <td>
			        <a href="/product/productView.do?pseq=${odVO.pseq}"><c:out value="${odVO.pname}"/></a>
			      </td>
			      <td>
			        <c:out value="${odVO.odquantity}"/>
			      </td>
			      <td>
			        <fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${odVO.price2}"/>
			      </td>
			      <td>
			      	<c:choose>
			      	  <c:when test="${odVO.odresult == 0}">
				        Unprocessed
			          </c:when>
			      	  <c:when test="${odVO.odresult == 1}">
			            <i class="bi bi-check fs-5 text-success"></i>Processed
			          </c:when>
			          <c:otherwise>
			          	Error
			          </c:otherwise>
					</c:choose>
			      </td>
			  	</tr>
			  	</c:forEach>
			  	
			  	</tbody>
			  </table>
			  
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