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
				
				<br><br><br>
				<div style="margin-left: 600px;" id="before">
					<h3 style="font-weight: 900; text-align: left;">영수증 상세 페이지</h3>
					<br>
					<div id="Layout">
						<br>
						<div id="inner" class="align">
							<div style="width: 80%; margin: 0 auto;">
							<br>
							<h4 style="text-align: left;"><strong>마미손</strong></h4>
							<h1 style="text-align: left;">${ membership.MS_PRICE }원</h1>
							<br>
							<h5 style="text-align: right;"><img src="../resources/images/pay.png" width="70px" height="29px" style="position: relative; bottom: 2px;" > 카카오페이</h5>
							<hr style="border-top: 2px solid #000000">
							<table style="width: 80%; margin: 0 auto;">
							
							<c:if test="${ membership.MS_PRICE eq '199,000'}">
								<tr>
									<th>공급가액</th>
									<td>180,909원</td>
								</tr>
								<tr>
									<th>부가세</th>
									<td>18,091</td>
								</tr>
							</c:if>	
							
							<c:if test="${ membership.MS_PRICE eq '699,000'}">
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
									<td>${ membership.MS_PRICE }</td>
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
									<td>${ membership.PAY_DATE }</td>
								</tr>
								
							</table>
							
							<hr>
							<table style="width: 80%;  margin: 0 auto;">
								<tr>
									<th>상호명</th>
									<td>${ membership.STORE_NAME }</td>
								</tr>
								<tr>
									<th>사업자 번호</th>
									<td>${ membership.STORE_NO }</td>
								</tr>
								<tr>
									<th>사업자 주소</th>
									<td>${ membership.ADDRESS }${ membership.D_ADDRESS }</td>
								</tr>
								<tr>
									<th style="width: 120px;">사업자 전화번호</th>
									<td>${ membership.PHONE }</td>
								</tr>
							</table>
						</div>
						</div>
					</div>
							<br>
				</div>		
				</div>
				<button id="print" class="couponBtn" style="margin-top : 100px;" onclick="goPrint('영수증 프린트')">프린트하기</button>
			</div>
		</div>
	</div>

	<!-- footer -->
	<jsp:include page="../commons/footer.jsp" />

<script>
function goPrint(title){
    let sw=screen.width;
    let sh=screen.height;
    let w=800;//팝업창 가로길이
    let h=600;//세로길이
    let xpos=(sw-w)/2; 
    let ypos=(sh-h)/2; 

    let pHeader="<html><head><link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css' integrity='sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn' 'crossorigin=anonymous'><link rel='stylesheet' href='${ pageContext.servletContext.contextPath }/resources/css/coupon.css'> <title>" + title + "</title></head><body>";
    let pgetContent=document.getElementById("Layout").innerHTML + "<br>";
    //innerHTML을 이용하여 Div로 묶어준 부분을 가져오
    let pFooter="</body></html>";
    pContent=pHeader + pgetContent + pFooter; 
     
    pWin=window.open("","print","width=" + w +",height="+ h +",top=" + ypos + ",left="+ xpos +",status=yes,scrollbars=yes"); //동적인 새창을 띄웁니다.
    pWin.document.open(); //팝업창 오픈
    pWin.document.write(pContent); 
    pWin.document.close(); //클로즈
    pWin.print(); //윈도우 인쇄 창 띄우고
    pWin.close(); //인쇄가 되던가 취소가 되면 팝업창 닫
   }
</script>
</body>
</html>