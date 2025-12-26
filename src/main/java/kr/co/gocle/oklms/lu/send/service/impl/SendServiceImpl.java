package kr.co.gocle.oklms.lu.send.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.commbiz.util.AtchFileUtil;
import kr.co.gocle.oklms.lu.activity.service.ActivityService;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO; 
import kr.co.gocle.oklms.lu.activity.vo.MemberVO;
import kr.co.gocle.oklms.lu.activity.vo.SubjweekStdVO;
import kr.co.gocle.oklms.lu.grade.service.GradeService;
import kr.co.gocle.oklms.lu.send.service.SendService;
import kr.co.gocle.oklms.lu.send.vo.SendVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

@Transactional(rollbackFor=Exception.class)
@Service("sendService")
public class SendServiceImpl extends EgovAbstractServiceImpl implements SendService {

	@Resource(name = "sendMapper")
    private SendMapper sendMapper;

	
	@Override
	public List<SendVO> listSendCdp(SendVO sendVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSendCdp(sendVO);
	}
	
	
	@Override
	public List<SendVO> listSend(SendVO sendVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSend(sendVO);
	}
	
	@Override
	public List<SendVO> listSendCcn(SendVO sendVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSendCcn(sendVO);
	}
	
	@Override
	public List<MailVO> listSendEmailResult(MailVO mailVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSendEmailResult(mailVO);
	}
	
	@Override
	public List<MailVO> listSendSmsResult(MailVO mailVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSendSmsResult(mailVO);
	}
	
	
	
	@Override
	public List<SendVO> listSendResult(SendVO sendVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSendResult(sendVO);
	}
	
	@Override
	public List<SendVO> listSendResultDetail(SendVO sendVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSendResultDetail(sendVO);
	}
	
	@Override
	public int deleteSendMaster(MailVO mailVO) throws Exception {
		// TODO Auto-generated method stub
		int iResult = 0;
		if(mailVO.getSendSeqs().length > 0){
			for(int i=0; i < mailVO.getSendSeqs().length; i++){
				iResult += sendMapper.deleteSendMaster(mailVO.getSendSeqs()[i]);
			}
		}
		return iResult;
	}
	
	@Override
	public MailVO getSendMaster(MailVO mailVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.getSendMaster(mailVO);
	}
	
	@Override
	public List<MailVO> listSendDetail(MailVO mailVO)
			throws Exception {
		// TODO Auto-generated method stub
		return sendMapper.listSendDetail(mailVO);
	}
	
}
