package cn.tianhai.gzadq.service;

import java.util.List;

import cn.tianhai.gzadq.pojo.BridgeDetail;

public interface BridgeDetailService {
	public List<BridgeDetail> getAllBridgeDetail();
	public List<BridgeDetail> getNineBridgeDetail();
	public BridgeDetail getBridgeDetailById(String obtid);

    List<BridgeDetail> getActualBridgeDetail();

    List<BridgeDetail> getSevenBridgeDetail();
}
