package com.suteng.shiro.business.entity;


import com.suteng.shiro.business.entity.activiti.TaskCopy;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:14 2019/4/28
 */
public class ProjectMgtTask {
    private ProjectMgt projectMgt;

    private TaskCopy task;

    public ProjectMgtTask() {
    }

    public ProjectMgtTask(ProjectMgt projectMgt, TaskCopy task) {
        this.projectMgt = projectMgt;
        this.task = task;
    }

    public ProjectMgt getProjectMgt() {
        return projectMgt;
    }

    public void setProjectMgt(ProjectMgt projectMgt) {
        this.projectMgt = projectMgt;
    }

    public TaskCopy getTask() {
        return task;
    }

    public void setTask(TaskCopy task) {
        this.task = task;
    }
}
