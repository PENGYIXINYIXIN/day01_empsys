package com.qfedu.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {

    @RequestMapping("/login.do")
    public String login(String username, String password, Integer isRemember){

        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        Subject subject = SecurityUtils.getSubject();

        // 设置记住我
        if(isRemember == 1){
            token.setRememberMe(true);
        }

        try {
            subject.login(token);
            return "redirect:/list.jsp";
        } catch (AuthenticationException e) {
            e.printStackTrace();
            return "redirect:/login.jsp";
        }
    }
    // 判断是否有指定的权限
    @RequiresPermissions("user:list")
    @RequestMapping("/test.do")
    public String test(){
        return "redirect:/add.jsp";
    }

    @RequiresPermissions("user:sss")
    @RequestMapping("/test2.do")
    public String test2(){
        return "redirect:/add.jsp";
    }

}




