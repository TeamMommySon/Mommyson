package com.sd.mommyson.usermypage.dto;

import java.sql.Date;
import com.sd.mommyson.member.dto.StoreDTO;

public class CouponDTO {
	
	private int cpCode;
	private String cpName;
	private Date startDate;
	private int disWon;
	private Date endDate;
	private int dCcon;
	private StoreDTO store;
	/* private CouponHistoryDTO cpHistory; */
	
	public CouponDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CouponDTO(int cpCode, String cpName, Date startDate, int disWon, Date endDate, int dCcon, StoreDTO store,
			CouponHistoryDTO cpHistory) {
		super();
		this.cpCode = cpCode;
		this.cpName = cpName;
		this.startDate = startDate;
		this.disWon = disWon;
		this.endDate = endDate;
		this.dCcon = dCcon;
		this.store = store;
//		this.cpHistory = cpHistory;
	}





	public StoreDTO getStore() {
		return store;
	}

	public void setStore(StoreDTO store) {
		this.store = store;
	}

	/*
	 * public CouponHistoryDTO getCpHistory() { return cpHistory; }
	 * 
	 * public void setCpHistory(CouponHistoryDTO cpHistory) { this.cpHistory =
	 * cpHistory; }
	 */

	public int getCpCode() {
		return cpCode;
	}

	public void setCpCode(int cpCode) {
		this.cpCode = cpCode;
	}

	public String getCpName() {
		return cpName;
	}

	public void setCpName(String cpName) {
		this.cpName = cpName;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public int getDisWon() {
		return disWon;
	}

	public void setDisWon(int disWon) {
		this.disWon = disWon;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getdCcon() {
		return dCcon;
	}

	public void setdCcon(int dCcon) {
		this.dCcon = dCcon;
	}

	@Override
	public String toString() {
		return "CouponDTO [cpCode=" + cpCode + ", cpName=" + cpName + ", startDate=" + startDate + ", disWon=" + disWon
				+ ", endDate=" + endDate + ", dCcon=" + dCcon + ", store=" + store + "]";
	}

	/*
	 * @Override public String toString() { return "CouponDTO [cpCode=" + cpCode +
	 * ", cpName=" + cpName + ", startDate=" + startDate + ", disWon=" + disWon +
	 * ", endDate=" + endDate + ", dCcon=" + dCcon + ", store=" + store +
	 * ", cpHistory=" + cpHistory + "]"; }
	 */


	
	
}
