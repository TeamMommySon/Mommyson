<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"href="${ pageContext.servletContext.contextPath }/resources/css/user/findId.css">
<link rel="stylesheet" type="text/css"href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF"crossorigin="anonymous"></script>
<style>
    .correct {
    color : green;
    }
     .incorrect {
    color : red;
    }
</style>
</head>
<body>
	<div class="center">
		<br>
		<br>
		<h1>아이디 찾기</h1>
		<img class="logo"
			src="${ pageContext.servletContext.contextPath }/resources/images/logo.png">
		<br>
			<input type="text" class="name" id="name" name="name" placeholder=" 이름(한글 2글자 이상)" style="border-radius: 9px;"> 
			<br>
           	<span id="nameCheckResult"></span>
            <br>		
		 	<input type="email" class="email" id="email" name="email" placeholder=" 이메일(@를 포함)"> 
			<br>
           	<span id = "emailCheckResult"></span>
            <br>
	 		<button type="submit" class="btn btn-primary"  id="findIdButton" onclick="findIdButton1()"
				style="width: 100px; height: 40px; border-radius: 9px; 
				background-color: rgb(247, 170, 145); color: black; border: 2px solid black;">아이디찾기</button> 
			&nbsp; &nbsp; &nbsp; &nbsp;
			<button type="reset" class="goLogin" id="goLogin"
				style="border-radius: 9px; background-color: rgb(247, 170, 145);">로그인</button>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
	<script>
		/* 이름 입력 여부 확인 & 정규식 확인 */
		$("#name").blur(function(){
			var inputName = $("#name").val();
			var regex = /^[가-힣]{2,}$/;
			var result = regex.exec(inputName);
			var nameCheckResult = $("#nameCheckResult");
				
			if(inputName == ""){
				nameCheckResult.html("이름을 입력해주세요.");
				nameCheckResult.attr("class", "incorrect");
				return false;

			} else {
				if(result != null) {
					nameCheckResult.html("");
					return true;
					
				} else {
					nameCheckResult.html("이름 형식이 올바르지 않습니다. 이름은 한글로 2글자 이상 입력해주세요. ");
					nameCheckResult.attr("class", "incorrect");
	       		 	return false;	 
				} 
			}				
		});
		
		/* 이메일 입력 여부 확인 & 정규식 확인 */
	       $("#email").blur(function(){
				var inputEmail = $("#email").val();
				var regex = /.+@[a-z]+(\.[a-z]+){1,2}$/;
			 	var result = regex.exec($('#email').val());
			 	var emailCheckResult = $("#emailCheckResult");
			 	
			 		if(inputEmail == ""){
			 			emailCheckResult.html("이메일을 입력해주세요.");
			 			emailCheckResult.attr("class", "incorrect");
			 			return false;
			 			
			 		} else {
			 			
			 			if(result != null){
			 				emailCheckResult.html("");
			 				return true;
			 				
			 			} else {
			 				emailCheckResult.html("이메일 형식이 올바르지않습니다. @를 포함하여 올바른 형식으로 작성해주세요.");
			 				emailCheckResult.attr("class", "incorrect");
			 				return false;
			 			}
			 		}
	       	
	       });
		
		
	  
	  	
	  /* 아이디 찾기 버튼 클릭 */
	  /* 이름이나 이메일을 입력하지 않고 아이디찾기를 누르면 회원정보를 입력해주세요 라는 알럿이 나오게 한다.  */	
	  /* 이름과 이메일이 회원정보와 일치하지 않은 상태에서 아이디찾기를 누르면 "회원정보를 다시 확인해주세요." 라는 알럿이 나오게 한다.  */	
	   
    	function findIdButton1(){
    		 var name = $('#name').val();        	
       		 var email = $('#email').val();	
	    	
       		 if(name == "" || email ==""){
       			 alert("회원 정보를 입력해 주세요.");
       		     return false;
       			 
       		 } else {
       			 
		    	$.ajax({
		    		url:"${ pageContext.servletContext.contextPath }/member/findIdCheck",
		    		type:"post",
		    		data : {
		    			name : name, 
		    			email : email
		    		}, 
		    		async : false, 
		    		success:function(data){
		    				console.log("data : " + data);
		    				
		    			if(data != null && data != "") {
		    				alert("고객님의 아이디는 " + data + "입니다.");
		    				return true;
		    				
		    			} else {
		    				alert("입력하신 정보가 일치하지 않습니다. 올바른 정보를 입력해주세요.");
		    				return false;
		    			}
		    		},
	    			error : function(error){
	    				alert(error);
	    			}	
	    		});
	    	 }
		  } 
   
		
		  
    	/* 로그인 화면으로 돌아가기 */
    	const $goLogin = document.getElementById("goLogin");
    		$goLogin.onclick = function() {
    			location.href = "${ pageContext.servletContext.contextPath }/member/login";
    		}
    </script>
</body>
</html>