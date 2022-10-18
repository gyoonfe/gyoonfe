package com.gyoontar.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	
	// gt_order
	private int oseq;
	private String userid;
	private Date oregdate;
	private int ozipcode;
	private String oaddress1;
	private String oaddress2;
	
	// gt_order_detail
	private int odseq;
	private int pseq;
	private int odquantity;
	private int odresult;
	
	// gt_product
	private String pname;
	private int price2;
	
	// gt_member
	private String mname;
	private String phone;

}
