<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>

<script>
$(document).ready(function(){
	$("#loginBtn").click(function(){
		if($("#mem_id").val() == ""){
			alert("아이디를 입력하세요");
		}else if($("#mem_pw").val() == ""){
			alert("비밀번호를 입력하세요");
		}else{
			$("#loginform").attr("action", "${root}/user/login.tfarm").submit();
		}
	});
});
</script>
<form id="loginform" name="loginform" method="post">
 <fieldset>
	<div style="width:400px; margin-left:300px; margin-top:100px; margin-bottom:300px">
	    <legend style="font-weight:bold">로그인</legend>
	    <div class="form-group" style="width:400px">
	      <label for="exampleInputEmail1">ID</label>
	      <input type="text" class="form-control" id="mem_id" name="mem_id" aria-describedby="emailHelp" placeholder="Enter id">
	      
	    </div>
	    <div class="form-group" style="width:400px">
	      <label for="exampleInputPassword1">Password</label>
	      <input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="Enter Password">
	    </div>
		<div style="width:100%">
	    	<button type="button" id="loginBtn" class="btn btn-primary" style="width:100%">LOGIN</button>
		</div>
	<a id="kakao-login-btn" href="javascript:loginWithKakao()"></a>
    <a href="http://developers.kakao.com/logout"></a>
    <!-- <div id="naverIdLogin"></div> 네이버로그인 보류 -->
    <!-- <fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button> -->
    <div class="fb-login-button" data-size="large" data-button-type="continue_with" data-auto-logout-link="true"  onlogin="fbLogin();"></div>
   <!--  scope="public_profile,email,publish_pages,manage_pages" data-max-rows="1" data-size="large" data-button-type="continue_with" data-show-faces="true" data-auto-logout-link="true" data-use-continue-as="true" -->
    <a href="#">아이디 찾기</a>
	<a href="#">비밀번호 찾기</a>
	</div>
	
	<!-- ---------------------------------------------카카오---------------------------------------- -->
	
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script type='text/javascript'>
        // 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('7200f9d45b32773b509fdb430680cabb');
          // 카카오 로그인 버튼을 생성합니다.
          Kakao.Auth.createLoginButton({
            container: '#kakao-login-btn',
            success: function(authObj) {
              // 로그인 성공시, API를 호출합니다.
              Kakao.API.request({
                url: '/v1/user/me',
                success: function(res) {
                	if(res.kaccount_email_verified){               		
 	            		alert(res.kaccount_email); 	            		
 	       				var thumbnail = res.properties.thumbnail_image;
 	       				$("#semail").val(res.kaccount_email); 	   
 	       				$("#sname").val(res.properties.nickname);
 	       				$("#sid").val(res.id);
 	       				$("#sociallogin").attr("action","${root}/user/social.tfarm").submit();
                	}
                },
                fail: function(error) {
                  alert(JSON.stringify(error));
                }
              });
            },
            fail: function(err) {
              alert(JSON.stringify(err));
            }
          });
      </script>
      
      <!-- ---------------------------------------------카카오끝---------------------------------------- -->
      <!-- ---------------------------------------------페이스북 시작---------------------------------------- -->
      
      
		<script>
			      
		    function fbLogin() {
		    	// 로그인 여부 체크
		    	FB.getLoginStatus(function(response) {

		    		if (response.status === 'connected') {
		    			 getMyprofile();
		    		} else if (response.status === 'not_authorized') {
		    			// 사람은 Facebook에 로그인했지만 앱에는 로그인하지 않다
		    			alert('앱에 로그인해야 이용가능한 기능입니다.');
		    		} else {
		    			// 그 사람은 Facebook에 로그인하지 않았으므로이 앱에 로그인했는지 여부는 확실하지 않다
		    			alert('페이스북에 로그인해야 이용가능한 기능입니다.');
		    		}
		    	}, true); // 중복실행방지 {scope: "user_about_me,email,user_birthday"}
		    }
		    
		    function getMyprofile(){
			    FB.api('/me',{fields: 'email,name'}, function(user) {
			    	console.log(user);
			    	console.log(user.user_about_me+" "+user.email + " " + user.name + " " + user.id + " " + user.user_birthday);
			    	$("#semail").val(user.email); 	   
	       			$("#sname").val(user.name);
	       			$("#sid").val(user.id);
	       			$("#sociallogin").attr("action","${root}/user/social.tfarm").submit();
				});
		    }

		    window.fbAsyncInit = function() {
		    	FB.init({
		    		appId   : '191953874874648',
		    		cookie  : true,
		    		xfbml   : true,
		    		version : 'v2.11'
		    	});
		    };

		    (function(d, s, id) {
		    	var js, fjs = d.getElementsByTagName(s)[0];
		    	if (d.getElementById(id)) return;
		    	js = d.createElement(s); js.id = id;
		    	js.src = "//connect.facebook.net/ko_KR/sdk.js";
		    	fjs.parentNode.insertBefore(js, fjs);
		    }(document, 'script', 'facebook-jssdk'));
		</script>
      
      
      <!-- ---------------------------------------------페이스북 끝---------------------------------------- -->
      
      
      
      <!--                             네이버로그인 보류
      <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
      <script type="text/javascript">
		var naverLogin = new naver.LoginWithNaverId(
			{		
				clientId: "{Mg3yfs3dMI9xPz7jGTPC}",
				callbackUrl: "{http://localhost:80/tfarm/login/login.jsp}",
				isPopup: true,
				callbackHandle: false,
				loginButton: {color: "green", type: 3, height: 48} /* 로그인 버튼의 타입을 지정 */
			}
		);
		
  	 	/* 설정정보를 초기화하고 연동을 준비 */
		naverLogin.init();
  	 	
		window.addEventListener('load', function () {
			naverLogin.getLoginStatus(function (status) {
				if (status) {
					/* 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
					var email = naverLogin.user.getEmail();
					if( email == undefined || email == null) {
						alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
						/* 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
						naverLogin.reprompt();
						return;
					}

				/* 	window.location.replace("처리후 되돌아갈 곳"); */
				} else {
					console.log("callback 처리에 실패하였습니다.");
				}
			});
		});
		</script>
        -->
        
        
    
    
    
	</fieldset>
</form>
<form id="sociallogin" name="sociallogin" method="POST">
	<input type="hidden" id="semail" name="semail">
	<input type="hidden" id="sname" name="sname">
	<input type="hidden" id="sid" name="sid">
</form>

<%@ include file="/common/footer.jsp" %>