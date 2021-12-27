package com.sd.mommyson.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sd.mommyson.manager.common.Pagination;
import com.sd.mommyson.manager.dto.PostDTO;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.member.dto.StoreDTO;
import com.sd.mommyson.owner.dto.CouponDTO;
import com.sd.mommyson.owner.dto.ProductDTO;
import com.sd.mommyson.user.common.SelectCriteria;
import com.sd.mommyson.user.dao.UserDAO;
import com.sd.mommyson.user.dto.CartDTO;
import com.sd.mommyson.user.dto.FileDTO;
import com.sd.mommyson.user.dto.OrderDTO;
import com.sd.mommyson.user.dto.ReviewDTO;

@Service
public class UserServiceImpl implements UserService{
	
	private UserDAO userDAO;
	
	@Autowired
	public UserServiceImpl(UserDAO userDAO) {
		this.userDAO = userDAO;
	}


	@Override
	public List<PostDTO> selectRecentNotice() {

		List<PostDTO> noticeMainCon = userDAO.selectRecentNotice();		
		
		
		return noticeMainCon;
	}
	
	@Override
	public List<PostDTO> selectOftenFqa() {
		List<PostDTO> oftenFqa = userDAO.selectOftenFqa();
		
		return oftenFqa;
	}
	
	@Override
	public int selectTotalCount(Map<String, String> searchMap) {
		System.out.println("서비스 searchMap: " + searchMap);
		int totalCount = userDAO.selectTotalCount(searchMap);
		return totalCount;
	}

	@Override
	public int selectFqaTotalCount(Map<String, String> searchMap) {
		int totalCount = userDAO.selectFqaTotalCount(searchMap);
		return totalCount;
	}

	@Override
	public List<PostDTO> selectNotice(SelectCriteria selectCriteria) {
		
		List<PostDTO>noticeList = userDAO.selectNotice(selectCriteria);
		return noticeList;
	}
	
	@Override
	public List<PostDTO> selectNoticeContents(int postNo) {

		List<PostDTO> noticeContentList = userDAO.selectNoticeContents(postNo);
		
		return noticeContentList;
	}

	@Override
	public int updateIncrementBoardCount(int postNo) {
		int result = userDAO.updateIncrementBoardCount(postNo);
		return result;
	}

	@Override
	public List<PostDTO> selectImportantNotice() {

		List<PostDTO> importantNotice = userDAO.selectImportantNotice();
		return importantNotice;
	}

	@Override
	public List<StoreDTO> selectStoreList(Pagination pagination) {
		List<StoreDTO> storeList = userDAO.selectStoreList(pagination);
		return storeList;
	}
	
	@Override
	public List<PostDTO> selectFqaList(SelectCriteria selectCriteria) {

		List<PostDTO> fqaList = userDAO.selectFqaList(selectCriteria);
		
		return fqaList;
	}


	@Override
	public int selectProductTotalCount(Map<String, String> searchMap) {
		return userDAO.selectProductTotalCount(searchMap);
	}


	@Override
	public List<ProductDTO> selectProductList(Pagination pagination) {
		List<ProductDTO> productList = userDAO.selectProductList(pagination);
		return productList;
	}

	@Override
	public int selectStoreTotalCount(Map<String, String> searchMap) {
		return userDAO.selectStoreTotalCount(searchMap);
	}

	@Override
	public List<ReviewDTO> selectReviewList(Pagination pagination) {
		return userDAO.selectReviewList(pagination);
	}


	@Override
	public List<ProductDTO> selectProducts(String memCode) {
		return userDAO.selectProducts(memCode);
	}


	@Override
	public Map<String, String> selectStoreByMemCode(String memCode) {
		return userDAO.selectStoreMyMemCode(memCode);
	}


	@Override
	public int selectReviewTotalCount(Map<String, String> searchMap) {
		return userDAO.selectReviewTotalCount(searchMap);
	}


	@Override
	public ProductDTO selectProductBySdCode(int sdCode) {
		return userDAO.selectProductBySdCode(sdCode);
	}


	/* 장바구니 상품 조회  */
	@Override
	public int selectCountCart(HashMap<String, Integer> order) {
		return userDAO.selectCountCart(order);
	}
	
	/* 장바구니에 상품 insert  */
	@Override
	public void insertCart(HashMap<String, Integer> order) {
		 userDAO.insertCart(order);
		
	}


	/* 장바구니에 상품 update */
	@Override
	public void updateCart(HashMap<String, Integer> order) {
		userDAO.updateCart(order);
		
	}

	
	/* 장바구니 목록 조회 */
	@Override
	public List<CartDTO> cartList(MemberDTO member) {
		return userDAO.cartList(member);
	}

	/* 장바구니 리스트 삭제 */
	@Override
	public int deleteCartList(HashMap<String, Object> deleteCartProduct) {

		int result = 0;
		
		int success = userDAO.deleteCartList(deleteCartProduct);
		
		if(success > 0) {
			result += 1;
		}
		return result;
	}
	
	
	/* 방문포장 주문리스트 저장 & 조회 */
	   @Override
	   public Map<String,Object> insertPackageOrderList(HashMap<String, Object> insertPackage) {
	      
	      int result = 0;
	      
	      Map<String, Object> map = new HashMap<String, Object>();
	      
	      List<Integer> price = (List<Integer>)insertPackage.get("packagePayList");
	      
	      int[] storeCode = (int[])insertPackage.get("storeCode");
	      
	      String[] storeName = (String[])insertPackage.get("storeName");

	      int[] sdCode = (int[])insertPackage.get("sdCode");

	      String[] sdName = (String[])insertPackage.get("sdName");

	      int[] amount = (int[])insertPackage.get("amount");
	      
	      List<Integer> orderCodes = new ArrayList<>();
	      for(int i = 0; i< price.size(); i++) {
	         
	    	 map.put("memCode", insertPackage.get("memCode"));
	         map.put("price", price.get(i));
	         map.put("storeCode",storeCode[i]);
	         map.put("storeName", storeName[i]);
	         map.put("sdCode", sdCode[i]);
	         map.put("sdName", sdName[i]);
	         map.put("amount", amount[i]);
	         
	         int success = userDAO.insertPackageOrderList(map);
	         orderCodes.add(userDAO.selectLastOrderCode());
	         if(success > 0) {
	            result += 1;
	         }
	         
	      }
	      Map<String,Object> resultMap = new HashMap<>();
	      resultMap.put("result", result);
	      resultMap.put("orderCodes", orderCodes);
	      
	      return resultMap;      
	   }

	
	   /* 배달 주문리스트 저장 */
		@Override
		public Map<String, Object> insertDeliveryOrderList(HashMap<String, Object> insertDelivery) {

			int result = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			List<Integer> price = (List<Integer>)insertDelivery.get("deliveryPayList");
			
			int[] storeCode = (int[])insertDelivery.get("storeCode");
			
			String[] storeName = (String[])insertDelivery.get("storeName");
			
	        int[] sdCode = (int[])insertDelivery.get("sdCode");

	        int[] amount = (int[])insertDelivery.get("amount");
	      
	        String[] sdName = (String[])insertDelivery.get("sdName");
	        
			
		      List<Integer> orderCodes = new ArrayList<>();

		      for(int i = 0; i< price.size(); i++) {
		         
		    	 map.put("memCode", insertDelivery.get("memCode"));
		         map.put("price", price.get(i));
		         map.put("storeCode",storeCode[i]);
		         map.put("storeName", storeName[i]);
		         map.put("sdCode", sdCode[i]);
		         map.put("sdName", sdName[i]);
		         map.put("amount", amount[i]);
				
				int success = userDAO.insertDeliveryOrderList(map);
				orderCodes.add(userDAO.selectLastOrderCode());
				if(success > 0) {
					result += 1;
				}
			
			
			}
		      Map<String,Object> resultMap = new HashMap<>();
		      resultMap.put("result", result);
		      resultMap.put("orderCodes", orderCodes);
		      
		      return resultMap;     
		}

	
	/**
	    * 배달주문 결제 시 주문내역 업데이트
	    * @author leeseungwoo
	    */
	   @Override
	   public int updateOrder2(List<Map<String, Object>> list) {
	      
	      int result = 0;
	      for(int i = 0; i < list.size(); i++) {
	         System.out.println(list.get(i));
	         result += userDAO.updateOrder2(list.get(i));
	      }
	      System.out.println("service 들어옴 -----------------------" + result);
	      return result;
	   }
	
	/* 방문포장 결제완료화면 조회 */
	@Override
	public List<Map<String,Object>> selectPackageOrderComplete(List<Map<String, Object>> list) {
		return userDAO.selectPackageOrderComplete(list);
	}
	
	/* 배달 결제완료화면 조회 */
	@Override
	public List<Map<String, Object>> selectDeliveryOrderComplete(List<Map<String, Object>> list) {
		return userDAO.selectDeliveryOrderComplete(list);
	}

	@Override
	public int insertReport(Map<String, Integer> reportInfo) {
		return userDAO.insertReport(reportInfo);
	}

	@Override
	public Map<String, String> selectStoreInfoByMemcode(int memCode) {
		return userDAO.selectStoreInfoByMemcode(memCode);
	}


	@Override
	public int selectSearchTotalCount(Map<String, Object> searchMap) {
		return userDAO.selectSearchTotalCount(searchMap);
	}


	@Override
	public List<ProductDTO> selectSearchList(Map<String, Object> searchMap) {
		return userDAO.selectSearchList(searchMap);
	}

	@Override
	public Integer insertJJIMplus(Map<String, Integer> map) {
		return userDAO.insertJJIMplus(map);
	}


	@Override
	public List<String> selectJJIMList(String memCode) {
		return userDAO.selectJJIMList(memCode);
	}


	@Override
	public Integer deleteJJIMplus(Map<String, Integer> map) {
		return userDAO.deleteJJIMplus(map);
	}


	@Override
	public int registMtmConsultingText(Map<String, Object> mtmConsulting) {

		int result = userDAO.registMtmConsultingText(mtmConsulting);
	
		return result;
	}
		
	@Override	
	public List<Map<String, String>> selectOrderList(List<Integer> orderCodes) {
		return userDAO.selectOrderList(orderCodes);
	}


	@Override
	public List<CouponDTO> selectCouponList(int memCode) {
		return userDAO.selectCouponList(memCode);
	}




	/**@author ShinHyungi
	 * order_tbl 반복문 돌며 update
	 */
	@Override
	public int updateOrder(List<Map<String, Object>> list) {
		
		int result = 0;
		for(int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
			result += userDAO.updateOrder(list.get(i));
			userDAO.insertRTNotice(list.get(i));
		}
		System.out.println("service 들어옴 -----------------------" + result);
		return result;
	}
	
	@Override
	public void deleteOrder(List<Integer> orderCodeList) {
		userDAO.deleteOrder(orderCodeList);
	}

	@Override
	public int registMtmConFile(Map<String, Object> fileInfo) {
		int fileUploadResult = userDAO.registMtmConFile(fileInfo);
		return fileUploadResult;
	}
	
	@Override
	public int updateCouponStatus(List<Integer> list2) {
		return userDAO.updateCouponStatus(list2);
	}

	@Override
	public int selectMtmTotalCount(Map<String, String> searchMap) {
		int totalCount = userDAO.selectMtmTotalCount(searchMap);
		return totalCount;
	}

	@Override
	public List<PostDTO> selectMtmConsulting(SelectCriteria selectCriteria) {
		
		List<PostDTO> mtmConsultingSelect = userDAO.selectMtmConsulting(selectCriteria);
		
		return mtmConsultingSelect;
	}


	@Override
	public PostDTO selectConsultingCon(Map<String, Object> searchMap) {

		PostDTO consultingCon = userDAO.selectConsultingCon(searchMap);
		return consultingCon;
	}


	@Override
	public List<FileDTO> selectConsumerImg(int postNo) {
		List<FileDTO> userFileImg = userDAO.selectConsumerImg(postNo);
		return userFileImg;
	}


	@Override
	public List<FileDTO> selectManagerImg(int postNo) {
		List<FileDTO> managerFileImg = userDAO.selectManagerImg(postNo);
		return managerFileImg;
	}


	@Override
	public int updateDelConsulting(int postNo) {
		
		int delResultdelResult = userDAO.updateDelConsulting(postNo);
		
		return delResultdelResult;
	}


	@Override
	public int updateMtmConsultingText(Map<String, Object> mtmConsulting) {
		
		int result = userDAO.updateMtmConsultingText(mtmConsulting);
		return result;
	}


	@Override
	public int updateMtmConFile(Map<String, Object> fileInfo) {

		int fileUploadResult = userDAO.updateMtmConFile(fileInfo);
		return fileUploadResult;
	}


	@Override
	public int updateVcountFqa(int postNo) {
		
		int result = userDAO.updateVcountFqa(postNo);
		return result;
	}


	@Override
	public int updateDelImg(Map<String, Object> delImgInfo) {
		int result = userDAO.updateDelImg(delImgInfo);
		return result;
	}


	@Override
	public MemberDTO selectMemberAddress(int memCode) {
		
		return userDAO.selectMemberAddress(memCode);
	}

}
