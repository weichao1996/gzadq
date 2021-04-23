package cn.tianhai.gzadq.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.tianhai.gzadq.pojo.BridgeDetail;

@Repository
public interface BridgeDetailMapper {
	public List<BridgeDetail> getAllBridgeDetail();
	public List<BridgeDetail> getNineBridgeDetail();
	public BridgeDetail getBridgeDetailById(String obtid);

    List<BridgeDetail> getActualBridgeDetail();

	List<BridgeDetail> getSevenBridgeDetail();
}
