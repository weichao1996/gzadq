package cn.tianhai.gzadq.pojo;

import java.math.BigDecimal;

public class Threshold {
	/**
	 * 阈值
	 */
	private int tid;
	private int userid;
	private String arain="";
	private String frain="";
	private String awind="";
	private String fwind="";
	private String avis="";
	private String fvis="";
	private String radius="";
	private String lnglat;
	private double maxRain;
	private double maxWind;
	private double minVis;
	private String forecasttime;

	public String getForecasttime() {
		return forecasttime;
	}

	public void setForecasttime(String forecasttime) {
		this.forecasttime = forecasttime;
	}

	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	
	public String getArain() {
		return arain;
	}
	public void setArain(String arain) {
		this.arain = arain;
	}
	public String getFrain() {
		return frain;
	}
	public void setFrain(String frain) {
		this.frain = frain;
	}
	public String getAwind() {
		return awind;
	}
	public void setAwind(String awind) {
		this.awind = awind;
	}
	public String getFwind() {
		return fwind;
	}
	public void setFwind(String fwind) {
		this.fwind = fwind;
	}
	public String getAvis() {
		return avis;
	}
	public void setAvis(String avis) {
		this.avis = avis;
	}
	public String getFvis() {
		return fvis;
	}
	public void setFvis(String fvis) {
		this.fvis = fvis;
	}
	public String getRadius() {
		return radius;
	}
	public void setRadius(String radius) {
		this.radius = radius;
	}
	public String getLnglat() {
		return lnglat;
	}
	public void setLnglat(String lnglat) {
		this.lnglat = lnglat;
	}
	public double getMaxRain() {
		return maxRain;
	}
	public void setMaxRain(double maxRain) {
		this.maxRain = maxRain;
	}
	public double getMaxWind() {
		return maxWind;
	}
	public void setMaxWind(double maxWind) {
		this.maxWind = maxWind;
	}
	public double getMinVis() {
		return minVis;
	}
	public void setMinVis(double minVis) {
		this.minVis = minVis;
	}
	
	
}	
