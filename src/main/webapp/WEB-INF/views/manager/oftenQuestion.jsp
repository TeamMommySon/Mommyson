<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>자주하는 질문</title>
</head>
<body>
    <header class="manager_header at-container">
		<img
			src="${ pageContext.servletContext.contextPath }/resources/images/managerLogo.png"
			alt="마미손맛 MANAGEMENT"> <a href="../main.html" class="home_btn">
			<img
			src="${ pageContext.servletContext.contextPath }/resources/images/mainHome.png"
			alt="메인화면으로">
			<p>메인화면으로</p>
		</a>
	</header>
    <div class="head_line"></div>
    <div class="at-container total_container">
        
        <jsp:include page="../commons/managerSidebar.jsp" />
        
        <div class="board_container">
            <h2 onclick="location.href='${ pageContext.servletContext.contextPath }/manager/oftenQuestion'">자주하는 질문</h2>
            <form
				action="${ pageContext.servletContext.contextPath }/manager/oftenQuestion"
				method="GET">
             <div class="search_box">
        	 <ul class="df_ul">
		        <li><img class="glass" src="${ pageContext.servletContext.contextPath}/resources/images/glass.png "></li>
		        <li><input type="search" class="searchtext" name="searchValue" placeholder="찾고싶은 내용 검색하기" onKeyup="javascript:if(event.keyCode==13) {search_onclick_submit()}"></li>
		        <li><button type="button" class="searchbutton" onclick="search_onclick_submit()">검색하기</button></li>
        	 </ul>
             </div>
                       
            <ul class="df_ul question_category">
                <li id="six" onclick="location.href='${ pageContext.servletContext.contextPath }/manager/oftenQuestion?searchCondition=memberJoinQuestion'"> 
                    <a>회원가입</a>
                </li>
                <li id="seven" onclick="location.href='${ pageContext.servletContext.contextPath }/manager/oftenQuestion?searchCondition=billAndOrderQuestion'">
                    <a>결제/주문</a>
                </li>
                <li id="eight" onclick="location.href='${ pageContext.servletContext.contextPath }/manager/oftenQuestion?searchCondition=reviewManagementQuestion'">
                    <a>리뷰관리</a>
                </li>
                <li id="nine" onclick="location.href='${ pageContext.servletContext.contextPath }/manager/oftenQuestion?searchCondition=userQuestion'">
                    <a>이용문의</a>
                </li>
                <li id="ten" onclick="location.href='${ pageContext.servletContext.contextPath }/manager/oftenQuestion?searchCondition=inconvenienceQuestion'">
                    <a>불편관리</a>
                </li>
                <li id="eleven" onclick="location.href='${ pageContext.servletContext.contextPath }/manager/oftenQuestion?searchCondition=etcQuestion'">
                    <a>기타</a>
                </li>
            </ul>
            <table class="table board_table question_table">
                <colgroup>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="15%"/>
                    <col width="70%"/>
                </colgroup>
                <thead style="background-color: #EDEDED;">
                    <tr>
                        <th><input type="checkbox" name="ch1" id="chk_all"></th>
                        <th>번호</th>
                        <th>카테고리</th>
                        <th>제목</th>
                    </tr>
                </thead>
                
                <tbody>
                <c:forEach items="${ requestScope.OftenQuestionList }" var="ql" varStatus="status">
                <c:set var="num" value="${(pagination.totalCount-status.index) - ((pagination.pageNo-1) * 10)}"/>
                    <tr class="click_qa">
                        <th scope="row"><input type="checkbox" name="chkQuestion" value="${ ql.postNo }"></th>
                        <td>${ num }</td>
                        <td>
                        <c:if test="${ ql.boardCode eq '6' }">회원가입</c:if>
                        <c:if test="${ ql.boardCode eq '7' }">결제주문</c:if>
                        <c:if test="${ ql.boardCode eq '8' }">리뷰관리</c:if>
                        <c:if test="${ ql.boardCode eq '9' }">이용문의</c:if>
                        <c:if test="${ ql.boardCode eq '10' }">불편관리</c:if>
                        <c:if test="${ ql.boardCode eq '11' }">기타</c:if>
                        </td>
                        <td class="tal">${ ql.postTitle }</td>
                    </tr>
                    <tr class="answer tal">
                        <td colspan="4">${ ql.postContent }</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <input type="button" id="delQuestion" name="delQuestion" class="black_btn delete_btn" value="삭제하기">
            <a href="${ pageContext.servletContext.contextPath }/manager/oftenQuestionWrite" class="black_btn write_btn" style="background-color: #F89E91;">작성하기</a>
            </form>
            
            <!-- 페이징 -->
            <jsp:include page="../commons/pagingWithoutSearch.jsp" />
        </div>
    </div>
    
    <script type="text/javascript">
	
		$('#delQuestion').on('click',function(){
			
   	    	if(confirm("선택한 게시글을 삭제하시겠습니까?") == false){
   	    		return false;
   	    	}
			
			let delList = $(".board_table > tbody > tr");
			let chkQuestion = [];
			
			$("input:checkbox[name='chkQuestion']:checked").each(function(index, item){
				chkQuestion.push($(this).val());
				console.log(chkQuestion);
				
			})
		
		
			$.ajax({
				url: '${ pageContext.servletContext.contextPath }/manager/oftenQuestion/' + chkQuestion,
				type: 'GET',
				success: function(data){
					alert(data);
					location.href="${ pageContext.servletContext.contextPath }/manager/oftenQuestion";
				},
				error: function(data){
					alert(data);
				}
			});		
		});
	
	</script>

    <jsp:include page="../commons/footer.jsp" />
    
    
    
    <script>
	    $(".click_qa").on('click',function(e){
	        $(event.currentTarget).next().toggle(300);

	    });
	    
	    $("#chk_all").click(function(){
		    	
		   	 let chk = $(this).is(":checked");
		   	 if(chk){
		   		 $(".board_table > tbody > tr th input").prop('checked', true);
		   	 } else{
		   		 $(".board_table > tbody > tr th input").prop('checked', false);
		   	 }
	  	 
	   });
	    
	    $("#homeSubmenu2").addClass("show");
        $("#homeSubmenu2 > li:nth-child(2) > a").attr("style","color: #F89E91 !important");
    
	    /* 삭제 XXXX */
	   /* $('#searchCondition').on('change',function() {
		   
		   	let changedCondition = $('#searchCondition').val();
		   	console.log($(this).val());
		   	location.href = "${ location.href }?searchCondition=" + changedCondition;
	
	   }); */


	  /*  $('.question_category > li').on('click',function(e){
		   let getValue = e.currentTarget.firstElementChild.value;
		   let realValue = document.getElementById('searchCondition').value = getValue;
		   console.log("겟 : " + getValue);
		   console.log("진짜 : " + realValue);
		   console.log(document.location.href);
	   }) */
	   
	   
    </script>
</body>
</html>