<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>공지사항</title>
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
			<h2>공지사항</h2>
			<form action="${ pageContext.servletContext.contextPath }/manager/noticeSelect" method="GET">
				<select class="sel_notice" name="searchCondition"
					id="searchCondition">
					<option value="all"
						${ requestScope.pagination.searchCondition eq "all"? "selected": "" }>전체</option>
					<option value="notice"
						${ requestScope.pagination.searchCondition eq "notice"? "selected": "" }>공지</option>
					<option value="guide"
						${ requestScope.pagination.searchCondition eq "guide"? "selected": "" }>안내</option>
					<option value="check"
						${ requestScope.pagination.searchCondition eq "check"? "selected": "" }>점검</option>
					<option value="event"
						${ requestScope.pagination.searchCondition eq "event"? "selected": "" }>이벤트</option>
					<option value="owner"
						${ requestScope.pagination.searchCondition eq "owner"? "selected": "" }>사업자</option>
				</select>
				<table class="table board_table">
					<colgroup>
						<col width="5%" />
						<col width="10%" />
						<col width="60%" />
						<col width="15%" />
						<col width="10%" />
					</colgroup>
					<thead style="background-color: #EDEDED;">
						<tr>
							<th><input type="checkbox" name="ch1" id="chk_all" ></th>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
					   <c:forEach items="${ requestScope.noticeUpList }" var="up">
						<tr class="important_notice">
							<th scope="row"><input type="checkbox" name="chkNotice" value="${ up.postNo }"></th>
							<td>공지</td>
							<td class="tal">
							<a href="${ pageContext.servletContext.contextPath }/manager/noticeDetailView?postNo=${ up.postNo }">${ up.postTitle }</a>
						    </td>
							<td>${ up.postDate }</td>
							<td>${ up.viewCnt }</td>
						</tr>
						</c:forEach>
						
						<c:forEach items="${ requestScope.noticeList }" var="nl" varStatus="status">
						<c:set var="num" value="${(pagination.totalCount-status.index) - ((pagination.pageNo-1) * 10)}"/>
							<tr>
								<th scope="row"><input type="checkbox" name="chkNotice"
									value="${ nl.postNo }"></th>
								<td>${ num }</td>
								<td class="tal"><a
									href="${ pageContext.servletContext.contextPath }/manager/noticeDetailView?postNo=${ nl.postNo }">${ nl.postTitle }</a>
								</td>
								<td>${ nl.postDate }</td>
								<td>${ nl.viewCnt }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<input type="button" id="delNotice" name="delNotice" class="black_btn delete_btn" value="삭제하기">
				<a href="${ pageContext.servletContext.contextPath }/manager/noticeWrite"
					class="black_btn write_btn" style="background-color: #F89E91;">작성하기</a>
			</form>

			<jsp:include page="../commons/paging.jsp" />
		</div>
	</div>

	<script type="text/javascript">
	
		$('#delNotice').on('click',function(){
			
   	    	if(confirm("선택한 게시글을 삭제하시겠습니까?") == false){
   	    		return false;
   	    	}
			
			let delList = $(".board_table > tbody > tr");
			let chkNotice = [];
			
			$("input:checkbox[name='chkNotice']:checked").each(function(index, item){
				chkNotice.push($(this).val());
				console.log(chkNotice);
				
			})
		
		
			$.ajax({
				url: '${ pageContext.servletContext.contextPath }/manager/noticeSelect/' + chkNotice,
				type: 'GET',
				success: function(data){
					alert(data);
					location.href="${ pageContext.servletContext.contextPath }/manager/noticeSelect";
				},
				error: function(data){
					alert(data);
				}
			});		
		});
	
	</script>

	<jsp:include page="../commons/footer.jsp" />

	<script>
	
	    $("#homeSubmenu2").addClass("show");
        $("#homeSubmenu2 > li:first-child > a").attr("style","color: #F89E91 !important");
        
   	    $("#chk_all").click(function(){
   	    	
		   	 let chk = $(this).is(":checked");
		   	 if(chk){
		   		 $(".board_table > tbody > tr th input").prop('checked', true);
		   	 } else{
		   		 $(".board_table > tbody > tr th input").prop('checked', false);
		   	 }
	   	 
	    });
        
	   	$('#searchCondition').on('change',function() {
	    	 let changedCondition = $('#searchCondition').val();
	    	 console.log($(this).val());
	    	 location.href = "${ location.href }?searchCondition=" + changedCondition;
	 
	    });
       
        
     </script>


</body>
</html>