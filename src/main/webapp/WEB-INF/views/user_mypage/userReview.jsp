<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
  <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/user/userMyPageSideBar.css">
  <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/user/userReview.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="../commons/header.jsp"></jsp:include>

    <section>

      <div class="container">
        <div class="row">
          <div class="col-md-3">
               <jsp:include page="../commons/userMyPageSidebar.jsp"></jsp:include>
      </div>
      <div class="col-md-9">
            <div id="pagetitle">
              <br><br>
              <h3><strong>내가쓴 리뷰</strong> &nbsp;&nbsp;<sub>고객님이 현재까지 작성한 리뷰 내역 입니다. </sub></h3>
              
            </div>
            <br><br><br>
            <table class="table table">
              <thead>
                <tr>
                  <th id="tablecol1" scope="col">가게 정보</th>
                  <!-- <th id="tablecol2" scope="col"></th>제품 이미지  -->       
                  <th id="tablecol3" scope="col">제품정보</th>        
                  <th id="tablecol4" scope="col">리뷰</th>        
                  <th id="tablecol5" scope="col">별점</th>        
                  <th id="tablecol6" scope="col">작성일자</th>        
                  <th id="tablecol7" scope="col"></th><!--수정삭제 버튼-->        
                </tr>
              </thead>
              <tbody>
				<c:forEach var="reviewInfo" items="${ requestScope.reviewContentList }">
                <tr>
                  <td>
                   <c:forEach var="RelativeSdIfo" items="${ requestScope.productInfo }">
                  	<c:if test="${ RelativeSdIfo.ORDER_CODE eq reviewInfo.orderCode }">
               		   <img class="storeimg" src="${ pageContext.servletContext.contextPath }/${ RelativeSdIfo.STORE_IMG }">
                	</c:if>
                   </c:forEach>
                  </td>
                  <td>
                  	<img class="storeimg" src="${ pageContext.servletContext.contextPath }/${ reviewInfo.img }">
                  </td>
                  <td style="padding-top: 40px;"><c:out value="${ reviewInfo.content }"/></td>
                  <td style="padding-top: 40px;"><c:out value="${ reviewInfo.grade }"/>개</td><!--추후 별 이미지 처리-->
                  <td style="padding-top: 40px;"><c:out value="${ reviewInfo.orderDTO.requestTime }"/></td><!-- 주문일자 -->
                  <td style="padding-top: 40px;"><button class="urBtn del" value="${ reviewInfo.rvCode }">삭제</button><button class="urBtn am" value="${ reviewInfo.rvCode }">수정</button></td>
                </tr>
               	
				</c:forEach>
              </tbody>
            </table>
            <script>
            										
				if(document.getElementsByClassName("del")) {
					const $button =$('.del');

					console.log($button);
					
					for(let i = 0; i< $button.length; i++) {
						$button[i].onclick = function() {
							let rvCode = this.value;
							console.log(rvCode);
							
							 $.ajax({
								url:"${ pageContext.servletContext.contextPath }/userMyPage/delReview",
								method : "post",
								data : {
									rvCode : rvCode
								},
								success : function(data, textStatus,xhr) {
									alert(data);
									location.reload();
								},
								error : function(xhr, status, error) {
									
									alert(error);
									location.reload();
								}
							}); 
						}
					}
				}
				if(document.getElementsByClassName("am")) {
					const $button2 =$('.am');
					console.log($button2);

					for(let j = 0; j< $button2.length; j++) {
						$button2[j].onclick = function() {
							let rvCode2 = this.value;
							console.log(rvCode2);
							location.href = "${ pageContext.servletContext.contextPath }/userMyPage/amendmentReview?rvCode=" + rvCode2;
						}
					}
				}
            </script>

			<ul>
                 <jsp:include page="../commons/userMyPagePagination.jsp"/>
             </ul>
            <!-- 페이징 -->
 
			<form action="${ pageContext.servletContext.contextPath }/userMyPage/userReview" method="get" style="margin-left: 300px">
               <input type="hidden" name="currentPage" value="1">			
               <img class="glass" src="${ pageContext.servletContext.contextPath }/resources/images/glass.png">
               <input type="text" class="searchtext" name="searchValue" placeholder="찾고싶은 리뷰 작성한 가게 이름을 입력해주세요">
               <button type="submit" class="searchbutton">검색하기</button>
			</form>
           

          </div>
            
          </div>
        </div>
    
    </section>
   	<jsp:include page="../commons/footer.jsp"/>
  </body>
  </html>
