package com.tfarm.member.model.service;

import java.util.List;

import com.tfarm.member.model.MemberDetailDto;
import com.tfarm.member.model.MemberDto;
import com.tfarm.member.model.ZipDto;

public interface MemberService {
	
	int idCheck(String id);
	int pwCheck(String id, String pass);
	List<ZipDto> zipSearch(String dong);
	int registerMember(MemberDetailDto memberDetailDto);
	void deleteMember(String id);
	String bringPw(String number);
	MemberDetailDto login(String id, String pass);
	MemberDetailDto socialLogin(String id);
	int modifyMember(MemberDetailDto memberDetailDto);
	int socialRegister(String id, String name, String email1, String email2);
	
	List<MemberDetailDto> listMember(String key, String word);

}
