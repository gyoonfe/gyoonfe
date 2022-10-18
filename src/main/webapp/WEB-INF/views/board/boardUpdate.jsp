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

	<!-- Board Carousel -->
	<%@ include file="../includes/boardCarousel.jsp" %>


	<div class="row mt-5" align="center">
	  <p class="fs-1 gyoon-redressed">Board</p>
	  
	  <form method="post" action="boardUpdate.do" enctype="multipart/form-data" name="updateForm"> <!-- Form ------------------------------------------- -->
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  <input type="hidden" name="bno" value="${boardVO.bno}">
	  <input type="hidden" name="userid" value="${session_userid}">
	  <input type="hidden" name="hits" value="${boardVO.hits}">
	  <input type="hidden" name="pageNum" value="${cri.pageNum}">
	  <input type="hidden" name="amount" value="${cri.amount}">
	  
	  <div class="d-flex justify-content-center">
	    <c:set var="now" value="<%=new java.util.Date()%>" /> <!-- Now Date -->
	  	<p>Posted Date : <span class="fs-4"><fmt:formatDate pattern="yyyy-MM-dd" value="${boardVO.regdate}"/></span></p>
	  	<p class="mx-3"></p>
	  	<p>Today : <span class="fs-4"><fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/></span></p>
	  	<p class="mx-3"></p>
	  	<p>Writer : <span class="fs-4"><c:out value="${boardVO.nickname}"/></span></p>
	  </div>
	  
	  <hr>
	  
	  <div align="center" class="gyoon-big-pd-mg">
		<table class="table text-center align-middle border-white">
		    <tr>
		      <th>Title</th>
		      <th><input type="text" class="form-control border-dark" aria-describedby="addon-wrapping" name="title" value="${boardVO.title}"></th>
		    </tr>
		    <tr>
		      <th>Content</th>
		      <th><textarea name="content" id="summernote">${boardVO.content}</textarea></th>
		    </tr>
		</table>
	  </div>
	  
	  <hr>
	  
	  <div class="d-flex justify-content-center mt-5 mb-5">
	    <div class="">
		  <span class="p-1 px-3 button-hover" onClick="checkUpdate()">Update</span> 
		  <span class="p-1 px-3 button-hover" onClick="checkReset()">Reset</span>    
	      <span class="p-1 px-4 button-hover" onClick="location.href='board.do'">List</span>
	    </div>
	  </div>
	  
	  </form> <!-- Form ------------------------------------------- -->
	 
	</div><!-- /row -->	  
	
</div> <!-- /container -->


</body>
</html>


<script type="text/javascript">
	function checkUpdate(){
		if(document.updateForm.title.value.length == 0){
			document.updateForm.title.focus();
			alert("Check your Title.");
			return false;
		}
		if(document.updateForm.content.value.length == 0){
			document.updateForm.content.focus();
			alert("Check your Content.");
			return false;
		}
		if(confirm('Are you sure to upload this post?')){
			document.updateForm.submit();
		}else{
			return false;
		}
	}
	
	var reset_content = '${boardVO.content}';
	function checkReset(){
		if(confirm('You really want to Reset this form?')){
			document.updateForm.reset();
			$('#summernote').summernote('code', reset_content);
			document.updateForm.title.focus();
		}else{
			return false;
		}
	}
	
	$('#summernote').summernote({
		height: 300,
		tabsize: 2,
		minHeight: null,         
		maxHeight: null,           
		focus: true,
		 toolbar: [
		    // 글꼴 설정
		    ['fontname', ['fontname']],
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색
		    ['color', ['forecolor','color']],
		    // 표만들기
		    ['table', ['table']],
		    // 글머리 기호, 번호매기기, 문단정렬
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격
		    ['height', ['height']],
		    // 그림첨부, 링크만들기, 동영상첨부
		    ['insert',['picture','link','video']],
		    // 코드보기, 확대해서보기, 도움말
		    ['view', ['codeview','fullscreen', 'help']]
		  ],
		  // 추가한 글꼴
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
		 // 추가한 폰트사이즈
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	});
</script>

<%@ include file="../includes/footer.jsp" %>