package com.gyoontar.domain;

import lombok.Data;

@Data
public class MapVO {

	private int idx;
	private String name;
	private String phone;
	private String email;
	private double lat;
	private double lng;
	private String address1;
	private String address2;
	private String image;
	
}
