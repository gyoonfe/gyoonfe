<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<body>

<div class="container">

	<!-- Index Carousel -->
	<%@ include file="../includes/indexCarousel.jsp" %>
	
	<div class="row my-5 gyoon-link" align="center"> <!-- Best Product List -->
	  <p class="fs-1 gyoon-redressed">Best</p>
	  <hr>
	  <div class="row gyoon-pd-mg">
	  	  <c:forEach var="best" items="${best_list}" begin="0" end="3">
		  <div class="col-md-3 mb-5">
		  	<div class="gyoon-img-hover">
	   		  <a href="/product/productView.do?pseq=${best.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
	   		  	<img src="/upload_gyoontar/product/${best.pimage}" class="img-thumbnail pimage-size" alt="...">
	   		  </a>
		  	</div>
		    <div class="d-flex flex-column my-3">
		      <a href="/product/productView.do?pseq=${best.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
		      	<span class="fw-bolder"><c:out value="${best.pname}"/></span>
		      </a>
		      <a href="/product/productView.do?pseq=${best.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
		      	<span class="gyoon-price"><fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${best.price2}"/></span>
		      </a>
		    </div>
		  </div>
	  	  </c:forEach>
	  </div>
	</div><!-- /row -->
	
	<div class="row my-5 gyoon-link" align="center"> <!-- Sale Product List -->
	  <p class="fs-1 gyoon-redressed">On Sale</p>
	  <div class="d-flex justify-content-end align-items-center mb-3">
	    <span class="p-1 px-3 button-hover" onClick="location.href='/product/productSale.do'">More</span>	  
	  </div>
	  <hr>
	  <div class="row gyoon-pd-mg">
		  
		  <c:forEach var="sale" items="${sale_list}" begin="0" end="3">
		  <div class="col-md-3 mb-5">
		  	<div class="gyoon-img-hover">
	   		  <a href="/product/productView.do?pseq=${sale.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
	   		  	<img src="/upload_gyoontar/product/${sale.pimage}" class="img-thumbnail pimage-size" alt="...">
	   		  </a>
		  	</div>
		    <div class="d-flex flex-column my-3">
		      <a href="/product/productView.do?pseq=${sale.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
		      	<span class="fw-bolder"><c:out value="${sale.pname}"/></span>
		      </a>
		      <a href="/product/productView.do?pseq=${sale.pseq}&pageNum=${cri.pageNum}&amount=${cri.amount}">
		      	<span class="gyoon-price"><fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${sale.price2}"/></span>
		      </a>
		    </div>
		  </div>
		  </c:forEach>
		  
	  </div>
	</div><!-- /row -->
	
	<div class="row gyoon-link mb-5" align="center"> <!-- Board List (all notice + 10 posts) -->
	  <p class="fs-1 gyoon-redressed">Board</p>
	  <div class="d-flex justify-content-end align-items-center mb-3">
	    <span class="p-1 px-3 button-hover" onClick="location.href='/board/board.do'">Board</span>	  
	  </div>

	  <hr>
	  
	  <div class="row gyoon-pd-mg">
		<table class="table table-hover">
		  <thead class="fs-5" align="center">
		    <tr>
		      <th scope="col">Num</th>
		      <th scope="col">Title</th>
		      <th scope="col">Writer</th>
		      <th scope="col">Hits</th>
		      <th scope="col">Date</th>
		    </tr>
		  </thead>
		  <tbody align="center">
		  
		  	<c:forEach var="notice" items="${notice_list}">
		    <tr class="table-danger">
		      <th scope="row">Notice</th>
		      <td><a href="/board/boardView.do?bno=${notice.bno}&pageNum=1&amount=10"><c:out value="${notice.title}"/></a></td>
		      <td><c:out value="${notice.nickname}"/></td>
		      <td><c:out value="${notice.hits}"/></td>
		      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}"/></td>
		    </tr>
		    </c:forEach>
		    
		    <c:set var="idx" value="1"/>
		  	<c:forEach var="board" items="${board_list}" begin="0" end="9">
		    <tr>
		      <th scope="row">${idx}</th>
		      <td><a href="/board/boardView.do?bno=${board.bno}&pageNum=1&amount=10"><c:out value="${board.title}"/></a></td>
		      <td><c:out value="${board.nickname}"/></td>
		      <td><c:out value="${board.hits}"/></td>
		      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
		    </tr>
		    <c:set var="idx" value="${idx + 1}"/>
		    </c:forEach>

		  </tbody>
		</table>
	  </div>
	</div><!-- /row -->
	
</div> <!-- /container -->


</body>
</html>

<script>

</script>


<%@ include file="../includes/footer.jsp" %>