package com.sd.mommyson.manager.controller;

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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sd.mommyson.manager.common.Pagination;
import com.sd.mommyson.manager.dao.ManagerDAO;
import com.sd.mommyson.manager.dto.BannerDTO;
import com.sd.mommyson.manager.dto.CategoryDTO;
import com.sd.mommyson.manager.dto.HotKeywordDTO;
import com.sd.mommyson.manager.dto.PostDTO;
import com.sd.mommyson.manager.service.ManagerService;
import com.sd.mommyson.member.dto.AuthDTO;
import com.sd.mommyson.member.dto.ManagerDTO;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.member.dto.UserDTO;
import com.sd.mommyson.owner.dto.TagDTO;
import com.sd.mommyson.user.dto.ReportDTO;
import com.sd.mommyson.user.dto.ReviewDTO;

@Controller
@RequestMapping("/manager/*")
public class ManagerController {
	
	private ManagerService managerService;
	private final BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	public ManagerController(ManagerService managerService, BCryptPasswordEncoder passwordEncoder) {
		this.managerService = managerService;
		this.passwordEncoder = passwordEncoder;
	}
	
	/* 일반 회원 조회 */
	/**
	 * @param model
	 * @param currentPage
	 * @author leeseungwoo
	 */
	@GetMapping("normalMember")
	public void normalMember(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
							, @RequestParam(value="searchValue", required = false) String sv) {
		
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
		String searchValue = sv;
		String searchCondition = "";
		
		Map<String, Object> searchMap = new HashMap<>();
		
		String memberTypeUser = "user";
		
		searchMap.put("memberTypeUser", memberTypeUser);
		searchMap.put("searchValue", searchValue);
		
		System.out.println("searchMap : " + searchMap);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.selectNormalMemberTotalCount(searchMap);
		
		System.out.println("totalInquiryBoardCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount);
		}
		
		pagination.setSearchCondition("user");
		
		System.out.println("pagination : " + pagination);
		
		
		List<MemberDTO> normalMemberList = managerService.selectMember(pagination);
		System.out.println("리스트 확인 : " + normalMemberList);
		
		if(normalMemberList != null) {
			model.addAttribute("pagination", pagination);
			model.addAttribute("normalMemberList", normalMemberList);
		} else {
			System.out.println("조회실패");
		}
		
	}
	
	/* 회원삭제 */
	/**
	 * @param deleteMember
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping("deleteMember")
	public String deleteMember(@RequestParam("chkMember") int[] deleteMember) {

		List<Integer> deleteMemberList = new ArrayList<>();
		
		for(int i = 0; i < deleteMember.length; i++) {
			deleteMemberList.add(deleteMember[i]);
		}
		
		managerService.deleteMembers(deleteMemberList);
		
		return "redirect:normalMember";
	}
	
	/* 회원블랙등록 */
	/**
	 * @param chkMemberBlack
	 * @return
	 * @author leeseungwoo
	 */
	@GetMapping(value = "registBlack/{chkMember}", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String memberAddBlack(@PathVariable("chkMember") int[] chkMemberBlack) {
		
		List<Integer> memberAddBlackList = new ArrayList<>();
		
		for(int i = 0; i < chkMemberBlack.length; i++) {
			memberAddBlackList.add(chkMemberBlack[i]);
		}
		
		boolean result = managerService.modifyMemberAddBlack(memberAddBlackList);
		
		return result? "1" : "2";
	}

	
	/* 사업자 회원 조회 */
	/**
	 * @param model
	 * @param currentPage
	 * @author leeseungwoo
	 */
	@GetMapping("businessMember")
	public void buisnessMember(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
							  , @RequestParam(value="searchValue", required = false) String sv) {
		
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
		String searchValue = sv;
		String searchCondition = "";
		
		Map<String, Object> searchMap = new HashMap<>();
		
		String memberTypeCeo = "ceo";
		
		searchMap.put("memberTypeCeo", memberTypeCeo);
		searchMap.put("searchValue", searchValue);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.selectNormalMemberTotalCount(searchMap);
		
		System.out.println("totalInquiryBoardCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
			
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount);
		}
		
		pagination.setSearchCondition("ceo");
		
		List<MemberDTO> buisnessMemberList = managerService.selectMember(pagination);
		
		System.out.println("buisnessMemberList : " + buisnessMemberList);
		
		if(buisnessMemberList != null) {
			model.addAttribute("pagination", pagination);
			model.addAttribute("buisnessMemberList", buisnessMemberList);
		} else {
			System.out.println("조회실패");
		}
		
	}
	
	/* 사업자 회원 삭제 */
	/**
	 * @param deleteMember
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping("deleteCeoMember")
	public String deleteCeoMember(@RequestParam("chkMember") int[] deleteMember) {
		
		List<Integer> deleteCeoMemberList = new ArrayList<>();
		
		for(int i = 0; i < deleteMember.length; i++) {
			deleteCeoMemberList.add(deleteMember[i]);
		}
		
		managerService.deleteMembers(deleteCeoMemberList);
		
		return "redirect:buisnessMember";
	}
	
	/* 사업자 상세 정보 조회 */
	/**
	 * @param ceoNum
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "ceoDetailInfo", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MemberDTO ceoDetailInfo(@RequestParam("modalInfo") int ceoNum) throws JsonProcessingException {
		
		System.out.println("들어옴");
		
		Map<String, Object> ceoDetailInfo = new HashMap<>();
		ceoDetailInfo.put("ceoNum", ceoNum);
		
		MemberDTO ceoDetailInfos = managerService.selectCeoDetailInfo(ceoDetailInfo);
		
		System.out.println("ceoDetailInfos : " + ceoDetailInfos);
		
		return ceoDetailInfos;
	}
	
	/* 블랙 회원 조회 */
	/**
	 * @param model
	 * @param currentPage
	 * @author leeseungwoo
	 */
	@GetMapping("blackMember")
	public void blackMember(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
							, @RequestParam(value="searchValue", required = false) String sv) {
		
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
		String searchValue = sv;
		String searchCondition = "";
		
		Map<String, Object> searchMap = new HashMap<>();
		
		String blackMember = "black";
		
		searchMap.put("blackMember", blackMember);
		searchMap.put("searchValue", searchValue);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.selectNormalMemberTotalCount(searchMap);
		
		System.out.println("totalInquiryBoardCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
			
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount);
		}
		
		pagination.setSearchCondition("black");
		
		System.out.println("pagination : " + pagination);
		
		List<MemberDTO> blackMemberList = managerService.selectMember(pagination);
		System.out.println("리스트 확인 : " + blackMemberList);
		
		if(blackMemberList != null) {
			model.addAttribute("pagination", pagination);
			model.addAttribute("blackMemberList", blackMemberList);
		} else {
			System.out.println("조회실패");
		}
		
	}
	
	/**
	 * 블랙회원 경고내역 상세보기
	 * @param memCode
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "blackMemDetail", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<Map<String, Object>> blackMemDetail(@RequestParam("memCode") int memCode) {
		
		System.out.println("들어옴");
		
		Map<String, Object> blackMemDetailMap = new HashMap<>();
		blackMemDetailMap.put("memCode", memCode);
		
		List<Map<String, Object>> blackMemDetailList = managerService.selectblackMemDetail(blackMemDetailMap);
		System.out.println("blackMemDetailList : " + blackMemDetailList);
		
		return blackMemDetailList;
	}
	
	/* 블랙해지 */
	/**
	 * @param blackMember
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "terminateBlack", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public boolean terminateBlack(@RequestParam(value = "chkMember[]",required = false) String[] blackMember, @RequestParam(value = "rvCodes", required = false) String  blackRvCode){
		
		System.out.println("들어옴");
		
		List<Object> terminateBlackList = new ArrayList<>();
		
		for(String cm : blackMember) {
			terminateBlackList.add(cm);
		}
		
		System.out.println("리스트 : " + terminateBlackList);
		
		List<Object> terminateRvCodeList = new ArrayList<>();
		
		System.out.println(blackRvCode);
		String sarr[] = blackRvCode.split(",");
		for(String rc : sarr) {
			terminateRvCodeList.add(rc);
		}
		
		Map<String, Object> terminateMap = new HashMap<>();
		terminateMap.put("terminateBlackList", terminateBlackList);
		terminateMap.put("terminateRvCodeList", terminateRvCodeList);
		
		boolean result = managerService.updateTerminateBlack(terminateMap);
		
		return result;
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 조회 + 상단 고정 공지사항 조회
	 */
	@GetMapping("noticeSelect")
	public String noticeSelect(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
			, @RequestParam(value="searchCondition", required=false) String sc
			, @RequestParam(value="searchValue", required=false) String sv) {
		
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
		String searchCondition = sc;
		String searchValue = sv;
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		
		System.out.println("searchValue : " + searchValue);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.selectNoticeTotalCount(searchMap);
		
		System.out.println("totalInquiryBoardCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		System.out.println("조건 : " + searchCondition);
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) { //검색할 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else if(searchCondition != null && !"".equals(searchCondition)) {  // 조건변경할때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		} else { //둘 다null값으로 들어올 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, "all", null);
		}
		
//		System.out.println("pagination : " + pagination);
		
		/* 공지사항 리스트 조회 */
		List<PostDTO> noticeList = managerService.selectNoticeList(pagination);
		
		/* 상단 고정 게시글 값 불러오는 메소드 */
		List<PostDTO> noticeUpList = managerService.selectNoticeUpList();
		
		if(noticeList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("noticeUpList",noticeUpList);
		} else {
			System.out.println("공지사항 리스트 조회 실패");
		}
		
		return "manager/noticeSelect";
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 작성 화면
	 */
	@GetMapping("noticeWrite")
	public void noticeWrite() {
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 작성
	 */
	@PostMapping(value = "noticeWrite")
	public String noticeWrite(@ModelAttribute PostDTO post, Model model) {
		System.out.println(post);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", post.getBoardCode());
		map.put("postTitle", post.getPostTitle());
		map.put("postContent", post.getPostContent());
		
		int result = managerService.postWriting(map);
	
		if(result > 0) {
			model.addAttribute("result", "공지 등록에 성공했습니다.");
		} else {
			model.addAttribute("result", "공지 등록에 실패했습니다.");
		}
		
		return "redirect:/manager/noticeSelect";
	}
	
	
	/**
	 * @author junheekim
	 * @category 공지사항 게시물 조회
	 */
	@GetMapping("noticeDetailView")
	public String noticeDetailView(Model model, @RequestParam(value = "postNo", required = false) int postNo) {
		
		PostDTO selectNotice = managerService.selectNotice(postNo);
		boolean isCnt = managerService.selectNoticeCnt(postNo);
		
		System.out.println("조회수 결과 : " + isCnt);
		
		if(selectNotice != null) {
			model.addAttribute("selectNotice", selectNotice);
		} else {
			System.out.println("공지사항 게시글 조회 실패");
		}
		
		return "manager/noticeDetailView";
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 게시물 수정 페이지
	 */
	@GetMapping("noticeRevise")
	public void noticeRevise(Model model, @RequestParam(value = "postNo", required = false) int postNo) {
		
		PostDTO selectNotice = managerService.selectNotice(postNo);
		
		if(selectNotice != null) {
			model.addAttribute("selectNotice", selectNotice);
		} else {
			System.out.println("공지사항 게시글 수정 진입 실패");
		}
		
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 게시물 수정
	 */
	@PostMapping(value = "noticeRevise")
	public String noticeRevise(@ModelAttribute PostDTO post, Model model) {
		System.out.println(post);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("postNo", post.getPostNo());
		map.put("boardCode", post.getBoardCode());
		map.put("postTitle", post.getPostTitle());
		map.put("postContent", post.getPostContent());
		
		int result = managerService.postRevise(map);
	
		if(result > 0) {
			model.addAttribute("result", "공지 수정에 성공했습니다.");
		} else {
			model.addAttribute("result", "공지 수정에 실패했습니다.");
		}
		
		return "redirect:/manager/noticeSelect";
	}
	
	
	/**
	 * @author junheekim
	 * @category 공지사항 게시글 삭제(체크박스)
	 */
	@GetMapping(value = "noticeSelect/{chkNotice}", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String noticeDelete(@PathVariable("chkNotice")  int[] chkDelNotice) {
		
		List<Integer> addNoticeDeleteList = new ArrayList<>();
		
		String message = "";
		for(int i = 0; i < chkDelNotice.length; i++) {
			addNoticeDeleteList.add(chkDelNotice[i]);
			
			boolean result = managerService.deletePost(addNoticeDeleteList);
			
			if(result) {
				message = "선택한 게시글을 삭제하였습니다.";
			} else {
				message = "게시글 삭제에 실패하였습니다.";
			}
		}
		
		return message;
		
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 게시글 삭제(상세보기)
	 */
	@GetMapping(value = "noticeSelectDelete/{postNo}", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String noticeSelectDelete(@PathVariable("postNo") int postNo) {
		
		boolean result = managerService.deleteSelectNotice(postNo);
		
		String message = "";
		if(result) {
			message = "선택한 게시글을 삭제하였습니다.";
		} else {
			message = "게시글 삭제에 실패하였습니다.";
		}
		
		return message;
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 게시글 상단 고정 등록
	 */
	@GetMapping(value = "noticeUp/{postNo}", produces = "text/plain; charset=UTF-8; ")
	@ResponseBody
	public String noticeUp(@PathVariable("postNo") int postNo) {
		
		boolean result = managerService.noticeUp(postNo);
		
		String message = "";
		if(result) {
			message = "게시글이 상단 고정되었습니다.";
		} else {
			message = "게시글 상단 고정 등록에 실패하였습니다.";
		}
		
		return message;
	}
	
	/**
	 * @author junheekim
	 * @category 공지사항 게시글 상단 고정 해제
	 */
	@GetMapping(value = "noticeDown/{postNo}", produces = "text/plain; charset=UTF-8; ")
	@ResponseBody
	public String noticeDown(@PathVariable("postNo") int postNo) {
		
		boolean result = managerService.noticeDown(postNo);
		
		String message = "";
		if(result) {
			message = "게시글 상단 고정이 해제되었습니다.";
		} else {
			message = "게시글 상단 고정 해제에 실패하였습니다.";
		}
		
		return message;
	}
	
	
	
	/**
	 * @author junheekim
	 * @category 자주묻는질문 리스트 조회
	 */
	@GetMapping("oftenQuestion")
	public String oftenQuestion(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
			, @RequestParam(value="searchCondition", required=false) String sc
			, @RequestParam(value="searchValue", required=false) String sv) {
		/* ==== 현재 페이지 처리 ==== */
		int pageNo = 1;
		
		System.out.println("currentPage : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(pageNo);
		
		/* ==== 검색 처리 ==== */
		String searchCondition = sc;
		String searchValue = sv;
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		
		System.out.println("searchMap : " + searchMap);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.OftenQuestionTotalCount(searchMap);
		
		System.out.println("OftenQuestionTotalCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		System.out.println("조건 : " + searchCondition);
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) { //검색할 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else if(searchCondition != null && !"".equals(searchCondition)) {  // 조건변경할때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		} else { //둘 다null값으로 들어올 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
		}
		
//		System.out.println("pagination : " + pagination);
		
		/* 자주묻는질문 리스트 조회 */
		List<PostDTO> OftenQuestionList = managerService.selectOftenQuestionList(pagination);
		

		if(OftenQuestionList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("OftenQuestionList",OftenQuestionList);
		} else {
			System.out.println("자주묻는질문 리스트 조회 실패");
		}
		
		return "manager/oftenQuestion";
	}
	
	/**
	 * @author junheekim
	 * @category 자주묻는질문
	 */
	@GetMapping("oftenQuestionWrite")
	public void oftenQuestionWrite() {
		
	}
	
	/**
	 * @author junheekim
	 * @category 자주묻는질문 작성
	 */
	@PostMapping(value = "oftenQuestionWrite")
	public String oftenQuestionWrite(@ModelAttribute PostDTO post, Model model) {
		System.out.println("포스트 : " + post);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", post.getBoardCode());
		map.put("postTitle", post.getPostTitle());
		map.put("postContent", post.getPostContent());
		
		
		int result = managerService.postWriting(map);
	
		if(result > 0) {
			model.addAttribute("result", "자주묻는질문에 등록에 성공했습니다.");
		} else {
			model.addAttribute("result", "자주묻는질문에 등록에 실패했습니다.");
		}
		
		return "redirect:/manager/oftenQuestion";
	}
	
	/**
	 * @author junheekim
	 * @category 자주묻는질문 게시글 삭제(체크박스)
	 */
	@GetMapping(value = "oftenQuestion/{chkQuestion}", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String oftenQuestion(@PathVariable("chkQuestion")  int[] chkDelQuestion) {
		
		List<Integer> questionDeleteList = new ArrayList<>();
		
		String message = "";
		for(int i = 0; i < chkDelQuestion.length; i++) {
			questionDeleteList.add(chkDelQuestion[i]);
			
			boolean result = managerService.deletePost(questionDeleteList);
			
			if(result) {
				message = "선택한 게시글을 삭제하였습니다.";
			} else {
				message = "게시글 삭제에 실패하였습니다.";
			}
		}
		
		return message;
		
	}
	
	
	/**
	 * @author junheekim
	 * @category 사업자 - 1:1 질문 조회
	 */
	@GetMapping("businessInquiry")
	public String businessInquiry(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
			, @RequestParam(value = "searchCondition", required = false) String sc
			, @RequestParam(value = "searchValue", required = false) String sv) {
		System.out.println("조건a : " + sc);
		/* ==== 현재 페이지 처리 ==== */
		int pageNo = 1;
		
		System.out.println("currentPage : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(pageNo);
		
		/* ==== 검색 처리 ==== */
		String searchCondition = sc;
		String searchValue = sv;
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		
		System.out.println("searchMap : " + searchMap);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.businessInquiryTotalCount(searchMap);
		
		System.out.println("OftenQuestionTotalCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		System.out.println("조건 : " + searchCondition);
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) { //검색할 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else if(searchCondition != null && !"".equals(searchCondition)) {  // 조건변경할때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		} else { //둘 다null값으로 들어올 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
		}
		
//		System.out.println("pagination : " + pagination);
		
		/* 자주묻는질문 리스트 조회 */
		List<PostDTO> businessInquiryList = managerService.selectBusinessInquiry(pagination);
		

		if(businessInquiryList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("businessInquiryList",businessInquiryList);
		} else {
			System.out.println("사업자 1:1 문의 리스트 조회 실패");
		}
		
		return "manager/businessInquiry";
	}

	@GetMapping("businessAnswer")
	public void businessAnswer() {
		
	}
	
	
	/**
	 * @author junheekim
	 * @category 소비자 - 1:1 질문 조회
	 * @return
	 */
	@GetMapping("normalInquiry")
	public String normalInquiry(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
			, @RequestParam(value = "searchCondition", required = false) String sc
			, @RequestParam(value = "searchValue", required = false) String sv) {
		
		System.out.println("조건b : " + sc);
		/* ==== 현재 페이지 처리 ==== */
		int pageNo = 1;
		
		System.out.println("currentPage : " + currentPage);
		
		if(currentPage != null && !"".equals(currentPage)) {
			pageNo = Integer.parseInt(currentPage);
		}
		
		if(pageNo <= 0) {
			pageNo = 1;
		}
		
		System.out.println(pageNo);
		
		/* ==== 검색 처리 ==== */
		String searchCondition = sc;
		String searchValue = sv;
		
		Map<String, String> searchMap = new HashMap<>();
		searchMap.put("searchCondition", searchCondition);
		searchMap.put("searchValue", searchValue);
		
		System.out.println("searchMap : " + searchMap);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.normalInquiryTotalCount(searchMap);
		
		System.out.println("OftenQuestionTotalCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		System.out.println("조건 : " + searchCondition);
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) { //검색할 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else if(searchCondition != null && !"".equals(searchCondition)) {  // 조건변경할때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, null);
		} else { //둘 다null값으로 들어올 때
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, null, null);
		}
		
//		System.out.println("pagination : " + pagination);
		
		/* 자주묻는질문 리스트 조회 */
		List<PostDTO> normalInquiryList = managerService.selectNormalInquiry(pagination);
		

		if(normalInquiryList != null) {
			model.addAttribute("pagination",pagination);
			model.addAttribute("normalInquiryList",normalInquiryList);
		} else {
			System.out.println("소비자 1:1 문의 리스트 조회 실패");
		}
		
		return "manager/normalInquiry";
	}
	
	/* 리뷰 신고 현황 */
	/**
	 * @param model
	 * @param currentPage
	 * @param sv
	 * @throws JsonProcessingException
	 * @author leeseungwoo
	 */
	@GetMapping("statusStoreWarning")
	public void statusStoreWarning(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
								   , @RequestParam(value="searchValue", required = false) String sv) {
		
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
		String searchValue = sv;
		String searchCondition = "";
		
		String all = "all";
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("searchValue", searchValue);
		searchMap.put("all", all);
		
		System.out.println("searchMap : " + searchMap);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.selectReportTotalCount(searchMap);
		
		System.out.println("totalInquiryBoardCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount);
		}
		
		pagination.setSearchCondition("all");
		
		System.out.println("pagination : " + pagination);
		
		List<Map<String, Object>> reportList = managerService.selectReportList(pagination);
		System.out.println("리스트 확인 : " + reportList);
		
		if(reportList != null) {
			model.addAttribute("pagination", pagination);
			model.addAttribute("reportList", reportList);
		} else {
			System.out.println("조회실패");
		}
		
	}
	
	/**
	 * 신고 접수된 리뷰 조회
	 * @param model
	 * @param currentPage
	 * @param sv
	 * @param condition
	 * @return
	 * @author leeseungwoo
	 */
	@GetMapping(value = "repReception")
	public String repReception(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
			   , @RequestParam(value="searchValue", required = false) String sv,
			     @RequestParam("searchCondition") String condition) {
		
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
		String searchValue = sv;
		String searchCondition = "";
		
//		String processSituation = "W";
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("searchValue", searchValue);
		searchMap.put("condition1", condition);
		
		System.out.println("searchMap : " + searchMap);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.selectReportTotalCount(searchMap);
		
		System.out.println("totalInquiryBoardCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount);
		}
		
		pagination.setSearchCondition(condition);
		
		System.out.println("pagination : " + pagination);
		
		List<Map<String, Object>> repReceptionList = managerService.selectReportList(pagination);
		System.out.println("리스트 확인 : " + repReceptionList);
		
		if(repReceptionList != null) {
			model.addAttribute("pagination", pagination);
			model.addAttribute("repReceptionList", repReceptionList);
		} else {
			System.out.println("조회실패");
		}
		
		return "manager/statusStoreWarning";
	}
	
	/**
	 * 처리완료된 신고리뷰 조회
	 * @param model
	 * @param currentPage
	 * @param sv
	 * @param condition
	 * @return
	 * @author leeseungwoo
	 */
	@GetMapping(value = "repComplete")
	public String repComplite(Model model, @RequestParam(value = "currentPage", required = false) String currentPage
			   , @RequestParam(value="searchValue", required = false) String sv,
			     @RequestParam("searchCondition") String condition) {
		
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
		String searchValue = sv;
		String searchCondition = "";
		
//		String processSituation = "W";
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("searchValue", searchValue);
		searchMap.put("condition2", condition);
		
		System.out.println("searchMap : " + searchMap);
		
		/* ==== 조건에 맞는 게시물 수 처리 ==== */
		int totalCount = managerService.selectReportTotalCount(searchMap);
		
		System.out.println("totalInquiryBoardCount : " + totalCount);
		
		int limit = 10;
		int buttonAmount = 10;
		
		Pagination pagination = null;
		
		/* ==== 검색과 selectOption 고르기 ==== */
		if(searchValue != null && !"".equals(searchValue)) {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount, searchCondition, searchValue);
		} else {
			pagination = Pagination.getPagination(pageNo, totalCount, limit, buttonAmount);
		}
		
		pagination.setSearchCondition(condition);
		
		System.out.println("pagination : " + pagination);
		
		List<Map<String, Object>> repCompleteList = managerService.selectReportList(pagination);
		System.out.println("리스트 확인 : " + repCompleteList);
		
		if(repCompleteList != null) {
			model.addAttribute("pagination", pagination);
			model.addAttribute("repCompleteList", repCompleteList);
		} else {
			System.out.println("조회실패");
		}
		
		return "manager/statusStoreWarning";
	}
	
	/**
	 * 신고된 리뷰 상세조회
	 * @param repCode
	 * @return
	 * @throws JsonProcessingException
	 * @author leeseungwoo
	 */
	@PostMapping(value = "repDetailView", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> repDetailView(@RequestParam("repNo") int repNo) throws JsonProcessingException{
		
		System.out.println("들어옴");
		
		Map<String, Object> repMap = new HashMap<>();
		repMap.put("repNo", repNo);
		
		Map<String, Object> reportInfo = managerService.selectRepDetailView(repMap);
		System.out.println("reportInfo : " + reportInfo);
		
		return reportInfo;
	}
	
	/**
	 * 신고된 리뷰 반려처리
	 * @param repRvCode
	 * @return
	 * @author leeseungwoo
	 */
	@GetMapping(value = "repCompanion{repRvCode}", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String repCompanion(@PathVariable("repRvCode") int repRvCode) {
		
		System.out.println("들어옴");
		System.out.println("리뷰코드 : " + repRvCode);
		
		Map<String, Integer> repComMap = new HashMap<>();
		repComMap.put("repRvCode", repRvCode);
		
		boolean result = managerService.updateRepCompanion(repComMap);
		
		System.out.println("result : " + result);
		
		return result? "1" : "2";
	}
	
	/**
	 * 신고된 해당리뷰 회원 경고주기
	 * @param repMemCode
	 * @return
	 * @author leeseungwoo
	 */
	@GetMapping(value = "repWarning/{repMemCode}/{repRvCode}", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String warning(@PathVariable("repMemCode") int repMemCode, @PathVariable("repRvCode") int repRvCode) {
		
		System.out.println("들어옴");
		System.out.println("회원코드 : " + repMemCode);
		System.out.println("리뷰코드 : " + repRvCode);
		
		Map<String, Integer> warMap = new HashMap<>();
		warMap.put("repMemCode", repMemCode);
		warMap.put("repRvCode", repRvCode);
		
		boolean result = managerService.updateWarning(warMap);
		
		System.out.println("result : " + result);
		
		return result? "1" : "2";
	}
	
	/**
	 * 신고된 리뷰 해당 회원 블랙처리
	 * @param repMemCode
	 * @param repRvCode
	 * @return
	 * @author leeseungwoo
	 */
	@GetMapping(value = "repBlack/{repMemCode}/{repRvCode}", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String black(@PathVariable("repMemCode") int repMemCode, @PathVariable("repRvCode") int repRvCode) {
		
		System.out.println("들어옴");
		System.out.println("회원코드 : " + repMemCode);
		System.out.println("리뷰코드 : " + repRvCode);
		
		Map<String, Object> blackMap = new HashMap<>();
		blackMap.put("repMemCode", repMemCode);
		blackMap.put("repRvCode", repRvCode);
		
		boolean result = managerService.updateBlack(blackMap);
		
		System.out.println("result : " + result);
		
		return result? "1" : "2";
	}
	
	/**
	 * 배너조회
	 * @param model
	 * @author leeseungwoo
	 */
	@GetMapping("bannerManage")
	public void bannerManage(Model model) {
		
		List<BannerDTO> bannerList = managerService.selectBanner();
		System.out.println("bannerList : " + bannerList);
		
		model.addAttribute("bannerList", bannerList);
	}
	
	/* 배너추가 페이지 */
	@GetMapping("bannerAdd")
	public void bannerAdd() {
		
		
	}
	
	/**
	 * 배너추가
	 * @param banner
	 * @param bnImg
	 * @param request
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping("bannerinsert")
	public String bannerinsert(@ModelAttribute BannerDTO banner, @RequestParam MultipartFile bnImg
							   , HttpServletRequest request) {
		System.out.println("들어옴");
		System.out.println("banner : " + banner);
		Map<String, Object> bnMap = new HashMap<>();
		bnMap.put("banner", banner);
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/uploadFiles";
		
		File mkdir = new File(filePath);
		if(!mkdir.exists()) {
			mkdir.mkdirs();
		}
		
		String orginFileName = bnImg.getOriginalFilename();
		String ext = orginFileName.substring(orginFileName.indexOf("."));
		String savedName = UUID.randomUUID().toString().replace("-", "") + ext;
		
		try {
			bnImg.transferTo(new File(filePath + "/" + savedName));
			
			String fileName = "resources/uploadFiles/" + savedName;
			System.out.println("fileName : " + fileName);
			bnMap.put("bnImg", fileName);
			
			
		} catch (IllegalStateException | IOException e) {
			new File(filePath + "/" + savedName).delete();	
			e.printStackTrace();
		}
		
		int result = managerService.insertBannerAdd(bnMap);
		
		if(result > 0) {
			System.out.println("배너등록성공");
		} else {
			System.out.println("배너등록실패");
			new File(filePath + "/" + savedName).delete();
		}
		
		return "redirect:bannerManage";
	}
	
	/**
	 * 사용중인 태그 조회
	 * 핫 키워드 조회
	 * @param model
	 * @author leeseungwoo
	 */
	@GetMapping("tagManage")
	public void tagManage(Model model) {
		
		List<TagDTO> useTagList = managerService.selectUseTag();
		List<HotKeywordDTO> hotkewordList = managerService.selectHotkeword();
		
		System.out.println("useTagList : " + useTagList);
		System.out.println("hotkewordList : " + hotkewordList);
		
		model.addAttribute("useTagList", useTagList);
		model.addAttribute("hotkewordList", hotkewordList);
	}
	
	/**
	 * 태그 추가
	 * @param tag
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping("tagAdd")
	public String tagAdd(@RequestParam("tag") String tag) {
		
		System.out.println("태그추가 들어옴");
		
		int result = managerService.insertTagAdd(tag);
		
		if(result > 0) {
			System.out.println("태그 추가 성공");
		} else {
			System.out.println("태그 추가 실패");
		}
		
		return "redirect:tagManage";
	}
	
	/**
	 * 태그 삭제
	 * @param tagNo
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "tagDelete", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String tagDelete(@RequestParam("tagNo") int tagNo) {
		
		int result = managerService.deleteTag(tagNo);
		
		if(result > 0) {
			System.out.println("태그 삭제 성공");
		} else {
			System.out.println("태그 삭제 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/**
	 * 사용태그로 등록하기
	 * @param tagNo
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "useTag", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String useTag(@RequestParam("useTagNo[]") int[] tagNo) {
		
		List<Integer> useTagNoList = new ArrayList<>();
		
		for(int tn : tagNo) {
			useTagNoList.add(tn);
		}
		
		int result = managerService.updateUseTag(useTagNoList);
		
		if(result > 0) {
			System.out.println("사용태그로 등록 완료");
		} else {
			System.out.println("사용태그로 등록 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/**
	 * 미사용 태그로 등록하기
	 * @param tagNo
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "unUseTag", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String unUseTag(@RequestParam("unUseTagNo[]") int[] tagNo) {
		
		List<Integer> unUseTagNoList = new ArrayList<>();
		
		for(int tn : tagNo) {
			unUseTagNoList.add(tn);
		}
		
		int result = managerService.updateUnUseTag(unUseTagNoList);
		
		if(result > 0) {
			System.out.println("사용태그로 등록 완료");
		} else {
			System.out.println("사용태그로 등록 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/**
	 * 핫 키워드 등록
	 * @param tagNo
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "hotkewordAdd", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String hotkewordAdd(@RequestParam("tagNo[]") int[] tagNo, @RequestParam("tagName[]") String[] tagName) {
		
		System.out.println("들어옴");
		
		List<Map<String, Object>> hotkewordTagNoList = new ArrayList<>();
		Map<String, Object> hotMap = null;
		for(int i = 0; i < tagNo.length; i++) {
			hotMap = new HashMap<>();
			hotMap.put("tagNo", tagNo[i]);
			hotMap.put("tagName", tagName[i]);
			hotkewordTagNoList.add(hotMap);
		}
		
		System.out.println("list : " + hotkewordTagNoList);
		
		int result = managerService.updateHotkewordAdd(hotkewordTagNoList);
		
		if(result > 0) {
			System.out.println("핫 키워드 등록 완료");
		} else {
			System.out.println("핫 키워드 등록 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/**
	 * 핫 키워드 수정
	 * @param tagNo
	 * @param tagName
	 * @param hotNo
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "hotkewordEdit", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String hotkewordEdit(@RequestParam("tagNo[]") String[] tagNo, @RequestParam("tagName[]") String[] tagName,
								@RequestParam("hotNo[]") String[] hotNo) {
		
		List<Map<String, Object>> hotkewordEditList = new ArrayList<>();
		Map<String, Object> hotMap = null;
		for(int i = 0; i < tagNo.length; i++) {
			hotMap = new HashMap<>();
			hotMap.put("tagNo", tagNo[i]);
			hotMap.put("tagName", tagName[i]);
			hotMap.put("hotNo", hotNo[i]);
			hotkewordEditList.add(hotMap);
		}
		
		System.out.println("hotkewordEditList : " + hotkewordEditList);
		
		int result = managerService.updateHotkewordEdit(hotkewordEditList);
		
		if(result > 0) {
			System.out.println("핫 키워드 수정 완료");
		} else {
			System.out.println("핫 키워드 수정 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/**
	 * 카테고리 조회
	 * @param model
	 * @author leeseungwoo
	 */
	@GetMapping("categoryManage")
	public void categoryManage(Model model) {
		
		List<CategoryDTO> categoryList = managerService.selectCategoryList();
		System.out.println("categoryList : " + categoryList);
		
		model.addAttribute("categoryList", categoryList);
	}
	
	/**
	 * 카테고리 추가
	 * @param category
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping("categoryAdd")
	public String categoryAdd(@RequestParam("category") String category) {
		
		int result = managerService.insertCategory(category);
		
		if(result > 0) {
			System.out.println("카테고리 추가 완료");
		} else {
			System.out.println("카테고리 추가 실패");
		}
		
		return "redirect:categoryManage";
	}
	
	/**
	 * 카테고리 삭제
	 * @param categoryCode
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "categoryDelete", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String categoryDelete(@RequestParam("categoryCode") int categoryCode) {
		
		int result = managerService.deleteCategory(categoryCode);
		
		if(result > 0) {
			System.out.println("카테고리 삭제 완료");
		} else {
			System.out.println("카테고리 삭제 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/**
	 * 사용 카테고리로 등록
	 * @param categoryCode
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "useCategory", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String useCategory(@RequestParam("useCategoryCode[]") String[] categoryCode) {
		
		List<String> useCategoryCodeList = new ArrayList<>();
		for(String ctc : categoryCode) {
			useCategoryCodeList.add(ctc);
		}
		
		int result = managerService.updateUseCategory(useCategoryCodeList);
		
		if(result > 0) {
			System.out.println("사용 카테고리로 등록 완료");
		} else {
			System.out.println("사용 카테고리로 등록 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/**
	 * 미사용 카테고리로 등록
	 * @param categoryCode
	 * @return
	 * @author leeseungwoo
	 */
	@PostMapping(value = "unUseCategory", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String unUseCategory(@RequestParam("unUseCategoryCode[]") String[] categoryCode) {
		
		List<String> unUseCategoryCodeList = new ArrayList<>();
		for(String ctc : categoryCode) {
			unUseCategoryCodeList.add(ctc);
		}
		
		int result = managerService.updateUnUseCategory(unUseCategoryCodeList);
		
		if(result > 0) {
			System.out.println("미사용 카테고리로 등록 완료");
		} else {
			System.out.println("미사용 카테고리로 등록 실패");
		}
		
		return result > 0? "1" : "2";
	}
	
	/* 관리자 조회 */
	@GetMapping("manageManager")
	public void manageManager(Model model, HttpSession session) {
		List<AuthDTO> authList = managerService.selectAuth();
		List<ManagerDTO> managerList = managerService.selectManagers(((MemberDTO) session.getAttribute("loginMember")).getMemId());
		model.addAttribute("managerList", managerList);
		model.addAttribute("authList", authList);
	}
	
	@PostMapping("manageManager")
	@ResponseBody
	public int updateAuth(@RequestParam("memCode") int memCode, @RequestParam("selected") int selected) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memCode", memCode);
		map.put("selected", selected);
		
		int result = managerService.updateAuth(map);
		
		return result;
	}
	
	/* 관리자 아이디 생성 */
	@GetMapping("createManager")
	public void createManager() {}
	
	@PostMapping("createManager")
	public String createManager(@ModelAttribute MemberDTO member, @RequestParam int code) {
		System.out.println(member);
		member.setMemPwd(passwordEncoder.encode(member.getMemPwd()));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member", member);
		map.put("code", code);
		int result = managerService.insertNewManager(map);
		return "redirect:/manager/manageManager";
	}
	
	/* 관리자 삭제 */
	@GetMapping("deleteManager/{cks}")
	public String deleteManager(@PathVariable("cks") String[] arr, Model model) {
		
		List<String> list = new ArrayList<String>();
		for(String b : arr) {
			list.add(b);
		}
		
		int result = managerService.deleteManager(list);
		
		if(result > 0) {
			model.addAttribute("result", "삭제에 성공했습니다.");
		} else {
			model.addAttribute("result", "삭제에 실패했습니다.");
		}
		
		return "redirect:/manager/manageManager";
	}
	
	/* 관리자 아이디 중복체크 */
	@PostMapping(value = "idDupCheck", produces = "text/plain; charset=UTF-8;")
	@ResponseBody
	public String idDupCheck(@RequestParam("memId") String memId) {
		
		String message = "";
		
		int count = managerService.idDupCheck(memId);
		System.out.println(count);
		
		if(count > 0) {
			message = "사용이 불가능한 아이디입니다.";
		} else {
			message = "사용 가능한 아이디입니다.";
		}
		
		System.out.println(message);
		
		return message;
	}
	
	/* 관리자 정산 */
	@GetMapping("taxAdjustment")
	public void taxAdjustment() {}
	
	/* 중개이용료 리스트 */
	@GetMapping("taxDetailAdjustment")
	public void taxDetailAdjustment() {}
}
