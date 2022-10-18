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
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
	  		  <p class="fs-2 mt-5 gyoon-redressed">Product List <span class="fs-4"> ( Total : <c:out value="${pageVO.total}"/> )</span></p>
	  		  <hr>
	  		  
			  <form method="post" action="/admin/product.do" id="categoryForm" class="mx-2"> 
			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	          <input type="hidden" name="pageNum" value="1">
	          <input type="hidden" name="amount" value="10"> 
	          <input type="hidden" name="onKind" value="y"> 
			  <div class="d-flex justify-content-end align-items-center my-5">
			  	  <div class="me-3">
				      <select name="category">
					    <option value="electric">Electric</option>
					    <option value="acoustic">Acoustic</option>
					    <option value="amp">Amp</option>
					    <option value="acc">Acc</option>
				      </select>
			  	  </div>
		          <div>
					  <span class="p-1 px-3 button-hover" onClick="document.getElementById('categoryForm').submit()">Show</span>	
				  </div>
			  </div>
			  </form> 
	  		  
	  		  <form method="post" action="productDelete.do" name="productForm">
	  		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			  <table class="table text-center">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Idx
			      </td>
			      <td>
			        P.Name
			        <span class="fs-5 text-danger">(Comment)</span>
			      </td>
			      <td>
			        Stock
			      </td>
			      <td>
			        Price
			      </td>
			      <td>
			        Date
			      </td>
			      <td>
			        Best
			      </td>
			      <td>
			        Sale
			      </td>
			      <td>
			      	Del
			      </td>
			    </tr>
			    </thead>
			    
			    <c:set var="idx" value="${pageVO.total - ((pageVO.cri.pageNum - 1) * pageVO.cri.amount)}"/>
			    <c:forEach var="product" items="${product_list}">
			  	<tr> 
			      <td>
			        <c:out value="${idx}"/>
			      </td>
			      <td>
			        <a href="/admin/productView.do?pseq=${product.pseq}">
			          <c:out value="${product.pname}"/>
			          <c:if test="${product.noRepComCount > 0}">
			            <span class="fs-5 text-danger">${product.noRepComCount}</span>
			          </c:if>
			        </a>
			      </td>
			      <td>
			        <c:out value="${product.pquantity}"/>
			      </td>
			      <td>
			        <c:out value="${product.price2}"/>
			      </td>
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${product.pregdate}"/>
			      </td>
			      <td>
			        <c:choose>
			        <c:when test="${product.bestyn == 1}">
			         Y
			        </c:when>
			        <c:otherwise>
			         N
			        </c:otherwise>
			        </c:choose>
			      </td>
			      <td>
			        <c:choose>
			        <c:when test="${product.saleyn == 1}">
			         Y
			        </c:when>
			        <c:otherwise>
			         N
			        </c:otherwise>
			        </c:choose>
			      </td>
			      <td>
			      	<input class="form-check-input" type="checkbox" name="pseq" value="${product.pseq}">
			      </td>
			  	</tr>
			  	<c:set var="idx" value="${idx - 1}"/>
			  	</c:forEach>
			  	
			  </table>
			  </form>
			  
			  <c:if test="${product_list[0] == null}">
			  	<p class="fs-3 my-5">No Result found for '${pageVO.cri.keyword}'</p>
			  </c:if>
			  
			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-3 button-hover" onClick="location.href='/admin/productWrite.do'">Write</span>
				<span class="p-1 px-3 mx-4 button-hover" onClick="return checkDelete()">Delete</span>
				<span class="p-1 px-4 button-hover" onClick="location.href='/admin/product.do'">List</span>
			  </div>
			  
			  <div class="d-flex justify-content-center my-5">
			    <div class=" fs-4">
				  
				  <c:if test="${pageVO.prev}">
				    <a href="product.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=1&amount=${pageVO.cri.amount}&onKind=${onKind}&category=${kind}"><i class="bi bi-chevron-double-left"></i></a> 
				    <a href="product.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.startPage - 1}&amount=${pageVO.cri.amount}&onKind=${onKind}&category=${kind}"><i class="bi bi-caret-left-square"></i></a> 
				  </c:if>
		
				  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
					<a href="product.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${num}&amount=${pageVO.cri.amount}&onKind=${onKind}&category=${kind}" class="${pageVO.cri.pageNum == num ? 'border border-dark rounded-3 px-2' : ''}">${num}</a> 			
				  </c:forEach>
				  
				  <c:if test="${pageVO.next}">
				    <a href="product.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.endPage + 1}&amount=${pageVO.cri.amount}&onKind=${onKind}&category=${kind}"><i class="bi bi-caret-right-square"></i></a> 
				    <a href="product.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.realEnd}&amount=${pageVO.cri.amount}&onKind=${onKind}&category=${kind}"><i class="bi bi-chevron-double-right"></i></a> 
				  </c:if>
				  
			    </div>
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

$(document).ready(function() {
	var insert_result = '<c:out value="${insert_result}"/>';
	if( insert_result != null && insert_result != "" && !history.state ){
		if( parseInt(insert_result) == 1 ){
			alert('Product Insert Success !');
		}else{
			alert('Product Insert Fail !');
		}
	}
	var update_result = '<c:out value="${update_result}"/>';
	if( update_result != null && update_result != "" && !history.state ){
		if( parseInt(update_result) == 1 ){
			alert('Product Update Success !');
		}else{
			alert('Product Update Fail !');
		}
	}
	var delete_result = '<c:out value="${delete_result}"/>';
	if( delete_result != null && delete_result != "" && !history.state ){
		alert( delete_result );
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

function checkDelete(){
	var count = 0;
	if( document.productForm.pseq.length == undefined ){
		if( document.productForm.pseq.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.productForm.pseq.length; i++ ){
			if( document.productForm.pseq[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check products you want to delete from product list.");
		document.productForm.focus();
		return false;
	}else{
		if( confirm("You sure to delete "+count+" products from List?") ){
			document.productForm.submit();
		} else{
		 return false;	
		}
	}
}
</script>


<%@ include file="../includes/footer.jsp" %>