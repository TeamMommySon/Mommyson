<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
	integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="${ pageContext.servletContext.contextPath }/resources/css/coupon.css">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF"
	crossorigin="anonymous"></script>
<title>상세 영수증</title>
</head>
<body>
	<!-- header -->
	<jsp:include page="../commons/header.jsp" />

	<br>
	<br>
	<br>
	<div class="page-text" style="width: 1550px; margin: 0 auto;">
		<h3 style="margin-left: 100px; font-weight: 900;">상세 영수증</h3>
		<hr>
	</div>

	<div class="body-all">
		<div class="body-inside">

			<!-- sidebar  -->
			<jsp:include page="../commons/ownerSidebar.jsp" />

			<div style="text-align: center;" >
				<br>
				<br>
				<div style="margin-left: 600px;" id="before">
					<h3 style="font-weight: 900; text-align: left;">상세영수증</h3>
					<br>
					<div id="Layout" style="width: 700px; background-color: #ededed">
						<br>
						<div style="width: 600px;  background-color: white; margin: 0 auto;" class="align">
							<div style="width: 80%; margin: 0 auto;">
							<br>
							<h4 style="text-align: left;"><strong>마미손</strong></h4>
							<h1 style="text-align: left;">${ payInfo.MS_PRICE }원</h1>
							<br>
							<h5 style="text-align: right;"><img src="../resources/images/pay.png" width="70px" height="29px" style="position: relative; bottom: 2px;" > 카카오페이</h5>
							<hr style="border-top: 2px solid #000000">
							<table style="width: 80%; margin: 0 auto;">
							
							<c:if test="${ payInfo.MS_PRICE eq '199,000'}">
								<tr>
									<th>공급가액</th>
									<td>180,909원</td>
								</tr>
								<tr>
									<th>부가세</th>
									<td>18,091</td>
								</tr>
							</c:if>	
							
							<c:if test="${ payInfo.MS_PRICE eq '699,000'}">
								<tr>
									<th>공급가액</th>
									<td>635,455원</td>
								</tr>
								<tr>
									<th>부가세</th>
									<td>63,545원</td>
								</tr>
							</c:if>	
							
							</table>
							<hr>
							<table style="width: 80%; margin: 0 auto; ">
								<tr>
									<th>총 결제 금액</th>
									<td>${ payInfo.MS_PRICE }</td>
								</tr>
							</table>
						</div>
						
						<div style="width: 600px; background-color: white; margin: 0 auto; height: 500px;" class="align">
							<br>
							<div style="width: 80%; margin: 0 auto;">
							<table style= "width: 80%;  margin: 0 auto; " >
								<tr>
									<th>거래구분</th>
									<td>일시불</td>
								</tr>
								<tr>
									<th>거래 유형</th>
									<td>카카오페이</td>
								</tr>
								<tr>
									<th>거래 일시</th>
									<td>${ payInfo.PAY_DATE }</td>
								</tr>
								
							</table>
							
							<hr>
							<table style="width: 80%;  margin: 0 auto;">
								<tr>
									<th>상호명</th>
									<td>${ payInfo.STORE_NAME }</td>
								</tr>
								<tr>
									<th>사업자 번호</th>
									<td>${ payInfo.STORE_NO }</td>
								</tr>
								<tr>
									<th>사업자 주소</th>
									<td>${ payInfo.ADDRESS }${ payInfo.D_ADDRESS }</td>
								</tr>
								<tr>
									<th style="width: 120px;">사업자 전화번호</th>
									<td>${ payInfo.PHONE }</td>
								</tr>
							</table>
						</div>
						</div>
					</div>
							<br>
				</div>		

				</div>
			</div>
			
		</div>
	</div>



	<!-- footer -->
	<jsp:include page="../commons/footer.jsp" />

</body>
</html>