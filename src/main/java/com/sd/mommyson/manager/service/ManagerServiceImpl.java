package com.sd.mommyson.manager.service;

import org.springframework.stereotype.Service;

import com.sd.mommyson.manager.dao.ManagerDAO;
import com.sd.mommyson.member.dao.MemberDAO;
import com.sd.mommyson.member.dto.MemberDTO;

@Service
public class ManagerServiceImpl implements ManagerService {

	private ManagerDAO managerDAO;
	
	public ManagerServiceImpl(ManagerDAO managerDAO) {
		this.managerDAO = managerDAO;
	}
	
	@Override
	public MemberDTO normalMemberSelect(MemberDTO member) {
		
		MemberDTO normalMemberList = null;
		
		normalMemberList = managerDAO.normalMemberSelect(member);
		
		return null;
	}

	
}
