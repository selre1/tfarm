package com.tfarm.member.model.dao;

import java.util.List;
import java.util.Map;

import com.tfarm.member.model.MemberDetailDto;
import com.tfarm.member.model.MemberDto;
import com.tfarm.member.model.ZipDto;

public interface MemberDao {
	
	int idCheck(String id);
	List<ZipDto> zipSearch(String dong);
	int registerMember(MemberDetailDto memberDetailDto);
	void deleteMember(String id);
	MemberDto login(Map<String, String> map);	
	List<MemberDetailDto> listMember(Map<String, String> map);
}
