<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>일반회원조회</title>
</head>
<body>
    <header class="manager_header at-container">
        <img src="${ pageContext.servletContext.contextPath }/resources/images/managerLogo.png" alt="마미손맛 MANAGEMENT">
        <a href="../main.html" class="home_btn">
            <img src="${ pageContext.servletContext.contextPath }/resources/images/mainHome.png" alt="메인화면으로">
            <p>메인화면으로</p>
        </a>
    </header>
    <div class="head_line"></div>
    <div class="at-container total_container">
    
        <jsp:include page="../commons/managerSidebar.jsp"></jsp:include>
        
        <div class="board_container">
            <h2>회원관리</h2>
            <form action="${ pageContext.servletContext.contextPath }/manager/deleteMember" method="POST">
	            <div class="top_box">
	                <p>일반 회원 조회</p>
	                <input type="submit" value="회원삭제">
	            </div>
	
	            <table class="table board_table">
	                <colgroup>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                </colgroup>
	                <thead style="background-color: #EDEDED;">
	                    <tr>
	                        <th><input type="checkbox" name="chkAll" id="chk_all"></th>
	                        <th>번호</th>
	                        <th>아이디</th>
	                        <th>닉네임</th>
	                        <th>이메일</th>
	                        <th>가입일</th>
	                        <th>총 주문금액</th>
	                        <th>경고</th>
	                        <!-- <th>상태</th> -->
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach items="${ requestScope.normalMemberList }" var="nm" varStatus="vst">
		                    <tr>
		                        <th scope="row"><input type="checkbox" name="chkMember" value="${ nm.memCode }" class="chkbox"></th>
		                        <td>${ nm.memCode }</td>
		                        <td>${ nm.memId }</td>
		                        <td>${ nm.nickname }</td>
		                        <td>${ nm.email }</td>
		                        <td>${ nm.enrollDate }</td>
		                        <c:set value="0" var="c"/>
		                        <td class="totalPrice"><button type="button" style="border: 0; padding: 7px;" onclick="totalPrice(this);">확인하기</button><span class="total"></span></td>
		                        <td>${ nm.user.repCount }</td>
		                        <%-- <td class="memberState">${ nm.isDeleted }</td> --%>
		                    </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
            </form>
           	<input type="button" name="blackAdd" id="black_add" value="블랙등록" class="black_btn">
            
            <script>
            	$("#black_add").on('click', function(){
            		
            		let changeList = $(".board_table > tbody > tr");
            		let chkMember = [];
            		
            		$("input:checkbox[name='chkMember']:checked").each(function(i, ival) {
            			chkMember.push($(this).val());
            			console.log(chkMember);
                    });
            		
            	
            		$.ajax({
            			url : '${ pageContext.servletContext.contextPath }/manager/registBlack/' + chkMember,
            			type : 'GET',
            			success: function(data){
            				console.log(data);
            				location.href="${ pageContext.servletContext.contextPath }/manager/normalMember";
            			},
            			error: function(error){
            				console.log(error);
            			}
            		});
            	});
            </script>
            
            <!-- 페이징 -->
            <jsp:include page="../commons/paging.jsp"/>
        </div>
    </div>

    <jsp:include page="../commons/footer.jsp"></jsp:include>

    <script>
 
	    $("#homeSubmenu1").addClass("show");
	    $("#homeSubmenu1 > li:first-child > a").attr("style","color: #F89E91 !important");
	    
	    $("#chk_all").click(function(){
	   	 let chk = $(this).is(":checked");
	   	 if(chk){
	   		 $(".board_table > tbody > tr th input").prop('checked', true);
	   	 } else{
	   		 $(".board_table > tbody > tr th input").prop('checked', false);
	   	 }
	   	 
	    });
	    
	    /* if($(".memberState").text().charAt(0) == 'N'){
    		$(".memberState").text("정상")
    	} */
	    
	    function totalPrice(e){
	    	
	    	let getMemCode = e.parentElement.parentElement.firstElementChild.firstElementChild.value;
	    	let price = e;
	    	let result = e.nextElementSibling;
	    	$.ajax({
	    		url : '${ pageContext.servletContext.contextPath }/manager/totalPrice',
	    		type : 'POST',
	    		data : {
	    			getMemCode : getMemCode
	    		},
	    		success : function(data){
	    			$(price).css('display','none');
	    			$(result).text(data + "원");
	    		},
	    		error : function(error){
	    			console.log(error);
	    		}
	    	});
	    }
	    
	    /* for(let i = 0; i < $('.totalPrice input').length; i++){
	    	let total = $('.totalPrice input');
		    console.log(total[i].value);
		    console.log('isNan : ', typeof total[i]);
		    
	    } */
	    
	    /* const sum = num1.reduce((a,b) => (a+b));
	    document.write('reduce : ', sum); */
	    
	    
	    
	    /* document.write('forEach item : ', sumsum); */
	    
	    /* let total = $('.totalPrice').text().replace("[", "");
	    let result = total.replace("]", "");
	    let result1 = result.replace(/[[]]/gi,"");
	    let result2 = result1.replace("[", "");
	    let result3 = result2.replace("]", "");
	    let totalResult = result3.split(",");
	    
	    let arr = [];
	    let num = 0;
	    for(let i = 0; i < totalResult.length; i++){
	    	arr[i] = Number(totalResult[i]);
	    	num += arr[i]
	    }
	    console.log(arr);
	    console.log(num);
	    
	    $('.totalPrice').text(num); */
	    /* let trLength = $('.board_table tr');
	    for(let i = 0; i < trLength.length; i++ ){
	    	
	    } */
	    
	    
     </script>
</body>
</html>