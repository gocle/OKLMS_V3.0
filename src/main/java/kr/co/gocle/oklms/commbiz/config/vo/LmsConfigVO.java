
/*******************************************************************************
 * COPYRIGHT(C) 2020 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 최선호    2020. 01. 29.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.commbiz.config.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

import kr.co.gocle.oklms.comm.vo.BaseVO;

/**
* VO 클래스에 대한 내용을 작성한다.
* @author 최선호
* @since 2020. 01. 29.
*/
public class LmsConfigVO  extends BaseVO implements Serializable{

	private static final long serialVersionUID = -6151115994405518231L;

	private String confId;        
	private String optKey;     
	private String optValue;     
	private String optName;        
	private String optType;       
	private int optHidden;       
	private String optUnitText;    
	private String optHelp;         
	private String sitePrefix;     
	
	
	public String getConfId() {
		return confId;
	}
	public void setConfId(String confId) {
		this.confId = confId;
	}
	public String getOptKey() {
		return optKey;
	}
	public void setOptKey(String optKey) {
		this.optKey = optKey;
	}
	public String getOptValue() {
		return optValue;
	}
	public void setOptValue(String optValue) {
		this.optValue = optValue;
	}
	public String getOptName() {
		return optName;
	}
	public void setOptName(String optName) {
		this.optName = optName;
	}
	public String getOptType() {
		return optType;
	}
	public void setOptType(String optType) {
		this.optType = optType;
	}
	public int getOptHidden() {
		return optHidden;
	}
	public void setOptHidden(int optHidden) {
		this.optHidden = optHidden;
	}
	public String getOptUnitText() {
		return optUnitText;
	}
	public void setOptUnitText(String optUnitText) {
		this.optUnitText = optUnitText;
	}
	public String getOptHelp() {
		return optHelp;
	}
	public void setOptHelp(String optHelp) {
		this.optHelp = optHelp;
	}
	public String getSitePrefix() {
		return sitePrefix;
	}
	public void setSitePrefix(String sitePrefix) {
		this.sitePrefix = sitePrefix;
	}
	
	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }

}
