<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 발행</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/coupon.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

</head>
<body>
	<!-- 페이지가 로드되기 전에 메세지가 있으면 메세지에 대한 알럿을 띄워준다. // model을 requestScope 영역 안에서 사용된다. -->
<script>
	if(${ requestScope.message != null && requestScope.message != ''}){
		alert('${ requestScope.message }');
	}
</script>
	
	<!-- header -->
	<jsp:include page="../commons/header.jsp"/>

    <br><br><br>
    <div class="page-text" style="width: 1550px; margin: 0 auto;">
        <h3 style="margin-left: 100px; font-weight: 900;">쿠폰 발행</h3>
        <hr>
    </div>

    <div class="body-all">
        <div class="body-inside">
        
        <!-- sidebar  -->
        <jsp:include page="../commons/ownerSidebar.jsp"/>
        
        <div style="text-align: center;">
        <br><br>
        <img src="${ pageContext.servletContext.contextPath }/${ owner.ceo.store.storeImg }" width="300px"><br><br>
        <br><br>
        <div style="margin-left: 450px;" id="before">
        <h3 style="font-weight: 900; text-align: left; margin-left: 30px;">발행한 쿠폰</h3>
        <br>
        <form action="${ pageContext.servletContext.contextPath}/owner/couponDelete" method="POST">
        <table class="table table" style="width: 1050px;">
            <thead style="background-color: #EDEDED;">
              <tr>
                <th scope="col"><input type="checkbox"  id="allCheck"></th>
                <th scope="col">발행일</th>
                <th scope="col">쿠폰이름</th>
                <th scope="col">할인금액</th>
                <th scope="col">할인조건</th>
                <th scope="col">유효기간</th>
              </tr>
            </thead>
            <tbody>
			<c:forEach var="cp" items="${ coupon }">
              <tr>
                <th scope="row"><input type="checkbox" name="chkcoupon" value="${ cp.cpCode }"></th>
                <td>${ cp.startDate }</td>
                <td>${ cp.cpName }</td>
                <td>${ cp.disWon }</td>
                <td>${ cp.dCcon }</td>
                <td>${ cp.endDate }</td> 
              </tr>
             </c:forEach>
            </tbody>
          </table>
          <br><br>
          <!-- 모달쿠폰 -->
          <button type="button"  id="couponBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" style="height: 40px;">
            추가</button>
          <button id="couponBtn2" type="submit">삭제</button>
        </form>
        </div>  
      </div>
	    
		    <!-- 페이지네이션 -->
			<div style="margin-left: 450px; position: relative; top: 100px;">
			<jsp:include page="../commons/pagingWithoutSearch.jsp"/>
			</div>
			
	    </div>  
	    
	    <!-- 모오오오달 -->
	    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title" id="exampleModalLabel">쿠폰 추가</h5>
	          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	          </button>
	        </div>
	        <form action="${ pageContext.servletContext.contextPath }/owner/coupon" method="post">
	        <div class="modal-body" style="margin: 0 auto;">
	          <br>
	          <h4>쿠폰이름</h4><input type="text" name="cpName" min="0" placeholder="쿠폰이름을 작성해주세요"><br><br>
	          <h4>할인금액</h4><input type="number" min="0" name="disWon" style="width: 80px; "><h4>원</h4><br><br>
	          <h4>할인조건</h4><input type="number" min="0" name="dCcon" style="width: 80px"><h6>원 이상 사용 가능</h6><br><br>
	          <h4>유효기간</h4><input type="date" name="endDate">
	          <br><br>
	        </div>
	        <div class="modal-footer">
	          <button type="submit" class="btn btn-primary"  id="couponBtn" style="width: 100px;">추가하기</button>
	          <button type="reset" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        </div>
	        </form>
	      </div>
	    </div>
	    </div>
	  </div>
	  
	  <script>
	  $("#allCheck").click(function(){
	      if($("#allCheck").prop("checked")){
	        $("input[type=checkbox]").prop("checked",true);
	      } else{
	        $("input[type=checkbox]").prop("checked",false);
	      }
	    });
	  </script>
	  
	  <!-- footer -->
	  <jsp:include page="../commons/footer.jsp"/>
	  
</body>
</html>