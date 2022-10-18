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
	
	<div class="row my-5 gyoon-link">
	
	  <div class="text-center">
	  	  <p class="fs-1 gyoon-redressed">FAQ</p>
	  </div>
	  <hr>
	    <div class="gyoon-pd-mg">
	    
		<div class="accordion accordion-flush p-0 my-5 shadow" id="accordionFlushExample">
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="flush-headingOne">
		      <button class="accordion-button collapsed fs-3" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
		        How to pay?
		      </button>
		    </h2>
		    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
		      <div class="accordion-body bg_grey">
 				Not yet<br>
 				Sorry.
			  </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="flush-headingTwo">
		      <button class="accordion-button collapsed fs-3" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
		        What can I do to share my notes?
		      </button>
		    </h2>
		    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
		      <div class="accordion-body bg_grey">
 				Please use [Board] by writing post or comment<br>
 				 to communicate with everbody.
			  </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="flush-headingThree">
		      <button class="accordion-button collapsed fs-3" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
		        I want to use Gyoontar service offline.
		      </button>
		    </h2>
		    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
		      <div class="accordion-body bg_grey">
		      	We have 2 stores in KR, 2 stores in JP. So you can use this service offline.<br>
		      	If you want more information of offline store, 
		      	<span class="gyoon-link fs-5"><a href="/index/map.do">Click here.</a></span>
		      </div>
		    </div>
		  </div>
		</div>
		
		  <div class="d-flex justify-content-center my-5">
		    <span class="p-1 px-4 mx-1 button-hover" onclick="location.href='/index/index.do'">Home</span>
		    <sec:authorize access="isAnonymous()">
		      <span class="p-1 px-4 mx-1 button-hover" onclick="location.href='/member/login.do'">Login</span>
		    </sec:authorize>
		    <span class="p-1 px-3 mx-1 button-hover" onclick="location.href='/product/productCategory.do?category=electric'">Shopping</span>
		  </div>
		
		</div><!-- /padding div -->
	</div><!-- /row -->
	

	
</div> <!-- /container -->


</body>
</html>

<%@ include file="../includes/footer.jsp" %>