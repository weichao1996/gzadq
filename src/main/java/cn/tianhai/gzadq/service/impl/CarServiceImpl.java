package cn.tianhai.gzadq.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import cn.tianhai.gzadq.mapper.CarMapper;
import cn.tianhai.gzadq.pojo.Car;
import cn.tianhai.gzadq.service.CarService;

@Service
@CacheConfig(cacheNames="car")
public class CarServiceImpl implements CarService {
	@Autowired CarMapper carMapper;
	
	@Override
	@Cacheable(key="'car '+ #p0.cid")
	public Car getCar(Car car) {
		// TODO Auto-generated method stub
		return carMapper.getCar(car);
	}

}
