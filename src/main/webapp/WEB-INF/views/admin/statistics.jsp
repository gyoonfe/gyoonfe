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

	  		  <p class="fs-2 mt-5 gyoon-redressed">Statistics Of Orders</p>
			  <form method="get" action="/admin/statistics.do" id="searchStatForm" onsubmit="return searchStat()"> 
			  <div class="d-flex justify-content-center align-items-center boxes my-5">
			  	  <div>
				      <select name="pseq">
					    <option value="0">All</option>
					    <c:forEach var="product" items="${product_list}">
					      <option value="${product.pseq}">${product.pname}</option>
					    </c:forEach>
				      </select>
			  	  </div>
			  	  <input class="form-control form-control-sm box_sm mx-5" type="text" name="yyyy" id="yyyy" placeholder="ex) 2022" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
			  	  <input type="hidden" name="mm" value="01">
		          <div>
					  <button type="submit" id="statSubmitButton" class="p-1 px-3 button-hover">Search</button>	
				  </div>
			  </div>
			  </form> 
	  		  <hr>
	  		  
	  		  <p class="fs-3 mt-5 gyoon-redressed">${year}</p>
	  		  <c:choose>
	  		    <c:when test="${pVO != null}">
	  		      <p class="fs-4 gyoon-redressed">
	  		        ${pVO.pname}
	  		        <span class="fs-5">
	  		        	( <fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${pVO.price2}"/> )
	  		        </span>
	  		      </p>
	  		    </c:when>
	  		    <c:otherwise>
	  		      <p class="fs-4 gyoon-redressed">
	  		      	All Product
	  		      	<span class="fs-5">
	  		      		( <fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${list[0].price+list[1].price+list[2].price+list[3].price+list[4].price+list[5].price+list[6].price+list[7].price+list[8].price+list[9].price+list[10].price+list[11].price}"/> )
	  		      	</span>
	  		      </p>
	  		    </c:otherwise>
	  		  </c:choose>

			  <!-- Chart JS -->
       		  <div class="gyoon-pd-mg text-center">
			    <canvas id="myChart"></canvas>
			  </div>

			</div>  <!-- /col -->	
		  </div> <!-- /row -->
	  	
	  </div><!-- / padding row -->

	</div><!-- /row -->
	
</div>

</div><!-- /제일 바깥 container -->

</body>
</html>

<style>
#statSubmitButton {
	background: #fff;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

  //Enter Key = Submit
  $("#yyyy").on("keyup",function(key){
      if(key.keyCode==13) {
          $("#searchStatForm").submit();    
	  }     
  });

  function searchStat(){
	  if( $("#yyyy").val().length < 4 || $("#yyyy").val().length > 4 ){
		  alert('Please check "Year" to search.');
		  $("#yyyy").focus();
		  return false;
	  }
	  $("#searchStatForm").submit();
  }
  
  const labels = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  const data = {
    labels: labels,
    datasets: [{
      label: 'Monthly Orders',
      backgroundColor: 'rgb(255, 99, 132)',
      borderColor: 'rgb(255, 99, 132)',
      data: [
    	  	 ${list[0].price}, 
    	     ${list[1].price}, 
    	     ${list[2].price}, 
    	     ${list[3].price}, 
    	     ${list[4].price}, 
    	     ${list[5].price}, 
    	     ${list[6].price}, 
    	     ${list[7].price},
    	     ${list[8].price},
    	     ${list[9].price},
    	     ${list[10].price}, 
    	     ${list[11].price}
    	    ],
    }]
  };
  
  const config = {
    type: 'line',
    data: data,
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
  };
</script>
<script>
  const myChart = new Chart(
    document.getElementById('myChart'),
    config
  );
</script>


<%@ include file="../includes/footer.jsp" %>