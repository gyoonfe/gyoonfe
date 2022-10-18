package com.gyoontar.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userid;
	private String pass;
	private String mname;
	private String nickname;
	private int sex;
	private String email;
	private String phone;
	private int zipcode;
	private String address1;
	private String address2;
	private String mprofile;
	private Date regdate;
	private int status;
	private int admin;
	
	private List<AuthVO> authList;
	private String auth; // 등록 용
	
}
