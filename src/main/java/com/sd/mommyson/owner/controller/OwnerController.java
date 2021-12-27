package com.sd.mommyson.owner.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sd.mommyson.manager.common.Pagination;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.member.service.MemberService;
import com.sd.mommyson.owner.dto.CouponDTO;
import com.sd.mommyson.owner.dto.CpHistoryDTO;
import com.sd.mommyson.owner.dto.DCProduct;
import com.sd.mommyson.owner.dto.MembershipAndStoreDTO;
import com.sd.mommyson.owner.dto.MembershipDTO;
import com.sd.mommyson.owner.dto.ProductDTO;
import com.sd.mommyson.owner.dto.TagDTO;
import com.sd.mommyson.owner.service.OwnerService;
import com.sd.mommyson.user.dto.OrderDTO;
import com.sd.mommyson.user.dto.ReviewDTO;

@Controller
@RequestMapping("/owner/*")
@SessionAttributes({"loginMember","owner","membership"})
public class OwnerController {
	
	private OwnerService ownerService;
	private BCryptPasswordEncoder passwordEncoder;
	private MemberService memberService;
	
	@Autowired
	public OwnerController(OwnerService ownerService, MemberService memberService , BCryptPasswordEncoder passwordEncoder) {
		
		this.ownerService = ownerService;
		this.memberService = memberService;
		this.passwordEncoder = passwordEncoder;
	}
	
	/* 사업자 마이페이지 메인화면 */
	@GetMapping("ownerMain")
	public String ownerMypage(@ModelAttribute("loginMember") MemberDTO member, Model model) throws ParseException {
		
		MemberDTO owner = ownerService.selectOwner(member);
		
		System.out.println(owner);

		model.addAttribute("owner", owner);
		
		MemberDTO members = (MemberDTO)model.getAttribute("loginMember");
		int memCode = members.getMemCode();
		
		Map<String, Object> memberShip = ownerService.selectMembershipInfo(memCode);
		
		if(memberShip != null && !memberShip.isEmpty()) {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Calendar c1 = Calendar.getInstance(); 
			
			String dd = sdf.format(c1.getTime());
			
			java.util.Date today = sdf.parse(dd);
			
			String startDate = sdf.format(memberShip.get("START_DATE"));
			String endDate = sdf.format(memberShip.get("END_DATE"));
			
			memberShip.put("startDate", startDate);
			memberShip.put("endDate", endDate);
			
			model.addAttribute("membership",memberShip);
			
			List<ProductDTO> proList = ownerService.selectProdoucts(memCode);
			
			int status = 0;
			
			for(ProductDTO i : proList) {
				
				if(i.geteDate().before(today) && !i.getOrderableStatus().equals("X")) {
					
					 status += ownerService.modifyEDateStatus(i.getSdCode());
					
				}
				
			}
			
			System.out.println(status + "행 업데이트 성공!");
		}
		
		return "owner/ownerMain";
	}
	
	/* 쿠폰  리스트 */
	@GetMapping("coupon")
	public String coupon(@ModelAttribute("loginMember") MemberDTO member, Model model, @RequestParam(value = "currentPage", required = false) String currentPage ) {
		
		
		 MemberDTO owner = ownerService.selectOwner(member);
		 System.out.println(owner);
		 
		 int memCode = owner.getMemCode();
		
		/* 주문 접수 페이지 처리  - 조건 없는 페이지 */
		// 현재 페이지
		int pageNo = 1;
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println("현재 페이지 : " + currentPage);

		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = ownerService.selectCouponListTotalCount(memCode); // where 절에 storeName을 써야하니까 넘겨준다
		
		int limit = 10; //페이지당 글 갯수
		int buttonAmount =  10;//페이징 버튼의 갯수
		String searchCondition = String.valueOf(memCode);
		
		Pagination pagination = null;
																	  // 검색 조건이 없으니까 null, null 처리
		pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		System.out.println("페이지 : " + pagination);
		
		List<CouponDTO> coupon = ownerService.selectCoupon(pagination);
		System.out.println("리스트 확인 : " + coupon);
		
		if(coupon != null) {
			//					items 이름 , 리스트이름
			model.addAttribute("pagination",pagination);
			model.addAttribute( "coupon" ,coupon);
		} else {
			System.out.println("조회실패...");
		}
		
		return "owner/coupon";
	}
	

	/* 쿠폰등록*/
	@PostMapping("coupon") 	  // couponDTO를 선언하면 자동으로 값이 담겨져 // memCode를 가져오려면 세션이 필요
	public String couponInsert(@ModelAttribute CouponDTO coupon, RedirectAttributes ra, HttpSession session ) {
															  		// 리다이렉트를 해줄때 값을 넘겨주는...........
		// @ModelAttribute 을 사용하는 순간 DTO에 필드값이랑 name값이 같으면 자동으로 값을 DTO에 담아서 보낸다. 
		
		// root-contect에서 insert는 regist로 시작으로 지정해놓았다
		int result = ownerService.registCoupon(coupon);
		System.out.println("결과를 말하라" + coupon);
		
		//세션에서 memCode를 담아서 넘겨준다.
		MemberDTO member = (MemberDTO)session.getAttribute("loginMember");
		int memCode = member.getMemCode();
		
		int result2 = ownerService.registCouponStore(memCode);
		
		if(result > 0 && result2 > 0) {
			ra.addFlashAttribute("message","쿠폰 등록에 성공하였습니다.");
		} else {
			ra.addFlashAttribute("message","쿠폰 등록에 실패하였습니다.");
		}
		
		return "redirect:coupon"; // getMapping으로 보내준다
	}
	
	//쿠폰 삭제
	@PostMapping("couponDelete") 
	public String couponDelete ( @RequestParam("chkcoupon") int[] deleteCoupon, RedirectAttributes ra) {
		
		List<Integer> deleteCouponList = new ArrayList<>();
		
		for(int i = 0; i < deleteCoupon.length; i++) {
			deleteCouponList.add(deleteCoupon[i]);
		}
		
		int result3 = ownerService.deleteCoupon(deleteCouponList);
		
		if(result3 > 0 ) {
			ra.addFlashAttribute("message","쿠폰 삭제에 성공하였습니다.");
		} else {
			ra.addFlashAttribute("message","쿠폰 삭제에 실패하였습니다.");
		}
		
		return "redirect:coupon";		
	}
	
	/* 가게정보 수정 */
	@GetMapping("modifyStore")
	public void modifyStore(){}
	
	@PostMapping("modifyStore")
	public String updateModifytStore(@RequestParam MultipartFile img, HttpSession session, HttpServletRequest request, RedirectAttributes ra) {
		
		System.out.println("img : " + img);
		
		String storeName = request.getParameter("storeName");
		String address = request.getParameter("address");
		String dAddress = request.getParameter("dAddress");
		String postCode = request.getParameter("postCode");
		String workTime = request.getParameter("workTime");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		String storeInfo = request.getParameter("storeInfo");
		String no = request.getParameter("no");
		
		
		MemberDTO member = (MemberDTO)session.getAttribute("owner");
		System.out.println(member);
		
		
		Map<String, Object> modifyInfo = new HashMap<>();
		modifyInfo.put("storeName", storeName);
		modifyInfo.put("address", address);
		modifyInfo.put("dAddress", dAddress);
		modifyInfo.put("postCode", postCode);
		modifyInfo.put("workTime", workTime);
		modifyInfo.put("phone", phone);
		modifyInfo.put("name", name);
		modifyInfo.put("storeInfo", storeInfo);
		modifyInfo.put("no",no);
		modifyInfo.put("member", member);
		
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
				
				modifyInfo.put("fileName", fileName);
				
				
			} catch (IllegalStateException | IOException e) {
				new File(filePath + "/" + savedName).delete();
					
				e.printStackTrace();
			}
		
		}
		
		int modifyOwner = ownerService.modifyInfo(modifyInfo);
		int modifyCeo = ownerService.modifyCeo(modifyInfo);
		int modifyStore = ownerService.modifyStore(modifyInfo);
		
		System.out.println("modifyOwner : " + modifyOwner);
		System.out.println("modifyCeo : " + modifyCeo);
		System.out.println("modifyStore : " + modifyStore);
		
		if(modifyOwner > 0 && modifyCeo > 0 && modifyStore > 0) {
			ra.addFlashAttribute("message","변경이 완료되었습니다.");
		} else {
			ra.addFlashAttribute("message","변경에 실패하였습니다.");
		}
		
		return "redirect:ownerMain";
	}
	
	/* 비밀번호 변경 */
	@GetMapping("modifyOwnerInfo")
	public void modifyOwnerInfo() {}
	
	@PostMapping("modifyOwnerInfo")
	public ModelAndView modifyOwnerPwd(@RequestParam Map<String, String> info, ModelAndView mv, RedirectAttributes ra,SessionStatus status) {
		
		MemberDTO member = new MemberDTO();
		
		member.setMemPwd(passwordEncoder.encode(info.get("pwd")));
		member.setMemCode(Integer.parseInt(info.get("memCode")));
		
		int modifyPwd = ownerService.modifyPwd(member);
		
		if(modifyPwd > 0) {
			ra.addFlashAttribute("message","비밀번호가 변경되었습니다.");
			status.setComplete();
			mv.setViewName("redirect:/");
		} else {
			mv.addObject("message", "비밀번호 변경에 실패하였습니다.");
			mv.setViewName("modifyOwnerInfo");
		}
		
		return mv;
		
	}
	
	
	/* 상품등록 */
	@GetMapping("productRegist") 
	public void productRegist(Model model){
		
		List<TagDTO> tagList = ownerService.selectTag();
		List<HashMap<String, String>> categoryList = memberService.selectCategoryList();
		
		for(int i = 0; i < categoryList.size(); i++) {
			
			System.out.println("키 좀 알려줘 이지삭아 : " + categoryList.get(i).keySet());
			
		}

		model.addAttribute("tagList",tagList);
		model.addAttribute("categoryList",categoryList);
	}
	
	@PostMapping("productRegist")
	public String registProduct(@RequestParam MultipartFile productImg, HttpSession session, @ModelAttribute ProductDTO product, 
			HttpServletRequest request, RedirectAttributes rd) {
		
		int tag = Integer.parseInt(request.getParameter("tag1"));
		int tag2 = Integer.parseInt(request.getParameter("tag2"));
		int tag3 = Integer.parseInt(request.getParameter("tag3"));
		
		List<Integer> tagList = new ArrayList<Integer>();
		tagList.add(tag);
		tagList.add(tag2);
		tagList.add(tag3);
		
		MemberDTO member = (MemberDTO)session.getAttribute("loginMember");
		int memCode = member.getMemCode();
		
		Map<String,Object> productInfo = new HashMap<String, Object>();
		productInfo.put("product",product);
		productInfo.put("tagList", tagList);
		productInfo.put("memCode", memCode);
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		String filePath = root + "/uploadFiles";
		
		File mkdir = new File(filePath);
		if(!mkdir.exists()) {
			mkdir.mkdirs();
		}
		
		
			String orginFileName = productImg.getOriginalFilename();
			String ext = orginFileName.substring(orginFileName.indexOf("."));
			String savedName = UUID.randomUUID().toString().replace("-", "") + ext;
			
			try {
				productImg.transferTo(new File(filePath + "/" + savedName));
				
				String fileName = "resources/uploadFiles/" + savedName;
				
				productInfo.put("fileName", fileName);
				
				
			} catch (IllegalStateException | IOException e) {
				new File(filePath + "/" + savedName).delete();	
				e.printStackTrace();
			}
			
			int result = ownerService.registProduct(productInfo);
			
			if(result > 0) {
				rd.addFlashAttribute("message","상품이 등록되었습니다.");
			} else {
				rd.addFlashAttribute("message","상품 등록에 실패하였습니다.");
				new File(filePath + "/" + savedName).delete();
			}
		
		return "redirect:productManagement";
	}
	
	/* 리뷰 관리 */
	@GetMapping("review")
	public String selectReview(@ModelAttribute("loginMember") MemberDTO member, Model model,
			@RequestParam(value = "currentPage", required = false) String currentPage, @RequestParam(value = "currentPage", required = false) String currentPage2) {
		
		// MemberDTO 안에 CeoDTo 안에 StoreDTO 안에 storeName 이 존재하니 뽑아서 넘겨준다.
		MemberDTO owner = ownerService.selectOwner(member);
		String storeName = owner.getCeo().getStore().getStoreName();
		System.out.println(storeName);
		
		
		// 주문 접수 페이지 처리  - 조건 없는 페이지
				// 현재 페이지
				int pageNo2 = 1;
				
				if(currentPage2 != null && !"".equals(currentPage2)) {
					pageNo2 = Integer.parseInt(currentPage2);
				}
				
				if(pageNo2 <= 0) {
					pageNo2 = 1;
				}
				
				System.out.println("현재 페이지 : " + currentPage2);

				
				/* ==== 조건에 맞는 게시물 수 처리 ==== */
				int totalCount2 = ownerService.selectReviewListTotalCount(storeName); // where 절에 storeName을 써야하니까 넘겨준다
				
				int limit2 = 10; //페이지당 글 갯수
				int buttonAmount2 =  10;//페이징 버튼의 갯수
				String searchCondition2 = storeName;
				
				Pagination pagination2 = null;
																			  // 검색 조건이 없으니까 null, null 처리
				pagination2 = Pagination.getPagination(pageNo2, totalCount2, limit2, buttonAmount2, searchCondition2, null);
				System.out.println("페이지 : " + pagination2);
				
				List<ReviewDTO> reviews = ownerService.selectReview(pagination2);
				System.out.println("리뷰들아 들어왔니 : " + reviews);	
				
				if(reviews != null) {
					//					items 이름 , 리스트이름
					model.addAttribute("pagination",pagination2);
					model.addAttribute("owner", owner);
					model.addAttribute("reviews",reviews);
				} else {
					System.out.println("조회실패...");
				}
		
		/* 쿠폰 모달 리스트 가져오기 */ 
		 System.out.println(owner);
		 int memCode = owner.getMemCode();
		
		// 주문 접수 페이지 처리  - 조건 없는 페이지
		// 현재 페이지
		int pageNo = 1;
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println("현재 페이지 : " + currentPage);

		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = ownerService.selectCouponListTotalCount(memCode); // where 절에 storeName을 써야하니까 넘겨준다
		
		int limit = 10; //페이지당 글 갯수
		int buttonAmount =  10;//페이징 버튼의 갯수
		String searchCondition = String.valueOf(memCode);
		
		Pagination pagination = null;
																	  // 검색 조건이 없으니까 null, null 처리
		pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		System.out.println("페이지 : " + pagination);
		
		List<CouponDTO> coupon = ownerService.selectCoupon(pagination);
		System.out.println("리스트 확인 : " + coupon);
		
		if(coupon != null) {
			//					items 이름 , 리스트이름
			model.addAttribute("pagination",pagination);
			model.addAttribute( "coupon" ,coupon);
		} else {
			System.out.println("조회실패...");
		}
		
		// 알럿
		model.addAttribute("message",model.getAttribute("message"));
		
		return "owner/review";	
		
	}
	/* 리뷰관리 - 리뷰쓴 고객들에게 쿠폰주기/삭제 인서트 (CP_HISTORY_TBL) */
	//	          form 이름 작성
	@PostMapping("registGiveAndDeleteCp")
	public String registGiveAndDeleteCp(@RequestParam("chkreview") int[] deleteReview, RedirectAttributes ra) {
		
		List<Integer> deleteReviewList = new ArrayList<>();
		
		for(int i = 0; i < deleteReview.length; i++) {
			deleteReviewList.add(deleteReview[i]);
		}
		
		int result = ownerService.deleteReview(deleteReviewList);
		
		if(result > 0 ) {
			ra.addFlashAttribute("message","리뷰 삭제에 성공하였습니다.");
		} else {
			ra.addFlashAttribute("message","리뷰 삭제에 실패하였습니다.");
		}
		
		return "redirect:review";	
		
	}

	/* 판매상품 관리 */
	@GetMapping("productManagement")
	public void productManagement(Model model, @RequestParam( required = false) Map<String, String> param, HttpSession session) {
		
		MemberDTO member = (MemberDTO)session.getAttribute("loginMember");
		
		int memCode = member.getMemCode();
		
		
		// 현재 페이지 
		int pageNo = 1;
		
		String currentPage = param.get("currentPage");
		String searchValue = param.get("searchValue");
		String mDate = param.get("mDate");
		String mDate2 = param.get("mDate2");
		String eDate = param.get("eDate");
		String eDate2 = param.get("eDate2");
		String status = param.get("status");
		
		System.out.println("mDate : " + mDate);
		System.out.println("mDate2 : " + mDate2);
		System.out.println("eDate : " + eDate);
		System.out.println("eDate2 : " + eDate2);
		
		// 현재 페이지가 != null && !"" 않으면 pagNo는 현재 페이지로
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		// pageNo가 0보다 작으면 pageNo는 1로
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(currentPage);
		System.out.println(pageNo);
		
		System.out.println("searchValue : " + searchValue);
		
		/* searchValue 넘김 */
		Map<String, Object> searchMap = new HashMap<>();
		
		searchMap.put("searchValue", searchValue);
		searchMap.put("memCode",memCode);
		searchMap.put("mDate",mDate);
		searchMap.put("mDate2",mDate2);
		searchMap.put("eDate",eDate);
		searchMap.put("eDate2",eDate2);
		searchMap.put("status",status);
		
		int totalCount = ownerService.selectTotalCount(searchMap);
		
		System.out.println("totalCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagenation = null;
		
		if(searchValue != null && !"".equals(searchValue)) {
			pagenation = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, searchValue);
			searchMap.put("pagenation", pagenation);
		} else {
			pagenation = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
			searchMap.put("pagenation", pagenation);
		}
		
		List<ProductDTO> productList = ownerService.selectProduct(searchMap);
		
		System.out.println("productList : " + productList);
		
		if(productList != null) {
			
			model.addAttribute("pagination",pagenation);
			model.addAttribute("productList", productList);
			model.addAttribute("searchMap",searchMap);
			
			
		} else {
			System.out.println("조회실패");
		}
		
	}

	@PostMapping("giveCoupons")
	public String giveCoupons(@RequestParam(value="cps",required = false) List<Integer> cpCode
							, @RequestParam(value="chk",required = false) List<Integer> chkReview, RedirectAttributes ra) {
		
		if(chkReview != null && chkReview.size() > 0 && cpCode !=null && cpCode.size() > 0) {
			
			System.out.println("리뷰리스트드르르르를 chkR : " + chkReview);
			System.out.println("줄 쿠폰 코드드드드드들 cps : " + cpCode);
			
			int registCoupon = ownerService.registCpToReview(chkReview,cpCode);
			
			if(registCoupon > 0 ) {
				ra.addFlashAttribute("message","쿠폰 주기를 성공하였습니다.");
				
			}else {
				ra.addFlashAttribute("message","쿠폰 주기를 실패하였습니다.");
			}
			
		} else {
			System.out.println("실패실패실패!!");
		}
		
		return "redirect:review";
	}
	
	@PostMapping("productManagement")
	public String product(@RequestParam(value="sdCode", required = false ,defaultValue = "0") int sdCode, @RequestParam(value="deleteCode",required = false) List<Integer> deleteCode,
			RedirectAttributes redirect) {
		// redirect할때는 RedirectAttributes 사용해야함 정신차려..!
		if(sdCode > 0 ) {

			ProductDTO product = new ProductDTO();
			product.setSdCode(sdCode);
			System.out.println("sdCode : " + product);
			int updateStatus = ownerService.modifyStatus(product);

			if(updateStatus > 0) {
				redirect.addFlashAttribute("success","success");
			} 
		}

		if(deleteCode != null && deleteCode.size() > 0) {

			System.out.println("deleteCode : " + deleteCode);

			int removeProduct = ownerService.removeProduct(deleteCode);

			if(removeProduct > 0) {
				redirect.addFlashAttribute("message","삭제가 완료되었습니다");
			} else {
				redirect.addFlashAttribute("message","삭제에 실패하였습니다");
			}

		}

		return "redirect:productManagement";
	}
	
	/* 오더페이지 완료된 주문 페이지네이션*/
	@GetMapping("order2")
	public String orderList2(@ModelAttribute("loginMember") MemberDTO member, @RequestParam( required = false) Map<String, String> param,Model model) {
		
		// MemberDTO 안에 CeoDTo 안에 StoreDTO 안에 storeName 이 존재하니 뽑아서 넘겨준다.
				MemberDTO owner = ownerService.selectOwner(member);
				String storeName = owner.getCeo().getStore().getStoreName();
				System.out.println("스토어 이름 : " + storeName);
				
		// 현재 페이지 
				int pageNo = 1;
				// jsp에서 받아온 값들을 param에 담기면 get으로 꺼내쓴다
				String currentPage = param.get("currentPage");
				String searchValue = param.get("searchValue");
				String mDate = param.get("mDate");
				String mDate2 = param.get("mDate2");
				
				System.out.println("mDate : " + mDate);
				System.out.println("mDate2 : " + mDate2);
				
				// 현재 페이지가 != null && !"" 않으면 pagNo는 현재 페이지로
				if(currentPage != null && !"".equals(currentPage)) {
					pageNo = Integer.parseInt(currentPage);
				}
				
				// pageNo가 0보다 작으면 pageNo는 1로
				if(pageNo <= 0) {
					pageNo = 1;
				}
				
				System.out.println(currentPage);
				System.out.println(pageNo);
				
				System.out.println("searchValue : " + searchValue);
				
				/* searchValue 넘김 */
				Map<String, Object> searchMap = new HashMap<>();
				
				searchMap.put("searchValue", searchValue);
				searchMap.put("storeName",storeName);
				searchMap.put("mDate",mDate);
				searchMap.put("mDate2",mDate2);
				
				int totalCount = ownerService.selectTotalCountOrder(searchMap);
				
				System.out.println("totalCount : " + totalCount);
				
				int limit = 10;
				int buttonAmount = 10;
				
				Pagination pagenation = null;
				
				if(searchValue != null && !"".equals(searchValue)) {
					pagenation = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, searchValue);
					searchMap.put("pagination", pagenation);
				} else {
					pagenation = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
					searchMap.put("pagination", pagenation);
				}
				
				List<OrderDTO> orderList2 = ownerService.selectOrderList2(searchMap);
				
				System.out.println("orderList2 : " + orderList2);
				
				if(orderList2 != null) {
					model.addAttribute("pagination",pagenation);
					model.addAttribute("orderList2", orderList2);
					model.addAttribute("searchMap",searchMap);
				} else {
					System.out.println("조회실패");
				}
				
		return "owner/order2";
	}
	
	@GetMapping("order")
	public String orderList(@ModelAttribute("loginMember") MemberDTO member, 
							@RequestParam(value = "currentPage", required = false) String currentPage ,Model model) {
		
		// MemberDTO 안에 CeoDTo 안에 StoreDTO 안에 storeName 이 존재하니 뽑아서 넘겨준다.
		MemberDTO owner = ownerService.selectOwner(member);
		String storeName = owner.getCeo().getStore().getStoreName();
		System.out.println("스토어 이름 : " + storeName);
		
		/* 주문 접수 페이지 처리  - 조건 없는 페이지 */
		// 현재 페이지
		int pageNo = 1;
		
		System.out.println("현재 페이지 : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(currentPage);
		System.out.println(pageNo);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = ownerService.selectOrderListTotalCount(storeName); // where 절에 storeName을 써야하니까 넘겨준다
		
		int limit = 10; //페이지당 글 갯수
		int buttonAmount =  10;//페이징 버튼의 갯수
		
		Pagination pagination = null;
		String searchCondition = storeName;
																	  // 검색 조건이 없으니까 null, null 처리
		pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		System.out.println("페이지 : " + pagination);
		
		List<OrderDTO> orderList = ownerService.selectOrderList(pagination); 
		System.out.println("주문 내역 : " + orderList);
		
		model.addAttribute("pagination",pagination);
		model.addAttribute("orderList",orderList);
		return "owner/order";
	}

	@PostMapping(value="order",produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String orderList2(@RequestParam(value="orderCode") int orderCode) throws JsonProcessingException {
		
		System.out.println("asdasdsadsads : " + orderCode);
		
		// 값 가져오기
		OrderDTO orderOne = ownerService.selectOrder(orderCode);
		
		System.out.println(orderOne);
		
		ObjectMapper mapper = new ObjectMapper();
		
		return mapper.writeValueAsString(orderOne);
		
	}
	
	@PostMapping("orderUpdateAndDelete")
	public String orderUpdate(@RequestParam("orderType") int orderType,@RequestParam("orderCode") int orderCode, Model model) {

		System.out.println("코드 잘 넘어오니!! : " + orderCode);
		
		OrderDTO orderDTO = new OrderDTO();
		int code = orderDTO.getCode();
		
		System.out.println("코드코드코드 : " + code);
		
		if(orderType == 2) {
			
			Map<Object,Object> orderMap = new HashMap<>();
			orderMap.put("orderCode", orderCode);
			orderMap.put("orderType", orderType);
			
 			int acceptOrder = ownerService.acceptModifyOrder(orderMap);
 			
 			System.out.println("수락하나요~~~~");
 			
		}
		
		if(orderType == 3) {
			
			Map<Object,Object> orderMap = new HashMap<>();
			orderMap.put("orderCode", orderCode);
			orderMap.put("orderType", orderType);
			
			int cancleOrder = ownerService.cancleModifyOrder(orderMap);
			
			System.out.println("취소하나요~~~~");
		}
		
		if(orderType == 4) {
			
			Map<Object, Object> orderMap = new HashMap<>();
			orderMap.put("orderCode", orderCode);
			orderMap.put("orderType", orderType);
			
			int completeOrder = ownerService.completeModifyOrder(orderMap);
			
			System.out.println("주문 완료하나요우");
		}
		
		return "redirect:order";
	}
	
	/* 오늘의 할인 */
	@GetMapping("todayDiscount")
	public void todayDiscount(Model model, @RequestParam(required = false) Map<String, String> param) {
		
		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		int memCode = member.getMemCode();
		
		Map<String, Object> searchMap = new HashMap<>();
		
		int pageNo = 1;
		
		String currentPage = param.get("currentPage");
		String searchValue = param.get("searchValue");
		
		searchMap.put("searchValue", searchValue);
		searchMap.put("memCode", memCode);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		int totalCount = ownerService.selectTotalDC(searchMap);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagenation = null;
		
		if(searchValue != null && !"".equals(searchValue)) {
			pagenation = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, searchValue);
			searchMap.put("pagenation", pagenation);
		} else {
			pagenation = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
			searchMap.put("pagenation", pagenation);
		}
		
		List<ProductDTO> DCList = ownerService.selectDC(searchMap);
		List<ProductDTO> productList = ownerService.selectProdouct(memCode);
		
		System.out.println("productList : " + productList);
			
		model.addAttribute("DCList",DCList);
		model.addAttribute("pagination", pagenation);
		model.addAttribute("productList",productList);
		model.addAttribute("msg", model.getAttribute("msg"));
		model.addAttribute("message",model.getAttribute("message"));
	}
	
	@PostMapping("todayDiscount")
	public String dcProduct(@RequestParam(value="sdCode", required = false) int[] sdCode, @RequestParam(value="dcRate" , required = false) int[] dcRate, @RequestParam(value="deleteCode" , required = false) int[] deleteCode, RedirectAttributes rd) {
		
		List<DCProduct> maps = new ArrayList<DCProduct>();
		
		if(sdCode != null  && dcRate!= null ) {
			
			for(int i = 0; i < sdCode.length; i++) {
				maps.add(new DCProduct(dcRate[i],sdCode[i]));
			}
			
			int insertDc = ownerService.registDc(maps);
			
			int updateDC = ownerService.modifyProduct(maps);
			
			System.out.println("insertDc : " + insertDc);
			System.out.println("updateDC : " + updateDC);
			
			
			if(insertDc > 0 && updateDC > 0) {
				rd.addFlashAttribute("msg","등록에 성공하였습니다.");
			} else {
				rd.addFlashAttribute("msg","등록에 실패하였습니다.");
			}
			
		}
		
		if(deleteCode!= null ) {
			
			List<Integer> codeList = new ArrayList<Integer>();
			for(int i : deleteCode) {
				System.out.println("asdadsadsa : " + i);
				codeList.add(i);
			}
			
			int deleteDC = ownerService.removeDc(codeList);
			int deletePro = ownerService.modifyDc(codeList);
			
			if(deleteDC > 0 && deletePro > 0) {
				rd.addFlashAttribute("message","삭제되었습니다.");
			} else {
				rd.addFlashAttribute("message","삭제에 실패하였습니다.");
			}
		}
		
		return "redirect:todayDiscount";
		
	}
	
	/* 사용자 가게 영업상태 변경 */
	@PostMapping(value="ownerSidebar",produces="text/plan; charset=UTF-8")
	@ResponseBody
	public String ownersidebar(Model model, @RequestParam(value="statusYN") String statusYN, RedirectAttributes rd) {
		
		System.out.println("statusYN : " + statusYN);

		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		
		int memCode = member.getMemCode();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memCode", memCode);
		map.put("statusYN", statusYN);
		
		int updateStatus =ownerService.modifyOwnerStatus(map);
		
		member.getCeo().getStore().setStatusYN(statusYN);
		model.addAttribute("loginMember", member);
		
		return updateStatus + "";
		
	}
	
	/* 사용자 이용권 결제 */
	@GetMapping("ownerPay")
	public void pay() {}
	
	
	@PostMapping("ownerPay2")
	public String payInfo(Model model, @RequestParam(value="pay") int msCode) {
		
		System.out.println("msCode : " + msCode);
		
		MemberDTO ownerInfo = (MemberDTO)model.getAttribute("loginMember");
		
		MembershipDTO membership = ownerService.selectMembership(msCode);
		
		System.out.println("membership : " + membership);
		
		model.addAttribute("ownerInfo",ownerInfo);
		model.addAttribute("membership",membership);
		
		return "owner/ownerPay2";
	}
	
	@GetMapping("kakaoPay")
	public String kaakoapy(Model model, @RequestParam(value="msCode") int msCode, @RequestParam(value="msDate") int msDate, @RequestParam(value="msType") String msType, 
			@RequestParam(value="price") String price, RedirectAttributes rd) {
		
		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		int memCode = member.getMemCode();
		String storeName = member.getCeo().getStore().getStoreName();
		
		System.out.println("카카오 페이로 넘겨받은 msCode : " + msCode);
		System.out.println("카카오 페이로 넘겨받은 msDate : " + msDate);
		System.out.println("카카오 페이로 넘겨받은 msType : " + msType);
		System.out.println("카카오 페이로 넘겨받은 price : " + price);
		System.out.println("사업자 이름 : " + storeName);

		// 오늘 날짜 구하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		
		Calendar c1 = Calendar.getInstance(); 
		
		String today = sdf.format(c1.getTime());
		
		System.out.println(today);
		
		
		MembershipAndStoreDTO memberShip = ownerService.selectMembershipAndStore(memCode);
		
		
		Map<String, Object> info = new HashMap<String, Object>();
		
		info.put("msCode", msCode);
		info.put("memCode", memCode);
		info.put("msDate",msDate);
		
		Map<String, Object> successInfo = new HashMap<String, Object>();
		successInfo.put("storeName",storeName);
		successInfo.put("msType",msType);
		successInfo.put("price",price);
		successInfo.put("payDate",today);
		
		if(memberShip == null) {
			
			int insertMembership = ownerService.registMembership(info);
			
			if( insertMembership > 0 ) {
				
				rd.addFlashAttribute("successInfo",successInfo);
				
			} else {
				
				rd.addFlashAttribute("msg","결제에 실패하였습니다.");
			}
			
		} else {
			
			info.put("dDay", memberShip.getEndDate());
			
			int extendMembership = ownerService.modifiyMembership(info); 
			
			if( extendMembership > 0 ) {
				
				rd.addFlashAttribute("successInfo",successInfo);
				
			} else {
				
				rd.addFlashAttribute("msg","결제에 실패하였습니다.");
			}
			
		}
		
		return "redirect:paySuccess";
		
	}
	
	@GetMapping("paySuccess")
	public void paySuccess(Model model) {
		
		model.getAttribute("successInfo");
		
	}
	
	/* 판매 상품 변경 */
	@GetMapping("modifyProduct")
	public void productModify(@RequestParam int sdCode, Model model) {
		
		System.out.println("sdCode 들어왔는가 : " + sdCode);
		
		ProductDTO product = ownerService.selectPd(sdCode);
		
		List<Integer> tag = ownerService.seletTagList(sdCode);
		
		List<TagDTO> tagList = ownerService.selectTag();
		
		List<HashMap<String, String>> categoryList = memberService.selectCategoryList();
		
		model.addAttribute("product",product);
		model.addAttribute("tagList",tagList);
		model.addAttribute("tag",tag);
		model.addAttribute("categoryList",categoryList);
	}
	
	@PostMapping("modifyProduct")
	public String modifyProduct(@RequestParam(required = false)  MultipartFile productImg, @ModelAttribute ProductDTO product, 
			HttpServletRequest request, RedirectAttributes rd, Model model, @RequestParam(required = false) String img) {
		
		int tag = Integer.parseInt(request.getParameter("tag1"));
		int tag2 = Integer.parseInt(request.getParameter("tag2"));
		int tag3 = Integer.parseInt(request.getParameter("tag3"));
		
		List<Integer> tagList = new ArrayList<Integer>();
		tagList.add(tag);
		tagList.add(tag2);
		tagList.add(tag3);
		
		System.out.println("tagList : " + tagList);
		System.out.println("product 변경된값 들어왔니? : " + product);
		
		System.out.println("파일이름 들어왔니? : " + productImg);
		
		Map<String,Object> productInfo = new HashMap<String, Object>();
		productInfo.put("product",product);
		productInfo.put("tagList", tagList);
		
		if(productImg != null && !productImg.isEmpty()) {
			
			String root = request.getSession().getServletContext().getRealPath("resources");
			
			String filePath = root + "/uploadFiles";
			
			File mkdir = new File(filePath);
			if(!mkdir.exists()) {
				mkdir.mkdirs();
			}
				String orginFileName = productImg.getOriginalFilename();
				String ext = orginFileName.substring(orginFileName.indexOf("."));
				String savedName = UUID.randomUUID().toString().replace("-", "") + ext;
				
				try {
					productImg.transferTo(new File(filePath + "/" + savedName));
					
					String fileName = "resources/uploadFiles/" + savedName;
					
					productInfo.put("fileName", fileName);
					
					
				} catch (IllegalStateException | IOException e) {
					new File(filePath + "/" + savedName).delete();	
					e.printStackTrace();
				}
				
				int result = ownerService.updateProduct(productInfo);
				
				if(result > 0) {
					rd.addFlashAttribute("message","상품이 등록되었습니다.");
				} else {
					rd.addFlashAttribute("message","상품 등록에 실패하였습니다.");
					new File(filePath + "/" + savedName).delete();
				}
			
		} 
		
		if(img != null && img != "") {
			
			productInfo.put("fileName",img);
			
			int result = ownerService.updateProduct(productInfo);
			
			if(result > 0) {
				rd.addFlashAttribute("message","변경되었습니다.");
			} else {
				rd.addFlashAttribute("message","변경에 실패하였습니다.");
			}
			
		}
		
		return "redirect:productManagement";
	}
	
	/* 사업자 이용권 영수증 페이지 */
	@GetMapping("receiptList")
	public void receiptList (Model model, @RequestParam(value = "currentPage", required = false) String currentPage) {
		
		int pageNo = 1;
		
		System.out.println("현재 페이지 : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(currentPage);
		System.out.println(pageNo);
		
		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		int memCode = member.getMemCode();

		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = ownerService.selectTotalReceipt(memCode);
		
		Pagination pagenation = null;
		
		int limit = 10;
		int buttonAmount = 10;
		
		pagenation = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
		map.put("pagination", pagenation);
		map.put("memCode", memCode);
	
		List<Map<String, Object>> info = ownerService.selectMembershipInfoList(map);

		model.addAttribute("info",info);
		model.addAttribute("pagination",pagenation);
			
	}
	
	/* 영수증 출력 */
	@GetMapping("receipt")
	public void receipt(Model model, @RequestParam String payDate) {
		
		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		int memCode = member.getMemCode();
		
		System.out.println("payDate : " + payDate);
		
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memCode",memCode);
		map.put("payDate",payDate);
		
		Map<String, Object> payInfo = ownerService.selectPayInfo(map);
		
		if(payInfo != null && !payInfo.isEmpty()) {
			
			model.addAttribute("payInfo",payInfo);
		} 
	}
	
	/* 정산 메인페이지 */
	@GetMapping("salesList")
	public void salesList(Model model) {
		
		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		
		String storeName = member.getCeo().getStore().getStoreName();
		
		// 하루 총 매출
		Map<String,Integer> totalPrice = ownerService.selectTotalPrice(storeName);
		
		System.out.println("totalPrice : " + totalPrice);
		
		// 배달 총 매출
		Map<String,Integer> delPrice = ownerService.selectDelPrice(storeName);
		
		System.out.println("delPrice : " + delPrice);
		
		// 포장 총 매출
		Integer pickupPrice = ownerService.selectPickupPrice(storeName);
		
		System.out.println("pickupPrice : "  + pickupPrice );
		if(pickupPrice != null && pickupPrice > 0) {
			
			model.addAttribute("pickupPrice",pickupPrice);
			
		} else {
			model.addAttribute("pickupPrice", null);
		}
		
		List<Map<String,Object>> salseMonth  = ownerService.selectMonth(storeName);
		
		String str = "";
		String delPrices = "";
		String pickPrice = "";
		
		if(salseMonth != null && !salseMonth.isEmpty()) {
			
			for(int i = 0; i < salseMonth.size(); i++) {
				
				if(i != salseMonth.size()-1 ) {
					
					str += (String)salseMonth.get(i).get("PAYDATE") + "월,";
					
				} else {
					
					str += (String)salseMonth.get(i).get("PAYDATE") + "월";
				}
					
				if(salseMonth.get(i).get("DELPRICE") != null ) {
				
					int won = 10000;
					
					int	price = Integer.parseInt(String.valueOf(salseMonth.get(i).get("DELPRICE"))) / won;
					
					if(i != salseMonth.size()-1) {
						
						delPrices += price +",";
						
					} else {
						
						delPrices += price + "";
						
					}
						 
					
				} else {
					
					if(i != salseMonth.size()-1) {
						
						delPrices += 0 +",";
						
					} else {
						
						delPrices += 0 + "";
						
					}
					
				}
					
				if(salseMonth.get(i).get("PICKPRICE") != null ) {
					
					int won = 10000;
					
					int price = Integer.parseInt(String.valueOf(salseMonth.get(i).get("PICKPRICE"))) / won;
					
					if(i != salseMonth.size()-1) {
						
						pickPrice += price + ",";
						
					} else {
						
						pickPrice += price + "";
						
					}
					
				} else {
					
					if(i != salseMonth.size()-1) {
						
						pickPrice += 0 + ",";
						
					} else {
						
						pickPrice += 0 + "";
					}
					
					
				}
					
			} 
		
		}
		
		System.out.println("str : " + str);
		System.out.println("delPrices : " + delPrices);
		System.out.println("pickPrice : " + pickPrice);
		
		model.addAttribute("totalPrice",totalPrice);
		model.addAttribute("delPrice",delPrice);
		model.addAttribute("str",str);
		model.addAttribute("delPrices",delPrices);
		model.addAttribute("pickPrice",pickPrice);
		
	}
	
	/* 일별 매출 */
	@GetMapping("salesDay")
	public void salseDay(Model model, @RequestParam(value = "currentPage", required = false) String currentPage,
			@RequestParam(value="date1",required = false) String date1, @RequestParam(value="date2",required = false) String date2) {
		
		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		
		String storeName = member.getCeo().getStore().getStoreName();
		
		System.out.println("storeName : " + storeName);
		System.out.println("date1 : " + date1);
		System.out.println("date2 : " + date2);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("storeName", storeName);
		map.put("date1", date1);
		map.put("date2", date2);
		
		int pageNo = 1;
		
		System.out.println("현재 페이지 : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(currentPage);
		System.out.println(pageNo);
		
		int totalCount = ownerService.selectTotalDailySalse(map);
		
		int limit = 10; //페이지당 글 갯수
		int buttonAmount =  10;//페이징 버튼의 갯수
		
		Pagination pagination = null;
		
		pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
		map.put("pagination", pagination);
		System.out.println("페이지 : " + pagination);
		
		List<Map<String,Object>> dailySales  = ownerService.selectDailySales(map);
		
		
		model.addAttribute("dailySales",dailySales);
		model.addAttribute("pagination",pagination);
		model.addAttribute("map",map);
	}
	
	/* 월별 매출 */
	@GetMapping("salseMonth")
	public void salesMonth(Model model, @RequestParam(value = "currentPage", required = false) String currentPage, @RequestParam(value="date1",required = false) String date1, 
			@RequestParam(value="date2",required = false) String date2) {
		
		MemberDTO member = (MemberDTO)model.getAttribute("loginMember");
		
		String storeName = member.getCeo().getStore().getStoreName();
		System.out.println("storeName : " + storeName);
		System.out.println("date1 : " + date1);
		System.out.println("date2 : " + date2);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("storeName", storeName);
		map.put("date1", date1);
		map.put("date2", date2);
		
		int pageNo = 1;
		
		System.out.println("현재 페이지 : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(currentPage);
		System.out.println(pageNo);
		
		int totalCount = ownerService.selectTotalsalseMonth(map);
		
		int limit = 5; //페이지당 글 갯수
		int buttonAmount =  10;//페이징 버튼의 갯수
		
		Pagination pagination = null;
		
		pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
		map.put("pagination", pagination);
		System.out.println("페이지 : " + pagination);
		
		List<Map<String,Object>> salseMonth  = ownerService.selectSalseMonth(map);
		
		model.addAttribute("salseMonth",salseMonth);
		model.addAttribute("pagination",pagination);
		model.addAttribute("map",map);
		
	}
	
	
	// 쿠폰 발행 내역
	@GetMapping("giveCouponLIst")
	public void giveCouponLIst(@ModelAttribute("loginMember") MemberDTO member,  @RequestParam(value = "currentPage", required = false) String currentPage, Model model) {
		
		// SearchCondition 에 필요한 memCode 가져와주고
		MemberDTO owner = ownerService.selectOwner(member);
		int memCode = owner.getMemCode();
		
		System.out.println("멤버 코드 잘 오니~~~~ : " + memCode);
		
		/* 주문 접수 페이지 처리  - 조건 없는 페이지 */
		// 현재 페이지
		int pageNo = 1;
		
		System.out.println("현재 페이지 : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(currentPage);
		System.out.println(pageNo);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = ownerService.selectgiveListTotalCount(memCode); // where 절에 storeName을 써야하니까 넘겨준다
		
		int limit = 10; //페이지당 글 갯수
		int buttonAmount =  10;//페이징 버튼의 갯수
		
		Pagination pagination = null;
		String searchCondition = String.valueOf(memCode);
																	  					// 검색 조건이 없으니까  null 처리
		pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		System.out.println("페이지 : " + pagination);
		
		List<CpHistoryDTO> givecpList = ownerService.selectgiveList(pagination); 
		System.out.println("쿠폰 발행 내역 : " + givecpList);
		
		model.addAttribute("pagination",pagination);
		model.addAttribute("givecpList",givecpList);

	}
	
	@GetMapping("ownerQuit")
	public void ownerQuit(Model model) {
		
	}
	
	@PostMapping(value="ownerQuitGo", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String ownerQuitGo(@ModelAttribute("loginMember") MemberDTO member ,Model model, @RequestParam("memPwd") String memPwd) throws JsonProcessingException {
		
		int memCode = member.getMemCode();
		
		System.out.println("탈퇴갑니다");
		
		boolean originPwd = ownerService.selectOriginPwd(memCode,memPwd);
		
		int result = 0;
		
		if(originPwd == true) {
			result = 1;
		} else {
			result = 0;
		}
		
		ObjectMapper mapper = new ObjectMapper();
		
		return mapper.writeValueAsString(result);
		
	}
	
}
