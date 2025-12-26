/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2017. 01. 06.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.lu.member.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import kr.co.gocle.oklms.comm.util.TextStringUtil;
import kr.co.gocle.oklms.comm.vo.BaseVO;
import kr.co.gocle.oklms.commbiz.util.SecurityUtil;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.web.multipart.MultipartFile;

/**
 * VO 클래스에 대한 내용을 작성한다.
 * 
 * @author 이진근
 * @since 2017. 01. 06.
 */
public class MemberSearchVO extends BaseVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7896512282882197285L;
	private String memId;
	private String memPassword;
	private String memName;
	private String email;
	private String memSeq;
	private String companyName;
	private String deptNm;
	
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemPassword() {
		return memPassword;
	}
	public void setMemPassword(String memPassword) {
		this.memPassword = memPassword;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
	
	public String getEncryptShaPw(){
		return SecurityUtil.encryptSha256(memPassword);
	}
}
