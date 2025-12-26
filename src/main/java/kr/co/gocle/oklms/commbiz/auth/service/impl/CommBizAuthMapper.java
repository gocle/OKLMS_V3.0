
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
package kr.co.gocle.oklms.commbiz.auth.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.commbiz.auth.vo.ComAuthVO;
import egovframework.com.cmm.LoginVO;

 /**
 * 프로토타입 게시판 CRUD 쿼리를 마이바티스로 연결하는 클레스.
* 이진근
 * @since 2016. 7. 20.
 */
@Mapper
public interface CommBizAuthMapper {

	/**
	 * DB에서 Data를 여러건 조회하는 로직을 수행한다.
	 * @param comAuthVO
	 * @return
	 * List<ComAuthVO>
	 */
	List<ComAuthVO> listAuth(ComAuthVO comAuthVO) throws Exception;
	
	
	/**
	 * DB에서 Data를 단건 조회하는 로직을 수행한다.
	 * @param comAuthVO
	 * @return
	 * ComAuthVO
	 */
	ComAuthVO getAuth(ComAuthVO comAuthVO) throws Exception;
	
	
}
