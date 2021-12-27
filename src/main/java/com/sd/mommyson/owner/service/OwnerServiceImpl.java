package com.sd.mommyson.owner.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sd.mommyson.manager.common.Pagination;
import com.sd.mommyson.member.dao.MemberDAO;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.owner.dao.OwnerDAO;
import com.sd.mommyson.owner.dto.CouponDTO;
import com.sd.mommyson.owner.dto.CpHistoryDTO;
import com.sd.mommyson.owner.dto.DCProduct;
import com.sd.mommyson.owner.dto.MembershipAndStoreDTO;
import com.sd.mommyson.owner.dto.MembershipDTO;
import com.sd.mommyson.owner.dto.ProductDTO;
import com.sd.mommyson.owner.dto.TagDTO;
import com.sd.mommyson.user.dto.OrderDTO;
import com.sd.mommyson.user.dto.ReviewDTO;

@Service
public class OwnerServiceImpl implements OwnerService{

	private OwnerDAO ownerDAO;
	private MemberDAO memberDAO;
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	public OwnerServiceImpl(MemberDAO memberDAO,OwnerDAO ownerDAO, BCryptPasswordEncoder passwordEncoder) {
		this.memberDAO = memberDAO;
		this.ownerDAO = ownerDAO;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public MemberDTO selectOwner(MemberDTO member) {

		
		return memberDAO.selectOwner(member);
	}

	@Override
	public List<CouponDTO> selectCoupon(Pagination pagination) {
		
		return ownerDAO.selectCoupon(pagination);
	}

	@Override
	public List<ReviewDTO> selectReview(Pagination pagination) {
		
		List<ReviewDTO> list = ownerDAO.selectReview(pagination);
		
		return list;
	}

	@Override
	public int modifyInfo(Map<String, Object> modifyInfo) {

		System.out.println(modifyInfo);
		
		int result = ownerDAO.modifyInfo(modifyInfo);
		
		return result;
	}

	@Override
	public int modifyCeo(Map<String, Object> modifyInfo) {
		
		int result = ownerDAO.modifyCeo(modifyInfo);
		
		return result;
	}

	@Override
	public int modifyStore(Map<String, Object> modifyInfo) {

		int result = ownerDAO.modifyStore(modifyInfo);
		
		return result;
	}

	@Override
	public int registCoupon(CouponDTO coupon) {
		
		int result = ownerDAO.registCoupon(coupon);
		
		return result;
	
	}
	@Override
	public int modifyPwd(MemberDTO member) {
		
		int result = ownerDAO.modifyPwd(member);
		
		return result;
	}

	@Override
	public int registCouponStore(int memCode) {
		
		int result = ownerDAO.registCouponStore(memCode);
		
		return result;
		
	}
	
	@Override
	public List<TagDTO> selectTag() {

		return ownerDAO.selectTag();
	}

	@Override
	public int registProduct(Map<String, Object> productInfo) {

		int result = ownerDAO.registProduct(productInfo);
		
		return result;
	}

	@Override
	public List<ProductDTO> selectProduct(Map<String, Object> searchMap) {
		
		return ownerDAO.selectProduct(searchMap);
	}

	@Override
	public int selectTotalCount(Map<String, Object> searchMap) {

		int result = ownerDAO.selectTotalCount(searchMap);
			
		return result;
	}

	@Override
	public int modifyStatus(ProductDTO product) {

		int result = ownerDAO.modifyStatus(product);
		
		return result;
	}

	@Override
	public int removeProduct(List<Integer> deleteCode) {

		int result = 0;
		
		int delete = ownerDAO.removeProduct(deleteCode);
		
		if(delete > 0) {
			
			int delCode = ownerDAO.removeProductCode(deleteCode);
			
			if(delCode > 0) {
				
				result += 1;
			}
			
		}
		
		return result;
	}

	@Override
	public int selectTotalDC(Map<String, Object>  searchMap) {
		
		int result = ownerDAO.selectTotalDC(searchMap);
		
		return result;
	}

	@Override
	public List<ProductDTO> selectDC(Map<String, Object> searchMap) {

		List<ProductDTO> result = ownerDAO.selectDC(searchMap);
		
		return result;
	}

	@Override
	public int selectTotalModal(Map<String, Object> searchMap) {

		int result = ownerDAO.selectTotalModal(searchMap);

		return result;
	}

	@Override
	public List<ProductDTO> selectProdouct(int memCode) {

		List<ProductDTO> product = ownerDAO.selectProdouct(memCode);
		
		return product;
	}

	@Override
	public int registDc(List<DCProduct> maps) {

		int result = ownerDAO.registDc(maps);
				
		return result;
	}

	@Override
	public List<OrderDTO> selectOrderList(Pagination pagination) {
		
		List<OrderDTO> order = ownerDAO.selectOrderList(pagination);
		
		return order;
	}

	@Override
	public int selectOrderListTotalCount(String storeName) {
		
		int result = ownerDAO.selectOrderListTotalCount(storeName);
		
		return result;
	}
	
	@Override
	public int modifyOwnerStatus(Map<String, Object> map) {

		int result = ownerDAO.modifyOwnerStatus(map);
		
		return result;
	}

	@Override
	public int deleteReview(List<Integer> deleteReviewList) {

		int result = ownerDAO.deleteReview(deleteReviewList);
		
		return result;
	}

	@Override
	public int deleteCoupon(List<Integer> deleteCouponList) {

		int result = ownerDAO.deleteCoupon(deleteCouponList);
		
		return result;
	}

	@Override
	public int selectCouponListTotalCount(int memCode) {
		
		int result = ownerDAO.selectCouponListTotalCount(memCode);
		
		return result;
	}

	@Override
	public int selectReviewListTotalCount(String storeName) {
		
		int result = ownerDAO.selectReviewListTotalCount(storeName);
		
		return result;
	}

	@Override
	public MembershipDTO selectMembership(int msCode) {

		MembershipDTO membership = ownerDAO.selectMembership(msCode);
		
		return membership;
	}

	@Override
	public int modifyProduct(List<DCProduct> maps) {
		// 결과값에 대한 내용을 서비스에서 처리 해야한다.
		// 프로시져에 대한 내용을 사용하게 되면 성공에 대한 값을 일반 업데이트와 다른 기준으로 넘겨준다.
		int result = 0;
		int checkValue = 0;
		for(int i = 0; i < maps.size(); i++) {
			
			DCProduct dc = maps.get(i);
			
			checkValue += ownerDAO.modifyProduct(dc);
		} 
		
		if(checkValue == maps.size()) {
			result = checkValue;
		}
		
		return result;
	}

	@Override
	public List<OrderDTO> selectOrderList2(Map<String, Object> searchMap) {
		
		List<OrderDTO> result = ownerDAO.selectOrderList2(searchMap);
		
		return result;
	}

	@Override
	public OrderDTO selectOrder(int orderCode) {
		
		return ownerDAO.selectOrder(orderCode);
	}

	@Override
	public int acceptModifyOrder(Map<Object, Object> orderMap) {
		
		int result = ownerDAO.acceptModifyOrder(orderMap);
		
		if(result == 1) {
			System.out.println("accepTime 업데이트 성공");
		}
		
		return result;
	}

	@Override
	public int cancleModifyOrder(Map<Object, Object> orderMap) {
		
		int result = ownerDAO.cancleModifyOrder(orderMap);
		
		if(result == 1) {
			System.out.println("accepTime 업데이트 성공");
		}
		
		return result;
	}

	@Override
	public int completeModifyOrder(Map<Object, Object> orderMap) {
		
		int result = ownerDAO.completeModifyOrder(orderMap);
		
		if(result == 1) {
			System.out.println("주문 complete 업데이트 성공~~~~~~~??");
		}
		
		return result;
	}

	@Override
	public int selectTotalCountOrder(Map<String, Object> searchMap) {
		
		int result = ownerDAO.selectTotalCountOrder(searchMap);
		
		return result;
	}

	@Override
	public int removeDc(List<Integer> codeList) {

		int result = ownerDAO.removeDc(codeList);
		
		return result;
	}

	@Override
	public int modifyDc(List<Integer> codeList) {

		int result = ownerDAO.modifyDc(codeList);
		
		return result;
	}

	@Override
	public ProductDTO selectPd(int sdCode) {
		
		return ownerDAO.selectPd(sdCode);
	}

	@Override
	public List<Integer> seletTagList(int sdCode) {

		return ownerDAO.seletTagList(sdCode);
	}

	@Override
	public int updateProduct(Map<String, Object> productInfo) {

		int result = 0;
		
		int updateProduct = ownerDAO.updateProduct(productInfo);
		
		if(updateProduct > 0) {
			
			@SuppressWarnings("unchecked")
			List<Integer> tagList = (List<Integer>)productInfo.get("tagList");
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			
			ProductDTO pr = (ProductDTO)productInfo.get("product");
			
			int sdCode = pr.getSdCode();
			
			map.put("sdCode",sdCode);

			int removeTag = ownerDAO.removeTag(sdCode);
			
			if(removeTag > 0) {
				
				int updateTag = 0;
				
				for(int i = 0; i < tagList.size(); i++) {
					
					int tag = tagList.get(i);
					
					map.put("tag", tag);
					
					updateTag += ownerDAO.insertTag(map);
				}
				
				if(updateTag == tagList.size()) {
					result = 1;
				}
			}
			
		}
		
		return result;
	}

	@Override
	public MembershipAndStoreDTO selectMembershipAndStore(int memCode) {

		MembershipAndStoreDTO membership = ownerDAO.selectMembershipAndStore(memCode);
		
		return membership;
	}

	@Override
	public int registMembership(Map<String, Object> info) {

		// 오늘 날짜 구하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		
		Calendar c1 = Calendar.getInstance(); 
		
		String today = sdf.format(c1.getTime());
		
		// 오늘날짜 + 이용권 일 수 
		
		int msDate = (Integer)info.get("msDate");
		
		c1.add(c1.DATE, msDate);
		
		String endDate = sdf.format(c1.getTime());
		
		System.out.println(endDate);
		
		info.put("endDate", endDate);
		info.put("startDate", today);
		
		return ownerDAO.registMembership(info);
	}

	@Override
	public Map<String, Object> selectMembershipInfo(int memCode) {

		
		return ownerDAO.selectMembershipInfo(memCode);
	}

	@Override
	public int modifiyMembership(Map<String, Object> info) {

		int result = 0;
		
		// 현재 사용하고 있는 이용권의 연장여부를 Y로 변경
		int modify = ownerDAO.modifyExtendYn(info);
		
		// update 성공시 insert를 위한 작업을 수행
		if(modify > 0 ) {
			
			// 이용권 남은 날짜 계산
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Calendar c1 = Calendar.getInstance(); 
			
			String today = sdf.format(c1.getTime());
			
			Date date = Date.valueOf(today);
			
			Date dDay = (Date)info.get("dDay");
			
			long calDate = dDay.getTime() - date.getTime();
			
			long calDates = calDate / (24 * 60 * 60 * 1000);
			
			calDates = Math.abs(calDates);
			
			System.out.println("날짜 차이 : " + calDates);

			// 이용권 남은 일 + 이용권 일 수
			
			Calendar c2 = Calendar.getInstance();
			
			c2.setTime(dDay);
			
			c2.add(Calendar.DATE, (int)calDates);
			
			String endDate = sdf.format(c2.getTime());
			
			System.out.println("종료일 : " + endDate);
			
			// 종료일 넘겨주기, 시작일 넘겨주기 
			info.put("endDate", endDate);
			info.put("startDate", today);
			
			int extend = ownerDAO.registMembership(info);
			
			// insert 성공 시 1을 반환하도록 
			if(extend > 0) {
				result = 1;
			}
		}
		
		return result;
	}

	@Override
	public List<Map<String, Object>> selectMembershipInfoList(Map<String, Object> map) {

		return ownerDAO.selectMembershipInfoList(map);
	}

	@Override
	public int selectTotalReceipt(int memCode) {

		return ownerDAO.selectTotalReceipt(memCode);
	}

	@Override
	public Map<String, Object> selectPayInfo(Map<String, Object> map) {

		return ownerDAO.selectPayInfo(map);
	}

	@Override
	public int modifyEDateStatus(int sdCode) {

		int result = 0;
		
		int status = ownerDAO.modifyEDateStatus(sdCode);
		
		if(status > 0) {
			
			int dc = ownerDAO.removeDcs(sdCode); 
			
			if(dc > 0) {
					
				result += 1;
			}
		}
		
		return result;
	}

	@Override
	public List<ProductDTO> selectProdoucts(int memCode) {

		return ownerDAO.selectProdoucts(memCode);
	}
	
	@Override	
	public int registCpToReview(List<Integer> chkReview, List<Integer> cpCode) {
		
		//리뷰 리스트들 요소 하나씩 뽑아주기
		Map<String,Object> result = new HashMap<>();
		
		int success = 0;
		
		for(int i = 0; chkReview.size() > i; i++) {
			
			int value = chkReview.get(i);
			
			result.put("review", value);
			
			for(int j = 0; j < cpCode.size(); j++) {
				
				int value2 = cpCode.get(j);
				
				result.put("cpCode",value2);
				
				int goDAO = ownerDAO.registCpToReview(result);
				
				// 하나씩 보내서 성공하면 1반환 계속 반환되면 2가 되고....
				if(goDAO > 0 ) {
					success += 1;
				} 
				System.out.println("인서트 성공이니??!!! : " + success);
			}
		}
		return success;
	}

	@Override
	public int selectgiveListTotalCount(int memCode) {
		
		return ownerDAO.selectgiveListTotalCount(memCode);
	}

	@Override
	public List<CpHistoryDTO> selectgiveList(Pagination pagination) {
		
		return ownerDAO.selectgiveList(pagination);
	}

	@Override
	public Map<String, Integer> selectTotalPrice(String storeName) {

		return ownerDAO.selectTotalPrice(storeName);
	}

	@Override
	public boolean selectOriginPwd(int memCode, String memPwd) {
		
		boolean result = false;
		
		if(passwordEncoder.matches(memPwd, ownerDAO.selectEncPwd(memCode))) {
			
			int yn = ownerDAO.updateDeleteYN(memCode);
			
			if(yn > 0) {
				result = true;
			}
			
		} else {
			result = false;
		}
		
		return result;
	}
	
	@Override
	public Map<String, Integer> selectDelPrice(String storeName) {
		
		
		return ownerDAO.selectDelPrice(storeName);
	}

	@Override
	public Integer selectPickupPrice(String storeName) {
		
		return ownerDAO.selectPickupPrice(storeName);
	}

	@Override
	public List<Map<String, Object>> selectDailySales(Map<String, Object> map) {
		
		return ownerDAO.selectDailySales(map);
	}

	@Override
	public int selectTotalDailySalse(Map<String, Object> map) {

		int result = ownerDAO.selectTotalDailySalse(map);
		
		return result;
	}

	@Override
	public int selectTotalsalseMonth(Map<String, Object> map) {
		
		return ownerDAO.selectTotalsalseMonth(map);
	}

	@Override
	public List<Map<String, Object>> selectSalseMonth(Map<String, Object> map) {

		return ownerDAO.selectSalseMonth(map);
	}

	@Override
	public List<Map<String, Object>> selectMonth(String storeName) {

		return ownerDAO.selectMonth(storeName);
	}

}
