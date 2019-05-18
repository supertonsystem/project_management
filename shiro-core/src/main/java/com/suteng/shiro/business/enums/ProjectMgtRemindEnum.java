package com.suteng.shiro.business.enums;

/**
 *  截至时间提醒
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public enum ProjectMgtRemindEnum {
    /**
     * 天数|警告等级
     */
    INFO(5, "info"), WARNING(1, "warning"), DANGER(0, "danger"),UNKNOW(-1,"");
    private int day;
    private String grade;

    ProjectMgtRemindEnum(int day, String grade) {
        this.day = day;
        this.grade = grade;
    }

    public static ProjectMgtRemindEnum getProjectMgtRemind(Integer day) {
        if (day == null) {
            return UNKNOW;
        }
        for (ProjectMgtRemindEnum projectMgtRemind : ProjectMgtRemindEnum.values()) {
            if (projectMgtRemind.getDay() == day) {
                return projectMgtRemind;
            }
        }
        return UNKNOW;
    }

    public static ProjectMgtRemindEnum getProjectMgtRemind(String day) {
        if (day == null) {
            return UNKNOW;
        }
        if("info".equals(day)){
            return INFO;
        }
        if("warning".equals(day)){
            return WARNING;
        }
        if("danger".equals(day)){
            return DANGER;
        }
        return UNKNOW;
    }

    public int getDay() {
        return day;
    }

    public String getGrade() {
        return grade;
    }
}
