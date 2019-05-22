package com.suteng.shiro.controller;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftTypeEntity;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.GiftTypeService;
import com.suteng.shiro.business.vo.GiftTypeConditionVo;
import com.suteng.shiro.framework.object.PageResult;
import com.suteng.shiro.framework.object.ResponseVO;
import com.suteng.shiro.util.ResultUtil;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
            return ResultUtil.success("成功",entity);
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

}
