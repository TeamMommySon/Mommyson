<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/coupon.css">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/owners.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>     
<title>이용권 구매 영수증 관리</title>
</head>
<body>
	<!-- header -->
	<jsp:include page="../commons/header.jsp"/>
	
	<br><br><br>
    <div class="page-text" style="width: 1550px; margin: 0 auto;">
        <h2 style="margin-left: 100px; font-weight: 900;">이용권 구매 영수증 관리</h2>
        <hr>
    </div>
	
	<div class="body-all">
      <div class="body-inside">
      
     <!-- sidebar  -->
      <jsp:include page="../commons/ownerSidebar.jsp"/>
      <br><br><br>
      <div style="text-align: center; float: right; margin-bottom: 150px;">
        <div>
        <table class="table table" style="width: 1050px; clear: right;">
            <thead style="background-color: #EDEDED;">
              <tr>
                <th scope="col">번호</th>
                <th scope="col">상호명</th>
                <th scope="col">상품명</th>
                <th scope="col">가격</th>
                <th scope="col">결제일자</th>
                <th scope="col">상세보기</th>
              </tr>
            </thead>
            <tbody>
            <c:if test="${ requestScope.info ne null and !empty requestScope.info}">
              <c:forEach var="list" items="${ requestScope.info }">
              <c:set var="i" value="${ i + 1 }"/>
              <c:set var="j" value="${ (requestScope.pagination.pageNo / 2) * 10 }"/>
              <fmt:parseNumber var="page" integerOnly="true" value="${ j }"/>
              <tr>
                <c:if test="${ requestScope.pagination.pageNo > 1 }">
                <th scope="row">${ i + page }</th>
                </c:if>
                <c:if test="${ requestScope.pagination.pageNo <= 1 }">
                <th scope="row">${ i }</th>
                </c:if> 
                <td>${ list.STORE_NAME }</td>
                <td>${ list.MS_TYPE }</td>
                <td>${ list.MS_PRICE }</td>
                <td>${ list.PAY_DATE }</td>
                <td><a href="${ pageContext.servletContext.contextPath }/owner/receipt?payDate=<fmt:formatDate value="${ list.PAY_DATE }" pattern="yyyy-MM-dd"/>">상세보기</a></td>
              </tr>
              </c:forEach>
             </c:if>

			<c:if test="${ empty requestScope.info }">
				<tr>
					<td colspan="6" style="font-weight: 700; font-size: 20px; padding-top : 70px;">결제한 이용권이 없습니다.</td>
				</tr>
			</c:if>             
            </tbody>
          </table>
        </div>
        </div>
        <jsp:include page="../commons/pagingWithoutSearch.jsp"/>
      </div>  
    </div>
	
	<!-- footer -->
	 <jsp:include page="../commons/footer.jsp"/>
	<script>
		$('.pagination').css("margin-left","680px");
	</script>
</body>
</html>