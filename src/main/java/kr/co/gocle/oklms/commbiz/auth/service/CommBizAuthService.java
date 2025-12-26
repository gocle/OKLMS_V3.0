
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.commbiz.auth.service;

import java.util.List;
import java.util.Map;

import kr.co.gocle.oklms.commbiz.auth.vo.ComAuthVO;

import org.springframework.transaction.annotation.Transactional;

import egovframework.com.cmm.LoginVO;

 /**
 * 클래스에 대한 내용을 작성한다.
* 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
public interface CommBizAuthService {

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
