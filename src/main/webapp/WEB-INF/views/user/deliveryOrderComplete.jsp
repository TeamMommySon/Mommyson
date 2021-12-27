<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달 결제 완료 화면</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/orderComplete.css">
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>

<body>
<jsp:include page="../commons/header.jsp"/>
    <br><br><br>

    <form method="get" action="${ pageContext.servletContext.contextPath }/userMyPage/myOrderList">
    <h3 id="orderComplete">주문완료</h3>
    <br>
    <div id="div">
      <p id="p">주문이 성공적으로 완료되었습니다.</p>
      <br>
 	<button type="submit" id="myOrderList" style="margin-left: 39%; width:100px; height:40px; border-radius: 9px; color:rgb(247, 170, 145);
              font-size: 20px; border:2px solid rgb(247, 170, 145); background-color:rgb(255, 255, 255); margin-left: 43%;">주문내역</button>
    </div>
    <br><br>

    <p id="information">주문자 정보</p>
    <br>
    
    <table id="table1">  
        <tr>    
            <th name="phone">연락처</td>
            <td><c:out value="${ requestScope.orderList[0].PHONE }"/></td>
        </tr>
        <!-- 만약 딜리버리 페이에서 주소 Order_TBL걸로 하나만 업로드했다면 주소만 쓸것  -->
        <tr>
            <th name="postCode">우편번호</th>
            <td><c:out value="${ requestScope.orderList[0].POST_CODE }"/></td>
        </tr>
        <tr>
            <th name="address">주소</th>
            <td><c:out value="${ requestScope.orderList[0].ADDRESS }"/></td>
        </tr>
        <tr>
            <th name="dAddress">상세주소</th>
            <td><c:out value="${ requestScope.orderList[0].D_ADDRESS }"/></td> 
        </tr>
    </table>
    <br>
    <br>

    <p id="orderProduct">주문 내역</p>
    	<input type="hidden" id="orderCode" name="code" value="${ requestScope.orderList[0].ORDER_CODE }"/>
   		<br>    
	    <table id="table2" style="margin-left : 23%;">  
	
		        <tr>
		            <th id="restaurantInformation" name="storeName">가게상호 </th>
		            <th id="productInformation" name="sdCode">반찬명</th>
		            <th id="quantity" name="amount">수량</th>
		            <th id="paymentAmount" name="totalPrice">결제금액</th>
		            <th id="takeTime" name="time">예약시간</th>
		        </tr>
		        <c:forEach var="row" items="${ requestScope.orderList }" varStatus="i">
			        <tr>
			            <td><c:out value="${ row.STORE_NAME }"/></td>
			            <td><c:out value="${ row.SD_NAME }"/></td>
			            <td><c:out value="${ row.AMONT }"/></td>
			            <td><c:out value="${ row.TOTAL_PRICE }"/></td>
			        	<td><c:out value="${ row.TAKE_TIME }"/></td>
			        </tr>
           	    </c:forEach>
	    </table>

    </form>
    <br><br><br><br>
    <jsp:include page="../commons/footer.jsp"/>
    
<!--     
<!—     <script>
    
	$("#myOrderList").on('click', function(){
		let orderCodes = [];
		$('#orderCode').each(function(index,val){
			orderCodes.push($(this.val()));
		});
  		
		location.href = "${ pageContext.servletContext.contextPath }/userMyPage/myOrderList?orderCodes=" + orderCodes ; 
	});

    </script> —> -->
</body>
</html>