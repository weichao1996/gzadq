package cn.tianhai.gzadq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import cn.tianhai.gzadq.mapper.BridgeDetailMapper;
import cn.tianhai.gzadq.pojo.BridgeDetail;
import cn.tianhai.gzadq.service.BridgeDetailService;

@Service
@CacheConfig(cacheNames="bridgeDetail")
public class BridgeDetailServiceImpl implements BridgeDetailService {
	@Autowired BridgeDetailMapper bridgeDetailMapper;
	
	@Override
	@Cacheable(key="'allBridgeDetail'")
	public List<BridgeDetail> getAllBridgeDetail() {
		// TODO Auto-generated method stub
		return bridgeDetailMapper.getAllBridgeDetail();
	}

	@Cacheable(key="'nineBridgeDetail'")
	public List<BridgeDetail> getNineBridgeDetail() {
		// TODO Auto-generated method stub
		return bridgeDetailMapper.getNineBridgeDetail();
	}

	@Override
	@Cacheable(key="'bridgeDetail '+#p0")
	public BridgeDetail getBridgeDetailById(String obtid) {
		// TODO Auto-generated method stub
		return bridgeDetailMapper.getBridgeDetailById(obtid);
	}

	@Override
	public List<BridgeDetail> getActualBridgeDetail() {
		return  bridgeDetailMapper.getActualBridgeDetail();
	}

	@Override
	public List<BridgeDetail> getSevenBridgeDetail() {
		return bridgeDetailMapper.getSevenBridgeDetail();
	}
}
