package cn.tianhai.gzadq.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.pojo.BridgeDetail;
import cn.tianhai.gzadq.pojo.Car;
import cn.tianhai.gzadq.pojo.Threshold;
import cn.tianhai.gzadq.service.BridgeDataService;
import cn.tianhai.gzadq.service.BridgeDetailService;
import cn.tianhai.gzadq.service.DfBridgeService;
import cn.tianhai.gzadq.util.Calculate;
import cn.tianhai.gzadq.util.ContentComparator;
import cn.tianhai.gzadq.util.Distance;
import net.sf.json.JSONArray;

@CrossOrigin(origins = "*",maxAge = 3600)
@Controller
public class ActualController {

	@Autowired BridgeDetailService bridgeDetailServiceImpl;
	@Autowired DfBridgeService dfBridgeServiceImpl;
	@Autowired BridgeDataService bridgeDataServiceImpl;
	
	@GetMapping("/actualData")
    public Object actualData(Model m) {
		List<BridgeDetail> list=bridgeDetailServiceImpl.getActualBridgeDetail();
		JSONArray json = JSONArray.fromObject(list);
		System.out.println(json);
		m.addAttribute("json",json);
        return "actualData";
        
    }
	
	@GetMapping("/getMinActual")
	@ResponseBody
    public Object getMinActual() {
		List<BridgeDetail> list=bridgeDetailServiceImpl.getAllBridgeDetail();
		List list2=new ArrayList();
		for(BridgeDetail b:list) {
			if(b.getObtid().equals("G3981")||b.getObtid().equals("G3972")||b.getObtid().equals("G3973")||
					b.getObtid().equals("G3974")||b.getObtid().equals("G3975")||b.getObtid().equals("G3983")||
					b.getObtid().equals("G3978")||b.getObtid().equals("G3984")||b.getObtid().equals("G3985")) {
				List<ActualData> actualDataList=dfBridgeServiceImpl.getMinActualData(b.getObtid());
				if(actualDataList.size()==0) {
					actualDataList=bridgeDataServiceImpl.getMinActualData(b.getObtid());
				}
				list2.add(actualDataList);
			}
			
		}
		
        return list2;
        
    }
	
	@GetMapping("/getMinActual/{obtid}")
	@ResponseBody
    public Object getMinActual(@PathVariable String obtid) {
		List<ActualData> actualDataList=dfBridgeServiceImpl.getMinActualData(obtid);
		if(actualDataList.size()==0) {
			actualDataList=bridgeDataServiceImpl.getMinActualData(obtid);
		}
        return actualDataList;
        
    }
	
	@GetMapping("/getHourActual/{obtid}")
	@ResponseBody
    public Object getHourActual(@PathVariable String obtid) {
		List<ActualData> actualDataList=dfBridgeServiceImpl.getHourActualData(obtid);
		List<ActualData> list=new ArrayList<ActualData>();
		
		if(actualDataList.size()==0) {
			actualDataList=bridgeDataServiceImpl.getHourActualData(obtid);
			for(int i=0;i<actualDataList.size();i++) {
				String datetime=actualDataList.get(i).getDatetime();
				if(datetime.substring(14, 19).equals("00:00")) {
					list.add(actualDataList.get(i));
				}
			}
		}else {
			for(int i=0;i<actualDataList.size();i++) {
				String datetime=actualDataList.get(i).getDatetime();
				if(datetime.substring(14, 19).equals("00:00")) {
					list.add(actualDataList.get(i));
				}
			}
		}
        return list;
        
    }
	
	@GetMapping("/getWindList")
	@ResponseBody
    public Object getWindList() {
		List<ActualData> actualDataList=dfBridgeServiceImpl.getWindList();
		List<ActualData> actualDataList2=bridgeDataServiceImpl.getWindList();
		
		actualDataList.addAll(actualDataList2);
		Collections.sort(actualDataList, new ContentComparator());  
		
        return actualDataList;
        
    }
	

}
