package com.sd.mommyson.owner.dao;

import java.util.List;
import java.util.Map;

import com.sd.mommyson.manager.common.Pagination;
import com.sd.mommyson.member.dto.CeoDTO;
import com.sd.mommyson.member.dto.MemberDTO;
import com.sd.mommyson.owner.dto.CouponDTO;
import com.sd.mommyson.owner.dto.CpHistoryDTO;
import com.sd.mommyson.owner.dto.DCProduct;
import com.sd.mommyson.owner.dto.MembershipAndStoreDTO;
import com.sd.mommyson.owner.dto.MembershipDTO;
import com.sd.mommyson.owner.dto.ProductDTO;
import com.sd.mommyson.owner.dto.TagDTO;
import com.sd.mommyson.user.dto.OrderDTO;
import com.sd.mommyson.user.dto.ReviewDTO;

public interface OwnerDAO {

	public CeoDTO selectOwner(MemberDTO member);

	public List<CouponDTO> selectCoupon(Pagination pagination);

	public List<ReviewDTO> selectReview(Pagination pagination);
	
	public int modifyInfo(Map<String, Object> modifyInfo);

	public int modifyCeo(Map<String, Object> modifyInfo);

	public int registCoupon(CouponDTO coupon);

	public int registCouponStore(int memCode);

	public int modifyStore(Map<String, Object> modifyInfo);

	public int modifyPwd(MemberDTO member);

	public List<TagDTO> selectTag();

	public int registProduct(Map<String, Object> productInfo);

	public List<ProductDTO> selectProduct(Map<String, Object> searchMap);

	public int selectTotalCount(Map<String, Object> searchMap);

	public int deleteReview(List<Integer> deleteReviewList);

	public int deleteCoupon(List<Integer> deleteCouponList);

	public int modifyStatus(ProductDTO product);

	public int removeProduct(List<Integer> deleteCode);

	public int selectTotalDC(Map<String, Object> searchMap);

	public List<ProductDTO> selectDC(Map<String, Object> searchMap);

	public int selectTotalModal(Map<String, Object> searchMap);

	public List<ProductDTO> selectProdouct(int memCode);

	public List<OrderDTO> selectOrderList(Pagination pagination);

	public List<OrderDTO> selectOrderList2(Map<String, Object> searchMap);

	public int selectOrderListTotalCount(String storeName);

	public int selectCouponListTotalCount(int memCode);

	public List<CouponDTO> selectCoupon(MemberDTO member);

	public int selectReviewListTotalCount(String storeName);
	
	public int registDc(List<DCProduct> maps);

	public int modifyOwnerStatus(Map<String, Object> map);

	public MembershipDTO selectMembership(int memCode);

	public OrderDTO selectOrder(int orderCode);

	public int acceptModifyOrder(Map<Object, Object> orderMap);

	public int cancleModifyOrder(Map<Object, Object> orderMap);

	public int completeModifyOrder(Map<Object, Object> orderMap);

	public int selectTotalCountOrder(Map<String, Object> searchMap);
	
	public int modifyProduct(DCProduct dc);

	public int removeDc(List<Integer> codeList);

	public int modifyDc(List<Integer> codeList);

	public ProductDTO selectPd(int sdCode);

	public List<Integer> seletTagList(int sdCode);

	public int updateProduct(Map<String, Object> productInfo);

	public int insertTag(Map<String, Integer> map);

	public int removeTag(int sdCode);

	public MembershipAndStoreDTO selectMembershipAndStore(int msCode);

	public int registMembership(Map<String, Object> info);

	public Map<String, Object> selectMembershipInfo(int memCode);

	public int modifyExtendYn(Map<String, Object> info);

	public Map<String, Object> selectMembershipHis(int memCode);

	public List<Map<String, Object>> selectMembershipInfoList(Map<String, Object> map);

	public int selectTotalReceipt(int memCode);

	public Map<String, Object> selectPayInfo(Map<String, Object> map);

	public int modifyEDateStatus(int sdCode);

	public List<ProductDTO> selectProdoucts(int memCode);
	
	public int registCpToReview(Map<String, Object> result);

	public int selectgiveListTotalCount(int memCode);

	public List<CpHistoryDTO> selectgiveList(Pagination pagination);

	public int removeDcs(int sdCode);

	public int updateDeleteYN(int memCode);

	public String selectEncPwd(int memCode);
	
	public Map<String, Integer> selectTotalPrice(String storeName);

	public Map<String, Integer> selectDelPrice(String storeName);

	public Integer selectPickupPrice(String storeName);

	public List<Map<String, Object>> selectDailySales(Map<String, Object> map);

	public int selectTotalDailySalse(Map<String, Object> map);

	public int selectTotalsalseMonth(Map<String, Object> map);

	public List<Map<String, Object>> selectSalseMonth(Map<String, Object> map);

	public List<Map<String, Object>> selectMonth(String storeName);

	public int removeProductCode(List<Integer> deleteCode);

}
