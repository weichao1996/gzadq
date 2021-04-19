package cn.tianhai.gzadq.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import cn.tianhai.gzadq.mapper.ThresholdMapper;
import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.pojo.BridgeDetail;
import cn.tianhai.gzadq.pojo.ForecastData;
import cn.tianhai.gzadq.pojo.Threshold;
import cn.tianhai.gzadq.service.BridgeDataService;
import cn.tianhai.gzadq.service.BridgeDetailService;
import cn.tianhai.gzadq.service.DfBridgeService;
import cn.tianhai.gzadq.service.ForecastDataService;
import cn.tianhai.gzadq.util.Distance;

@CrossOrigin(origins = "*",maxAge = 3600)
@Controller
public class ThresholdController {
	@Autowired ThresholdMapper thresholdMapper;
	@Autowired BridgeDetailService bridgeDetailServiceImpl;
	@Autowired DfBridgeService dfBridgeServiceImpl;
	@Autowired BridgeDataService bridgeDataServiceImpl;
	@Autowired ForecastDataService forecastDataServiceImpl;
	
	@GetMapping("getThreshold")
	@ResponseBody
    public Object getThreshold(HttpSession httpSession) {
		Threshold threshold=(Threshold) httpSession.getAttribute("threshold");
//		Threshold threshold=thresholdMapper.getThreshold(userid);
        return threshold;
        
    }
	
	@PostMapping("/addThreshold/{path}")
    public Object addThreshold(Threshold threshold,Model m,@PathVariable String path,HttpSession httpSession) {
		httpSession.setAttribute("threshold", threshold);
        m.addAttribute("msg", "提交成功");
        m.addAttribute("path", path);
        return "succeed";
        
    }
	
	@PostMapping("/updateThreshold/{path}")
    public Object updateThreshold(Threshold threshold,Model m,@PathVariable String path,HttpSession httpSession) {
		Threshold threshold1=(Threshold) httpSession.getAttribute("threshold");
		if(threshold1!=null) {
			threshold.setLnglat(threshold1.getLnglat());
		}
		httpSession.setAttribute("threshold", threshold);
//        thresholdMapper.updateThreshold(threshold);
        m.addAttribute("msg", "修改成功");
        m.addAttribute("path", path);
        return "succeed";
        
    }
	
	@GetMapping("/setLnglat/{userid}/{lnglat}/{path}")
	@ResponseBody
    public Object setLnglat(@PathVariable int userid,@PathVariable String lnglat,@PathVariable String path,HttpSession httpSession) {
		
		Threshold threshold=(Threshold) httpSession.getAttribute("threshold");
		if(threshold==null) {
			threshold=new Threshold();
		}
		threshold.setLnglat(lnglat);
		httpSession.setAttribute("threshold", threshold);
		
//		Threshold threshold=thresholdMapper.getThreshold(userid);
//		Threshold threshold1=new Threshold();
//		threshold1.setUserid(userid);
//		threshold1.setLnglat(lnglat);
//		if(threshold==null) {
//			thresholdMapper.addLnglat(threshold1);
//		}else {
//			thresholdMapper.updateLnglat(threshold1);
//		}
        return path;
        
    }
	
	@GetMapping("/getDetailIn")
	@ResponseBody
    public Object getDetailIn(HttpSession httpSession) {
		Threshold threshold=(Threshold)httpSession.getAttribute("threshold");
		Threshold maxthreshold=new Threshold();
		maxthreshold.setMinVis(100000);

				List<BridgeDetail> list=bridgeDetailServiceImpl.getAllBridgeDetail();
				Distance distance=new Distance();
				
				double lon=Double.parseDouble(threshold.getLnglat().split(",")[0]);
				double lat=Double.parseDouble(threshold.getLnglat().split(",")[1]);
				double disk;
				double maxRain=0;
				double maxWind=0;
				double minVis=100000;
				for(BridgeDetail b:list) {
					disk=distance.getDistance(lon, lat, b.getLon(), b.getLat());
					System.out.println(disk);
					if(disk<Double.parseDouble(threshold.getRadius())*1000) {
						ActualData a=bridgeDataServiceImpl.getActualDataById(b.getObtid());
						if(a==null) {
							a=dfBridgeServiceImpl.getActualDataById(b.getObtid());
						}
						if(a!=null) {
							if(a.getRain()>maxRain) {
								maxRain=a.getRain();
							}
							if(a.getWind()>maxWind) {
								maxWind=a.getWind();
							}
							if(a.getVis()<minVis) {
								minVis=a.getVis();
							}
						}
						
					}
				}
				maxthreshold.setMaxRain(maxRain);
				maxthreshold.setMaxWind(maxWind);
				maxthreshold.setMinVis(minVis);
				
				Threshold maxthresholdFore=new Threshold();
				maxthresholdFore.setMinVis(100000);
						List<ForecastData> point5klist=forecastDataServiceImpl.getPoint5k();						
						maxRain=0;
						maxWind=0;
						minVis=100000;
						Calendar ca = Calendar.getInstance();
						ca.add(Calendar.HOUR,1);
						ca.set(Calendar.MINUTE,0);
						ca.set(Calendar.SECOND,0);
						ca.set(Calendar.MILLISECOND,0);
						System.out.println(ca.getTime());
						SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String str1 = simpleDateFormat.format(ca.getTime());
						System.out.println(str1);
						
						for(ForecastData f:point5klist) {
							disk=distance.getDistance(lon, lat, f.getX(), f.getY());
							System.out.println(disk);
							if(disk<Double.parseDouble(threshold.getRadius())*1000) {
								f.setForecasttime("2021-03-26 12:00:00");//str1
								ForecastData c=forecastDataServiceImpl.getForecastDataById(f);

								if(c.getRain()>maxRain) {
									maxRain=c.getRain();
								}
								if(c.getWind()>maxWind) {
									maxWind=c.getWind();
								}
								if(c.getVis()<minVis) {
									minVis=c.getVis();
								}
							}
						}
						maxthresholdFore.setMaxRain(maxRain);
						maxthresholdFore.setMaxWind(maxWind);
						maxthresholdFore.setMinVis(minVis);
						
				
						List<Threshold> thresholdList=new ArrayList<Threshold>();
						thresholdList.add(maxthreshold);
						thresholdList.add(maxthresholdFore);
        return thresholdList;
        
    }
	

}
