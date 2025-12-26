
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2017. 02. 14.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.aunuri.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.aunuri.vo.AunuriLinkEvalPlanNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkLessonVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberMappingVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberVO;
import kr.co.gocle.aunuri.vo.AunuriLinkScheduleVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectGradeVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekVO;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO; 
import kr.co.gocle.oklms.commbiz.outmember.vo.OutMemberVO;

/**
* CRUD 쿼리를 마이바티스로 연결하는 클레스.
* @author 이진근
* @since 2017. 02. 14.
*/
@Mapper
public interface AunuriLinkMapper {

	/**
	 * 콘텐츠별 버전정보가 등록 되었는지 확인하는 SQL 을 호출한다.
	 * @param cmsCourseContentVO
	 * @return
	 * List<CmsCourseContentVO>
	 */
	int getCount() throws Exception;


	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriLinkMemberVO>
	 */
	List<AunuriLinkMemberVO> listAunuriMember(AunuriLinkMemberVO aunuriMemberVO) throws Exception;

	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkSubjectVO
	 * @return
	 * List<AunuriLinkSubjectVO>
	 */
	List<AunuriLinkSubjectVO> listAunuriSubject(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception;

	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkLessonVO
	 * @return
	 * List<AunuriLinkLessonVO>
	 */
	List<AunuriLinkLessonVO> listAunuriLesson(AunuriLinkLessonVO aunuriLinkLessonVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkLessonVO
	 * @return
	 * List<AunuriLinkLessonVO>
	 */
	List<AunuriLinkLessonVO> listAunuriLessonTerm(AunuriLinkLessonVO aunuriLinkLessonVO) throws Exception;

	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkLessonVO
	 * @return
	 * List<AunuriLinkMemberMappingVO>
	 */
	List<AunuriLinkMemberMappingVO> listAunuriIns(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception;
	
	

	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkScheduleVO
	 * @return
	 * List<AunuriLinkScheduleVO>
	 */
	List<AunuriLinkScheduleVO> listAunuriHaksaSchedule(AunuriLinkScheduleVO aunuriLinkScheduleVO) throws Exception;



	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkSubjectWeekVO
	 * @return
	 * AunuriLinkSubjectWeekVO
	 */
	AunuriLinkSubjectWeekVO getAunuriWeekLessonInfo(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;

	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkSubjectWeekVO
	 * @return
	 * AunuriLinkSubjectWeekVO
	 */
	AunuriLinkSubjectWeekVO getAunuriWeekTime(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception;

	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkSubjectWeekNcsVO
	 * @return
	 * List<AunuriLinkSubjectWeekNcsVO>
	 */
	AunuriLinkSubjectWeekNcsVO getAunuriWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkScheduleVO
	 * @return
	 * List<AunuriLinkSubjectWeekNcsVO>
	 */
	List<AunuriLinkSubjectWeekNcsVO> listAunuriWeekNcsElem(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;


	/**
	 * DB에서 Data를 단건을 조회하는 로직을 수행한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * AunuriLinkMemberVO
	 */
	AunuriLinkMemberVO getAunuriUserImage(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;

	/**
	 * DB에서 성적평가기준 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkEvalPlanNcsVO
	 * @return
	 * List<AunuriLinkEvalPlanNcsVO>
	 */
	List<AunuriLinkEvalPlanNcsVO> listAunuriWeekNcsEvalPlanCode(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;

	/**
	 * DB에서 NCS 평가계획 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkEvalPlanNcsVO
	 * @return
	 * List<AunuriLinkEvalPlanNcsVO>
	 */
	List<AunuriLinkEvalPlanNcsVO> listAunuriWeekNcsEvalPlanNote(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;

	/**
	 * DB에서 NCS 평가방법 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkEvalPlanNcsVO
	 * @return
	 * List<AunuriLinkEvalPlanNcsVO>
	 */
	List<AunuriLinkEvalPlanNcsVO> listAunuriWeekNcsEvalWay(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;

	/**
	 * DB에서 성적평가기준 Data를 단건을 조회하는 로직을 수행한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * AunuriLinkEvalPlanNcsVO
	 */
	AunuriLinkEvalPlanNcsVO getAunuriWeekNcsEvalPlan(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;

	/**
	 * DB에서 NCS개설과목능력요소 Data를 단건을 조회하는 로직을 수행한다.
	 * @param aunuriLinkMemberVO
	 * @return
	 * AunuriLinkEvalPlanNcsVO
	 */
	AunuriLinkEvalPlanNcsVO getAunuriWeekNcsEvalPlanElem(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	
	/**
	 * DB에서 학습근로자별 성적 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkSubjectGradeVO
	 * @return
	 * List<AunuriLinkSubjectGradeVO>
	 */
	List<AunuriLinkSubjectGradeVO> listSubectGrade(AunuriLinkSubjectGradeVO aunuriLinkSubjectGradeVO) throws Exception;
	
	/**
	 * DB에서 학습근로자별 성적 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkSubjectGradeVO
	 * @return
	 * List<AunuriLinkSubjectGradeVO>
	 */
	AunuriLinkSubjectGradeVO getSubectGradeCnt(AunuriLinkSubjectGradeVO aunuriLinkSubjectGradeVO) throws Exception;
	

	int getAunuriMemberCnt(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	int getAunuriMemberTutCnt(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	int getAunuriMemberTutSize(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	int insertAunuriSubjectInfoTutMapping(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	int updateAunuriSubjectInfoTutMapping(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	int deleteAunuriTutMappingNull(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	int deleteAunuriTutMapping(AunuriLinkEvalPlanNcsVO evalPlanNcsVO) throws Exception;
	
	
	int updateAunuriOutMemberInfoEtc(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;
	
	String getAunuriWeekStartDate(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception;
	
	/**
	 * 아우누리 교과조회
	 * @param aunuriLinkSubjectGradeVO
	 * @return
	 * List<AunuriLinkSubjectGradeVO>
	 */
	List<AunuriLinkSubjectVO> listAunuriTermSubject(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriMemberVO
	 * @return
	 * List<AunuriLinkMemberVO>
	 */
	AunuriLinkMemberVO getAunuriMember(AunuriLinkMemberVO aunuriMemberVO) throws Exception;
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkLessonVO
	 * @return
	 * List<AunuriLinkMemberMappingVO>
	 */
	List<AunuriLinkMemberMappingVO> listAunuriInsTerm(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception;
	
	void smsSendCall(MailVO mailVO) throws Exception;
 
	List<MailVO> smsSendMailTel(MailVO mailVO) throws Exception;
	
	/**
	 * 아우누리 교과조회
	 * @param aunuriLinkMemberVO
	 * @return
	 * List<AunuriLinkMemberVO>
	 */
	List<AunuriLinkMemberVO> listAunuriMemberOutYn(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;
	
	/**
	 * 아우누리 교과조회
	 * @param aunuriLinkMemberVO
	 * @return
	 * List<AunuriLinkMemberVO>
	 */
	List<AunuriLinkMemberVO> listAunuriMemberPassYn(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param aunuriLinkSubjectWeekNcsVO
	 * @return
	 * List<AunuriLinkSubjectWeekNcsVO>
	 */
	List<AunuriLinkSubjectWeekNcsVO>  listAunuriWeekNcsUnit(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception;

	
	int insertOutMember(OutMemberVO outMemberVO) throws Exception;
	
}
