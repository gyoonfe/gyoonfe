package com.gyoontar.utility;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	private String category;
	
	public Criteria() { //생성자 
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) { //생성자 
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
}
