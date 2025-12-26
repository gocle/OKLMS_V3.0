
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
package kr.co.gocle.oklms.commbiz.auth.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.gocle.oklms.commbiz.auth.service.CommBizAuthService;
import kr.co.gocle.oklms.commbiz.auth.vo.ComAuthVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

 /**
 * 프로토타입 게시판 CRUD 비지니스 로직을 구현하는 클레스.
* 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("commBizAuthService")
public class CommBizAuthServiceImpl extends EgovAbstractServiceImpl implements CommBizAuthService {

    
    @Resource(name = "commBizAuthMapper")
    private CommBizAuthMapper commBizAuthMapper;

	@Override
	public List<ComAuthVO> listAuth(ComAuthVO comAuthVO) throws Exception {
		List<ComAuthVO> data = commBizAuthMapper.listAuth(comAuthVO);
		return data;
	}
	
	@Override
	public ComAuthVO getAuth(ComAuthVO comAuthVO) throws Exception {
		ComAuthVO data = commBizAuthMapper.getAuth(comAuthVO);
		return data;
	}
	
}
