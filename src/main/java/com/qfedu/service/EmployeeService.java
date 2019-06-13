package com.qfedu.service;

import com.qfedu.pojo.Employee;

import java.util.List;
import java.util.Map;

public interface EmployeeService {

    public List<Employee> findALlEmps();

    public void addEmp(Employee emp);

    public void deleteEmpById(Integer id);

    public Employee findEmpById(Integer id);

    public void updateEmp(Employee emp);

    //public VPageInfo<Employee> findByPage(Integer page, Integer size);

    public Map<String, Object> findByPage(Integer page, Integer limit);

    public void addEmps(List<Employee> list);
}
