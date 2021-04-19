package cn.tianhai.gzadq.service;

import java.util.List;

import cn.tianhai.gzadq.pojo.ForecastData;

public interface ForecastDataService {
	public List<ForecastData> getForecastTime();
	public List<ForecastData> getForecastData(String forecasttime);
	public List<ForecastData> getForeWindList(String forecasttime);
	public List<ForecastData> getPoint5k();
	public ForecastData getForecastDataById(ForecastData forecastData);
	public List<ForecastData> getForecastDataDiv(ForecastData forecastData);
}
