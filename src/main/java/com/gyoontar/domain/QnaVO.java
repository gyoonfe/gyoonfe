package com.gyoontar.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QnaVO {

	private int qseq;
	private String userid;
	private String qtitle;
	private String qcontent;
	private String qreply;
	private int qresult;
	private Date qregdate;
	
	// gt_member
	private String mname;
	
	public QnaVO () {

	}	
	
	public QnaVO (int qseq, int qresult) {
		this.qseq = qseq;
		this.qresult = qresult;
	}
	
}
