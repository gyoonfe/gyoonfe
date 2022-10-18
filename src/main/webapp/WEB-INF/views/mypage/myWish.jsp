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
	  <p class="fs-1 gyoon-redressed">Wish List</p>
	  
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
			    <thead class="fs-4">
			    <tr>
			      <td colspan="2">
			        Product
			      </td>
			      <td>
			        Wish
			      </td>
			    </tr>
			    </thead>
			    
			    <c:forEach var="wish" items="${wish_list}">
			  	<tr class="tr${wish.pseq}"> 
			  	  <td> 
					<a href="/product/productView.do?pseq=${wish.pseq}">
					  <img src="/upload_gyoontar/product/${wish.pimage}" alt="..." class="wish-size-cursor">
					</a>
			  	  </td>
			  	  <td>
					<a href="/product/productView.do?pseq=${wish.pseq}"><c:out value="${wish.pname}"/></a><br>
					<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${wish.price2}"/>
			  	  </td>
			  	  <td> 
			  	    <i class="gyoon-heart bi bi-heart-fill fs-3 ms-2 align-self-center btn-heart" data-pseq="${wish.pseq}"></i>
			  	  </td>
			  	</tr>
				</c:forEach>

			  </table>

			  <c:if test="${wish_list[0] == null}">
			    <p class="my-5 fs-3 gyoon-redressed">No Wish.</p>
			  </c:if>

			  <c:if test="${wish_list[0] != null}">
			  <div class="d-flex justify-content-center my-5">
				  <span class="p-1 px-4 button-hover" onClick="return checkDelete()">Delete All</span>
			  </div>
			  </c:if>
			  
			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	   	  
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div> <!-- /container with sidebar -->
    
</div><!-- /gyoon-sidebar-container -->

</div><!-- /제일 바깥 container -->

</body>
</html>

<style>
.table td{
	vertical-align: middle;
}
</style>

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
		var all_delete = '<c:out value="${all_delete}"/>';
		if( all_delete != null && all_delete != "" && !history.state ){
			if( parseInt(all_delete) > 0 ){
				alert('All Wish deleted successfully !');
			}else{
				alert('Error - All Wish Delete !');
			}
		}
		history.replaceState({},null,null);
	})
	
	$(".btn-heart").on("click", function(){
		var userid = '<c:out value="${session_userid}"/>';
		var pseq = $(this).data('pseq');
		if( confirm('You want to delete this product in Wish List?') ){
			$.ajax({
				type:"get",
				url:"/product/deleteWish.do?pseq=" + pseq + "&userid=" + userid,
				success:function(data){
					console.log(data); // count of pseq's wish
					$(".tr" + pseq).detach();
					alert('Delete Wish Success !');
				}, error:function(){
					alert("Error - Delete Wish");
				}
			})	
		}
	})
	
	function checkDelete(){
		if( confirm('You really want to delete all items in wish list?') ){
			location.href = "/mypage/deleteAllWish.do?userid=${session_userid}";
		}else{
			return false;
		}
	}
	
</script>



<%@ include file="../includes/footer.jsp" %>