/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/
package kr.co.gocle.oklms.la.api.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import kr.co.gocle.oklms.commbiz.menu.vo.CommbizMenuVO;
/**
 * COM_AUTH_MAP 테이블에 대응되는 VO 클래스입니다.
 * 
* 이진근
 * @since 2016. 07. 01.
 */
public class ApiVO extends CommbizMenuVO implements Serializable {
	
	private static final long serialVersionUID = -8059339090758541457L;

	private String menuIdAndAuthGroupId; // 메뉴ID^권한그룹아이디
	
	private String memName;  // 센터 전담자 명
	private String memSeq;   // 센터 전담자 번호
	
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
}
