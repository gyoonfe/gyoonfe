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

	<!-- Join Carousel -->
	<%@ include file="../includes/joinCarousel.jsp" %>
	
	<form name="contractForm">
	<div class="row my-5" align="center">
	
	  <p class="fs-1 gyoon-redressed">Join</p>	
	  <hr>
	
	  <div class="my-5 text-start px_200">
	  <div class="border border-dark p-0"><!-- scroll spy -->
		<nav id="navbar-example2" class="navbar navbar-light bg-dark px-3 m-0">
		  <p class="navbar-brand fs-3 text-white">Gyoon's <span class="fs-5">( Gyoontar )</span></p>
		</nav>
		<div data-bs-spy="scroll" data-bs-target="#navbar-example2" data-bs-offset="10" class="scrollspy-example p-3 gyoon-contract" tabindex="0">
		  <br>
		  <br>
		  <!-- Contract Content -->
		  <%@ include file="../includes/contractContent.jsp" %>
		</div>
	  </div>
	  </div>
	  
	  <div class="d-flex justify-content-center my-3">
		<div class="form-check mx-2">
		  <input class="form-check-input" type="radio" name="flexRadioDefault" value="y" id="flexRadioDefault1">
		  <label class="form-check-label" for="flexRadioDefault1">
		    Agree
		  </label>
		</div>
		<div class="form-check mx-2">
		  <input class="form-check-input" type="radio" name="flexRadioDefault" value="n" id="flexRadioDefault2" checked>
		  <label class="form-check-label" for="flexRadioDefault2">
		    Disagree
		  </label>
		</div>
	  </div>
	  
	  <div class="d-flex justify-content-center mt-5 mb-5">
	    <div class="">
		  <span class="p-1 px-4 border border-2 border-dark button-hover" onClick="return checkContract()">Join</span>    
	      <span class="p-1 px-3 border border-2 border-dark button-hover" onClick="location.href='login.do'">Log in</span>
	      <span class="p-1 px-3 border border-2 border-dark button-hover" onClick="location.href='/index/index.do'">Home</span>
	    </div>
	  </div>
	  
	</div><!-- /row -->
	</form>  

	
</div> <!-- /container -->


</body>
</html>

<script type="text/javascript">
	function checkContract(){
		if(document.contractForm.flexRadioDefault.value == 'n'){
			alert('You should agree on Terms of service to join Gyoontar');
			return false;
		}
		location.href="/member/join.do";
	}
</script>

<%@ include file="../includes/footer.jsp" %>