
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
package kr.co.gocle.oklms.la.member.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.member.vo.ExcelMemberVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;

 /**
 * 프로토타입 게시판 CRUD 쿼리를 마이바티스로 연결하는 클레스.
 * @author 이진근
 * @since 2016. 7. 20.
 */
@Mapper
public interface MemberMapper {

	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<MemberVO> listMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<ExcelMemberVO> listMemberAllExcelList(ExcelMemberVO excelMemberVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<MemberVO> listMemberMail(MemberVO memberVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<ExcelMemberVO> getSearchEmail(ExcelMemberVO excelMemberVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<ExcelMemberVO> getSearchHpNo(ExcelMemberVO excelMemberVO) throws Exception;

	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * MemberVO
	 */
	MemberVO getMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * MemberVO
	 */
	MemberVO getStdMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * MemberVO
	 */
	int getMemberCnt(MemberVO memberVO) throws Exception;

	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int insertMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int insertAuthMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 정보를 단건 삭제하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int deleteAuthMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 정보를 단건 삭제하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int deleteDeptMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int insertDeptMember(MemberVO memberVO) throws Exception;
	
	
	/**
	 * 정보를 여러건 삭제하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int deleteAuthMemberList(MemberVO memberVO) throws Exception;
	
	
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int insertExcelMember(ExcelMemberVO excelMemberVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */
	int insertExcelCompMember(ExcelMemberVO excelMemberVO) throws Exception;
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */ 
	int updateMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */ 
	int updateCcnStdMember(MemberVO memberVO) throws Exception;
	
	int updateTraningStatus(MemberVO memberVO) throws Exception;
	
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * String
	 */ 
	int updateMemberPwInit(MemberVO memberVO) throws Exception;

	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * int
	 */
	int deleteMemberList(MemberVO memberVO) throws Exception;
	
	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * int
	 */
	int deleteMember(MemberVO memberVO) throws Exception;	
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * MemberVO
	 */
	String getMemberSeq(String memberId) throws Exception;
	
	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * MemberVO
	 */
	String getCompanyName(String companyName) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<MemberVO> listStdMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * int
	 */
	int updateStdMember(MemberVO memberVO) throws Exception;	
	
	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * int
	 */
	int getOjtPrtCnt(MemberVO memberVO) throws Exception;	
	
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<MemberVO> listCotMemberStat(MemberVO memberVO) throws Exception;
	
	List<MemberVO> listStudyMemberStat(MemberVO memberVO) throws Exception;
}
