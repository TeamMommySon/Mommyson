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
    <title>배달 주문/결제</title>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/css/user/deliveryPay.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <style>
    .correct {
    color : green;
    }
     .incorrect {
    color : red;
    }
    </style>

</head>

<body>
   <jsp:include page="../commons/header.jsp"></jsp:include>
   <form action="${ pageContext.servletContext.contextPath }/user/deliveryPay" method="POST">
      <div class="delivery-container at-container">
          <h2 class="title">배달 예약 주문</h2>
          <div class="infoBox">
             <h3 class="title2">배송 정보</h3>
             <div>
                <span>연락처</span>
                <input type="text" id="phone" placeholder=" 연락처를 입력해주세요" style="width: 200px;">
             </div>
             <div>
                <span>우편번호</span>
                <input type="text" class="input1" name="postCode" id="zipCode" placeholder=" 검색버튼 클릭 후 주소 입력" readonly style="width: 200px;">
                <input type="button" id="searchZipCode" value="검색" class="search_btn">
             </div>
             <div>
                <span>주소</span>
                <input type="text" class="input1" name="address" id="address1" placeholder=" 주소" readonly style="width: 500px;">
             </div>
             <div>
                <span>상세주소</span>
                <input type="text" class="input1"  name="dAddress" id="address2" style="width: 500px;" required>
                <input type="checkbox" class="myCheckBtn" name="myAddress" id="myaddress" onclick="memberAddress(this);">
                <label for="myaddress"></label>
                <span>내 주소로 배달</span>
             </div>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
             <span id="address2CheckResult"></span>
          </div>
          
          <div class="infoBox2">
             <table id="table1" class="info_table" border="0">
                <colgroup>
                   <col width="20%"/>
                   <col width="20%"/>
                   <col width="20%"/>
                   <col width="20%"/>
                   <col width="20%"/>
                </colgroup>
                <thead>
                     <tr id="tr1">
                         <th>가게정보</th>
                         <th>가게별 총 제품 금액</th>
                         <th>배송비</th>
                         <th>쿠폰</th>
                         <th>예약시간</th>
                    </tr>
                 </thead>
                 <tbody>
                    <c:forEach items="${ requestScope.orderList }" var="order">
                       <tr id="tr2">
                          <td style="display: none;">
                             <input type="hidden" id="memCode" value="${ order.MEM_CODE }"/>
                             <input type="hidden" id="orderCode" value="${ order.ORDER_CODE }"/>
                          </td>
                          <td>
                             <img src="${ pageContext.servletContext.contextPath }/${ order.STORE_IMG }">
                             <p>${ order.STORE_NAME }</p>
                          </td>
                          <td>
                             <p id="price" style="display: inline;"><fmt:formatNumber value="${ order.TOTAL_PRICE }"/></p><span>원</span>
                          </td>
                          <td class="delCostWon">
                             <c:if test="${ order.DEL_COST != null }">
                                <p style="display: inline;">${ order.DEL_COST }</p>원
                             </c:if>
                             <c:if test="${ order.DEL_COST == null }">
                                <p style="display: inline;">0</p>원
                             </c:if>
                          </td>
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
                 </tbody>
               </table>
          </div>
          
          <div class="info_box3">
             <ul class="df_ul payment_list">
                <li>
                   <p>총 제품금액</p>
                   <strong id="productPrice"></strong><span class="won">원</span>
                </li>
                <li>
                   <img src="${ pageContext.servletContext.contextPath }/resources/images/pay_minus.png" alt="-">
                </li>
                <li>
                   <p>할인금액</p>
                   <strong id="discountWon">0</strong><span class="won">원</span>
                </li>
                <li>
                   <img src="${ pageContext.servletContext.contextPath }/resources/images/pay_plus.png" alt="+">
                </li>
                <li>
                   <p>총 배송비</p>
                   <strong id="delCost">0</strong><span class="won">원</span>
                </li>
                <li>
                   <img src="${ pageContext.servletContext.contextPath }/resources/images/pay_result.png" alt="=">
                </li>
                <li>
                   <p>결제 금액</p>
                   <input type="number" id="totalPrice" value="9000" disabled="disabled"><span class="won">원</span>
                </li>
             </ul>
          </div>
          <div class="btn_box">
             <input type="button" value="결제하기" id="pay" class="final_btn" style="margin-right: 15px;">
             <a id="goShoppingBasket" class="final_btn" style="background-color: #EDEDED; color: #333 !important;">취소하기</a>
          </div>
         </div>
   </form>
        

    
    
    <jsp:include page="../commons/footer.jsp"/>
   
    <script>
       function memberAddress(){
          if($("input:checkbox[name='myAddress']").is(":checked") ==  true){
             let memCode = $("#memCode").val();
              console.log(memCode);
              
              let zipCode = $("#zipCode");
              let address = $("#address1");
              let dAddress = $("#address2");
              
              $.ajax({
                 url : '${ pageContext.servletContext.contextPath }/user/memberAddress',
                 type : 'POST',
                 data : {
                    memCode : memCode
                 },
                 success : function(data){
                    console.log(data);
                    zipCode.val(data.postCode);
                    address.val(data.address);
                    dAddress.val(data.dAddress);
                 },
                 error : function(error){
                    console.log(error);
                 }
              });
          } else {
             let memCode = $("#memCode").val();
              console.log(memCode);
              
              let zipCode = $("#zipCode");
              let address = $("#address1");
              let dAddress = $("#address2");
              
              $.ajax({
                 url : '${ pageContext.servletContext.contextPath }/user/memberAddress',
                 type : 'POST',
                 data : {
                    memCode : memCode
                 },
                 success : function(data){
                    console.log(data);
                    zipCode.val("");
                    address.val("");
                    dAddress.val("");
                 },
                 error : function(error){
                    console.log(error);
                 }
              });
          }
       }
    
        function validate(){
          var name = document.getElementById("name");
          var phone = document.getElementById("phone");
          var zipCode = document.getElementById("zipCode");
          var address1 = document.getElementById("address1");
          var address2 = document.getElementById("address2");

          if(name.value == ""){
              alert("이름을 입력해주세요.")
              name.focus();
              return false;
          }

          if(!chk(/^[가-힣]{2,}$/,name,"이름은 한글로 2글자 이상을 넣으세요")){
              return false;
          }
          
          if(phone.value == ""){
                alert("전화번호를 입력해주세요.")
                phone.focus();
                return false;
            }

          if(zipCode.value == ""){
              alert("우편번호 입력해주세요.")
              zipCode.focus();
              return false;
          }
          if(address1.value == ""){
              alert("주소를 입력해주세요.");
              address1.focus();
              return false;
          }
          if(address2.value == ""){
              alert("상세주소를 입력해주세요.");
              address2.focus();
              return false;
          }
      
      }

      function chk(re, ele, msg){
         
         if(!re.test(ele.value)){
             alert(msg);
             ele.select();
             return false;
         }
         return true;
      }
      
      /* 우편번호 검색 */
		const $searchZipCode = document.getElementById("searchZipCode");
		
       $searchZipCode.onclick = function() {
       
           //다음 우편번호 검색 창을 오픈하면서 동작할 콜백 메소드를 포함한 객체를 매개변수로 전달한다.
           new daum.Postcode({
               oncomplete: function(data){
                   //팝업에서 검색결과 항목을 클릭했을 시 실행할 코드를 작성하는 부분
                   document.getElementById("zipCode").value = data.zonecode;
                   document.getElementById("address1").value = data.address;
                   document.getElementById("address2").focus();
               }
           }).open();
       }
       
	    /* 상세주소 입력 여부 확인 알럿 */
       $("#address2").blur(function(){
       	var inputAdress2 = $("#address2").val();
       	var address2CheckResult = $("#address2CheckResult");
       	
	       	if(inputAdress2 == ""){
	       		address2CheckResult.html("상세주소를 입력해주세요.");
	       		address2CheckResult.attr("class", "incorrect");
	       		return false;
	       	} else {
	      			address2CheckResult.html("");
	      		 	return true;
	       	}
       	
       });
	    
       /* 전화번호 정규식 알럿 */
       $("#phone").blur(function(){
       	var inputPhone = $("#phone").val();
       	var regex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
       	var result = regex.exec(inputPhone);
       	var phoneCheckResult = $("#phoneCheckResult");  
       		
       		if(inputPhone == ""){
       			phoneCheckResult.html("전화번호를 입력해주세요.");
       			phoneCheckResult.attr("class","incorrect");
       			return false;
       	
       		} else {
       			
       			if(result != null) {
       				phoneCheckResult.html("");
       				return true;
       			} else {
       				alert("전화번호 형식이 올바르지 않습니다. 올바른 형식으로 9~11자리 숫자를 입력해주세요.");
       				return false;
       			} 
       		}
       	
      	 });
       
      
      
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
            });
            location.href='${ pageContext.servletContext.contextPath }/user/payCancle?orderCodes=' + orderCodes;
         });
         
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
                let total = parseInt($('#productPrice').text()) - discountWon + parseInt($('#delCost').text());
                $('#totalPrice').val(total);
            }
         });

         // 결제 로직
         $('#pay').on('click',function() {
            if($('#phone').val() == '' || $('#time').val() == '' || $('#zipCode').val() == '' || $('#address1').val() == '' || $('#address2').val() == '') {
               alert('주문 정보를 모두 기입해주세요!');
            } else {
               let name = $('#name').val();
                let phone = $('#phone').val();
                let zipCode = $('#zipCode').val();
                let address = $('#address1').val();
                let detailAddress = $('#address2').val();
                let totalPrice = [];
                $('#price').each(function(index,val) {
                   totalPrice.push($('#price').text().replace(',',''));
                });
                let payPrice = $('#totalPrice').val();
                let takeTime = $('#time').val();
                let orderCodes = [];
                $('#orderCode').each(function(index, val) {
                   orderCodes.push($(this).val());
                });
                let couponCodes = [];
                $('select option:selected').each(function(index) {
                   couponCodes.push($(this).attr('id'));
                });
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
                     buyer_addr : address,
                     buyer_postcode : zipCode,
                     m_redirect_url : ''
                 },  
                 function(rsp) {
                   if ( !rsp.success ) {
                    //결제 시작 페이지로 리디렉션되기 전에 오류가 난 경우
                     var msg = '오류로 인하여 결제가 시작되지 못하였습니다.';
                     msg += '에러내용 : ' + rsp.error_msg;
                     alert(msg);
                   } else {
                      alert('결제 완료!');
                      location.href='${ pageContext.servletContext.contextPath }/user/payComplete2?orderCodes=' + orderCodes + '&zipCode=' + zipCode + '&address=' + address + '&detailAddress=' + detailAddress + '&totalPrice=' + totalPrice + '&phone=' + phone + '&time=' + takeTime + '&couponCodes=' + couponCodes;
                   }
                });
            }
         });
    </script>


</body>
</html>