<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header_board.jsp" %>
<script>
control = "/reboard";

function writeArticle() {
	if($("#subject").val() == "") {
		alert("제목입력!!!");
		return;
	} else if($("#content").val() == "") {
		alert("내용입력!!!");
		return;
	} else {
		document.writeForm.action = root + control + "/reply.tfarm";
		document.writeForm.submit();
	}
}
</script>


<!-- ******************티켓 글쓰기********************** -->
<form id="writeForm" name="writeForm" method="post" action="" style="margin: 0px">

	<input type="hidden" name="bcode" value="${bcode}">
	<input type="hidden" name="pg" value="1">
	<input type="hidden" name="key" value="">
	<input type="hidden" name="word" value="">
	<input type="hidden" id="ref" name="ref" value="${article.ref}">
	<input type="hidden" id="lev" name="lev" value="${article.lev}">
	<input type="hidden" id="step" name="step" value="${article.step}">
	<input type="hidden" id="pseq" name="pseq" value="${article.seq}">
	
	
	<div class="mr-sm-2 col-xl-10"style="margin:20px; float:left; width:900px;" >
		<div class="form-group">
			<legend style="font-weight:bold">${category}작성하기</legend>
			<div class="form-group">
				<input type="text" class="form-control" name="subject" id="subject" placeholder="글 제목을 입력해주세요" value="답변입니다:${article.subject}">
			</div>
	    
	    	<textarea class="form-control" name="content" id="content" rows="20">
	    
	    	
	    	
	    	--------------------------------------------------------원글--------------------------------------------------------
	    	${article.content}
	    	</textarea>
	
		</div>
	<!-- ******************등록 취소 버튼*********************** -->
		<div>
			<button type="button" class="btn btn-info" onclick="javascript:writeArticle();">등록</button>
			<button type="button" class="btn btn-info" onclick="javascript:listArticle('${bcode}', '${pg}', '${key}', '${word}')">취소</button>
		</div>
	</div>
</form>
<%@ include file="/common/footer.jsp" %>