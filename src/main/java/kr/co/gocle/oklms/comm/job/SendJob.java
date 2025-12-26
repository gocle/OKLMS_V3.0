package kr.co.gocle.oklms.comm.job;

import java.text.SimpleDateFormat;
import java.util.List;

import kr.co.gocle.aunuri.service.AunuriLinkService;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekVO;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.commbiz.mail.service.MailService;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.link.service.LinkService;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
//import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;


public class SendJob extends QuartzJobBean{
	
	public Logger log = Logger.getLogger(getClass());
	
	
	private MailService  mailService;
	
	public void setMailService(MailService mailService) { this.mailService = mailService; }
	 
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		// TODO Auto-generated method stub
		//System.out.println("Start - QuartzJobBean :: " + getClass().getName() + ", " +DateTimeUtil.getDateTimeByPattern("yyyy-MM-dd HH:mm:ss"));
		
		long time = System.currentTimeMillis();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
        System.out.println(" send Cron trigger 2 (1 minute): current time = " + sdf.format(time));
		
        String sendDate = sdf.format(time);
        
        
        
		try {
			
			List<MailVO> resultList = mailService.listSendMaster(sendDate);
			System.out.println(" listSendMaster size = " + resultList.size());
			int iResult = mailService.excuteSendBatch(sendDate);
			System.out.println(" excuteSendBatch success = " + iResult);
			//mailService.excuteSendBatch();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
	}

}
