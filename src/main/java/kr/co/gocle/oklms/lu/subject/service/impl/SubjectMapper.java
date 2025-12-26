
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

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.grade.vo.GradeVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectCompanyVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

 /**
 * 프로토타입 게시판 CRUD 쿼리를 마이바티스로 연결하는 클레스.
 * @author 이진근
 * @since 2017. 01. 06.
 */
@Mapper
public interface SubjectMapper {

	/**
	 * 단걸을 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * SubjectVO
	 */
	SubjectVO getSubjectInfo(SubjectVO subjectVO) throws Exception;



	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectPrtOff(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectPrtOffWeek(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectPrtOjt(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectPrtOjtWeek(SubjectVO subjectVO) throws Exception;


	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectCdpOff(SubjectVO subjectVO) throws Exception;
	
	List<SubjectVO> listSubjectCdpMain(SubjectVO subjectVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listSubjectOnlineCcn(SubjectVO subjectVO) throws Exception;
	

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectStdOff(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectStdOffWeek(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectStdOjt(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectStdOjtWeek(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectCotOjt(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listInChargeSubjectCotOjtWeek(SubjectVO subjectVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectCompanyVO
	 * @return
	 * List<SubjectCompanyVO>
	 */
	List<SubjectCompanyVO> listInChargeCompanyStudyStateCcn(SubjectCompanyVO subjectCompanyVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectCompanyVO
	 * @return
	 * String
	 */
	SubjectCompanyVO getActivityNoteMemInfos(SubjectCompanyVO subjectCompanyVO) throws Exception;


	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectCompanyVO
	 * @return
	 * List<SubjectCompanyVO>
	 */
	List<SubjectCompanyVO> listInChargeCompanyStateCcn(SubjectCompanyVO subjectCompanyVO) throws Exception;

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectCompanyVO
	 * @return
	 * List<SubjectCompanyVO>
	 */
	List<SubjectCompanyVO> listInChargeCompanyStudyStateCcm(SubjectCompanyVO subjectCompanyVO) throws Exception;


	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectCompanyVO
	 * @return
	 * List<SubjectCompanyVO>
	 */
	List<SubjectCompanyVO> listInChargeCompanyStateCcm(SubjectCompanyVO subjectCompanyVO) throws Exception;


	/**
	 * 개설강좌정보 조회 데이타 체크 Count하는 SQL 을 호출한다.
	 * @param currProcVO
	 * @return
	 * int
	 */
	String getMinSubjectClass(SubjectVO subjectVO) throws Exception;



	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param currProcVO
	 * @return
	 * List<CurrProcVO>
	 */
	List<SubjectVO> listOjtClassName(SubjectVO subjectVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param currProcVO
	 * @return
	 * List<CurrProcVO>
	 */
	List<SubjectVO> listOjtCompanyName(SubjectVO subjectVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param currProcVO
	 * @return
	 * List<CurrProcVO>
	 */
	List<SubjectVO> listAllOjtClassName(SubjectVO subjectVO) throws Exception;
	
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param currProcVO
	 * @return
	 * List<CurrProcVO>
	 */
	List<SubjectVO> listOjtClassStdName(SubjectVO subjectVO) throws Exception;
	
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listSubjectAdm(SubjectVO subjectVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listSubjectAdmAll(SubjectVO subjectVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	SubjectVO getLinkYyyyTerm(SubjectVO subjectVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	List<SubjectVO> listYyyyTermReinfcDate(SubjectVO subjectVO) throws Exception;
	
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	int deleteTermReinfcDate(SubjectVO subjectVO) throws Exception;
	
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	int insertTermReinfcDate(SubjectVO subjectVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * List<SubjectVO>
	 */
	int updateTermSubject(SubjectVO subjectVO) throws Exception;
	
	int update_lms_activity_note(SubjectVO subjectVO) throws Exception;              
	int update_lms_lesson(SubjectVO subjectVO) throws Exception;                     
	int update_lms_subj_ins_mapping(SubjectVO subjectVO) throws Exception;           
	int update_lms_subj_tut_mapping(SubjectVO subjectVO) throws Exception;           
	int update_lms_subj_week(SubjectVO subjectVO) throws Exception;                  
	int update_lms_subj_week_time(SubjectVO subjectVO) throws Exception;             
	int update_lms_subj_week_time_enrichment(SubjectVO subjectVO) throws Exception;  
	int update_lms_subject(SubjectVO subjectVO) throws Exception;                    
	int update_lms_th_first_ev_std_score(SubjectVO subjectVO) throws Exception;      
	int update_lms_th_lctre_ctrl_set(SubjectVO subjectVO) throws Exception;          
	int update_lms_th_ncs_lctre_elem(SubjectVO subjectVO) throws Exception;          
	int update_lms_th_ncs_plan_lrn(SubjectVO subjectVO) throws Exception;            
	int update_lms_th_plan_ev(SubjectVO subjectVO) throws Exception;                 
	int update_lms_traning_note_detail(SubjectVO subjectVO) throws Exception;        
	int update_lms_traning_note_master(SubjectVO subjectVO) throws Exception;        
	int update_lms_traning_process_mapping(SubjectVO subjectVO) throws Exception;    
	int update_lms_traning_subj_ncs_elem_sch(SubjectVO subjectVO) throws Exception;  
	int update_lms_traning_subj_ncs_unit_sch(SubjectVO subjectVO) throws Exception;  
	int update_lms_traning_subj_week_sch(SubjectVO subjectVO) throws Exception;      
	int update_lms_traning_subj_week_time_sch(SubjectVO subjectVO) throws Exception;	
	
	
	List<SubjectVO> listHak(SubjectVO subjectVO) throws Exception;
	
	int insertHak(SubjectVO subjectVO) throws Exception;	
	int updateHak(SubjectVO subjectVO) throws Exception;	
	int deleteHak(SubjectVO subjectVO) throws Exception;	
	
	List<SubjectVO> listWeekStudyDay(SubjectVO subjectVO) throws Exception;
	
	
	int updateWeekStudyDay(SubjectVO subjectVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * GradeVO
	 */

	List<SubjectCompanyVO> listTraningStatusCcn(SubjectCompanyVO subjectCompnyVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param subjectVO
	 * @return
	 * GradeVO
	 */

	List<SubjectCompanyVO> listSubjectCcn(SubjectCompanyVO subjectCompnyVO) throws Exception;

	List<SubjectVO> listDepartmentStat(SubjectVO subjectVO) throws Exception;
	
	List<SubjectVO> listSubjectStat(SubjectVO subjectVO) throws Exception;
	
	int mergeDeptLimit(SubjectVO subjectVO) throws Exception;
}
