package cn.tianhai.gzadq.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.tianhai.gzadq.pojo.ActualData;

@Repository
public interface BridgeDataMapper {
	public List<ActualData> getMinActualData(String obtid);
	public List<ActualData> getHourActualData(String obtid);
	public List<ActualData> getWindList();
	
	public ActualData getActualDataById(String obtid);
	
}
