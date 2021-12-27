<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/findPwd.css">
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
    <div class=center>
        <br><br>
        <h1>비밀번호 찾기</h1>
        <img class=logo src="${ pageContext.servletContext.contextPath }/resources/images/logo.png">
    </div>
    <div class=text style="margin-left:37%">
        <br> 
        <input type="email" class="email" id="email" name="email" placeholder=" 이메일주소(@ 포함)"
        style=" border-radius: 9px; width: 440px; height: 40px;">
        <button type="submit" id="submit" 
        style="width:100px; height:40px; border-radius: 9px; background-color:rgb(247, 170, 145); text-align : center;">코드전송</button>
        <br>
        <span id="emailCheckResult"></span>
        <br>
        <input type="number" class="emailCode" id="emailCode" name="emailCode" placeholder="인증번호(이메일 전송 버튼 클릭 후 수신된 인증번호 입력)"
        style=" border-radius: 9px; width: 440px; height: 40px;">
        <input type="hidden" name="inputEmailCode">
        <br>
        <span id="codeCheckResult"></span>
        <br>
    </div>    
    <div class="button" style="text-align: center;">
        <button type="submit" id="changePwdButton"
        style="width:100px; height:40px; border-radius: 9px; background-color:rgb(247, 170, 145); text-align : center;">비밀번호 변경</button>
        &nbsp; &nbsp;
        <button type="reset" id="goLogin" 
        style="width:100px; height:40px; border-radius: 9px; background-color:rgb(247, 170, 145); text-align : center;">로그인</button>
        <br><br>
    </div>
    <jsp:include page="../commons/footer.jsp"/>
    <script>
    
   		$('#changePwdButton').click(function(){
       		 if($('#email').val() == ""){
       			 alert("이메일을 입력해주세요.");
       			 $('#email').focus();
       			 return false;
       		 }
       	 });
        
       	$('#changePwdButton').click(function(){
       		if($('#emailCode').val() == ""){
                   alert("인증번호를 입력해주세요");
               	$("#codeCheckResult").html("이메일 전송 버튼을 클릭하여 수신된 인증 번호를 입력해주세요.");
               	$("#codeCheckResult").attr("class", "incorrect");
               	$("#emailCode").focus();
               	return false;
       		}
       	});  
      	
  
      
         
        /* 이메일 입력 여부 확인 & 정규식 확인 */
        $("#email").blur(function(){
        	var inputEmail = $("#email").val();
        	var regex = /.+@[a-z]+(\.[a-z]+){1,2}$/;
        	var result =regex.exec(inputEmail);
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
        
	    
        
        /* 코드 전송 버튼 클릭 */
        /* 아이디, 이메일을 입력하지 않고 누르면 회원정보를 입력해주세요 라는 알럿이 나온다. */	
	    /* 아이디, 이메일이 회원정보와 일치하지 않은 상태에서 누르면 "회원정보를 다시 확인해주세요." 라는 알럿이 나온다. */	
	    
	   var emailCode ="";
        
	    $("#submit").click(function(){
	    	
        	var email = $("#email").val();
        	var codeCheckResult = $("#codeCheckResult"); // 비교결과 
        	
        	if(email == ""){
        		codeCheckResult.html("이메일을 입력해주세요.");
        		codeCheckResult.attr("class", "incorrect");
        		return false; 
        		
        	} else {
        		codeCheckResult.html("");
        		alert("이메일 인증번호를 발송했습니다. 인증번호를 입력해주세요.")
         		$.ajax({
         			type:"post",
         			url:"find_pass.do",
         			data : { email : email },	
         			async : false
         			
         		});
        	}
		}); 
	    
	    
	    //비밀번호 변경을 눌렀을 때 두개중하나라도 값이 비어있으면 필요 정보를 입력해주세요 
	 	 $('changePwdButton').click(function(){
	
		 if($('#email').val() == "" || $('#emailCode').val() == ""); 
			 alert("필요정보를 입력해주세요.");
			 return false;
	 	 });
	 	 
	 	 
	 	/* 비밀번호 변경 버튼 클릭시 이메일과 인증코드 모두 입력이 잘 되어있고 이메일에 발송된 인증번호가 일치하면 비밀번호 변경 화면으로 넘어간다. */
	    $('#changePwdButton').click(function(){
	        
	       	var email = $("#email").val(); //이메일 
	       	var inputEmailCode = $("#emailCode").val(); // 입력코드 
	       	
	       	if(email !== "" || inputEmailCode!= ""){
	       	
	       		$.ajax({
	        			type:"post",
	        			url:"findPass2",
	        			data : { 
	        				email : email, 
	        				inputEmailCode : inputEmailCode
	        			},	
	        			async : false, 
	        			success:function(data){  // memberController에서 try catch문 주석하고 data잘들어오는지 실행해보기 
	        				console.log("data : " + data);  
	        				if(data == '인증코드가 일치하지 않습니다.') {
	        					alert(data);
	        				} else {
	        					alert("인증번호가 일치합니다. 비밀번호 변경 화면으로 이동합니다.");
	        					location.href = "${ pageContext.servletContext.contextPath }/member/modifyPwd?email=" + data; //겟방식  
	        				}
	        			},
	        			
	        			error : function(error){
	       				alert(error);
	       			}	
	        		
				}); 
	       			
	       	}
	
		});   
	    
	    /* 로그인 화면 이동  */ 
	    const $goLogin = document.getElementById("goLogin");
	    $goLogin.onclick = function() {
	    	location.href = "${ pageContext.servletContext.contextPath }/member/login";
	    }
    </script>        
</body>
</html>