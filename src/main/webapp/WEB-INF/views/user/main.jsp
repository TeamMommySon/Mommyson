<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>마미손맛</title>
    <script src="https:/cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/main.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/slick.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/slick-theme.css">
    <script src="${ pageContext.servletContext.contextPath }/resources/js/slick.min.js"></script>
</head>
<body>
<script>
	if(${ requestScope.message != null && requestScope.message != '' }){
		alert('${ requestScope.message }');
	}
</script>
    
    <jsp:include page="../commons/header.jsp"></jsp:include>
    
    <script>
    	$(function() {
    		<c:forEach items="${ sessionScope.locationList }" var="locationList">
			$('#location').append('<option value = ' + '<c:out value = "${ locationList.LOCATION_CODE }"/>' + '>'
						 + '<c:out value = "${ locationList.LOCATION_NAME }"/></option>')
			</c:forEach>
    	})
    	
    	
    </script>
	
    <section>
        <div style="width: 100%; height: 400px; margin-bottom: 100px; padding: 0 !important;" class="at-container">
            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                  <c:forEach items="${ requestScope.banerList }" var="baner">
	                  <c:if test="${ baner.bnOrder == 1 }">
		                  <div class="carousel-item active">
		                    <img src="${ pageContext.servletContext.contextPath }/${ baner.bnImg }" class="d-block w-100" alt="...">
		                  </div>
	                  </c:if>
	                  <c:if test="${ baner.bnOrder != 1 }">
		                  <div class="carousel-item">
		                    <img src="${ pageContext.servletContext.contextPath }/${ baner.bnImg }" class="d-block w-100" alt="...">
		                  </div>
	                  </c:if>
                  </c:forEach>
                </div>
               <button class="carousel-control-prev" type="button" data-target="#carouselExampleControls" data-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-target="#carouselExampleControls" data-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
                </button>
              </div>
        </div>
        
        <div class="container">

            <c:if test="${ sessionScope.loginMember == null }">
            	<div style="margin : 50px;">
	                <span style="font-size: 14pt;">동네 설정&nbsp;</span>
	                <select name="location" id="location">
	                </select>
	            </div>
            </c:if>
            <!-- 슬라이더 세팅 -->
            <script>
                $(document).ready(function(){
                $('.menu_bar').slick({
                    infinite : true,
                    slidesToScroll : 4,
                    slidesToShow : 4,
                    prevArrow : "<button type='button' class='pinkbtn' style='position: absolute; left: 0; top: 30%; z-index: 1;'>←</button>",
                    nextArrow : "<button type='button' class='pinkbtn' style='position: absolute; right: 0; top: 30%; z-index: 1;'>→</button>"
                });
                });
            </script>

            <!-- 오늘의 추천 -->
            <div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                    <h3>오늘의 추천</h3>
                    <a href="${ pageContext.servletContext.contextPath }/user/sale">더보기 ></a>
                </div>
                <div class="col-sm-12">
                    <div class="menu_bar" align="center">
                    	<!-- 오늘 날짜에 따른 무작위 추천 -->
                        <c:set var="recommendCount" value="0"/>
                        <c:set var="now" value="<%=new java.util.Date()%>"/>
						<c:set var="date"><fmt:formatDate value="${now}" pattern="dd"/></c:set>
						<c:set var="random" value="${fn:substring(date,1,1)}"/> 
                        <c:forEach items="${ requestScope.productList }" var="product" varStatus="status">
	                        <c:if test="${ recommendCount < 12 && ((product.memCode % (random + 1)) == 0 || (product.sdCode % (random + 1)) == 1)}">
		                        <div class="recommend-img">
		                            <img src="${ pageContext.servletContext.contextPath }/${ product.sdImg }">
		                            <div class="menu_div">
		                                <a href="${ pageContext.servletContext.contextPath }/user/sidedish_detail?sdCode=${ product.sdCode }&memCode=${ product.memCode }" class="menu_name">${ product.sdName }(${ product.volume }g)</a>
		                                <pre> <strong><fmt:formatNumber value="${ product.price - (product.price * product.discountRate / 100) }" />원</strong>  <label style="text-decoration: line-through; color: lightgray;"><fmt:formatNumber value="${ product.price }" />원</label></pre>
		                                <strong style="font-size: 10pt; display: flex; align-items: center;"><svg style="margin-right: 5px;" xmlns="http:/www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shop-window" viewBox="0 0 16 16">
		                                    <path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h12V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zm2 .5a.5.5 0 0 1 .5.5V13h8V9.5a.5.5 0 0 1 1 0V13a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9.5a.5.5 0 0 1 .5-.5z"/>
		                                </svg>${ product.storeName }</strong>
		                            </div>
		                        </div>
		                        <c:set var="recommendCount" value="${ recommendCount + 1 }"/>
	                        </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
			
            <!-- 우리동네 인기 맛집 -->
            <div style="margin-bottom: 60px;">
                <div style="display: flex; justify-content: space-between; margin: 90px 0px 60px 0px;">
                    <h3>우리동네 인기 맛집</h3>
                    <a href="${ pageContext.servletContext.contextPath }/user/famousStore?type=famous">더보기 ></a>
                </div>
                <div class="col-sm-12">
                    <div class="menu_bar" align="center">
                    	<c:set var="famousCount" value="0"/>
                        <c:forEach items="${ requestScope.storeList }" var="store">
	                        <c:if test="${ store.rvCount > 10 && famousCount < 12 }">
		                        <div class="recommend-img">
		                            <img class="store_logo" src="${ pageContext.servletContext.contextPath }/${ store.storeImg }">
		                            <div class="store_name">
		                            <a href="${ pageContext.servletContext.contextPath }/user/storepage?memCode=${ store.memCode }" class="menu_name">${ store.storeName }</a>
		                            <div class="menu_div2">
		                                <pre style="font-size: 10pt; display: flex; align-items: center;"><svg style="color: #EFCA45;" xmlns="http:/www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
		                                    <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
		                                </svg> <strong style="margin-right: 5px;">${ store.grade }</strong><span style="color: #616161;">최근리뷰 ${ store.rvCount }</span></pre>
		                            </div>
		                            </div>
		                        </div>
		                        <c:set var="famousCount" value="${ famousCount + 1 }"/>
	                        </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 핫 키워드 -->
        <div class="at-container">
            <div id="hot" style="padding: 0 200px;">
                <div class="keywords"><img style="width: 22px; height: 32px;" src="${ pageContext.servletContext.contextPath }/resources/images/fire.png">&nbsp;&nbsp;<h4>핫 키워드</h4></div>
                <div class="tags">
                	<c:forEach items="${ requestScope.hotKeywordList }" var="hot">
	                    <div class="hot_tag"><a href="#" style="text-align: center;"><strong>#${ hot.tagName }</strong></a></div>                  
                	</c:forEach>
                	<script>
                		$('.hot_tag').on('click',function() {
                			let searchValue = $(this).text();
                			$('#search').val(searchValue);
                			$("form").submit();
                		})
                	</script>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- 오늘만 할인 -->
            <div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                    <h3>오늘만 할인</h3>
                    <a href="${ pageContext.servletContext.contextPath }/user/sale">더보기 ></a>
                </div>
                <div class="col-sm-12">
                    <div class="menu_bar" align="center">
                    	<c:set var="saleCount" value="0"/>
		                <c:forEach items="${ requestScope.productList }" var="product">
			                <c:if test="${ product.discountRate > 0 && saleCount < 12}">
				                <div class="recommend-img">
		                            <img src="${ pageContext.servletContext.contextPath }//${ product.sdImg }">
		                            <div class="menu_div">
		                                <a href="${ pageContext.servletContext.contextPath }/user/sidedish_detail?sdCode=${ product.sdCode }&memCode=${ product.memCode }" class="menu_name">${ product.sdName }(${ product.volume }g)</a>
		                                <pre><strong><fmt:formatNumber value="${ product.price - (product.price * product.discountRate / 100) }" />원</strong>  <label style="text-decoration: line-through; color: lightgray;"><fmt:formatNumber value="${ product.price }" />원</label></pre>
		                                <strong style="font-size: 10pt; display: flex; align-items: center;"><svg style="margin-right: 5px;" xmlns="http:/www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shop-window" viewBox="0 0 16 16">
		                                    <path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h12V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zm2 .5a.5.5 0 0 1 .5.5V13h8V9.5a.5.5 0 0 1 1 0V13a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9.5a.5.5 0 0 1 .5-.5z"/>
		                                </svg>${ product.storeName }</strong>
		                            </div>
		                        </div>
		                        <c:set var="count" value="${ saleCount + 1 }"/>
			                </c:if>
		                </c:forEach>
                    </div>
                </div>
            </div>

            <!-- 신규 반찬 가게 -->
            <div style="margin-bottom: 60px;">
                <div style="display: flex; justify-content: space-between; margin: 90px 0px 60px 0px;">
                    <h3>신규 반찬 가게</h3>
                    <a href="#">더보기 ></a>
                </div>
                <div class="col-sm-12">
                    <div class="menu_bar" align="center">
                    	<c:forEach items="${ requestScope.storeList }" var="store" end="11">
	                        <div class="recommend-img">
	                            <img class="store_logo" src="${ pageContext.servletContext.contextPath }/${ store.storeImg }">
	                            <a href="${ pageContext.servletContext.contextPath }/user/storepage?memCode=${ store.memCode }" class="menu_name"><h6>${ store.storeName }</h6></a>
	                        </div>
                    	</c:forEach>
                    </div>
                </div>
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