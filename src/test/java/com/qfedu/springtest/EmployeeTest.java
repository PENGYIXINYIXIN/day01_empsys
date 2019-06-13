package com.qfedu.springtest;

import com.qfedu.pojo.Employee;
import com.qfedu.service.EmployeeService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

public class EmployeeTest extends BaseTest {
    // 使用spring-test，可以直接注入对象
    @Autowired
    private EmployeeService empService;

    @Test
    @Rollback(false) // 设置是否回滚，默认回滚
    public void addTest(){
        Employee emp = new Employee();
        emp.setName("houhou");
        emp.setSex("女");
        empService.addEmp(emp);
    }

}
