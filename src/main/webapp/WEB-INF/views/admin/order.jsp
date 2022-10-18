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
	  <p class="fs-1 gyoon-redressed">Admin</p>
	  
	  <form method="get" action="/admin/order.do" name="orderSearchForm" class="mx-2"> 
	  <div class="d-flex justify-content-end align-items-center mb-3">
	  	  <div>
		      <select name="type">
			    <option value="">Select</option>
			    <option value="N">Name</option>
			    <option value="P">Product</option>
			    <option value="Z">Zip code</option>
			    <option value="NPZ">All</option>
		      </select>
	  	  </div>
	  	  <div class="mx-2">
			  <input class="form-control border-dark" type="search" name="keyword" placeholder="Search" aria-label="Search">
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
	  		  <p class="fs-2 mt-5 gyoon-redressed">Order List <span class="fs-4"> ( Total : <c:out value="${pageVO.total}"/> )</span></p>
	  		  <hr>
	  		  
	  		  <form method="get" action="/admin/orderCheck.do" name="orderForm">
	  		  <input type="hidden" name="pageNum" value="${pageVO.cri.pageNum}">
	  		  <input type="hidden" name="amount" value="${pageVO.cri.amount}">
			  <table class="table text-center">
			    <thead class="fs-4">
			    <tr>
			      <td>
			        Code
			      </td>
			      <td>
			        Name
			      </td>
			      <td>
			        Product
			      </td>
			      <td>
			        Quantity
			      </td>
			      <td>
			        ZipCode
			      </td>
			      <td>
			      	Address
			      </td>
			      <td>
			      	Tel
			      </td>
			      <td>
			      	Date
			      </td>
			    </tr>
			    </thead>
			    
			    <c:set var="idx" value="${pageVO.total - ((pageVO.cri.pageNum - 1) * pageVO.cri.amount)}"/>
			    <c:forEach var="order" items="${order_list}">
			  	<tr> 
			      <td>
			        <c:out value="${order.odseq}"/>
			        <c:choose>
			          <c:when test="${order.odresult == 0}">
			            <input class="form-check-input" type="checkbox" name="odseq" value="${order.odseq}"><br>
			            Unprocessed
			          </c:when>
			          <c:when test="${order.odresult == 1}">
			            <i class="bi bi-check fs-5 text-success"></i><br>
			            <span class="text-success">Processed</span> 
			          </c:when>
			          <c:otherwise>
			            Error
			          </c:otherwise>
			        </c:choose>
			      </td>
			      <td>
			        <c:out value="${order.mname}"/><br>
			        ( <c:out value="${order.userid}"/> )
			      </td>
			      <td>
			        <a href="/product/productView.do?pseq=${order.pseq}"><c:out value="${order.pname}"/></a>
			      </td>
			      <td>
			        <c:out value="${order.odquantity}"/>
			      </td>
			      <td>
			        <c:out value="${order.ozipcode}"/>
			      </td>
			      <td>
			        <c:out value="${order.oaddress1} ( ${order.oaddress2} )"/>
			      </td>
			      <td>
			        <c:out value="${order.phone}"/>
			      </td>
			      <td>
			        <fmt:formatDate pattern="yyyy-MM-dd" value="${order.oregdate}"/>
			      </td>
			  	</tr>
			  	<c:set var="idx" value="${idx - 1}"/>
			  	</c:forEach>
			  	
			  </table>
			  </form>
			  
			  <c:if test="${order_list[0] == null}">
			  	<p class="gyoon-redressed fs-3 my-5">No Result found for '${pageVO.cri.keyword}'</p>
			  </c:if>
			  
			  <div class="d-flex justify-content-center my-5">
				<span class="p-1 px-3 me-2 button-hover" onClick="return checkOrder()">Check</span>
				<span class="p-1 px-2 ms-2 button-hover" onClick="location.href='/admin/order.do'">Show All</span>
			  </div>
			  
			  <div class="d-flex justify-content-center my-5">
			    <div class=" fs-4">
				  
				  <c:if test="${pageVO.prev}">
				    <a href="order.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=1&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-left"></i></a> 
				    <a href="order.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.startPage - 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-left-square"></i></a> 
				  </c:if>
		
				  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
					<a href="order.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${num}&amount=${pageVO.cri.amount}" class="${pageVO.cri.pageNum == num ? 'border border-dark rounded-3 px-2' : ''}">${num}</a> 			
				  </c:forEach>
				  
				  <c:if test="${pageVO.next}">
				    <a href="order.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.endPage + 1}&amount=${pageVO.cri.amount}"><i class="bi bi-caret-right-square"></i></a> 
				    <a href="order.do?type=${pageVO.cri.type}&keyword=${pageVO.cri.keyword}&pageNum=${pageVO.realEnd}&amount=${pageVO.cri.amount}"><i class="bi bi-chevron-double-right"></i></a> 
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
	var len_result = '${len_result}';
	var count_result = '${count_result}';
	if( len_result != null && len_result != '' && count_result != null && count_result != '' && !history.state ){
		if( parseInt(len_result) == parseInt(count_result) ){
			alert('Checked Successfully ( ' + count_result + ' ) !');
		}else{
			alert('Error - Checked Fail ( ' + count_result + ' / ' + len_result + ' )');
		}
	}
	history.replaceState({},null,null);
})

function submitSearch(){
	if(document.orderSearchForm.keyword.value.length < 2){
		alert('Please input keyword at least 2 letters for searching.');
		document.orderSearchForm.keyword.focus();
		return false;
	}
	document.orderSearchForm.submit();
}

function checkOrder(){
	var count = 0;
	if( document.orderForm.odseq.length == undefined ){
		if( document.orderForm.odseq.checked == true ){
			count++;
		}
	}else{
		for( var i=0; i<document.orderForm.odseq.length; i++ ){
			if( document.orderForm.odseq[i].checked == true ){
				count++;
			}
		}
	}
	if( count == 0 ){
		alert("Please check Orders you want to make processed.");
		document.orderForm.focus();
		return false;
	}else{
		if( confirm("You sure to make "+count+" Orders processed?") ){
			document.orderForm.submit();
		} else{
		 return false;	
		}
	}
}
</script>


<%@ include file="../includes/footer.jsp" %>