package com.gyoontar.service;

import java.util.List;

import com.gyoontar.domain.MapVO;

public interface MapService {

	public List<MapVO> selectAllMap();
	
	public int insertMap(MapVO mapVO);
	
	public int deleteMap(int idx);
}
