package com.qfedu.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.qfedu.common.JsonBean;
import com.qfedu.pojo.Employee;
import com.qfedu.service.EmployeeService;
import com.qfedu.utils.ExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

@Controller
public class ImportExcelController {

    @Autowired
    private EmployeeService empService;
    @RequestMapping("/import.do")
    @ResponseBody
    public JsonBean importExcel(@RequestParam MultipartFile excelFile){

        // 获取上传文件的文件名
        String fileName = excelFile.getOriginalFilename();

        // 获取上传文件的输入流
        try {
            InputStream inputStream = excelFile.getInputStream();
            // 读取excel内容
            List<Map<String, Object>> maps = ExcelUtils.readExcel(fileName, inputStream);
            // 通过jackson进行操作
            ObjectMapper objectMapper = new ObjectMapper();
            // 将对象转为json格式字符串
            String jsonStr = objectMapper.writeValueAsString(maps);
            // 将json字符串转为指定类型的对象
            List<Employee> employeeList = objectMapper.readValue(jsonStr, new TypeReference<List<Employee>>() {});

            // 批量插入
            empService.addEmps(employeeList);

        } catch (Exception e) {
            e.printStackTrace();
            return new JsonBean(0, e.getMessage());
        }

        return new JsonBean(1, null);
    }

}
