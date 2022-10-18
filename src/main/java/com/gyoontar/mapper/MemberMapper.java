package com.gyoontar.mapper;

import java.util.List;


import com.gyoontar.domain.MemberVO;
import com.gyoontar.utility.Criteria;

public interface MemberMapper {

	public MemberVO read(String userName);
	
	public List<MemberVO> selectAll(Criteria cri);
	
	public List<MemberVO> selectAdmin();
	
	public int insert(MemberVO mVO);
	public int updateMember(MemberVO mVO);
	public int changePW(MemberVO mVO);
	
	public int toDormant(String userid);
	public int notDormant(String userid);
	
	
	public int checkUserid(String userid);
	public int checkNickname(String nickname);
	public int checkUpdateNickname(MemberVO mVO);
	public int adminDelete(String userid);
	public int updateAdmin(MemberVO mVO);
	
	public int insertAdmin(MemberVO mVO);
	public int insertAuth(MemberVO mVO);
	
	public int selectCount(Criteria cri);
	public int selectCountAdmin();
}
