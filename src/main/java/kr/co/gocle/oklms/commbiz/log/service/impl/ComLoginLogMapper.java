
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
package kr.co.gocle.oklms.commbiz.log.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.commbiz.log.vo.ComLoginLogVO;
/**
* COM_LOGIN_LOG에 대한 CRUD 쿼리를 마이바티스로 연결하는 클레스.
* 이진근
* @since 2016. 7. 20.
*/
@Mapper
public interface ComLoginLogMapper {

	/**
	 * COM_LOGIN_LOG의 목록을 조회하는 SQL 을 호출한다.
	 * @param comLoginLogVO
	 * @return
	 * List<ComLoginLogVO>
	 */
	List<ComLoginLogVO> listComLoginLog(ComLoginLogVO comLoginLogVO) throws Exception;
	/**
	 * COM_LOGIN_LOG의 목록을 조회와 동일한 검색 조건을 수행하였을 때의 총 data건수를 조회하는 SQL 을 호출한다.
	 * @param comLoginLogVO
	 * @return
	 * @throws Exception
	 * Integer
	 */
	Integer getComLoginLogCnt(ComLoginLogVO comLoginLogVO) throws Exception;


	/**
	 * COM_LOGIN_LOG에 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param comLoginLogVO
	 * @return
	 * String
	 */
	int insertComLoginLog(ComLoginLogVO comLoginLogVO) throws Exception;

}
