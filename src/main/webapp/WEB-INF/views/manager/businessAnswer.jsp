<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>사업자 1:1문의</title>
</head>
<body>
	<header class="manager_header at-container">
		<img
			src="${ pageContext.servletContext.contextPath }/resources/images/managerLogo.png"
			alt="마미손맛 MANAGEMENT"> <a href="../main.html" class="home_btn">
			<img
			src="${ pageContext.servletContext.contextPath }/resources/images/mainHome.png"
			alt="메인화면으로">
			<p>메인화면으로</p>
		</a>
	</header>
	<div class="head_line"></div>
	<div class="at-container total_container">

		<jsp:include page="../commons/managerSidebar.jsp"/>
        <div class="board_container">
            <h1>1:1문의</h1>
            <hr style="border-bottom: 1px solid #808080;">
            <div class="top_box">
                <p>사업자 문의</p>
            </div>
            <form action="${ pageContext.servletContext.contextPath }/manager/registBusinessAnswer" method="post" enctype="multipart/form-data">
            <c:set value="${ requestScope.businessQuestion }" var="bq"/>
                <table class="table bd_write_header bd_bottom_line">
                    <colgroup>
                        <col width="10%"/>
                        <col width="30%"/>
                        <col width="10%"/>
                        <col width="20%"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="green_area">제목</th>
                            <td colspan="3">
                               <c:out value="${ bq.postTitle }"/>
                            </td>
                        </tr>
                        <tr>
                            <th class="green_area">아이디</th>
                            <td>
                               <c:out value="${ bq.member.memId }"/>
                            </td>
                            <th class="green_area">작성일</th>
                            <td>
                               <c:out value="${ bq.postDate }"/> 
                            </td>
                        </tr>
                        <tr style="height: auto; vertical-align: middle;">
                            <th class="green_area">내용</th>
                            <td colspan="3">
                            	<c:out value="${ bq.postContent }"/>
                            </td>
                        </tr>
                        <c:set value="${ requestScope.ImgFileList }" var="imgList"/>
                        <tr style="height: auto; vertical-align: middle; border-bottom: 0;">
                            <th class="green_area">이미지</th>
                            <td colspan="3">
                            <c:if test="${ !empty imgList }">
                               <div class="fix_photo"><img class="fixImg" id="onImg1" src="${ pageContext.servletContext.contextPath }/${ imgList[0].fileName }"></div>
                               <c:if test="${ !empty imgList[1] }">
                               <div class="fix_photo"><img class="fixImg" id="onImg2" src="${ pageContext.servletContext.contextPath }/${ imgList[1].fileName }"></div>
                               </c:if>
                               <c:if test="${ !empty imgList[2] }">
                               <div class="fix_photo"><img class="fixImg" id="onImg3" src="${ pageContext.servletContext.contextPath }/${ imgList[2].fileName }"></div>
                               </c:if>
                            </c:if>
                               
                            <c:if test="${ empty imgList }">
                               <a>미첨부</a>
                            </c:if>
                            </td>
                        </tr>
                    </thead>
                </table>
                
                <input type="hidden" name="postNo" value="${ bq.postNo }">
                
                <!-- modal -->
                <div class="inquiry_modal">
                    <div class="inqury_box">
                        <img class="inquiry_img" id="show_img">
                    </div>
                </div>
                <!-- modal -->
                
                 <!-- 미답변 상태일 시 보여줄 화면 -->
                <c:if test='${ bq.ansStatus eq "W" }'>
                <div class="top_box" style="margin-top: 20px;">
                    <p>답변 내용</p>
                </div>
                <div class="text_area2">
                    <textarea name="ansContent" id=""></textarea>
                </div>
                <div class="top_box">
                    <p>이미지 첨부</p>
                </div>
                <div class="change_photo" id="view_area1"><img class="img_size noEvent" id="view_img1" src="${ pageContext.servletContext.contextPath }/resources/images/photo2.png"></div>
                <div class="change_photo" id="view_area2"><img class="img_size noEvent" id="view_img2" src="${ pageContext.servletContext.contextPath }/resources/images/photo2.png"></div>
                <div class="change_photo" id="view_area3" style="margin-right:0;"><img class="img_size noEvent" id="view_img3" src="${ pageContext.servletContext.contextPath }/resources/images/photo2.png"></div>
                <div class="photo_size">이미지당 10MB이하, 최대 3개까지 등록 가능합니다.</div>
                <div class="btn_box">
                    <input type="submit" value="답변등록" class="btn write_btn" style="background-color: #F89E91;">
                    <a href="javascript:history.back(-1)" class="btn cancle_btn" style="background-color: #BEBEBE;">목록으로</a>
                </div>
                
                <!-- file area -->
                <div class="fileArea">
                    <input type="file" id="insert_img1" name="fileName1" onchange="loadImg(this,1)" accept="image/*">
                    <input type="file" id="insert_img2" name="fileName2" onchange="loadImg(this,2)" accept="image/*">
                    <input type="file" id="insert_img3" name="fileName3" onchange="loadImg(this,3)" accept="image/*">
                </div>
                <!-- file area -->
                </c:if>
                
                </form>
                
                <!-- 답변 상태일 시 보여줄 화면 -->
                <c:if test='${ bq.ansStatus eq "Y" }'>
                <div class="top_box" style="margin-top: 20px;">
                    <p>답변 내용</p>
                </div>
                <div class="text_area2">
                    <textarea name="ansContent" id="" disabled><c:out value="${ bq.ansContent }"/></textarea>
                </div>
                <div class="top_box">
                    <p>이미지 첨부</p>
                </div>
                <c:set value="${ requestScope.answerFileList }" var="answerImg"/>
                <c:if test="${ !empty answerImg[0] && answerImg[0].fileName  ne null }">
                <div class="change_photo"><img class="img_size addEvent" src="${ pageContext.servletContext.contextPath }/${ answerImg[0].fileName }"></div>
                </c:if>
                <c:if test="${ empty answerImg[0] || answerImg[0].fileName eq null }">
                <div class="change_photo"><img class="img_size addEvent" src="${ pageContext.servletContext.contextPath }/resources/images/photo2.png"></div>
                </c:if>
                
                <c:if test="${ !empty answerImg[1] && answerImg[1].fileName ne null }">
                <div class="change_photo"><img class="img_size addEvent" src="${ pageContext.servletContext.contextPath }/${ answerImg[1].fileName }"></div>
                </c:if>
                <c:if test="${ empty answerImg[1] || answerImg[1].fileName eq null }">
                <div class="change_photo"><img class="img_size addEvent" src="${ pageContext.servletContext.contextPath }/resources/images/photo2.png"></div>
                </c:if>
                
                <c:if test="${ !empty answerImg[2] && answerImg[2].fileName ne null }">
                <div class="change_photo" style="margin-right:0;"><img class="img_size addEvent" src="${ pageContext.servletContext.contextPath }/${ answerImg[2].fileName }"></div>
                </c:if>
                <c:if test="${ empty answerImg[2] || answerImg[2].fileName eq null }">
                <div class="change_photo" style="margin-right:0;"><img class="img_size addEvent" src="${ pageContext.servletContext.contextPath }/resources/images/photo2.png"></div>
                </c:if>
                <div class="photo_size">이미지당 10MB이하, 최대 3개까지 등록 가능합니다.</div>
                <div class="btn_box">
                    <input type="button" value="수정하기" class="btn write_btn" style="background-color: #F89E91;" onclick="location.href='${ pageContext.servletContext.contextPath }/manager/businessRevise?postNo=${ bq.postNo }'">
                    <a href="javascript:history.back(-1)" class="btn cancle_btn" style="background-color: #BEBEBE;">목록으로</a>
                </div>
                
                
				</c:if>
				
        </div>
    </div>
    
    <jsp:include page="../commons/footer.jsp"/>

    <script>
        $("#chk_all").click(function(){
         $(this).parent
        });
        
        $(".write_btn").attr("style","background-color: #9FD39B !important");
 
         $("#homeSubmenu3").addClass("show");
         $("#homeSubmenu3 > li:first-child > a").attr("style","color: #F89E91 !important");
     </script>

	 <!-- modal  -->     
     <script>

/*         $('.fixImg').click(function(){
            let img = $(this).attr("src");
            
            $('.inquiry_img').attr("src",img);
            $('.inquiry_box').html(img);
            $('.inquiry_modal').show();
        }); */
        
        $('.addEvent').click(function(){
            let img = $(this).attr("src");
            console.log(img);
            
            if(img != "${ pageContext.servletContext.contextPath }/resources/images/photo2.png"){ 
	            $('.inquiry_img').attr("src",img);
	            $('.inquiry_box').html(img);
	            $('.inquiry_modal').show();
            }
        });

        $('.inquiry_modal').click(function(e){
            $('.inquiry_modal').toggle();
            $('.inquiry_modal').css('display','none');
        });
    </script>

	<!-- file image -->
    <script>
        
        $("#view_area1").click(function(){
        	$("#insert_img1").click();
        })
        
        $("#view_area2").click(function(){
        	$("#insert_img2").click();
        })
        
        $("#view_area3").click(function(){
        	$("#insert_img3").click();
        })
        

        function loadImg(value, num){
        	
            if(value.files && value.files[0]){
                const reader = new FileReader();
                /* 읽기동작이 성공적으로 로드되었을 때 작동하는 함수 */
                reader.onload = function(e){
                /* 가공된 파일 url을 srcdp 넣어줌 */
                    switch(num){
                    case 1: document.getElementById("view_img1").src = e.target.result; break;
                    case 2: document.getElementById("view_img2").src = e.target.result; break;
                    case 3: document.getElementById("view_img3").src = e.target.result; break;
                    }
                }
                reader.readAsDataURL(value.files[0]);
            }
            if(value.files || value.files[0]){
                switch(num){
                    case 1: document.getElementById("view_img1").src = '${ pageContext.servletContext.contextPath }/resources/images/photo2.png'; break;
                    case 2: document.getElementById("view_img2").src = '${ pageContext.servletContext.contextPath }/resources/images/photo2.png'; break;
                    case 3: document.getElementById("view_img3").src = '${ pageContext.servletContext.contextPath }/resources/images/photo2.png'; break;
                    }
            }
        }
    </script>
</body>
</html>