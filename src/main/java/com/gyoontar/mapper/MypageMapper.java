package com.gyoontar.mapper;

import java.util.List;

import com.gyoontar.domain.CartVO;
import com.gyoontar.domain.OrderVO;
import com.gyoontar.domain.QnaVO;
import com.gyoontar.domain.StatisticsVO;
import com.gyoontar.utility.Criteria;

public interface MypageMapper {

	public List<OrderVO> selectOrder(String userid);
	public OrderVO selectOneOrder(int oseq);
	public List<OrderVO> selectDetail(int oseq);
	public int selectOrderSeq();
	public int insertOrder(OrderVO oVO);

	public int insertDetail(OrderVO oVO);
	
	public List<CartVO> selectCart(String userid);
	public int insertCart(CartVO cVO);
	public int updateCartResult(int cseq);
	public int deleteCart(int cseq);
	
	public List<QnaVO> selectQna(String userid);
	public int insertQna(QnaVO qVO);

	
	// Admin
	public List<OrderVO> selectAllOrder(Criteria cri);
	public int selectOrderCount(Criteria cri);
	public int updateOdresult(int odseq);
	
	public List<QnaVO> selectAllQna(Criteria cri);
	public QnaVO selectOneQna(int qseq);
	public int selectQnaCount(Criteria cri);
	public int updateQna(QnaVO qVO);
	public int updateQresult(QnaVO qVO);
	public int qnaDelete(int qseq);
	
	public StatisticsVO allMonthly(StatisticsVO statVO);
	public StatisticsVO pseqMonthly(StatisticsVO statVO);
	
	
}
