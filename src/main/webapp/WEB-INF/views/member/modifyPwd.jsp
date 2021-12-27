<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/modifyPwd.css">
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
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
    <div class = center>
        <br><br>
        <h1>비밀번호 변경</h1>
        <img class=logo src="${ pageContext.servletContext.contextPath }/resources/images/logo.png">
        <br>
       <!--  <form action="modifyPwd" method="post" onsubmit="return validate();">  -->
        <input type="hidden" name="email" id="email">
        <input type="password" class="pwd1" id="pwd1" name="memPwd" placeholder="비밀번호는 [영문,숫자,특수기호] 4~12글자"
        style=" border-radius: 9px; width: 440px; height: 40px;">
        <br>
        <span id="pwd1CheckResult"></span>
        <br>
        <input type="password" class="pwd2" id="pwd2" placeholder="비밀번호를 확인해주세요"
		style=" border-radius: 9px; width: 440px; height: 40px;">
        <br>
        <span id="pwd2CheckResult"></span>
        <br><br>
        <button type="submit" id="changePwd"
         style="width:100px; height:40px; border-radius: 9px; background-color:rgb(247, 170, 145); text-align : center;">변경</button>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <button type="reset" id="goLogin"
         style="width:100px; height:40px; border-radius: 9px; background-color:rgb(247, 170, 145); text-align : center;">취소</button>
      <!--  </form> -->
    </div>

    <br><br>
    
    <jsp:include page="../commons/footer.jsp"/>
    <script>
        
        
    
        /* 비밀번호1 클릭시 입력 여부 확인 알럿 & 정규식 확인 */
        $("#pwd1").blur(function(){
       	var inputPwd = $("#pwd1").val();
      		var regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{4,12}$/;
      		var result = regex.exec(inputPwd);
      		var pwd1CheckResult = $("#pwd1CheckResult");

      		
      			if(inputPwd == ""){
      				pwd1CheckResult.html("비밀번호를 입력해주세요.");
	        		pwd1CheckResult.attr("class", "incorrect");
	        		return false;
      				
      			} else {
      				
      				if(result != null){
      					pwd1CheckResult.html("");
	        			return true;
	        			
	        		} else {
	        			pwd1CheckResult.html("비밀번호 형식이 올바르지 않습니다. 비밀번호는 알파벳과 특수기호 !@#$%^*+=- 와 숫자를 혼합하여 4~12글자를 작성해주세요 ");
	        			pwd1CheckResult.attr("class", "incorrect");
	        			return false;
	        		}
      				
      			}	
       	}); 
       
       
       
        /* 비밀번호 입력 여부 확인 알럿 & 일치 여부 확인 */
        $("#pwd2").blur(function(){
       	 
       	 var inputPwd1 = $("#pwd1").val();
       	 var inputPwd2 = $("#pwd2").val();
    	 	 var pwd2CheckResult = $("#pwd2CheckResult");
       	 
       	 if(inputPwd2 == "") {
       		pwd2CheckResult.html("비밀번호를 확인해주세요.");
       		pwd2CheckResult.attr("class", "incorrect");
 			return false;
 			
       	 }	else {
       		 
 	        	if(inputPwd1 == inputPwd2){
 	        		pwd2CheckResult.html("비밀번호가 일치합니다.");
 	        		pwd2CheckResult.attr("class", "correct");
 	        		return true;
 	        		
 	        	} else {
 	        		pwd2CheckResult.html("비밀번호가 일치하지않습니다. 비밀번호를 동일하게 입력해주세요.");
 	        		pwd2CheckResult.attr("class", "incorrect");
 	        		return false;
 	        	}
       		 }	
       });
       
       
       
       /* 비밀번호 변경 버튼 클릭시 비밀번호1 입력 여부 확인 알럿 */
         $("#changePwd").click(function(){
    	  if($("#pwd1").val() == ""){
    		  alert("비밀번호를 입력해주세요.");
    		  $("#pwd1").focus(); 
    		  return false;
    	  } 
       });
       
       
       
      /* 비밀번호 변경 버튼 클릭시 비밀번호2 입력 여부 확인 알럿 */
       $("#changePwd").click(function(){
     	  if($("#pwd2").val() == ""){
     		  alert("비밀번호를 확인해주세요.");
     		  $("#pwd2").focus(); 
     		  return false;
     	  } 
        });  
       
      
      
  	  /* 비밀번호 변경버튼 클릭시 동일여부에 따라 변경 */
       $('#changePwd').click(function(){
           
       	var email = '${email}';
       	console.log("email(jsp) : " + email);
       	
       	var pwd1 = $("#pwd1").val();
       	console.log("pwd1(jsp) : " + pwd1);
       	
       	var pwd2 = $("#pwd2").val();
       	console.log("pwd2(jsp) : " + pwd2);
       	
       	if(pwd1 != "" && pwd2 != "" && pwd1 != null && pwd2 != null){
       		
       		if(pwd1 == pwd2) {
       			
	        		$.ajax({
	        			type : "post",
	        			url : "modifyPwd",
	        			data : {
	        				pwd1 : pwd1,
	        				email : email
	        			},
	        			async : false,
	        			success : function(data){
	        				console.log("data  : " + data);
	        			},
	        			error : function(error){
		       				alert(error);
	        			}		
	        			
	        		});
	        		
	        		alert("비밀번호 변경에 성공했습니다.");
	        		location.href = "${ pageContext.servletContext.contextPath }/member/login";
	        		
       		} else {
       			alert("비밀번호를 다시 확인해 주세요.");
       			
       		}
       	}
       	
       });
       
        
        
	    /* 로그인 화면 이동 */ 
	    const $goLogin = document.getElementById("goLogin");
	    $goLogin.onclick = function() {
	    	location.href = "${ pageContext.servletContext.contextPath }/member/login";
	    }
    </script>   
</body>
</html>