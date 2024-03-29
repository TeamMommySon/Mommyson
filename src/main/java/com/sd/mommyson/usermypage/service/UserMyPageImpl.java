package com.sd.mommyson.usermypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.member.dto.StoreDTO;
import com.sd.mommyson.user.common.SelectCriteria;
import com.sd.mommyson.user.dto.OrderDTO;
import com.sd.mommyson.user.dto.ReviewDTO;
import com.sd.mommyson.usermypage.dao.UserMyPageDAO;
import com.sd.mommyson.usermypage.dto.CouponDTO;
import com.sd.mommyson.usermypage.dto.CouponHistoryDTO;
import com.sd.mommyson.usermypage.dto.MyOrderDTO;
import com.sd.mommyson.usermypage.dto.OrderInfoDTO;

@Service
public class UserMyPageImpl implements UserMyPageService {
	
	private UserMyPageDAO userMyPageDAO;
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	public UserMyPageImpl( UserMyPageDAO userMyPageDAO, BCryptPasswordEncoder passwordEncoder) {
		this.userMyPageDAO = userMyPageDAO;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public int selectMycouponNo(Map<String, String> searchMap) {

		int totalCount = userMyPageDAO.selectMycouponNo(searchMap);
		return totalCount;
	}

	@Override
	public List<CouponHistoryDTO> selectMyCouponList(SelectCriteria selectCriteria) {
		
		List<CouponHistoryDTO> myCouponList = userMyPageDAO.selectMyCouponList(selectCriteria);
		
		return myCouponList;
	}

	@Override
	public int selectMyOrderNum(Map<String, String> searchMap) {

		int totalCount = userMyPageDAO.selectMyOrderNum(searchMap);
		
		return totalCount;
	}

	@Override
	public List<MyOrderDTO> selectMyOrderList(SelectCriteria selectCriteria) {

		List<MyOrderDTO> myOrderList = userMyPageDAO.selectMyOrderList(selectCriteria);
		return myOrderList;
	}

	@Override
	public int selectMyRecommendStore(Map<String, String> searchMap) {

		int totalCount = userMyPageDAO.selectMyRecommendStore(searchMap);
		return totalCount;
	}

	@Override
	public List<StoreDTO> selectRecommendStore(SelectCriteria selectCriteria) {
		
		List<StoreDTO> storeReconmendList = userMyPageDAO.selectRecommendStore(selectCriteria);
		
		return storeReconmendList;
	}

	@Override
	public int deleteRecommendStore(int storeNo) {

		int result = userMyPageDAO.deleteRecommendStore(storeNo);
		
		return result;
	}

	@Override
	public int selectTotalReviewCount(Map<String,String> searchMap) {
		int totalCount = userMyPageDAO.selectTotalReviewCount(searchMap);
		return totalCount;
	}

	@Override
	public List<ReviewDTO> selectReviewContentList(SelectCriteria selectCriteria) {
		
		List<ReviewDTO> reviewContentList = userMyPageDAO.selectReviewContentList(selectCriteria);
		return reviewContentList;
	}

	@Override
	public List<HashMap<String, String>> selectMyOrderSd(int userCode) {
		List<HashMap<String, String>> mySdInfo = userMyPageDAO.selectMyOrderSd(userCode);
		return mySdInfo;
	}

	@Override
	public int insertReview(ReviewDTO review) {
		return userMyPageDAO.insertReview(review);
	}

	@Override
	public int updateStoreGrade(Map<String, Object> map) {
		return userMyPageDAO.updateStoreGrade(map);
	}

	@Override
	public double selectStoreGrade(int orderCode) {
		return userMyPageDAO.selectStoreGrade(orderCode);
	}

	@Override
	public List<HashMap<String, String>> selectMySdInfo(int userCode) {
		List<HashMap<String, String>> productInfo = userMyPageDAO.selectMySdInfo(userCode);
		return productInfo;
	}

	@Override
	public int updateOrderCancel(int orderNo) {
		int result = userMyPageDAO.updateOrderCancel(orderNo);
		return result;
	}

	@Override
	public int updateDelReview(int rvCodeDel) {
		int result = userMyPageDAO.updateDelReview(rvCodeDel);
		return result;
	}

	@Override
	public int updateSignOut(MemberDTO memberInfo) {

		int memberConfirmation = 0;
		if(passwordEncoder.matches(memberInfo.getMemPwd(), userMyPageDAO.selectEncPwd(memberInfo))) {
			
			memberConfirmation = userMyPageDAO.updateSignOut(memberInfo);
		}
		return memberConfirmation;
	}

	@Override
	public boolean selectMatchUserInfo(MemberDTO memberInfo) {
		
		boolean confirmationResult;
		
		if(passwordEncoder.matches(memberInfo.getMemPwd(), userMyPageDAO.selectEncPwd(memberInfo))) {
			
			confirmationResult = true;
		} else {
			confirmationResult = false;
		}
		
		return confirmationResult;
	}

	@Override
	public ReviewDTO selectReviewInfo(int rvCode) {
		
		ReviewDTO reviewInfo = userMyPageDAO.selectReviewInfo(rvCode);
		
		return reviewInfo;
	}

	@Override
	public int updateReview(Map<String, Object> amendmentRv) {

		int result = userMyPageDAO.updateReview(amendmentRv);
		return result;
	}

	@Override
	public int selectCeoCode(int cpCode) {
		 int ceoCode = userMyPageDAO.selectCeoCode(cpCode);
		return ceoCode;
	}

	@Override
	public void updateMemberInfo(MemberDTO member) {
		userMyPageDAO.updateMemberInfo(member);
		userMyPageDAO.updateUserInfo(member);
	}



	

}
