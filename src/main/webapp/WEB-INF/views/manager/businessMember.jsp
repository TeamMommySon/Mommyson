<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>사업자회원조회</title>
</head>
<body>
    <header class="manager_header at-container">
        <img src="${ pageContext.servletContext.contextPath }/resources/images/managerLogo.png" alt="마미손맛 MANAGEMENT">
        <a href="../main.html" class="home_btn">
            <img src="${ pageContext.servletContext.contextPath }/resources/images/mainHome.png" alt="메인화면으로">
            <p>메인화면으로</p>
        </a>
    </header>
    <div class="head_line"></div>
    <div class="at-container total_container">
        
        <jsp:include page="../commons/managerSidebar.jsp"></jsp:include>
        
        <div class="board_container">
            <h2>회원관리</h2>
            <form action="${ pageContext.servletContext.contextPath }/manager/deleteCeoMember" method="POST">
	            <div class="top_box">
	                <p>사업자 회원 조회</p>
	                <input type="submit" value="회원삭제">
	            </div>
	
	            <table class="table board_table">
	                <colgroup>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <%-- <col width=""/> --%>
	                </colgroup>
	                <thead style="background-color: #EDEDED;">
		                <tr>
		                    <th><input type="checkbox" name="chkAll" id="chk_all"></th>
		                    <th>번호</th>
		                    <th>아이디</th>
		                    <th>대표자</th>
		                    <th>이메일</th>
		                    <th>가입일</th>
		                    <th>가게</th>
		                    <!-- <th>상태</th> -->
		                    <th>-</th>
		                </tr>
	                </thead>
	                <tbody>
		                <c:forEach items="${ requestScope.buisnessMemberList }" var="nm">
		                    <tr>
		                        <th scope="row"><input type="checkbox" name="chkMember" value="${ nm.memCode }" class="chkbox"></th>
		                        <td>${ nm.memCode }</td>
		                        <td>${ nm.memId }</td>
		                        <td>${ nm.ceo.name }</td>
		                        <td>${ nm.email }</td>
		                        <td>${ nm.enrollDate }</td>
		                        <td>${ nm.ceo.store.storeName }</td>
		                        <%-- <td>${ nm.ceo.store.membershipAndStore.membership.msType }</td> --%>
		                        <td>
		                        	<a href="javascript:void(0);" onclick="clickDetailInfo(this);" data-toggle="modal" data-target="#exampleModal">[상세보기]</a>
	                        	</td>
		                    </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
            </form>
            <!-- 페이징 -->
            <jsp:include page="../commons/paging.jsp"/>
        </div>
    </div>
    
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                	<h3 class="modal_title">사업자 정보</h3>
                    <div class="txt_info_box">
                        <table border="1">
                            <colgroup>
                                <col width=""/>
                                <col width=""/>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>사업자 번호</th>
                                    <td class="infoNum"></td>
                                </tr>
                                <tr>
                                    <th>대표자명</th>
                                    <td class="infoName"></td>
                                </tr>
                                <tr>
                                    <th>가입일</th>
                                    <td class="infoEnrollDate"></td>
                                </tr>
                                <tr>
                                    <th>아이디</th>
                                    <td class="infoId"></td>
                                </tr>
                                <tr>
                                    <th>이메일</th>
                                    <td class="infoEmail"></td>
                                </tr>
                                <tr>
                                    <th>가게정보</th>
                                    <td class="infoStore"></td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td class="infoAddress"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal_footer">
                    <h3 class="modal_title">결제내역</h3>
                    <table border="1">
                        <colgroup>
                            <col width="20%"/>
                            <col width="30%"/>
                            <col width="20%"/>
                            <col width="30%"/>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>결제일</th>
                                <td class="infoPaymentDay"></td>
                                <th>구매품목</th>
                                <td class="infoBuyItem"></td>
                            </tr>
                            <tr>
                                <th>만료일</th>
                                <td class="infoExpiryDate"></td>
                                <th>결제금액</th>
                                <td class="infoPaymentPrice"></td>
                            </tr>
                           <!--  <tr>
                                <th></th>
                                <td></td>
                                <th class="infoPaymentAllPrice">총 결제금액</th>
                                <td></td>
                            </tr> -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="../commons/footer.jsp"></jsp:include>

    <script>
    		
        $("#homeSubmenu1").addClass("show");
        $("#homeSubmenu1 > li:nth-child(2) > a").attr("style","color: #F89E91 !important");
         
        $("#chk_all").click(function(){
    	   	let chk = $(this).is(":checked");
    	   	if(chk){
    	   		$(".board_table > tbody > tr th input").prop('checked', true);
    	   	} else{
    	   		$(".board_table > tbody > tr th input").prop('checked', false);
    	   	}
   	    });
         
         /* 사업자 상세 정보 조회 */
		function clickDetailInfo(e){
			const modalInfo = e.parentNode.parentNode.firstElementChild.firstChild.value;
			const ceoNum = $('.txt_info_box .infoNum');
			const ceoName = $('.txt_info_box .infoName');
			const ceoEnrollDate = $('.txt_info_box .infoEnrollDate');
			const ceoId = $('.txt_info_box .infoId');
			const ceoEmail = $('.txt_info_box .infoEmail');
			const ceoStore = $('.txt_info_box .infoStore');
			const ceoAddress = $('.txt_info_box .infoAddress');
			const ceoPaymentDay = $('.modal_footer .infoPaymentDay');
			const ceoBuyItem = $('.modal_footer .infoBuyItem');
			const ceoExpiryDate = $('.modal_footer .infoExpiryDate');
			const ceoPaymentPrice = $('.modal_footer .infoPaymentPrice');
			const ceoPaymentAllPrice = $('.modal_footer .infoPaymentAllPrice');
     		
     		$.ajax({
     			url : '${ pageContext.servletContext.contextPath }/manager/ceoDetailInfo',
     			type : 'POST',
     			data : {
     				modalInfo : modalInfo
     			},
     			success : function(data){
     				console.log(data);
     				ceoNum.text(data.ceo.no);
     				ceoName.text(data.ceo.name);
     				ceoEnrollDate.text((new Date(data.enrollDate)).toLocaleDateString());
     				ceoId.text(data.memId);
     				ceoEmail.text(data.email);
     				ceoStore.text(data.ceo.store.storeName);
     				ceoAddress.text(data.address);
     				ceoPaymentDay.text((new Date(data.ceo.store.membershipAndStore.startDate)).toLocaleDateString());
     				ceoBuyItem.text(data.ceo.store.membershipAndStore.membership.msType);
     				ceoExpiryDate.text((new Date(data.ceo.store.membershipAndStore.endDate)).toLocaleDateString());
     				ceoPaymentPrice.text(data.ceo.store.membershipAndStore.membership.msPrice);
     				ceoPaymentAllPrice.text();
     			},
     			error : function(error){
     				console.log(error);
     			}
   			});
     	}
     </script>
</body>
</html>