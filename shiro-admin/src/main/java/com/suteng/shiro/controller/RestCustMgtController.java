package com.suteng.shiro.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.Config;
import com.suteng.shiro.business.entity.CustContactEntity;
import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.business.entity.Role;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.CustContactService;
import com.suteng.shiro.business.service.CustPersonRelationService;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.business.service.CustProjectRelationService;
import com.suteng.shiro.business.service.CustProjectService;
import com.suteng.shiro.business.service.ShiroService;
import com.suteng.shiro.business.service.SysConfigService;
import com.suteng.shiro.business.service.SysRoleService;
import com.suteng.shiro.business.service.SysUserRoleService;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.business.util.DepartmentUtil;
import com.suteng.shiro.business.util.PersonUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.business.vo.CustContactConditionVo;
import com.suteng.shiro.business.vo.CustPersonConditionVo;
import com.suteng.shiro.business.vo.CustProjectConditionVo;
import com.suteng.shiro.framework.easypoi.ExcelUtil;
import com.suteng.shiro.framework.easypoi.bean.ContactExcel;
import com.suteng.shiro.framework.easypoi.bean.PersonExcel;
import com.suteng.shiro.framework.easypoi.bean.ProjectExcel;
import com.suteng.shiro.framework.object.PageResult;
import com.suteng.shiro.framework.object.ResponseVO;
import com.suteng.shiro.util.ResultUtil;
import org.apache.commons.collections4.ListUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 * 客户管理
 *
 * @date 2018/4/24 14:37
 * @since 1.0
 */
@RestController
@RequestMapping("/custmgt")
public class RestCustMgtController {
    @Value("${web.person-icon-upload-Uri}")
    private String path;
    @Autowired
    private CustPersonService custPersonService;
    @Autowired
    private CustProjectService custProjectService;
    @Autowired
    private CustContactService custContactService;
    @Autowired
    private CustPersonRelationService custPersonRelationService;
    @Autowired
    private CustProjectRelationService custProjectRelationService;
    @Autowired
    private SysUserService userService;

    @RequestMapping("/person/uploadIcon")
    public ResponseVO uploadIcon(@RequestParam("file") MultipartFile file,@RequestParam("id") Long id) {
        try{
            if (file.isEmpty()) {
               return ResultUtil.error("文件为空");
            }
            String fileName = file.getOriginalFilename();  // 文件名
            String suffixName = fileName.substring(fileName.lastIndexOf(".")+1);  // 后缀名
            if(!suffixName.equals("jpg")&&!suffixName.equals("png")&&!suffixName.equals("jpeg")){
                return ResultUtil.error("图片格式不支持");
            }
            File dest = new File(path + id+"."+suffixName);
            try {
                file.transferTo(dest);
            } catch (IOException e) {
                e.printStackTrace();
            }
            CustPersonEntity entity=new CustPersonEntity();
            entity.setId(id);
            entity.setIcon(id+"."+suffixName);
            custPersonService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error(ResponseStatus.ERROR);
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @RequiresPermissions("custmgt:persons")
    @PostMapping("/person/list")
    public PageResult personList(CustPersonConditionVo vo) {
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:person:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:person:dept");
        if(all){
            vo.getCustPersonEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustPersonEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else {
            Long userId = (Long) subject.getPrincipal();
            vo.getCustPersonEntity().setRegister(userId);
        }
        PageInfo<CustPersonEntity> pageInfo = custPersonService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @PostMapping("/person/visitPersonList")
    public ResponseVO visitPersonList() {
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        List<CustPersonEntity> list = custPersonService.findVisitPersonList(userId);
        return ResultUtil.success(null, list);
    }

    @RequiresPermissions("custmgt:persons")
    @GetMapping("/persons")
    public ModelAndView squareList(CustPersonConditionVo vo) {
        //这里不进行分页,取最大
        vo.setPageSize(100000);
        Map<String, Object> model = new HashMap<String, Object>();
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:person:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:person:dept");
        if(all){
            vo.getCustPersonEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustPersonEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else {
            Long userId = (Long) subject.getPrincipal();
            vo.getCustPersonEntity().setRegister(userId);
        }
        PageInfo<CustPersonEntity> persons=custPersonService.findPageBreakByCondition(vo);
        List<List<CustPersonEntity>> list=null;
        if(persons!=null){
          List<List<CustPersonEntity>> pList= ListUtils.partition(persons.getList(),9);
            model.put("persons",pList);
        }
        //model.put("persons",persons==null?null:persons.getList());
        model.put("name",vo.getCustPersonEntity().getName());
        return new ModelAndView("/custmgt/person_square_list", model);
    }

    @GetMapping(value = "/person/listAll")
    public ResponseVO listAll(CustPersonEntity vo) {
        List<CustPersonEntity> persons=custPersonService.listByEntity(vo);
        return ResultUtil.success(null, persons);
    }

    @RequiresPermissions("custmgt:persons")
    @RequestMapping("/person/chooseView")
    public ModelAndView personChooseView() {
        Map<String, String> model = new HashMap<String, String>();
        return new ModelAndView("/custmgt/person_choose_list", model);
    }

    @RequiresPermissions("custmgt:persons")
    @RequestMapping("/person/chooseViewByProject")
    public ModelAndView chooseViewByProject() {
        Map<String, String> model = new HashMap<String, String>();
        return new ModelAndView("/custmgt/project_person_choose_list", model);
    }

    @RequiresPermissions("custmgt:persons")
    @RequestMapping("/person/view/{id}")
    public ModelAndView personView(@PathVariable Long id) {
        Map<String, Object> model = new HashMap<String, Object>();
        CustPersonEntity personEntity=custPersonService.getByPrimaryKey(id);
        model.put("personEntity",personEntity);
        model.put("operation","view");
        return new ModelAndView("/custmgt/person_view", model);
    }

    @RequestMapping("/person/personRelationList")
    public ResponseVO personRelationList(Long sourceId) {
        List<CustPersonEntity> list= custPersonService.findPersonRelationList(sourceId);
        return ResultUtil.success(null, list);
    }

    @RequestMapping("/person/personRelationListByProjectId")
    public ResponseVO personRelationListByProjectId(Long projectId) {
        List<CustPersonEntity> list= custPersonService.findPersonRelationListByProjectId(projectId);
        return ResultUtil.success(null, list);
    }

    @RequestMapping(value = "/person/chooseList")
    public PageResult personChooseList(CustPersonConditionVo vo) {
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:person:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:person:dept");
        if(all){
            vo.getCustPersonEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustPersonEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            vo.getCustPersonEntity().setRegister(userId);
        }
        PageInfo<CustPersonEntity> pageInfo=custPersonService.findPageChoosePerson(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequestMapping(value = "/person/chooseListByProject")
    public PageResult personChooseListByProject(CustPersonConditionVo vo) {
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:person:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:person:dept");
        if(all){
            vo.getCustPersonEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustPersonEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            vo.getCustPersonEntity().setRegister(userId);
        }
        PageInfo<CustPersonEntity> pageInfo=custPersonService.findPageChoosePersonByProject(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("custmgt:person:add")
    @PostMapping(value = "/person/add")
    public ResponseVO personAdd(CustPersonEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            custPersonService.insert(entity);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"custmgt:person:batchDelete", "custmgt:person:delete"}, logical = Logical.OR)
    @PostMapping(value = "/person/remove")
    public ResponseVO personRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            custPersonService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个客户信息");
    }

    @RequiresPermissions("custmgt:person:edit")
    @PostMapping("/person/get/{id}")
    public ResponseVO personGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.custPersonService.getByPrimaryKey(id));
    }

    @RequiresPermissions("custmgt:person:edit")
    @PostMapping("/person/edit")
    public ResponseVO personEdit(CustPersonEntity entity) {
        try {
            custPersonService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }
    @PostMapping(value = "/person/deletePersonRelation")
    public ResponseVO deletePersonRelation(Long sourceId,Long[] destIds) {
        if (null == destIds) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : destIds) {
            custPersonRelationService.deletePersonRelationByDestId(sourceId,id);
        }
        return ResultUtil.success("");
    }


    @GetMapping("/person/exportExcel")
    public void exportExcelByPerson(HttpServletResponse response) {
        //这里不进行分页,取最大
        CustPersonConditionVo vo=new CustPersonConditionVo();
        vo.setPageSize(100000);
        Map<String, Object> model = new HashMap<String, Object>();
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:person:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:person:dept");
        if(all){
            vo.getCustPersonEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustPersonEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else {
            Long userId = (Long) subject.getPrincipal();
            vo.getCustPersonEntity().setRegister(userId);
        }
        PageInfo<CustPersonEntity> persons=custPersonService.findPageBreakByCondition(vo);
        List<PersonExcel> excelList = new ArrayList<>();
        if(persons!=null&&persons.getList()!=null){
            for(CustPersonEntity person:persons.getList()){
                PersonExcel p=new PersonExcel();
                try {
                    BeanUtils.copyProperties(person.getCustPerson(), p);
                    excelList.add(p);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //导出操作
        ExcelUtil.exportExcel(excelList, PersonExcel.class, "客户信息.xls", response);
    }



    /****              项目信息开始                   **/
    @RequiresPermissions("custmgt:projects")
    @PostMapping("/project/list")
    public PageResult projectList(CustProjectConditionVo vo) {
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:project:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:project:dept");
        if(all){
            vo.getCustProjectEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustProjectEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else{
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            vo.getCustProjectEntity().setRegister(userId);
        }
        PageInfo<CustProjectEntity> pageInfo = custProjectService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequestMapping(value = "/project/listAll")
    public ResponseVO projectListAll(CustProjectEntity vo) {
        List<CustProjectEntity> projects=custProjectService.listByEntity(vo);
        return ResultUtil.success(null, projects);
    }

    @RequestMapping("/project/projectRelationList")
    public ResponseVO projectRelationList(Long personId) {
        List<CustProjectEntity> list= custProjectService.findProjectRelationList(personId);
        return ResultUtil.success(null, list);
    }

    @RequestMapping(value = "/project/chooseList")
    public PageResult projectChooseList(CustProjectConditionVo vo) {
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:project:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:project:dept");
        if(all){
            vo.getCustProjectEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustProjectEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else{
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            vo.getCustProjectEntity().setRegister(userId);
        }
        PageInfo<CustProjectEntity> pageInfo=custProjectService.findPageChooseProject(vo);
        return ResultUtil.tablePage(pageInfo);
    }


    @RequiresPermissions("custmgt:projects")
    @RequestMapping("/project/chooseView")
    public ModelAndView projectChooseView() {
        Map<String, String> model = new HashMap<String, String>();
        return new ModelAndView("/custmgt/project_choose_list", model);
    }

    @RequiresPermissions("custmgt:project:add")
    @PostMapping(value = "/project/add")
    public ResponseVO projectAdd(CustProjectEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            custProjectService.insert(entity);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"custmgt:project:batchDelete", "custmgt:project:delete"}, logical = Logical.OR)
    @PostMapping(value = "/project/remove")
    public ResponseVO projectRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            custProjectService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个项目信息");
    }

    @RequiresPermissions("custmgt:project:edit")
    @PostMapping("/project/get/{id}")
    public ResponseVO projectGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.custProjectService.getByPrimaryKey(id));
    }

    @RequiresPermissions("custmgt:projects")
    @RequestMapping("/project/view/{id}")
    public ModelAndView projectView(@PathVariable Long id) {
        Map<String, Object> model = new HashMap<String, Object>();
        CustProjectEntity projectEntity=custProjectService.getByPrimaryKey(id);
        model.put("projectEntity",projectEntity);
        return new ModelAndView("/custmgt/project_view", model);
    }

    @RequiresPermissions("custmgt:project:edit")
    @PostMapping("/project/edit")
    public ResponseVO projectEdit(CustProjectEntity entity) {
        try {
            custProjectService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @PostMapping(value = "/project/deletePorjectRelation")
    public ResponseVO deletePorjectRelation(Long personId,Long[] projectIds) {
        if (null == projectIds) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : projectIds) {
            custProjectRelationService.deleteProjectRelationByProjectIdAndPersonId(personId,id);
        }
        return ResultUtil.success("");
    }

    @PostMapping(value = "/project/deletePersonRelationByProjectId")
    public ResponseVO deletePersonRelationByProjectId(Long projectId,Long[] personIds) {
        if (null == personIds) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : personIds) {
            custProjectRelationService.deleteProjectRelationByProjectIdAndPersonId(id,projectId);
        }
        return ResultUtil.success("");
    }

    @GetMapping("/project/exportExcel")
    public void exportExcelByProject(HttpServletResponse response) {
        CustProjectConditionVo vo=new CustProjectConditionVo();
        vo.setPageSize(100000);
        Subject subject = SecurityUtils.getSubject();
        //最高权限
        boolean all=subject.isPermitted("custmgt:project:all");
        //部门共享
        boolean dept=subject.isPermitted("custmgt:project:dept");
        if(all){
            vo.getCustProjectEntity().setRegister(null);
        }else if(dept){
            Long userId = (Long) subject.getPrincipal();
            User user= userService.getByPrimaryKey(userId);
            if(user!=null&&user.getDepId()!=null){
                vo.getCustProjectEntity().setRegister(null);
                vo.setDeptId(user.getDepId().longValue());
            }
        }else{
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            vo.getCustProjectEntity().setRegister(userId);
        }
        PageInfo<CustProjectEntity> pageInfo = custProjectService.findPageBreakByCondition(vo);
        List<ProjectExcel> excelList = new ArrayList<>();
        if(pageInfo!=null&&pageInfo.getList()!=null){
            for(CustProjectEntity projectEntity:pageInfo.getList()){
                ProjectExcel p=new ProjectExcel();
                try {
                    BeanUtils.copyProperties(projectEntity.getCustProject(), p);
                    if(projectEntity.getDepartment()!=null){
                        p.setDepartmentName(DepartmentUtil.getDepartmentName(projectEntity.getDepartment()));
                    }
                    if(projectEntity.getPm()!=null){
                        p.setPmName(UserUtil.getUserNickName(projectEntity.getPm()));
                    }
                    excelList.add(p);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //导出操作
        ExcelUtil.exportExcel(excelList, ProjectExcel.class, "项目信息.xls", response);
    }


    /****              联系信息开始                   **/
    @RequiresPermissions("custmgt:contacts")
    @PostMapping("/contact/list")
    public PageResult contactList(CustContactConditionVo vo) {
        PageInfo<CustContactEntity> pageInfo = custContactService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequestMapping(value = "/contact/listAll")
    public ResponseVO contactListAll(CustContactEntity vo) {
        List<CustContactEntity> contacts=custContactService.listByEntity(vo);
        return ResultUtil.success(null, contacts);
    }

    /**
     * 列表
     * @param vo
     * @return
     */
    @RequestMapping(value = "/contact/chooseList")
    public PageResult contactChooseList(CustContactConditionVo vo) {
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        vo.getCustContactEntity().setRegister(userId);
        PageInfo<CustContactEntity> pageInfo=custContactService.findPageChooseContact(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    /**
     * 视图
     * @return
     */
    @RequestMapping("/contact/chooseView")
    public ModelAndView contactChooseView() {
        Map<String, String> model = new HashMap<String, String>();
        return new ModelAndView("/custmgt/contact_choose_list", model);
    }
    @RequiresPermissions("custmgt:contact:add")
    @PostMapping(value = "/contact/add")
    public ResponseVO contactAdd(CustContactEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            custContactService.insert(entity);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"custmgt:contact:batchDelete", "custmgt:contact:delete"}, logical = Logical.OR)
    @PostMapping(value = "/contact/remove")
    public ResponseVO contactRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            custContactService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个联系信息");
    }

    @RequiresPermissions("custmgt:contact:edit")
    @PostMapping("/contact/get/{id}")
    public ResponseVO contactGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.custContactService.getByPrimaryKey(id));
    }

    @RequiresPermissions("custmgt:contacts")
    @RequestMapping("/contact/view/{id}")
    public ModelAndView contactView(@PathVariable Long id) {
        Map<String, Object> model = new HashMap<String, Object>();
        CustContactEntity contactEntity=custContactService.getByPrimaryKey(id);
        model.put("contactEntity",contactEntity);
        return new ModelAndView("/custmgt/contact_view", model);
    }
    @RequiresPermissions("custmgt:contact:edit")
    @PostMapping("/contact/edit")
    public ResponseVO contactEdit(CustContactEntity entity) {
        try {
            custContactService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @PostMapping(value = "/contact/deletePersonIds")
    public ResponseVO deleteContactPersonIds(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            CustContactEntity contact=custContactService.getByPrimaryKey(id);
            if(contact!=null){
                contact.setPersonId(null);
                custContactService.update(contact);
            }
        }
        return ResultUtil.success("");
    }

    @GetMapping("/contact/exportExcel")
    public void exportExcelByContact(HttpServletResponse response) {
        Subject subject = SecurityUtils.getSubject();
        Long userId = (Long) subject.getPrincipal();
        CustContactEntity entity=new CustContactEntity();
        entity.setRegister(userId);
        List<CustContactEntity> contacts=custContactService.listByEntity(entity);
        List<ContactExcel> excelList = new ArrayList<>();
        if(contacts!=null){
            for(CustContactEntity contactEntity:contacts){
                ContactExcel c=new ContactExcel();
                try {
                    BeanUtils.copyProperties(contactEntity.getCustContact(), c);
                    if(contactEntity.getPersonId()!=null){
                        c.setPersonName(PersonUtil.getCustPersonName(contactEntity.getPersonId()));
                    }
                    excelList.add(c);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //导出操作
        ExcelUtil.exportExcel(excelList, ContactExcel.class, "联系信息.xls", response);
    }
    /**                    config 相关                   **/
    @Autowired
    private SysUserRoleService sysUserRoleService;

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private ShiroService shiroService;
    @Autowired
    private SysConfigService sysConfigService;

    /**
     * 全局处理隐藏
     * @param globalCustMgtControl
     * @return
     */
    @RequiresPermissions("custmgt:config")
    @RequestMapping(value = "/config/globalCustMgtControl")
    public ResponseVO globalCustMgtControl(boolean globalCustMgtControl) {
        if(globalCustMgtControl){
            Role vo=new Role();
            vo.setName("role:custmgt");//客户管理控制
            Role role= sysRoleService.getOneByEntity(vo);
            if(role!=null){
                sysUserRoleService.removeByRoleId(role.getId());
                Config config=new Config();
                config.setCode("globalCustMgtControl");
                config= sysConfigService.getOneByEntity(config);
                config.setValue("1");
                sysConfigService.updateSelective(config);
                shiroService.reloadAuthorizingByRoleId(role.getId());
            }
        }else{
            Role vo=new Role();
            vo.setName("role:custmgt");//客户管理控制
            Role role= sysRoleService.getOneByEntity(vo);
            if(role!=null) {
                sysUserRoleService.addAllUserRole(role.getId());
                Config config=new Config();
                config.setCode("globalCustMgtControl");
                config= sysConfigService.getOneByEntity(config);
                config.setValue("0");
                sysConfigService.updateSelective(config);
                shiroService.reloadAuthorizingByRoleId(role.getId());
            }
        }
        return ResultUtil.success("");
    }

    @RequiresPermissions("custmgt:config")
    @GetMapping("/config")
    public ModelAndView custConfig() {
        Map<String,Object> object=new HashMap<>();
        Config vo=new Config();
        vo.setCode("globalCustMgtControl");
        Config config=sysConfigService.getOneByEntity(vo);
        object.put("globalCustMgtControl",config);
        return ResultUtil.view("custmgt/config",object);
    }


}
