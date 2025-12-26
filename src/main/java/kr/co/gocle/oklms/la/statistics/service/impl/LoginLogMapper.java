
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
package kr.co.gocle.oklms.la.statistics.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.statistics.vo.LoginLogVO;

 /**
 * COM_MENU에 대한 CRUD 쿼리를 마이바티스로 연결하는 클레스.
* 이진근
 * @since 2016. 7. 20.
 */
@Mapper
public interface LoginLogMapper {

	/**
	 * LoginLogVO의 전체 목록을 조회하는 SQL 을 호출한다.
	 * @param loginLogVO
	 * @return
	 * List<LoginLogVO>
	 */
	List<LoginLogVO> listLoginLog(LoginLogVO loginLogVO);
	
}
