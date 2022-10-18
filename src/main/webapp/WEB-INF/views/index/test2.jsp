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

<h2 class="text-center my-5">Test Page</h2>

	<div class="gyoon-pd-mg text-center">
	  <canvas id="myChart"></canvas>
	</div>

</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
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
      data: [0, 
    	    10, 
    	    5, 
    	    2, 
    	    20, 
    	    30, 
    	    45, 
    	    45,
    	    45,
    	    45,
    	    45, 
    	    45],
    }]
  };
  
  const config = {
    type: 'line',
    data: data,
    options: {}
  };
</script>
<script>
  const myChart = new Chart(
    document.getElementById('myChart'),
    config
  );
</script>

<%@ include file="../includes/footer.jsp" %>