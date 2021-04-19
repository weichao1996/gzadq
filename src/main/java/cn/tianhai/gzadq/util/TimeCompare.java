package cn.tianhai.gzadq.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class TimeCompare {
	public static int timeCompare(String t1,String t2){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		Calendar c1=Calendar.getInstance();

		Calendar c2=Calendar.getInstance();

		try {
		c1.setTime(formatter.parse(t1));

		c2.setTime(formatter.parse(t2));

		} catch (ParseException e) {
		e.printStackTrace();

		}

		int result=c1.compareTo(c2);

		return result;

		}

		
		
}
