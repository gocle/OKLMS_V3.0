
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 7. 20.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.commbiz.login.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import egovframework.com.cmm.LoginVO;

 /**
 * 프로토타입 게시판 CRUD 쿼리를 마이바티스로 연결하는 클레스.
* 이진근
 * @since 2016. 7. 20.
 */
@Mapper
public interface CommBizLoginMapper {

	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<LoginVO> listLoginVO(LoginVO loginVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * List<MemberVO>
	 */
	List<LoginVO> listAdminLoginVO(LoginVO loginVO) throws Exception;
	
	/**
	 * 비밀번호 오류 횟수 증가.
	 * @param memberVO
	 * void
	 */
	void updateLoginVOPwFailCnt(LoginVO loginVO);
	/**
	 * 사용자의 비밀번호를 임의의 문자열로 초기화 시킴.
	 * @param memberVO
	 * void
	 */
	void updateLoginVOPwInit(LoginVO loginVO);
	
	/**
	 * 사용자의 비밀번호를 임의의 문자열로 초기화 시킴.
	 * @param memberVO
	 * void
	 */
	void updateLoginVOLoginLimit(LoginVO loginVO);
	
	/**
	 * 로그인 시 사용만료일 업데이트
	 * @param paramMap
	 * void
	 */
	void updateLoginVOExpireYmd(Map<String, Object> paramMap);
	/**
	 * 최종 로그인 일시 업데이트.
	 * @param memberVO
	 * void
	 */
	void updateLoginVOLastLoginDt(LoginVO loginVO);
	/**
	 * 비밀번호를 입력 받은 PW로 초기화 한다. (비밀번호 찾기 팝업의 비밀번호 초기화)
	 * @param memberVO
	 * void
	 */
	void updateLoginVOPw(LoginVO loginVO);
	/**
	 * DB에서 회사정보를 한건 조회하는 로직을 수행한다.
	 * @param memberVO
	 * @return
	 * LoginVO
	 */
	LoginVO getLoginCompanyId(LoginVO loginVO) throws Exception;
}
