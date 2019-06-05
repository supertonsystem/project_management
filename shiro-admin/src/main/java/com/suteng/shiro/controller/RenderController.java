package com.suteng.shiro.controller;

import java.util.HashMap;
import java.util.Map;

import com.suteng.shiro.util.ResultUtil;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 页面跳转类
 *
 * @date 2018/4/24 14:37
 * @since 1.0
 */
@Controller
public class RenderController {

    @RequiresAuthentication
    @GetMapping(value = {"", "/index"})
    public ModelAndView home() {
        return ResultUtil.view("index");
    }

    @RequiresPermissions("users")
    @GetMapping("/users")
    public ModelAndView user() {
        return ResultUtil.view("user/list");
    }

    @RequiresPermissions("resources")
    @GetMapping("/resources")
    public ModelAndView resources() {
        return ResultUtil.view("resources/list");
    }

    @RequiresPermissions("roles")
    @GetMapping("/roles")
    public ModelAndView roles() {
        return ResultUtil.view("role/list");
    }

    @RequiresPermissions("departments")
    @GetMapping("/departments")
    public ModelAndView departments() {
        return ResultUtil.view("department/list");
    }

    @RequiresPermissions("projectmgt:agenda")
    @GetMapping("/projectmgt/agenda")
    public ModelAndView agendaList() {
        return ResultUtil.view("projectmgt/agendalist");
    }

    @RequiresPermissions("projectmgt:projects")
    @GetMapping("/projectmgt/projects")
    public ModelAndView projects() {
        return ResultUtil.view("projectmgt/list");
    }

    @RequiresPermissions("projectmgt:myproject")
    @GetMapping("/projectmgt/myproject")
    public ModelAndView myProjects() {
        Map<String, String> model = new HashMap<String, String>();
        model.put("type", "mylist");
        return new ModelAndView("projectmgt/list", model);
    }

    @RequiresPermissions("projectmgt:focusprojects")
    @GetMapping("/projectmgt/focusprojects")
    public ModelAndView focusProjects() {
        Map<String, String> model = new HashMap<String, String>();
        model.put("type", "focus");
        return new ModelAndView("projectmgt/list", model);
    }

    //@RequiresPermissions("custmgt:persons")
    //@GetMapping("/custmgt/persons")
    //public ModelAndView custPersons() {
    //    return ResultUtil.view("custmgt/person_list");
    //}

    @RequiresPermissions("custmgt:projects")
    @GetMapping("/custmgt/projects")
    public ModelAndView custProjects() {
        return ResultUtil.view("custmgt/project_list");
    }

    @RequiresPermissions("custmgt:contacts")
    @GetMapping("/custmgt/contacts")
    public ModelAndView custContacts() {
        return ResultUtil.view("custmgt/contact_list");
    }

    @RequiresPermissions("giftmgt:types")
    @GetMapping("/giftmgt/types")
    public ModelAndView giftTypes() {
        return ResultUtil.view("giftmgt/type_list");
    }

    @RequiresPermissions("giftmgt:repertorys")
    @GetMapping("/giftmgt/repertorys")
    public ModelAndView giftRepertorys() {
        return ResultUtil.view("giftmgt/repertory_list");
    }

    @RequiresPermissions("giftmgt:consumes")
    @GetMapping("/giftmgt/consumes")
    public ModelAndView giftConsumes() {
        return ResultUtil.view("giftmgt/consume_list");
    }

    @RequiresPermissions("giftmgt:consumeDetails")
    @GetMapping("/giftmgt/consumeDetails")
    public ModelAndView giftConsumeDetails() {
        return ResultUtil.view("giftmgt/consume_detail_list");
    }


}
