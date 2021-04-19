package cn.tianhai.gzadq.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.tianhai.gzadq.pojo.Car;

@Repository
public interface CarMapper {

	public Car getCar(Car car);

}
