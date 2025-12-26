package kr.co.gocle.oklms.lu.activity.vo;

import java.io.Serializable;
import java.util.List;

import kr.co.gocle.oklms.comm.vo.BaseVO;

public class MemberVO extends BaseVO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2686077250858826567L;
	
	private String yyyy;
	private String term;
	private String subjectCode;
	private String classId;
	
	private String memName;
	private String memId;
	private String memSeq;
	private String[] memSeqs;
	private String lessonId;
	private String weekCnt;
	private String content;
	private String reqContent;
	private String atchFileId;
	private String orgFileName;
	
	private String companyId;
	private String companyName;
	private String searchCompanyName;
	private String searchName;
	private String searchId;
	private String planTime;
	private String studyTime;
	private int achievement;	
	private String timeHour;
	private  List<ActivityVO> arrActivityVO;
	private String outYn;
	
	public String getOutYn() {
		return outYn;
	}

	public void setOutYn(String outYn) {
		this.outYn = outYn;
	}
	
	public String getSearchId() {
		return searchId;
	}
	public void setSearchId(String searchId) {
		this.searchId = searchId;
	}
	
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	public List<ActivityVO> getArrActivityVO() {
		return arrActivityVO;
	}
	public void setArrActivityVO(List<ActivityVO> arrActivityVO) {
		this.arrActivityVO = arrActivityVO;
	}
	public String getStudyTime() {
		return studyTime;
	}
	public void setStudyTime(String studyTime) {
		this.studyTime = studyTime;
	}
	public String getTimeHour() {
		return timeHour;
	}
	public void setTimeHour(String timeHour) {
		this.timeHour = timeHour;
	}
	public String getPlanTime() {
		return planTime;
	}
	public void setPlanTime(String planTime) {
		this.planTime = planTime;
	} 
	public int getAchievement() {
		return achievement;
	}
	public void setAchievement(int achievement) {
		this.achievement = achievement;
	}
	public String getSearchCompanyName() {
		return searchCompanyName;
	}
	public void setSearchCompanyName(String searchCompanyName) {
		this.searchCompanyName = searchCompanyName;
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
	public String[] getMemSeqs() {
		return memSeqs;
	}
	public void setMemSeqs(String[] memSeqs) {
		this.memSeqs = memSeqs;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getWeekCnt() {
		return weekCnt;
	}
	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReqContent() {
		return reqContent;
	}
	public void setReqContent(String reqContent) {
		this.reqContent = reqContent;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
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
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
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
	public String getLessonId() {
		return lessonId;
	}
	public void setLessonId(String lessonId) {
		this.lessonId = lessonId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	public String getTermName() {
		String result = "";
		if("1".equals(term)){
			result = "1학기";
		} else if("2".equals(term)){
			result = "2학기";
		} else if("3".equals(term)){
			result = "여름학기";
		} else {
			result = "겨울학기";
		}
		return result;
	}
}
