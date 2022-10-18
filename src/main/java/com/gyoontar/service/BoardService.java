package com.gyoontar.service;

import java.util.List;

import com.gyoontar.domain.BoardVO;
import com.gyoontar.utility.Criteria;

public interface BoardService {

	public List<BoardVO> selectNotice(Criteria cri);
	public List<BoardVO> selectByUserid(String userid); // for myBoard.jsp
	public List<BoardVO> select(Criteria cri);
		public int selectCount(Criteria cri);
	
	public BoardVO view(int bno);
		public void plusHits(int bno);
		public int maxBno();
		public int minBno();
		public BoardVO nextBvo(int bno);
		public BoardVO prevBvo(int bno);
	
	public int insert(BoardVO boardVO);
		
	public int update(BoardVO boardVO);	
	
	public int delete(int bno);
	
	// GT_BOARD_REPLY
	public List<BoardVO> selectReply(int bno);
	public List<BoardVO> selectReplyByUserid(String userid);
	public BoardVO selectOneReply(int repno);
	
	public int insertReply(BoardVO boardVO);
	public int updateReply(BoardVO boardVO);
	public int deleteReply(BoardVO boardVO);
	
	// GT_BOARD_LIKE
	public int selectLikeCount(int bno);
	public List<BoardVO> selectLike(int bno);
	public List<BoardVO> selectLikeByUserid(String userid);

	public int addLike(BoardVO bVO);
	public int deleteLike(BoardVO bVO);
	public int deleteAllLike(String userid);

}
