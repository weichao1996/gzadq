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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.pojo.BridgeDetail;
import cn.tianhai.gzadq.pojo.Car;
import cn.tianhai.gzadq.service.BridgeDataService;
import cn.tianhai.gzadq.service.BridgeDetailService;
import cn.tianhai.gzadq.service.DfBridgeService;
import cn.tianhai.gzadq.util.Calculate;
import cn.tianhai.gzadq.util.CalculateNew;
import cn.tianhai.gzadq.util.ContentComparator;
import net.sf.json.JSONArray;

@CrossOrigin(origins = "*",maxAge = 3600)
@Controller
public class CalculateController {
	@Autowired CalculateNew calculateNew;
	@Autowired BridgeDetailService bridgeDetailServiceImpl;
	@Autowired DfBridgeService dfBridgeServiceImpl;
	@Autowired BridgeDataService bridgeDataServiceImpl;
	
	@GetMapping("/getUwind/{cid}/{Ucar}")
	@ResponseBody
    public Object getUwind(@PathVariable int cid,@PathVariable int Ucar) {
		Car car=new Car();
		car.setCid(cid);
		
		List<ActualData> actualDataList=dfBridgeServiceImpl.getWindList();
		List<ActualData> actualDataList2=bridgeDataServiceImpl.getWindList();
		
		actualDataList.addAll(actualDataList2);
		Collections.sort(actualDataList, new ContentComparator());  
		
		List uwindResult = new ArrayList();
		for(ActualData a:actualDataList) {
			uwindResult.add(calculateNew.getUwind(car,Ucar,a));
		}
        return uwindResult;
        
    }
	
	@GetMapping("/getUcar/{cid}")
	@ResponseBody
    public Object getUcar(@PathVariable int cid) {
		Car car=new Car();
		car.setCid(cid);
		
		List<ActualData> actualDataList=dfBridgeServiceImpl.getWindList();
		List<ActualData> actualDataList2=bridgeDataServiceImpl.getWindList();
		
		actualDataList.addAll(actualDataList2);
		Collections.sort(actualDataList, new ContentComparator());  
		
		
		
		List uwindResult = new ArrayList();
		uwindResult.add(actualDataList);
		for(ActualData a:actualDataList) {
			uwindResult.add(calculateNew.getUcar(car,a));
		}
        return uwindResult;
        
    }
	
//	@GetMapping("/getUcarByUwind")
//	@ResponseBody
//    public Object getUcarByUwind(Car car,Model m) {
//		
//        return calculate.getUcarByUwind(car);
//        
//    }
//	
//	@GetMapping("/getUcarByVis")
//	@ResponseBody
//    public Object getUcarByVis(Car car,Model m) {
//		
//        return calculate.getUcarByVis(car);
//        
//    }
//	
//	@GetMapping("/getUcar")
//	@ResponseBody
//    public Object getUcar(Car car,Model m) {
//		
//        return calculate.getUcar(car);
//        
//    }
	
	@GetMapping("/safeVcar")
    public Object safeVcar(Model m) {
		
        return "safeVcar";
        
    }
	

}
