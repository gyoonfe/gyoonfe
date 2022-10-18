package com.gyoontar.utility;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {

	private int startPage;
	private int endPage;
	private int blockPerPage = 5; // 한 Page 당 보여줄 Block 수
	private int realEnd;
	
	private boolean prev, next;
	
	private int total;
	private Criteria cri; // Criteria 객체를 맴버변수로 활용.
	
	
	public PageVO(Criteria cri, int total) { // 생성자.
		this.cri = cri;
		this.total = total;
		this.endPage = (int)(Math.ceil(cri.getPageNum() / (double)(blockPerPage))) * blockPerPage; 
		this.startPage = this.endPage - (blockPerPage - 1); 
		int realEnd = (int)( Math.ceil((total * 1.0) / cri.getAmount()) );
		this.realEnd = realEnd;
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
	
	
}

