package cn.tianhai.gzadq.service;

import java.util.List;

import cn.tianhai.gzadq.pojo.ActualData;

public interface DfBridgeService {
	public List<ActualData> getMinActualData(String obtid);
	public List<ActualData> getHourActualData(String obtid);
	public List<ActualData> getWindList();
	
	public ActualData getActualDataById(String obtid);
}
