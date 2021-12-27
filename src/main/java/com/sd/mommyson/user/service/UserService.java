package com.sd.mommyson.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sd.mommyson.manager.common.Pagination;
import com.sd.mommyson.manager.dto.PostDTO;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.member.dto.StoreDTO;
import com.sd.mommyson.owner.dto.CouponDTO;
import com.sd.mommyson.owner.dto.ProductDTO;
import com.sd.mommyson.user.common.SelectCriteria;
import com.sd.mommyson.user.dto.CartDTO;
import com.sd.mommyson.user.dto.FileDTO;
import com.sd.mommyson.user.dto.OrderDTO;
import com.sd.mommyson.user.dto.ReviewDTO;

public interface UserService {

	int selectTotalCount(Map<String, String> searchMap);

	List<PostDTO> selectNotice(SelectCriteria selectCriteria);

	int selectStoreTotalCount(Map<String, String> searchMap);

	List<StoreDTO> selectStoreList(Pagination pagination);

	int selectProductTotalCount(Map<String, String> searchMap);

	List<ProductDTO> selectProductList(Pagination pagination);

	List<PostDTO> selectFqaList(SelectCriteria selectCriteria);

	int selectFqaTotalCount(Map<String, String> searchMap);

	List<PostDTO> selectNoticeContents(int postNo);

	int updateIncrementBoardCount(int postNo);
	
	List<ReviewDTO> selectReviewList(Pagination pagination);

	List<ProductDTO> selectProducts(String memCode);

	Map<String, String> selectStoreByMemCode(String memCode);

	int selectReviewTotalCount(Map<String, String> searchMap);

	ProductDTO selectProductBySdCode(int sdCode);

	/* 장바구니 상품 조회  */
	int selectCountCart(HashMap<String, Integer> order);
	
	/* 장바구니에 상품 insert  */
	void insertCart(HashMap<String, Integer> order);

	/* 장바구니에 상품 update */
	void updateCart(HashMap<String, Integer> order);
	
	/* 장바구니 목록 조회 */
	List<CartDTO> cartList(MemberDTO member);
	
	/* 방문포장 주문리스트 저장 */
	Map<String,Object> insertPackageOrderList(HashMap<String, Object> insertPackage);

	/* 배달 주문리스트 저장  */
	Map<String, Object> insertDeliveryOrderList(HashMap<String, Object> insertDelivery);
	
	/* 장바구니 리스트 삭제  */
	int deleteCartList(HashMap<String, Object> deleteCartProduct);

	/* 방문포장 주문 리스트 조회 */
	List<Map<String, String>> selectOrderList(List<Integer> orderCodes);

	/* 방문포장 쿠폰 리스트 조회 */
	List<CouponDTO> selectCouponList(int memCode);

	/* 방문포장 주문 리스트 update */
	int updateOrder(List<Map<String, Object>> list);
	
	/* 방문포장,배달 쿠폰 리스트 update */
	int updateCouponStatus(List<Integer> list2);
	
	/* 방문포장 결제완료화면 조회 */
	List<Map<String, Object>> selectPackageOrderComplete(List<Map<String, Object>> list);
	
	/* 배달주문 결제 시 주문내역 업데이트 */
	int updateOrder2(List<Map<String, Object>> list);
	
	/* 배달 결제완료화면 조회 */
	List<Map<String, Object>> selectDeliveryOrderComplete(List<Map<String, Object>> list);
	
	/* 주문 결제 취소 */
	void deleteOrder(List<Integer> orderCodeList);

	int insertReport(Map<String, Integer> reportInfo);

	Map<String, String> selectStoreInfoByMemcode(int memCode);
	
	int selectSearchTotalCount(Map<String, Object> searchMap);

	List<ProductDTO> selectSearchList(Map<String, Object> searchMap);
	
	List<PostDTO> selectImportantNotice();

	List<PostDTO> selectRecentNotice();

	List<PostDTO> selectOftenFqa();

	Integer insertJJIMplus(Map<String, Integer> map);

	List<String> selectJJIMList(String memCode);

	Integer deleteJJIMplus(Map<String, Integer> map);

	int registMtmConsultingText(Map<String, Object> mtmConsulting);

	int registMtmConFile(Map<String, Object> fileInfo);

	int selectMtmTotalCount(Map<String, String> searchMap);

	List<PostDTO> selectMtmConsulting(SelectCriteria selectCriteria);

	PostDTO selectConsultingCon(Map<String, Object> searchMap);

	List<FileDTO> selectConsumerImg(int postNo);

	List<FileDTO> selectManagerImg(int postNo);

	int updateDelConsulting(int postNo);

	int updateMtmConsultingText(Map<String, Object> mtmConsulting);

	int updateMtmConFile(Map<String, Object> fileInfo);

	int updateVcountFqa(int postNo);

	int updateDelImg(Map<String, Object> delImgInfo);
	
	/* 회원주소조회 */
	MemberDTO selectMemberAddress(int memCode);

}
