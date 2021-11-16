package cn.tianhai.gzadq.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.pojo.BridgeDetail;
import cn.tianhai.gzadq.pojo.Car;
import cn.tianhai.gzadq.pojo.ForecastData;
import cn.tianhai.gzadq.pojo.HeartMap;
import cn.tianhai.gzadq.pojo.Threshold;
import cn.tianhai.gzadq.service.BridgeDetailService;
import cn.tianhai.gzadq.service.ForecastDataService;
import cn.tianhai.gzadq.util.ContentComparator;
import cn.tianhai.gzadq.util.Distance;
import cn.tianhai.gzadq.util.TimeCompare;

@CrossOrigin(origins = "*",maxAge = 3600)
@Controller
public class ForecastController {
	static Logger logger = Logger.getLogger(ForecastController.class);
	@Autowired ForecastDataService forecastDataServiceImpl;
	@Autowired BridgeDetailService bridgeDetailServiceImpl;
	@Value("${timeCompare}") 
	private Integer timeCompare;
	@Value("${thresholdTime}") 
	private Integer thresholdTime;
	
	@GetMapping("/forecastData")
    public Object forecastData(Model m) {
		m.addAttribute("thresholdTime", thresholdTime);
        return "forecastData";
        
    }
	
	@GetMapping("/forecastDataPoint")
    public Object forecastDataPoint(Model m) {
		m.addAttribute("thresholdTime", thresholdTime);
        return "forecastDataPoint";
        
    }
	
	
	@GetMapping("/getForecastTime")
	@ResponseBody
    public Object getForecastTime() {
		List<ForecastData> list=forecastDataServiceImpl.getForecastTime();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String now=simpleDateFormat .format(new Date());
        List<ForecastData> list2=new ArrayList();
        for(ForecastData forecastData:list) {
        	if(TimeCompare.timeCompare(now, forecastData.getForecasttime())==timeCompare) {//-1
        		list2.add(forecastData);
        	}
        }

        return list2;
    }
	
	@GetMapping("/getForecastData/{forecasttime}/{type}")
	@ResponseBody
    public Object getForecastData(@PathVariable String forecasttime,@PathVariable String type) {
		if(forecasttime.equals("-请选择时间-")||type.equals("-请选择要素-")) {return null;}
		List<ForecastData> list=forecastDataServiceImpl.getForecastData(forecasttime);
		List<HeartMap> heartMapList=new ArrayList();
		if(type.equals("rain")) {
			for(ForecastData forecastData:list) {
				HeartMap heartmap=new HeartMap();
				heartmap.setLng(forecastData.getX());
				heartmap.setLat(forecastData.getY());
				heartmap.setCount(forecastData.getRain());
				heartMapList.add(heartmap);
			}
		}else if(type.equals("wspd10m")){
			for(ForecastData forecastData:list) {
				HeartMap heartmap=new HeartMap();
				heartmap.setLng(forecastData.getX());
				heartmap.setLat(forecastData.getY());
				heartmap.setCount(forecastData.getWind());
				heartMapList.add(heartmap);
			}
		}else 
			if(type.equals("visi")){
			for(ForecastData forecastData:list) {
				HeartMap heartmap=new HeartMap();
				heartmap.setLng(forecastData.getX());
				heartmap.setLat(forecastData.getY());
				heartmap.setCount(forecastData.getVis());
				heartMapList.add(heartmap);
			}
		}
			
		
        return heartMapList;
    }
	
	@GetMapping("/getForeWindList")
	@ResponseBody
    public Object getForeWindList() {
//		List<ForecastData> list=forecastDataServiceImpl.getForecastTime();
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String now=simpleDateFormat .format(new Date());
//        String forecasttime="";
//        for(ForecastData forecastData:list) {
//        	if(TimeCompare.timeCompare(now, forecastData.getForecasttime())==-1) {
//        		forecasttime=forecastData.getForecasttime();
//        		break;
//        	}
//        }
		Calendar ca = Calendar.getInstance();
		ca.add(Calendar.HOUR,1);
		ca.set(Calendar.MINUTE,0);
		ca.set(Calendar.SECOND,0);
		ca.set(Calendar.MILLISECOND,0);
		System.out.println(ca.getTime());
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str1 = simpleDateFormat.format(ca.getTime());
		System.out.println(str1);
		List<ForecastData> forecastDataList=forecastDataServiceImpl.getForeWindList("2021-03-26 12:00:00");//str1
		
		System.out.println("大桥预报风速list大小:"+forecastDataList.size());
		for(ForecastData fd:forecastDataList){
			System.out.println(fd.getVenueid());
		}
		
		ForecastData f260=forecastDataList.get(4);
		ForecastData f269=forecastDataList.get(6);
		forecastDataList.remove(4);
		forecastDataList.add(f269);
		forecastDataList.add(f269);
		forecastDataList.add(f260);
		
		
		
        return forecastDataList;
        
    }
	
	@GetMapping("/getObtid")
	@ResponseBody
    public Object getObtid() {
		
		List<BridgeDetail> list=bridgeDetailServiceImpl.getSevenBridgeDetail();
		
        return list;
        
    }
	
	@GetMapping("/getForecastDataDiv")
	@ResponseBody
    public Object getForecastDataDiv() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now=simpleDateFormat .format(new Date());
		List<ForecastData> point5klist=forecastDataServiceImpl.getPoint5k();
		Distance distance=new Distance();
		List list3=new ArrayList();
		
		List<BridgeDetail> list=bridgeDetailServiceImpl.getSevenBridgeDetail();
		for(BridgeDetail b:list) {
			double disk=145000;
			ForecastData forecastData = null;
			for(ForecastData f:point5klist) {
				if(distance.getDistance(b.getLon(), b.getLat(), f.getX(), f.getY())<disk) {
					disk = distance.getDistance(b.getLon(), b.getLat(), f.getX(), f.getY());
					forecastData=f;
					System.out.println(disk);
				}
				
			}
//			forecastData.setForecasttime("2021-03-26 12:00:00");//now
			
			
			List<ForecastData> forecastDataList=forecastDataServiceImpl.getForecastDataDiv(forecastData);
			
			List<ForecastData> list2=new ArrayList();
	        for(int i=0;i<forecastDataList.size();i++) {
	        	forecastDataList.get(i).setX(b.getLon());
	        	forecastDataList.get(i).setY(b.getLat());
	        	if(TimeCompare.timeCompare("2021-03-26 12:00:00", forecastDataList.get(i).getForecasttime())==-1) {//now
	        		if(list2.size()<24) {
	        			list2.add(forecastDataList.get(i));
	        		}
	        	}
	        	if(i>23&&i<72) {
	        		if(i%3==0) {
	        			list2.add(forecastDataList.get(i));
	        		}
	        	}
	        	if(i>71&&i<84) {
	        		list2.add(forecastDataList.get(i));
	        	}
	        }
	        list3.add(list2);
		}
		
		
		
		return list3;
		
    }
	
	@GetMapping("/getForecastDataDiv/{obtid}")
	@ResponseBody
    public Object getForecastDataDiv(@PathVariable String obtid) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now=simpleDateFormat .format(new Date());
		
		BridgeDetail b=bridgeDetailServiceImpl.getBridgeDetailById(obtid);
		List<ForecastData> point5klist=forecastDataServiceImpl.getPoint5k();
		Distance distance=new Distance();
		double disk=145000;
		ForecastData forecastData = null;
		for(ForecastData f:point5klist) {
			if(distance.getDistance(b.getLon(), b.getLat(), f.getX(), f.getY())<disk) {
				disk = distance.getDistance(b.getLon(), b.getLat(), f.getX(), f.getY());
				forecastData=f;
				System.out.println(disk);
			}
			
		}
//		forecastData.setForecasttime("2021-03-26 12:00:00");//now
		
		
		List<ForecastData> forecastDataList=forecastDataServiceImpl.getForecastDataDiv(forecastData);
		
		List<ForecastData> list2=new ArrayList();
        for(int i=0;i<forecastDataList.size();i++) {
        	if(TimeCompare.timeCompare("2021-03-26 12:00:00", forecastDataList.get(i).getForecasttime())==-1) {//now
        		if(list2.size()<24) {
        			list2.add(forecastDataList.get(i));
        		}
        	}
        	if(i>23&&i<72) {
        		if(i%3==0) {
        			list2.add(forecastDataList.get(i));
        		}
        	}
        	if(i>71&&i<84) {
        		list2.add(forecastDataList.get(i));
        	}
        }
		return list2;
		
    }
	
}
