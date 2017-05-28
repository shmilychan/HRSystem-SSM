package cn.mldn.travel.task;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import cn.mldn.travel.service.back.ITravelServiceBack;

@Component
public class TravelTask {
	@Resource
	private ITravelServiceBack travelServiceBack ;
	// @Scheduled(cron = "* * * * * ?") // 每晚12点触发
	@Scheduled(cron = "0 0 0 * * ?") // 每秒一触发
	public void runJob() { // 自己定义了一个任务调度执行方法
		this.travelServiceBack.editTask() ;
	}
}
