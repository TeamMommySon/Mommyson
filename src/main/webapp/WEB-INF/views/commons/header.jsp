<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>header</title>
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</head>
<body>
    <header class="header at-container">
      <div class="headerTop">
        <div class="headerBody">
          <a href="${ pageContext.servletContext.contextPath }/"><img src="${ pageContext.servletContext.contextPath }/resources/images/mainlogo.png" style="width: 300px;"></a>
          <br><br><br>
            <div class="bodyLeft" style="display: block;">
                <ul class="df_ul headerItem">
                <!-- 로그인 후 -->
                <c:if test="${ sessionScope.loginMember != null }">
                   <!-- 소비자의 경우 -->
                	<c:if test="${ sessionScope.loginMember.memType == 'user' }">
                   		<li id="ca_lo">
                    		<a href="${ pageContext.servletContext.contextPath }/user/cart">장바구니</a>
                  		</li>
                 		 <li>
                  			<a href="${ pageContext.servletContext.contextPath }/userMyPage/"><img style="height: 25px; margin-right: 10px;" src="${ pageContext.servletContext.contextPath }/resources/images/profile.png">${ sessionScope.loginMember.nickname}</a>
                  		</li>
                  		<li>
                    		<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
							  <div class="btn-group" role="group">
							    <button id="btnGroupDrop1" type="button" style="background: none; border: none; outline: none;" class="dropdown" data-toggle="dropdown" aria-expanded="false">
							      <c:if test="${ empty sessionScope.noticeList }">
								      <img style="width: 28px;" id="bell" src="${ pageContext.servletContext.contextPath }/resources/images/bella.png">
							      </c:if>
							      <c:if test="${ !empty sessionScope.noticeList }">
								      <img style="width: 28px;" id="bell" src="${ pageContext.servletContext.contextPath }/resources/images/inkedbell.png">
							      </c:if>
							    </button>
							    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="btnGroupDrop1" style="width: 450px; min-height: 60px;">
							      <c:forEach items="${ sessionScope.noticeList }" var="notice">
								      <div style="display: flex; justify-content: space-between; align-items: center;">
									      <a class="dropdown-item" href="#">${ notice.noticeContent }</a>
									      <p style="width: 150px;"><fmt:formatDate pattern="MM/dd HH:mm" value="${ notice.noticeTime }"/></p>
									      <button value="${ notice.noticeCode }" style="background: none; border: none; outline: none; margin-right: 10px;" onclick="deleteNotice(this)">x</button>
								      </div>
							      </c:forEach>
							    </div>
							  </div>
							</div>
                  		</li>
                   </c:if>
                   
                   <!-- 사업자인 경우 -->
                    <c:if test="${ sessionScope.loginMember.memType == 'ceo' }">
                    	<li>
                    		<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
							  <div class="btn-group" role="group">
							    <button id="btnGroupDrop1" type="button" style="background: none; border: none; outline: none;" class="dropdown" data-toggle="dropdown" aria-expanded="false">
							      <c:if test="${ empty sessionScope.noticeList }">
								      <img style="width: 28px;" src="${ pageContext.servletContext.contextPath }/resources/images/bella.png">
							      </c:if>
							      <c:if test="${ !empty sessionScope.noticeList }">
								      <img style="width: 28px;" src="${ pageContext.servletContext.contextPath }/resources/images/inkedbell.png">
							      </c:if>
							    </button>
							    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="btnGroupDrop1" style="width: 450px; min-height: 60px;">
							      <c:forEach items="${ sessionScope.noticeList }" var="notice">
								      <div style="display: flex; justify-content: space-between; align-items: center;">
									      <a class="dropdown-item" href="${ pageContext.servletContext.contextPath }/owner/order">${ notice.noticeContent }</a>
									      <p style="width: 150px;"><fmt:formatDate pattern="MM/dd HH:mm" value="${ notice.noticeTime }"/></p>
									      <button value="${ notice.noticeCode }" style="background: none; border: none; outline: none; margin-right: 10px;" onclick="deleteNotice(this)">x</button>
								      </div>
							      </c:forEach>
							    </div>
							  </div>
							</div>
                  		</li>
                   		<li>
                    		<a id="ck" href="${ pageContext.servletContext.contextPath }/owner/ownerMain"><img style="height: 25px; margin-right: 5px; margin-bottom: 10px;" 
                    		src="${ pageContext.servletContext.contextPath }/resources/images/ceoprofile.png">${ sessionScope.loginMember.ceo.store.storeName }</a>
                    	</li>
                    </c:if>
                    <script>
                    	// 알림 삭제
                    	function deleteNotice(e) {
                    		let noticeCode = e.value;
                    		$.ajax({
                    			url: '${ pageContext.servletContext.contextPath }/member/deleteNotice',
                    			type: 'post',
                    			data: {
                    				noticeCode : noticeCode
                    			},
                    			success: function(data) {
                    				location.reload();
                    			}
                    		})
                    	}
                    </script>
                    <!-- 관리자의 경우 -->
                    <c:if test="${ sessionScope.loginMember.memType == 'manager' }">
	                  	<li>
	                    	<a href="${ pageContext.servletContext.contextPath }/manager/normalMember">관리페이지</a>
	                  	</li>
                    </c:if> 
                    	<li style="margin-bottom: 5px;">
                    		<a href="${ pageContext.servletContext.contextPath }/member/logout" >로그아웃</a>
                 	   </li>
                  </c:if> 
                <!-- 로그인 전 -->
                <c:if test="${ sessionScope.loginMember == null }">
                  <li>
                    <a  href="${ pageContext.servletContext.contextPath }/member/login">로그인</a>
                  </li>
                  <li >
                    <a href="${ pageContext.servletContext.contextPath }/member/join">회원가입</a>
                  </li>
                </c:if>
                
              </ul>
          </div>
        </div>
      </div>  
    </header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light at-container" style="margin: 0 auto;">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown" style="margin-right: 180px;">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-expanded="false" style="margin-left: 50px; font-weight: 700; color: black">
                	전체 카테고리
                </a>
            <script>
	            $(function() {
	        	// 카테고리 리스트 불러오기
	        	$('#categoryList').append(
	        				'<div class="col-2">' +
	        		<c:forEach items="${ sessionScope.categoryList }" var="categoryList" end="3">
        					'<a href="${ pageContext.servletContext.contextPath }/user/category/?category=${ categoryList.CATEGORY_CODE }">' + '<c:out value = "${ categoryList.CATEGORY_NAME }"/>' + '</a>' +
	        		</c:forEach>
	        				'</div>' +
	        				'<div class="col-1"></div>'
	        		);
	        	
	        	$('#categoryList').append(
	        				'<div class="col-2">' +
	        		<c:forEach items="${ sessionScope.categoryList }" var="categoryList" begin="4" end="7">
        					'<a href="${ pageContext.servletContext.contextPath }/user/category/?category=${ categoryList.CATEGORY_CODE }">' + '<c:out value = "${ categoryList.CATEGORY_NAME }"/>' + '</a>' +
	        		</c:forEach>
	        				'</div>' +
	        				'<div class="col-1"></div>'
	        		);
	        	
	        	$('#categoryList').append(
	        				'<div class="col-2">' +
	        		<c:forEach items="${ sessionScope.categoryList }" var="categoryList" begin="8" end="11">
        					'<a href="${ pageContext.servletContext.contextPath }/user/category/?category=${ categoryList.CATEGORY_CODE }">' + '<c:out value = "${ categoryList.CATEGORY_NAME }"/>' + '</a>' +
	        		</c:forEach>
	        				'</div>' +
	        				'<div class="col-1"></div>'
	        		);
	        	
	        	$('#categoryList').append(
	        				'<div class="col-2">' +
	        		<c:forEach items="${ sessionScope.categoryList }" var="categoryList" begin="12" end="15">
        					'<a href="${ pageContext.servletContext.contextPath }/user/category/?category=${ categoryList.CATEGORY_CODE }">' + '<c:out value = "${ categoryList.CATEGORY_NAME }"/>' + '</a>' +
	        		</c:forEach>
	        				'</div>' +
	        				'<div class="col-1"></div>'
	        		);
	    		})
            </script>
            
            <div class="dropdown-menu">
                <div class="dropdown-content" aria-labelledby="navbarDropdown">
                <!-- 카테고리 리스트 -->
                    <div class="row" id="categoryList">
                    </div>
                </div>
            </div>
            </li>
            <li><a href="${ pageContext.servletContext.contextPath }/user/category?category=recommend">오늘의 추천</a></li>
            <li><a href="${ pageContext.servletContext.contextPath }/user/famousStore?type=famous">우리동네 인기 맛집</a></li>
            <li><a href="${ pageContext.servletContext.contextPath }/user/sale">오늘만 할인</a></li>
            <li><a href="${ pageContext.servletContext.contextPath }/user/famousStore?type=new">신규 반찬 가게</a></li>
          </ul>
          <form action="${ pageContext.servletContext.contextPath }/user/searchResult" method="post" style="display: flex; width: 350px;">
	          <input class="form-control mr-sm-2" id="search" name="searchValue" type="search" placeholder="# 혹은 이름으로 검색해주세요" aria-label="Search">
	          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
          </form>
        </div>
        <!-- 태그 div -->
    	<div id="tags" style="display: none;">
	    	<div style="display: flex; justify-content: space-between; width: 100%; margin: 10px;">
	    	<c:forEach items="${ sessionScope.tagList }" var="tag" end="4">
		       <button type="button" class="tag" name="searchValue" value="${ tag.tagNo }">#${ tag.tagName }</button>
	    	</c:forEach>
	        </div>
	    	<div style="display: flex; justify-content: space-between; width: 100%; margin: 10px;">
    		<c:forEach items="${ sessionScope.tagList }" var="tag" begin="5" end="9">
	       	   <button type="button" class="tag" name="searchValue" value="${ tag.tagNo }">#${ tag.tagName }</button>
    		</c:forEach>
	        </div>
	    	<div style="display: flex; justify-content: space-between; width: 100%; margin: 10px;">
    		<c:forEach items="${ sessionScope.tagList }" var="tag" begin="10">
		       <button type="button" class="tag" name="searchValue" value="${ tag.tagNo }">#${ tag.tagName }</button>
	    	</c:forEach>
	        </div>
		</div>    
      </nav>
    	
      <script>
        // 태그 div 출력 이벤트
        $('#search').on('keyup', function() {
          let text = $('#search').val();
          if(text.charAt(text.length-1) == '#') {
           $('#tags').css('display', 'block');
          } else {
           $('#tags').css('display', 'none');
          }
        });

        // 태그 클릭 이벤트
        $('.tag').on('click',function(e) {
         
         let text = $('#search').val();
         let index = text.lastIndexOf('#');
         let replace = text.replaceAt(index, e.target.innerText + ",");
         $('#search').val(replace);
         $('#tags').css('display', 'none');
         $('#search').focus();
        });
        
        $('#ck').on('click',function(){
        	
        	if(${ sessionScope.membership == null && sessionScope.membership == "" }){
        		if(alert('이용권을 구매 후 사용하실 수 있습니다.')){
        			location.href = '${ pageContext.servletContext.contextPath }/owner/ownerPay'
        		}
        	}
        	
        });

        String.prototype.replaceAt=function(index, character) {
          return this.substr(0, index) + character + this.substr(index+character.length); 
        }
        
      </script>
</body>
</html>