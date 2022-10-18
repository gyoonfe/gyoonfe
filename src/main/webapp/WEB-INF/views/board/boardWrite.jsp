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
	

<c:set var="nowDate"></c:set> 
	
	<div class="row mt-5" align="center">
	  <p class="fs-1 gyoon-redressed">Board</p>
	  
	  <form method="post" action="boardWrite.do" name="writeForm">
	  <input type="hidden" name="userid" value="${session_userid}">
	  <input type="hidden" name="noticeyn" value="0">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  
	  <div class="d-flex justify-content-center">
	    <c:set var="now" value="<%=new java.util.Date()%>" /> <!-- Today -->
	  	<p>Date : <span class="fs-4"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></span></p>
	  	<p class="mx-3"></p>
	  	<p>ID : <span class="fs-4">${session_userid}</span></p>
	  </div>
	  
	  <hr>
	  
	  <div class="gyoon-big-pd-mg" align="center">
		<table class="table text-center align-middle border_white">
		    <tr>
		      <th>Title</th>
		      <th><input type="text" class="form-control border-dark" aria-describedby="addon-wrapping" name="title"></th>
		    </tr>
		    <tr>
		      <th>Content</th>
		      <th><textarea  name="content" id="summernote"></textarea></th>
		    </tr>
<!-- 		    <tr> -->
<!-- 		      <th>Upload</th> -->
<!-- 		      <th><input type="file" class="form-control border-dark" name="uploadfile" id="uploadfile"></th> -->
<!-- 		    </tr> -->
		</table>
	  </div>
	  
	  <hr>
	  
	  <div class="d-flex justify-content-center mt-5 mb-5">
	    <div class="">
		  <span class="p-1 px-3 button-hover" onClick="checkWrite()">Write</span>    
		  <span class="p-1 px-3 button-hover" onClick="writeReset()">Reset</span>  
	      <span class="p-1 px-4 button-hover" onClick="location.href='board.do'">List</span>
	    </div>
	  </div>
	  
	  </form> <!-- Form ------------------------------------------- -->
	 
	</div><!-- /row -->	  
	
</div> <!-- /container -->


</body>
</html>

<script>
	function checkWrite(){
		if(document.writeForm.title.value.length == 0){
			document.writeForm.title.focus();
			alert("Check your Title.");
			return false;
		}
		if(document.writeForm.content.value.length == 0){
			document.writeForm.content.focus();
			alert("Check your Content.");
			return false;
		}
		if(confirm('Are you sure to upload this post?')){
			document.writeForm.submit();
		}else{
			return false;
		}
	}
	
	function writeReset(){
		if(confirm('Are you sure to Reset this post?')){
			document.writeForm.reset();
			$('#summernote').summernote('reset');
			document.writeForm.title.focus();
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