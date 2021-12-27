
package com.sd.mommyson.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.sd.mommyson.manager.common.Pagination;
import com.sd.mommyson.manager.dto.PostDTO;
import com.sd.mommyson.manager.service.ManagerService;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.member.dto.StoreDTO;
import com.sd.mommyson.owner.dto.CouponDTO;
import com.sd.mommyson.owner.dto.ProductDTO;
import com.sd.mommyson.user.common.Pagenation;
import com.sd.mommyson.user.common.SelectCriteria;
import com.sd.mommyson.user.dto.CartDTO;
import com.sd.mommyson.user.dto.FileDTO;
import com.sd.mommyson.user.dto.OrderDTO;
import com.sd.mommyson.user.dto.ReviewDTO;
import com.sd.mommyson.user.service.UserService;


/**
 * @author haejinpark
 *
 */
@Controller
//@SessionAttributes("")
@RequestMapping("/user/*")
public class UserController {

	private UserService userService;
	private ManagerService managerService;

	@Autowired
	public UserController(UserService userService, ManagerService managerService) {
		this.userService = userService;
		this.managerService = managerService;
	}

	@GetMapping("test")
	public void test() {

	}

	@GetMapping("test2")
	public void test2() {

	}


	/**@author 양윤제
	 * @category 고객센터 메인
	 */
	@GetMapping("ucc")
	public String userCustomerServiceMain(HttpSession session, Model mv, @RequestParam(value = "fqabatch", required = false) String pr) {

		List<PostDTO> noticeMainCon = userService.selectRecentNotice();
		System.out.println("고객 메인 공지사항" + noticeMainCon);

		List<PostDTO> importantNotice = userService.selectImportantNotice();
		System.out.println("고객 메인 중요 공지사항" + importantNotice);

		List<PostDTO> oftenFqa = userService.selectOftenFqa();
		System.out.println("고객센터 자주묻는 질문" + oftenFqa);

		mv.addAttribute("noticeMainCon", noticeMainCon);
		mv.addAttribute("importantNotice", importantNotice);
		mv.addAttribute("oftenFqa", oftenFqa);

		return "user/userCustomerServiceMain";
	}

	/**
	 * @author 양윤제
	 * @category1:1 상담내역 출력
	 */
	@GetMapping("ucc/MTMConsult")
	public String userCustomerServiceCenterMTMConsult(HttpSession session, Model mv, @RequestParam(required= false) Map<String,String> parameters) {

		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");

		int memCode = memberInfo.getMemCode();

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
		String searchCondition = "" + memCode;
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);

		int totalCount = userService.selectMtmTotalCount(searchMap);
		System.out.println("total : " + totalCount);


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

		List<PostDTO> mtmConsultingSelect = userService.selectMtmConsulting(selectCriteria);

		System.out.println("mtmConsultingSelect :" + mtmConsultingSelect);

		mv.addAttribute("mtmConsultingSelect", mtmConsultingSelect);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("paging", "mtm");


		return "user/userCustomerServiceCenterMTMConsult";
	}


	/**
	 * @author 양윤제
	 * @return 1:1입력창 진입
	 */
	@GetMapping("ucc/MTMQnA")
	public String userCustomerServiceCenterMTMQnA(HttpSession session) {

		return "user/userCustomerServiceCenterMTMQnA";
	}




	/**
	 * @author 양윤제
	 * @category 1:1문의 입력기능 수행
	 */
	@PostMapping("ucc/MTMQnA")
	public String userCustomerServiceCenterMTMQnA(@RequestParam(required = false) List<MultipartFile> multiFiles, HttpServletRequest request, Model mv, HttpSession session) {

		String mtmTitle = request.getParameter("title");//상담제목
		String mtmSort = request.getParameter("mtmSort");//질문 유형
		String mtmContents = request.getParameter("content");//상담 본문

		System.out.println("mtmTitle : " + mtmTitle);
		System.out.println("mtmSort : " + mtmSort);
		System.out.println("mtmContents : " + mtmContents);
		System.out.println("multiFiles : " + multiFiles);


		//유저와 유저 종류(사업자, 소비자) 정보
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("로그인 멤버: " + memberInfo);
		//유저 코드
		int memCode = memberInfo.getMemCode();
		System.out.println("로그인한 멤버의 멤버 코드: " + memCode);
		//유저 종류
		String memType = memberInfo.getMemType();
		System.out.println("멤버 타입 : " + memType);

		int boardCode = 0;
		if(memType.equals("user")) {
			switch (mtmSort) {
			case "memberJoinQuestion": boardCode = 12 ; break;
			case "billAndOrderQuestion": boardCode = 13; break;
			case "reviewManagementQuestion": boardCode = 14; break;
			case "userQuestion": boardCode = 15; break;
			case "inconvenienceQuestion": boardCode = 16; break;
			case "etcQuestion": boardCode = 17; break;
			default: System.out.println("관리자에게 문의하세요"); break;
			}
		}


		if(memType.equals("ceo")) {
			switch (mtmSort) {
			case "memberJoinQuestion": boardCode = 18; break;
			case "billAndOrderQuestion": boardCode = 19; break;
			case "reviewManagementQuestion": boardCode = 20; break;
			case "userQuestion": boardCode = 21; break;
			case "inconvenienceQuestion": boardCode = 22; break;
			case "etcQuestion": boardCode = 23; break;
			default: System.out.println("관리자에게 문의하세요"); break;
			}
		}



		Map<String,Object> mtmConsulting = new HashMap<>();
		mtmConsulting.put("mtmTitle", mtmTitle);
		mtmConsulting.put("mtmContents", mtmContents);
		mtmConsulting.put("boardCode", boardCode);
		mtmConsulting.put("memCode", memCode);

		System.out.println("mtmConsulting : " + mtmConsulting);
		//인서트후 postNo값 받아옴 
		int result = userService.registMtmConsultingText(mtmConsulting);

		System.out.println("result : " + result);

		//		int postNo = postInfo.getPostNo();


		//파일테이블 파일타입 설정값
		String fileType ="";
		switch (memType) {
		case "ceo": fileType = "owner";	break;
		case "user": fileType = "user";	break;
		default: System.out.println("올바르지 못한 사용자 입니다."); break;
		}

		/* 파일을 저장할 경로 설정 */
		String root = request.getSession().getServletContext().getRealPath("resources");
		System.out.println("root : " + root);

		String filePath = root + "\\uploadFiles";

		System.out.println("filePath :" + filePath);
		File mkdir = new File(filePath);
		if(!mkdir.exists()) {
			mkdir.mkdirs();
		}
		System.out.println("멀티파일 사이즈" + multiFiles.size());
		List<Map<String,String>> files = new ArrayList<>();
		for(int i = 0; i < multiFiles.size(); i++) {

			if(multiFiles.get(i) !=null && !multiFiles.get(i).isEmpty()) {

				/* 파일명 변경 처리 */
				String originFileName = multiFiles.get(i).getOriginalFilename();
				String ext = originFileName.substring(originFileName.lastIndexOf("."));
				String savedName = UUID.randomUUID().toString().replace("-", "") + ext;
				System.out.println("변경되어 저장되는 파일 이름 : " + savedName);
				/* 파일에 관한 정보 추출 후 보관 */
				//데이터페이스에 쓸 내용
				Map<String,String> file = new HashMap<>();
				file.put("originFileName", originFileName);
				file.put("savedName", savedName);
				file.put("filePath", filePath);
				files.add(file);
			} else {

				/* 파일에 관한 정보 추출 후 보관 */
				//데이터페이스에 쓸 내용
				Map<String,String> file = new HashMap<>();
				file.put("originFileName", "");
				file.put("savedName", "");
				file.put("filePath", "");
				files.add(file);

			}


		}



		//파일저장
		int fileUploadResult = 0;
		try {

			for(int i = 0; i < multiFiles.size(); i++) {
				if(multiFiles.get(i) !=null && !multiFiles.get(i).isEmpty()) {

					Map<String,String> file = files.get(i);//반복하며 하나씩 업로드
					multiFiles.get(i).transferTo(new File(filePath + "\\" + file.get("savedName")));

					String fileLocation = "resources/uploadFiles/" + file.get("savedName");//DB에 올릴 파일경로 및 파일명
					System.out.println("올라가는 파일명 및 이름  : " + fileLocation);
					System.out.println("save : " + file.get("savedName"));
					Map<String,Object> fileInfo = new HashMap<>();
					fileInfo.put("boardCode", boardCode);
					fileInfo.put("fileLocation", fileLocation);
					fileInfo.put("fileType", fileType);
					fileUploadResult += userService.registMtmConFile(fileInfo);
				} else {

					Map<String,String> file = files.get(i);//반복하며 하나씩 업로드

					String fileLocation = "";//DB에 올릴 파일경로 및 파일명
					System.out.println("올라가는 파일명 및 이름  : " + fileLocation);
					System.out.println("save : " + file.get("savedName"));
					Map<String,Object> fileInfo = new HashMap<>();
					fileInfo.put("boardCode", boardCode);
					fileInfo.put("fileLocation", fileLocation);
					fileInfo.put("fileType", fileType);
					fileUploadResult += userService.registMtmConFile(fileInfo);
				}
			}



			mv.addAttribute("message","파일업로드 성공");
			if(fileUploadResult == multiFiles.size() ) {
				System.out.println("정상적으로 파일이 처리됨");
			} else {
				System.out.println("파일업로드 갯수가 " + fileUploadResult + "개 입니까? 숫자가 맞다면 정상적으로 처리되었습니다." );
			}
		} catch (IllegalStateException | IOException e) {
			//실패시파일삭제

			for(int i = 0; i < multiFiles.size(); i++) {
				if(multiFiles.get(i) !=null && !multiFiles.get(i).isEmpty()) {
					Map<String,String> file = files.get(i);
					new File(filePath + "\\" + file.get("savedName")).delete(); 

				} else {
					break;
				}
			}

			//				e.printStackTrace();
		}


		return "user/userCustomerServiceCenterMTMQnADetail";
	}

	/**@author 양윤제
	 * @category 1:1상담내용 수정 직전 내용 출력 
	 */
	@GetMapping("ucc/MTMChange")
	public String userCustomerServiceCenterMTMQnAChange(HttpSession session, @RequestParam(required = false) Map<String,String> parameters, Model mv) {

		int postNo = Integer.parseInt(parameters.get("postNo"));

		System.out.println("postNo : " + postNo);

		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");

		int memCode = memberInfo.getMemCode();

		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("postNo", postNo);
		searchMap.put("memCode", memCode);

		//포스트 내용 불러 오기
		PostDTO consultingCon = userService.selectConsultingCon(searchMap);

		System.out.println("consultingCon : " + consultingCon);

		//포스트 첨부 이미지파일 출력(소비자, 사업자)
		List<FileDTO> userFileImg = userService.selectConsumerImg(postNo);

		System.out.println("소비자, 사업자 파일 내용 : " + userFileImg);

		//포스트 첨부 이미지 파일 츌룍(관리자)
		//		List<FileDTO> managerFileImg = userService.selectManagerImg(postNo);

		//		System.out.println("관리자 첨부 파일 내용 : " +  managerFileImg);

		mv.addAttribute("consultingCon", consultingCon);
		mv.addAttribute("userFileImg", userFileImg);
		//		mv.addAttribute("managerFileImg", managerFileImg);

		return "user/userCustomerServiceCenterMTMQnAChange";
	}


	/**
	 * @author 양윤제
	 * @category 1:1 상담 게시글 수정
	 * @return
	 */
	@PostMapping("ucc/MTMDAmd")
	public String userCustomerServiceCenterMTMQnAAmendment(@RequestParam(required = false) List<MultipartFile> multiFiles, HttpServletRequest request, Model mv, HttpSession session) {

		String mtmTitle = request.getParameter("title");//상담제목
		//		String mtmSort = request.getParameter("mtmSort");//질문 유형
		String mtmContents = request.getParameter("content");//상담 본문
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		int fileCode0 = Integer.parseInt(request.getParameter("fileCode0"));
		int fileCode1 = Integer.parseInt(request.getParameter("fileCode1"));
		int fileCode2 = Integer.parseInt(request.getParameter("fileCode2"));
		List<Integer> fileCode = new ArrayList<>();
		fileCode.add(fileCode0);
		fileCode.add(fileCode1);
		fileCode.add(fileCode2);


		System.out.println("mtmTitle : " + mtmTitle);
		//		System.out.println("mtmSort : " + mtmSort);
		System.out.println("mtmContents : " + mtmContents);
		System.out.println("multiFiles : " + multiFiles);
		System.out.println("postNo : " + postNo);
		System.out.println("fileCode0 : " + fileCode0);
		System.out.println("fileCode1 : " + fileCode1);
		System.out.println("fileCode2 : " + fileCode2);
		System.out.println("fileCode리스트 : " + fileCode);

		//유저와 유저 종류(사업자, 소비자) 정보
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("로그인 멤버: " + memberInfo);
		//유저 코드
		int memCode = memberInfo.getMemCode();
		System.out.println("로그인한 멤버의 멤버 코드: " + memCode);
		//유저 종류
		String memType = memberInfo.getMemType();
		System.out.println("멤버 타입 : " + memType);

		Map<String,Object> mtmConsulting = new HashMap<>();
		mtmConsulting.put("mtmTitle", mtmTitle);
		mtmConsulting.put("mtmContents", mtmContents);
		mtmConsulting.put("postNo", postNo);
		mtmConsulting.put("memCode", memCode);

		System.out.println("mtmConsulting : " + mtmConsulting);
		//텍스트 업데이트  
		int result = userService.updateMtmConsultingText(mtmConsulting);

		System.out.println("result : " + result);
		System.out.println("multiFiles : " + multiFiles);

		if(!multiFiles.isEmpty()) {
			/* 파일을 저장할 경로 설정 */
			String root = request.getSession().getServletContext().getRealPath("resources");
			System.out.println("root : " + root);

			String filePath = root + "\\uploadFiles";

			System.out.println("filePath :" + filePath);
			File mkdir = new File(filePath);
			if(!mkdir.exists()) {
				mkdir.mkdirs();
			}
			System.out.println("멀티파일 사이즈" + multiFiles.size());
			List<Map<String,String>> files = new ArrayList<>();
			for(int i = 0; i < multiFiles.size(); i++) {

				if(multiFiles.get(i) !=null && !multiFiles.get(i).isEmpty()) {

					/* 파일명 변경 처리 */
					String originFileName = multiFiles.get(i).getOriginalFilename();
					String ext = originFileName.substring(originFileName.lastIndexOf("."));
					String savedName = UUID.randomUUID().toString().replace("-", "") + ext;
					System.out.println("변경되어 저장되는 파일 이름 : " + savedName);
					/* 파일에 관한 정보 추출 후 보관 */
					//데이터페이스에 쓸 내용
					Map<String,String> file = new HashMap<>();
					file.put("originFileName", originFileName);
					file.put("savedName", savedName);
					file.put("filePath", filePath);
					files.add(file);
				} else {

					/* 파일에 관한 정보 추출 후 보관 */
					//데이터페이스에 쓸 내용
					Map<String,String> file = new HashMap<>();
					file.put("originFileName", "");
					file.put("savedName", "");
					file.put("filePath", "");
					files.add(file);

				}


			}

			//파일저장
			int fileUploadResult = 0;
			try {

				for(int i = 0; i < multiFiles.size(); i++) {
					if(multiFiles.get(i) !=null && !multiFiles.get(i).isEmpty()) {

						Map<String,String> file = files.get(i);//반복하며 하나씩 업로드
						multiFiles.get(i).transferTo(new File(filePath + "\\" + file.get("savedName")));

						String fileLocation = "resources/uploadFiles/" + file.get("savedName");//DB에 올릴 파일경로 및 파일명
						System.out.println("올라가는 파일명 및 이름  : " + fileLocation);
						System.out.println("save : " + file.get("savedName"));
						Map<String,Object> fileInfo = new HashMap<>();
						fileInfo.put("fileCode", fileCode.get(i));
						fileInfo.put("fileLocation", fileLocation);
						fileInfo.put("postNo", postNo);
						fileUploadResult += userService.updateMtmConFile(fileInfo);
					} 

				}

				mv.addAttribute("message","파일업로드 성공");
				if(fileUploadResult == multiFiles.size() ) {
					System.out.println("정상적으로 파일이 처리됨");
				} else {
					System.out.println("파일업로드 갯수가 " + fileUploadResult + "개 입니까? 숫자가 맞다면 정상적으로 처리되었습니다." );
				}
			} catch (IllegalStateException | IOException e) {
				//실패시파일삭제

				for(int i = 0; i < multiFiles.size(); i++) {
					if(multiFiles.get(i) !=null && !multiFiles.get(i).isEmpty()) {
						Map<String,String> file = files.get(i);
						new File(filePath + "\\" + file.get("savedName")).delete(); 

					} else {
						break;
					}
				}

				//					e.printStackTrace();
			}

		}

		return "redirect:/user/ucc/MTMOpen?postNo=" + postNo;
	}

	@PostMapping(value = "ucc/imgDel", produces="application/json; charset=UTF-8")
	@ResponseBody
	public void mtmDelImg(HttpSession session, @RequestParam(required = false) Map<String,String> parameters, Model mv) {

		int fileCode = Integer.parseInt(parameters.get("fileCode"));
		System.out.println("fileCode : " + fileCode);
		String cameraImg = "resources/uploadFiles/camera.png";

		Map<String, Object> delImgInfo = new HashMap<>();
		delImgInfo.put("fileCode", fileCode);
		delImgInfo.put("cameraImg", cameraImg);

		int result = userService.updateDelImg(delImgInfo);

		if( result > 0) {
			System.out.println("파일 삭제 성공");
		} else {
			System.out.println("파일 삭제 실패");
		}

	}

	/**
	 * @author 양윤제
	 * @category 1:1 상담 게시글 삭제
	 * @return
	 */
	@PostMapping("ucc/MTMDel")
	public String userCustomerServiceCenterMTMQnADel(HttpSession session, @RequestParam(required = false) Map<String,String> parameters, Model mv ) {

		if(parameters.get("delInfo") != null || !parameters.get("delInfo").isEmpty()) {
			int postNo = Integer.parseInt(parameters.get("delInfo")); //삭제 할 1:1상담게시물
			System.out.println("게시물 번호 : " + postNo);

			int delResult = userService.updateDelConsulting(postNo);

		}

		return "user/userCustomerServiceCenterNoticeSelect";
	}


	/**@author 양윤제
	 * @category 1:1상담내용 열람
	 */
	@GetMapping("ucc/MTMOpen")
	public String userCustomerServiceCenterMTMQnADetail(HttpSession session, @RequestParam(required = false)Map<String,String> parameters, Model mv) {

		int postNo = Integer.parseInt(parameters.get("postNo"));

		System.out.println("postNo : " + postNo);

		MemberDTO memberInfo = (MemberDTO) session.getAttribute("loginMember");

		int memCode = memberInfo.getMemCode();

		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("postNo", postNo);
		searchMap.put("memCode", memCode);

		//포스트 내용 불러 오기
		PostDTO consultingCon = userService.selectConsultingCon(searchMap);

		System.out.println("consultingCon : " + consultingCon);

		//포스트 첨부 이미지파일 출력(소비자, 사업자)
		List<FileDTO> userFileImg = userService.selectConsumerImg(postNo);

		System.out.println("소비자, 사업자 파일 내용 : " + userFileImg);

		//포스트 첨부 이미지 파일 츌룍(관리자)
		List<FileDTO> managerFileImg = userService.selectManagerImg(postNo);

		System.out.println("관리자 첨부 파일 내용 : " +  managerFileImg);

		mv.addAttribute("consultingCon", consultingCon);
		mv.addAttribute("userFileImg", userFileImg);
		mv.addAttribute("managerFileImg", managerFileImg);

		return "user/userCustomerServiceCenterMTMQnADetail";
	}



	/**@author 양윤제
	 * @category 공지사항 게시글 목룍 출력
	 */
	@GetMapping("ucc/uccNoticeSelect")
	public String userCustomerServiceCenterNoticeSelect(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {
		System.out.println("공지사항 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = parameters.get("searchCondition");
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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
		List<PostDTO> noticeList = userService.selectNotice(selectCriteria);
		System.out.println(" 공지리스트 : " + noticeList);

		/*중요공지 출력*/

		List<PostDTO> importantNotice = userService.selectImportantNotice();
		System.out.println("중요 공지 사항 리스트 : " + importantNotice);

		mv.addAttribute("noticeList", noticeList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("importantNotice", importantNotice);

		return "user/userCustomerServiceCenterNoticeSelect";
	}

	/**@author 양윤제
	 * @category 공지사항 게시글 내용 출력
	 */
	@GetMapping("ucc/uccNoticeDetail")
	public String userCustomerServiceCenterNoticeDetail(HttpSession session,  Model mv, @RequestParam("postNo") String postInfo) {

		System.out.println("공지사항 내용 출력 콘트롤러 진입");
		int postNo = Integer.parseInt(postInfo);
		System.out.println("PostNo : " + postNo);

		/*조회수 수정*/
		int result = userService.updateIncrementBoardCount(postNo);
		if( result > 0) {
			System.out.println("조회수 증가 성공");
		} else {
			System.out.println("조회수 증가 실패");
		}

		List<PostDTO> noticeContentList = userService.selectNoticeContents(postNo);

		System.out.println("공지사항 내용출력 " + noticeContentList);

		mv.addAttribute("noticeContentList",noticeContentList);

		return "user/userCustomerServiceCenterNoticeDetail";
	}

	/**@author 양윤제
	 * @category 자주하는 질문(전체)
	 */
	@GetMapping("ucc/uccOftenQuestion")
	public String userFqaMain(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {

		System.out.println("FQA관련 메인 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = "total";
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectFqaTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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

		List<PostDTO> fqaList = userService.selectFqaList(selectCriteria); 

		System.out.println("fqa회원관리 : " + fqaList);


		/* FQA title 전달 */

		String boardTitle = "전체";


		mv.addAttribute("fqaList", fqaList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("boardTitle", boardTitle);

		return "user/userCustomerServiceOftenQuestionBase";
	}


	/**@author 양윤제
	 * @category 자주하는 질문(회원가입관련)
	 */
	@GetMapping("ucc/memberJoinFqa")
	public String userMemberJoinFqa(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {

		System.out.println("FQA 회원가입 관련 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = "memberJoinQuestion";
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectFqaTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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

		List<PostDTO> fqaList = userService.selectFqaList(selectCriteria); 

		System.out.println("fqa회원관리 : " + fqaList);
		/* FQA title 전달 */
		//		System.out.println("테스트: " + fqaList.get(0));

		String boardTitle = "회원가입";


		mv.addAttribute("fqaList", fqaList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("boardTitle", boardTitle);

		return "user/userCustomerServiceOftenQuestionBase";
	}

	/**@author 양윤제
	 * @return 자주하는 질문(결제주문)
	 */
	@GetMapping("ucc/paycheckFqa")
	public String userPaycheckFqa(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {



		System.out.println("FQA 결제주문 관련 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = "billAndOrderQuestion";//BOARD_TBL, D_TYPE
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectFqaTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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

		List<PostDTO> fqaList = userService.selectFqaList(selectCriteria); 

		System.out.println("fqa결제주문 : " + fqaList);

		/* FQA title 전달 */

		String boardTitle = "결제/주문";

		mv.addAttribute("fqaList", fqaList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("boardTitle", boardTitle);

		return "user/userCustomerServiceOftenQuestionBase";
	}

	/**@author 양윤제
	 * @return 자주하는 질문(리뷰관리)
	 */
	@GetMapping("ucc/reviewFqa")
	public String userReviewFqa(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {

		System.out.println("FQA 리뷰관리 관련 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = "reviewManagementQuestion";//BOARD_TBL, D_TYPE
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectFqaTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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

		List<PostDTO> fqaList = userService.selectFqaList(selectCriteria); 

		System.out.println("fqa리뷰관리 : " + fqaList);

		/* FQA title 전달 */

		String boardTitle = "리뷰관리";


		mv.addAttribute("fqaList", fqaList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("boardTitle", boardTitle);

		return "user/userCustomerServiceOftenQuestionBase";
	}

	/**@author 양윤제
	 * @return 자주하는 질문(이용문의)
	 */
	@GetMapping("ucc/usingFqa")
	public String userUsingFqa(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {


		System.out.println("FQA 이용문의 관련 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = "userQuestion";//BOARD_TBL, D_TYPE
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectFqaTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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

		List<PostDTO> fqaList = userService.selectFqaList(selectCriteria); 

		System.out.println("fqa이용문의 : " + fqaList);

		/* FQA title 전달 */

		String boardTitle = "이용문의";


		mv.addAttribute("fqaList", fqaList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("boardTitle", boardTitle);



		return "user/userCustomerServiceOftenQuestionBase";
	}

	/**@author 양윤제
	 * @return 자주하는 질문(불편관리)
	 */
	@GetMapping("ucc/inconFqa")
	public String userInconFqa(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {


		System.out.println("FQA 불편관리 관련 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = "inconvenienceQuestion";//BOARD_TBL, D_TYPE
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectFqaTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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

		List<PostDTO> fqaList = userService.selectFqaList(selectCriteria); 

		System.out.println("fqa불편관리 : " + fqaList);

		/* FQA title 전달 */

		String boardTitle = "불편관리";


		mv.addAttribute("fqaList", fqaList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("boardTitle", boardTitle);

		return "user/userCustomerServiceOftenQuestionBase";
	}

	/**@author 양윤제
	 * @return 자주하는 질문(기타)
	 */
	@GetMapping("ucc/etcFqa")
	public String userEtcFqa(HttpSession session, Model mv, @RequestParam(required = false) Map<String, String> parameters) {		

		System.out.println("FQA 불편관리 관련 콘트롤러 진입");

		/* 목록보기를 눌렀을 시 가장 처음에 보여지는 페이지는 1페이지이다.
		 * 파라미터로 전달되는 페이지가 있는 경우 currentPage는 파라미터로 전달받은 페이지 수 이다.
		 * */
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

		String searchCondition = "etcQuestion";//BOARD_TBL, D_TYPE
		String searchValue = parameters.get("searchValue");

		System.out.println("searchCondition : " + searchCondition);
		System.out.println("searchValue : " + searchValue);
		System.out.println("pageNo : " + pageNo);

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		System.out.println("searchMap : " + searchMap);



		/* 전체 게시물 수가 필요하다.
		 * 데이터베이스에서 먼저 전체 게시물 수를 조회해올 것이다.
		 * 검색조건이 있는 경우 검색 조건에 맞는 전체 게시물 수를 조회한다.
		 * */

		int totalCount = userService.selectFqaTotalCount(searchMap);

		System.out.println("totalPostCount : " + totalCount);

		/* 한 페이지에 보여 줄 게시물 수 */
		int limit = 10;		//얘도 파라미터로 전달받아도 된다.
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

		List<PostDTO> fqaList = userService.selectFqaList(selectCriteria); 

		System.out.println("fqa기타 : " + fqaList);

		/* FQA title 전달 */

		String boardTitle = "기타";


		mv.addAttribute("fqaList", fqaList);
		mv.addAttribute("selectCriteria", selectCriteria);
		mv.addAttribute("boardTitle", boardTitle);

		return "user/userCustomerServiceOftenQuestionBase";
	}

	@PostMapping(value="ucc/countingFqa", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String incrementVcountFqa(@RequestParam(required = false) Map<String,String> parameters) {

		int postNo = Integer.parseInt(parameters.get("postNo"));

		System.out.println("postNo : " + postNo);

		int result = userService.updateVcountFqa(postNo);

		System.out.println("result : " + result);

		return result > 0? "1" : "0";
	}


	/**
	 * 장바구니 상품 조회 & 상품 담기 
	 * @author ShinHyungi, ParkHaejin
	 * @param amount
	 * @param sdCode
	 * @param session
	 * @return "user/shoppingBasket"
	 */
	@RequestMapping("insertCart")
	public String insertCart(@RequestParam("amount") int amount, @RequestParam("sdCode") int sdCode, 
			@RequestParam("price") int price, HttpSession session) {
		
		System.out.println("amount : " + amount);
		System.out.println("sdCode : " + sdCode);
		System.out.println("price : " + price);
		
		MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
		System.out.println("member :" + member);
	
		HashMap<String,Integer> order = new HashMap<String,Integer>();
		order.put("sdCode", sdCode);
		order.put("amount", amount);
		order.put("memCode", member.getMemCode());
		order.put("totalPrice", price*amount);
		System.out.println("order : " + order);
		
		int count = userService.selectCountCart(order); //장바구니에 기존 상품이 있는지 조회 
		System.out.println("count : " + count);
		
		if(count == 0) {
			userService.insertCart(order); // 장바구니에 상품이 0개이면 insert  
		} else {
			userService.updateCart(order); // 장바구니에 상품이 0개이상이면 update 
		}
				
		return "redirect:/user/cart";
	
	}
	

	/**
	 * 장바구니 리스트 조회 
	 * @author ShinHyungi, ParkHaejin
	 * @param model
	 * @param session
	 * @return "user/shoppingBasket"
	 */
	@GetMapping("cart")
		public String cart(Model model,  HttpSession session) {
			
			MemberDTO member = (MemberDTO)session.getAttribute("loginMember"); 
			System.out.println("member : " + member);
			
			List<CartDTO> cartList = userService.cartList(member);
						
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("cartList", cartList); 
			System.out.println("map : " + map);
			
			model.addAttribute("map", map);
			System.out.println("model : " + model);
		return "user/shoppingBasket";
	}
	
	/**
	 * 장바구니 상품 삭제하기 
	 * @author ParkHaejin
	 * @param model
	 * @param session
	 * @param deleteList
	 * @return "user/shoppingBasket"
	 */
	@GetMapping("deleteCart")
	public String deleteCart(Model model, HttpSession session, @RequestParam(value = "deleteList", required = false) int[] deleteList){
		
		MemberDTO member = (MemberDTO)session.getAttribute("loginMember");
		int memCode = member.getMemCode();
		System.out.println("memCode : " + memCode);
		
		System.out.println("deleteList : " + deleteList);
		System.out.println("deleteList : " + deleteList[0]);
		System.out.println("deleteList : " + deleteList.length);
		
		List<Integer> deleteCartList = new ArrayList<>();
		
		for(int i = 0; i < deleteList.length; i++) {
			deleteCartList.add(deleteList[i]); 
	
		}
		
		System.out.println("deleteCartList : " + deleteCartList);
		
		HashMap<String,Object> deleteCartProduct = new HashMap<String,Object>();
		deleteCartProduct.put("deleteCartList", deleteCartList);
		deleteCartProduct.put("memCode", memCode);
		
		int result = userService.deleteCartList(deleteCartProduct);
		System.out.println("result : " + result);
		
		if(result > 0) {
			System.out.println("deleteCartList Service성공");
		} else {
			System.out.println("deleteCartList Service실패");
		}
		
		return "redirect:/user/cart";
	}
	
	/**
	 * 방문포장 버튼 누르면 주문 정보 insert, select
	 * @author shinhyungi,haejinpark,kimjuhwan
	 * @param model
	 * @param session
	 * @param orderPrice
	 * @param storeCode
	 * @param storeName
	 * @return
	 */
	@GetMapping("packagePay")
	   public String packagePay(Model model, HttpSession session, @RequestParam(value = "orderList", required = false) int[] orderPrice, 
			   @RequestParam(value="storeCode",required = false) int[] storeCode , @RequestParam String[] storeName
	         , @RequestParam int[] sdCode, @RequestParam String[] sdName, @RequestParam int[] amount) {

	
	      MemberDTO member = (MemberDTO)session.getAttribute("loginMember"); 
	      int memCode = member.getMemCode();
	      
	      System.out.println("memCode : " + memCode);
	      
	      System.out.println("orderPrice : " + orderPrice);
	      System.out.println("orderPrice : " + orderPrice[0]);
	      System.out.println("orderPrice : " + orderPrice.length);
	      
	      
	      List<Integer> packagePayList = new ArrayList<>();
	      
	      for(int i = 0; i < orderPrice.length; i++) {
	         packagePayList.add(orderPrice[i]);
	      }
	      
	      System.out.println("packagePayList : " + packagePayList);
	      

	      for(int sc : storeCode) {
	         System.out.println("storeCode : " + sc);
	      }
	      
	      for(String st : storeName) {
	         System.out.println("storeName : " + storeName);
	      }
	      
		  for(int sdCode2 : sdCode) {
			  System.out.println("sdCode : " + sdCode2);
		  }
		
		  for(String sdName2 : sdName) {
			  System.out.println("sdName : " + sdName2);
		  }
		  
	      for(int amount2 : amount) {
	    	  System.out.println("amount : " + amount2);
	      }
	      

	      HashMap<String, Object> insertPackage = new HashMap<String, Object>();
	      insertPackage.put("memCode", memCode);
	      insertPackage.put("packagePayList", packagePayList);
	      insertPackage.put("storeCode", storeCode);
	      insertPackage.put("storeName", storeName);
	      insertPackage.put("sdCode", sdCode);
	      insertPackage.put("sdName", sdName);
	      insertPackage.put("amount", amount);
	      
	      
	      Map<String,Object> result = userService.insertPackageOrderList(insertPackage);
	      System.out.println("result : " + result);
	      if ((int)result.get("result") > 0 ) {
	         System.out.println("insertPackage Service 성공");
	      } else {
	         System.out.println("insertPackage Service 실패");
	      }
	      
	      // 주문 내역 및 쿠폰 가져오기
	      List<Integer> orderCodes =  (List<Integer>) result.get("orderCodes");
	      List<Map<String, String>> orderList = userService.selectOrderList(orderCodes); 
	      model.addAttribute("orderList", orderList);
	      List<CouponDTO> couponList = userService.selectCouponList(member.getMemCode());
	      model.addAttribute("couponList", couponList);
	      
	      for(CouponDTO c : couponList) {
	         System.out.println("coupon : " + c);
	      }
	      
	      return "user/packagePay";
	   }
	
	
	
	
	
	/**@author ShinHyungi , ParkHaejin
	 * 포장 주문 시작할 때 생성된 주문 업데이트 & 방문포장 결제 완료 조회
	 * @return "user/selectPackageOrderComplete";
	 */
	@GetMapping("payComplete")
	public String payComplete(Model model, @RequestParam("orderCodes") int[] orderCodes, @RequestParam("totalPrice") int[] totalPrice,
			@RequestParam("phone") String phone, @RequestParam("time") String[] time, @RequestParam("couponCodes") int[] couponCodes) {
		
		  System.out.println(orderCodes[0]);
		  List<Map<String, Object>> list = new ArrayList<>();
		  Map<String, Object> map = null;
		  for(int i = 0; i < orderCodes.length; i++) {
			map = new HashMap<>();
			map.put("orderCode",orderCodes[i]);
			map.put("totalPrice",totalPrice[i]);
			System.out.println(orderCodes[i] + " : " + totalPrice[i]);
			map.put("phone",phone);
			map.put("time",time[i]);

			list.add(map);
	
				
			}
			// 쿠폰 사용 완료 표시
			List<Integer> list2 = new ArrayList<>();
			for(int c : couponCodes) {
				list2.add(c);
			}
			
			int result = userService.updateOrder(list);
			int result2 = 0;
			if(!list2.isEmpty()) {
				result2 = userService.updateCouponStatus(list2);
			}
			
			if(result > 0) {
				model.addAttribute("message", "업데이트 성공");
				if(result2 > 0) {
					System.out.println("쿠폰 업뎃 완료~");
				}
			} else {
				model.addAttribute("message", "업데이트 실패");
			}
			
			List<Map<String,Object>> orderList = userService.selectPackageOrderComplete(list); //방문포장 결제 완료 조회
			System.out.println("orderList : " + orderList);
			
			model.addAttribute("orderList", orderList);
			System.out.println("model : " + model);
			
			
			return "user/packageOrderComplete";
		}
	

	
	/**
	    * 배달 버튼 누르면 장바구니 정보 insert 
	    * @author leeseungwoo
	    * @param model
	    * @param session
	    * @param orderList
	    * @param storeCode
	    * @param storeName
	    * @return "redirect:/paymentDelivery"    
	    * */
	   @GetMapping("deliveryPay")
	   public String deliveryPay(Model model, HttpSession session, @RequestParam(value = "orderList", required = false) int[] orderList, 
	         @RequestParam(value="storeCode",required = false) int[] storeCode, @RequestParam String[] storeName, 
	         @RequestParam int[] sdCode, @RequestParam String[] sdName, @RequestParam int[] amount) {

	      MemberDTO member = (MemberDTO)session.getAttribute("loginMember"); 
	      int memCode = member.getMemCode();
	      
	      System.out.println("memCode : " + memCode);
	      
	      System.out.println("orderList : " + orderList);
	      System.out.println("orderList : " + orderList[0]);
	      System.out.println("orderList : " + orderList.length);
	      
	      List<Integer> deliveryPayList = new ArrayList<>();
	      
	      for(int i = 0; i < orderList.length; i++) {
	         deliveryPayList.add(orderList[i]);
	      }
	      
	      System.out.println("deliveryPayList : " + deliveryPayList);
	      
	      for(int sc : storeCode) {
	         System.out.println("storeCode : " + sc);
	      }
	      
	      for(String sn : storeName) {
	         System.out.println("storeName : " + sn);
	      }
	      
	      for(int sdCode2 : sdCode) {
			  System.out.println("sdCode : " + sdCode2);
		  }
		
		  for(String sdName2 : sdName) {
			  System.out.println("sdName : " + sdName2);
		  }
		  
	      for(int amount2 : amount) {
	    	  System.out.println("amount : " + amount2);
	      }
	      
	      HashMap<String, Object> insertDelivery = new HashMap<String, Object>();
	      insertDelivery.put("deliveryPayList", deliveryPayList);
	      insertDelivery.put("memCode", memCode);
	      insertDelivery.put("storeCode", storeCode);
	      insertDelivery.put("storeName", storeName);
	      insertDelivery.put("sdCode", sdCode);
	      insertDelivery.put("sdName", sdName);
	      insertDelivery.put("amount", amount);
	      
	      Map<String,Object> result = userService.insertDeliveryOrderList(insertDelivery);
	      System.out.println("result : " + result);
	      if ((int)result.get("result") > 0 ) {
	         System.out.println("insertDelivery Service 성공");
	      } else {
	         System.out.println("insertDelivery Service 실패");
	      }
	      
	      // 주문 내역 & 배송비 가져오기
	      List<Integer> orderCodes =  (List<Integer>) result.get("orderCodes");
	      List<Map<String, String>> orderList2 = userService.selectOrderList(orderCodes); 
	      model.addAttribute("orderList", orderList2);
	      List<CouponDTO> couponList = userService.selectCouponList(member.getMemCode());
	      model.addAttribute("couponList", couponList);
	      
	      for(CouponDTO c : couponList) {
	         System.out.println("coupon : " + c);
	      }
	      
	      return "user/deliveryPay";
	      
	   }
	
	
	/**
	    * 배달주문 결제 시 주문내역 업데이트
	    * @param model
	    * @param orderCodes
	    * @param totalPrice
	    * @param phone
	    * @param time
	    * @param couponCodes
	    * @param zipCode
	    * @param address
	    * @param detailAddress
	    * @return
	    * @author leeseungwoo
	    */
	   @GetMapping("payComplete2")
	   public String payComplete2(Model model, @RequestParam("orderCodes") int[] orderCodes, @RequestParam("totalPrice") int[] totalPrice,
	         @RequestParam("phone") String phone, @RequestParam("time") String time, @RequestParam("couponCodes") int[] couponCodes,
	         @RequestParam("zipCode") String zipCode, @RequestParam("address") String address, @RequestParam("detailAddress") String detailAddress) {
	      
	      System.out.println(orderCodes[0]);
	      List<Map<String, Object>> list = new ArrayList<>();
	      Map<String, Object> map = null;
	      for(int i = 0; i < orderCodes.length; i++) {
	         map = new HashMap<>();
	         map.put("orderCode",orderCodes[i]);
	         map.put("totalPrice",totalPrice[i]);
	         System.out.println(orderCodes[i] + " : " + totalPrice[i]);
	         map.put("phone",phone);
	         map.put("time",time);
	         map.put("zipCode",zipCode);
	         map.put("address",address);
	         map.put("detailAddress",detailAddress);
	         list.add(map);
	      }
	      // 쿠폰 사용 완료 표시
	      List<Integer> list2 = new ArrayList<>();
	      for(int c : couponCodes) {
	         list2.add(c);
	      }
	      
	      int result = userService.updateOrder2(list);
	      int result2 = 0;
	      if(!list2.isEmpty()) {
	         result2 = userService.updateCouponStatus(list2);
	      }
	      
	      if(result > 0) {
	         model.addAttribute("message", "업데이트 성공");
	         if(result2 > 0) {
	            System.out.println("쿠폰 업뎃 완료~");
	         }
	      } else {
	         model.addAttribute("message", "업데이트 실패");
	      }
	      
			List<Map<String,Object>> orderList = userService.selectDeliveryOrderComplete(list); //방문포장 결제 완료 조회
			System.out.println("orderList : " + orderList);
			
			model.addAttribute("orderList", orderList);
			System.out.println("model : " + model);
			
	      
	      
	      return "user/deliveryOrderComplete";
	   }
	
		

	/**
	 * 주문 결제 취소
	 * @author shinhyungi
	 * @param orderCodes
	 * @return "redirect:cart";
	 */
	
	@GetMapping("payCancle")
	public String orderCancle(@RequestParam("orderCodes") int[] orderCodes) {
		
		List<Integer> orderCodeList = new ArrayList<>();
		for(int i : orderCodes) {
			orderCodeList.add(i);
		}
		
		userService.deleteOrder(orderCodeList);
		
		return "redirect:cart";
	}
	
	
	/**
	 * @author ShinHyungi
	 * @param mv
	 * @param category
	 * @param session
	 * @return mv
	 */
	@GetMapping("category")
	public String categoryPage(Model model,@RequestParam(value = "category") String category,@RequestParam(value = "currentPage", required = false) String currentPage , HttpSession session) {
		List<HashMap<String, String>> categoryList = (List<HashMap<String, String>>) session.getAttribute("categoryList");

		String cg = "";
		for(int i = 0; i < categoryList.size(); i++) {
			if(categoryList.get(i).get("CATEGORY_CODE").equals(category)) {
				cg = categoryList.get(i).get("CATEGORY_NAME");
			}
		}

		if(cg.equals("")) {
			cg = "오늘의 추천";
		}

		/* ==== 현재 페이지 처리 ==== */
		int pageNo = 1;

		System.out.println("currentPage : " + currentPage);

		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}

		if(pageNo <= 0) {
			pageNo = 1;
		}

		System.out.println(currentPage);
		System.out.println(pageNo);

		/* ==== 검색 처리 ==== */
		String searchCondition = (String) model.getAttribute("searchCondition");
		String searchValue = (String) model.getAttribute("searchValue");

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchValue", searchValue);
		searchMap.put("category", category);
		System.out.println("searchMap : " + searchMap);
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = userService.selectProductTotalCount(searchMap);

		System.out.println("totalInquiryBoardCount : " + totalCount);

		int limit = 10;
		int buttonAmount = 10;

		Pagination pagination = null;
		if(searchCondition == null && "".equals(searchCondition)) {
			searchCondition = category;
		}

		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, searchValue);
		} else if(searchCondition != null && searchCondition != "전체") {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, category, null);
		}

		System.out.println("pagination : " + pagination);

		List<ProductDTO> productList = userService.selectProductList(pagination);

		System.out.println("리스트 확인 : " + productList);

		if(productList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("productList", productList);
		} else {
			System.out.println("조회실패");
		}

		model.addAttribute("category", cg);

		return "user/category_page";
	}

	/**@author ShinHyungi
	 * @param model
	 * @param currentPage
	 */
	@GetMapping("sale")
	public void todaySale(Model model, @RequestParam(value = "currentPage", required = false) String currentPage) {

		/* ==== 현재 페이지 처리 ==== */
		int pageNo = 1;

		System.out.println("currentPage : " + currentPage);

		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}

		if(pageNo <= 0) {
			pageNo = 1;
		}

		System.out.println(currentPage);
		System.out.println(pageNo);

		/* ==== 검색 처리 ==== */
		String searchCondition = (String) model.getAttribute("searchCondition");
		String searchValue = (String) model.getAttribute("searchValue");

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchValue", searchValue);

		System.out.println("searchMap : " + searchMap);
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = userService.selectProductTotalCount(searchMap);

		System.out.println("totalInquiryBoardCount : " + totalCount);

		int limit = 12;
		int buttonAmount = 10;

		Pagination pagination = null;

		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, searchValue);
		} else if(searchCondition != null && searchCondition != "전체") {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, "sale", null);
		}

		System.out.println("pagination : " + pagination);

		List<ProductDTO> productList = userService.selectProductList(pagination);

		System.out.println("리스트 확인 : " + productList);

		if(productList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("productList", productList);
		} else {
			System.out.println("조회실패");
		}
	}

	/**
	 * @author ShinHyungi
	 * @param mv
	 * @param type
	 * @param model
	 * @return mv
	 */
	@GetMapping("famousStore")
	public String famousStore(@RequestParam(value = "type", required = false) String type, @RequestParam(value = "currentPage", required = false) String currentPage , Model model) {

		String cg = "";
		switch(type) {
		case "new" : cg = "신규 반찬 가게"; break;
		case "famous" : cg = "우리동네 인기 맛집"; break;
		}

		/* ==== 현재 페이지 처리 ==== */
		int pageNo = 1;

		System.out.println("currentPage : " + currentPage);

		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}

		if(pageNo <= 0) {
			pageNo = 1;
		}

		System.out.println(currentPage);
		System.out.println(pageNo);

		/* ==== 검색 처리 ==== */
		String searchCondition = type;
		String searchValue = (String) model.getAttribute("searchValue");

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchValue", searchValue);
		searchMap.put("type", type);
		System.out.println("searchMap : " + searchMap);
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = userService.selectStoreTotalCount(searchMap);

		System.out.println("totalInquiryBoardCount : " + totalCount);

		int limit = 12;
		int buttonAmount = 10;

		Pagination pagination = null;

		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		}

		System.out.println("pagination : " + pagination);

		List<StoreDTO> storeList = userService.selectStoreList(pagination);

		System.out.println("리스트 확인 : " + storeList);

		if(storeList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("storeList", storeList);
		} else {
			System.out.println("조회실패");
		}

		model.addAttribute("type", cg);
		model.addAttribute("realType", type);

		return "user/famousStore";
	}

	/**@author ShinHyungi
	 * @param memCode
	 * @param model
	 * @param currentPage
	 * @return
	 */
	@GetMapping("storepage")
	public String storePage(@RequestParam String memCode, Model model, @RequestParam(value = "currentPage", required = false) String currentPage) {

		Map<String, String> store = userService.selectStoreByMemCode(memCode);
		List<ProductDTO> products = userService.selectProducts(memCode);
		List<String> jjimList = userService.selectJJIMList(memCode);
		System.out.println(store);
		model.addAttribute("jjimList", jjimList);
		/* ==== 현재 페이지 처리 ==== */
		int pageNo = 1;

		System.out.println("currentPage : " + currentPage);

		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}

		if(pageNo <= 0) {
			pageNo = 1;
		}

		/* ==== 검색 처리 ==== */
		String searchCondition = (String) model.getAttribute("searchCondition");
		String searchValue = (String) model.getAttribute("searchValue");

		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("memCode", memCode);

		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = userService.selectReviewTotalCount(searchMap);

		int limit = 10;
		int buttonAmount = 10;

		Pagination pagination = null;
		if(searchCondition == null || "".equals(searchCondition)) {
			searchCondition = memCode;
		}

		pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		System.out.println(pagination);
		List<ReviewDTO> rvList = userService.selectReviewList(pagination);
		System.out.println("리스트 확인 : " + rvList);

		if(rvList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("rvList", rvList);
		} else {
			System.out.println("조회실패");
		}

		model.addAttribute("store", store);
		model.addAttribute("products", products);
		return "user/store_page";
	}
	
	/**@author ShinHyungi
	 * @param sdCode
	 * @param memCode
	 * @param model
	 */
	@GetMapping("sidedish_detail")
	public void orderProduct(@RequestParam("sdCode") int sdCode, @RequestParam("memCode") String memCode ,Model model) {

		ProductDTO product = userService.selectProductBySdCode(sdCode);
		Map<String, String> store = userService.selectStoreByMemCode(memCode);
		model.addAttribute("product", product);
		model.addAttribute("store", store);
	}

	/**@author ShinHyungi
	 * @param rvCode
	 * @param reportType
	 * @return
	 */
	@PostMapping(value = "report", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String report(@RequestParam("rvCodee") int rvCode, @RequestParam("reportType") int reportType) {

		Map<String, Integer> reportInfo = new HashMap<String, Integer>();
		reportInfo.put("rvCode", rvCode);
		reportInfo.put("reportType", reportType);

		int result = userService.insertReport(reportInfo);

		return result > 0? "1" : "0";
	}

	/**@author ShinHyungi
	 * @param memCode
	 * @param model
	 * @return
	 */
	@GetMapping("storeInfo")
	public String storeInfo(@RequestParam("memCode") int memCode, Model model) {
		Map<String, String> store = userService.selectStoreInfoByMemcode(memCode);
		model.addAttribute("store", store);
		return "user/store_info";
	}

	/**@author ShinHyungi
	 * @param model
	 * @param searchValue
	 */
	@PostMapping("searchResult")
	public void search(Model model, @RequestParam(value = "searchValue") String searchValue) {

		List<String> list = new ArrayList<String>();
		Map<String, Object> searchMap = new HashMap<>();
		if(searchValue.contains(",")) {
			String[] words = searchValue.split(",");
			for(String a : words) {
				String word = a.replace("#", "");
				System.out.println("searchValue : " + searchValue);
				if(!word.equals("")) {
					list.add(word);
				}
			}
			searchMap.put("searchValue", list);
		} else {
			if(searchValue.contains("#")) {
				list.add(searchValue.replace("#", ""));
				searchMap.put("searchValue", list);
			} else {
				searchMap.put("searchValue", searchValue);
				searchMap.put("searchCondition", "title");
			}
		}

		List<ProductDTO> productList = userService.selectSearchList(searchMap);
		System.out.println("리스트 확인 : " + productList);

		if(productList != null) {
			model.addAttribute("productList", productList);
		} else {
			System.out.println("조회실패");
		}

	}


	/**@author ShinHyungi
	 * @param storeCode
	 * @param memCode
	 * @return
	 */
	@PostMapping(value = "jjimplus", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String jjimplus(@RequestParam("storeCode") int storeCode, @RequestParam("memCode") int memCode) {

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("storeCode",storeCode);
		map.put("memCode",memCode);

		Integer result = userService.insertJJIMplus(map);

		return result > 0? "삭제 완료" : "삭제 실패";
	}

	/**@author ShinHyungi
	 * @param storeCode
	 * @param memCode
	 * @return
	 */
	@PostMapping(value = "jjimdelete", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String jjimdelete(@RequestParam("storeCode") int storeCode, @RequestParam("memCode") int memCode) {

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("storeCode",storeCode);
		map.put("memCode",memCode);

		Integer result = userService.deleteJJIMplus(map);

		return result > 0? "삭제 완료" : "삭제 실패";
	}


	/**
	 * 주소 검색
	 * @param memCode
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "memberAddress", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MemberDTO memberAddress(@RequestParam("memCode") int memCode) {

		System.out.println("memCode : " + memCode);
		MemberDTO memberAddress = userService.selectMemberAddress(memCode);
		System.out.println("memberAddress : " + memberAddress);

		return memberAddress;
	}
	
}
