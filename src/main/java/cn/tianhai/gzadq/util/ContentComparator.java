package cn.tianhai.gzadq.util;

import java.util.Comparator;

import cn.tianhai.gzadq.pojo.ActualData;  

public class ContentComparator implements Comparator<ActualData>{  
    public int compare(ActualData o1, ActualData o2) {  
  
        //将 null 排到最后  
        if(o1 == null){  
            return 1;  
        }  
        if(o2 == null || !(o2 instanceof ActualData)){  
            return -1;  
        }  
          
        double lon1 = o1.getLon();  
        double lon2 = o2.getLon();  
        return lon1 > lon2 ? 1 : lon1 < lon2 ? -1 : 0;  
          
        /* 
        //如果想要按照 name 字段进行排序, 只需将最后三行代码改为下面这一行即可 
        return o1.getName().compareTo(o2.getName()); 
        */  
          
    }  
}  
