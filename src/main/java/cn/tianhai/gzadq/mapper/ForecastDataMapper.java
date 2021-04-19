package cn.tianhai.gzadq.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.tianhai.gzadq.pojo.ForecastData;

@Repository
public interface ForecastDataMapper {
	public List<ForecastData> getForecastTime();
	public List<ForecastData> getForecastData(String forecasttime);
	public List<ForecastData> getForeWindList(String forecasttime);
	public List<ForecastData> getPoint5k();
	public ForecastData getForecastDataById(ForecastData forecastData);
	public List<ForecastData> getForecastDataDiv(ForecastData forecastData);
	
	
}
