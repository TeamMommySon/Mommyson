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
    <jsp:include page="../commons/header.jsp"></jsp:include>
    <section>
        <div class="at-container" style="width: 80%;">
             <form action="${ pageContext.servletContext.contextPath }/userMyPage/amendmentReview" method="post" enctype="multipart/form-data">
         		
            <div class="main_box">
                <h1 align="center">리뷰 수정</h1>
                <div class="sub_box">
                    <h3>사진</h3>
                    <div id="review_pic">
                    <input type="hidden" name="reviewCode" value="${ requestScope.reviewInfo.rvCode }">
                    <input type="hidden" name="orderNo" value="${ requestScope.reviewInfo.orderCode }">
                   		<c:if test="${ requestScope.reviewInfo.img eq null or requestScope.reviewInfo.img eq ''}">
                        	<img src="${ pageContext.servletContext.contextPath }/resources/images/no-image.png" id="review_img">
                   		</c:if>
                        <c:if test="${ requestScope.reviewInfo.img ne null and requestScope.reviewInfo.img ne ''}">
                           <img src="${ pageContext.servletContext.contextPath }/${ requestScope.reviewInfo.img }" id="review_img" style="width: 400px;">
                       	</c:if>
                    </div>
                    <div style="padding-top: 200px;">
                        <button type="button" class="pink_btn" data-toggle="modal" data-target="#exampleModal">
                            사진등록
                        </button>
                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                              <div class="modal-content">
                                <div class="modal-header">
                                  <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                <div class="modal-body">
                                    <img src="" id="preview-image" style="width: 400px;">
                                    <hr>
                                    
                                    <input type="file" id="input-image" name="singleFile" >
                                    <input type="hidden" id="emergencyPath" name="emergencyPath" value="${ requestScope.reviewInfo.img }">
                                </div>
                                <div class="modal-footer">
                                  <button type="button" class="pink_btn" data-dismiss="modal">취소</button>
                                  <button type="button" class="pink_btn" id="save_img">저장</button>
                                </div>
                                <script>
                                    // 이미지 미리보기, 모달창내에
                                    function readImage(input) {

                                        if(input.files && input.files[0]) {

                                            const reader = new FileReader()

                                            reader.onload = e => {
                                                const previewImage = document.getElementById("preview-image")
                                                previewImage.src = e.target.result
                                            }

                                            reader.readAsDataURL(input.files[0])
                                        }
                                    }
									//모달창안에 인풋 파일 부분
                                    const inputImage = document.getElementById("input-image")
                                    inputImage.addEventListener("change", e => {
                                        readImage(e.target)//위에 있는 함수 통해서 
                                    })

                                    // 저장 버튼 클릭 시 리뷰 사진 등록 //모달창 밖의 이미지가 변함
									//프리뷰 이미지값 변환
                                    $('#save_img').on('click',function() {
                                        let img = $('#preview-image').attr('src')
                                        $('#review_img').attr('src',img);//프리뷰이미지를 리뷰 이미지로
                                        $('#exampleModal').modal('hide');
                                    })
                                </script>
                              </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sub_box">
                    <div style="display: flex; justify-content: space-between; width: 280px; margin: 50px 0;">
                        <h3>별점</h3>
                        <div id="star_box">
                            <button type="button" value="1">
                                <svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                </svg>
                            </button>
                            <button type="button" value="2">
                                <svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                </svg>
                            </button>
                            <button type="button" value="3">
                                <svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                </svg>
                            </button>
                            <button type="button" value="4">
                                <svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                </svg>
                            </button>
                            <button type="button" value="5">
                                <svg style="color: #EFCA45;" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                </svg>
                            </button>
                            <input type="hidden" id="star" name="postGrade" value="5">
                        </div>
                    </div>
                    <div></div>
                </div>
                <div class="sub_box" style="margin-bottom: 100px;">
                    <div style="display: flex; justify-content: space-between; width: 100%;">
                        <h3>내용</h3>
                        <textarea id="contents" name="contents" cols="90" rows="10" placeholder="리뷰를 작성해주세요!" style="resize: none; padding: 10px;">${requestScope.reviewInfo.content }</textarea>
                    </div>
                </div>
                <div class="sub_box" style="margin-bottom: 100px; align-items: center; width: 36%;">
                    <div style="display: flex; justify-content: space-between; width: 100%;">
                        <button type="button" class="pink_btn" style="background: #AEAEAE;" id="goBackMyReview" onclick="history.back()">취소</button>
                        <button type="submit" class="pink_btn" id="completeform">완료</button>
                    </div>
                </div>
            </div>
             </form>
        </div>
            <script>
             $(document).ready(function() {
                let gradeInfo =  $('#star_box > button');
                console.log(gradeInfo);
                for(let i = 0; i < gradeInfo.length; i++) {
             	   
             		  let gradeRate = gradeInfo[i].value;
             	  if(gradeInfo[i].value == "${ requestScope.reviewInfo.grade }") {
             		  console.log(gradeRate);
             		  $('#star_box > button').ready(function(gradeRate) {
                           // e.currentTarget.nextAll().css('color','lightgray');
                           
                           console.log(gradeRate);
                           $('button[value=${ requestScope.reviewInfo.grade }]').nextAll().children().css('color','lightgray');
                           $('button[value=${ requestScope.reviewInfo.grade }]').children().css('color','#EFCA45');
                           $('button[value=${ requestScope.reviewInfo.grade }]').prevAll().children().css('color','#EFCA45');
                           $('#star').val($('button[value=${ requestScope.reviewInfo.grade }]').val());
                       });
             	  }
                }
                
             });
             
                $('#star_box > button').on('click',function(e) {
                    // e.currentTarget.nextAll().css('color','lightgray');
                    
                    console.log(e.currentTarget);
                    $(event.currentTarget).nextAll().children().css('color','lightgray');
                    $(event.currentTarget).children().css('color','EFCA45');
                    $(event.currentTarget).prevAll().children().css('color','#EFCA45');
                    $('#star').val($(event.currentTarget).val())
                });
                
               /*  $('#goBackMyReview').on('click',function() {
                
                    location.href = "${ pageContext.servletContext.contextPath }/userMyPage/userReview";
                }); */
                
                
            </script>
    </section>
	<jsp:include page="../commons/footer.jsp"/>
</body>
</html>