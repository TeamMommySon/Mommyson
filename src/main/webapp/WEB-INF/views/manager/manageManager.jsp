<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>관리자 조회</title>
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
            <h1>관리자 관리</h1>
            <div class="top_box">
                <p>관리자 조회</p>
                <div class="top_btn">
                <input type="button" value="수정" class="rev_btn">
                <input type="button" value="삭제" class="del_btn" onclick="deleteManager();">
                <script>
                	// 관리자 삭제
                	function deleteManager() {
                		let cks = $("input:checkbox[name='ch1']:checked").val();
                		location.href='${ pageContext.servletContext.contextPath }/manager/updateManager/' + cks;
                	}
                </script>
                </div>
            </div>
            <hr>
            <div>
                <div>
                <table class="table">
                    <colgroup>
                        <col width=""/>
                        <col width=""/>
                        <col width=""/>
                        <col width=""/>
                        <col width=""/>
                    </colgroup>
                    <thead style="background-color: #EDEDED;">
                      <tr>
                        <th scope="row"><input type="checkbox" name="ch1"></th>
                        <th>관리권한</th>
                        <th>아이디</th>
                        <th>가입일</th>
                        <th>최근접속일</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th scope="row"><input type="checkbox" name="ch1"></th>
                        <td>
                        	슈퍼관리자
                        </td>
                        <td>${ sessionScope.loginMember.memId }</td>
                        <td>${ sessionScope.loginMember.enrollDate }</td>
                        <td>${ sessionScope.loginMember.manager.lastLogin }</td>
                      </tr>
                      <c:forEach items="${ requestScope.managerList }" var="managerList">
                      	  <tr>
	                        <th scope="row"><input type="checkbox" name="ch1" value="${ managerList.memCode }"></th>
	                        <td>
	                            <select class="manager">
	                            	<c:forEach items="${ requestScope.authList }" var="authList">
						   				<c:if test="${ managerList.manager.authDTO.auth == authList.auth }">
						   					<option value="${ authList.code }" selected>${ authList.auth }</option>
						   				</c:if>
						   				<c:if test="${ managerList.manager.authDTO.auth != authList.auth }">
						   					<option value="${ authList.code }">${ authList.auth }</option>
						   				</c:if>
						   			</c:forEach>
	                            </select>
	                            <input type="hidden" value="${ managerList.memCode }"/>
	                        </td>
	                        <td><c:out value="${ managerList.memId }"/></td>
	                        <td><c:out value="${ managerList.enrollDate }"/></td>
	                        <td><c:out value="${ managerList.manager.lastLogin }"/></td>
	                      </tr>
                      </c:forEach>
                      <script>
                        // 관리자 권한 수정
                        
                      	$('.manager').on('change', function(e) {
	                      	let selected = e.target.value;
                      		let memCode = e.target.nextElementSibling.value;
                      		$.ajax({
                      			url: '/mommyson/manager/manageManager',
                      			type: 'post',
                      			data: { 
                      				selected : selected,
                      				memCode : memCode
                      			},
                      			success: function(data) {
                      				console.log(data);
                      			}
                      		});
                      	});
                      </script>
                    </tbody>
                  </table>
                  <br><br>
                </div>
            </div>
            <!-- 페이징 -->
            <nav class="page_box" aria-label="Page navigation example">
                <ul class="pagination">
                  <li class="page-item"><a class="page-link-move" href="#">&laquo;</a></li>
                  <li class="page-item"><a class="page-link-move" href="#">&lt;</a></li>
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
                  <li class="page-item"><a class="page-link-move" href="#">&gt;</a></li>
                  <li class="page-item"><a class="page-link-move" href="#">&raquo;</a></li>
                </ul>
                <ul>
                    <img class="glass" src="${ pageContext.servletContext.contextPath }/resources/images/glass.png">
                    <input type="text" class="searchtext" placeholder="찾고싶은 게시물의 제목을 입력해주세요"></li>
                    <button type="submit" class="searchbutton">검색하기</button></li>
                 </ul>
              </nav>
        </div>
    </div>

    <jsp:include page="../commons/footer.jsp"></jsp:include>

    <script>
         $("#homeSubmenu6").addClass("show");
         $("#homeSubmenu6 > li:first-child > a").attr("style","color: #F89E91 !important");
    </script>
</body>
</html>