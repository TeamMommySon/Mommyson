<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/colorset.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/store_page.css">
</head>
<body>
    
    <jsp:include page="../commons/header.jsp"/>

    <section>
        <div class="at-container" style="position: relative; margin-top: 200px; display: flex; flex-direction: column; align-items: center;">
            <div class="store_logo" style="background: white;">
                <img src="${ pageContext.servletContext.contextPath }/${ requestScope.store.STORE_IMG }">
            </div>
            <div class="top">
                <!-- 찜, 평점 -->
                <div style="float: left;">
                    <div class="df-ac">
                    	<c:set var="jjimCount" value="0"/>
                    	<c:forEach items="${ requestScope.jjimList }" var="j">
                    		<c:if test="${ j == sessionScope.loginMember.memCode }">
                    			<c:set var="jjimCount" value="${ jjimCount + 1 }"/>
                    		</c:if>
                    	</c:forEach>
                    	<c:if test="${ jjimCount > 0 }">
	                        <button class="btn_none" onclick="jjim_plus('delete')"><img src="${ pageContext.servletContext.contextPath }/resources/images/heart.png" style="width: 35px; height: 35px;"></button>&nbsp;&nbsp;<h4 style="margin: 0;"><strong>찜</strong> ${ requestScope.store.JJIM }</h4>
                    	</c:if>
                    	<c:if test="${ jjimCount == 0 }">
	                        <button class="btn_none" onclick="jjim_plus('plus')"><img src="${ pageContext.servletContext.contextPath }/resources/images/whiteHeart.png" style="width: 35px; height: 35px;"></button>&nbsp;&nbsp;<h4 style="margin: 0;"><strong>찜</strong> ${ requestScope.store.JJIM }</h4>
                    	</c:if>
                    </div>
                    <script>
                    	function jjim_plus(str) {
                    		if(${ sessionScope.loginMember != null }) {
                    			let storeCode = '${ requestScope.store.MEM_CODE }';
                        		let memCode = '${ sessionScope.loginMember.memCode }';
                        		$.ajax({
                        			url: '${ pageContext.servletContext.contextPath }/user/jjim' + str,
                        			type: 'post',
                        			data: {
                        				storeCode : storeCode,
                        				memCode : memCode
                        			},
                        			success: function(data) {
                        				console.log(data)
                        				if(data == '삭제 완료') {
                        					location.reload();
                        				}
                        			}
                        		});
                    		} else {
                    			alert("로그인이 필요한 기능입니다.");
                    			location.href='${ pageContext.servletContext.contextPath }/member/login';
                    		}
                    	}
                    </script>
                    <br>
                    <div>
                        <span class="df-ac">
                        <!--  별점 -->
                            <div style="display: flex; justify-content: space-between; width: 150px;">
                                <c:if test="${ requestScope.store.GRADE == 0 }">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
									  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
									</svg>
                                </c:if>
                                <c:if test="${ requestScope.store.GRADE < 1.5 && requestScope.store.GRADE > 0 }">
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                </c:if>
                                <c:if test="${ requestScope.store.GRADE >= 1.5 && requestScope.store.GRADE < 2.5 }">
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                </c:if>
                                <c:if test="${ requestScope.store.GRADE >= 2.5 && requestScope.store.GRADE < 3.5 }">
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                </c:if>
                                <c:if test="${ requestScope.store.GRADE >= 3.5 && requestScope.store.GRADE < 4.5 }">
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                </c:if>
                                <c:if test="${ requestScope.store.GRADE >= 4.5 }">
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
	                                  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
	                                </svg>
                                </c:if>
                            </div>
                            &nbsp;&nbsp;<h4 style="margin: 0;">${ requestScope.store.GRADE }</h4>
                        </span>
                    </div>
                </div>
                <!-- 가게정보, 전화, 신고 -->
                <div>
                    <div>
                        <a href="${ pageContext.servletContext.contextPath }/user/storeInfo?memCode=${ requestScope.store.MEM_CODE }"><h4><strong>가게정보</strong></h4></a>
                    </div>
                    <div style="display: flex; justify-content: space-between; width: 400px;">
                        <div><h4><strong>전화 :</strong>&nbsp;${ requestScope.store.PHONE }</h4></div>
                        <div></div>
                    </div>
                </div>
            </div>
            
            <!-- 신고 모달 -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">리뷰 신고</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
	                <div class="modal-body">
	                    <div class="form-group">
	                        <label for="recipient-name" class="col-form-label">신고유형</label>
	                        <select id="reportType" name="reportType">
	                        	<option value="1">도배성 글</option>
	                        	<option value="2">욕설/폭언</option>
	                        	<option value="3">악성 리뷰</option>
	                        	<option value="4">광고성 리뷰</option>
	                        </select>
	                        <input type="hidden" id="rvCode" name="rvCode">
	                    </div>
    	            </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	                    <button type="submit" id="addReport" class="btn btn-primary">신고하기</button>
	                </div>
	                <script>
	                	$('#addReport').on('click',function() {
	                		let reportType = $('#reportType').val();
	                		let rvCodee = $('#rvCode').val();
	                		
	                		
	                		$.ajax({
	                			url: '${ pageContext.servletContext.contextPath }/user/report',
	                			data: {
	                				reportType : reportType,
	                				rvCodee : rvCodee
	                			},
	                			type: 'post',
	                			success: function(data) {
	                				if(data == 1) {
	                					alert('신고 완료!');
	                					location.reload();
	                				} else {
	                					alert('신고가 정상 처리되지 않았습니다.');
	                					location.reload();
	                				}
	                			}
	                		})
	                	})
	                </script>
                </div>
            </div>
            </div>
            
            
            <div class="bottom">
                <div class="menu_box">
                    <h1 style="margin-bottom: 70px;">오늘만 할인</h1>
                    <!-- 세일 메뉴 div -->
                    <c:set value="0" var="count"/>
                    <c:forEach items="${ requestScope.products }" var="product">
	                    <c:if test="${ product.discountRate > 0 }">
	                    	<div class="sail_menu">
		                        <div class="menu_img">
		                            <img src="${ pageContext.servletContext.contextPath }/${ product.sdImg }">
		                        </div>
		                        <div>
		                            <h3 style="margin-bottom: 20px;"><c:out value="${ product.sdName }"/></h3>
		                            <p style="width: 450px;"><c:out value="${ product.detail }"/></p>
		                        </div>
		                        <div style="display: flex; align-items: flex-end;">
		                            <c:if test="${ product.orderableStatus == 'Y' }">
			                            <h3 style="margin-right: 20px; margin-bottom: 7px;"><c:out value="${ product.price }"/> 원</h3>
		                            </c:if>
		                            <c:if test="${ product.orderableStatus == 'N' }">
			                            <h3 style="margin-right: 20px; margin-bottom: 7px;"><c:out value="${ product.price }"/> 원</h3>
		                            </c:if>
		                            <button class="pink_btn" style="width: 80px" value="${ product.sdCode }">담기</button>
		                        </div>
		                        <c:set var="count" value="${ count + 1 }"></c:set>
		                    </div>
	                    </c:if>
                    </c:forEach>
                    <c:if test="${ count == 0 }">
                    	<h3 align="center" style="margin-bottom: 100px;">오늘은 할인 상품이 없습니다</h3>
                    </c:if>

                    <!-- 반찬 종류 div -->
                    <h1 style="margin-bottom: 70px;">반찬 종류</h1>
                    <c:forEach items="${ requestScope.products }" var="product">
	                    <c:if test="${ product.discountRate == 0 }">
		                    <div class="sail_menu" style="align-items: center; margin-top: 18px;">
		                        <div><h3><strong>${ product.sdName }</strong></h3></div>
		                        <div><p>${ product.detail }</p></div>
		                        <div style="display: flex; align-itmes: flex-end;"><h3 style="margin-right: 20px;">${ product.price } 원</h3><button class="pink_btn" style="width: 80px" value="${ product.sdCode }">담기</button></div>
		                    </div>
	                    </c:if>
                    </c:forEach>

				    <script>
						 // 신고버튼 스크립트
				      	$('#reportBtn').on('click',function(e) {
				      		let rvCode = this.value;
				      		$('#rvCode').val(rvCode);	
				      	});
						 
						 function insertReport(e) {
							 let rvCode = e.value;
				      		$('#rvCode').val(rvCode);
						 }
				    
				      	// 장바구니 담는 페이지로 이동
				      	$('.pink_btn').on('click', function(e) {
				      		if(${ sessionScope.loginMember != null }) {
				      			let sdCode = e.target.value;
				          		location.href = '${ pageContext.servletContext.contextPath }/user/sidedish_detail?sdCode=' + sdCode + '&memCode=${ requestScope.store.MEM_CODE }';
				      		} else {
				      			alert('로그인이 필요한 서비스입니다.');
				      			location.href = '${ pageContext.servletContext.contextPath }/member/login';
				      		}
				      	});
				      	
				    </script>
                    <!-- 리뷰 -->
                    <div style="display: flex; justify-content: space-between; align-items: center; width: 100%; padding: 0px 40px 0px 40px;">
                        <h1 style="margin-bottom: 70px; margin-top: 100px; border-bottom: 1px solid black;">리뷰</h1>
                        <div></div>
                    </div>
                    <c:forEach items="${ requestScope.rvList }" var="rv">
	                    <div class="review">
	                        <!-- 리뷰 사진 -->
	                        <div class="review_img">
	                            <img src="${ pageContext.servletContext.contextPath }/${ rv.img }">
	                        </div>
	                        <!-- 컨텐츠 -->
	                        <div class="review_contents">
	                            <div style="display: flex; justify-content: space-between; align-items: flex-end;">
	                                <div>
	                                	<c:forEach var="grade" begin="1" end="${ rv.grade }">
		                                	<svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
			                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
			                                </svg>
		                                </c:forEach>
	                                </div>
	                                <div class="df-ac">&nbsp;<button id="reportBtn" onclick="insertReport(this)" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" style="background-color: white; border: none;" value="${ rv.rvCode }"><img src="${ pageContext.servletContext.contextPath }/resources/images/reportbtn.png" style="width: 40px; height: 40px;"></button></div>
	                            </div>
	                            <div class="review_text">
	                                <p>
	                                    ${ rv.content } 
	                                </p>
	                            </div>
	                            <div class="review_name" style="display: flex; justify-content: space-between;">
	                                <p>주문한 반찬 : <c:forEach items="${ rv.orderList }" var="list" varStatus="status">${ list } <c:if test="${ !status.last }">, </c:if></c:forEach></p>
	                                <p>작성자  ${ rv.memId }</p>
	                            </div>
	                        </div>
	                    </div>
                    </c:forEach>

                    <jsp:include page="../commons/pagingWithoutSearch.jsp"/>
                </div>
            </div>
        </div>
        <c:if test="${ sessionScope.loginMember != null && sessionScope.loginMember.memType == 'user' }">
        	<div id="cart_logo">
        		<c:if test="${ sessionScope.cartCount != 0 }">
        			<div style="background: #FFF9C2; width: 23px; height: 23px; border-radius: 50%; position: relative; top: 26px; color: black; display: flex; align-items: center; justify-content: center;">
        				${ sessionScope.cartCount }
        			</div>
        		</c:if>
        		<button onclick="location.href='${ pageContext.servletContext.contextPath }/user/cart'"><img class="store_logo" src="${ pageContext.servletContext.contextPath }/resources/images/cart_logo.png"></button>
        	</div>
        </c:if>
    </section>

    <jsp:include page="../commons/footer.jsp"/>
</body>
</html>