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
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/store_page.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="../commons/header.jsp"/>

    <section>
        <div class="at-container" style="position: relative; margin-top: 200px; display: flex; flex-direction: column; align-items: center;">
            <div class="store_logo" style="background: white;">
                <img src="${ pageContext.servletContext.contextPath }/${ requestScope.store.STORE_IMG }">
            </div>
            <div class="bottom" style="border-top: 1px solid black; margin-top: 100px;">
                <form action="${ pageContext.servletContext.contextPath }/user/insertCart" method="post" onsubmit="return validate();">  
	                <div class="menu_box" style="margin-top: 100px;">
	                    <!-- 메뉴 이름 -->
	                    <input type="hidden" name="sdCode" value="${ requestScope.product.sdCode }">
	                    <h1 style="margin-bottom: 70px; font-weight: bold;">${ requestScope.product.sdName }</h1>
	                    <!-- 메뉴 사진 -->
	                    <div class="menu_pic">
	                        <img src="${ pageContext.servletContext.contextPath }/${ requestScope.product.sdImg }">
	                    </div>
	                    <!-- tag 들 -->
	                    <div class="tags">
	                    	<c:forEach items="${ requestScope.product.tagList }" var="tag">
	                    		<span><a href="#" style="text-align: center;"><strong>#${ tag }</strong></a></span>
	                    	</c:forEach>
	                    </div>
	
	                    <!-- 메뉴 설명 -->
	                    <p style="margin: 70px 0px 70px 0px; font-size: 20pt;">
	                        ${ requestScope.product.detail }
	                    </p>
	
	                    <!-- 반찬 정보 -->
	                    <div class="side_info">
	                        <p>제조일자</p>
	                        <p>${ requestScope.product.mDate }</p>
	                    </div>
	                    <div class="side_info">
	                        <p>유효기한</p>
	                        <p>${ requestScope.product.eDate }</p>
	                    </div>
	                    <div class="side_info">
	                        <p>용량</p>
	                        <p>${ requestScope.product.volume }g</p>
	                    </div>
	                    <div class="side_info">
	                        <p>식품 유형</p>
	                        <p>${ requestScope.product.category }</p>
	                    </div>
	                    <div class="side_info">
	                        <p>재료</p>
	                        <p>${ requestScope.product.ingredient }</p>
	                    </div>
	                    <div class="side_info">
	                        <p>보관법</p>
	                        <p>${ requestScope.product.storageMethod }</p>
	                    </div>
	                    <div class="side_info">
	                        <p>가격</p>
	                        <p><fmt:formatNumber value="${ requestScope.product.price - (requestScope.product.price * requestScope.product.discountRate / 100)  }"/> 원</p>
	                        <input type="hidden" value="${ requestScope.product.price - (requestScope.product.price * requestScope.product.discountRate / 100) }" name="price">
	                    </div>
	                    <div class="side_info">
	                        <p>할인</p>
	                        <c:if test="${ requestScope.product.discountRate == 0 }">
	                        	<p>(-)</p>
	                        </c:if>
	                        <c:if test="${ requestScope.product.discountRate > 0 }">
	                        	<p><fmt:formatNumber value="${ requestScope.product.discountRate }"/>%</p>
	                        </c:if>
	                    </div>
	                    <div class="side_info">
	                        <p>수량</p>
	                        <div style="display: flex;">
	                            <button type="button" class="numbtn" onclick="stepdown();">-</button>
	                            <input type="text" id="num" name="amount" value="0" readonly style="width: 30px; height: 30px; border-radius: 0; text-align: center;">
	                            <button type="button" class="numbtn" onclick="stepup();">+</button>
	                        </div>
	                                      
	                        <%-- <select name="amount">
	                        	<c:forEach begin="1" end="50" var="i">
	                        		<option value="${ i }" >${ i } 개</option> 
	                        	</c:forEach> 
	                        </select> --%>
	                        
	                        <script>
	                            function stepup() {
	                                $('#num').val(parseInt($('#num').val()) + 1);
	                            }
	
	                            function stepdown() {
	                                if($('#num').val() > 0) {
	                                    $('#num').val(parseInt($('#num').val()) - 1);
	                                }
	                            }
	                            
	                            function validate() {
	                            	let num = $('#num').val();
	                            	if(num == 0) {
	                            		alert('한 개 이상 담아주세요!');
	                            		return false;
	                            	}
	                            	
	                            	$('input:hidden[name=price]').val(parseInt($('input:hidden[name=price]').val().replace(',','')));
	                            	
	                            	return true;
	                            }
	                        </script>
	                    </div>
	                    <div style="display: flex; justify-content: space-between; width: 25%; margin: 50px 0 300px 0;">
	                        <button class="pink_btn" onclick="location.href='${ pageContext.servletContext.contextPath }/storepage?memCode=${ requestScope.store.MEM_CODE }'">취소</button>
	                        <button class="pink_btn" type="submit">장바구니 추가</button>
	                    </div>
	                </div>
                </form>
            </div>
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