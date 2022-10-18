package com.gyoontar.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {
	
	// gt_cart
	private int cseq;
	private String userid;
	private int pseq;
	private int cquantity;
	private int cresult;
	private Date cregdate;
	
	// gt_product
	private String pname;
	private int price2;
	
}
