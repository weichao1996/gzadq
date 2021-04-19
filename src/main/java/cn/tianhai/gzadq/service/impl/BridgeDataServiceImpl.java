package cn.tianhai.gzadq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import cn.tianhai.gzadq.mapper.BridgeDataMapper;
import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.service.BridgeDataService;

@Service
public class BridgeDataServiceImpl implements BridgeDataService {
	@Autowired BridgeDataMapper bridgeDataMapper;
	
	@Override
	public List<ActualData> getMinActualData(String obtid) {
		
		return bridgeDataMapper.getMinActualData(obtid);
	}

	@Override
	public List<ActualData> getHourActualData(String obtid) {
		// TODO Auto-generated method stub
		return bridgeDataMapper.getHourActualData(obtid);
	}

	@Override
	public List<ActualData> getWindList() {
		// TODO Auto-generated method stub
		return bridgeDataMapper.getWindList();
	}

	@Override
	public ActualData getActualDataById(String obtid) {
		// TODO Auto-generated method stub
		return bridgeDataMapper.getActualDataById(obtid);
	}

}
