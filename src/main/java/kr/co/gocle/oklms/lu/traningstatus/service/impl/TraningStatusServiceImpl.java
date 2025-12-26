package kr.co.gocle.oklms.lu.traningstatus.service.impl;
import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.oklms.lu.traningstatus.service.TraningStatusService;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningReportVO;
import kr.co.gocle.oklms.lu.traningstatus.vo.TraningStatusVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; 

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl; 

@Transactional(rollbackFor=Exception.class)
@Service("TraningStatusService")
public class TraningStatusServiceImpl extends EgovAbstractServiceImpl implements TraningStatusService {
	
	@Resource(name = "traningStatusMapper")
    private TraningStatusMapper traningStatusMapper;
	
	@Override
	public TraningStatusVO getProgress(TraningStatusVO traningStatusVO)	throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.getProgress(traningStatusVO);
	}

	@Override
	public List<TraningStatusVO> listTraningStatus(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		 List<TraningStatusVO> data;
		if(traningStatusVO.getSessionMemType().equals("PRT")){
			data = traningStatusMapper.listTraningStatusPrt(traningStatusVO);
		} else if(traningStatusVO.getSessionMemType().equals("COT")){
			data = traningStatusMapper.listTraningStatusCot(traningStatusVO);
		} else if(traningStatusVO.getSessionMemType().equals("CCM")){
			data = traningStatusMapper.listTraningStatusCcm(traningStatusVO);
		} else {
			data = traningStatusMapper.listTraningStatus(traningStatusVO);
		}
		return data;
	}

	@Override
	public List<TraningStatusVO> listTraningStatusDetail(TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		List<TraningStatusVO> data;
		if(traningStatusVO.getSessionMemType().equals("PRT")){
			data = traningStatusMapper.listTraningStatusDetailPrt(traningStatusVO);
		} else if(traningStatusVO.getSessionMemType().equals("COT")){
			data = traningStatusMapper.listTraningStatusDetailCot(traningStatusVO);
		} else if(traningStatusVO.getSessionMemType().equals("CCM")){
			data = traningStatusMapper.listTraningStatusDetailCcm(traningStatusVO);
		} else {
			data = traningStatusMapper.listTraningStatusDetail(traningStatusVO);
		}
		return data;
	}
	
	
	@Override
	public List<TraningStatusVO> listTraningComplete( TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listTraningComplete(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> popupAttendListOff( TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.popupAttendListOff(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> popupAttendListOnlineOff( TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.popupAttendListOnlineOff(traningStatusVO);
	}
	
	@Override
	public List<TraningReportVO> listOnlineScheduleAttend( TraningReportVO traningReportVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listOnlineScheduleAttend(traningReportVO);
	}
	
	@Override
	public List<TraningStatusVO> listOffTraningStatus(TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listOffTraningStatus(traningStatusVO) ;
	}

	@Override
	public List<TraningStatusVO> listOjtTraningStatus(TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listOjtTraningStatus(traningStatusVO);
	}

	@Override
	public List<TraningStatusVO> listWeekTraningStatus(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listWeekTraningStatus(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> listTraningStatusPrt(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listTraningStatusPrt(traningStatusVO);
	}

	@Override
	public List<TraningStatusVO> listTraningStatusDetailPrt(TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listTraningStatusDetailPrt(traningStatusVO);
	}
	
	
	
	@Override
	public List<TraningStatusVO> listSubject(TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listSubject(traningStatusVO);
	}
	
	@Override
	public List<TraningReportVO> listSubjectWeek(TraningReportVO traningReportVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listSubjectWeek(traningReportVO);
	}
	
	@Override
	public List<TraningReportVO> listSubjectTraning(TraningReportVO traningReportVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listSubjectTraning(traningReportVO);
	}
	
	@Override
	public List<TraningReportVO> listSubjectTraningOff(TraningReportVO traningReportVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listSubjectTraningOff(traningReportVO);
	}
	
	@Override
	public List<TraningReportVO> listSubjectReport(TraningReportVO traningReportVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listSubjectReport(traningReportVO);
	}
	
	@Override
	public List<TraningReportVO> listSubjectOnline(TraningReportVO traningReportVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listSubjectOnline(traningReportVO);
	}
	
	@Override
	public List<TraningReportVO> listSubjectActivity(TraningReportVO traningReportVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listSubjectActivity(traningReportVO);
	}
	
	@Override
	public List<TraningStatusVO> listTraningOff(TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listTraningOff(traningStatusVO);
	}
	
	@Override
	public List<TraningReportVO> listTraningStatusCcn(TraningReportVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listTraningStatusCcn(traningStatusVO);
	}
	
	@Override
	public List<TraningReportVO> listTraningSubjectStatusCcn(TraningReportVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listTraningSubjectStatusCcn(traningStatusVO);
	}
	
	@Override
	public List<TraningReportVO> listTraningNcsSubjectStatusCcn(TraningReportVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return  traningStatusMapper.listTraningNcsSubjectStatusCcn(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> listTraningYear(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listTraningYear(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> listCompanyTraningProcessNote(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listCompanyTraningProcessNote(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> listCompanyTraningProcessAct(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listCompanyTraningProcessAct(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> listCompanyTraningProcessEval(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listCompanyTraningProcessEval(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> listOjtTraningstatusCdp(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listOjtTraningstatusCdp(traningStatusVO);
	}
	
	@Override
	public List<TraningStatusVO> listOjtTraningstatusExcel(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.listOjtTraningstatusExcel(traningStatusVO);
	}
	
	@Override
	public int updateLessonPassYn(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.updateLessonPassYn(traningStatusVO);
	}
	
	@Override
	public int updateLessonGrade(	TraningStatusVO traningStatusVO) throws Exception {
		// TODO Auto-generated method stub
		return traningStatusMapper.updateLessonGrade(traningStatusVO);
	}
	
}
