<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/store_page.css">
</head>
<body>
    <jsp:include page="../commons/header.jsp"/>

    <section>
        <h1 align="center" style="margin-top: 60px;">가게 정보</h1>
        <div class="at-container" style="position: relative; margin-top: 130px; display: flex; flex-direction: column; align-items: center;">
            <div class="store_logo" style="background: white;">
                <img src="${ pageContext.servletContext.contextPath }/${ requestScope.store.STORE_IMG }">
            </div>
            <div class="bottom" style="border-top: 1px solid black; margin-top: 100px;">
                <div class="menu_box" style="margin-top: 100px;">
                    <div class="info_div" style="margin-top: 60px;">
                        <div style="font-size: 20pt; font-weight: bold;">상호</div>
                        <div class="info_con" style="background: #EFEFEF; width: 500px; padding: 10px 40px; font-weight: bold;">${ requestScope.store.STORE_NAME }</div>
                    </div>
                    <div class="info_div">
                        <div style="font-size: 20pt; font-weight: bold;">전화번호</div>
                        <div class="info_con" style="background: #EFEFEF; width: 500px; padding: 10px 40px; font-weight: bold;">${ requestScope.store.PHONE }</div>
                    </div>
                    <div class="info_div">
                        <div style="font-size: 20pt; font-weight: bold;">주소</div>
                        <div class="info_con" style="background: #EFEFEF; width: 500px; padding: 10px 40px; font-weight: bold;">${ requestScope.store.ADDRESS }</div>
                    </div>
                    <div class="info_div">
                        <div style="font-size: 20pt; font-weight: bold;">영업시간</div>
                        <div class="info_con" style="background: #EFEFEF; width: 500px; padding: 10px 40px; font-weight: bold;">${ requestScope.store.WORK_TIME }</div>
                    </div>
                    <div class="info_div">
                        <div style="font-size: 20pt; font-weight: bold;">상세주소</div>
                        <div class="info_con" style="background: #EFEFEF; width: 500px; padding: 10px 40px; font-weight: bold;">${ requestScope.store.D_ADDRESS }</div>
                    </div>
                    <div class="info_div">
                        <div style="font-size: 20pt; font-weight: bold;">가게 소개</div>
                        <div class="info_con" style="background: #EFEFEF; width: 500px; padding: 10px 40px; font-weight: bold;">
                            <p>
                                ${ requestScope.store.STORE_INFO }
                            </p>
                        </div>
                    </div>
                    <div class="info_div" style="margin-bottom: 100px;">
                        <div style="font-size: 20pt; font-weight: bold;">사업자<br>등록번호</div>
                        <div class="info_con" style="background: #EFEFEF; width: 500px; padding: 10px 40px; font-weight: bold;">${ requestScope.store.STORE_NO }</div>
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