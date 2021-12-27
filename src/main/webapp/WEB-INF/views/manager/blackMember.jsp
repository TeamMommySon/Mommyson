<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>블랙회원조회</title>
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
            <form action="${ pageContext.servletContext.contextPath }/manager/terminateBlack" method="POST">
	            <div class="top_box">
	                <p>블랙 회원 조회</p>
	                <input type="button" value="블랙해지" onclick="terminateFinish(this);">
	            </div>
	            <table class="table board_table">
	                <colgroup>
	                    <col width=""/>
	                    <%-- <col width=""/> --%>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                    <col width=""/>
	                </colgroup>
	                <thead style="background-color: #EDEDED;">
		                <tr>
		                    <th><input type="checkbox" name="chkAll" id="chk_all"></th>
		                    <!-- <th>번호</th> -->
		                    <th>아이디</th>
		                    <th>닉네임</th>
		                    <th>이메일</th>
		                    <th>가입일</th>
		                    <th>총 결제금액</th>
		                    <th>경고내역</th>
		                </tr>
	                </thead>
	                <tbody>
	                	<c:forEach items="${ requestScope.blackMemberList }" var="nm">
			                <tr>
		                        <th scope="row"><input type="checkbox" name="chkMember" value="${ nm.memCode }" class="chkbox"></th>
		                        <td style="display: none;" id="rvCodeId"><c:forEach items="${ nm.user.review }" varStatus="status" var="rv"><c:forEach items="${ rv.report }" var="rp" varStatus="status2">${ rp.rvCode }<c:if test="${ !status.last || !status2.last }">,</c:if></c:forEach></c:forEach></td>
		                        <td>${ nm.memId }</td>
		                        <td>${ nm.nickname }</td>
		                        <td>${ nm.email }</td>
		                        <td>${ nm.enrollDate }</td>
		                        <td class="totalPrice"><button type="button" style="border: 0; padding: 7px;" onclick="totalPrice(this);">확인하기</button><span class="total"></span></td>
		                        <td><a href="javascript:void(0);" onclick="blackMemDetail(this);" data-toggle="modal" data-target="#exampleModal">[경고내역보기]</a></td>
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
                   <table border="1" class="tb_content">
                       <colgroup>
                            <col width="10%"/>
                            <col width="10%"/>
                            <col width="15%"/>
                            <col width="50%"/>
                            <col width="15%"/>
                       </colgroup>
                       <thead>
                           <tr>
                               <th>경고순번</th>
                               <th>리뷰코드</th>
                               <th>카테고리</th>
                               <th>내용</th>
                               <th>신고날짜</th>
                           </tr>
                       </thead>
                       <tbody class="infoTbody">
                           <!-- <tr>
                               <td class="no">1</td>
                               <td class="category"></td>
                               <td class="content"></td>
                               <td class="date"></td>
                           </tr> -->
                       </tbody>
                   </table>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../commons/footer.jsp"></jsp:include>

    <script>
    	$("#chk_all").click(function(){
	   	 let chk = $(this).is(":checked");
	   	 if(chk){
	   		 $(".board_table > tbody > tr th input").prop('checked', true);
	   	 } else{
	   		 $(".board_table > tbody > tr th input").prop('checked', false);
	   	 }
	   	 
	    });
 
         $("#homeSubmenu1").addClass("show");
         $("#homeSubmenu1 > li:last-child > a").attr("style","color: #F89E91 !important");
         
         function blackMemDetail(e){
        	 
        	 const memCode = e.parentElement.parentElement.firstElementChild.firstElementChild.value;
        	 let no = $('.no');
        	 let category = $('.category');
        	 let content = $('.content');
        	 let date = $('.date');
        	 
        	 $.ajax({
        		url : '${ pageContext.servletContext.contextPath }/manager/blackMemDetail',
        		type : 'POST',
        		data : {
        			memCode : memCode
        		},
        		success : function(data,index){
        			console.log(data);
        			
        			const infoTbody = $('.infoTbody');
        			infoTbody.html("");
        			
        			let count = 1;
        			for(let index in data){
        				
        				$tr = $("<tr>");
        				$noTd = $("<td>").text(count);
        				$reviewNoTd = $("<td>").text(data[index].RV_CODE);
        				$categoryTd = $("<td>").text(data[index].REP_TYPE);
        				$contentTd = $("<td>").text(data[index].RV_CONTENT);
        				$dateTd = $("<td>").text((new Date(data[index].REP_DATE)).toLocaleDateString());
        				
        				$tr.append($noTd);
        				$tr.append($reviewNoTd);
        				$tr.append($categoryTd);
        				$tr.append($contentTd);
        				$tr.append($dateTd);
        				
        				infoTbody.append($tr);
        				
        				count++;
        			}
        			
        		},
        		error : function(error){
        			console.log(error);
        		}
        	 });
         }
         
         function terminateFinish(e){
        	 
        	 if($("input:checkbox[name='chkMember']:checked") != null){
        		 const rvCodes = e.parentElement.parentElement.lastElementChild.lastElementChild.firstElementChild.firstElementChild.nextElementSibling.textContent;
            	 let chkMember = [];
         		
         		 $("input:checkbox[name='chkMember']:checked").each(function(i, ival) {
         			 chkMember.push($(this).val());
         			 console.log(chkMember);
                 });
         		 
         		 console.log(rvCodes);
         		 console.log(chkMember);
         		 
         		$.ajax({
         			url : '${ pageContext.servletContext.contextPath }/manager/terminateBlack',
         			type : 'POST',
         			data : {
         				chkMember : chkMember,
         				rvCodes : rvCodes
         			},
         			success : function(data){
         				console.log(data);
         				location.reload();
         			},
         			error : function(error){
         				console.log(error);
         			}
         		 });
         		
        	 } else {
        		 alert("체크해주세요.");
        	 }
        	 
         }
         
         function totalPrice(e){
 	    	
 	    	let getMemCode = e.parentElement.parentElement.firstElementChild.firstElementChild.value;
 	    	let price = e;
 	    	let result = e.nextElementSibling;
 	    	$.ajax({
 	    		url : '${ pageContext.servletContext.contextPath }/manager/totalPrice',
 	    		type : 'POST',
 	    		data : {
 	    			getMemCode : getMemCode
 	    		},
 	    		success : function(data){
 	    			$(price).css('display','none');
 	    			$(result).text(data + "원");
 	    		},
 	    		error : function(error){
 	    			console.log(error);
 	    		}
 	    	});
 	    }
     </script>
</body>
</html>