package cn.tianhai.gzadq.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.tianhai.gzadq.pojo.Threshold;

@Repository
public interface ThresholdMapper {
	public Threshold getThreshold(int userid);
	public void addThreshold(Threshold threshold);
	public void updateThreshold(Threshold threshold);
	public void addLnglat(Threshold threshold);
	public void updateLnglat(Threshold threshold);
}
