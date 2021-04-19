package cn.tianhai.gzadq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import cn.tianhai.gzadq.mapper.ForecastDataMapper;
import cn.tianhai.gzadq.pojo.ForecastData;
import cn.tianhai.gzadq.service.ForecastDataService;

@Service
@CacheConfig(cacheNames="forecastData")
public class ForecastDataServiceImpl implements ForecastDataService {
	@Autowired ForecastDataMapper forecastDataMapper;
	@Override
	public List<ForecastData> getForecastTime() {
		// TODO Auto-generated method stub
		return forecastDataMapper.getForecastTime();
	}

	@Override
	public List<ForecastData> getForecastData(String forecasttime) {
		// TODO Auto-generated method stub
		return forecastDataMapper.getForecastData(forecasttime);
	}

	@Override
	public List<ForecastData> getForeWindList(String forecasttime) {
		// TODO Auto-generated method stub
		return forecastDataMapper.getForeWindList(forecasttime);
	}

	@Override
	@Cacheable(key="'allPoint5k'")
	public List<ForecastData> getPoint5k() {
		// TODO Auto-generated method stub
		return forecastDataMapper.getPoint5k();
	}

	@Override
	public ForecastData getForecastDataById(ForecastData forecastData) {
		// TODO Auto-generated method stub
		return forecastDataMapper.getForecastDataById(forecastData);
	}

	@Override
	public List<ForecastData> getForecastDataDiv(ForecastData forecastData) {
		// TODO Auto-generated method stub
		return forecastDataMapper.getForecastDataDiv(forecastData);
	}

}
