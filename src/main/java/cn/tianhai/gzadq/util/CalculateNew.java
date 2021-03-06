package cn.tianhai.gzadq.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.pojo.Car;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Component
public class CalculateNew {

	public double getUwind(Car car,int Ucar,ActualData a) {
		if(a.getRain()==0) {//干路面
			if(car.getCid()==1) {//轿车
				return new BigDecimal(Ucar).subtract(BigDecimal.valueOf(199.68)).divide(BigDecimal.valueOf(-5.44),2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}else if(car.getCid()==2) {//微型客车
				return new BigDecimal(Ucar).subtract(BigDecimal.valueOf(281.6)).divide(BigDecimal.valueOf(-11.52),2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}else if(car.getCid()==3) {//中型客车
				return new BigDecimal(Ucar).subtract(new BigDecimal(300)).divide(new BigDecimal(-10)).doubleValue();
			}else if(car.getCid()==4) {//集装箱挂车
				return new BigDecimal(Ucar).subtract(BigDecimal.valueOf(212.4)).divide(BigDecimal.valueOf(-6.62),2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}
		}else {//湿路面
			if(car.getCid()==1) {//轿车
				return new BigDecimal(Ucar).subtract(BigDecimal.valueOf(173.12)).divide(BigDecimal.valueOf(-5.82),2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}else if(car.getCid()==2) {//微型客车
				return new BigDecimal(Ucar).subtract(BigDecimal.valueOf(206.5)).divide(new BigDecimal(-11),2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}else if(car.getCid()==3) {//中型客车
				return new BigDecimal(Ucar).subtract(BigDecimal.valueOf(236.48)).divide(BigDecimal.valueOf(-9.78),2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}else if(car.getCid()==4) {//集装箱挂车
				return new BigDecimal(Ucar).subtract(BigDecimal.valueOf(189.62)).divide(BigDecimal.valueOf(-7.83),2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}
		}
		return 0;

	}



	public String getUcar(Car car,ActualData a) {
		double Uwind=a.getWind();
		double Ucar;
		if(Uwind>18){
			return "限行(风速大于18m/s封桥)";
		}
		if(a.getRain()==0) {//干路面
			if(car.getCid()==1) {//轿车
				Ucar= BigDecimal.valueOf(-5.44).multiply(BigDecimal.valueOf(Uwind)).add(BigDecimal.valueOf(199.68)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}else if(car.getCid()==2) {//微型客车
				Ucar= BigDecimal.valueOf(-11.52).multiply(BigDecimal.valueOf(Uwind)).add(BigDecimal.valueOf(281.6)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}else if(car.getCid()==3) {//中型客车
				Ucar= new BigDecimal(-10).multiply(BigDecimal.valueOf(Uwind)).add(new BigDecimal(300)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}else if(car.getCid()==4) {//集装箱挂车
				Ucar= BigDecimal.valueOf(-6.62).multiply(BigDecimal.valueOf(Uwind)).add(BigDecimal.valueOf(212.4)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}
		}else{//湿路面
			if(car.getCid()==1) {//轿车
				Ucar= BigDecimal.valueOf(-5.82).multiply(BigDecimal.valueOf(Uwind)).add(BigDecimal.valueOf(173.12)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}else if(car.getCid()==2) {//微型客车
				Ucar= new BigDecimal(-11).multiply(BigDecimal.valueOf(Uwind)).add(BigDecimal.valueOf(206.5)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}else if(car.getCid()==3) {//中型客车
				Ucar= BigDecimal.valueOf(-9.78).multiply(BigDecimal.valueOf(Uwind)).add(BigDecimal.valueOf(236.48)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}else if(car.getCid()==4) {//集装箱挂车
				Ucar= BigDecimal.valueOf(-7.83).multiply(BigDecimal.valueOf(Uwind)).add(BigDecimal.valueOf(189.62)).setScale(1,BigDecimal.ROUND_DOWN).doubleValue();
				return (Ucar>100?"100":Ucar)+"";
			}
		}
		return "0";

	}

	/*public double getUwind(Car car,int Ucar,ActualData a) {
		if(a.getRain()==0) {//干路面
			if(car.getCid()==1) {//轿车
				if(Ucar<=100&&Ucar>80) {
					return 20;
				}
				if(Ucar<=80&&Ucar>60) {
					return 22;
				}
				if(Ucar<=60&&Ucar>0) {
					return 24;
				}
			}else if(car.getCid()==2) {//微型客车
				if(Ucar<=100&&Ucar>80) {
					return 15.5;
				}
				if(Ucar<=80&&Ucar>60) {
					return 17.5;
				}
				if(Ucar<=60&&Ucar>40) {
					return 19;
				}
				if(Ucar<=40&&Ucar>0) {
					return 20;
				}
			}else if(car.getCid()==3) {//中型客车
				if(Ucar<=100&&Ucar>80) {
					return 19.5;
				}
				if(Ucar<=80&&Ucar>60) {
					return 22;
				}
				if(Ucar<=60&&Ucar>40) {
					return 23.5;
				}
				if(Ucar<=40&&Ucar>0) {
					return 24.3;
				}
			}else if(car.getCid()==4) {//集装箱挂车
				if(Ucar<=100&&Ucar>80) {
					return 17;
				}
				if(Ucar<=80&&Ucar>60) {
					return 20;
				}
				if(Ucar<=60&&Ucar>40) {
					return 22;
				}
				if(Ucar<=40&&Ucar>0) {
					return 23.5;
				}
			}
		}else {//湿路面
			if(car.getCid()==1) {//轿车
				if(Ucar<=100&&Ucar>80) {
					return 14;
				}
				if(Ucar<=80&&Ucar>60) {
					return 16;
				}
				if(Ucar<=60&&Ucar>0) {
					return 18.1;
				}
			}else if(car.getCid()==2) {//微型客车
				if(Ucar<=100&&Ucar>80) {
					return 9.5;
				}
				if(Ucar<=80&&Ucar>60) {
					return 11.5;
				}
				if(Ucar<=60&&Ucar>40) {
					return 13;
				}
				if(Ucar<=40&&Ucar>0) {
					return 14;
				}
			}else if(car.getCid()==3) {//中型客车
				if(Ucar<=100&&Ucar>80) {
					return 13.5;
				}
				if(Ucar<=80&&Ucar>60) {
					return 16;
				}
				if(Ucar<=60&&Ucar>40) {
					return 17.5;
				}
				if(Ucar<=40&&Ucar>0) {
					return 18.3;
				}
			}else if(car.getCid()==4) {//集装箱挂车
				if(Ucar<=100&&Ucar>80) {
					return 11;
				}
				if(Ucar<=80&&Ucar>60) {
					return 14;
				}
				if(Ucar<=60&&Ucar>40) {
					return 16;
				}
				if(Ucar<=40&&Ucar>0) {
					return 17.5;
				}
			}
		}
		return 0;

	}



	public String getUcar(Car car,ActualData a) {
		double Uwind=a.getWind();
		if(a.getRain()==0) {//干路面
			if(car.getCid()==1) {//轿车
				if(Uwind>=0&&Uwind<=20) {
					return "100";
				}
				if(Uwind>20&&Uwind<=22) {
					return "80";
				}
				if(Uwind>22&&Uwind<=24) {
					return "60";
				}
				if(Uwind>24) {
					return "限行";
				}
			}else if(car.getCid()==2) {//微型客车
				if(Uwind>=0&&Uwind<=15.5) {
					return "100";
				}
				if(Uwind>15.5&&Uwind<=17.5) {
					return "80";
				}
				if(Uwind>17.5&&Uwind<=19) {
					return "60";
				}
				if(Uwind>19&&Uwind<=20) {
					return "40";
				}
				if(Uwind>20) {
					return "限行";
				}
			}else if(car.getCid()==3) {//中型客车
				if(Uwind>=0&&Uwind<=19.5) {
					return "100";
				}
				if(Uwind>19.5&&Uwind<=22) {
					return "80";
				}
				if(Uwind>22&&Uwind<=23.5) {
					return "60";
				}
				if(Uwind>23.5&&Uwind<=24.3) {
					return "40";
				}
				if(Uwind>24.3) {
					return "限行";
				}
			}else if(car.getCid()==4) {//集装箱挂车
				if(Uwind>=0&&Uwind<=17) {
					return "100";
				}
				if(Uwind>17&&Uwind<=20) {
					return "80";
				}
				if(Uwind>20&&Uwind<=22) {
					return "60";
				}
				if(Uwind>22&&Uwind<=23.5) {
					return "40";
				}
				if(Uwind>23.5) {
					return "限行";
				}
			}
		}else{//湿路面
			if(car.getCid()==1) {//轿车
				if(Uwind>=0&&Uwind<=14) {
					return "100";
				}
				if(Uwind>14&&Uwind<=16) {
					return "80";
				}
				if(Uwind>16&&Uwind<=18.1) {
					return "60";
				}
				if(Uwind>18.1) {
					return "限行";
				}
			}else if(car.getCid()==2) {//微型客车
				if(Uwind>=0&&Uwind<=9.5) {
					return "100";
				}
				if(Uwind>9.5&&Uwind<=11.5) {
					return "80";
				}
				if(Uwind>11.5&&Uwind<=13) {
					return "60";
				}
				if(Uwind>13&&Uwind<=14) {
					return "40";
				}
				if(Uwind>14) {
					return "限行";
				}
			}else if(car.getCid()==3) {//中型客车
				if(Uwind>=0&&Uwind<=13.5) {
					return "100";
				}
				if(Uwind>13.5&&Uwind<=16) {
					return "80";
				}
				if(Uwind>16&&Uwind<=17.5) {
					return "60";
				}
				if(Uwind>17.5&&Uwind<=18.3) {
					return "40";
				}
				if(Uwind>18.3) {
					return "限行";
				}
			}else if(car.getCid()==4) {//集装箱挂车
				if(Uwind>=0&&Uwind<=11) {
					return "100";
				}
				if(Uwind>11&&Uwind<=14) {
					return "80";
				}
				if(Uwind>14&&Uwind<=16) {
					return "60";
				}
				if(Uwind>16&&Uwind<=17.5) {
					return "40";
				}
				if(Uwind>17.5) {
					return "限行";
				}
			}
		}
		return "0";

	}*/
}
