<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>사업자 정산</title>
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
            <h2>사업자 정산</h2>
                <div class="date_box" style="margin-bottom: 0px;">
                    <span style="font-size: 20px;">결제 기간</span>
                    <input type="date" class="calendar" id="startDate">
                    <label>~</label>
                    <input type="date" class="calendar" id="endDate">
                    <input type="button" id="searchByDate" class="gray_btn" value="검색">
                    <script>
                    	$('#searchByDate').on('click',function() {
                    		let startDate = $('#startDate').val();
                    		let endDate = $('#endDate').val();
                    		if(startDate == null || endDate == null) {
                    			alert("날짜를 지정해주세요.");
                    		} else {
                    			location.href='${ pageContext.servletContext.contextPath }/manager/taxAdjustment?startDate=' + startDate + '&endDate=' + endDate;
                    		}
                    	});
                    </script>
                </div>
                <div class="top_box">
                    <input type="button" id="excel" value="엑셀변환" style="background-color: #F89E91;">
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
                    <col width="14%"/>
                    <col width=""/>
                    <col width=""/>
                </colgroup>
                <thead style="background-color: #EDEDED;">
                    <tr>
                        <th><input type="checkbox" name="ch2" id="chk_all"></th>
                        <th>결제일자</th>
                        <th>타입</th>
                        <th>공급가액</th>
                        <th>세액</th>
                        <th>합계금액</th>
                        <th>공급받는자 성명</th>
                        <th>공급받는자 상호명</th>
                        <th>공급받는자 등록번호</th>
                        <th>공급받는자 이메일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${ requestScope.taxAdjustList }" var="tax">
                    <tr>
                        <td scope="row"><input type="checkbox" name="ch1" value="${ tax.code }"></td>
                        <td>${ tax.payDate }</td>
                        <td>${ tax.msType }</td>
                        <td><fmt:formatNumber value="${ tax.msPrice * 0.9 }"/></td>
                        <td><fmt:formatNumber value="${ tax.msPrice * 0.1 }"/></td>
                        <td><fmt:formatNumber value="${ tax.msPrice }"/></td>
                        <td>${ tax.ceoName }</td>
                        <td>${ tax.storeName }</td>
                        <td>${ tax.storeNo }</td>
                        <td><input type="text" value="${ tax.email }" class="text_email" disabled></td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <script>
            	$('#excel').on('click',function() {
            		let codeList = [];
            		$('input:checkbox[name=ch1]:checked').each(function(index,item) {
            			codeList.push($(this).val());
            		})
            		
            		$.ajax({
            			url: '${ pageContext.servletContext.contextPath }/manager/excel',
            			type: 'post',
            			data: {
            				codeList : codeList
            			},
            			success: function(data) {
            				
            			}
            		});
            		
            	})
            </script>
            <p style="float: right; color: gray">작성일자는 결제일자가 포함된 달의 다음달 10일까지 입니다!</p>
            
            <jsp:include page="../commons/paging.jsp"/>
        </div>
    </div>

	<jsp:include page="../commons/footer.jsp"></jsp:include>
	
   <script>
       $("#chk_all").on('click',function(){
         if($('#chk_all').is(':checked') == true) {
        	 $('input:checkbox').attr('checked',true);
         } else {
        	 $('input:checkbox').attr('checked',false);
         }
       });
   </script>
    
</body>
</html>