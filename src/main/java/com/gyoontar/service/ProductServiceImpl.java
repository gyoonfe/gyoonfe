package com.gyoontar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gyoontar.domain.ProductVO;
import com.gyoontar.mapper.ProductMapper;
import com.gyoontar.utility.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service // 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시하기 위해 사용함.
@Log4j
@AllArgsConstructor // 생성자를 만들고 자동으로 주입함. (생성자를 만들지 않을 경우에는 @setter()를 이용해서 처리함)
public class ProductServiceImpl implements ProductService {

	private ProductMapper mapper;
	
	@Override
	public List<ProductVO> selectAll(Criteria cri){
		return mapper.selectAll(cri);
	}
	@Override
	public List<ProductVO> selectKind(Criteria cri){
		return mapper.selectKind(cri);
	}
	@Override
	public List<ProductVO> selectBest(){
		return mapper.selectBest();
	}
	@Override
	public List<ProductVO> selectSale(Criteria cri){
		return mapper.selectSale(cri);
	}
		@Override
		public int selectCount(Criteria cri) {
			return mapper.selectCount(cri);
		}
		@Override
		public int selectSaleCount(Criteria cri) {
			return mapper.selectSaleCount(cri);
		}
		@Override
		public int selectKindCount(Criteria cri) {
			return mapper.selectKindCount(cri);
		}
		@Override
		public int deleteReview(ProductVO pVO) {
			return mapper.deleteReview(pVO);
		}
		@Override
		public int deleteComment(ProductVO pVO) {
			return mapper.deleteComment(pVO);
		}
		
	@Override
	public ProductVO view(int pseq) {
		return mapper.view(pseq);
	}
		@Override
		public ProductVO selectOneReview(int revno) {
			return mapper.selectOneReview(revno);
		}
		@Override
		public ProductVO selectOneComment(int comno) {
			return mapper.selectOneComment(comno);
		}
		@Override
		public List<ProductVO> selectRevByUserid(String userid){
			return mapper.selectRevByUserid(userid);
		}
		@Override
		public List<ProductVO> selectComByUserid(String userid){
			return mapper.selectComByUserid(userid);
		}
		@Override
		public int updateReview(ProductVO pVO) {
			return mapper.updateReview(pVO);
		}
		@Override
		public int updateComment(ProductVO pVO) {
			return mapper.updateComment(pVO);
		}
		@Override
		public int updateComReply(ProductVO pVO) {
			return mapper.updateComReply(pVO);
		}
		@Override
		public List<ProductVO> selectReview(int pseq){
			return mapper.selectReview(pseq);
		}
		@Override
		public List<ProductVO> selectComment(int pseq){
			return mapper.selectComment(pseq);
		}
		@Override
		public int selectNoRepComCount(int pseq) {
			return mapper.selectNoRepComCount(pseq);
		}
		@Override
		public int insertReview(ProductVO pVO) {
			return mapper.insertReview(pVO);
		}
		@Override
		public int insertComment(ProductVO pVO) {
			return mapper.insertComment(pVO);
		}
		
	@Override
	public int insert(ProductVO pVO) {
		return mapper.insert(pVO);
	}
		
	@Override	
	public int update(ProductVO pVO) {
		return mapper.update(pVO);
	}
		
	@Override
	public int delete(int pseq) {
		return mapper.delete(pseq);
	}
	
	
	@Override
	public List<ProductVO> selectWish(int pseq){
		return mapper.selectWish(pseq);
	}
	@Override
	public List<ProductVO> selectWishByUserid(String userid){
		return mapper.selectWishByUserid(userid);
	}
	@Override
	public int selectWishCount(int pseq) {
		return mapper.selectWishCount(pseq);
	}
	@Override
	public int insertWish(ProductVO pVO) {
		return mapper.insertWish(pVO);
	}
	@Override
	public int deleteWish(ProductVO pVO) {
		return mapper.deleteWish(pVO);
	}
	@Override
	public int deleteAllWish(String userid) {
		return mapper.deleteAllWish(userid);
	}
		
}
