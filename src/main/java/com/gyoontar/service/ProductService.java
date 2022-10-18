package com.gyoontar.service;

import java.util.List;

import com.gyoontar.domain.ProductVO;
import com.gyoontar.utility.Criteria;

public interface ProductService {

	public List<ProductVO> selectAll(Criteria cri);
	public List<ProductVO> selectKind(Criteria cri);
	public List<ProductVO> selectBest();
	public List<ProductVO> selectSale(Criteria cri);
	
	public ProductVO view(int pseq);
		public List<ProductVO> selectReview(int pseq);
		public List<ProductVO> selectComment(int pseq);
		public int selectNoRepComCount(int pseq);
		public List<ProductVO> selectRevByUserid(String userid);
		public List<ProductVO> selectComByUserid(String userid);
		public ProductVO selectOneReview(int revno);
		public ProductVO selectOneComment(int comno);
		public int updateReview(ProductVO pVO);
		public int updateComment(ProductVO pVO);
		public int updateComReply(ProductVO pVO);
		public int insertReview(ProductVO pVO);
		public int insertComment(ProductVO pVO);
		public int deleteReview(ProductVO pVO);
		public int deleteComment(ProductVO pVO);
		
	public int insert(ProductVO pVO);	
		
	public int update(ProductVO pVO);	
		
	public int delete(int pseq);
	
	public int selectCount(Criteria cri);
	public int selectSaleCount(Criteria cri);
	public int selectKindCount(Criteria cri);
	
	public List<ProductVO> selectWish(int pseq);
	public List<ProductVO> selectWishByUserid(String userid);
	public int selectWishCount(int pseq);
	public int insertWish(ProductVO pVO);
	public int deleteWish(ProductVO pVO);
	public int deleteAllWish(String userid);
}
