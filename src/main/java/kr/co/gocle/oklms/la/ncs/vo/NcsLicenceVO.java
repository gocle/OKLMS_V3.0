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
package kr.co.gocle.oklms.la.ncs.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

/**
 * COM_LOGIN_LOG 테이블에 대응되는 VO 클래스입니다.
 * 
 */
public class NcsLicenceVO extends BaseVO implements Serializable {


	private static final long serialVersionUID = 1L;
	
	private String  rn;
	private String  rowspan;
	private String  licenceId;
	private String  licenceName;
	private String  licenceLevel;
	private String  licenceVersion;
	private String  unitId;
	private String  unitCd;
	private String  unitName;
	private String  orders;
	
	public String getRn() {
		return rn;
	}
	public void setRn(String rn) {
		this.rn = rn;
	}
	public String getRowspan() {
		return rowspan;
	}
	public void setRowspan(String rowspan) {
		this.rowspan = rowspan;
	}
	public String getLicenceId() {
		return licenceId;
	}
	public void setLicenceId(String licenceId) {
		this.licenceId = licenceId;
	}
	public String getLicenceName() {
		return licenceName;
	}
	public void setLicenceName(String licenceName) {
		this.licenceName = licenceName;
	}
	public String getLicenceLevel() {
		return licenceLevel;
	}
	public void setLicenceLevel(String licenceLevel) {
		this.licenceLevel = licenceLevel;
	}
	
	public String getLicenceVersion() {
		return licenceVersion;
	}
	public void setLicenceVersion(String licenceVersion) {
		this.licenceVersion = licenceVersion;
	}
	
	public String getUnitId() {
		return unitId;
	}
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}
	public String getUnitCd() {
		return unitCd;
	}
	public void setUnitCd(String unitCd) {
		this.unitCd = unitCd;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public String getOrders() {
		return orders;
	}
	public void setOrders(String orders) {
		this.orders = orders;
	}
}
