package cn.tianhai.gzadq.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.tianhai.gzadq.pojo.ActualData;
import cn.tianhai.gzadq.pojo.Car;
import cn.tianhai.gzadq.service.CarService;

@Component
public class Calculate {
	
	@Autowired CarService carServiceImpl;
	//��������
	private BigDecimal m;//����
	private BigDecimal A;//���������	
	private BigDecimal kcs;//����������ϵ�����ƫ�ǵı�����ϵ
	private BigDecimal kcl;//����ϵ�����ƫ�ǵı�����ϵ
	private BigDecimal Lc;//����

	private BigDecimal R=new BigDecimal(1000);//�Ű뾶
	private double arfa=1.15;//�½�
	private BigDecimal Ucar0;//����  km/h  ����100
	private BigDecimal Ucar;//����  m/s
	
	//����Դ����
	private BigDecimal us;//Ħ��ϵ��(���ݽ������)
	private BigDecimal Uwind;//���� m/s
	private double eg;//�����
	private BigDecimal vis;//�ܼ���
	
	//����
	private BigDecimal lou=BigDecimal.valueOf(1.255);//�����ܶ�
	private BigDecimal g=BigDecimal.valueOf(9.8);//�������ٶ�
	
	private BigDecimal Cs;//����������ϵ��
	private BigDecimal Cl;//����ϵ��
	private BigDecimal beta;//��ƫ��
	private BigDecimal betatemp;
	private BigDecimal Fs;//����������
	private BigDecimal Fl;//��������
	private BigDecimal Fi;//������
	private BigDecimal Ga;//�� ����������
	private BigDecimal Ff;//�໬������
	
	/**
	 * ��ȫ�г�����
	 * @param car0
	 * @return
	 */
	public BigDecimal getUwind(Car car0,int Ucar1,ActualData a) {
		Car car=carServiceImpl.getCar(car0);
		m=BigDecimal.valueOf(car.getM());
		A=BigDecimal.valueOf(car.getA());
		kcs=BigDecimal.valueOf(car.getKcs());
		kcl=BigDecimal.valueOf(car.getKcl());
		eg=getEg(a);
		us=BigDecimal.valueOf(getUs(a));
		
		Ucar0=new BigDecimal(Ucar1);
		Ucar=Ucar0.multiply(new BigDecimal(1000)).divide(new BigDecimal(3600),5,RoundingMode.HALF_UP); //	m/s
		for(Uwind=new BigDecimal(1);Uwind.compareTo(new BigDecimal(100))==-1;Uwind=Uwind.add(BigDecimal.valueOf(0.01))) {
			 double egRadians = Math.toRadians(eg);//�Ƕ�ת��Ϊ����
			 double arfaRadians = Math.toRadians(arfa);//�Ƕ�ת��Ϊ����
			 betatemp=Uwind.multiply(BigDecimal.valueOf(Math.sin(egRadians))).divide(
					 Uwind.multiply(BigDecimal.valueOf(Math.cos(egRadians))).add(Ucar),5,RoundingMode.HALF_UP);
			 if(betatemp.compareTo(new BigDecimal(0))>-1) {
				 beta=BigDecimal.valueOf(Math.atan(betatemp.doubleValue())).multiply(new BigDecimal(180)).divide(BigDecimal.valueOf(3.14159),5,RoundingMode.HALF_UP);
			 }else {
				 beta=BigDecimal.valueOf(Math.atan(betatemp.doubleValue())).multiply(new BigDecimal(180)).divide(BigDecimal.valueOf(3.14159),5,RoundingMode.HALF_UP)
						 .add(new BigDecimal(180));
			 }

			 Cs=kcs.multiply(beta);
			 Cl=kcl.multiply(beta);
			 Fs=BigDecimal.valueOf(0.5).multiply(lou).multiply(A).multiply(Cs).multiply(
					 BigDecimal.valueOf(Math.pow(Uwind.doubleValue(), 2))
					 .add(BigDecimal.valueOf(Math.pow(Ucar.doubleValue(), 2)))
					 .add(new BigDecimal(2).multiply(Uwind).multiply(Ucar).multiply(BigDecimal.valueOf(Math.cos(egRadians))))
					 );
			 Fl=BigDecimal.valueOf(0.5).multiply(lou).multiply(A).multiply(Cl).multiply(
					 BigDecimal.valueOf(Math.pow(Uwind.doubleValue(), 2))
					 .add(BigDecimal.valueOf(Math.pow(Ucar.doubleValue(), 2)))
					 .add(new BigDecimal(2).multiply(Uwind).multiply(Ucar).multiply(BigDecimal.valueOf(Math.cos(egRadians))))
					 );
			 Fi=m.multiply(BigDecimal.valueOf(Math.pow(Ucar.doubleValue(), 2))).divide(R,5,RoundingMode.HALF_UP);
			 Ga=m.multiply(g).multiply(BigDecimal.valueOf(Math.sin(arfaRadians)));
			 
			 Ff=us.multiply(m.multiply(g).multiply(BigDecimal.valueOf(Math.cos(arfaRadians))).subtract(Fl));
			 
			 if(Fs.add(Fi).add(Ga).compareTo(Ff)>-1) {
				 break;
			 }
		}
		return Uwind;
	}
	
	public double getEg(ActualData a) {
		if(a.getObtid().equals("G3981")||a.getObtid().equals("G3972")||a.getObtid().equals("G3973")||a.getObtid().equals("G3974")
				||a.getObtid().equals("G3975")) {
			if(a.getWd()>=0 && a.getWd()<=45) {
				return new BigDecimal(45).subtract(BigDecimal.valueOf(a.getWd())).doubleValue();
			}else if(a.getWd()>45 && a.getWd()<=135) {
				return BigDecimal.valueOf(a.getWd()).subtract(new BigDecimal(45)).doubleValue();
			}else if(a.getWd()>135 && a.getWd()<=225) {
				return new BigDecimal(225).subtract(BigDecimal.valueOf(a.getWd())).doubleValue();
			}else if(a.getWd()>225 && a.getWd()<=315) {
				return BigDecimal.valueOf(a.getWd()).subtract(new BigDecimal(225)).doubleValue();
			}else if(a.getWd()>315 && a.getWd()<=360) {
				return new BigDecimal(405).subtract(BigDecimal.valueOf(a.getWd())).doubleValue();
			}
		}else if(a.getObtid().equals("G3983")||a.getObtid().equals("G3978")||a.getObtid().equals("G3984")||a.getObtid().equals("G3985")){
			if(a.getWd()>=0 && a.getWd()<=90) {
				return new BigDecimal(90).subtract(BigDecimal.valueOf(a.getWd())).doubleValue();
			}else if(a.getWd()>90 && a.getWd()<=180) {
				return BigDecimal.valueOf(a.getWd()).subtract(new BigDecimal(90)).doubleValue();
			}else if(a.getWd()>180 && a.getWd()<=270) {
				return new BigDecimal(270).subtract(BigDecimal.valueOf(a.getWd())).doubleValue();
			}else if(a.getWd()>270 && a.getWd()<=360) {
				return BigDecimal.valueOf(a.getWd()).subtract(new BigDecimal(270)).doubleValue();
			}
		}
		return 0;
		
	}
	
	public double getUs(ActualData a) {
		if(a.getRain()>1) {
			return 0.3;
		}else if(a.getRain()==0) {
			return 0.7;
		}
		
		return 0.5;
		
	}
	
	/**
	 * ���ݷ�����ȫ��ʻ�ٶ�
	 * @param car0
	 * @return
	 */
	public BigDecimal getUcarByUwind(Car car0,ActualData a) {
		Car car=carServiceImpl.getCar(car0);
		m=BigDecimal.valueOf(car.getM());
		A=BigDecimal.valueOf(car.getA());
		kcs=BigDecimal.valueOf(car.getKcs());
		kcl=BigDecimal.valueOf(car.getKcl());
		eg=getEg(a);
		us=BigDecimal.valueOf(getUs(a));
		
		Uwind=BigDecimal.valueOf(a.getWind());
		for(Ucar0=new BigDecimal(1);Ucar0.compareTo(new BigDecimal(300))==-1;Ucar0=Ucar0.add(BigDecimal.valueOf(0.01))) {
			 Ucar=Ucar0.multiply(new BigDecimal(1000)).divide(new BigDecimal(3600),5,RoundingMode.HALF_UP); //	m/s
			 double egRadians = Math.toRadians(eg);//�Ƕ�ת��
			 double arfaRadians = Math.toRadians(arfa);//�Ƕ�ת��
			 betatemp=Uwind.multiply(BigDecimal.valueOf(Math.sin(egRadians))).divide(
					 Uwind.multiply(BigDecimal.valueOf(Math.cos(egRadians))).add(Ucar),5,RoundingMode.HALF_UP);
			 if(betatemp.compareTo(new BigDecimal(0))>-1) {
				 beta=BigDecimal.valueOf(Math.atan(betatemp.doubleValue())).multiply(new BigDecimal(180)).divide(BigDecimal.valueOf(3.14159),5,RoundingMode.HALF_UP);
			 }else {
				 beta=BigDecimal.valueOf(Math.atan(betatemp.doubleValue())).multiply(new BigDecimal(180)).divide(BigDecimal.valueOf(3.14159),5,RoundingMode.HALF_UP)
						 .add(new BigDecimal(180));
			 }

			 Cs=kcs.multiply(beta);
			 Cl=kcl.multiply(beta);
			 Fs=BigDecimal.valueOf(0.5).multiply(lou).multiply(A).multiply(Cs).multiply(
					 BigDecimal.valueOf(Math.pow(Uwind.doubleValue(), 2))
					 .add(BigDecimal.valueOf(Math.pow(Ucar.doubleValue(), 2)))
					 .add(new BigDecimal(2).multiply(Uwind).multiply(Ucar).multiply(BigDecimal.valueOf(Math.cos(egRadians))))
					 );
			 Fl=BigDecimal.valueOf(0.5).multiply(lou).multiply(A).multiply(Cl).multiply(
					 BigDecimal.valueOf(Math.pow(Uwind.doubleValue(), 2))
					 .add(BigDecimal.valueOf(Math.pow(Ucar.doubleValue(), 2)))
					 .add(new BigDecimal(2).multiply(Uwind).multiply(Ucar).multiply(BigDecimal.valueOf(Math.cos(egRadians))))
					 );
			 Fi=m.multiply(BigDecimal.valueOf(Math.pow(Ucar.doubleValue(), 2))).divide(R,5,RoundingMode.HALF_UP);
			 Ga=m.multiply(g).multiply(BigDecimal.valueOf(Math.sin(arfaRadians)));
			 
			 Ff=us.multiply(m.multiply(g).multiply(BigDecimal.valueOf(Math.cos(arfaRadians))).subtract(Fl));
			 
			 if(Fs.add(Fi).add(Ga).compareTo(Ff)>-1) {
				 break;
			 }
			
		}
		return Ucar0;
		
	}
	
	/**
	 * �����ܼ�����ȫ��ʻ�ٶ�
	 * @param car0
	 * @return
	 */
	public BigDecimal getUcarByVis(Car car0,ActualData a1) {
		Car car=carServiceImpl.getCar(car0);
		us=BigDecimal.valueOf(getUs(a1));
		vis=BigDecimal.valueOf(a1.getVis());
//		vis=new BigDecimal(500);
		double arfaRadians = Math.toRadians(arfa);//�Ƕ�ת��Ϊ����
		BigDecimal a=g.multiply(us.add(BigDecimal.valueOf(arfaRadians)));
		Ucar=BigDecimal.valueOf(Math.sqrt(new BigDecimal(4).subtract(
				new BigDecimal(2).multiply(BigDecimal.valueOf(car.getLc()).add(new BigDecimal(5)).subtract(vis))
				.divide(a,5,RoundingMode.HALF_UP)).doubleValue())).subtract(new BigDecimal(2)).multiply(a);
		
		
		Ucar0=BigDecimal.valueOf(Math.floor(Ucar.multiply(new BigDecimal(3600)).divide(new BigDecimal(1000),5,RoundingMode.HALF_UP).doubleValue()));
		return Ucar0;
	}
	
	/**
	 * ��ȡ��ȫ��ʻ�ٶ�
	 * @param car0
	 * @return
	 */
	public int getUcar(Car car0,ActualData a) {
		Car car=carServiceImpl.getCar(car0);
//		System.out.println("�ܼ���     "+car.getName()+"��ȫ��ʻ����");
//		for(vis=new BigDecimal(60);vis.compareTo(new BigDecimal(301))==-1;vis=vis.add(new BigDecimal(10))) {
//		for(vis=new BigDecimal(330);vis.compareTo(new BigDecimal(1001))==-1;vis=vis.add(new BigDecimal(30))) {
//		System.out.println("����     "+car.getName()+"��ȫ��ʻ����");
//		vis=new BigDecimal(1001);
//		for(Uwind=new BigDecimal(10);Uwind.compareTo(new BigDecimal(35))==-1;Uwind=Uwind.add(new BigDecimal(1))) {
		vis=BigDecimal.valueOf(a.getVis());
			if(vis.compareTo(new BigDecimal(50))<1) {
				System.out.println(vis+"     15");
				return 15;
				
			}else if(vis.compareTo(new BigDecimal(50))==1&&vis.compareTo(new BigDecimal(300))<1) {
				if(car.getCid()==1) {
				return BigDecimal.valueOf(0.3549).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(14.721)).intValue();
			}else if(car.getCid()==2) {
				return BigDecimal.valueOf(0.3565).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(14.267)).intValue();
			}else if(car.getCid()==3) {
				return BigDecimal.valueOf(0.3475).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(11.253)).intValue();
			}else if(car.getCid()==4) {
				return BigDecimal.valueOf(0.3389).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(8.8219)).intValue();
			}
				
//				if(car.getCid()==1) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(0.3549).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(14.721)).intValue());
//				}else if(car.getCid()==2) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(0.3565).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(14.267)).intValue());
//				}else if(car.getCid()==3) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(0.3475).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(11.253)).intValue());
//				}else if(car.getCid()==4) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(0.3389).multiply(getUcarByVis(car,a)).add(BigDecimal.valueOf(8.8219)).intValue());
//				}

				
			}else if(vis.compareTo(new BigDecimal(300))==1&&vis.compareTo(new BigDecimal(1000))<1){
				
				if(car.getCid()==1) {
					return BigDecimal.valueOf(0.78).multiply(getUcarByUwind(car,a))
							.add(BigDecimal.valueOf(0.085).multiply(getUcarByVis(car,a)))
							.subtract(BigDecimal.valueOf(154.5)).intValue();
				}else if(car.getCid()==2) {
					return BigDecimal.valueOf(-0.432).multiply(getUcarByUwind(car,a))
							.add(BigDecimal.valueOf(0.0354).multiply(getUcarByVis(car,a)))
							.add(BigDecimal.valueOf(201.365)).intValue();
				}else if(car.getCid()==3) {
					return BigDecimal.valueOf(0.2555).multiply(getUcarByUwind(car,a))
							.add(BigDecimal.valueOf(0.0848).multiply(getUcarByVis(car,a)))
							.subtract(BigDecimal.valueOf(4.5)).intValue();
				}else if(car.getCid()==4) {
					return BigDecimal.valueOf(0.1316).multiply(getUcarByUwind(car,a))
							.add(BigDecimal.valueOf(0.082).multiply(getUcarByVis(car,a)))
							.add(BigDecimal.valueOf(22.609)).intValue();
				}
				
//				if(car.getCid()==1) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(0.78).multiply(getUcarByUwind(car,a))
//							.add(BigDecimal.valueOf(0.085).multiply(getUcarByVis(car,a)))
//							.subtract(BigDecimal.valueOf(154.5)).intValue());
//					
//				}else if(car.getCid()==2) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(-0.432).multiply(getUcarByUwind(car,a))
//							.add(BigDecimal.valueOf(0.0354).multiply(getUcarByVis(car,a)))
//							.add(BigDecimal.valueOf(201.365)).intValue());
//				}else if(car.getCid()==3) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(0.2555).multiply(getUcarByUwind(car,a))
//							.add(BigDecimal.valueOf(0.0848).multiply(getUcarByVis(car,a)))
//							.subtract(BigDecimal.valueOf(4.5)).intValue());
//				}else if(car.getCid()==4) {
//					System.out.println(vis+"     "+BigDecimal.valueOf(0.1316).multiply(getUcarByUwind(car,a))
//							.add(BigDecimal.valueOf(0.082).multiply(getUcarByVis(car,a)))
//							.add(BigDecimal.valueOf(22.609)).intValue());
//				}
				
			}else if(vis.compareTo(new BigDecimal(1000))==1) {
				
				if(car.getCid()==1) {
					return BigDecimal.valueOf(1.2048).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(86.781)).intValue();
				}else if(car.getCid()==2) {
					return BigDecimal.valueOf(0.6143).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(30.613)).intValue();
				}else if(car.getCid()==3) {
					return BigDecimal.valueOf(0.7667).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(76.648)).intValue();
				}else if(car.getCid()==4) {
					return BigDecimal.valueOf(1.0662).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(162.55)).intValue();
				}
				
//				if(car.getCid()==1) {
//					System.out.println(Uwind+"     "+BigDecimal.valueOf(1.2048).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(86.781)).intValue());
//				}else if(car.getCid()==2) {
//					System.out.println(Uwind+"     "+BigDecimal.valueOf(0.6143).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(30.613)).intValue());
//				}else if(car.getCid()==3) {
//					System.out.println(Uwind+"     "+BigDecimal.valueOf(0.7667).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(76.648)).intValue());
//				}else if(car.getCid()==4) {
//					System.out.println(Uwind+"     "+BigDecimal.valueOf(1.0662).multiply(getUcarByUwind(car,a)).subtract(BigDecimal.valueOf(162.55)).intValue());
//				}
			}
		
		
		
		return 0;

	}
	
	
	
}
