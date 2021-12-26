<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/coupon.css">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/owners.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>     
<title>판매상품 관리</title>
</head>
<body>
<script>
	if(${ requestScope.message != null && requestScope.message != ''}){
		alert('${ requestScope.message }');
	}
</script>
	<!-- header -->
	<jsp:include page="../commons/header.jsp"/>
	
	<br><br><br>
    <div class="page-text" style="width: 1550px; margin: 0 auto;">
        <h2 style="margin-left: 100px; font-weight: 900;">판매 상품 관리</h2>
        <hr>
    </div>
	
	<div class="body-all">
      <div class="body-inside">
      
     <!-- sidebar  -->
      <jsp:include page="../commons/ownerSidebar.jsp"/>
      <br><br><br>
      <div style="text-align: center; float: right; margin-bottom: 150px;">
        <div>
        <form action="${ pageContext.servletContext.contextPath }/owner/productManagement" method="get" id="frm">
	      <div style="margin-bottom: 20px; float: right; clear: right;"> 
		     <p style="float: left; margin-right: 15px; font-weight: 700;">제조일 &nbsp;&nbsp;&nbsp;<input type="date" name="mDate" id="mDate" value="${ searchMap.mDate }"></p>
		     <p style="float: left;margin-right: 15px;">~ &nbsp;&nbsp;<input type="date" name="mDate2" id="mDate2" value="${ searchMap.mDate2 }"></p>
		     <button type="submit" class="couponBtn" style="width: 80px; margin-top: 2px;">조회하기</button>
		  </div>
		  <div style="margin-bottom: 20px; float: right; clear: right;"> 
		     <p style="float: left; margin-right: 15px; font-weight: 700;">유통기한 &nbsp;&nbsp;&nbsp;<input type="date" name="eDate" id="eDate" value="${ searchMap.eDate }"></p>
		     <p style="float: left;margin-right: 15px;">~ &nbsp;&nbsp;<input type="date" name="eDate2" id="eDate2" value="${ searchMap.eDate2 }"></p>
		     <button type="submit" class="couponBtn" style="width: 80px; margin-top: 2px;">조회하기</button>
		  </div>
		  <div style="margin-bottom: 20px; float: right; clear: right;"> 
		      <p style="float: left; font-weight: 700; margin-right: 15px;">판매여부 &nbsp;&nbsp;
		      	<select id="status" name="status" >
		      		<option value="all">전체</option>
		      		<option value="Y">판매</option>
		      		<option value="N">판매중단</option>
		     	</select>
		      </p>
		      <button id="clear" class="couponBtn" style="width: 80px; margin-top: 2px; ">초기화</button>
	      </div>
	    </form>
        <table class="table table" style="width: 1050px; clear: right;">
            <thead style="background-color: #EDEDED;">
              <tr>
                <th scope="col"><input type="checkbox" id="allCheck"></th>
                <th scope="col">번호</th>
                <th scope="col">상품</th>
                <th scope="col">제조일</th>
                <th scope="col">유통기한</th>
                <th scope="col">판매여부</th>
                <th scope="col">상세보기</th>
              </tr>
            </thead>
            <tbody>
            
            <c:if test="${ !empty productList }">
              <c:forEach var="list" items="${ productList }">
              <c:set var="i" value="${ i + 1 }"/>
              <c:set var="j" value="${ (requestScope.pagination.pageNo / 2) * 10 }"/>
              <fmt:parseNumber var="page" integerOnly="true" value="${ j }"/>
              <tr>
                <th scope="col"><input type="checkbox" name="deleteCode" value="${ list.sdCode }" id="deleteCode"></th>
                <c:if test="${ requestScope.pagination.pageNo > 1 }">
                <th scope="row">${ i + page }</th>
                </c:if>
                <c:if test="${ requestScope.pagination.pageNo <= 1 }">
                <th scope="row">${ i }</th>
                </c:if>
                <td><a href="${ pageContext.servletContext.contextPath }/owner/modifyProduct?sdCode=${ list.sdCode }">${ list.sdName }</a></td>
                <td>${ list.mDate }</td>
                <td>${ list.eDate }</td>
                <td>
	               	<c:if test="${ list.orderableStatus eq 'N' }">
	                <button class="couponBtn btn1" id="btn1" name="sdCode" value="${ list.sdCode }">판매하기</button>
	                </c:if>
	                
	                <c:if test="${ list.orderableStatus eq 'Y' }">
	                <button class="couponBtn btn1" id="btn1" name="sdCode" value="${ list.sdCode }" style="background-color : #777777;">판매중</button>
	                </c:if>
	                
	                <c:if test="${ list.orderableStatus eq 'X' }">
	                <button class="couponBtn btn2" id="btn1" name="sdCode" value="${ list.sdCode }" style="background-color : #E72E13; width:110px; ">유통기한 지남</button>
	                </c:if>
                </td>
                <td><a href="${ pageContext.servletContext.contextPath }/owner/modifyProduct?sdCode=${ list.sdCode }">상세보기</a></td>
              </tr>
              </c:forEach>
              </c:if>
              
              <c:if test="${ empty productList }">
              <tr>
              	<td colspan="7" style="font-weight: 700; font-size: 20px; padding-top : 70px;">등록된 상품이 없습니다.</td>
              </tr>	
              </c:if>
              
            </tbody>
          </table>
        </div>
        <div style="float: right; margin: 20px 30px 0 0;">
          <button class="couponBtn" id="delete" style="background-color: #777777; height: 30px; width: 80px">삭제</button>
        </div>
        </div>
        <jsp:include page="../commons/ownerPaging.jsp"/>
      </div>  
    </div>
	<script>
	    $(".btn1").click(function(e){
	    	
	    	let sdCode = e.target.value;
	    	console.log(sdCode);
	    	
	    	let form = $('<form></form>');
	        form.attr('action', '${pageContext.servletContext.contextPath}/owner/productManagement');
	        form.attr('method', 'post');
	        form.appendTo('body');
	        form.append($('<input type="hidden" value="' + sdCode + '" name=sdCode>'));
	        form.submit();
	     
	    });
	
	    $("#allCheck").click(function(){
	      if($("#allCheck").prop("checked")){
	        $("input[type=checkbox]").prop("checked",true);
	      } else{
	        $("input[type=checkbox]").prop("checked",false);
	      }
	    });
	    
	    $("#delete").click(function(){
	    	
	    	let arr = [];
	    	$('input:checkbox[name=deleteCode]:checked').each(function(){
	    		let value = $(this).val();
	    		arr.push(value);
	    	})
	    	
	    	console.log(arr);
	    	
	    	let form = $('<form></form>');
	        form.attr('action', '${pageContext.servletContext.contextPath}/owner/productManagement');
	        form.attr('method', 'post');
	        form.appendTo('body');
	        form.append($('<input type="hidden" value="' + arr + '" name=deleteCode>'));
	        form.submit(); 
	    	
	    });
	    
	    $('.btn2').on('click',function(e){
	    	
	    	if(!alert('유통기한이 지난 상품입니다. 유통기한을 변경하여주세요.')){
	    		
	    		let sdCode = e.target.value;
	    		
	    		console.log(sdCode);
	    		
	    		location.href = '${ pageContext.servletContext.contextPath }/owner/modifyProduct?sdCode=' + sdCode
	    		
	    	}
	    	
	    });
	    
	    $(".searchtext").attr("placeholder","검색할 상품명을 입력해주세요");
	    
	    $("#status").change(function(){
	    	$("#frm").submit();
	    });
	    
	    $("#clear").click(function(){
	    	$("#eDate").val("");
	    	$("#eDate2").val("");
	    	$("#mDate").val("");
	    	$("#mDate2").val("");
	    	$('#status').val("");
	    	$("#frm").submit();
	    });
	    
	    if(${ searchMap.status != null && searchMap.status != '' } ){
	    	$('#status').val('${ searchMap.status}');
	    }
	    
	</script>  
	
	<!-- footer -->
	 <jsp:include page="../commons/footer.jsp"/>
	
</body>
</html>