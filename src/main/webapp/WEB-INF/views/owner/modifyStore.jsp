<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/owners.css">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/ownerStore.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
<title>가게정보 수정</title>
</head>
<body>

	<!-- header -->
	<jsp:include page="../commons/header.jsp"/>
	
	<div class="page-text" style="width: 1550px; margin: 0 auto;">
	<br><br><br>
        <br><h2 style="margin-left: 100px; font-weight: 900;">가게정보 수정</h2>
        <hr>
    </div>
	
	<div class="body-all"style="margin-bottom: 600px">
	  <div class="body-inside">
        
        <!-- sidebar  -->
        <jsp:include page="../commons/ownerSidebar.jsp"/>
	
		<div class="body-center" style="text-align: center;">
        <form action="${ pageContext.servletContext.contextPath }/owner/modifyStore" method="post" enctype="multipart/form-data">
        <div class="at-container" style="width: 80%;">
            <div class="main_box">
            <br><br>
                <h1 align="center">가게 정보</h1>
                <div class="sub_box">
                    <h3>대표이미지</h3>
                    <div id="review_pic">
                        <input type="image" src="${ pageContext.servletContext.contextPath }/${ sessionScope.owner.ceo.store.storeImg }" style="pointer-events : none" id="review_img">
                    </div>
                    <div>
                        <button type="button" class="pink_btn" data-toggle="modal" data-target="#exampleModal">
                            사진변경
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
                                    <input type="file" id="input-image" name="img">
                                </div>
                                <div class="modal-footer">
                                  <button type="button" class="pink_btn" data-dismiss="modal">취소</button>
                                  <button type="button" class="pink_btn" id="save_img">저장</button>
                                </div>
                                <script>
                                    // 이미지 미리보기
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

                                    const inputImage = document.getElementById("input-image")
                                    inputImage.addEventListener("change", e => {
                                        readImage(e.target)
                                    })

                                    // 저장 버튼 클릭 시 리뷰 사진 등록 (ajax로 수정해야함)
                                    $('#save_img').on('click',function() {
                                        let img = $('#preview-image').attr('src');
                                        $('#review_img').attr('src',img);
                                        $('#exampleModal').modal('hide');
                                    })
                                </script>
                              </div>
                            </div>
                        </div>
                    </div>
                </div>
                 <div style="width: 1000px; margin-right: 200px">
		            <br><br><br>
		          <div class="changeUserInfo">
		            <label>상호명</label><input type="text" name="storeName" placeholder="${ sessionScope.owner.ceo.store.storeName }">
		          </div>
		          <div class="changeUserInfo" style="margin-left: 98px">
		            <div style="display: inline-block;"><label>주소</label><input type="text" name="address" id="address" placeholder="${ owner.address }"></div>
		            <div style="display: inline-block;">&nbsp;&nbsp;&nbsp;
		            <input type="button" value="주소검색" onclick="sample6_execDaumPostcode()" class="pink_btn" style="width: 78px; height: 30px; padding: 0; box-shadow : none">
		            </div>
		          </div>
		          <div class="changeUserInfo"> 
		            <label>상세주소</label><input type="text" name="dAddress"id="dAddress" placeholder="${ sessionScope.owner.dAddress }">
		          </div>
		          <div class="changeUserInfo">
		            <label>우편번호</label><input type="text" name="postCode" id="postCode"  placeholder="${ sessionScope.owner.postCode }">
		          </div>
		          <div class="changeUserInfo">
		            <label>영업시간</label><input type="text" name="workTime" placeholder="${ sessionScope.owner.ceo.store.workTime }">
		          </div>
		          <div class="changeUserInfo">
		            <label>전화번호</label><input type="text" name="phone" placeholder="${ sessionScope.owner.phone }">
		          </div>
		          <div class="changeUserInfo">
		            <label>대표자명</label><input type="text" name="name" placeholder="${ sessionScope.owner.ceo.name }">
		          </div>
		          <div class="changeUserInfo">
		            <label>사업자 등록번호</label><input type="text" id="no" name="no" placeholder="${ sessionScope.owner.ceo.no }">
		          </div>
		        </div>
		          <div class="changeUserInfo" style="margin: 40px 0 100px 0">
		            <h3>가게소개</h3>
		            <br><br><br>
                    <textarea name="storeInfo" id="contents" cols="90" rows="10" placeholder="${ sessionScope.owner.ceo.store.storeInfo }" style="resize: none; padding: 10px;" name="storeInfo"></textarea>
                    <input type="hidden" name="memCode" value="${ sessionScope.loginMember.memCode }">
		          </div>
                </div>
                <input type="button" class="pink_btn" id="btn" style="background: #AEAEAE; margin-right: 20px" value="취소">
                <input type="submit"class="pink_btn" value="완료" id="btn">
              </div>
             </form>
          </div>
        </div>
      </div>  
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postCode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("dAddress").focus();
            }
        }).open();
    }
</script>
  <!-- footer --> 
  <jsp:include page="../commons/footer.jsp"/>
   
</body>
</html>