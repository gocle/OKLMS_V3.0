/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2017. 01. 06.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.lu.subject.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.grade.vo.GradeVO;
import kr.co.gocle.oklms.lu.subject.service.SubjectService;
import kr.co.gocle.oklms.lu.subject.vo.SubjectCompanyVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
//import org.apache.commons.beanutils.BeanUtils;





import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

 /**
 * 프로토타입 게시판 CRUD 비지니스 로직을 구현하는 클레스.
 * @author 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("SubjectService")
public class SubjectServiceImpl extends EgovAbstractServiceImpl implements SubjectService {

	/** ID Generation */
    /*@Resource(name="subjectIdGnrService")
    private EgovIdGnrService subjectIdGnrService;*/

	@Resource(name = "subjectMapper")
    private SubjectMapper subjectMapper;

	@Override
	public SubjectVO getSubjectInfo(SubjectVO SubjectVO) throws Exception {
		SubjectVO data = subjectMapper.getSubjectInfo(SubjectVO);
		return data;
	}


	@Override
	public List<SubjectVO> listSubjectPrt(SubjectVO subjectVO) throws Exception {

		List<SubjectVO> listSubjectPrt = null;

		if(subjectVO.getSubjectTraningType().equals("OJT")){
			if(subjectVO.getSearchPeriodType().equals("TERM")){
				listSubjectPrt =  subjectMapper.listInChargeSubjectPrtOjt(subjectVO);
			} else {
				listSubjectPrt =  subjectMapper.listInChargeSubjectPrtOjtWeek(subjectVO);
			}
		} else {
			if(subjectVO.getSearchPeriodType().equals("TERM")){
				listSubjectPrt = subjectMapper.listInChargeSubjectPrtOff(subjectVO);
			} else {
				listSubjectPrt = subjectMapper.listInChargeSubjectPrtOffWeek(subjectVO);
			}
		}
		return listSubjectPrt;
	}
	

	@Override
	public List<SubjectVO> listSubjectCdp(SubjectVO subjectVO) throws Exception {
		return subjectMapper.listInChargeSubjectCdpOff(subjectVO);
	}
	
	@Override
	public List<SubjectVO> listSubjectCdpMain(SubjectVO subjectVO) throws Exception {
		return subjectMapper.listSubjectCdpMain(subjectVO);
	}
	
	@Override
	public List<SubjectVO> listSubjectOnlineCcn(SubjectVO subjectVO) throws Exception {
		return subjectMapper.listSubjectOnlineCcn(subjectVO);
	}

	@Override
	public List<SubjectVO> listSubjectStd(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> listSubjectStd = null;

		if(subjectVO.getSubjectTraningType().equals("OJT")){
			if(subjectVO.getSearchPeriodType().equals("TERM")){
				listSubjectStd =  subjectMapper.listInChargeSubjectStdOjt(subjectVO);
			} else {
				listSubjectStd =  subjectMapper.listInChargeSubjectStdOjtWeek(subjectVO);
			}
		} else {
			if(subjectVO.getSearchPeriodType().equals("TERM")){
				listSubjectStd = subjectMapper.listInChargeSubjectStdOff(subjectVO);
			} else {
				listSubjectStd = subjectMapper.listInChargeSubjectStdOffWeek(subjectVO);
			}
		}
		return listSubjectStd;
	}

	@Override
	public List<SubjectVO> listSubjectCot(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> listSubjectCot = null;

		if(subjectVO.getSearchPeriodType().equals("TERM")){
			listSubjectCot =  subjectMapper.listInChargeSubjectCotOjt(subjectVO);
		} else {
			listSubjectCot =  subjectMapper.listInChargeSubjectCotOjtWeek(subjectVO);
		}

		return listSubjectCot;
	}

	@Override
	public List<SubjectCompanyVO> listCompanyCcn(SubjectCompanyVO subjectCompanyVO) throws Exception {
		List<SubjectCompanyVO> listCompanyCcn = null;
		if(subjectCompanyVO.getSearchStatusType().equals("STU")){
			listCompanyCcn =  subjectMapper.listInChargeCompanyStudyStateCcn(subjectCompanyVO);
		} else {
			listCompanyCcn =  subjectMapper.listInChargeCompanyStateCcn(subjectCompanyVO);
		}

		return listCompanyCcn;
	}


	@Override
	public SubjectCompanyVO getActivityNoteMemInfos(SubjectCompanyVO subjectCompanyVO) throws Exception {
		SubjectCompanyVO compVO = subjectMapper.getActivityNoteMemInfos(subjectCompanyVO);
		return compVO;
	}

	@Override
	public List<SubjectCompanyVO> listCompanyCcm(SubjectCompanyVO subjectCompanyVO) throws Exception {
		List<SubjectCompanyVO> listCompanyCcm = null;

		if(subjectCompanyVO.getSearchStatusType().equals("STU")){
			listCompanyCcm =  subjectMapper.listInChargeCompanyStudyStateCcm(subjectCompanyVO);
		} else {
			listCompanyCcm =  subjectMapper.listInChargeCompanyStateCcm(subjectCompanyVO);
		}

		return listCompanyCcm;
	}

	@Override
	public String getMinSubjectClass(SubjectVO subjectVO) throws Exception {
		return subjectMapper.getMinSubjectClass(subjectVO);
	}

  	@Override
	public List<SubjectVO> listOjtClassName(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> data = subjectMapper.listOjtClassName(subjectVO);
		return data;
	}
  	
  	@Override
	public List<SubjectVO> listOjtCompanyName(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> data = subjectMapper.listOjtCompanyName(subjectVO);
		return data;
	}
  	
  	@Override
	public List<SubjectVO> listAllOjtClassName(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> data = subjectMapper.listAllOjtClassName(subjectVO);
		return data;
	}
  	
  	@Override
	public List<SubjectVO> listOjtClassStdName(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> data = subjectMapper.listOjtClassStdName(subjectVO);
		return data;
	}
  	
	@Override
	public List<SubjectVO> listSubjectAdm(SubjectVO subjectVO) throws Exception {
		return subjectMapper.listSubjectAdm(subjectVO);
	}
	
	@Override
	public List<SubjectVO> listSubjectAdmAll(SubjectVO subjectVO) throws Exception {
		return subjectMapper.listSubjectAdmAll(subjectVO);
	}
	
	@Override
	public SubjectVO getLinkYyyyTerm(SubjectVO subjectVO) throws Exception {
		return subjectMapper.getLinkYyyyTerm(subjectVO);
	}
	
	@Override
	public List<SubjectVO> listYyyyTermReinfcDate(SubjectVO subjectVO) throws Exception {
		return subjectMapper.listYyyyTermReinfcDate(subjectVO);
	}
	
	@Override
	public int saveSubjectAdmReinfc(SubjectVO subjectVO) throws Exception {
		int iResult = 0;
		
		iResult += subjectMapper.deleteTermReinfcDate(subjectVO);
		
		if( subjectVO.getReinfcTraningDates() != null && subjectVO.getReinfcTraningDates().length > 0 ){
			for( int i=0; i < subjectVO.getReinfcTraningDates().length; i++ ){
				if( !"".equals(subjectVO.getReinfcTraningDates()[i]) && !"".equals(subjectVO.getWeekCnts()[i]) ) {
					SubjectVO sVO = new SubjectVO();
					sVO.setYyyy(subjectVO.getYyyy());
					sVO.setTerm(subjectVO.getTerm());
					sVO.setWeekCnt(subjectVO.getWeekCnts()[i]);
					sVO.setReinfcTraningDate(subjectVO.getReinfcTraningDates()[i]);
					sVO.setSessionMemSeq(subjectVO.getSessionMemSeq());
					
					iResult += subjectMapper.insertTermReinfcDate(sVO);
				}
			}
		}
		
		return iResult;
	}
	
	
	@Override
	public int updateTermSubject(SubjectVO subjectVO) throws Exception {
		int sqlResultInt = 0;

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(subjectVO);

		sqlResultInt += subjectMapper.update_lms_activity_note(subjectVO);              
		sqlResultInt += subjectMapper.update_lms_lesson(subjectVO);                     
		sqlResultInt += subjectMapper.update_lms_subj_ins_mapping(subjectVO);           
		sqlResultInt += subjectMapper.update_lms_subj_tut_mapping(subjectVO);           
		sqlResultInt += subjectMapper.update_lms_subj_week(subjectVO);                  
		sqlResultInt += subjectMapper.update_lms_subj_week_time(subjectVO);             
		sqlResultInt += subjectMapper.update_lms_subj_week_time_enrichment(subjectVO);  
		sqlResultInt += subjectMapper.update_lms_subject(subjectVO);                    
		sqlResultInt += subjectMapper.update_lms_th_first_ev_std_score(subjectVO);      
		sqlResultInt += subjectMapper.update_lms_th_lctre_ctrl_set(subjectVO);          
		sqlResultInt += subjectMapper.update_lms_th_ncs_lctre_elem(subjectVO);          
		sqlResultInt += subjectMapper.update_lms_th_ncs_plan_lrn(subjectVO);            
		sqlResultInt += subjectMapper.update_lms_th_plan_ev(subjectVO);                 
		sqlResultInt += subjectMapper.update_lms_traning_note_detail(subjectVO);        
		sqlResultInt += subjectMapper.update_lms_traning_note_master(subjectVO);        
		sqlResultInt += subjectMapper.update_lms_traning_process_mapping(subjectVO);    
		sqlResultInt += subjectMapper.update_lms_traning_subj_ncs_elem_sch(subjectVO);  
		sqlResultInt += subjectMapper.update_lms_traning_subj_ncs_unit_sch(subjectVO);  
		sqlResultInt += subjectMapper.update_lms_traning_subj_week_sch(subjectVO);      
		sqlResultInt += subjectMapper.update_lms_traning_subj_week_time_sch(subjectVO);	

		
		return sqlResultInt;
	}
	
	@Override
	public List<SubjectVO> listHak(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> data = subjectMapper.listHak(subjectVO);
		return data;
	}
	
	@Override
	public int insertHak(SubjectVO subjectVO) throws Exception {
		subjectVO.setStartDate(subjectVO.getStartDate().replaceAll("\\.", ""));
		subjectVO.setEndDate(subjectVO.getEndDate().replaceAll("\\.", ""));
		return subjectMapper.insertHak(subjectVO);
	}
	
	@Override
	public int updateHak(SubjectVO subjectVO) throws Exception {
		subjectVO.setStartDate(subjectVO.getStartDate().replaceAll("\\.", ""));
		subjectVO.setEndDate(subjectVO.getEndDate().replaceAll("\\.", ""));
		return subjectMapper.updateHak(subjectVO);
	}
	
	@Override
	public int deleteHak(SubjectVO subjectVO) throws Exception {
		return subjectMapper.deleteHak(subjectVO);
	}
	
	@Override
	public List<SubjectVO> listWeekStudyDay(SubjectVO subjectVO) throws Exception {
		List<SubjectVO> data = subjectMapper.listWeekStudyDay(subjectVO);
		return data;
	}
	
	@Override
	public int updateWeekStudyDay(SubjectVO subjectVO) throws Exception {
		int iResult = 0;
		
		if( subjectVO.getWeekCnts() != null && subjectVO.getWeekCnts().length > 0 ){
			for( int i=0; i < subjectVO.getWeekCnts().length; i++ ){
				subjectVO.setWeekCnt(subjectVO.getWeekCnts()[i]);
				subjectVO.setTraningDate(subjectVO.getTraningDates()[i]);
				
				iResult += subjectMapper.updateWeekStudyDay(subjectVO);
				
			}
		}
		
		return iResult;
	}
	
	
	@Override
	public List<SubjectCompanyVO> listTraningStatusCcn(SubjectCompanyVO subjectCompnyVO) throws Exception {
		List<SubjectCompanyVO> data = subjectMapper.listTraningStatusCcn(subjectCompnyVO);
		return data;
	}
	
	@Override
	public List<SubjectCompanyVO> listSubjectCcn(SubjectCompanyVO subjectCompnyVO) throws Exception {
		List<SubjectCompanyVO> data = subjectMapper.listSubjectCcn(subjectCompnyVO);
		return data;
	}


	@Override
	public List<SubjectVO> listDepartmentStat(SubjectVO subjectVO) throws Exception {
		// TODO Auto-generated method stub
		return  subjectMapper.listDepartmentStat(subjectVO);
	}


	@Override
	public List<SubjectVO> listSubjectStat(SubjectVO subjectVO) throws Exception {
		// TODO Auto-generated method stub
		return  subjectMapper.listSubjectStat(subjectVO);
	}
	
	@Override
	public int mergeDeptLimit(SubjectVO subjectVO) throws Exception {
		// TODO Auto-generated method stub
		
		int iResult = 0;
		System.out.println("===================  subjectVO.getDeptCds().length : "+subjectVO.getDeptCds().length);
		if( subjectVO.getDeptCds() != null && subjectVO.getDeptCds().length > 0 ){
			for( int i=0; i < subjectVO.getDeptCds().length; i++ ){
				
				subjectVO.setDeptCd(subjectVO.getDeptCds()[i]);
				subjectVO.setDeptYear(subjectVO.getDeptYears()[i]);
				subjectVO.setDeptTransferYn(subjectVO.getDeptTransferYns()[i]);
				subjectVO.setDeptLimit(subjectVO.getDeptLimits()[i] == null ? "0" : subjectVO.getDeptLimits()[i]);
				
				iResult += subjectMapper.mergeDeptLimit(subjectVO);
				
			}
		}
		
		return  iResult;
	}
	
	
	
	
}
