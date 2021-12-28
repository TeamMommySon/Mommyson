<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항 상세보기</title>
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
        
        <jsp:include page="../commons/managerSidebar.jsp"/>
        
        <div class="board_container">
             <h2 style="display: inline-block; width: 91.6%;">공지사항</h2>
            <a href="javascript:history.go(-1)" class="btn prev_btn" style="border-bottom: 1px solid black; margin-top:16px; margin-left: -1%; border-radius: 0 !important">&lt; 뒤로가기</a>
            <form action="${ pageContext.servletContext.contextPath }/manager/noticeSelectDelete" method="get">
                <table class="table bd_write_header bd_detail_view">
                    <colgroup>
                        <col width="10%"/>
                        <col width="60%"/>
                        <col width="10%"/>
                        <col width="20%"/>
                    </colgroup>
                    <thead>
                        <tr style="border-bottom: 1px solid #B1B1B1;">
                            <th>제목</th>
                            <td colspan="2">[공지]${ selectNotice.postTitle } </td>
                            <c:if test="${ selectNotice.status eq 'N' }">
                            <td class="btntd"><a id="postUp" class="btn up_btn">공지 등록</a></td>
                            </c:if>
                            <c:if test="${ selectNotice.status eq 'U' }">
                            <td class="btntd"><a id="postDown" class="btn down_btn">공지 해제</a></td>
                            </c:if>
                        </tr>
                        <tr>
                            <th>작성일</th>
                            <td>${ selectNotice.postDate }</td>
                            <th>조회수</th>
                            <td>${ selectNotice.viewCnt }</td>
                        </tr>
                    </thead>
                </table>
               <div class="text_area">
                  <textarea class="text_area" disabled>${ selectNotice.postContent }</textarea>
                </div>
                <input type="hidden" name="postNo" id="postNo" value="${ selectNotice.postNo }">
                <div class="btn_box2">
                   
                    <a href="${ pageContext.servletContext.contextPath }/manager/noticeRevise?postNo=${ selectNotice.postNo }" class="btn write_btn">수정하기</a>
                    <input type="button" id="delNotice" name="delNotice" value="삭제하기" class="btn prev_btn">
                </div>
            </form>
            
        </div>
    </div>
   
    <jsp:include page="../commons/footer.jsp"/>

    <script>
    $('#delNotice').on('click',function(){
		
    	if(confirm("선택한 게시글을 삭제하시겠습니까?") == false){
    		return false;
    	}
		
		var postNo = $("#postNo").val();
	
		$.ajax({
			url: '${ pageContext.servletContext.contextPath }/manager/noticeSelectDelete/' + postNo,
			type: 'GET',
			success: function(data){
				alert(data);
				location.href="${ pageContext.servletContext.contextPath }/manager/noticeSelect";
			},
			error: function(data){
				alert(data);
			}
		});		
	});
    
    $('#postUp').on('click',function(){
		
    	if(confirm("해당 게시글을 상단 고정하시겠습니까?") == false){
    		return false;
    	}
		
		var postNo = $("#postNo").val();
	
		$.ajax({
			url: '${ pageContext.servletContext.contextPath }/manager/noticeUp/' + postNo,
			type: 'GET',
			success: function(data){
				alert(data);
				location.href="${ pageContext.servletContext.contextPath }/manager/noticeSelect";
			},
			error: function(data){
				alert(data);
			}
		});		
	});
    
	$('#postDown').on('click',function(){
			
	    	if(confirm("해당 게시글을 고정 해제하시겠습니까?") == false){
	    		return false;
	    	}
			
			var postNo = $("#postNo").val();
		
			$.ajax({
				url: '${ pageContext.servletContext.contextPath }/manager/noticeDown/' + postNo,
				type: 'GET',
				success: function(data){
					alert(data);
					location.href="${ pageContext.servletContext.contextPath }/manager/noticeSelect";
				},
				error: function(data){
					alert(data);
				}
			});		
		});
    </script>
</body>
</html>