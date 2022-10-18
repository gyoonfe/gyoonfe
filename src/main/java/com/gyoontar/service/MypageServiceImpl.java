package com.gyoontar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gyoontar.domain.CartVO;
import com.gyoontar.domain.OrderVO;
import com.gyoontar.domain.ProductVO;
import com.gyoontar.domain.QnaVO;
import com.gyoontar.domain.StatisticsVO;
import com.gyoontar.mapper.MypageMapper;
import com.gyoontar.mapper.ProductMapper;
import com.gyoontar.utility.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service // 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시하기 위해 사용함.
@Log4j
@AllArgsConstructor // 생성자를 만들고 자동으로 주입함. (생성자를 만들지 않을 경우에는 @setter()를 이용해서 처리함)
public class MypageServiceImpl implements MypageService {

	private MypageMapper mapper;
	
	@Override
	public List<OrderVO> selectOrder(String userid) {
		return mapper.selectOrder(userid);
	}
	@Override
	public OrderVO selectOneOrder(int oseq) {
		return mapper.selectOneOrder(oseq);
	}
	@Override
	public List<OrderVO> selectDetail(int oseq) {
		return mapper.selectDetail(oseq);
	}
	@Override
	public int selectOrderSeq() {
		return mapper.selectOrderSeq();
	}
	@Override
	public int insertOrder(OrderVO oVO) {
		return mapper.insertOrder(oVO);
	}
	@Override
	public int insertDetail(OrderVO oVO) {
		return mapper.insertDetail(oVO);
	}
	
	@Override
	public List<CartVO> selectCart(String userid) {
		return mapper.selectCart(userid);
	}
	@Override
	public int insertCart(CartVO cVO) {
		return mapper.insertCart(cVO);
	}
	@Override
	public int updateCartResult(int cseq) {
		return mapper.updateCartResult(cseq);
	}
	@Override
	public int deleteCart(int cseq) {
		return mapper.deleteCart(cseq);
	}
	
	@Override
	public List<QnaVO> selectQna(String userid){
		return mapper.selectQna(userid);
	}
	@Override
	public int insertQna(QnaVO qVO) {
		return mapper.insertQna(qVO);
	}

	
	// Admin
	@Override
	public List<OrderVO> selectAllOrder(Criteria cri){
		return mapper.selectAllOrder(cri);
	}
	@Override
	public int selectOrderCount(Criteria cri) {
		return mapper.selectOrderCount(cri);
	}
	@Override
	public int updateOdresult(int odseq) {
		return mapper.updateOdresult(odseq);
	}
	
	@Override
	public List<QnaVO> selectAllQna(Criteria cri){
		return mapper.selectAllQna(cri);
	}
	@Override
	public QnaVO selectOneQna(int qseq) {
		return mapper.selectOneQna(qseq);
	}
	@Override
	public int selectQnaCount(Criteria cri) {
		return mapper.selectQnaCount(cri);
	}
	@Override
	public int updateQna(QnaVO qVO) {
		return mapper.updateQna(qVO);
	}
	@Override
	public int updateQresult(QnaVO qVO) {
		return mapper.updateQresult(qVO);
	}
	@Override
	public int qnaDelete(int qseq) {
		return mapper.qnaDelete(qseq);
	}
	
	@Override
	public StatisticsVO allMonthly(StatisticsVO statVO) {
		return mapper.allMonthly(statVO);
	}
	@Override
	public StatisticsVO pseqMonthly(StatisticsVO statVO) {
		return mapper.pseqMonthly(statVO);
	}
	
	
}
