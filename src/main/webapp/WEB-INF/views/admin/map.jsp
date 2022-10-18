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
	  
	  <hr>

	  <div class="gyoon-pd-mg">
		  
		  <!-- Admin Nav -->
		  <%@ include file="../includes/adminNav.jsp" %>
		
		  <div class="row my-5">		  
			<div class="col-md-12">

	  		  <p class="fs-2 mt-5 gyoon-redressed">Store Register</p>
	  		  <hr>
	  		  <form method="post" action="/admin/regMap.do" id="regMapForm" enctype="multipart/form-data">
	  		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			  <table class="fs-5 align-middle label-bg boxes">
	            <tr>
	              <td width=30%><label for="autocomplete">Address</label></td>
	              <td>
					<div id="locationField">
					  <input class="form-control form-control-sm box" name="address1" id="autocomplete" placeholder="Enter address" type="text">
					</div>
	              </td>
	            </tr>
	            <tr>
	              <td><label for="address2">Detail</label></td>
	              <td>
					<div id="locationField">
					  <input class="form-control form-control-sm box" name="address2" id="address2" placeholder="Enter detail address" type="text">
					</div>
	              </td>
	            </tr>
	            <tr>
	              <td><label for="lat">LAT / LNG</label></td>
	              <td>
	                <input class="form-control form-control-sm box" type="text" name="lat" id="lat">
	                <input class="form-control form-control-sm box" type="text" name="lng" id="lng">
	              </td>
	            </tr>
	            <tr>
	              <td><label for="name">Name</label></td>
	              <td>
	                <input class="form-control form-control-sm box" type="text" name="name" id="name" placeholder="Enter name of branch store">
	              </td>
	            </tr>
	            <tr>
	              <td><label for="email">E-Mail</label></td>
	              <td>
	                <input class="form-control form-control-sm box" type="text" name="email" id="email" placeholder="branch@gmail.com">
	              </td>
	            </tr>
	            <tr>
	              <td><label for="phone">Tel</label></td>
	              <td>
	                <input class="form-control form-control-sm box" type="text" name="phone" id="phone">
	              </td>
	            </tr>
	            <tr>
	              <td><label for="uploadfile">Image</label></td>
	              <td>
	                <input class="form-control form-control-sm box" type="file" name="uploadfile" id="uploadfile">
	              </td>
	            </tr>
			  </table>
			  </form>
			   
			   
			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-3 me-2 button-hover" onClick="return checkReg()">Register</span>
			  </div>
			  
			  
			  <p class="fs-2 mt_100 mb-5 gyoon-redressed">Offline Store <span class="fs-4"> ( Total : <c:out value="${map_list.size()}"/> )</span></p>
			  <hr>
	  		  <form method="post" action="/admin/deleteMap.do" name="deleteMap">
	  		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			  <table class="table text-center align-middle">
	            <thead class="fs-3">
	            <tr>
	              <td>Name</td>
	              <td>Address</td>
	              <td>Tel</td>
	              <td>Email</td>
	              <td>LAT/LNG</td>
	            </tr>
	            </thead>
	            
	            <c:forEach var="map" items="${map_list}">
	            <tr>
	              <td>${map.name} <input class="form-check-input" type="checkbox" name="idx" value="${map.idx}"></td>
	              <td>${map.address1}<br>${map.address2}</td>
	              <td>${map.phone}</td>
	              <td>${map.email}</td>
	              <td>${map.lat}/<br>${map.lng}</td>
	            </tr>
	            </c:forEach>
			  </table>
			  </form>
			  
			  <div class="d-flex justify-content-center my-5">
			  	<span class="p-1 px-3 me-2 button-hover" onClick="return checkDelete()">Delete</span>
			  </div>
			  
			  <!-- Modal (image) -->
			  <div id="mprofile_modal">
			    <img src="" id="mprofile_modal_image" alt="...">
			  </div>
			  <!-- /Modal (image) -->

			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div>

</div><!-- /제일 바깥 container -->

</body>
</html>



<script>
	$(document).ready(function() {
		var reg_result = '<c:out value="${reg_result}"/>';
		if( reg_result != null && reg_result != "" && !history.state ){
			if( parseInt(reg_result) == 1 ){
				alert('Store Register Success !');
			}else{
				alert('Store Register Fail !');
			}
		}
		var delete_result = '<c:out value="${delete_result}"/>';
		if( delete_result != null && delete_result != "" && !history.state ){
			if( parseInt(delete_result) > 0 ){
				alert('Store Delete '+delete_result+' Success !');
			}else{
				alert('Store Delete '+delete_result+' Fail !');
			}
		}
		history.replaceState({},null,null);
	})

	function checkReg(){
		if( $("#name").val() == '' ){
			alert('Please check name of store.');
			$("#name").focus();
			return false;
		}
		if( $("#phone").val() == '' ){
			alert('Please check tel number.');
			$("#phone").focus();
			return false;
		}
		var regEmail=/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[a-zA-Z0-9\-]+/; // email check
		if( !regEmail.test($("#email").val()) ){
			alert('Email format is incorrect.');
			$("#email").focus();
			return false;
		}
		if( $("#autocomplete").val() == '' ){
			alert('Please check address.');
			$("#autocomplete").focus();
			return false;
		}
		if( $("#address2").val() == '' ){
			alert('Please check detail address.');
			$("#address2").focus();
			return false;
		}
		if( $("#lat").val() == '' || $("#lng").val() == ''){
			alert('Please check lat or lng.');
			$("#lat").focus();
			return false;
		}
		if( $("#uploadfile").val() == '' ){
			alert('Please upload image file.');
			$("#uploadfile").focus();
			return false;
		}
		if($("#uploadfile").val() != ""){
			var ext=$("#uploadfile").val().split('.').pop().toLowerCase();
			if($.inArray(ext,['gif','jpg','png','jpeg']) == -1) { /*하나라도 같으면 0이상의 값을 뱉는다.*/
				alert('Only Image file can be uploaded (gif,jpg,png,jpeg)');
				$("#uploadfile").val("");
				return false;
			}
		}
		if(document.getElementById("uploadfile").value != ""){
			var fileSize = document.getElementById("uploadfile").files[0].size;
			var maxSize = 3 * 1024 * 1024; //3mb
			if(fileSize > maxSize){
				alert('Image file can be upload max 3MB.');
				document.getElementById("uploadfile").value = "";
				return false;
			}
		}
		if( confirm('You sure to register new branch store?') ){
			$("#regMapForm").submit();
		}else{ return false; }
	}
	
	function checkDelete(){
		var count = 0;
		if( document.deleteMap.idx.length == undefined ){
			if( document.deleteMap.idx.checked == true ){
				count++;
			}
		}else{
			for( var i=0; i<document.deleteMap.idx.length; i++ ){
				if( document.deleteMap.idx[i].checked == true ){
					count++;
				}
			}
		}
		if( count == 0 ){
			alert("Please check Store you want to delete.");
			document.deleteMap.focus();
			return false;
		}else{
			if( confirm("You sure to delete "+count+" stores?") ){
				document.deleteMap.submit();
			} else{
			 return false;	
			}
		}
	}
</script>

<script>
	$(".mprofile").on("click", function(){
		var image = $(this).attr("src");
		$("#mprofile_modal_image").attr("src", image);
		$("#mprofile_modal").css("display", "block");
	})
	$(document).mouseup(function (e){
	  var modal = $("#mprofile_modal");
	  if(modal.has(e.target).length === 0){
	    modal.css("display", "none");
	  }
	})
</script>


<!-- Google Map API -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBiuNYqlKJxhHI9CsxfEURFDZ3bF8OXjRM&libraries=places&callback=initAutocomplete" async defer></script>
<script>
	var placeSearch, autocomplete;
	function initAutocomplete() {
	  // Create the autocomplete object, restricting the search to geographical
	  // location types.
	  autocomplete = new google.maps.places.Autocomplete(
	                                      (document.getElementById('autocomplete')),{types: ['geocode']});
	  // When the user selects an address from the dropdown, populate the address
	  // fields in the form.
	  autocomplete.addListener('place_changed', fillInAddress);
	}
	function fillInAddress() {
	  // Get the place details from the autocomplete object.
	  var place = autocomplete.getPlace();
	    document.getElementById("lat").value=place.geometry.location.lat();
	    document.getElementById("lng").value=place.geometry.location.lng();
	}
</script>
<!-- /Google Map API -->


<%-- <%@ include file="../includes/footer.jsp" %> --%>