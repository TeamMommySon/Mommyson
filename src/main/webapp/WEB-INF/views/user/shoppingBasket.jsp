<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/shppingBusket.css">
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>

<body>

	<jsp:include page="../commons/header.jsp"/>
	<br>
    <img class=cart1 src="${ pageContext.servletContext.contextPath }/resources/images/cart1.png" >
    
 	<form method="post">
	    <table id="table1">
	      <tr id="tr1">
	        <th><input type=checkbox id="all"></th>
	        <th>가게 정보</th>
	        <th>제품 정보</th>
	        <th>제품 금액</th>
	        <th>수량</th>
	        <th>총 제품 금액</th>
	      </tr>
	      </table>
	      
			<c:choose>
	    		<c:when test="${ map.count == 0 }"> 장바구니가 비어있습니다. </c:when>
	    		<c:otherwise>
	    			<c:forEach var="row" items="${ map.cartList }" varStatus="i">
	    				<table  id="table2" style="width: 80%; margin-left:10%; text-align: center; border :1px solid black;">	    				
		    				<tr id="tr2">
						        <td><input type="checkbox" class="checkbox" name="checkbox" id="checkbox" value="${ row.totalPrice }"/>
						        <input type="hidden" class="checkboxHd" value="${ row.cartCode }"/></td>
								<td><input type="hidden" id="memCode" name="memCode" value="${ row.memCode }"/></td>
						        <td><input type="hidden" name="storeName" value="${ row.storeName }"/></td>
						        <td><input type="hidden" name="sdCode" value="${ row.sdCode }"/></td>
						        <td><input type="hidden" name="sdName" value="${row.sdName }"/></td>
						        <td><input type="hidden" id="numberUpDown" name="amount" value="${ row.amount }"/></td>
						        <td id="storeImgTd" style="width: 15%;"><img id="storeImg" style="width :100px; height:100px;" 
						        src="${ pageContext.servletContext.contextPath }/${ row.storeImg }"/>
						        <br><c:out value="${ row.storeName }"/></td>
						        <td id="sdImgTd" style="padding-top: 13px; width: 25%;""><img id="sdImg" style="width :100px; height:100px;" 
						        src="${ pageContext.servletContext.contextPath }/${ row.sdImg }"/>
						        <br><c:out value="${ row.sdName }"/></td>
						       
						        <td  style="width: 17%;"><span id="price"><c:out value="${ row.price }"/></span>원</td>
						        <td  style="width: 13%;" >
						         	<div class="number">
							           	<a href="#" id="decreaseQuantity"> - </a>
							            <span id="numberUpDown" name="amount"><c:out value="${ row.amount }"/></span>
							            <a href="#" id="increaseQuantity"> + </a>
						        	</div>
						        </td>
						        <td><span id="totalPrice" name="totalPrice"><c:out value="${ row.totalPrice }"/></span>원</td> 
					      	</tr>
				      	</table>
				    </c:forEach> 
		    	</c:otherwise>
		    </c:choose>	      	

	    <div id="div2">
	      <table id="table3">
	        <tr>
	          <th>총 제품 금액 합계(배달 시 배송비 별도)</th>
	          <td id="paymentAmount" name="paymentAmount"></td>
	        </tr>
	      </table>
	    </div>
	    <br> 
	    <p id="p1">쿠폰으로 추가 할인 받으세요!</p>
	    <br>  
	   	<button type="button" id="selectDelete" onclick="selectDelete1('product')">선택삭제</button>	
    </form>
   	<button id="package" onclick="gopay('pack')" style="margin-left:78%;">방문포장</button>
   	<button id="delivery" onclick="gopay('deli')">배달예약</button>
	<br><br><br><br><br>
    <jsp:include page="../commons/footer.jsp"/>

	<script>

	
	/* 수량증감에따라 totalCount 변경 */

    $(function(){
       
	     	var stat = $('#numberUpDown').text();
	      	var num = parseInt(stat,10);
    	
	    $('#decreaseQuantity').click(function(e){
	      e.preventDefault();
	      
	      num--;
	      if(num < 0){
	      	num = 0;
	      	
	      }
	      
	      $('#numberUpDown').text(num);
	       var price =$("#price").text();
	       var stat = $('#numberUpDown').text();
 	       console.log(price); 
		   console.log(stat);
 	       var totalPrice = price * stat; 
 	       $("#totalPrice").text(totalPrice);

	    
	    });
	    
	    $('#increaseQuantity').click(function(e){
	      e.preventDefault();
	      
	      num++;
	      
	      $('#numberUpDown').text(num);
   	       var price =$("#price").text();
	       var stat = $('#numberUpDown').text();
 	       console.log(price); 
		   console.log(stat);
 	       var totalPrice = price * stat; 
 	       $("#totalPrice").text(totalPrice);
	      
	  });
	    
	    
	});  
	
	  /* 전체 체크, 해제 */
	  $("#all").click(function(){
	        if($("#all").is(":checked")){
	            $("input[name=checkbox]").prop("checked",true);
	        } else {
	            $("input[name=checkbox]").prop("checked",false);
	        }
	  });
	  
	  
	  
		/* 가게별 합계구하기 */

		$("input:checkbox").click(function(){
			
			let arr = 0;
	        $("input[name=checkbox]:checked").each(function(item,value){
	        	
	        	arr += parseInt($(this).val());
	        	
	        });
	         
	        $("#paymentAmount").text(arr); 
	        
		});
	  
		
	  

		function gopay(str) {
			let orderList = [];
			let storeCode = [];
			let storeName = [];
			let sdCode = [];
			let sdName = [];
			let amount = [];
			$("input:checkbox[name='checkbox']:checked")
					.each(
							function() {
								orderList.push($(this).val());
								storeCode.push($(this).parent().next()
										.children().val());
								storeName.push($(this).parent().next().children()
										 .parent().next().children().val());
								sdCode.push($(this).parent().next().children()
									  .parent().next().children()
									  .parent().next().children().val());
								sdName.push($(this).parent().next().children()
									  .parent().next().children()
									  .parent().next().children()
									  .parent().next().children().val());
								amount.push($(this).parent().next().children()
									  .parent().next().children()
									  .parent().next().children()
									  .parent().next().children()
									  .parent().next().children().val());

							});

			console.log(storeCode);
			
			$(function(e){
				if (str == "pack") {
					console.log(memCode);
					if ($(".checkbox").is(":checked") != null && $(".checkbox").is(":checked")  != 0) {
						location.href = '${ pageContext.servletContext.contextPath }/user/packagePay?orderList=' + orderList
										+ "&storeCode=" + storeCode + "&storeName=" + storeName
									    + "&sdCode=" + sdCode + "&sdName=" + sdName + "&amount=" + amount;
									    
						return true;
					} else {
						alert("결제할 상품을 클릭해주세요.");
						e.preventDefault();
					}
				

				} else if (str == "deli") {
					console.log(memCode);
					if ($(".checkbox").is(":checked") != null && $(".checkbox").is(":checked")  != 0) {
						location.href = '${ pageContext.servletContext.contextPath }/user/deliveryPay?orderList=' + orderList
										+ "&storeCode=" + storeCode + "&storeName=" + storeName
									    + "&sdCode=" + sdCode + "&sdName=" + sdName + "&amount=" + amount;
						return true;
						
					} else {
						alert("결제할 상품을 클릭해주세요.");
						e.preventDefault();
					}
	
				}
			});	
		}
	
 		function selectDelete1(str) {
			let deleteList = [];
		
			$("input:checkbox[name='checkbox']:checked").each(function(){ 
				deleteList.push($(this).next().val());
				
			});
		
			console.log(deleteList);
			
			$(function(e){
				if(str == "product") {
					location.href = '${ pageContext.servletContext.contextPath }/user/deleteCart?deleteList=' + deleteList;
					return true;
							
				} else {
					alert("삭제할 상품을 삭제해주세요.");
					e.preventDefault();
				}
				
			});
				
		} 
		
	</script>

</body>
</html>