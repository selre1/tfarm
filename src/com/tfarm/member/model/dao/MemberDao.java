package com.tfarm.member.model.dao;

import java.util.List;
import java.util.Map;

import com.tfarm.member.model.MemberDetailDto;
import com.tfarm.member.model.MemberDto;
import com.tfarm.member.model.ZipDto;

public interface MemberDao {
	
	int idCheck(String id);
	int pwCheck(Map<String,String> map);
	String bringPw(String number);
	int modifyMember(MemberDetailDto memberDetailDto);
	List<ZipDto> zipSearch(String dong);
	int registerMember(MemberDetailDto memberDetailDto);
	int socialRegister(Map<String, String> map);
	void deleteMember(String id);
	MemberDetailDto login(Map<String, String> map);
	MemberDetailDto socialLogin(String id);
	List<MemberDetailDto> listMember(Map<String, String> map);
	
}
