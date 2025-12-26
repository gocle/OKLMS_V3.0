
/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2016. 7. 20.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.la.traningprocess.service.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.member.vo.ExcelMemberVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
import kr.co.gocle.oklms.la.traningprocess.vo.TraningProcessVO;

 /**
 * 프로토타입 게시판 CRUD 쿼리를 마이바티스로 연결하는 클레스.
 * @author 이진근
 * @since 2016. 7. 20.
 */
@Mapper
public interface TraningProcessMapper {

	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<TraningProcessVO> listTraningProcess(TraningProcessVO traningProcessVO) throws Exception;
	
	List<TraningProcessVO> listSearchTraningProcess(TraningProcessVO traningProcessVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	TraningProcessVO getTraningProcess(TraningProcessVO traningProcessVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	Integer getTraningProcessUseCnt(TraningProcessVO traningProcessVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	int insertTraningProcess(TraningProcessVO traningProcessVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	int updateTraningProcess(TraningProcessVO traningProcessVO) throws Exception;
	
	
	int updateTraningProcessHrd(TraningProcessVO traningProcessVO) throws Exception; 
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	int deleteTraningProcess(TraningProcessVO traningProcessVO) throws Exception;
	
	List<TraningProcessVO> listTraningProcessStat(TraningProcessVO traningProcessVO) throws Exception;
	
	
	List<HashMap> mainTraningProcessStat() throws Exception;
	
	List<TraningProcessVO> listTraningDeptStat() throws Exception;
}
