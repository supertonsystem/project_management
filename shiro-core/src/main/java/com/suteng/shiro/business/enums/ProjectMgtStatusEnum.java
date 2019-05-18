package com.suteng.shiro.business.enums;

/**
 * 任务状态
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public enum ProjectMgtStatusEnum {
    UNKNOW(0, "未知"),
    PROCEED(1, "进行中"),
    FINISH(2, "已完成");
    private Integer status;
    private String name;

    ProjectMgtStatusEnum(Integer status, String name) {
        this.status = status;
        this.name = name;
    }

    public static ProjectMgtStatusEnum get(Integer status) {
        if (null == status) {
            return UNKNOW;
        }
        ProjectMgtStatusEnum[] enums = ProjectMgtStatusEnum.values();
        for (ProjectMgtStatusEnum anEnum : enums) {
            if (anEnum.getStatus().equals(status)) {
                return anEnum;
            }
        }
        return UNKNOW;
    }

    public Integer getStatus() {
        return status;
    }

    public String getName() {
        return name;
    }
}
