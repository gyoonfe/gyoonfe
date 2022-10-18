<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


		<p class="fs-2 gyoon-redressed">Best</p>
		<hr>  
		<div id="carouselExampleCaptions" class="carousel slide my-5" data-bs-ride="carousel">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <a href="/product/productView.do?pseq=${best_list[0].pseq}">
		      	<img src="/upload_gyoontar/product/${best_list[0].pimage}" class="d-block w-100 h_305" alt="...">
		      </a>
		      <div class="carousel-caption d-none d-md-block gyoon-redressed mb_150">
		        <p class="fs-3 shadow label-best">
		        	${best_list[0].pname}<br>
		        	<span class="fs-5">
		        		<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${best_list[0].price2}"/>
		        	</span>
		        </p>
		      </div>
		    </div>
		    
		    <c:forEach var="best" items="${best_list}" begin="1">
		    <div class="carousel-item">
		      <a href="/product/productView.do?pseq=${best.pseq}">
		      	<img src="/upload_gyoontar/product/${best.pimage}" class="d-block w-100 h_305" alt="...">
		      </a>
		      <div class="carousel-caption d-none d-md-block gyoon-redressed mb_150">
		        <p class="fs-3 shadow label-best">
		        	${best.pname}<br>
		        	<span class="fs-5">
		        		<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${best.price2}"/>
		        	</span>
		        </p>
		      </div>
		    </div>
		    </c:forEach>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div><!-- /carousel (besst) -->
