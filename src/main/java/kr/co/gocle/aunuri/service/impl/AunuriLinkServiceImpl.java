package kr.co.gocle.aunuri.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.gocle.aunuri.service.AunuriLinkService;
import kr.co.gocle.aunuri.vo.AunuriLinkEvalPlanNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkLessonVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberMappingVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberVO;
import kr.co.gocle.aunuri.vo.AunuriLinkScheduleVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectGradeVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekVO;
import kr.co.gocle.ifx.service.impl.IfxMapper;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.la.link.service.impl.LinkMapper;
import kr.co.gocle.oklms.la.member.service.impl.MemberMapper;
import kr.co.gocle.oklms.lu.attend.service.impl.AttendMapper;
import kr.co.gocle.oklms.lu.attend.vo.AttendVO;
import kr.co.gocle.oklms.lu.member.service.impl.MemberStdMapper;
import kr.co.gocle.oklms.lu.online.service.impl.OnlineTraningMapper;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.com.uss.ion.bnr.service.BannerVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

@Transactional(rollbackFor=Exception.class)
@Service("aunuriLinkService")
public class AunuriLinkServiceImpl extends EgovAbstractServiceImpl implements AunuriLinkService{

	@Resource(name = "aunuriLinkMapper")
    private AunuriLinkMapper aunuriLinkMapper;
	
    

	@Override
	public List<AunuriLinkMemberVO> listAunuriMember(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception {
		List<AunuriLinkMemberVO> data = aunuriLinkMapper.listAunuriMember(aunuriLinkMemberVO);
		return data;
	}

	@Override
	public List<AunuriLinkSubjectVO> listAunuriSubject(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception {
		List<AunuriLinkSubjectVO> data = aunuriLinkMapper.listAunuriSubject(aunuriLinkSubjectVO);
		return data;
	}

	@Override
	public List<AunuriLinkLessonVO> listAunuriLesson(AunuriLinkLessonVO aunuriLinkLessonVO) throws Exception {
		List<AunuriLinkLessonVO> data = aunuriLinkMapper.listAunuriLesson(aunuriLinkLessonVO);
		return data;
	}

	@Override
	public List<AunuriLinkMemberMappingVO> listAunuriIns(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception {
		List<AunuriLinkMemberMappingVO> data = aunuriLinkMapper.listAunuriIns(aunuriLinkMemberMappingVO);
		return data;
	}

	@Override
	public List<AunuriLinkScheduleVO> listAunuriHaksaSchedule(AunuriLinkScheduleVO aunuriLinkScheduleVO) throws Exception {
		List<AunuriLinkScheduleVO> data = aunuriLinkMapper.listAunuriHaksaSchedule(aunuriLinkScheduleVO);
		return data;
	}


	@Override
	public AunuriLinkSubjectWeekVO getAunuriWeekLessonInfo(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception {
		AunuriLinkSubjectWeekVO data = aunuriLinkMapper.getAunuriWeekLessonInfo(aunuriLinkSubjectWeekVO);
		return data;
	}


	@Override
	public AunuriLinkSubjectWeekVO getAunuriWeekTime(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception {
		AunuriLinkSubjectWeekVO data = aunuriLinkMapper.getAunuriWeekTime(aunuriLinkSubjectWeekVO);
		return data;
	}

	@Override
	public AunuriLinkSubjectWeekNcsVO getAunuriWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception {
		AunuriLinkSubjectWeekNcsVO data = aunuriLinkMapper.getAunuriWeekNcsUnit(aunuriLinkSubjectWeekNcsVO);
		return data;
	}
	
	@Override
	public List<AunuriLinkSubjectWeekNcsVO> listAunuriWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception {
		List<AunuriLinkSubjectWeekNcsVO> data = aunuriLinkMapper.listAunuriWeekNcsUnit(aunuriLinkSubjectWeekNcsVO);
		return data;
	}
	
	@Override
	public List<AunuriLinkSubjectWeekNcsVO> listAunuriWeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception {
		List<AunuriLinkSubjectWeekNcsVO> data = aunuriLinkMapper.listAunuriWeekNcsElem(aunuriLinkSubjectWeekNcsVO);
		return data;
	}


	@Override
	public AunuriLinkMemberVO getAunuriUserImage(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception {
		AunuriLinkMemberVO data = aunuriLinkMapper.getAunuriUserImage(aunuriLinkMemberVO);
		return data;
	}

	@Override
	public List<AunuriLinkEvalPlanNcsVO> listAunuriWeekNcsEvalPlanCode(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		List<AunuriLinkEvalPlanNcsVO> data = aunuriLinkMapper.listAunuriWeekNcsEvalPlanCode(evalPlanNcsVO);
		return data;
	}

	@Override
	public List<AunuriLinkEvalPlanNcsVO> listAunuriWeekNcsEvalPlanNote(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		List<AunuriLinkEvalPlanNcsVO> data = aunuriLinkMapper.listAunuriWeekNcsEvalPlanNote(evalPlanNcsVO);
		return data;
	}

	@Override
	public List<AunuriLinkEvalPlanNcsVO> listAunuriWeekNcsEvalWay(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		List<AunuriLinkEvalPlanNcsVO> data = aunuriLinkMapper.listAunuriWeekNcsEvalWay(evalPlanNcsVO);
		return data;
	}

	@Override
	public AunuriLinkEvalPlanNcsVO getAunuriWeekNcsEvalPlan(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		AunuriLinkEvalPlanNcsVO data = aunuriLinkMapper.getAunuriWeekNcsEvalPlan(evalPlanNcsVO);
		return data;
	}

	@Override
	public AunuriLinkEvalPlanNcsVO getAunuriWeekNcsEvalPlanElem(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		AunuriLinkEvalPlanNcsVO data = aunuriLinkMapper.getAunuriWeekNcsEvalPlanElem(evalPlanNcsVO);
		return data;
	}
	
	@Override
	public List<AunuriLinkSubjectGradeVO> listSubectGrade(AunuriLinkSubjectGradeVO aunuriLinkSubjectGradeVO) throws Exception {
		List<AunuriLinkSubjectGradeVO> data = aunuriLinkMapper.listSubectGrade(aunuriLinkSubjectGradeVO);
		return data;
	}
	
	@Override
	public AunuriLinkSubjectGradeVO getSubectGradeCnt(AunuriLinkSubjectGradeVO aunuriLinkSubjectGradeVO) throws Exception {
		AunuriLinkSubjectGradeVO data = aunuriLinkMapper.getSubectGradeCnt(aunuriLinkSubjectGradeVO);
		return data;
	}
	

	@Override
	public int getAunuriMemberCnt(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		return aunuriLinkMapper.getAunuriMemberCnt(evalPlanNcsVO);
	}

	@Override
	public int getAunuriMemberTutCnt(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		return aunuriLinkMapper.getAunuriMemberTutCnt(evalPlanNcsVO);
	}

	@Override
	public int getAunuriMemberTutSize(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		return aunuriLinkMapper.getAunuriMemberTutSize(evalPlanNcsVO);
	}

	@Override
	public int insertAunuriSubjectInfoTutMapping(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		return aunuriLinkMapper.insertAunuriSubjectInfoTutMapping(evalPlanNcsVO);
	}

	@Override
	public int updateAunuriSubjectInfoTutMapping(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		return aunuriLinkMapper.updateAunuriSubjectInfoTutMapping(evalPlanNcsVO);
	}

	@Override
	public int deleteAunuriTutMappingNull(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		return aunuriLinkMapper.deleteAunuriTutMappingNull(evalPlanNcsVO);
	}

	@Override
	public int deleteAunuriTutMapping(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception {
		return aunuriLinkMapper.deleteAunuriTutMapping(evalPlanNcsVO);
	}
	
	@Override
	public int updateAunuriOutMemberInfoEtc(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception {
		return aunuriLinkMapper.updateAunuriOutMemberInfoEtc(aunuriLinkMemberVO);
	}
	
	@Override
	public String getAunuriWeekStartDate(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception {
		return aunuriLinkMapper.getAunuriWeekStartDate(aunuriLinkSubjectVO);
	}

	@Override
	public  void smsSendCall(MailVO smsVO) throws Exception {
		// TODO Auto-generated method stub
		aunuriLinkMapper.smsSendCall(smsVO);
	}
  
	
}