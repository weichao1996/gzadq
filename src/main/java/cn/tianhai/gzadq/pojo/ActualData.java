package cn.tianhai.gzadq.pojo;

import java.util.Date;

public class ActualData {
/**
 * 实况数据
 */
	private String obtid;
	private String datetime;
	private double wind;
	private double wd;
	private double rain;
	private double vis;
	private double lon;
	private double lat;
	
	public String getObtid() {
		return obtid;
	}
	public void setObtid(String obtid) {
		this.obtid = obtid;
	}
	public double getWind() {
		return wind;
	}
	public void setWind(double wind) {
		this.wind = wind;
	}
	public double getRain() {
		return rain;
	}
	public void setRain(double rain) {
		this.rain = rain;
	}
	public double getVis() {
		return vis;
	}
	public void setVis(double vis) {
		this.vis = vis;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getWd() {
		return wd;
	}
	public void setWd(double wd) {
		this.wd = wd;
	}
	
	
}
