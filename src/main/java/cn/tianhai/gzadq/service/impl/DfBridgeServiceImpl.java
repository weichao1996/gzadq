package cn.tianhai.gzadq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tianhai.gzadq.mapper.DfBridgeMapper;
import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.service.DfBridgeService;

@Service
public class DfBridgeServiceImpl implements DfBridgeService {
	@Autowired DfBridgeMapper dfBridgeMapper; 
	@Override
	public List<ActualData> getMinActualData(String obtid) {
		// TODO Auto-generated method stub
		return dfBridgeMapper.getMinActualData(obtid);
	}

	@Override
	public List<ActualData> getHourActualData(String obtid) {
		// TODO Auto-generated method stub
		return dfBridgeMapper.getHourActualData(obtid);
	}

	@Override
	public List<ActualData> getWindList() {
		// TODO Auto-generated method stub
		return dfBridgeMapper.getWindList();
	}

	@Override
	public ActualData getActualDataById(String obtid) {
		// TODO Auto-generated method stub
		return dfBridgeMapper.getActualDataById(obtid);
	}

}
