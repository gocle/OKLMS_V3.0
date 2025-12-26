package kr.co.gocle.oklms.lu.grade.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.lu.activity.vo.ActivityVO; 
import kr.co.gocle.oklms.lu.activity.vo.MemberVO;
import kr.co.gocle.oklms.lu.activity.vo.SubjweekStdVO;
import kr.co.gocle.oklms.lu.grade.vo.GradeVO;

@Mapper
public interface  GradeMapper {

	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * GradeVO
	 */
	List<GradeVO> listGradeSendStatusList(GradeVO gradeVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * GradeVO
	 */
	List<GradeVO> listGradeSendList(GradeVO gradeVO) throws Exception;
	
	/**
	 * 단건을 등록하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * int
	 */
	int insertGradeCdpSend(GradeVO gradeVO) throws Exception;
	
	/**
	 * 단건을 호출하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * String
	 */
	String getGradeGroupMemIds(GradeVO gradeVO) throws Exception;
	
	/**
	 * 단건을 호출하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * String
	 */
	GradeVO getGradeCcmConfirmInfo(GradeVO gradeVO) throws Exception;
	
	/**
	 * 단건을 호출하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * String
	 */
	GradeVO getGradeCcmSubmitInfo(GradeVO gradeVO) throws Exception;
	
	/**
	 * 리스트 조회하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * GradeVO
	 */
	List<GradeVO> listGradeConfirmList(GradeVO gradeVO) throws Exception;
	
	/**
	 * 단건을 수정하는 SQL 을 호출한다.
	 * @param gradeVO
	 * @return
	 * int
	 */
	int updateGradeCcmConfirmY(GradeVO gradeVO) throws Exception;
	
}
