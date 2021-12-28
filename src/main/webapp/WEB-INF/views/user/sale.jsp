<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    
    <jsp:include page="../commons/header.jsp"/>

      <section>
        
        <h1 align="center" style="margin-top: 100px;">오늘만 할인</h1>
        <div class="container-xl" style=" margin-top: 150px;">
            <div class="row" style="margin-bottom: 100px;">
                <c:forEach items="${ requestScope.productList }" var="product">
	                <div class="col-3">
	                    <img style="width: 160px; height: 160px; border-radius: 10px; border: 1px solid gray;" src="${ pageContext.servletContext.contextPath }/${ product.sdImg }">
	                    <div class="menu_div"> 
	                        <a href="${ pageContext.servletContext.contextPath }/user/sidedish_detail?sdCode=${ product.sdCode }&memCode=${ product.memCode }" class="menu_name">${ product.sdName }(${ product.volume }g)</a>
	                        <pre><strong><fmt:formatNumber value="${ product.price - (product.price * product.discountRate / 100) }" />원</strong>  <label style="text-decoration: line-through; color: lightgray;"><fmt:formatNumber value="${ product.price }" />원</label></pre>
	                        <strong style="font-size: 10pt; display: flex; align-items: center;"><svg style="margin-right: 5px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shop-window" viewBox="0 0 16 16">
	                            <path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h12V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zm2 .5a.5.5 0 0 1 .5.5V13h8V9.5a.5.5 0 0 1 1 0V13a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9.5a.5.5 0 0 1 .5-.5z"/>
	                        </svg>${ product.storeName }</strong>
	                    </div>
	                </div>
                </c:forEach>
            </div>
            <jsp:include page="../commons/pagingWithoutSearch.jsp"/>
        </div>
        <c:if test="${ sessionScope.loginMember != null && sessionScope.loginMember.memType == 'user' }">
        	<div id="cart_logo">
        		<c:if test="${ sessionScope.cartCount != 0 }">
        			<div style="background: #FFF9C2; width: 23px; height: 23px; border-radius: 50%; position: relative; top: 26px; color: black; display: flex; align-items: center; justify-content: center;">
        				${ sessionScope.cartCount }
        			</div>
        		</c:if>
        		<button onclick="location.href='${ pageContext.servletContext.contextPath }/user/cart'"><img class="store_logo" src="${ pageContext.servletContext.contextPath }/resources/images/cart_logo.png"></button>
        	</div>
        </c:if>
      </section>

      <jsp:include page="../commons/footer.jsp"/>
</body>
</html>