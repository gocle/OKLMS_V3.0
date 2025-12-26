package kr.co.gocle.oklms.lu.traning.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * @author leejingeun
 *
 */
public class TraningVO extends BaseVO implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = -1329823451159588771L;

	private String traningProcessManageId;       //훈련과정관리아이디
	private String traningProcessId; 			//훈련과정아이디
	private String tempTraningProcessId;
	private String traningProcessIdArr;         //훈련과정아이디 배열
	private String companyId;					//기업아이디
	private String companyName;					//기업명
	private String hrdTraningNo; 				//HRD-NET 훈련과정번호
	private String hrdTraningName; 				//HRD-NET 훈련과정명
	private String traningProcessName; 			//훈련과정명
	private String traningProcessNo; 			//훈련과정번호
	private String deleteYn;					//삭제여부
	private String address;
	private String choiceDay;
	private String employInsManageNo;
	
	private String yyyy; 						//학년도
	private String term;						//학기
	private String subjectCode; 				//교과목코드
	private String subClass; 					//분반
	private String traningProcessPeriod;
	private String ojtClass;
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
	private String startDate;
	private String endDate;
	
	private String searchName;				  //회원 ID,NAME 검색값
	private String searchWord;				  //회원 검색어
	private String[] traningProcessManageIds;       //훈련과정관리아이디
	private String[] traningProcessManageIdss;       //훈련과정관리아이디
	private String[] prtGrades;
	private String[] prtBigos;
	private String[] ccnGrades;
	private String[] ccnBigos;
	private String year;
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String[] getCcnGrades() {
		return ccnGrades;
	}
	public void setCcnGrades(String[] ccnGrades) {
		this.ccnGrades = ccnGrades;
	}
	public String[] getCcnBigos() {
		return ccnBigos;
	}
	public void setCcnBigos(String[] ccnBigos) {
		this.ccnBigos = ccnBigos;
	}
	
	public String[] getPrtGrades() {
		return prtGrades;
	}
	public void setPrtGrades(String[] prtGrades) {
		this.prtGrades = prtGrades;
	}
	public String[] getPrtBigos() {
		return prtBigos;
	}
	public void setPrtBigos(String[] prtBigos) {
		this.prtBigos = prtBigos;
	}
	
	public String[] getTraningProcessManageIds() {
		return traningProcessManageIds;
	}
	public void setTraningProcessManageIds(String[] traningProcessManageIds) {
		this.traningProcessManageIds = traningProcessManageIds;
	}
	public String[] getTraningProcessManageIdss() {
		return traningProcessManageIdss;
	}
	public void setTraningProcessManageIdss(String[] traningProcessManageIdss) {
		this.traningProcessManageIdss = traningProcessManageIdss;
	}
	
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
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
	
	public String getOjtMonthBiyong() {
		return ojtMonthBiyong;
	}
	public void setOjtMonthBiyong(String ojtMonthBiyong) {
		this.ojtMonthBiyong = ojtMonthBiyong;
	}
	
	public String getOjtClass() {
		return ojtClass;
	}
	public void setOjtClass(String ojtClass) {
		this.ojtClass = ojtClass;
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
	
	public String getTraningProcessPeriod() {
		return traningProcessPeriod;
	}
	public void setTraningProcessPeriod(String traningProcessPeriod) {
		this.traningProcessPeriod = traningProcessPeriod;
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
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}
	public String getSubClass() {
		return subClass;
	}
	public void setSubClass(String subClass) {
		this.subClass = subClass;
	}

	public String getTraningProcessManageId() {
		return traningProcessManageId;
	}
	public void setTraningProcessManageId(String traningProcessManageId) {
		this.traningProcessManageId = traningProcessManageId;
	}
	public String getTraningProcessId() {
		return traningProcessId;
	}
	public void setTraningProcessId(String traningProcessId) {
		this.traningProcessId = traningProcessId;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
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
	public String getDeleteYn() {
		return deleteYn;
	}
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}
	public String getTraningProcessIdArr() {
		return traningProcessIdArr;
	}
	public void setTraningProcessIdArr(String traningProcessIdArr) {
		this.traningProcessIdArr = traningProcessIdArr;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getChoiceDay() {
		return choiceDay;
	}
	public void setChoiceDay(String choiceDay) {
		this.choiceDay = choiceDay;
	}
	public String getEmployInsManageNo() {
		return employInsManageNo;
	}
	public void setEmployInsManageNo(String employInsManageNo) {
		this.employInsManageNo = employInsManageNo;
	}
	public String getTempTraningProcessId() {
		return tempTraningProcessId;
	}
	public void setTempTraningProcessId(String tempTraningProcessId) {
		this.tempTraningProcessId = tempTraningProcessId;
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


	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }


}
