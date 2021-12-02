<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>
<body>
   <jsp:include page="../commons/header.jsp"></jsp:include>

    <section>

      <div class="container">
        <div class="row">
          <div class="col-md-3">
            <nav id="sidebar">
              <div class="sidebar-header">
                  <h3>마이페이지</h3>
              </div>
  
              <ul class="list-unstyled components">
                  <li>
                      <a href="#">주문내역</a>
                  </li>                 
                  <li>
                      <a href="#">개인정보변경</a>
                  </li>
                  <li>
                      <a href="#">회원탈퇴</a>
                  </li>
                  <li>
                    <a href="#">쿠폰함</a>
                </li>
                <li>
                  <a href="#">내가 쓴 리뷰</a>
              </li>
              <li>
                <a href="#">자주찾는가게</a>
              </li>
              <li>
                <a href="#">나의 신고 내역</a>
              </li>
              </ul>
              
          </nav>
          <!-- <img src="${ pageContext.servletContext.contextPath }/resources/images/customerServiceImg.png" id="customerguide"> -->
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
                  <th id="tablecol0"></th><!-- 체크 박스 -->
                  <th id="tablecol1" scope="col">가게 정보</th>
                  <th id="tablecol2" scope="col"></th><!-- 제품 이미지 -->        
                  <th id="tablecol3" scope="col">제품정보</th>        
                  <th id="tablecol4" scope="col">제품금액</th>        
                  <th id="tablecol5" scope="col">수량</th>        
                  <th id="tablecol6" scope="col">수령일자</th>        
                  <th id="tablecol7" scope="col">구매금액</th>      
                  <th id="tablecol8" scope="col"></th><!-- 리뷰쓰기 버튼// 접수상테(배달이완료되고 나서 뜨도록) -->     
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td style="padding-top: 40px;"><input type="checkbox" name="choose" style="width: 20px; height: 20px;"></td>
                  <td><img class="storeimg" src="${ pageContext.servletContext.contextPath }/resources/images/1 2.png"></td>
                  <td><img class="storeimg" src="${ pageContext.servletContext.contextPath }/resources/images/8 (1).png"></td>
                  <td style="padding-top: 40px;">새 물고기 구이</td>
                  <td style="padding-top: 40px;">10000원</td>
                  <td style="padding-top: 40px;"><p id="ea">1</p></td><!--추후 수량 표시-->
                  <td style="padding-top: 40px;">2021-11-24</td>
                  <td style="padding-top: 40px;">9000원</td>
                  <!-- <td style="padding-top: 40px;"><button class="urBtn">리뷰쓰기</button></td> -->
                  <td style="padding-top: 40px;"></td>
                  <!-- 주문접수가 완료 되면 위의 리뷰쓰기 버튼이 뜨도록 만든다 동시에  주문이 접수되면 체크박스가 비활성화 되도록 만든다.(주문취소버튼이 의미없도록)  -->
                </tr>
                
              </tbody>
            </table>
            <div>
              <button class="urBtn" style="margin-left: 970px;">주문취소</button>
            </div>
              <div>
                <!-- 페이징 -->
                <nav class="page_box" aria-label="Page navigation example">
                  <ul class="pagination">
                    <li class="page-item"><a class="page-link-num" href="#">&laquo;</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">&lt;</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">1</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">2</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">3</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">4</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">5</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">6</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">7</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">8</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">9</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">10</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">&gt;</a></li>
                    <li class="page-item"><a class="page-link-num" href="#">&raquo;</a></li>
                  </ul>
                  <ul>
                      <img class="glass" src="${ pageContext.servletContext.contextPath }/resources/images/glass.png">
                      <input type="text" class="searchtext" placeholder="찾고싶은 품목의 이름을 입력해주세요."></li>
                      <button type="submit" class="searchbutton">검색하기</button></li>
                   </ul>
                </nav>

              </div>

            
            
          </div>
        </div>
      </div>
    </section>
    <script>
      $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
            });
        });
    </script>



      <footer class="at-container">
        <ul class="df_ul ft_list">
          <li>
            <a href="">마미손맛 소개</a>   
          </li>
          <li>
            <a href="">이용약관</a>
          </li>
          <li>
            <a href="">개인정보처리방침</a>
          </li>
          <li>
            <a href="">전자금융거래이용약관</a>
          </li>
        </ul>
        <div class="ft_img_line">
          <img src="${ pageContext.servletContext.contextPath }/resources/images/ft_img01.png" alt="소비자중심경영">
        <img src="${ pageContext.servletContext.contextPath }/resources/images/ft_img02.png" alt="정보보호 관리체계 인증">
        <img src="${ pageContext.servletContext.contextPath }/resources/images/kakaopay.png" alt="KakaoPay" class="kakaopay">
      </div>
      <div class="ft_info">
        <p>(주)마미손맛 자세히 보기</p>
        <p>대표 : 유승제 / 주소 : 서울특별시 서초구 서초대로78길 48 송림빌딩 13층</p>
        <p>사업자번호 : 123-45-67890 / 통신판매업신고 : 제 2021-서울-503호 / 개인정보 정책 및 담당 : 김준희</p>
        <p>대표번호 : 1588-0000 / 팩스번호 : 02-123-1234 / 이메일 : mommysonmat@greedy.com</p>
        <p>ⓒ SSEULEODAMJO CORP. All Rights Reserved.</p>
      </div>
    </footer>
  </body>
  </html>
