<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
  <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/user/userMyPageSideBar.css">
  <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/user/userCustomerServiceMain.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="../commons/header.jsp"></jsp:include>
    <section>

      <div class="container">
        <div class="row" id="rowunder">
          <div class="col-md-3">
              <jsp:include page="../commons/userCustomerServiceCenterSidebar.jsp"></jsp:include>
          </div>

          <div class="col-md-9">
            <div id="userCouponHead">
            <br>
              <h3 id="title"><strong>고객센터</strong></h3>
            </div>
            <br>
              <h5><b>FAQ</b></h5>
              <!-- 구현하시는 분은 자주묻는 질문이나 공지사항 게시판 양식 그대로 끌어다 만드시면 됩니다. 클릭할때 관련 질문이 출력 되어야합니다.
                  아니 게시판 형식이 아니어도 내용만 양식에 맞게 출력되면 ok입니다.  
              -->
            <div style="border: solid gainsboro 2px; text-align: center; margin-top: 30px;">
              <table>
                <tbody class="qnaList">
                  <tr>
                    <td style="border-right: solid gainsboro;"><a href="${ pageContext.servletContext.contextPath }/user/ucc/memberJoinFqa?currentPage=1&searchValue=찾기"><img class="imgFAQ" src="${ pageContext.servletContext.contextPath }/resources/images/FAQICONIdPasswordFind.png"></a></td>
                    <td style="border-right: solid gainsboro;"><a href="${ pageContext.servletContext.contextPath }/user/ucc/paycheckFqa?currentPage=1&searchValue=주문내역+조회"><img class="imgFAQ" src="${ pageContext.servletContext.contextPath }/resources/images/FAQICONOrderList.png"></a></td>
                    <td style="border-right: solid gainsboro;"><a href="${ pageContext.servletContext.contextPath }/user/ucc/reviewFqa?currentPage=1&searchValue=조회"><img class="imgFAQ" src="${ pageContext.servletContext.contextPath }/resources/images/FAQICONWriteReview.png"></a></td>
                    <td><a href="${ pageContext.servletContext.contextPath }/user/ucc/paycheckFqa?currentPage=1&searchValue=쿠폰"><img class="imgFAQ" src="${ pageContext.servletContext.contextPath }/resources/images/FAQICONCoupon.png"></a></td>                  
                  </tr>
                </tbody>
              </table>
            </div>

            <hr>
            <div>
            <h5><b>자주하는 질문 TOP5</b></h5>
              <table class="table board_table question_table">
                <colgroup>
                    <col width=""/>
                </colgroup>
                <tbody>
                	<c:forEach var="oftenFqaTop5" items="${ requestScope.oftenFqa }" begin="0" end="4">
                	<c:set var="i" value="${ i + 1 }" />
                    <tr class="click_qa">
                        <td class="tal"><c:out value="${ i } . ${ oftenFqaTop5.postTitle }"/></td>
                    </tr>
                    <tr class="answer tal">
                        <td><c:out value="${ oftenFqaTop5.postContent }"/> </td>
                    </tr>
                	</c:forEach>
                </tbody>
            </table>

          <script>
            $(".click_qa").on('click',function(e){
                $(event.currentTarget).next().toggle(300);
                
                // let show = e.next();
                // show.toggle();
                
              
            });
        </script>
        </div>
        <hr>
        
          <div class="containerF">
            <div class="row">
                <div class="col-sm-6">
                  <h5><b>공지사항</b></h5>
                </div>
                <div class="col-sm-6">
                  <button class="searchbutton">전체보기</button>
                </div>
            </div>
            <div class="row" id="notice">
              <ul>
              <c:forEach var = "importantNotice" items="${ requestScope.importantNotice }" begin="0" end="1">
                <br><li class="importantNotice2"><b><중요></b> <c:out value="${ importantNotice.postTitle }"/><input type="hidden" value="${ importantNotice.postNo }"></li>
              </c:forEach>
              <c:forEach var = "noticeBoard" items="${ requestScope.noticeMainCon }" begin="0" end="2">
              	<br><li class="recentNotice"><c:out value="${ noticeBoard.postTitle }"/><input type="hidden" value="${ noticeBoard.postNo }"></li>
              </c:forEach>
              </ul>
            </div>
        </div>
       <script>
       $('.searchbutton').click(function() {
    	   
    	   location.href = "${ pageContext.servletContext.contextPath }/user/ucc/uccNoticeSelect"
    			
		});
       
       if(document.getElementsByClassName('importantNotice2')) {
    	   const $importantlis = $('.importantNotice2');
    	   for(let i = 0; i <  $importantlis.length; i++) {
    		   $importantlis[i].onclick = function() {
				
	    		  let noticeAddress = this.lastChild.value;
	    		  location.href = "${ pageContext.servletContext.contextPath }/user/ucc/uccNoticeDetail?postNo=" + noticeAddress;
	    		  console.log(noticeAddress);
			   }
    		   
    	   }
       }
       
       if(document.getElementsByClassName('.recentNotice')) {
    	   const $recentlis = $('.recentNotice');
    	   for(let i = 0; i <  $recentlis.length; i++) {
    		   $recentlis[i].onclick = function() {
				
	    		  let noticeAddress = this.lastChild.value;
	    		  location.href = "${ pageContext.servletContext.contextPath }/user/ucc/uccNoticeDetail?postNo=" + noticeAddress;
	    		  console.log(noticeAddress);
			   }
    		   
    	   }
       }
       </script>
        
         
          </div>
        </div>
      </div>
    </section>

    <jsp:include page="../commons/footer.jsp"/>
  </body>
  </html>
