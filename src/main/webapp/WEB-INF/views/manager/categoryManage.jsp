<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>카테고리 설정</title>
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
            <h2>카테고리 설정</h2>
           	<div class="tag_container">
	           	<div class="unused_tag">
		            <strong class="tag_title">미사용 카테고리</strong>
		            <button type="button" data-toggle="modal" data-target="#exampleModal">추가</button>
		            <ul class="df_ul tag_list">
		            	<c:forEach items="${ requestScope.categoryList }" var="ct" varStatus="vst">
		            		<c:if test="${ ct.status == 'N' }">
					            <li>
						            <input type="checkbox" name="chkCateCode" id="cheked<c:out value="${ vst.index }"/>" value="${ ct.categoryCode }">
						            <label for="cheked<c:out value="${ vst.index }"/>"></label>
						            <span>#${ ct.categoryName }</span>
						            <button type="button" onclick="categoryDelete(this);">
						            	<img src="${ pageContext.servletContext.contextPath }/resources/images/delete_btn.png" alt="태그삭제">
						            </button>
					            </li>
				            </c:if>
			            </c:forEach>
		            </ul>
	        	</div>
	            <div class="choice_use">
		            <button onclick="useCategory(this);" style="margin-bottom: 20px;">
		            	<img src="${ pageContext.servletContext.contextPath }/resources/images/use_tag_btn.png" alt="카테고리 사용">
		            </button>
		            <button onclick="unUseCategory(this);">
		            	<img src="${ pageContext.servletContext.contextPath }/resources/images/unuse_tag_btn.png" alt="카테고리 미사용">
		            </button>
	            </div>
	            <div class="used_tag">
		            <strong class="tag_title">사용 카테고리</strong>
		            <ul class="df_ul tag_list useCategoryList">
		            	<c:forEach items="${ requestScope.categoryList }" var="ct" varStatus="vst">
		            		<c:if test="${ ct.status == 'Y' }">
			            		<li>
						            <input type="checkbox" name="chkCateCode2" id="uncheked<c:out value="${ vst.index }"/>" value="${ ct.categoryCode }">
						            <label for="uncheked<c:out value="${ vst.index }"/>"></label>
						            <span>#${ ct.categoryName }</span>
					            </li>
				            </c:if>
		            	</c:forEach>
		            </ul>
		            <p>최대 16개</p>
	            </div>
            </div>
                
            <!-- 카테고리 추가 Modal -->
            <div class="modal fade add_tag_modal" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	            <div class="modal-dialog">
		            <div class="modal-content">
			            <div class="modal-body">
				            <p>카테고리 추가</p>
				            <form action="${ pageContext.servletContext.contextPath }/manager/categoryAdd" method="POST">
					            <input type="text" name="category" id="">
					            <div class="btn_box">
						            <input type="submit" style="background-color: #F89E91; margin-right: 5px;" value="확인">
						            <button data-dismiss="modal" aria-label="Close" style="background-color: #D7D4D4;">취소</button>
					            </div>
				            </form>
			            </div>
		            </div>
	            </div>
            </div>
        </div>
    </div>

    <jsp:include page="../commons/footer.jsp"></jsp:include>

    <script>
         $("#homeSubmenu5").addClass("show");
         $("#homeSubmenu5 > li:last-child > a").attr("style","color: #F89E91 !important");
         
         /* 카테고리 삭제 (미사용)*/
         function categoryDelete(e){
        	 
        	 const categoryCode = e.previousElementSibling.previousElementSibling.previousElementSibling.value;
        	 
        	 $.ajax({
        		url : '${ pageContext.servletContext.contextPath }/manager/categoryDelete',
        		type : 'POST',
        		data : {
        			categoryCode : categoryCode
        		},
        		success : function(data){
        			console.log(data);
        			location.reload();
        		},
        		error : function(error){
        			console.log(error);
        		}
        	 });
         }
         
         /* 사용 카테고리 등록 */
         function useCategory(){
        	 
        	 let useCategoryCount = $('.useCategoryList > li').length;
        	 let useCategoryCode = [];
        	 $("input:checkbox[name='chkCateCode']:checked").each(function(i, ival){
        		 useCategoryCode.push($(this).val());
        		 console.log(useCategoryCode);
        	 });
        	 
        	 let chkCount = useCategoryCode.length;
        	 let count = useCategoryCount + chkCount;
        	 
        	 if(count <= 16){
        		 
        		 $.ajax({
        			url : '${ pageContext.servletContext.contextPath }/manager/useCategory',
        			type : 'POST',
        			data : {
        				useCategoryCode : useCategoryCode
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
        		 alert("추가할 수 있는 카테고리는 최대 16개 입니다.");
        	 }
        	 
         }
         
         /* 미사용 카테고리 등록 */
         function unUseCategory(){
        	 
        	 let unUseCategoryCode = [];
        	 $("input:checkbox[name='chkCateCode2']:checked").each(function(i, ival){
        		 unUseCategoryCode.push($(this).val());
        		 console.log(unUseCategoryCode);
        	 });
        	 
       		 $.ajax({
       			url : '${ pageContext.servletContext.contextPath }/manager/unUseCategory',
       			type : 'POST',
       			data : {
       				unUseCategoryCode : unUseCategoryCode
       			},
       			success : function(data){
       				console.log(data);
       				location.reload();
       			},
       			error : function(error){
       				console.log(error);
       			}
       		 });
         }
     </script>
	
</body>
</html>