<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
</head>
<body>
	<div style="height: 1px; background-color:#C5C5C5; position:relative; top: 160px;"></div>
    <footer class="at-container">
        <ul class="df_ul ft_list">
            <li>
                <a href="">마미손맛 소개</a>   
            </li>
            <li>
                <a href="">이용약관</a>
            </li>
            <li>
                <a href="">개인정보처리방침</a>
            </li>
            <li>
                <a href="">전자금융거래이용약관</a>
            </li>
        </ul>
        <div class="ft_img_line">
            <img src="${ pageContext.servletContext.contextPath }/resources/images/ft_img01.png" alt="소비자중심경영">
            <img src="${ pageContext.servletContext.contextPath }/resources/images/ft_img02.png" alt="정보보호 관리체계 인증">
            <img src="${ pageContext.servletContext.contextPath }/resources/images/kakaopay.png" alt="KakaoPay" class="kakaopay">
        </div>
        <div class="ft_info">
            <p>대표 : 유승제 / 주소 : 서울특별시 서초구 서초대로78길 48 송림빌딩 13층</p>
            <p>사업자번호 : 123-45-67890 / 통신판매업신고 : 제 2021-서울-503호 / 개인정보 정책 및 담당 : 김준희</p>
            <p>대표번호 : 1588-0000 / 팩스번호 : 02-123-1234 / 이메일 : mommysonmat@greedy.com</p>
            <p>ⓒ SSEULEODAMJO CORP. All Rights Reserved.</p>
        </div>
        <div class="manager_center">
            <h4><a href="${ pageContext.servletContext.contextPath }/user/ucc">고객센터</a></h4>
            <div class="callNum">
                <img src="${ pageContext.servletContext.contextPath }/resources/images/callImg.png" alt="call">
                <span>1644 - 1234</span>    
            </div>
            <p>평일 10:00~18:50</p>
            <p>점심시간 12:00~13:00</p>
            <p>(주말과 공휴일은 휴무입니다.)</p>
            <hr>
            <p><a href="${ pageContext.servletContext.contextPath }/user/ucc/MTMQnA"/>1:1 문의하기</a></p>
            <br>
        </div>
    </footer>
</body>
</html>