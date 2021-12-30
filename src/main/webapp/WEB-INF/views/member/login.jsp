<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/login.css">
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
</head>
<body>
	
    <div class="center">
        <br><br>
        <h1>로그인</h1>
        <img class="logo" src="${ pageContext.servletContext.contextPath }/resources/images/logo.png">
        <br><br>
        <input type="text" name="memId" class="id" id="id" placeholder=" 아이디는 [영문,숫자] 4~12글자" style="border-radius: 10px;">
        <br><br>
        <input type="password" name="memPwd" class="pwd" id="pwd" placeholder=" 비밀번호는 [영문,숫자,특수기호] 4~12글자"  onKeypress="javascript:if(event.keyCode==13) {validate();}" style="border-radius: 10px;">
        <br><br>

         <!-- 아이디와 비밀번호가 일치하면  메인페이지 이동하기 -->
        <button type="submit" class="login" onclick="validate();">로그인</button>
        &nbsp; &nbsp; &nbsp; 
        <button type="button" class="reset" id="goMain">취소</button>
        <br> <br> 
        <a href="${ pageContext.servletContext.contextPath }/member/findId">아이디 찾기</a> &nbsp; 
        <a href="${ pageContext.servletContext.contextPath }/member/findPwd">비밀번호 찾기</a> &nbsp; 
        <a href="${ pageContext.servletContext.contextPath }/member/join">회원가입</a> 
    </div>
    <br><br>
    <jsp:include page="../commons/footer.jsp"/>
    <script>
        function validate(){
            let memId = $('#id').val();
            let memPwd = $('#pwd').val();
       
            if(memId ==""){
                alert("아이디를 입력해주세요.");
                memId.focus();
            }

            if(memPwd ==""){
                alert("비밀번호를 입력해주세요.");
            }
            
            $.ajax({
       			url: "/mommyson/member/login",
   				type: 'post',
   				data: {
   					memId : memId,
   					memPwd : memPwd
   				},
   				success: function(data) {
   					switch(data){
   						case "main" : location.href="${ pageContext.servletContext.contextPath }/"; break;
   						default : alert(data); break;
   					}
   				}
       		});
        }

    </script>     
    <script>
		const $goMain = document.getElementById("goMain");
            $goMain.onclick = function() {
                location.href = "${ pageContext.servletContext.contextPath }/";
            }
            
   		const $goJoin = document.getElementById("goJoin");
           $goJoin.onclick = function() {
               location.href = "${ pageContext.servletContext.contextPath }/join";
           }

    </script>
          
</body>
</html>