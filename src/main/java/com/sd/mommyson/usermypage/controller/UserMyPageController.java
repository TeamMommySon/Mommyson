package com.sd.mommyson.usermypage.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sd.mommyson.member.controller.MemberController;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.member.dto.StoreDTO;
import com.sd.mommyson.member.service.MemberService;
import com.sd.mommyson.user.common.Pagenation;
import com.sd.mommyson.user.common.SelectCriteria;
import com.sd.mommyson.user.dto.ReviewDTO;
import com.sd.mommyson.usermypage.dto.CouponHistoryDTO;
import com.sd.mommyson.usermypage.dto.MyOrderDTO;
import com.sd.mommyson.usermypage.service.UserMyPageService;

@Controller
@RequestMapping("/userMyPage/*")
@SessionAttributes("loginMember")
public class UserMyPageController {
//양윤제
	
	private UserMyPageService userMyPageService;
	private MemberService memberService;
	private BCryptPasswordEncoder passwordEncorder;
	
	@Autowired				 
	JavaMailSender mailSender; 
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	public UserMyPageController(UserMyPageService userMyPageService, BCryptPasswordEncoder passwordEncorder, MemberService memberService) {
		this.userMyPageService = userMyPageService;
		this.passwordEncorder = passwordEncorder;
		this.memberService = memberService;
	}
	
	
	
	
	/*주문내역*/
	@GetMapping(value={"myOrderList","/"})
	public String myOrderList(HttpSession session, Model mv, @RequestParam(required = false) Map<String,String> parameters) {
		
		
		
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("로그인 멤버: " + memberInfo);
		System.out.println("로그인한 멤버의 멤버 코드: " + memberInfo.getMemCode());
		int userCode = memberInfo.getMemCode();

		String currentPage = parameters.get("currentPage");
		
		int pageNo = 1;
		System.out.println("currnetPage : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		
		/* 0보다 작은 숫자값을 입력해도 1페이지를 보여준다 */
		if(pageNo <= 0) {
			pageNo = 1;
		}
		//searchCondition에 유저 코드를 넣어줌
		String searchCondition = "" + userCode;
		String searchValue = parameters.get("searchValue");
		
		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);
		
		//내가 주문한 내역의 총 숫자, 검색어로 주문가게 찾을수있음
		int totalCount = userMyPageService.selectMyOrderNum(searchMap);
		

		System.out.println("totalCount : " + totalCount);
		
		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 4;		//얘도 파라미터로 전달받아도 된다.
		/* 한 번에 보여질 페이징 버튼의 갯수 */
		int buttonAmount = 5;
		
		/* 페이징 처리를 위한 로직 호출 후 페이징 처리에 관한 정보를 담고 있는 인스턴스를 반환받는다. */
		SelectCriteria selectCriteria = null;
		
		if(searchCondition != null && !"".equals(searchCondition)) {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount);
		}
		
		System.out.println("selectCriteria : " + selectCriteria);
		
		List<MyOrderDTO> myOrderList = userMyPageService.selectMyOrderList(selectCriteria);
		
		System.out.println("주문내역 리스트 : " +myOrderList);
		
		//반찬 정보 가져오기 
		List<HashMap<String, String>> mySdInfo = userMyPageService.selectMyOrderSd(userCode);
		System.out.println(mySdInfo);
		
			
		mv.addAttribute("myOrderList", myOrderList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("mySdInfo", mySdInfo);
		mv.addAttribute("Paging", "myOrderBoard");
		
		return "user_mypage/userTotalOrderList";
	}
	
	/*주문취소*/
	@PostMapping("orderCancel")
	public void orderCancel(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String cancelInfo = request.getParameter("result");
		System.out.println("취소정보 : " + cancelInfo);
		
		String[] arrInfo = cancelInfo.split(" ");
		int result=0;
		for(int i = 0; i < arrInfo.length; i ++) {
			
			System.out.println("배열화된 주문번호 정보 : " + arrInfo[i]);
			
			 result += userMyPageService.updateOrderCancel(Integer.parseInt(arrInfo[i]));
			
		}
		
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if(result >= arrInfo.length ) {
				String message = "주문이 취소되었습니다.";
				out.print(message);
			} else {
				String message = "관리자에게 문의 바랍니다.";
				out.print(message);
			}
			
			out.flush();
			out.close();
		
		
	}
	
	/*개인정보변경 신원확인*/
	@GetMapping("userInfoChange")
	public String userInfoChange(HttpSession session) {
		
		
		return "user_mypage/userChangeUserInfo1";
	}
	
	/* 신원확인 프로세스 진입*/
	@PostMapping(value = "userConfirmation")
	@ResponseBody
	public boolean signOutConfirmation(@ModelAttribute MemberDTO memberInfo, Model mv, HttpSession session) {
			
		System.out.println("사용자 신원확인 과정진입");
		boolean confirmationResult = userMyPageService.selectMatchUserInfo(memberInfo);
		
		String message = "";

		message = "" + confirmationResult;
		System.out.println("message : " +  confirmationResult);
			
		
		return confirmationResult; 
	}
	
	/* 개인정보 변경 페이지 진입*/
	@GetMapping("userInfoChange2")
	public String userInfoChange2(HttpSession session, Model mv) {
		
		System.out.println("개인정보 변경 본 페이지 진입");
		//현재 사용자 정보
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("현재 사용자 정보 : " + memberInfo);
		
		
		mv.addAttribute("memberInfo", memberInfo);
	
		
		
		
		return "user_mypage/userChangeUserInfo2";
	}
	
	/*회원탈퇴 페이지 이동*/
	@GetMapping("userSignOut1")
	public String userSingOut1( ) {
		
		
		return "user_mypage/userSignOut1";
	}
	
	
	/*탈퇴처리과정*/
	@PostMapping(value="useSignOutConfirmation", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String signOutConfirmation(@ModelAttribute MemberDTO memberInfo, Model mv, SessionStatus status) {
		System.out.println("탈퇴처리과정진입");
		int result = userMyPageService.updateSignOut(memberInfo);
		
		String message = "";

		message = "" + result;
		System.out.println("message : " +  message);
		
		if(result > 0) {
			status.setComplete();
		}
	  return message;
	}
	
	/*쿠폰함*/
	@GetMapping("userCoupon")
	public String userCoupon(HttpSession session, Model mv, @RequestParam(required = false) Map<String,String> parameters) {
		
		System.out.println("내가 쓴 쿠폰함 콘트롤러 진입");
		
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("로그인 멤버: " + memberInfo);
		System.out.println("로그인한 멤버의 멤버 코드: " + memberInfo.getMemCode());
		int userCode = memberInfo.getMemCode();
		
		String currentPage = parameters.get("currentPage");
		
		int pageNo = 1;
		System.out.println("currnetPage : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		
		/* 0보다 작은 숫자값을 입력해도 1페이지를 보여준다 */
		if(pageNo <= 0) {
			pageNo = 1;
		}
		//searchCondition에 유저 코드를 넣어줌
		String searchCondition = "" + userCode;
		String searchValue = parameters.get("searchValue");
		
		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);
		
		int totalCount = userMyPageService.selectMycouponNo(searchMap);
		
		System.out.println("totalPostCount : " + totalCount);
		
		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 5;		//얘도 파라미터로 전달받아도 된다.
		/* 한 번에 보여질 페이징 버튼의 갯수 */
		int buttonAmount = 5;
		
		/* 페이징 처리를 위한 로직 호출 후 페이징 처리에 관한 정보를 담고 있는 인스턴스를 반환받는다. */
		SelectCriteria selectCriteria = null;
		
		if(searchCondition != null && !"".equals(searchCondition)) {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount);
		}
		
		System.out.println("selectCriteria : " + selectCriteria);
		
		List<CouponHistoryDTO> myCouponList = userMyPageService.selectMyCouponList(selectCriteria);
		
		System.out.println("나의 쿠폰 : " + myCouponList);
		System.out.println("myCouponList사이즈 : " + myCouponList.size());
		List<Integer> ceoCode = new ArrayList<>();
		for(int i = 0; i < myCouponList.size(); i++) {
			
			int ceoNum = userMyPageService.selectCeoCode(myCouponList.get(i).getCouponInfo().getCpCode());
			ceoCode.add(ceoNum);
			
			System.out.println("ceoCode : " + ceoCode);
			
		}
		System.out.println("ceoCode : " + ceoCode);
		mv.addAttribute("ceoCode", ceoCode);
		mv.addAttribute("myCouponList", myCouponList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("Paging", "uer_coupon_warehouse");//페이지네이션 해당값
		
		
		return "user_mypage/userCoupon";
	}
	
	
	/*자주찾는가게*/
	@GetMapping("userRecommendStore")
	public String userRecommendStore(HttpSession session, Model mv, @RequestParam(required = false) Map<String,String> parameters) {
		
		System.out.println("내가 찜한가게 콘트롤러 진입");
		
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("로그인 멤버: " + memberInfo);
		System.out.println("로그인한 멤버의 멤버 코드: " + memberInfo.getMemCode());
		int userCode = memberInfo.getMemCode();
		
		String currentPage = parameters.get("currentPage");
		
		int pageNo = 1;
		System.out.println("currnetPage : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		
		/* 0보다 작은 숫자값을 입력해도 1페이지를 보여준다 */
		if(pageNo <= 0) {
			pageNo = 1;
		}
		//searchCondition에 유저 코드를 넣어줌
		String searchCondition = "" + userCode;
		String searchValue = parameters.get("searchValue");
		
		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);
		
		int totalCount = userMyPageService.selectMyRecommendStore(searchMap);
		
		System.out.println("totalPostCount : " + totalCount);
		
		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 5;		//얘도 파라미터로 전달받아도 된다.
		/* 한 번에 보여질 페이징 버튼의 갯수 */
		int buttonAmount = 5;
		
		/* 페이징 처리를 위한 로직 호출 후 페이징 처리에 관한 정보를 담고 있는 인스턴스를 반환받는다. */
		SelectCriteria selectCriteria = null;
		
		if(searchCondition != null && !"".equals(searchCondition)) {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
			System.out.println("들어왔음");
		} else {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount);
		}
		
		System.out.println("selectCriteria : " + selectCriteria);
		
		List<StoreDTO> storeReconmendList = userMyPageService.selectRecommendStore(selectCriteria);
		
		System.out.println("내가찜한 가게 " + storeReconmendList);
		
		mv.addAttribute("storeReconmendList", storeReconmendList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("totalCount", totalCount);
		mv.addAttribute("Paging", "recommendStore");
		
		return "user_mypage/userRecommendStore";
	}
	/* 자주찾는 가게 삭제 */
	@PostMapping("delRecommend")
	public void delRecommendStore(HttpSession session, @RequestParam("storeCode") String str, HttpServletResponse response) throws IOException {
		
		
		System.out.println("str :" + str);
		int storeNo = Integer.parseInt(str);
		
		int result = userMyPageService.deleteRecommendStore(storeNo);
		response.setContentType("text/plain; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		if( result > 0 ) {
			out.print("삭제 되었습니다.");
		} else {
			out.print("삭제에 실패했습니다.");
		}
		
		out.flush();
		out.close();
		
	}
	
	/*나의 신고 내역*/
	@GetMapping("userReport")
	public String userReport( ) {
		
		
		return "user_mypage/userReport";
	}
	
	/*내가 쓴 리뷰*/
	@GetMapping("userReview")
	public String userReview(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam(required = false) Map<String,String> parameters) throws IOException {
		
		System.out.println("내가 리뷰 콘트롤러 진입");
		
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("로그인 멤버: " + memberInfo);
		System.out.println("로그인한 멤버의 멤버 코드: " + memberInfo.getMemCode());
		int userCode = memberInfo.getMemCode();
		
		String currentPage = parameters.get("currentPage");
		
		int pageNo = 1;
		System.out.println("currnetPage : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		
		/* 0보다 작은 숫자값을 입력해도 1페이지를 보여준다 */
		if(pageNo <= 0) {
			pageNo = 1;
		}
		//searchCondition에 유저 코드를 넣어줌
		String searchCondition = "" + userCode;
		String searchValue = parameters.get("searchValue");
		
		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);
		
		int totalCount = userMyPageService.selectTotalReviewCount(searchMap);
		System.out.println("totalCount : " + totalCount);

		System.out.println("totalPostCount : " + totalCount);
		
		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 5;		//얘도 파라미터로 전달받아도 된다.
		/* 한 번에 보여질 페이징 버튼의 갯수 */
		int buttonAmount = 5;
		
		/* 페이징 처리를 위한 로직 호출 후 페이징 처리에 관한 정보를 담고 있는 인스턴스를 반환받는다. */
		SelectCriteria selectCriteria = null;
		
		if(searchCondition != null && !"".equals(searchCondition)) {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
			System.out.println("들어왔음");
		} else {
			selectCriteria = Pagenation.getSelectCriteria(pageNo, totalCount, limit, buttonAmount);
		}
		
		System.out.println("selectCriteria : " + selectCriteria);
		
		List<ReviewDTO> reviewContentList = userMyPageService.selectReviewContentList(selectCriteria);
		System.out.println("리뷰 페이지네이션 및 검색 : " + reviewContentList);
		
		//반찬정보 조회
		List<HashMap<String, String>>productInfo = userMyPageService.selectMySdInfo(userCode);


		
		model.addAttribute("selectCriteria", selectCriteria);
		model.addAttribute("reviewContentList", reviewContentList);
		model.addAttribute("productInfo", productInfo);
		
		model.addAttribute("Paging", "myReview");
		
		
		return "user_mypage/userReview";
	}

	/* 리뷰 수정페이지 출력 */
	@GetMapping("amendmentReview")
	public String amendmentReview(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model mv){
		
		String reviewCode = request.getParameter("rvCode");
		System.out.println("reviewCode : " + reviewCode);
		int rvCode = Integer.parseInt(reviewCode);
		
		ReviewDTO reviewInfo = userMyPageService.selectReviewInfo(rvCode);
		
		System.out.println("review 정보 : " + reviewInfo);
		
		mv.addAttribute("reviewInfo", reviewInfo);
		
		return "user_mypage/review_change";
	}
	
	//리뷰 파일업로드 및 수정한 데이터 등록
	@PostMapping("amendmentReview")
	public String updateReview(HttpSession session, @RequestParam(required = false) Map<String,String> parameters, @RequestParam(required = false) MultipartFile singleFile, HttpServletRequest request, Model mv) {
		
		String message ="";
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		int memCode = memberInfo.getMemCode();
		int postGrade = Integer.parseInt(parameters.get("postGrade"));
		String postContents = parameters.get("contents");
		String rvCode = parameters.get("reviewCode");
		int orderNo = Integer.parseInt(parameters.get("orderNo"));
				
		System.out.println("memCode : " + memCode);
		System.out.println("reviewImg : " + postGrade);
		System.out.println("postContents : " + postContents);
		System.out.println("rvCode : " + rvCode);
		System.out.println("orderNo : " + orderNo);
		
		Map<String, Object> amendmentRv = new HashMap<>();
		amendmentRv.put("postGrade", postGrade);
		amendmentRv.put("postContents", postContents);
		amendmentRv.put("rvCode", rvCode);
		amendmentRv.put("memCode", memCode);
		
		System.out.println("리뷰수정 맵 내용 : " + amendmentRv);
		
		
		
		//이미지 파일 갱신(업로드)
		
		System.out.println("singleFile : " + singleFile);
		
		if(!singleFile.isEmpty() && singleFile != null) {
			
		
			/* 파일을 저장할 경로 설정 */
			String root = request.getSession().getServletContext().getRealPath("resources");
			
			System.out.println("root : " + root);//경로 확인
			
			String filePath = root + "\\uploadFiles"; //이폴더에 넣겠다.
			
			File mkdir = new File(filePath);//경로가 없으면 추가 시켜주겠다. mkdir
			if(!mkdir.exists()) {
				mkdir.mkdirs();//없으면 경로에 폴더 생성  없으면 mkdirs 하위 여러개 만들어줌, mkdir은 하나
			}
			
			/* 파일명 변경 처리 이름명 같은거 제거 */
			String originFileName = singleFile.getOriginalFilename();
			String ext = originFileName.substring(originFileName.lastIndexOf("."));//확장자명가져오겠다. "."마지막 껄 찾겠다.
			String savedName = UUID.randomUUID().toString().replace("-", "") + ext;//uuid ""-빈값으로 만들어주고 위에 확장자를 붙여줄거다.
			
			/* 파일을 저장한다. */
			
			amendmentRv.put("fileFolder", "resources/uploadFiles/" + savedName);
			try {
				singleFile.transferTo(new File(filePath + "\\" +savedName));
				System.out.println("파일 저장 경로 확인  : " + filePath + "\\" +savedName);
				message = "정상적으로 수정되어졌습니다.";
				mv.addAttribute("message", message);
			} catch (IllegalStateException | IOException e) {
				/* 실패 시 파일 삭제*/
				new File(filePath + "\\" + savedName).delete();//문제시 파일삭제
				message = "문제가 발생했습니다.";
				mv.addAttribute("message", message);
				e.printStackTrace();
			}//변경된파일이름으로 저장하겠다.
			
		} else {
			amendmentRv.put("fileFolder", parameters.get("emergencyPath"));
		}
		
		int result = userMyPageService.updateReview(amendmentRv);
		
		System.out.println("result : " + result);
		
		return  "redirect:userReview";
	}
	
	/*리뷰 삭제*/
	@PostMapping("delReview")
	public void deleteReview(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String reviewDelInfo = request.getParameter("rvCode");
		int rvCodeDel = Integer.parseInt(reviewDelInfo);
		System.out.println("리뷰 삭제 번호 " +rvCodeDel);
		
		int result = userMyPageService.updateDelReview(rvCodeDel);
		
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(result >0 ) {
			out.print("리뷰가 삭제 되었습니다.");
		} else {
			out.print("리뷰 삭제에 실패했습니다. 관리자에게 문의 하세요");
		}
		
		return;
	}
	
	
	/**@author ShinHyungi
	 * @param orderCode
	 * @param model
	 * @return
	 */
	@GetMapping("postReview")
	public String postReview(@RequestParam String orderCode, Model model) {
		
		model.addAttribute("orderCode", orderCode);
		
		return "user_mypage/review_page";
	}
	
	/**@author ShinHyungi
	 * @param img
	 * @param request
	 * @param session
	 * @return
	 */
	@PostMapping("postReview") 
	public String postReview(@RequestParam MultipartFile img, HttpServletRequest request, HttpSession session, RedirectAttributes ra) {
		MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
		ReviewDTO review = new ReviewDTO();
		
		int grade = Integer.parseInt(request.getParameter("star"));
		int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		review.setOrderCode(orderCode);
		review.setGrade(grade);
		review.setMemCode(member.getMemCode());
		review.setContent((String) request.getParameter("contents"));
		review.setMemId(member.getMemId());
		System.out.println("img : " + img);
		System.out.println("review : " + review);
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		String filePath = root + "/uploadFiles";
		
		File mkdir = new File(filePath);
		if(!mkdir.exists()) {
			mkdir.mkdirs();
		}
		
		if(!img.isEmpty()) {
			
			String orginFileName = img.getOriginalFilename();
			String ext = orginFileName.substring(orginFileName.indexOf("."));
			String savedName = UUID.randomUUID().toString().replace("-", "") + ext;
			
			try {
				img.transferTo(new File(filePath + "/" + savedName));
				
				String fileName = "resources/uploadFiles/" + savedName;
				
				review.setImg(fileName);
				
				
			} catch (IllegalStateException | IOException e) {
				new File(filePath + "/" + savedName).delete();
					
				e.printStackTrace();
			}
		
		}
		
		// 리뷰 등록
		int result = userMyPageService.insertReview(review);
		
		// 가게 평점 업데이트
		double storeGrade = userMyPageService.selectStoreGrade(orderCode);
		Map<String, Object> map = new HashMap<>();
		map.put("orderCode", orderCode);
		map.put("grade", storeGrade);
		int result2 = userMyPageService.updateStoreGrade(map);
		String url = "";
		if(result > 0 && result2 > 0) {
			url = "redirect:userReview";
			ra.addFlashAttribute("message", "리뷰 등록 완료");
		} else {
			url = "redirect:myOrderList";
			ra.addFlashAttribute("message", "리뷰 등록 실패");
		}
//		return "redirect:userMypage/userReview";
		return url;
	}
	
	/**@author ShinHyungi
	 * @param email
	 */
	@PostMapping("emailCheck")
	@ResponseBody
	public void emailCheck(@RequestParam("email") String email) {
		
		/* 뷰에서 넘어온 데이터 확인 */ 
		logger.info("이메일 데이터 전송 확인");
		logger.info("이메일 : " + email);

		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) +111111;
		logger.info("인증번호" + checkNum);

		/* 이메일 보내기 */
		String setFrom = "sli9962@naver.com";
		String toMail = email;
		String title = "회원가입 인증 이메일입니다.";
		String content = "마미손을 방문해주셔서 감사합니다." 
				+ "<br><br>" 
				+ "인증번호는 " + checkNum +"입니다." 
				+ "<br><br>" 
				+ "해당 인증번호를 홈페이지의 인증번호 확인란에 기입하여 주세요."; 

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);

		}catch(Exception e) {
			e.printStackTrace();
		}

		
		String num = Integer.toString(checkNum);

		HashMap<String,String> map = new HashMap<String,String>();
		map.put("num", num);
		map.put("toMail", toMail);
		
		System.out.println("map : " + map);
		memberService.registEmailCode(map);

	}
	
	/**@author ShinHyungi
	 * @param code
	 * @return
	 */
	@PostMapping(value = "codeCheck", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String codeCheck(@RequestParam("inputCode") String code) {
		
		String email= memberService.codeCheck(code);
		
		return email;
	}
	
	/**@author ShinHyungi
	 * @return
	 */
	@PostMapping("updateMemberInfo")
	public String updateMemberInfo(@ModelAttribute MemberDTO member, HttpSession session, SessionStatus status) {
		
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		member.setMemCode(loginMember.getMemCode());
		
		status.setComplete();
		
		if(member.getMemPwd() != null) {
			member.setMemPwd(passwordEncorder.encode(member.getMemPwd()));
		}
		
		userMyPageService.updateMemberInfo(member);
		
		return "redirect:/";
	}
	
}
