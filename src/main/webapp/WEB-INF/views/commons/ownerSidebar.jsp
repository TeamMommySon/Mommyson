<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/mypage-sidebar.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>
<body>
		<div class="side-all">
            <div class="side-1">
                <br>
                    <img src="${ pageContext.servletContext.contextPath }/${ sessionScope.owner.ceo.store.storeImg }" width="150px;"><br> <hr>
                    <h4><strong>${ sessionScope.owner.ceo.name } </strong>사장님</h4>
                    <br>
                    
                    <c:if test="${ sessionScope.membership != null && !empty sessionScope.membership }">
                    <h6>시작일 : ${ sessionScope.membership.startDate }</h6><br>
                    <h6>만료일 : ${ sessionScope.membership.endDate }</h6><br>
                    <h6>${ sessionScope.membership.MS_TYPE } 사용중</h6>
                    <input type="hidden" name="statusYN">
                    <br>
	                <a href="${ pageContext.servletContext.contextPath }/owner/ownerPay">
	                <button style="background-color: rgba(248, 158, 145, 1); border: none; border-radius: 5px; color: white; width: 100px; margin-bottom: 10px;" id="pay">연장하기</button>
	                </a>
	                <hr>
	               	<c:if test="${ sessionScope.loginMember.ceo.store.statusYN == 'Y' }">
	                	<button id="button3" style="margin-top: 10px; margin-bottom: 30px;">영업중</button> 
	                </c:if>
	                <c:if test="${ sessionScope.loginMember.ceo.store.statusYN == 'N' }">
	                	<button id="button3" style="margin-top: 10px; margin-bottom: 30px; background-color: #777777">영업시작</button> 
	                </c:if>
                    </c:if>
                    
                    <c:if test="${ sessionScope.membership == null && empty sessionScope.membership }">
                    <h5>이용중인 이용권이 없습니다.</h5>
                    <input type="hidden" name="statusYN">
                    <br>
	                <a href="${ pageContext.servletContext.contextPath }/owner/ownerPay">
	                <button style="background-color: rgba(248, 158, 145, 1); border: none; border-radius: 5px; color: white; width: 120px; margin-bottom: 10px;" id="pay">이용권 결제하기</button>
	                </a>
                    </c:if>
                </div>
            <script>
            $(function(){
              	$("#button3").click(function(){
              		let result = "";
                    if($("#button3").html() == "영업시작"){
                      $(this).css("background-color","#F89E91").html("영업중");
                      result = "Y";
                    } else{
                      $(this).css("background-color","#777777").html("영업시작");
                      result="N";
                    }
                    
                    $.ajax({
                    	url : '${ pageContext.servletContext.contextPath }/owner/ownerSidebar',
                    	type : 'post',
                    	data : { statusYN : result },
                    	success : function(data){
                    		console.log(data);
                    	}
                    })
               });
              	
               $('#pay').click(function(){
            	   
               })	
            });
                </script> 
                
            
            <div class="side-2" style="width: 300px; ">
              <nav id="sidebar" style="min-width: 295px; max-width: 295px;">
              <ul class="list-unstyled components">
	             <li>
                   <a href="#pageSubmenu3" data-toggle="collapse" aria-expanded="false">정보변경</a><hr>
                   <ul class="collapse list-unstyled" id="pageSubmenu3">
                       <li>
                           <a href="${ pageContext.servletContext.contextPath }/owner/modifyStore">가게정보 변경</a>
                       </li>
                       <li>
                           <a href="${ pageContext.servletContext.contextPath }/owner/modifyOwnerInfo">비밀번호 변경</a>
                       </li>
                   </ul>
                </li>
            	  <li class="active">
                            <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false">상품관리</a><hr>
                            <ul class="collapse list-unstyled" id="homeSubmenu">
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/productRegist">상품등록</a>
                                </li>
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/productManagement">판매 상품 관리</a>
                                </li>
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/todayDiscount">오늘의 할인</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false">주문관리</a><hr>
                            <ul class="collapse list-unstyled" id="pageSubmenu">
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/order">주문접수</a>
                                </li>
                                <li>
                                    <a  class="aLink" href="${ pageContext.servletContext.contextPath }/owner/order2">완료된 주문</a>
                                </li>
                            
                            </ul>
                        </li>
                        <li>
                            <a href="#pageSubmenu4" data-toggle="collapse" aria-expanded="false">쿠폰내역</a><hr>
                            <ul class="collapse list-unstyled 1" id="pageSubmenu4">
                                <li>
                            		<a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/coupon">쿠폰발행</a>
                                </li>
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/giveCouponLIst">쿠폰 발행 내역</a>
                                </li> 
                            </ul>
                        </li>
                        <li>
                            <a href="#pageSubmenu1" data-toggle="collapse" aria-expanded="false">매출내역</a><hr>
                            <ul class="collapse list-unstyled 1" id="pageSubmenu1">
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/salesDay">일별 매출</a>
                                </li>
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/salseMonth">월별 매출</a>
                                </li>
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/salesList">정산</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#pageSubmenu2" data-toggle="collapse" aria-expanded="false">고객관리</a><hr>
                            <ul class="collapse list-unstyled" id="pageSubmenu2">
                                <li>
                                    <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/review">리뷰관리</a>
                                </li> 
                            </ul>
                        </li>
                        <li>
                            <a href="${ pageContext.servletContext.contextPath }/owner/ownerQuit">탈퇴하기</a>
                        </li>
                        <hr>
                        <li>
                            <a class="aLink" href="${ pageContext.servletContext.contextPath }/owner/receiptList">이용권 구매 영수증 관리</a>
                        </li>
		          </nav>
	     		<script>
		      		$(document).ready(function(){
		              $('#sidebarCollapse').on('click', function () {
		                  $('#sidebar').toggleClass('active');
		              });
		          	});
						
	      			$('.aLink').on('click',function(e){
	      				
	      				if(${ sessionScope.membership == null && empty sessionScope.membership }){	
	      				
	      				 	alert("이용권을 결제한 뒤 사용하실 수 있습니다.");
	      				 	
	      				 	e.preventDefault();
	      				}
	      			});
	      	</script> 
     	 </div>
   	 </div>
</body>
</html>