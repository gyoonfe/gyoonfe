package com.gyoontar.mapper;

import java.util.List;

import com.gyoontar.domain.MapVO;

public interface MapMapper {

	public List<MapVO> selectAllMap();
	
	public int insertMap(MapVO mapVO);
	
	public int deleteMap(int idx);
	
}
