<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/coupon.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>   
<title>일별 매출</title>
</head>
<body>
	<!-- header -->
	<jsp:include page="../commons/header.jsp"/>
	
	<br><br><br>
    <div class="page-text" style="width: 1550px; margin: 0 auto;">
        <h3 style="margin-left: 150px; font-weight: 900; font-size: 40px;">일별 매출</h3>
        <hr>
    </div>
	
	 <div class="body-all">
        <div class="body-inside">
        
        <!-- sidebar  -->
      <jsp:include page="../commons/ownerSidebar.jsp"/>
      
      <div>
      <br>
      <h2 style="text-align: center;">일별 매출</h2>
      <br><br><br>
      <form action="">
      <div style="float: right;"> 
      <p style="float: left; margin-right: 15px; font-weight: 700;">조회 일자 &nbsp;&nbsp;&nbsp;<input type="date" min="" id=""></p>
      <p style="float: left;margin-right: 15px;">~ &nbsp;&nbsp;<input type="date" min="" id=""></p>
      <button type="submit" class="couponBtn" style="width: 80px; margin-top: 2px;">조회하기</button>
      </div>
    </form>
    <br><br>
    </div>
    <br>
    <div style="text-align: center;">
        <div style="margin-left: 450px;">
        <table class="table table" style="width: 1050px;">
            <thead style="background-color: #EDEDED;">
              <tr>
                <th scope="col">일자</th>
                <th scope="col">포장 판매액</th>
                <th scope="col">배달 판매액</th>
                <th scope="col">총 매출</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">2021-11-11일</th>
                <td>8,000원</td>
                <td>15,000원</td>
                <td style="font-weight: 700;">23,000원</td>
              </tr>
              <tr>
                <th scope="row">2021-11-12일</th>
                <td>30,000원</td>
                <td>50,000원</td>
                <td style="font-weight: 700;">80,000원</td>
              </tr>
              <tr>
                <th scope="row">2021-11-13일</th>
                <td>60,000원</td>
                <td>27,000원</td>
                <td style="font-weight: 700;">87,000원</td>
              </tr>
            </tbody>
          </table>
        </div>
        </div>
        <br><br><br><br>
        <jsp:include page="../commons/paging.jsp"/>
      </div>
    </div>  
    
    <!-- footer -->
  <jsp:include page="../commons/footer.jsp"/>
	
</body>
</html>