<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/manager.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<nav class="page_box" aria-label="Page navigation example">
        <ul class="pagination">
            <!-- 맨 앞으로 이동 버튼 -->
           <li class="page-item"><a class="page-link-num" id="startPage" href="#">&laquo;</a></li>
         <!-- 이전 페이지 버튼 -->
         <c:if test="${ requestScope.selectCriteria.pageNo > 1 }">
            <li class="page-item"><a class="page-link-num" id="prevPage" href="#">&lt;</a></li>
         </c:if>
         
         <!-- 숫자 버튼 -->
         <c:forEach var="page" begin="${ requestScope.selectCriteria.startPage }" end="${ requestScope.selectCriteria.endPage }" step="1">
            <c:if test="${ requestScope.selectCriteria.pageNo eq page }">
               <li class="page-item"><a class="page-link-num pageNo" href="#"><c:out value="${ page }"/></a></li>
            </c:if>
         <!-- 현재 페이지 -->
            <c:if test="${ requestScope.selectCriteria.pageNo ne page }">
               <li class="page-item"><a class="page-link-num pageNo" href="#"><c:out value="${ page }"/></a></li>
            </c:if>
         </c:forEach>
           
          <!-- 다음 페이지 버튼 -->
         <c:if test="${ requestScope.selectCriteria.pageNo < requestScope.selectCriteria.maxPage }">
            <li class="page-item"><a class="page-link-num" id="nextPage" href="#">&gt;</a></li>
         </c:if>
         <!-- 마지막 페이지로 이동 버튼 -->
             <li class="page-item"><a class="page-link-num" id="maxPage" href="#">&raquo;</a></li> 
        </ul>
    </nav>
	
	<script>
	
		let link ="";

			
		let fqaL = '${ requestScope.fqaList }';
		if(fqaL != "" && fqaL != null) {
			
			if( fqaL[0].boardCode == '6') {
				link = "${ pageContext.servletContext.contextPath }/user/ucc/memberJoinFqa";
			}
			
			if(	fqaL[0].boardCode == '7') {
				link = "${ pageContext.servletContext.contextPath }/user/ucc/paycheckFqa";
			}
			
			if(	fqaL[0].boardCode == '8') {
				link = "${ pageContext.servletContext.contextPath }/user/ucc/reviewFqa";
			}
			
			if(	fqaL[0].boardCode == '9') {
				link = "${ pageContext.servletContext.contextPath }/user/ucc/usingFqa";
			}
			
			if(	fqaL[0].boardCode == '10') {
				link = "${ pageContext.servletContext.contextPath }/user/ucc/inconFqa";
			}
			
			if(	fqaL[0].boardCode == '11') {
				link = "${ pageContext.servletContext.contextPath }/user/ucc/etcFqa";
			}

		}
	 	if( "${ requestScope.paging }" === "mtm" ){
			link = "${ pageContext.servletContext.contextPath }/user/ucc/MTMConsult";
		} 
		
		
		let searchText = "";
			
			
		if(${ !empty requestScope.selectCriteria.searchCondition? true: false }) {
			searchText += "&searchCondition=${ requestScope.selectCriteria.searchCondition }";
		}
		
		if(${ !empty requestScope.selectCriteria.searchValue? true: false }) {
			searchText += "&searchValue=${ requestScope.selectCriteria.searchValue }";
		}
			
		if(document.getElementById("startPage")) {
			const $startPage = document.getElementById("startPage");
			$startPage.onclick = function() {
				location.href = link + "?currentPage=1" + searchText;
			}
		}
		
		if(document.getElementById("prevPage")) {
			const $prevPage = document.getElementById("prevPage");
			$prevPage.onclick = function() {
				location.href = link + "?currentPage=${ requestScope.selectCriteria.pageNo - 1 }" + searchText;
			}
		}
		
		if(document.getElementById("nextPage")) {
			const $nextPage = document.getElementById("nextPage");
			$nextPage.onclick = function() {
				location.href = link + "?currentPage=${ requestScope.selectCriteria.pageNo + 1 }" + searchText;
			}
		}
		
		if(document.getElementById("maxPage")) {
			const $maxPage = document.getElementById("maxPage");
			$maxPage.onclick = function() {
				location.href = link + "?currentPage=${ requestScope.selectCriteria.maxPage }" + searchText;
			}
		}
		
		$(".pageNo").click(function(){
			let pageNo = $(this).text();
			console.log(link);
			location.href = link + "?currentPage=" + pageNo + searchText;
		});
	</script>

</body>
</html>