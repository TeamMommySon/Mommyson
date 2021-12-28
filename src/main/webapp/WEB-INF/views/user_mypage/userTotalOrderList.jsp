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
  <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/user/userTotalOrderList.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>
<body>
   <jsp:include page="../commons/header.jsp"></jsp:include>
	<script>
		$(function() {
			if(${ requestScope.message != null}) {
				alert('${ requestScope.message }');
			}
		});
	</script>
    <section>
		
      <div class="container">
        <div class="row">
          <div class="col-md-3">
              <jsp:include page="../commons/userMyPageSidebar.jsp"></jsp:include>
          </div>
          <div class="col-md-9">
            <div id="pagetitle">
              <br><br>
              <h3><strong>주문 내역</strong>&nbsp;&nbsp;<sub>고객님이 현재까지 주문한 내역 입니다. </sub></h3>
            </div>
            <br><br><br>
            <table class="table table" style="width: 1050px;">
              <thead style="background-color: #EDEDED;">
                <tr>
                  <th id="tablecol0"><input type="checkbox" style="width: 20px; height: 20px;" onclick="selectAll(this)"></th><!-- 체크 박스 -->
                  <th id="tablecol1" scope="col">가게 정보</th>
                  <th id="tablecol2" scope="col"></th><!-- 제품 이미지 -->        
                  <th id="tablecol3" scope="col">제품정보</th>        
                  <th id="tablecol4" scope="col">제품금액</th>        
                  <th id="tablecol5" scope="col">수량</th>        
                  <th id="tablecol6" scope="col">주문완료일자</th>        
                  <th id="tablecol7" scope="col">구매금액</th>      
                  <th id="tablecol8" scope="col">상태</th><!-- 리뷰쓰기 버튼// 접수상테(배달이완료되고 나서 뜨도록) -->     
                </tr>
              </thead>
              <tbody>
              <c:forEach var="myOrder"  items="${ requestScope.myOrderList }">
              	<tr>
                  <td style="padding-top: 40px;">
                  	<c:if test="${ (myOrder.acceptTime eq null) && (myOrder.cancleTime eq null) }">
             	     <input type="checkbox" name="choose" value="${ myOrder.orderCode }" style="width: 20px; height: 20px;">
           		    </c:if>
             	     <input type="hidden" name="orderCode" value="${ myOrder.orderCode }">
             	     <%-- <c:out value="${ myOrder.orderCode }"/> --%>
                  </td>
                  <td>
                  <img class="storeimg" src="${ pageContext.servletContext.contextPath }/${ myOrder.storeInfo.storeImg }">
                  </td>
                  <td colspan="4" style="padding-top: 40px; padding-left: 0px; padding-right: 0px;">
                  	<ul style="list-style: none">
                  
                  <c:forEach var="sdInfo" items="${ requestScope.mySdInfo }">
	                  <c:if test="${ myOrder.orderCode eq sdInfo.ORDER_CODE }">
		         	  <%-- <c:set var="i" value="${ i+1 }"/> --%>
	         	      	<li style="display: flex;">	         	      	
	         	      	<img class="storeimg" src="${ pageContext.servletContext.contextPath }/${ sdInfo.SD_IMG }">
	         	      	<p style="width: 220px"><c:out value="${ sdInfo.SD_NAME }"/></p>
	         	      	<p style="width: 100px"><c:out value="${ sdInfo.PRICE }"/></p>
	         	      	<p style="width: 100px"><c:out value="${ sdInfo.AMONT }"/></p>
	         	      	</li>
	         	      <br>
	                  </c:if>
                  </c:forEach>
                  	</ul>
                  </td>
                  
                  <td style="padding-top: 40px;">
                  <c:out value="${ myOrder.completeTime }"/>
                  </td>
                  <td style="padding-top: 40px;"><c:out value="${ myOrder.totalPrice }"/></td>
                  <td style="padding-top: 40px;">
                  <c:if test="${ myOrder.completeTime ne null && myOrder.acceptTime ne null }">
                  <button value="${ myOrder.orderCode }" onclick="postReview(this)" class="urBtn">리뷰쓰기</button>                             
                  </c:if>
                  <c:if test="${ (myOrder.acceptTime eq null) && (myOrder.cancleTime eq null) }">
                  <!-- 아직 접수 되지 않은 상태 -->             
                  <h6>주문접수 대기 중</h6>           
                  </c:if>
                  <c:if test="${ myOrder.completeTime eq null && myOrder.acceptTime ne null }">
                  <!-- 아직 소비자가 물건을 받지 못한 상태  -->
                  <h6>수령 대기중</h6>
                  </c:if>
                  <c:if test="${ myOrder.cancleTime ne null }">
                  <!-- 아직 소비자가 물건을 받지 못한 상태  -->
                  <h6>주문취소</h6>
                  </c:if>
                  </td>
                  <!-- <td style="padding-top: 40px;"></td> -->
                  <!-- 주문접수가 완료 되면 위의 리뷰쓰기 버튼이 뜨도록 만든다 동시에  주문이 접수되면 체크박스가 비활성화 되도록 만든다.(주문취소버튼이 의미없도록)  -->
                </tr>
              </c:forEach>
                
              </tbody>
            </table>
            <script>
            	// 리뷰작성
            	function postReview(e) {
            		let orderCode = e.value;
            		location.href='${ pageContext.servletContext.contextPath }/userMyPage/postReview?orderCode=' + orderCode;
            	}
            </script>
            <div>
              <button class="urBtn" style="margin-left: 970px;" onclick="getCheckboxValue()">주문취소</button>
            </div>
            <script>
            	
            	function getCheckboxValue() {
            		const query = 'input[name="choose"]:checked';
            		  const selectedEls = 
            		      document.querySelectorAll(query);
            		  
            		  let result = '';
            		  selectedEls.forEach((el) => {
            		    result += el.value + ' ';
            		  });
            	console.log(result);
            	
            	$.ajax({
            		url:"${ pageContext.servletContext.contextPath }/userMyPage/orderCancel",
            		method: "post",
            		data :{
            			result : result
            		},
            		success : function(data, textStatus, xhr) {
						alert(data);
						location.replace(location.href);

					},
					error : function(xhr, status, error) {
						alert("문제가 발생했습니다.");
						location.replace(location.href);
					}
            	});
				}
            	
            	function selectAll(selectAll)  {
            		  const checkboxes 
            		       = document.getElementsByName('choose');
            		  
            		  checkboxes.forEach((checkbox) => {
            		    checkbox.checked = selectAll.checked;
            		  })
            		}
            	
            </script>
              <div>
                    <jsp:include page="../commons/userMyPagePagination.jsp"/>
                <!-- 페이징 -->
                   <ul style="display: flex; flex-direction: row; justify-content: center; align-items: baseline;">
                      <img class="glass" src="${ pageContext.servletContext.contextPath }/resources/images/glass.png">
                      <form action="${ pageContext.servletContext.contextPath }/userMyPage/myOrderList" method="get">
                      <input type="hidden" name="currentPage" value="1">
                      <input type="text" class="searchtext" placeholder="주문한 가게의 이름을 입력해주세요." name="searchValue">
                      <button type="submit" class="searchbutton">검색하기</button>
                      </form>
                   </ul>
              </div>
            
            
          </div>
        </div>
      </div>
    </section>
	<jsp:include page="../commons/footer.jsp"/>
  </body>
  </html>
