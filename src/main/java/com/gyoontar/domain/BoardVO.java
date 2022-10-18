package com.gyoontar.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private String userid;
	private String nickname; 
	
	private int bno;
	private String title;
	private String content;
	private String hits;
//	private String bimage;
	private Date regdate;
	private int noticeyn;
	
	private int repno; // Reply No
	private String repcontent; // Reply Content
	private Date repregdate; // Reply Regdate
	
	private int blno; // Board_Like No
}
