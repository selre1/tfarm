<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>

<script type="text/javascript">
	$(document).ready(function() {
		$("#confirm").click(function() {
			if($("#mem_pw").val() == ""){
			}else{
				$("#mem_id").val("${userInfo.mem_id}");
				$("#confirmform").attr("action", "${root}/user/mypage.tfarm").submit();
			}
		}); 
	});
</script>


<form id="confirmform" name="confirmform" method="POST">
<input type="hidden" id="mem_id" name="mem_id" value="">
 <fieldset>
 
	<div style="margin-left:300px; margin-top:100px; margin-bottom:300px">
    <legend style="font-weight:bold">비밀번호 확인</legend>
    
    <div class="form-group" style="width:400px">
      <label for="exampleInputPassword1">Password</label>
      <input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="Enter Password">
    </div>

    <button id="confirm" type="button" class="btn btn-primary">확인</button>
	</div>
	</fieldset>
</form>
<%@ include file="/common/footer.jsp" %>