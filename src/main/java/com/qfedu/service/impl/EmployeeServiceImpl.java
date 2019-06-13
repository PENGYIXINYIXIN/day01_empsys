package com.qfedu.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.qfedu.dao.EmployeeDao;
import com.qfedu.pojo.Employee;
import com.qfedu.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    // required=false，不是必须写的
    @Autowired(required = false)
    private EmployeeDao empDao;

    @Override
    public void addEmp(Employee emp) {
        empDao.add(emp);
    }

    @Override
    public List<Employee> findALlEmps() {
        // 调用该方法进行分页查询
        // 第一个参数：页码；第二个参数：每页显示的记录数
        // startPage语句后，一定要紧跟着查询的相关方法
        PageHelper.startPage(1, 5);
        List<Employee> list = empDao.findAll();
        // 获取总记录数
        long total = ((Page) list).getTotal();
        return null;
    }

    @Override
    public Map<String, Object> findByPage(Integer page, Integer limit) {
        PageHelper.startPage(page, limit);
        List<Employee> list = empDao.findAll();
        // 获取总记录数
        long total = ((Page) list).getTotal();
        // 获取总页数
        int pages = ((Page) list).getPages();

        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", total);
        map.put("data", list);

        return map;

    }

    @Override
    public void deleteEmpById(Integer id) {

        empDao.deleteById(id);
    }

    @Override
    public Employee findEmpById(Integer id) {
        return empDao.findById(id);
    }

    @Override
    public void updateEmp(Employee emp) {
        empDao.update(emp);
    }

//    @Override
//    public VPageInfo<Employee> findByPage(Integer page, Integer size) {
//
//        VPageInfo<Employee> pageInfo = new VPageInfo<>();
//        // 计算分页开始的索引
//        int index = (page - 1) * size;
//        List<Employee> list = empDao.findByIndexAndSize(index, size);
//        // 设置当前页
//        pageInfo.setCurrentPage(page);
//        // 设置当前页的记录
//        pageInfo.setPageList(list);
//        // 计算总页数
//        int totalPage = 0;
//        int count = empDao.count();
//        if(count % size == 0){
//            totalPage = count / size;
//        }else{
//            totalPage = count / size + 1;
//        }
//        // 设置总页数
//        pageInfo.setTotalPage(totalPage);
//        return pageInfo;
//    }

    @Override
    public void addEmps(List<Employee> list) {
        empDao.addBatch(list);
    }
}





