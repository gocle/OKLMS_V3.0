package kr.co.gocle.oklms.comm.job;

import java.text.SimpleDateFormat;

import kr.co.gocle.aunuri.service.AunuriLinkService;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.link.service.LinkService;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
//import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;


public class AunuriLinkJob extends QuartzJobBean{
	
	public Logger log = Logger.getLogger(getClass());
	
	
	private LinkService  linkService;
	
	public void setLinkService(LinkService linkService) { this.linkService = linkService; }
	 
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		// TODO Auto-generated method stub
		//System.out.println("Start - QuartzJobBean :: " + getClass().getName() + ", " +DateTimeUtil.getDateTimeByPattern("yyyy-MM-dd HH:mm:ss"));
		
		long time = System.currentTimeMillis();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
        System.out.println(" link Cron trigger 2 (1 minute): current time = " + sdf.format(time));
		
		try {
			// 제적 및 졸업상태 업데이트 및 주차별 NCS 업데이트
			// 수강생 추가. 20180201
			linkService.excuteAunuriBatch();
			linkService.excuteStdBatch();
			linkService.excuteAttendBatch();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
	}

}
