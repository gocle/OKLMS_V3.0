
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
package kr.co.gocle.oklms.commbiz.menu.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.commbiz.menu.vo.CommbizMenuVO;

 /**
 * COM_MENU에 대한 CRUD 쿼리를 마이바티스로 연결하는 클레스.
* 이진근
 * @since 2016. 7. 20.
 */
@Mapper
public interface CommbizMenuMapper {
 
	/**
	 * 메뉴 목록 : 메인 메뉴 및 각 서브 메뉴에서 사용.
	 * @param commandMap
	 * @return
	 * List<CommbizMenuVO>
	 */
	ArrayList<CommbizMenuVO> listMenu(Map<String, Object> commandMap) throws Exception;
	ArrayList<CommbizMenuVO> mobilelistMenu(Map<String, Object> commandMap) throws Exception;
}
