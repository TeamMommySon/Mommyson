<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사업자 회원가입</title>
   
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>   
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/businessJoin.css">
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
   	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
      
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
    <br><br>
    <h1 style="text-align: center;">사업자 회원가입</h1>
    <br>

    <div class="container1" >
        <div class="image">
            <img class=logo src="${ pageContext.servletContext.contextPath }/resources/images/logo.png">
        </div>
        <div class="text">
            <form name="join_form" id="join_form" method="POST" onsubmit="return validate();" enctype="multipart/form-data"> 
            <input type="text" class="id" name="memId" id="id" placeholder=" 아이디(알파벳 소문자,숫자 혼합 4~12글자)"
             style=" height:40px;width:440px;border-radius: 9px;">
            <button type="button" name="idChk" id="idChk" onclick="idChk1()">중복확인</button>
            <input type="hidden" value="N" id="idChkHd">
           	<br>
            <span id="idCheckResult"></span>
            <br>
            <input type="password" class="pwd1" name="memPwd" id="pwd1" placeholder=" 비밀번호(알파벳,숫자,특수기호!@#$%^*+=- 를 혼합 4~12글자)"
             style=" height:40px;width:440px;border-radius: 9px;">
           	<br>
           	<span id="pwd1CheckResult"></span>
            <br>
            <input type="password" class="pwd2"  id="pwd2" placeholder=" 비밀번호 확인"
             style=" height:40px;width:440px;border-radius: 9px;">
           	<br>
           	<span id="pwd2CheckResult"></span>
            <br>
            <input type="text" class="input1" name="ceo.name" id="name" placeholder="대표자명"
             style=" height:40px;width:440px;border-radius: 9px;">
            <br>
           	<span id="nameCheckResult"></span>
            <br>
            <input type="text" class="input1" name="ceo.account" id="account" placeholder="계좌번호는 숫자, - 를 사용"
             style=" height:40px;width:440px;border-radius: 9px;">
            <br>
           	<span id="accountCheckResult"></span>
            <br>
             <input type="text" class="input1" name="phone" id="phone" placeholder=" 전화번호(올바른 형식으로 9~11자리 숫자)"
             style=" height:40px;width:440px;border-radius: 9px;">
            <br>
           	<span id="phoneCheckResult"></span>
            <br>
            <input type="email" class="email" name="email" id="email" placeholder=" 이메일주소(@ 포함)"
             style=" height: 40px;  width: 440px; border-radius: 9px;">
            <button type="button" name="emailChk" id="emailChk" onclick="emailChk1()" 
             style=" height:40px; width:100px; border-radius: 9px; background-color:rgb(247, 170, 145);">중복확인</button>
            <input type="hidden" value="N" id="emailChkHd">
            <button  type="submit" class ="submit"  name="submit" id="submit"
             style=" height:40px; width:100px; border-radius: 9px; background-color:rgb(247, 170, 145);">전송</button>
            <br>
           	<span id = "emailCheckResult"></span>
            <br>
            <input type="number" class="code" name="code" id="code" placeholder=" 인증번호(이메일 전송 버튼 클릭 후 수신된 인증번호 입력)" value="N"
             style=" height:40px;width:440px;border-radius: 9px;">
            <button  type="button" id="check" onclick="codeChk1()" style=" height:40px; width:100px; border-radius: 9px; background-color:rgb(247, 170, 145);">확인</button>
            <br>
            <span id="codeCheckResult"></span>
            <br>
            <input type="text" class="input1" name="postCode" id="zipCode" placeholder=" 우편번호(검색버튼을 눌러 주소 검색 후 클릭)" readonly
             style=" height:40px;width:440px;border-radius: 9px;">
            <input type="button" id="searchZipCode" value="검색">
            <br><br>
            <input type="text" class="input1" name="address" id="address1" placeholder=" 주소" readonly
             style=" height:40px;width:440px;border-radius: 9px;">
            <button type="button" id="button" onclick="locationCode1()">'구' 저장</button>
            <input type="hidden" name="locationCode" id="locationCode" value="N" > 
            <br><br>
            <input type="text" class="input1" name="dAddress" id="address2" placeholder=" 상세주소" required
             style=" height:40px;width:440px;border-radius: 9px;">
            <br>
           	<span id="address2CheckResult"></span>
            <br>
            <input type="text" class="input1" name="storeName" id="storeName" placeholder="상호명"
             style=" height:40px;width:440px;border-radius: 9px;">
            <br>
           	<span id="storeNameCheckResult"></span>
            <br>
            <input type="text" class="input1" name="ceo.no" id="businessRegistrationNo" placeholder=" 사업자번호는 숫자, - 를 사용(ex 123-45-67890)" required
             style=" height:40px;width:440px;border-radius: 9px;">
            <br>
           	<span id="noCheckResult"></span>
            <img src="" id="preview-image" style="width: 440px;">
            <p>상호 대표 이미지 &nbsp; <input type="file" name="storeImg2" id=storeImg></p>
            <br>
            
            <!-- 모달 띄우기 -->
         	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop" id="terms" value ="N" onclick="terms1()">약관 보기</button> 
            <br>

            <!--약관 Modal -->
            <div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                     <div class="modal-header">
                     <h5 class="modal-title" id="staticBackdropLabel">이용 약관 </h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                         <span aria-hidden="true">&times;</span>
                     </button>
                     </div>
                     <div class="modal-body">    
                         <p>
                             Mommysonmat 서비스는 개인정보를 다음의 목적을 위해 처리합니다. <br>
                             처리한 개인정보는 다음의 목적 이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.<br><br>
                             
                             ①Mommysonmat 서비스는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 <br>
                             개인정보를 수집시에 동의 받은 개인정보 보유, 이용기간 내에서 개인정보를 처리, 보유합니다.<br><br>
                             ②Mommysonmat 서비스는 회원가입, 회원 식별, 서비스 이용 등을 위해 아래와 같이 개인정보를 수집ᆞ이용합니다.<br><br>
                             
                                 수집 목적: 회원 식별 및 Mommysonmat 서비스 이용 <br>
                                 수집 항목:아이디, 비밀번호, 전화번호, 이메일, 우편번호, 주소, 상호, 상호 이미지, 사업자등록증 <br>
                                 수집 근거 : 정보주체의 동의 <br>
                                 수집 기간 : 회원탈퇴 시 까지<br><br>
                             
                             ③ 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체 없이 파기합니다. <br>
                             단, 법령에서 일정기간 의무를 부과하는 경우에는 해당 기간 동안 보관할 수 있습니다.<br><br>
                             ④ Mommysonmat  서비스를 이용할 때 자동적으로 여러분이 사용하는 장치의 유형, 운영체제 버전, 장치 고유 식별번호를 수집합니다. <br>
                             그 외에도 Mommysonmat 서비스를 이용하는데 필요한 다른 정보를 수집할 수 있으나 회원의 잔디 서비스를 이용하는 목적 용도로만 이용되며 그 외의 목적으로는 이용되지 않습니다.<br><br>
                         
                             귀하께서는 본 안내에 따른 개인정보 수집에 대하여 거부를 하실 수 있는 권리가 있습니다. <br>
                             본 개인정보 수집에 대하여 거부하시는 경우, 본인확인 등 신원확인이 되지 않음에 따라 Mommysonmat 서비스를 사용 하실 수 없습니다.
                         </p>
                     	<br>
                     </div>
                     <div class="modal-footer">
                     <button type="button" class="btn btn-primary" id="ok">확인</button>
                     </div>
                  </div>
                </div>
            </div> 
       		<input type=checkbox id="all" name="all">
            <input type="hidden" id="allHd" value="N">
            <span>약관 전체 동의</span> 
            <br>
            <input type=checkbox name="checkbox" id="checkbox">
            <span>만 14세 이상<strong>(필수)</strong></span>
            <br>
            <input type=checkbox name="checkbox" id="checkbox">
            <span>개인정보 처리방침<strong>(필수)</strong></span>
            <br>
            <input type=checkbox name="checkbox" id="checkbox">
            <span>서비스 이용 약관<strong>(필수)</strong></span>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; 
            <button type="submit" id="joinButton" style="height:40px; width:100px; border-radius: 9px; background-color:rgb(247, 170, 145);">가입하기</button>
            <button type="reset" id="goJoin">취소하기</button>
            <br><br>
        	</form>        
        </div>
    </div>
    <jsp:include page="../commons/footer.jsp"/>
        
	<script>
		/* 이미지 미리보기 */
		function readImage(input) {
			if(input.files && input.files[0]) {
				
				const reder = new FileReader();
				
				reader.onload = e => {
					const previewImage = document.getElementById("preview-image");
					previewImage.src = e.target.result;
				}
				
				reder.readAsDataURL(input.files[0]);
			}
		}
		
		const inputStoreImg= document.getElementById("storeImg");
		inputStoreImg.addEventListener("change", e => {
			readImage(e.target);
		});
		
		// 가입 버튼 클릭시 상호 이미지 사진 등록
		$('#joinButton').on('click', function(){
			let img = $('#preview-image').attr('src');
		});
	
	</script>
    
    <script>

        function validate(){
            var id = document.getElementById("id");
            var pwd1 = document.getElementById("pwd1");
            var pwd2 = document.getElementById("pwd2");
            var name = document.getElementById("name");
            var account = document.getElementById("account");
            var phone = document.getElementById("phone");
            var email = document.getElementById("email");
            var code = document.getElementById("code");
            var address1 = document.getElementById("address1");
            var address2 = document.getElementById("address2");
            var storeName = document.getElementById("storeName");
            var businessRegistrationNo = document.getElementById("businessRegistrationNo");
            var storeImg = document.getElementById("storeImg");
            var all = document.getElementById("all");
        
            if(id.value == ""){
                alert("아이디를 입력해주세요.")
                id.focus();
                return false;
            }


            if(pwd1.value == ""){
                alert("비밀번호를 입력해주세요.")
                pwd1.focus()
                return false;
            }


            if(pwd1.value != pwd2.value){
                alert("비밀번호를 확인해주세요.")
                pwd2.focus()
                return false;
            }

            if(name.value == ""){
                alert("대표자명을 입력해주세요.")
                name.focus()
                return false;
            }

            if(account.value == ""){
                alert("계좌번호를 입력해주세요.")
                account.focus()
                return false;
            }


            if(phone.value == ""){
                alert("전화번호를 입력해주세요.")
                phone.focus()
                return false;
            }

            if(email.value == ""){
                alert("이메일을 입력해주세요.")
                email.focus()
                return false;
            }

            if(zipCode.value == ""){
                alert("우편번호 검색해주세요.")
                zipCode.focus()
                return false;
            }
            
            if(address1.value == ""){
                alert("주소를 입력해주세요.")
                address1.focus()
                return false;
            }
            
            if(address2.value == ""){
                alert("상세주소를 입력해주세요.")
                address2.focus()
                return false;
            }
            
            if(storeName.value == ""){
                alert("상호를 입력해주세요.")
                storeName.focus()
                return false;
            }
            
            if(businessRegistrationNo.value == ""){
                alert("사업자 등록번호를 입력해 주세요.")
                businessRegistrationNo.focus()
                return false;
            }
            
            if(storeImg.value == ""){
                alert("상호 대표 이미지를 첨부해주세요.")
                storeImg.focus()
                return false;
            }


        }

        function chk(re, ele, msg){
                if(!re.test(ele.value)){
                    alert(msg);
                    ele.select();
                    return false;
                }
                return true;
        }
        
       /* 아이디 입력 여부 확인 & 정규식 확인 */
       
       $("#id").blur(function(){
	 	 var inputId = $("#id").val();
	 	 var regex = /^[a-z]+[a-z0-9]{3,11}$/g;
		 var result = regex.exec(inputId);
		 var idCheckResult = $("#idCheckResult");
			 
			 if(inputId == ""){
				 idCheckResult.html("아이디를 입력하신 후 중복 확인 버튼을 클릭해주세요.");
				 idCheckResult.attr("class", "incorrect");
				 return false;
				 
			 } else {
	
				 if(result != null){
					 idCheckResult.html("");
					 return true;
				 } else {
					 idCheckResult.html("아이디 형식이 올바르지 않습니다. 아이디는 알파벳 소문자, 숫자를 혼합하여 4~12 글자로 작성해주세요.");
					 idCheckResult.attr("class", "incorrect");
					 return false;
				 }
			 }
			 
	   });  
        
      /* 아이디 중복 체크 여부 확인 알럿 */
      
	    $(function(){  
	       $("#joinButton").click(function(){ 
	    	  if($("#idChkHd").val() == 'N'){
	    		  alert("아이디 중복확인을 해주세요.");
	    		  return false;
	    		  }
	    		  
	    	  }); 
	      });
       

        /* 아이디 입력 여부 확인 알럿 & 중복 확인 알럿 */
         function idChk1(){
        	
        	let id = $('#id').val();
        	let id2 = $('#id');
        	
            if(id == ""){
                alert("아이디를 입력해주세요.");
                id2.focus();
                return false;
                
            } else {     
            	
	        	$.ajax({
	        		url : "${ pageContext.servletContext.contextPath }/member/idChk",
	        		type : "post",
	        		data : {
	        			id : id
	        		},
	        		async: false,
	        		success:function(data){
	        			console.log("data : " + data);
        				
	        			var regex = /^[a-z]+[a-z0-9]{3,11}$/g;
	        			var result = regex.exec(id);
	        			
	        			if(data == '1') {
	        				alert("중복된 아이디 입니다.");
	        				return false;
	        				
	        			} else if(data == '0') {
	        				
	        				if(result !=null){
	        					$('#idChkHd').attr("value","Y");
	        					alert("사용가능한 아이디입니다.");
	        					idCheckResult.html("");
	        					return true;
	        				
	        				} else { 
	        					idCheckResult.html("아이디 형식이 올바르지 않습니다. 아이디는 알파벳 소문자, 숫자를 혼합하여 4~12 글자로 작성해주세요.");
	       					 	idCheckResult.attr("class", "incorrect");
	        					return false;
	        				} 
	        			}
	        		},
	         		error:function(error){
	        			alert(error);
	        			
	        		}
        	  	 
        		});
        	            
           	 }
        	
    	 }  

      
        /* 비밀번호 입력 여부 확인 알럿 & 정규식 확인 */
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
       
       
       /* 이름 입력 여부 확인 알럿 & 정규식 알럿 */
       $("#name").blur(function(){
       	var inputName = $("#name").val();
       	var regex = /^[가-힣]{2,}$/;
       	var result = regex.exec(inputName);
       	var nameCheckResult = $("#nameCheckResult");
       	
       	if(inputName == ""){
       		nameCheckResult.html("대표자명을 입력해주세요.");
       		nameCheckResult.attr("class", "incorrect");
       		return false;
       	} else {
       		
       		if(result != null) {
       	  		nameCheckResult.html("");
       			return true;
       			
       		} else {
       			nameCheckResult.html("대표자명 형식이 올바르지 않습니다. 대표자명은 한글로 2글자 이상 입력해주세요. ");
       			nameCheckResult.attr("class", "incorrect");
       		 	return false;
       		}
       	}
       	
       });
       
       
      /* 계좌번호 여부 확인 알럿 */
      $("#account").blur(function(){
   	   var inputAccount = $("#account").val();
   	   var regex = /^(\d{1,})(-(\d{1,})){1,}/;
   	   var result = regex.exec(inputAccount);
   	   var accountCheckResult = $("#accountCheckResult");
   	   
   	   if(inputAccount == "") {
   			accountCheckResult.html("계좌번호를 입력해주세요.");
   			accountCheckResult.attr("class","incorrect");
       		return false;
       		
   	   } else {
   		   
   		   if(result != null){
   			accountCheckResult.html("");
   			return true;
   			
   	 	  } else {
   	 		  
   	 		accountCheckResult.html("계좌번호 형식이 올바르지 않습니다. 계좌번호는 숫자와 - 를 사용해주세요.");
   			accountCheckResult.attr("class", "incorrect");
   			return false;
   	 	  }
   	 		  
   	   }
   	   
      });
       
       
       /* 전화번호 정규식 알럿 */
       $("#phone").blur(function(){
       	var inputPhone = $("#phone").val();
       	var regex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
       	var result = regex.exec(inputPhone);
       	var phoneCheckResult = $("#phoneCheckResult");  
       		
       		if(inputPhone == ""){
       			phoneCheckResult.html("전화번호를 입력해주세요.");
       			phoneCheckResult.attr("class","incorrect");
       			return false;
       	
       		} else {
       			
       			if(result != null) {
       				phoneCheckResult.html("");
       				return true;
       			} else {
       				phoneCheckResult.html("전화번호 형식이 올바르지 않습니다. 올바른 형식으로 9~11자리 숫자를 입력해주세요.");
       				phoneCheckResult.attr("class","incorrect");
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
		 			emailCheckResult.html("이메일을 입력하여 중복확인 후, 인증번호 전송 버튼을 눌러 인증번호를 입력해주세요.");
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
       
       /* 이메일 중복 체크 여부 확인 알럿 */
	    $(function(){  
	       $("#joinButton").click(function(){ 
	    	  if($("#emailChkHd").val() == 'N'){
	    		  alert("이메일 중복확인을 해주세요.");
	    		  return false;
	    		  }
	    		  
	    	  }); 
	      });
       
       
		/* 이메일 입력 확인 알럿 & 중복확인 알럿 & 중복확인시 정규식 확인 알럿 */
      function emailChk1() {
     	
	      	let email = $('#email').val();
	      	let email2 = $('#email');
	      	
	          if(email == ""){
	              alert("이메일을 입력해주세요.")
	              email2.focus();
	              return false;
	              
	          } else {     
	
	        	  $.ajax({
		    			url : "${ pageContext.servletContext.contextPath }/member/emailChk",
		    			type : "post",
		    			data : {
		    				email : email
		    			}, 
		    			async : false,
		    			success : function(data){
		    				console.log("data : " + data);  
		    				
		    			  	var regex =/.+@[a-z]+(\.[a-z]+){1,2}$/;
		    			  	var result = regex.exec($('#email').val());
		    			  	
		    				if(data == '1'){
		    					alert("중복된 이메일 입니다.");
		    					return false;
		    					
		    				} else if(data == '0') {
		    					
		    					if(result != null){
		    						$('#emailChkHd').attr("value", "Y");
		    						alert("사용가능한 이메일 입니다.");
		    						return true;
		    					} else {
		    						alert("이메일 형식이 올바르지 않습니다 올바른 이메일 형식을 입력해주세요.");
		    						return false;
		    						
		    					}
		    			  	}	
		    			},
		    			error : function(error){
		    				alert(error);
	  				}
	  			});
	          }
	      } 
		
		
        
        /* 이메일 인증번호 전송 & 비교 */
        $("#submit").click(function(){
        	
        	alert("이메일에 인증번호를 발송하였습니다. 이메일을 확인해주세요.");
    		var email = $("#email").val(); 
    		
    		$.ajax({
    			type:"POST",
    			url:"mailCheck",
    			data : {
    				email : email
    			}, 
	    		async: false
    		});
    	});
        
        
     
        /* 회원가입할 때 전송버튼 눌러 데이터베이스에 저장한 인증번호와 일치하는 이메일 조회해서 인증번호 일치 여부 안내 */
     
     	 function codeChk1(){
    		var email = ""; // 이메일 인증번호 저장을 위한 코드
    		var inputCode = $("#code").val(); // 입력코드	
    		
			$.ajax({
				type : "post",
				url : "codeCheck",
				data : {
					inputCode : inputCode	
				},
				async : false,
				success:function(data){ //조회한 이메일 
					console.log("data : " + data); 
					email = data;
						
    				var inputEmail = $("#email").val(); // 입력코드 
    				var codeCheckResult = $("#codeCheckResult"); // 비교결과 
    				
    				if(inputEmail != email){
    					if(inputCode == ""){
	   						codeCheckResult.html("이메일과 인증번호가 일치하지 않습니다. 인증번호를 다시 확인해주세요.");
	   						codeCheckResult.attr("class", "incorrect");
	   						return false;
	   						
    					} else{
    						codeCheckResult.html("이메일과 인증번호가 일치하지 않습니다. 인증번호를 다시 확인해주세요.");
	   						codeCheckResult.attr("class", "incorrect");
	   						return false;
    					}
    					
    				} else {
    					
    					if(inputCode != ""){
    						codeCheckResult.html("이메일과 인증번호가 일치합니다.");
    						codeCheckResult.attr("class", "correct");
  							return true;
    					}
    				}
					
				},
				error : function(error){
   				alert(error);
   			}
			});
   		
    	};

       /* 우편번호 검색 */
		const $searchZipCode = document.getElementById("searchZipCode");
		
        $searchZipCode.onclick = function() {
        
            //다음 우편번호 검색 창을 오픈하면서 동작할 콜백 메소드를 포함한 객체를 매개변수로 전달한다.
            new daum.Postcode({
                oncomplete: function(data){
                    //팝업에서 검색결과 항목을 클릭했을 시 실행할 코드를 작성하는 부분
                    document.getElementById("zipCode").value = data.zonecode;
                    document.getElementById("address1").value = data.address;
                    document.getElementById("address2").focus();
                }
            }).open();
        }
        

        /* 지역코드 체크여부 확인 알럿 */
  		$(function(){
  			$('#joinButton').click(function(){
  				if($('#locationCode').val() == 'N'){
  					alert('구 저장 버튼을 클릭해주세요 ');
  					return false;
  				}
  			});
  		});

        

        
		/* 서블릿에서 가져온 지역 코드 밸류에 넣기 */ 
	    function locationCode1(){
	    	let address1 = $('#address1').val();
	    	$.ajax({
	    		url : "${ pageContext.servletContext.contextPath }/member/locationCode",
	    		type : "post",
	    		data : {
	    			address1 : address1
	    		},
	    		async: false,
	    		success:function(data){
	    			$("#locationCode").val(data); 
	    		},
	    		error:function(error){
	    			alert(error);
	    		}
	    	
	    	});
	    }
		
 		/* 상세주소 입력 여부 확인 알럿 */
        $("#address2").blur(function(){
        	var inputAdress2 = $("#address2").val();
        	var address2CheckResult = $("#address2CheckResult");
        	
        	if(inputAdress2 == ""){
        		address2CheckResult.html("상세주소를 입력해주세요.");
        		address2CheckResult.attr("class", "incorrect");
        		return false;
        	} else {
       			address2CheckResult.html("");
       		 	return true;
        	}
        	
        });

      /* 상호명 입력 여부 확인 알럿 */
      $("#storeName").blur(function(){
   	   var inputStoreName = $("#storeName").val();
   	   var storeNameCheckResult = $("#storeNameCheckResult");
   	   
	   	   if(inputStoreName == "") {
		   		storeNameCheckResult.html("상호명을 입력해주세요.");
		   		storeNameCheckResult.attr("class", "incorrect");
	       		return false;
		   	} else {
		   		storeNameCheckResult.html("");
			 	return true;
			}	
	   	   
      });
   	   

      /* 사업자등록번호 입력 여부 확인 알럿 */
      $("#businessRegistrationNo").blur(function(){
   	   var inputBusinessRegistrationNo = $("#businessRegistrationNo").val();
   	   var regex = /^(\d{3,3})+[-]+(\d{2,2})+[-]+(\d{5,5})/;
   	   var result = regex.exec(inputBusinessRegistrationNo);
	   var noCheckResult = $("#noCheckResult");
   	   
	   	   if(inputBusinessRegistrationNo == "") {
	   			noCheckResult.html("사업자등록번호를 입력해주세요.");
	   			noCheckResult.attr("class", "incorrect");
	       		return false;
	       		
		   	} else {
		   		
		   		if(result != null) {
		   		noCheckResult.html("");
			 	return true;
			 	
		   		} else {
		   			noCheckResult.html("사업자번호 형식이 올바르지 않습니다.	사업자번호는 숫자와 - 를 사용해주세요. ex 123-45-67890 ");
		   			noCheckResult.attr("class", "incorrect");
				 	return false;
		   		}
			}	
	   	   
      });
		
       /* 약관 전체 동의 체크 박스를 선택하면 전체 체크 박스가 선택 */ 
       $("#all").on("change",function(){
       	
           if($("#all").is(":checked")){
               $("input[name=checkbox]").prop("checked",true);
               
           } else {
               $("input[name=checkbox]").prop("checked",false);
           }
       });
       

       /* 이용약관 동의 모달창 */
       $('#terms').click(function(e){
           $('#staticBackdrop').modal('show');
           e.preventDefault();
       });
       $('#ok').click(function(e){
           $('#staticBackdrop').modal('hide');
       });
       
       
     	/* 약관 체크 박스 클릭 안내 */
     	$(function(){
     		$('#joinButton').click(function(e){
     			if($('#all').is(":checked") && $('#checkbox').is(":checked")){
     				$("#allHd").val() == 'Y'
     			} else {	
     				alert('약관 전체 동의를 클릭해 주세요. ');
     				e.preventDefault();
     			}
     			
     		});
     	});
     
     	
		/* 회원가입버튼 클릭시 폼태그, 회원가입 서블렛 요청 */
		$(document).ready(function(){
			
			$("#joinButton").click(function(){
				$("#join_form").attr("action", "${ pageContext.servletContext.contextPath }/member/businessJoin");
				$("#join_form").submit();
				
			});
		});
		
	
		/* 회원가입 페이지로 돌아가기 */
			const $goJoin = document.getElementById("goJoin");
	            $goJoin.onclick = function() {
	                location.href = "${ pageContext.servletContext.contextPath }/member/join";
	            }

   
    </script>
</body>
</html>