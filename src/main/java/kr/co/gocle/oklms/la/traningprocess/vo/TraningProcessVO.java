package kr.co.gocle.oklms.la.traningprocess.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class TraningProcessVO extends BaseVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6782900174167197826L;
	/**
	 * 
	 */
	private String traningProcessId; 			//훈련과정아이디
	private String traningProcessName; 			//훈련과정명
	private String traningProcessNo; 			//훈련과정번호
	private String traningProcessPeriod; 			//훈련과정회차
	private String deleteYn; 					//삭제여부
	private String startDate;
	private String endDate;
	private String year;
	private String traningStatusCd;  //훈련상태
	private String traningTypeCd;
	private String ncsLicenceName;
	private String ncsLicenceLevel;
	private String ncsLicenceVersion;
	private String ncsCode;
	private String ncsName;
	private String  centerGrade;
	private String centerBigo;
	
	private String formationTotal ;  // 편제총원
	private String trainingTotal ;  // 훈련총원
	private String trainingActionTotal ;  // 훈련실시총원
	private String recantTotal ;  // 참여철회 인원
	private String recantRatio ;  // 참여철회율
	
	private String trainingRealTotal ;  // 훈련중인원
	private String failTotal ;  // 중탈인원
	private String failRatio ;  // 중탈율
	private String finishTotal ;  // 이수인원
	private String finishRatio ;  // 이수율
	private String notFinishTotal ;  // 미이수인원
	private String notFinishRatio ;  // 미이수율
	private String completeTotal ;  // 수료인원
	private String completeRatio ;  // 수료율
	private String ojtclass;          //OJT분반
	private String insNames;       // OJT지도교수
	
	private String searchTraningTypeCd ;  // 검색컬럼
	private String ojtTimeHour;
	private String offTimeHour;
	private String ccnNames;
	private String companyName ;
	
	private String searchCompanyName ;  // 검색컬럼 기업명
	
	private String noteMonth;
	private String actMonth;
	private String processStatus;
	private String ojtMonthBiyong;
	private String offMonthBiyong;
	
	private String ccnMonth;
	private String ccnGrade;
	private String ccnBigo;
	private String prtGrade;
	private String prtBigo;
	
	private String totalTraning;
	private String runTraning;
	private String finishTraning;
	private String notFinishTraning;

	private String completeTraning;
	private String failTraning;
	private String recantTraning;
	
	private String allFailDate;
	private String deptName;
	private String transferYn;
	private String licenceId;
	private String deptNo;
	private String traningProcessManageId;
	private String companyId;
	private String deptTotalCnt;
	private String dept1;
	private String dept2;
	private String dept3;
	private String dept4;
	private String dept5;
	private String dept6;
	private String dept7;
	private String dept8;
	
	public String getDeptTotalCnt() {
		return deptTotalCnt;
	}
	public void setDeptTotalCnt(String deptTotalCnt) {
		this.deptTotalCnt = deptTotalCnt;
	}
	public String getDept1() {
		return dept1;
	}
	public void setDept1(String dept1) {
		this.dept1 = dept1;
	}
	public String getDept2() {
		return dept2;
	}
	public void setDept2(String dept2) {
		this.dept2 = dept2;
	}
	public String getDept3() {
		return dept3;
	}
	public void setDept3(String dept3) {
		this.dept3 = dept3;
	}
	public String getDept4() {
		return dept4;
	}
	public void setDept4(String dept4) {
		this.dept4 = dept4;
	}
	public String getDept5() {
		return dept5;
	}
	public void setDept5(String dept5) {
		this.dept5 = dept5;
	}
	public String getDept6() {
		return dept6;
	}
	public void setDept6(String dept6) {
		this.dept6 = dept6;
	}
	
	public String getNotFinishTraning() {
		return notFinishTraning;
	}
	public void setNotFinishTraning(String notFinishTraning) {
		this.notFinishTraning = notFinishTraning;
	}
	
	public String getNotFinishTotal() {
		return notFinishTotal;
	}
	public void setNotFinishTotal(String notFinishTotal) {
		this.notFinishTotal = notFinishTotal;
	}
	public String getNotFinishRatio() {
		return notFinishRatio;
	}
	public void setNotFinishRatio(String notFinishRatio) {
		this.notFinishRatio = notFinishRatio;
	}
	
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getTraningProcessManageId() {
		return traningProcessManageId;
	}
	public void setTraningProcessManageId(String traningProcessManageId) {
		this.traningProcessManageId = traningProcessManageId;
	}
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public String getLicenceId() {
		return licenceId;
	}
	public void setLicenceId(String licenceId) {
		this.licenceId = licenceId;
	}
	public String getTransferYn() {
		return transferYn;
	}
	public void setTransferYn(String transferYn) {
		this.transferYn = transferYn;
	}
	public String getAllFailDate() {
		return allFailDate;
	}
	public void setAllFailDate(String allFailDate) {
		this.allFailDate = allFailDate;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getTotalTraning() {
		return totalTraning;
	}
	public void setTotalTraning(String totalTraning) {
		this.totalTraning = totalTraning;
	}
	public String getRunTraning() {
		return runTraning;
	}
	public void setRunTraning(String runTraning) {
		this.runTraning = runTraning;
	}
	public String getFinishTraning() {
		return finishTraning;
	}
	public void setFinishTraning(String finishTraning) {
		this.finishTraning = finishTraning;
	}
	public String getCompleteTraning() {
		return completeTraning;
	}
	public void setCompleteTraning(String completeTraning) {
		this.completeTraning = completeTraning;
	}
	public String getFailTraning() {
		return failTraning;
	}
	public void setFailTraning(String failTraning) {
		this.failTraning = failTraning;
	}
	public String getRecantTraning() {
		return recantTraning;
	}
	public void setRecantTraning(String recantTraning) {
		this.recantTraning = recantTraning;
	}
	public String getNoteMonth() {
		return noteMonth;
	}
	public void setNoteMonth(String noteMonth) {
		this.noteMonth = noteMonth;
	}
	public String getActMonth() {
		return actMonth;
	}
	public void setActMonth(String actMonth) {
		this.actMonth = actMonth;
	}
	public String getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(String processStatus) {
		this.processStatus = processStatus;
	}
	public String getOjtMonthBiyong() {
		return ojtMonthBiyong;
	}
	public void setOjtMonthBiyong(String ojtMonthBiyong) {
		this.ojtMonthBiyong = ojtMonthBiyong;
	}
	public String getOffMonthBiyong() {
		return offMonthBiyong;
	}
	public void setOffMonthBiyong(String offMonthBiyong) {
		this.offMonthBiyong = offMonthBiyong;
	}
	public String getCcnMonth() {
		return ccnMonth;
	}
	public void setCcnMonth(String ccnMonth) {
		this.ccnMonth = ccnMonth;
	}
	public String getCcnGrade() {
		return ccnGrade;
	}
	public void setCcnGrade(String ccnGrade) {
		this.ccnGrade = ccnGrade;
	}
	public String getCcnBigo() {
		return ccnBigo;
	}
	public void setCcnBigo(String ccnBigo) {
		this.ccnBigo = ccnBigo;
	}
	public String getPrtGrade() {
		return prtGrade;
	}
	public void setPrtGrade(String prtGrade) {
		this.prtGrade = prtGrade;
	}
	public String getPrtBigo() {
		return prtBigo;
	}
	public void setPrtBigo(String prtBigo) {
		this.prtBigo = prtBigo;
	}
	public String getSearchCompanyName() {
		return searchCompanyName;
	}
	public void setSearchCompanyName(String searchCompanyName) {
		this.searchCompanyName = searchCompanyName;
	}
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCcnNames() {
		return ccnNames;
	}
	public void setCcnNames(String ccnNames) {
		this.ccnNames = ccnNames;
	}
	
	public String getOjtTimeHour() {
		return ojtTimeHour;
	}
	public void setOjtTimeHour(String ojtTimeHour) {
		this.ojtTimeHour = ojtTimeHour;
	}
	public String getOffTimeHour() {
		return offTimeHour;
	}
	public void setOffTimeHour(String offTimeHour) {
		this.offTimeHour = offTimeHour;
	}
	
	public String getSearchTraningTypeCd() {
		return searchTraningTypeCd;
	}
	public void setSearchTraningTypeCd(String searchTraningTypeCd) {
		this.searchTraningTypeCd = searchTraningTypeCd;
	}
	public String getFormationTotal() {
		return formationTotal;
	}
	public void setFormationTotal(String formationTotal) {
		this.formationTotal = formationTotal;
	}
	public String getTrainingTotal() {
		return trainingTotal;
	}
	public void setTrainingTotal(String trainingTotal) {
		this.trainingTotal = trainingTotal;
	}
	public String getTrainingActionTotal() {
		return trainingActionTotal;
	}
	public void setTrainingActionTotal(String trainingActionTotal) {
		this.trainingActionTotal = trainingActionTotal;
	}
	public String getRecantTotal() {
		return recantTotal;
	}
	public void setRecantTotal(String recantTotal) {
		this.recantTotal = recantTotal;
	}
	public String getRecantRatio() {
		return recantRatio;
	}
	public void setRecantRatio(String recantRatio) {
		this.recantRatio = recantRatio;
	}
	public String getTrainingRealTotal() {
		return trainingRealTotal;
	}
	public void setTrainingRealTotal(String trainingRealTotal) {
		this.trainingRealTotal = trainingRealTotal;
	}
	public String getFailTotal() {
		return failTotal;
	}
	public void setFailTotal(String failTotal) {
		this.failTotal = failTotal;
	}
	public String getFailRatio() {
		return failRatio;
	}
	public void setFailRatio(String failRatio) {
		this.failRatio = failRatio;
	}
	public String getFinishTotal() {
		return finishTotal;
	}
	public void setFinishTotal(String finishTotal) {
		this.finishTotal = finishTotal;
	}
	public String getFinishRatio() {
		return finishRatio;
	}
	public void setFinishRatio(String finishRatio) {
		this.finishRatio = finishRatio;
	}
	public String getCompleteTotal() {
		return completeTotal;
	}
	public void setCompleteTotal(String completeTotal) {
		this.completeTotal = completeTotal;
	}
	public String getCompleteRatio() {
		return completeRatio;
	}
	public void setCompleteRatio(String completeRatio) {
		this.completeRatio = completeRatio;
	}
	public String getOjtclass() {
		return ojtclass;
	}
	public void setOjtclass(String ojtclass) {
		this.ojtclass = ojtclass;
	}
	public String getInsNames() {
		return insNames;
	}
	public void setInsNames(String insNames) {
		this.insNames = insNames;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getTraningStatusCd() {
		return traningStatusCd;
	}
	public void setTraningStatusCd(String traningStatusCd) {
		this.traningStatusCd = traningStatusCd;
	}
	public String getTraningTypeCd() {
		return traningTypeCd;
	}
	public void setTraningTypeCd(String traningTypeCd) {
		this.traningTypeCd = traningTypeCd;
	}
	public String getNcsLicenceName() {
		return ncsLicenceName;
	}
	public void setNcsLicenceName(String ncsLicenceName) {
		this.ncsLicenceName = ncsLicenceName;
	}
	public String getNcsLicenceLevel() {
		return ncsLicenceLevel;
	}
	public void setNcsLicenceLevel(String ncsLicenceLevel) {
		this.ncsLicenceLevel = ncsLicenceLevel;
	}
	public String getNcsLicenceVersion() {
		return ncsLicenceVersion;
	}
	public void setNcsLicenceVersion(String ncsLicenceVersion) {
		this.ncsLicenceVersion = ncsLicenceVersion;
	}
	public String getNcsCode() {
		return ncsCode;
	}
	public void setNcsCode(String ncsCode) {
		this.ncsCode = ncsCode;
	}
	public String getNcsName() {
		return ncsName;
	}
	public void setNcsName(String ncsName) {
		this.ncsName = ncsName;
	}
	public String getCenterGrade() {
		return centerGrade;
	}
	public void setCenterGrade(String centerGrade) {
		this.centerGrade = centerGrade;
	}
	public String getCenterBigo() {
		return centerBigo;
	}
	public void setCenterBigo(String centerBigo) {
		this.centerBigo = centerBigo;
	}
	
	public String getTraningProcessPeriod() {
		return traningProcessPeriod;
	}
	public void setTraningProcessPeriod(String traningProcessPeriod) {
		this.traningProcessPeriod = traningProcessPeriod;
	}
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getTraningProcessId() {
		return traningProcessId;
	}
	public void setTraningProcessId(String traningProcessId) {
		this.traningProcessId = traningProcessId;
	}
	public String getTraningProcessName() {
		return traningProcessName;
	}
	public void setTraningProcessName(String traningProcessName) {
		this.traningProcessName = traningProcessName;
	}
	public String getTraningProcessNo() {
		return traningProcessNo;
	}
	public void setTraningProcessNo(String traningProcessNo) {
		this.traningProcessNo = traningProcessNo;
	}
	public String getDeleteYn() {
		return deleteYn;
	}
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}


	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
	public String getDept7() {
		return dept7;
	}
	public void setDept7(String dept7) {
		this.dept7 = dept7;
	}
	public String getDept8() {
		return dept8;
	}
	public void setDept8(String dept8) {
		this.dept8 = dept8;
	}
	

}
