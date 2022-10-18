package com.gyoontar.domain;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class StatisticsVO {

    // 현재 날짜 구하기 
	static LocalDate now = LocalDate.now();
	static DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy");
	static String nowY = now.format(fmt);
	
	private int pseq;
	private int count;
	private int price;
	private String yyyy;
	private String mm;
	
	public StatisticsVO() { //생성자 
		this(nowY,"01",0);
	}
	
	public StatisticsVO(String yyyy, String mm) { //생성자 
		this.yyyy = yyyy;
		this.mm = mm;
	}
	
	public StatisticsVO(String yyyy, String mm, int pseq) { //생성자 
		this.yyyy = yyyy;
		this.mm = mm;
		this.pseq = pseq;
	}

	
}
