package com.gyoontar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gyoontar.domain.BoardVO;
import com.gyoontar.mapper.BoardMapper;
import com.gyoontar.utility.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service // 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시하기 위해 사용함.
@Log4j
@AllArgsConstructor // 생성자를 만들고 자동으로 주입함. (생성자를 만들지 않을 경우에는 @setter()를 이용해서 처리함)
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> selectNotice(Criteria cri){
		return mapper.selectNotice(cri);
	}
	@Override
	public List<BoardVO> selectByUserid(String userid){ // for myBoard.jsp
		return mapper.selectByUserid(userid);
	}
	@Override
	public List<BoardVO> select(Criteria cri) {
		return mapper.select(cri);
	}
		@Override
		public int selectCount(Criteria cri) {
			return mapper.selectCount(cri);
		}
	
	@Override
	public BoardVO view(int bno) {
		return mapper.view(bno);
	}
		@Override
		public void plusHits(int bno) {
			mapper.plusHits(bno);
		}
		@Override
		public int maxBno() {
			return mapper.maxBno();
		}
		@Override
		public int minBno() {
			return mapper.minBno();
		}
		@Override
		public BoardVO nextBvo(int bno) {
			return mapper.nextBvo(bno);
		}
		@Override
		public BoardVO prevBvo(int bno) {
			return mapper.prevBvo(bno);
		}
	@Override
	public int insert(BoardVO boardVO) {
		return mapper.insert(boardVO);
	}
		
	@Override
	public int update(BoardVO boardVO) {
		return mapper.update(boardVO);
	}
	
	@Override
	public int delete(int bno) {
		return mapper.delete(bno);
	}
	
	// GT_BOARD_REPLY
	@Override
	public List<BoardVO> selectReply(int bno){
		return mapper.selectReply(bno);
	}
	@Override
	public List<BoardVO> selectReplyByUserid(String userid){
		return mapper.selectReplyByUserid(userid);
	}
	@Override
	public BoardVO selectOneReply(int repno) {
		return mapper.selectOneReply(repno);
	}
	@Override
	public int insertReply(BoardVO boardVO) {
		return mapper.insertReply(boardVO);
	}
	@Override
	public int updateReply(BoardVO boardVO) {
		return mapper.updateReply(boardVO);
	}
	@Override
	public int deleteReply(BoardVO boardVO) {
		return mapper.deleteReply(boardVO);
	}
	
	// GT_BOARD_LIKE
	@Override
	public int selectLikeCount(int bno) {
		return mapper.selectLikeCount(bno);
	}
	@Override
	public List<BoardVO> selectLike(int bno){
		return mapper.selectLike(bno);
	}
	@Override
	public List<BoardVO> selectLikeByUserid(String userid){
		return mapper.selectLikeByUserid(userid);
	}
	@Override
	public int addLike(BoardVO bVO) {
		return mapper.addLike(bVO);
	}
	@Override
	public int deleteLike(BoardVO bVO) {
		return mapper.deleteLike(bVO);
	}
	@Override
	public int deleteAllLike(String userid) {
		return mapper.deleteAllLike(userid);
	}

	
}
