package com.suteng.shiro.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftConsumeDetailEntity;
import com.suteng.shiro.business.entity.GiftConsumeEntity;
import com.suteng.shiro.business.entity.GiftRepertoryEntity;
import com.suteng.shiro.business.entity.GiftTypeEntity;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.GiftConsumeDetailService;
import com.suteng.shiro.business.service.GiftConsumeService;
import com.suteng.shiro.business.service.GiftRepertoryService;
import com.suteng.shiro.business.service.GiftTypeService;
import com.suteng.shiro.business.util.PersonUtil;
import com.suteng.shiro.business.util.ProjectUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.business.vo.GiftConsumeConditionVo;
import com.suteng.shiro.business.vo.GiftConsumeDetailConditionVo;
import com.suteng.shiro.business.vo.GiftRepertoryConditionVo;
import com.suteng.shiro.business.vo.GiftTypeConditionVo;
import com.suteng.shiro.framework.easypoi.ExcelUtil;
import com.suteng.shiro.framework.easypoi.bean.GiftConsumeDetailExcel;
import com.suteng.shiro.framework.easypoi.bean.GiftRepertoryExcel;
import com.suteng.shiro.framework.object.PageResult;
import com.suteng.shiro.framework.object.ResponseVO;
import com.suteng.shiro.util.FastJsonUtil;
import com.suteng.shiro.util.ResultUtil;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * 客户管理
 *
 * @date 2018/4/24 14:37
 * @since 1.0
 */
@RestController
@RequestMapping("/giftmgt")
public class RestGiftMgtController {
    @Autowired
    private GiftTypeService giftTypeService;


    @RequiresPermissions("giftmgt:types")
    @PostMapping("/type/list")
    public PageResult typeList(GiftTypeConditionVo vo) {
        PageInfo<GiftTypeEntity> pageInfo = giftTypeService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("giftmgt:type:add")
    @PostMapping(value = "/type/add")
    public ResponseVO typeAdd(GiftTypeEntity entity) {
        try {
            giftTypeService.insert(entity);
            return ResultUtil.success("成功", entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"giftmgt:type:batchDelete", "giftmgt:type:delete"}, logical = Logical.OR)
    @PostMapping(value = "/type/remove")
    public ResponseVO typeRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            giftTypeService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个客户信息");
    }

    @RequiresPermissions("giftmgt:type:edit")
    @PostMapping("/type/get/{id}")
    public ResponseVO typeGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.giftTypeService.getByPrimaryKey(id));
    }

    @RequiresPermissions("giftmgt:type:edit")
    @PostMapping("/type/edit")
    public ResponseVO typeEdit(GiftTypeEntity entity) {
        try {
            giftTypeService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    /****              库存开始                   **/

    @Autowired
    private GiftRepertoryService giftRepertoryService;

    @RequiresPermissions("giftmgt:repertorys")
    @PostMapping("/repertory/list")
    public PageResult repertoryList(GiftRepertoryConditionVo vo) {
        PageInfo<GiftRepertoryEntity> pageInfo = giftRepertoryService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequestMapping("/repertory/listAll")
    public ResponseVO listAll(GiftRepertoryEntity vo) {
        List<GiftRepertoryEntity> repertorys = giftRepertoryService.listByEntity(vo);
        return ResultUtil.success(null, repertorys);
    }

    @GetMapping(value = "/repertory/availableListAll")
    public ResponseVO availableListAll() {
        List<GiftRepertoryEntity> repertorys = giftRepertoryService.availableRepertoryList();
        return ResultUtil.success(null, repertorys);
    }

    @RequiresPermissions("giftmgt:repertory:add")
    @PostMapping(value = "/repertory/add")
    public ResponseVO repertoryAdd(GiftRepertoryEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            giftRepertoryService.insert(entity);
            return ResultUtil.success("成功", entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions("giftmgt:repertory:add")
    @PostMapping(value = "/repertory/addRepertoryNum")
    public ResponseVO repertoryAdd(Long id, Long repertoryNum) {
        try {
            GiftRepertoryEntity entity = giftRepertoryService.getByPrimaryKey(id);
            entity.setRepertory(entity.getRepertory() + repertoryNum);
            entity.setSum(entity.getSum() + repertoryNum);
            Double addAmount = repertoryNum * entity.getUnit();
            entity.setAmount(entity.getAmount() + addAmount);
            StringBuilder str=new StringBuilder();
            str.append("新增库存数:"+repertoryNum+",");
            str.append("时间:"+ DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss")+",");
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            String nickName=UserUtil.getUserNickName(userId);
            str.append("执行人:"+ nickName+"\r\n");
            entity.setRemark(entity.getRemark()+str.toString());
            giftRepertoryService.updateSelective(entity);
            return ResultUtil.success("成功", entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"giftmgt:repertory:batchDelete", "giftmgt:repertory:delete"}, logical = Logical.OR)
    @PostMapping(value = "/repertory/remove")
    public ResponseVO repertoryRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            giftRepertoryService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个联系信息");
    }

    @PostMapping("/repertory/get/{id}")
    public ResponseVO repertoryGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.giftRepertoryService.getByPrimaryKey(id));
    }

    @RequestMapping("/repertory/view/{id}")
    public ModelAndView repertoryView(@PathVariable Long id) {
        GiftRepertoryEntity entity = this.giftRepertoryService.getByPrimaryKey(id);
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("repertory", entity);
        return ResultUtil.view("giftmgt/repertory_view", model);
    }


    @RequiresPermissions("giftmgt:repertory:edit")
    @PostMapping("/repertory/edit")
    public ResponseVO repertoryEdit(GiftRepertoryEntity entity) {
        try {
            giftRepertoryService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @RequiresPermissions("giftmgt:repertorys")
    @GetMapping("/repertory/exportExcel")
    public void exportExcelByRepertory(HttpServletResponse response) {
        List<GiftRepertoryEntity> repertorys = giftRepertoryService.listAll();
        List<GiftRepertoryExcel> excelList = new ArrayList<>();
        if (repertorys != null) {
            for (GiftRepertoryEntity giftRepertoryEntity : repertorys) {
                GiftRepertoryExcel g = new GiftRepertoryExcel();
                try {
                    BeanUtils.copyProperties(giftRepertoryEntity.getGiftRepertory(), g);
                    if (giftRepertoryEntity.getTypeId() != null) {
                        GiftTypeEntity gifttype = giftTypeService.getByPrimaryKey(giftRepertoryEntity.getTypeId());
                        if (gifttype != null) {
                            g.setTypeName(gifttype.getType());
                        }
                    }
                    excelList.add(g);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //导出操作
        ExcelUtil.exportExcel(excelList, GiftRepertoryExcel.class, "库存信息.xls", response);
    }

    /****              礼品领用开始                   **/

    @Autowired
    private GiftConsumeService giftConsumeService;

    @RequiresPermissions("giftmgt:consumes")
    @PostMapping("/consume/list")
    public PageResult consumeList(GiftConsumeConditionVo vo) {
        Subject subject = SecurityUtils.getSubject();
        //如果没审核权限 则只显示自己创建的记录
        boolean auditPerm = subject.isPermitted("giftmgt:consume:audit");
        if (auditPerm) {
            vo.getGiftConsumeEntity().setRegister(null);
        }
        PageInfo<GiftConsumeEntity> pageInfo = giftConsumeService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("giftmgt:consume:add")
    @PostMapping(value = "/consume/add")
    public ResponseVO consumeAdd(GiftConsumeEntity entity, String detailList) {
        try {
            List<GiftConsumeDetailEntity> details = FastJsonUtil.toList(detailList, GiftConsumeDetailEntity.class);
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            String result = giftConsumeService.insertConsumeAndDetailList(entity, details);
            if (result != null) {
                return ResultUtil.error(result);
            }
            return ResultUtil.success("成功", entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    /**
     * 提交 状态修改至“申请中”
     *
     * @param entity
     * @param detailList
     * @return
     */
    @RequiresPermissions("giftmgt:consume:add")
    @PostMapping(value = "/consume/submit")
    public ResponseVO consumeSubmit(GiftConsumeEntity entity, String detailList) {
        try {
            List<GiftConsumeDetailEntity> details = FastJsonUtil.toList(detailList, GiftConsumeDetailEntity.class);
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            //修改为"申请中"
            entity.setStatus(1);
            String result = giftConsumeService.updateConsumeAndDetailList(entity, details);
            if (result != null) {
                return ResultUtil.error(result);
            }
            return ResultUtil.success("成功", entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"giftmgt:consume:batchDelete", "giftmgt:consume:delete"}, logical = Logical.OR)
    @PostMapping(value = "/consume/remove")
    public ResponseVO consumeRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            giftConsumeService.removeConsumeAndDetailList(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个联系信息");
    }

    @RequiresPermissions("giftmgt:consume:edit")
    @PostMapping("/consume/get/{id}")
    public ResponseVO consumeGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.giftConsumeService.getByPrimaryKey(id));
    }

    @RequestMapping("/consume/view/{id}")
    public ModelAndView consumeView(@PathVariable Long id) {
        GiftConsumeEntity entity = this.giftConsumeService.getByPrimaryKey(id);
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("consume", entity);
        model.put("operate", "view");
        return ResultUtil.view("giftmgt/consume_view", model);
    }

    @RequiresPermissions("giftmgt:consume:edit")
    @PostMapping("/consume/edit")
    public ResponseVO consumeEdit(GiftConsumeEntity entity, String detailList) {
        try {
            List<GiftConsumeDetailEntity> details = FastJsonUtil.toList(detailList, GiftConsumeDetailEntity.class);
            String result = giftConsumeService.updateConsumeAndDetailList(entity, details);
            if (result != null) {
                return ResultUtil.error(result);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    /****              送礼开始                   **/

    @Autowired
    private GiftConsumeDetailService giftConsumeDetailService;

    @RequiresPermissions("giftmgt:consumeDetails")
    @PostMapping("/consumeDetail/list")
    public PageResult consumeDetailList(GiftConsumeDetailConditionVo vo) {

        Subject subject = SecurityUtils.getSubject();
        boolean perm = subject.isPermitted("giftmgt:consumeDetail:all");
        if (perm) {
            vo.getGiftConsumeDetailEntity().setRegister(null);
        } else {
            Long userId = (Long) subject.getPrincipal();
            vo.getGiftConsumeDetailEntity().setRegister(userId);
        }
        PageInfo<GiftConsumeDetailEntity> pageInfo = giftConsumeDetailService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("giftmgt:consumeDetails")
    @PostMapping("/consumeDetail/listAll")
    public ResponseVO consumeDetailListAll(GiftConsumeDetailEntity vo) {
        List<GiftConsumeDetailEntity> entities = giftConsumeDetailService.listByEntity(vo);
        return ResultUtil.success("成功", entities);
    }

    @RequiresPermissions("giftmgt:consumeDetail:add")
    @PostMapping(value = "/consumeDetail/add")
    public ResponseVO consumeAdd(GiftConsumeDetailEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            giftConsumeDetailService.insert(entity);
            return ResultUtil.success("成功", entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"giftmgt:consumeDetail:batchDelete", "giftmgt:consumeDetail:delete"}, logical = Logical.OR)
    @PostMapping(value = "/consumeDetail/remove")
    public ResponseVO consumeDetailRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            giftConsumeDetailService.removeByLock(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个联系信息");
    }

    @RequiresPermissions("giftmgt:consumeDetail:edit")
    @PostMapping("/consumeDetail/get/{id}")
    public ResponseVO consumeDetailGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.giftConsumeDetailService.getByPrimaryKey(id));
    }

    @RequiresPermissions("giftmgt:consumeDetail:edit")
    @RequestMapping("/consumeDetail/edit")
    public ResponseVO consumeDetailEdit(GiftConsumeDetailEntity entity) {
        try {
            //更新库存 需要联动
            if (entity.getNum() != null) {
                String result = giftConsumeDetailService.updateDetailAndConsumeByNum(entity.getId(), entity.getNum());
                if (result != null) {
                    return ResultUtil.error(result);
                }
            } else if (entity.getRepertoryId() != null) {
                String result = giftConsumeDetailService.updateDetailAndConsumeByRepertoryId(entity.getId(), entity.getRepertoryId());
                if (result != null) {
                    return ResultUtil.error(result);
                }
            } else {
                giftConsumeDetailService.updateSelective(entity);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @RequestMapping("/consumeDetail/updateStatus")
    public ResponseVO updateConsumeDetailStatus(Long consumeId, Long[] ids, Integer status) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        if (null == status) {
            return ResultUtil.error(500, "请选择状态");
        }
        for (Long id : ids) {
            if (status == 2) {
                //退回比较特殊，涉及库存变动
                giftConsumeDetailService.updateDrawStatusByLock(id, true);
            } else {
                GiftConsumeDetailEntity entity = new GiftConsumeDetailEntity();
                entity.setId(id);
                entity.setStatus(status);
                giftConsumeDetailService.updateSelective(entity);
            }
        }
        Long count = giftConsumeDetailService.findOperabilityCountByConsumeId(consumeId);
        //更新状态为已完成
        if (count == 0) {
            GiftConsumeEntity entity = new GiftConsumeEntity();
            entity.setStatus(2);
            entity.setId(consumeId);
            giftConsumeService.updateSelective(entity);
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @RequiresPermissions("giftmgt:consumeDetails")
    @GetMapping("/consumeDetail/exportExcel")
    public void exportExcelByConsumeDetail(HttpServletResponse response) {
        GiftConsumeDetailConditionVo vo = new GiftConsumeDetailConditionVo();
        vo.setPageSize(100000);
        Subject subject = SecurityUtils.getSubject();
        boolean perm = subject.isPermitted("giftmgt:consumeDetail:all");
        if (perm) {
            vo.getGiftConsumeDetailEntity().setRegister(null);
        } else {
            Long userId = (Long) subject.getPrincipal();
            vo.getGiftConsumeDetailEntity().setRegister(userId);
        }
        PageInfo<GiftConsumeDetailEntity> pageInfo = giftConsumeDetailService.findPageBreakByCondition(vo);
        List<GiftConsumeDetailExcel> excelList = new ArrayList<>();
        if (pageInfo != null && pageInfo.getList() != null) {
            for (GiftConsumeDetailEntity consumeDetailEntity : pageInfo.getList()) {
                GiftConsumeDetailExcel g = new GiftConsumeDetailExcel();
                try {
                    BeanUtils.copyProperties(consumeDetailEntity.getGiftConsumeDetail(), g);
                    if (consumeDetailEntity.getConsumeId() != null) {
                        GiftConsumeEntity entity = giftConsumeService.getByPrimaryKey(consumeDetailEntity.getConsumeId());
                        if (entity != null) {
                            g.setConsumeName(entity.getTitle());
                        }
                    }
                    if (consumeDetailEntity.getPersonId() != null) {
                        g.setPersonName(PersonUtil.getCustPersonName(consumeDetailEntity.getPersonId()));
                    }
                    if (consumeDetailEntity.getProjectId() != null) {
                        g.setProjectName(ProjectUtil.getCustProjectName(consumeDetailEntity.getProjectId()));
                    }
                    if (consumeDetailEntity.getRepertoryId() != null) {
                        GiftRepertoryEntity repertoryEntity= giftRepertoryService.getByPrimaryKey(consumeDetailEntity.getRepertoryId());
                        g.setRepertoryName(repertoryEntity.getName());
                    }
                    excelList.add(g);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //导出操作
        ExcelUtil.exportExcel(excelList, GiftConsumeDetailExcel.class, "送礼信息.xls", response);
    }

    /**
     * 确认领用
     * 单向
     *
     * @param ids
     * @return
     */
    @RequestMapping("/consumeDetail/updateDrawStatus")
    public ResponseVO updateConsumeDetailDrawStatus(Long consumeId, Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            giftConsumeDetailService.updateDrawStatusByLock(id, false);
        }
        Long count = giftConsumeDetailService.findOperabilityCountByConsumeId(consumeId);
        //更新状态为已完成
        if (count == 0) {
            GiftConsumeEntity entity = new GiftConsumeEntity();
            entity.setStatus(2);
            entity.setId(consumeId);
            giftConsumeService.updateSelective(entity);
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }
}
