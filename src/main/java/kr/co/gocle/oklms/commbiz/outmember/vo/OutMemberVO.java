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
package kr.co.gocle.oklms.commbiz.outmember.vo;

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
public class OutMemberVO extends BaseVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -999431964786813070L;
	/**
	 * 
	 */
	
	private String emplNo;        
	private String   loginId;        
	private String   loginPwd;       
	private String   koreanNm ;      
	private String   englNm   ;      
	private String   chcrtNm     ;   
	private String   frgnrSeCd  ;    
	private String   ihidnum     ;     
	private String   sexdstnCd   ;   
	private String   cprSeCd      ; 
	private String   hffcSttusCd  ; 
	private String   entschDe  ;      
	private String   retireDe    ;   
	private String   photo  ;          
	private String   telno    ;        
	private String   telnoPremis  ;   
	private String   mbtlnum   ;       
	private String   email        ;   
	private String   zip         ;     
	private String   adres1  ;         
	private String   adres2    ;      
	private String   chrgJob   ;       
	private String   regId     ;     
	private String   regDt    ;       
	private String   regIp     ;      
	private String   updId   ;        
	private String   updDt   ;      
	private String   updIp ;
	
	private String  memType ;
	private String companyId;
	private String authGroupId;
	private String memBirth;
	private String status;
	private String companyName;
	private String memSeq;
	private String sex;
	private String [] authGroupIds;
	private String compLicenceCd;
	private String compJoinDay;
	private String compTelNo;
	private String dutyNm;
	private String licenceFile;
	private String compStatusCd;
	private String compCareerYear;
	private String compEduLevelCd;
	private String compLicenceNm;
	
	public String getCompStatusCd() {
		return compStatusCd;
	}
	public void setCompStatusCd(String compStatusCd) {
		this.compStatusCd = compStatusCd;
	}
	public String getCompCareerYear() {
		return compCareerYear;
	}
	public void setCompCareerYear(String compCareerYear) {
		this.compCareerYear = compCareerYear;
	}
	public String getCompEduLevelCd() {
		return compEduLevelCd;
	}
	public void setCompEduLevelCd(String compEduLevelCd) {
		this.compEduLevelCd = compEduLevelCd;
	}
	public String getCompLicenceNm() {
		return compLicenceNm;
	}
	public void setCompLicenceNm(String compLicenceNm) {
		this.compLicenceNm = compLicenceNm;
	}
	
	public String getCompLicenceCd() {
		return compLicenceCd;
	}
	public void setCompLicenceCd(String compLicenceCd) {
		this.compLicenceCd = compLicenceCd;
	}
	public String getCompJoinDay() {
		return compJoinDay;
	}
	public void setCompJoinDay(String compJoinDay) {
		this.compJoinDay = compJoinDay;
	}
	public String getCompTelNo() {
		return compTelNo;
	}
	public void setCompTelNo(String compTelNo) {
		this.compTelNo = compTelNo;
	}
	public String getDutyNm() {
		return dutyNm;
	}
	public void setDutyNm(String dutyNm) {
		this.dutyNm = dutyNm;
	}
	public String getLicenceFile() {
		return licenceFile;
	}
	public void setLicenceFile(String licenceFile) {
		this.licenceFile = licenceFile;
	}
	
	public String[] getAuthGroupIds() {
		return authGroupIds;
	}
	public void setAuthGroupIds(String[] authGroupIds) {
		this.authGroupIds = authGroupIds;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMemBirth() {
		return memBirth;
	}
	public void setMemBirth(String memBirth) {
		this.memBirth = memBirth;
	}
	public String getMemType() {
		return memType;
	}
	public void setMemType(String memType) {
		this.memType = memType;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}

	public String getEmplNo() {
		return emplNo;
	}
	public void setEmplNo(String emplNo) {
		this.emplNo = emplNo;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginPwd() {
		return loginPwd;
	}
	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}
	public String getKoreanNm() {
		return koreanNm;
	}
	public void setKoreanNm(String koreanNm) {
		this.koreanNm = koreanNm;
	}
	public String getEnglNm() {
		return englNm;
	}
	public void setEnglNm(String englNm) {
		this.englNm = englNm;
	}
	public String getChcrtNm() {
		return chcrtNm;
	}
	public void setChcrtNm(String chcrtNm) {
		this.chcrtNm = chcrtNm;
	}
	public String getFrgnrSeCd() {
		return frgnrSeCd;
	}
	public void setFrgnrSeCd(String frgnrSeCd) {
		this.frgnrSeCd = frgnrSeCd;
	}
	public String getIhidnum() {
		return ihidnum;
	}
	public void setIhidnum(String ihidnum) {
		this.ihidnum = ihidnum;
	}
	public String getSexdstnCd() {
		return sexdstnCd;
	}
	public void setSexdstnCd(String sexdstnCd) {
		this.sexdstnCd = sexdstnCd;
	}
	public String getCprSeCd() {
		return cprSeCd;
	}
	public void setCprSeCd(String cprSeCd) {
		this.cprSeCd = cprSeCd;
	}
	public String getHffcSttusCd() {
		return hffcSttusCd;
	}
	public void setHffcSttusCd(String hffcSttusCd) {
		this.hffcSttusCd = hffcSttusCd;
	}
	public String getEntschDe() {
		return entschDe;
	}
	public void setEntschDe(String entschDe) {
		this.entschDe = entschDe;
	}
	public String getRetireDe() {
		return retireDe;
	}
	public void setRetireDe(String retireDe) {
		this.retireDe = retireDe;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getTelnoPremis() {
		return telnoPremis;
	}
	public void setTelnoPremis(String telnoPremis) {
		this.telnoPremis = telnoPremis;
	}
	public String getMbtlnum() {
		return mbtlnum;
	}
	public void setMbtlnum(String mbtlnum) {
		this.mbtlnum = mbtlnum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAdres1() {
		return adres1;
	}
	public void setAdres1(String adres1) {
		this.adres1 = adres1;
	}
	public String getAdres2() {
		return adres2;
	}
	public void setAdres2(String adres2) {
		this.adres2 = adres2;
	}
	public String getChrgJob() {
		return chrgJob;
	}
	public void setChrgJob(String chrgJob) {
		this.chrgJob = chrgJob;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getRegIp() {
		return regIp;
	}
	public void setRegIp(String regIp) {
		this.regIp = regIp;
	}
	public String getUpdId() {
		return updId;
	}
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	public String getUpdDt() {
		return updDt;
	}
	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}
	public String getUpdIp() {
		return updIp;
	}
	public void setUpdIp(String updIp) {
		this.updIp = updIp;
	}
	
	public String getEncryptShaPw(){
		return SecurityUtil.encryptSha256(loginPwd);
	}
}
