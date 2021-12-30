<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/owners.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/store_page.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>가게 리스트</title>
    <style>
    	.col-3 {
    		display: flex;
    		flex-direction: column;
    	}
    	
    	.container-xl {
    		max-width: 1300px !important;
    	}
    	
    	.row {
   		    padding-left: 70px;
    	}
    	
    	.store_name {
   		    margin-bottom: 20px;
    	}
    </style>
</head>
<body>
    
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    
    <jsp:include page="../commons/header.jsp"/>

    <section class="at-container">
    	  <div class="store-all" style="text-align: center;">
        <br><br>
        <h1 style="margin-top: 80px;">${ requestScope.type }</h1>
        <br><br><br><br>
        <div class="container-xl" style="margin-top: 50px;">
            <div class="row">
                <c:forEach items="${ requestScope.storeList }" var="store">
                <div class="col-3">
                    <img class="logo" src="${ pageContext.servletContext.contextPath}/${ store.storeImg }">
                    <div class="store_name" style="text-align: center; width: 200px; font-size: large;"><br>
		                <a href="${ pageContext.servletContext.contextPath }/user/storepage?memCode=${ store.memCode }" class="menu_name"><c:out value="${ store.storeName }"/></a>
		                <div class="menu_div2">
		                    <pre style="font-size: 13pt; display: flex; align-items: center;"><svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
		                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
		                    </svg> <strong style="margin-right: 10px;"><c:out value="${ store.grade }"/></strong><span style="color: #616161;">최근리뷰 <c:out value="${ store.rvCount }"/></span></pre>
		                </div>
	                </div>
                </div>
                </c:forEach>
	       </div>
	       <jsp:include page="../commons/pagingWithoutSearch.jsp"/>
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