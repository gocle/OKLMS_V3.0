
/*******************************************************************************
 * COPYRIGHT(C) 2016 WIZI LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of WIZI LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2016. 12. 28.        First Draft.
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.lu.subject.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

 /**
 * VO 클래스에 대한 내용을 작성한다.
 * @author 이진근
 * @since 2016. 12. 28.
 */
public class SubjectCompanyVO extends BaseVO implements Serializable{
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1623195581087203659L;
	/**
	 * 
	 */
	/**
	 * 
	 */
	
	private String yyyy                         ;	// 학년도                                 
	private String term                         ;	// 학기                       
	private String companyId;
	private String traningProcessId;
	private String companyName;
	private String hrdTraningNo; 				//HRD-NET 훈련과정번호
	private String hrdTraningName; 				//HRD-NET 훈련과정명
	private String hrdStartDate; 				
	private String hrdEndDate; 				
	private String weekId;
	private String weekCnt;
	private String noteSumCnt;
	private String evalPlanCnt;
	private String searchStatusType;
	private String memName;
	private String address;
	private String deptName;
	private String stuCnt;
	private String outCnt;
	private String ingCnt;
	private String tutNames;
	private String hrdNames;
	private String tutIds;
	private String hrdIds;
	private String tutInfos;
	private String hrdInfos;
	private String actNoteCnt;
	private String memInfos;
	private String infoNum;
	private String infoNums;
	private String subjectGrade;
	private String searchCompanyName;
	private String orderValue;
	private String orderType;
	private String [] infoNumArr;
	private int memInfosLength;
	private String traningProcessName;
	private String subjectName;
	private String subjectClass;
	private String ccmNames;
	private String subjectCode;
	private String subjectType;
	private String searchSchoolYear;
	
	public String getSearchSchoolYear() {
		return searchSchoolYear;
	}
	public void setSearchSchoolYear(String searchSchoolYear) {
		this.searchSchoolYear = searchSchoolYear;
	}
	public String getCcmNames() {
		return ccmNames;
	}
	public void setCcmNames(String ccmNames) {
		this.ccmNames = ccmNames;
	}
	
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getSubjectClass() {
		return subjectClass;
	}
	public void setSubjectClass(String subjectClass) {
		this.subjectClass = subjectClass;
	}
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}
	public String getSubjectType() {
		return subjectType;
	}
	public void setSubjectType(String subjectType) {
		this.subjectType = subjectType;
	}
	
	public String getTraningProcessName() {
		return traningProcessName;
	}
	public void setTraningProcessName(String traningProcessName) {
		this.traningProcessName = traningProcessName;
	}
	public String getTutIds() {
		return tutIds;
	}
	public void setTutIds(String tutIds) {
		this.tutIds = tutIds;
	}
	public String getHrdIds() {
		return hrdIds;
	}
	public void setHrdIds(String hrdIds) {
		this.hrdIds = hrdIds;
	}
	public String getTutInfos() {
		return tutInfos;
	}
	public void setTutInfos(String tutInfos) {
		this.tutInfos = tutInfos;
	}
	public String getHrdInfos() {
		return hrdInfos;
	}
	public void setHrdInfos(String hrdInfos) {
		this.hrdInfos = hrdInfos;
	}
	
	public String getSearchCompanyName() {
		return searchCompanyName;
	}
	public void setSearchCompanyName(String searchCompanyName) {
		this.searchCompanyName = searchCompanyName;
	}
	
	public String getTraningProcessId() {
		return traningProcessId;
	}
	public void setTraningProcessId(String traningProcessId) {
		this.traningProcessId = traningProcessId;
	}
	
	public String getSubjectGrade() {
		return subjectGrade;
	}
	public void setSubjectGrade(String subjectGrade) {
		this.subjectGrade = subjectGrade;
	}
	public String getTutNames() {
		return tutNames;
	}
	public void setTutNames(String tutNames) {
		this.tutNames = tutNames;
	}
	public String getHrdNames() {
		return hrdNames;
	}
	public void setHrdNames(String hrdNames) {
		this.hrdNames = hrdNames;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getStuCnt() {
		return stuCnt;
	}
	public void setStuCnt(String stuCnt) {
		this.stuCnt = stuCnt;
	}
	public String getOutCnt() {
		return outCnt;
	}
	public void setOutCnt(String outCnt) {
		this.outCnt = outCnt;
	}
	public String getIngCnt() {
		return ingCnt;
	}
	public void setIngCnt(String ingCnt) {
		this.ingCnt = ingCnt;
	}
	public String getInfoNum() {
		return infoNum;
	}
	public void setInfoNum(String infoNum) {
		this.infoNum = infoNum;
	}
	public String getInfoNums() {
		return infoNums;
	}
	public void setInfoNums(String infoNums) {
		this.infoNums = infoNums;
	}
	public String[] getInfoNumArr() {
		return infoNumArr;
	}
	public void setInfoNumArr(String[] infoNumArr) {
		this.infoNumArr = infoNumArr;
	}
	public int getMemInfosLength() {
		return memInfosLength;
	}
	public void setMemInfosLength(int memInfosLength) {
		this.memInfosLength = memInfosLength;
	}
	public String getMemInfos() {
		return memInfos;
	}
	public void setMemInfos(String memInfos) {
		this.memInfos = memInfos;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getActNoteCnt() {
		return actNoteCnt;
	}
	public void setActNoteCnt(String actNoteCnt) {
		this.actNoteCnt = actNoteCnt;
	}
	
	public String getSearchStatusType() {
		return searchStatusType;
	}
	public void setSearchStatusType(String searchStatusType) {
		this.searchStatusType = searchStatusType;
	}
	public String getYyyy() {
		return yyyy;
	}
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getHrdTraningNo() {
		return hrdTraningNo;
	}
	public void setHrdTraningNo(String hrdTraningNo) {
		this.hrdTraningNo = hrdTraningNo;
	}
	public String getHrdTraningName() {
		return hrdTraningName;
	}
	public void setHrdTraningName(String hrdTraningName) {
		this.hrdTraningName = hrdTraningName;
	}
	public String getHrdStartDate() {
		return hrdStartDate;
	}
	public void setHrdStartDate(String hrdStartDate) {
		this.hrdStartDate = hrdStartDate;
	}
	public String getHrdEndDate() {
		return hrdEndDate;
	}
	public void setHrdEndDate(String hrdEndDate) {
		this.hrdEndDate = hrdEndDate;
	}
	public String getWeekId() {
		return weekId;
	}
	public void setWeekId(String weekId) {
		this.weekId = weekId;
	}
	public String getWeekCnt() {
		return weekCnt;
	}
	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}
	public String getNoteSumCnt() {
		return noteSumCnt;
	}
	public void setNoteSumCnt(String noteSumCnt) {
		this.noteSumCnt = noteSumCnt;
	}
	public String getEvalPlanCnt() {
		return evalPlanCnt;
	}
	public void setEvalPlanCnt(String evalPlanCnt) {
		this.evalPlanCnt = evalPlanCnt;
	}
	public String getOrderValue() {
		return orderValue;
	}
	public void setOrderValue(String orderValue) {
		this.orderValue = orderValue;
	}
	
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
}
