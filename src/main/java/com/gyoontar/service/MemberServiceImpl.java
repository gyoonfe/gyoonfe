package com.gyoontar.service;


import java.util.List;


import org.springframework.stereotype.Service;

import com.gyoontar.domain.MemberVO;
import com.gyoontar.mapper.MemberMapper;
import com.gyoontar.utility.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service // 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시하기 위해 사용함.
@Log4j
@AllArgsConstructor // 생성자를 만들고 자동으로 주입함. (생성자를 만들지 않을 경우에는 @setter()를 이용해서 처리함)
public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper;
	
	@Override
	public MemberVO read(String userName) {
		return mapper.read(userName);
	}
	
	@Override
	public List<MemberVO> selectAll(Criteria cri){
		return mapper.selectAll(cri);
	}
		@Override
		public int selectCount(Criteria cri) {
			return mapper.selectCount(cri);
		}
		
	@Override
	public List<MemberVO> selectAdmin(){
		return mapper.selectAdmin();
	}
		@Override
		public int selectCountAdmin() {
			return mapper.selectCountAdmin();
		}
	@Override
	public int toDormant(String userid) {
		return mapper.toDormant(userid);
	}
	@Override
	public int notDormant(String userid) {
		return mapper.notDormant(userid);
	}
		
	@Override
	public int insert(MemberVO mVO) {
		return mapper.insert(mVO);
	}
	@Override
	public int updateMember(MemberVO mVO) {
		return mapper.updateMember(mVO);
	}
	@Override
	public int changePW(MemberVO mVO) {
		return mapper.changePW(mVO);
	}
	
	@Override
	public int checkUserid(String userid) {
		return mapper.checkUserid(userid);
	}
	@Override
	public int checkNickname(String nickname) {
		return mapper.checkNickname(nickname);
	}
	@Override
	public int checkUpdateNickname(MemberVO mVO) {
		return mapper.checkUpdateNickname(mVO);
	}
	@Override
	public int adminDelete(String userid) {
		return mapper.adminDelete(userid);
	}
	@Override
	public int updateAdmin(MemberVO mVO) {
		return mapper.updateAdmin(mVO);
	}
	
	
	@Override
	public int insertAdmin(MemberVO mVO) {
		return mapper.insertAdmin(mVO);
	}
	@Override
	public int insertAuth(MemberVO mVO) {
		return mapper.insertAuth(mVO);
	}

	
	
}
