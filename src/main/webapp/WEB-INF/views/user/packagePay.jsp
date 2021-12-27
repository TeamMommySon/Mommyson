<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>방문포장 주문 결제화면</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/packagePay.css">
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
     <jsp:include page="../commons/header.jsp"></jsp:include>
    <br>
    
      <div id="information">
        <h3>주문자정보</h3>
        <br><br>
        <input type="text" class="input1" id="phone" placeholder=" 전화번호를 입력해주세요">
      </div>
      <br>


        <table id="table1">
          <tr id="tr1">
            <th>가게정보</th>
            <th>가게별 총 제품 금액</th>
            <th>쿠폰</th>
            <th>예약시간</th>
          </tr>
          <c:forEach items="${ requestScope.orderList }" var="order">
             <tr id="tr2">
               <td><input type="hidden" id="orderCode" value="${ order.ORDER_CODE }"><img class=restaurantLogo001 src="${ pageContext.servletContext.contextPath }/${ order.STORE_IMG }"><br><c:out value="${ order.STORE_NAME }"/></td>
               <td><div style="display: inline-flex;"><p id="price"><fmt:formatNumber value="${ order.TOTAL_PRICE }"/></p> 원</div></td>
               <td>
                 <select id="coupons">
                   <option value="0">쿠폰을선택하세요</option>
                   <c:forEach items="${ requestScope.couponList }" var="c">
                   <c:if test="${ order.STORE_CODE == c.storeCode }">
                      <option id="${ c.cpNum }" value="${ c.disWon }"><c:out value="${ c.cpName }"/></option>
                   </c:if>
                   </c:forEach>
                 </select>
               </td>
               <td><input type="time" name="time" id="time"></td>
             </tr>
          </c:forEach>
      </table>
      <br>  
      <div id="div2">
        <table id="table2">
          <tr id="tr3">
          <th>제품금액</th>
          <th></th>
          <th>할인금액</th>
          <th></th>
          <th>결제 금액</th>
          </tr>
          <tr>
            <td id="tr4"><div style="display: inline-flex;"><p id="productPrice"></p> 원</div></td>
            <td> - </td>
            <td><div style="display: inline-flex;"><p id="discountWon">0</p>원</div></td>
            <td> = </td>
            <td id="paymentAmount"><input type="number" id="totalPrice" value="9000" disabled="disabled" style="background: white; width: 85px; border: none;">원</td>
          </tr>
        </table>  
      </div>
      <br><br>
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" id="pay" ">결제하기</button>
      <button type="button" id="goShoppingBasket">취소하기</button>
      
      <jsp:include page="../commons/footer.jsp"/>
      <script>
         // 금액 뿌려주기
         $(function() {
            let prices = 0;
            $('#price').each(function(index,val) {
               prices += parseInt($('#price').text().replace(',',''));
            })
            
            $('#productPrice').text(prices);
            
            $('#totalPrice').val(prices);
         })
         
         // 취소 시 order_tbl 데이터 삭제
         $('#goShoppingBasket').on('click',function() {
            let orderCodes = [];
            $('#orderCode').each(function(index, val) {
               orderCodes.push($(this).val());
            })
            location.href='${ pageContext.servletContext.contextPath }/user/payCancle?orderCodes=' + orderCodes;
         })
         
         // 쿠폰 적용 스크립트
         $('select').on('change',function() {
            let coupon = parseInt($(this).val());
            let price = parseInt($('#price').text().replace(',',''));
            if(price <= coupon) {
               alert('할인금액은 제품금액보다 클 수 없습니다.');
            } else {
               let discountWon = 0;
                $('select option:selected').each(function(index,val) {
                   discountWon += parseInt($(this).val());
                })
                $('#discountWon').text(discountWon);
                let total = parseInt($('#productPrice').text()) - discountWon;
                $('#totalPrice').val(total);
            }
         })
         
         // 결제 로직
         $('#pay').on('click',function() {
            if($('#phone').val() == '' || $('#time').val() == '') {
               alert('주문 정보를 모두 기입해주세요!');
            } else {
               let name = $('#name').val();
                let phone = $('#phone').val();
                let totalPrice = [];
                $('#price').each(function(index,val) {
                   totalPrice.push($('#price').text().replace(',',''));
                })
                let payPrice = $('#totalPrice').val();
                let takeTime = $('#time').val();
                let orderCodes = [];
                $('#orderCode').each(function(index, val) {
                   orderCodes.push($(this).val());
                })
                let couponCodes = [];
                $('select option:selected').each(function(index) {
                   couponCodes.push($(this).attr('id'));
                })
                var IMP = window.IMP; 
                 IMP.init('imp43692691'); 
                 IMP.request_pay({
                    pg : 'kakaopay',
                     pay_method : 'card', //생략 가능
                     merchant_uid: "${ requestScope.orderCodes[0] }", // 상점에서 관리하는 주문 번호 db에서 가져와야함
                     name : '포장예약 결제',
                     amount : payPrice,
                     buyer_email : 'iamport@siot.do',
                     buyer_name : name,
                     buyer_tel : phone,
                     buyer_addr : '서울특별시 강남구 삼성동',
                     buyer_postcode : '123-456',
                     m_redirect_url : ''
                 },  function(rsp) {
                   if ( !rsp.success ) {
                    //결제 시작 페이지로 리디렉션되기 전에 오류가 난 경우
                     var msg = '오류로 인하여 결제가 시작되지 못하였습니다.';
                     msg += '에러내용 : ' + rsp.error_msg;

                     alert(msg);
                   } else {
                      alert('결제 완료!');
                      location.href='${ pageContext.servletContext.contextPath }/user/payComplete?orderCodes=' + orderCodes + '&totalPrice=' + totalPrice + '&phone=' + phone + '&time=' + takeTime + '&couponCodes=' + couponCodes;
                   }
                });
            }
         });
         
         
      </script>
    <br><br><br><br>
    
    <script>
    function validate(){
      var phone = document.getElementById("phone");

      
      if(phone.value == ""){
          alert("전화번호를 입력해주세요.")
          phone.focus();
          return false;
      }

      var reg = /^[0-9]+/g;
      if(!reg.test(phone.value)) {
          alert("전화번호는 숫자만 입력할 수 있습니다.")
          phone.focus();
          return false;
      }

    function chk(re, ele, msg){
      if(!re.test(ele.value)){
              alert(msg);
              ele.select();
              return false;
          }
          return true;
      }

    }
</script>


</body>
</html>