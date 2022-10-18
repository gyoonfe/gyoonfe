package com.gyoontar.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {

	private int pseq;
	private String pname;
	private String kind;
	private int price1;
	private int price2;
	private int price3;
	private String pcontent;
	private int pquantity;
	private String pimage;
	private Date pregdate;
	private int bestyn;
	private int saleyn;
	
	private String userid;
	private String nickname;
	
	private int revno;
	private String  revcontent;
	private Date revregdate;
	
	private int comno;
	private String comcontent;
	private String comreply;
	private Date comregdate;
	private int noRepComCount;
	
	private int wno;
	
}
