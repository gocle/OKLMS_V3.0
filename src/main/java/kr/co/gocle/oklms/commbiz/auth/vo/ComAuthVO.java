/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
* 이진근    2016. 07. 01.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.commbiz.auth.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

/**
 * COM_LOGIN_LOG 테이블에 대응되는 VO 클래스입니다.
 * 
* 이진근
 * @since 2016. 07. 01.
 */
public class ComAuthVO extends BaseVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5895890124072019334L;
	
	private String authGroupId = "";
	private String authGroupName = "";
	private String memSeq = "";
	private String memType = "";
	private String authGroupSet = "";

	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}
	public String getAuthGroupName() {
		return authGroupName;
	}
	public void setAuthGroupName(String authGroupName) {
		this.authGroupName = authGroupName;
	}
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
	public String getMemType() {
		return memType;
	}
	public void setMemType(String memType) {
		this.memType = memType;
	}
	public String getAuthGroupSet() {
		return authGroupSet;
	}
	public void setAuthGroupSet(String authGroupSet) {
		this.authGroupSet = authGroupSet;
	}

}
