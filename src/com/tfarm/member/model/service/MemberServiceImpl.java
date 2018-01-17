package com.tfarm.member.model.service;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tfarm.member.model.MemberDetailDto;
import com.tfarm.member.model.MemberDto;
import com.tfarm.member.model.ZipDto;
import com.tfarm.member.model.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int idCheck(String id) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		return memberDao.idCheck(id);
	}

	@Override
	public List<ZipDto> zipSearch(String dong) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		return memberDao.zipSearch(dong);
	}
 
	@Override
	public int registerMember(MemberDetailDto memberDetailDto) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		return memberDao.registerMember(memberDetailDto);
	}

	@Override
	public MemberDto login(String id, String pass) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", id);
		map.put("userpwd", pass);
		return memberDao.login(map);
	}

	@Override
	public List<MemberDetailDto> listMember(String key, String word) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("key", key);
		map.put("word", word);
		return memberDao.listMember(map);
	}

	@Override
	public void deleteMember(String id) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		memberDao.deleteMember(id);
	}

}











