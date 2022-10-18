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
	  	  <p class="fs-1 gyoon-redressed">Offline Store</p>
	  </div>
	  <hr>
	    <div class="gyoon-pd-mg">
	    
		  <div id="map" style="height: 100vh;"></div>
		  
		</div><!-- /padding div -->
	</div><!-- /row -->

  <!-- Footer -->
  <div class="text-center mb-5 mt_100">
    <hr class="my-5">
    <span class="fs-5">HQ : (Zip)34856, Huiyoung Building 5-6F, 825, Gyeryong-ro, Jung-gu, Daejeon, Republic of Korea</span><br>
    Business registration number : 000-00-00000<br>
    <i class="bi bi-telephone"></i>  042-000-0000 / <i class="bi bi-envelope"></i>  gyoonproject@gmail.com<br>
    <p>Copyright &copy Gyoontar. All rights reserved.</p>
  </div>
  <!-- /Footer -->	
	
</div> <!-- /container -->


</body>
</html>

<!-- Google Map API -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBiuNYqlKJxhHI9CsxfEURFDZ3bF8OXjRM&callback=initMap&v=weekly" defer></script>
<script>
function initMap() {
	  const map = new google.maps.Map(document.getElementById("map"), {
	    zoom: 7,
	    center: { lat: 35.8391623, lng: 131.5543716 },
	  });
	  setMarkers(map);
} //initMap

const beaches = [];
	<c:forEach var = "list" items="${map_list}">
		beaches.push(["${list.name}", //0_index
					  "${list.phone}", //1
					  "${list.email}", //2
					  "${list.address1}", //3
					  "${list.address2}", //4
					  ${list.lat}, //5
					  ${list.lng}, //6
					  "${list.image}", //7
					  ${list.idx}, //8
					  4]); //9
	</c:forEach>
	
function setMarkers(map) {

	  for (let i = 0; i < beaches.length; i++) {
	    const beach = beaches[i];
	    const marker = new google.maps.Marker({
	      position: { lat: beach[5], lng: beach[6] },
	      map,
	      title: beach[0],
	      zIndex: beach[9],
	    });

	    const contentString =
	        '<div id="content">' +
	        '<img src="/upload_gyoontar/map/'+beach[7]+'" alt="..." style="height:250px; width:400px;">'+
	        '<h5>'+beach[0]+'</h5>'+
	        '<p>'+beach[3]+'</p>'+
	        '<p>'+beach[4]+'</p>'+
	        '<p>'+beach[1]+'</p>'+
	        '<p>'+beach[2]+'</p>'+
	        "</div>";
	      const infowindow = new google.maps.InfoWindow({
	        content: contentString,
	      });
	       
	      marker.addListener("click", () => {
	    	    infowindow.open(map, marker);
	    	  });
	    	
	  }
}//setMarkers()
</script>
<!-- /Google Map API -->
