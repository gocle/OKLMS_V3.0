package kr.co.gocle.oklms.lu.activity.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

public class ActivityVO extends BaseVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6928437728272437463L;
	
	private String activityCnt;
	private String activityNoteId;
	private String yyyy;
	private String term;
	private String subjectCode;
	private String classId;
	private String weekCnt;
	private String traningType;
	private String state;
	private String memId;
	private String memSeq;
	private String memSeqs;
	private String memNm;	
	private String content;
	private String reqContent;
	private String atchFileId;
	private String projAtchFileId;
	private String fieldFeedback;	
	private String professorFeedback;
	private String searchCompanyName;
	private String searchName;
	private String searchId;
	private String addyn;
	private String dayOfWeek;
	private String traningDate;
	private String traningSt;
	private String traningEd;
	private String timeHour;
	private String timeMin;
	private String traningStHour;
	private String traningStMin;
	private String traningEdHour;
	private String traningEdMin; 
	private String weekId;
	private String timeId;
	private String review;
	private String planTime;
	private String studyTime;
	private int achievement=0;
	
	private String companyId;
	private String traningProcessId; 
	private String subjectTraningType;
	private String subjectName;
	
	private String status;
	private String statusUser;
	private String statusDate;
	private String returnComment;
	private String atchFileStr;
	private String [] activityNoteIds;
	private String subjectClass;
	private String companyName;
	private String ncsUnitName;
	private String memName;
	private String actSearchStatus;
	private String searchSubjectCode;
	
	private String searchMonth;
	private String insNames;
	private String tutNames;
	private String stdName;
	private String monthStrDate;
	private String monthEndDate;
    private String traningProcessName;
    
    public String getSearchId() {
		return searchId;
	}

	public void setSearchId(String searchId) {
		this.searchId = searchId;
	}
    
    public String getTutNames() {
		return tutNames;
	}

	public void setTutNames(String tutNames) {
		this.tutNames = tutNames;
	}
    
    public String getSearchMonth() {
		return searchMonth;
	}

	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}

	public String getInsNames() {
		return insNames;
	}

	public void setInsNames(String insNames) {
		this.insNames = insNames;
	}

	public String getStdName() {
		return stdName;
	}

	public void setStdName(String stdName) {
		this.stdName = stdName;
	}

	public String getMonthStrDate() {
		return monthStrDate;
	}

	public void setMonthStrDate(String monthStrDate) {
		this.monthStrDate = monthStrDate;
	}

	public String getMonthEndDate() {
		return monthEndDate;
	}

	public void setMonthEndDate(String monthEndDate) {
		this.monthEndDate = monthEndDate;
	}

	public String getTraningProcessName() {
		return traningProcessName;
	}

	public void setTraningProcessName(String traningProcessName) {
		this.traningProcessName = traningProcessName;
	}
	
	public String getSearchSubjectCode() {
		return searchSubjectCode;
	}

	public void setSearchSubjectCode(String searchSubjectCode) {
		this.searchSubjectCode = searchSubjectCode;
	}
	
	public String getActSearchStatus() {
		return actSearchStatus;
	}
	public void setActSearchStatus(String actSearchStatus) {
		this.actSearchStatus = actSearchStatus;
	}
	
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	
	public String getNcsUnitName() {
		return ncsUnitName;
	}
	public void setNcsUnitName(String ncsUnitName) {
		this.ncsUnitName = ncsUnitName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getSubjectClass() {
		return subjectClass;
	}
	public void setSubjectClass(String subjectClass) {
		this.subjectClass = subjectClass;
	}
	public String[] getActivityNoteIds() {
		return activityNoteIds;
	}
	public void setActivityNoteIds(String[] activityNoteIds) {
		this.activityNoteIds = activityNoteIds;
	}
	public String getAtchFileStr() {
		return atchFileStr;
	}
	public void setAtchFileStr(String atchFileStr) {
		this.atchFileStr = atchFileStr;
	}
	public String getReturnComment() {
		return returnComment;
	}
	public void setReturnComment(String returnComment) {
		this.returnComment = returnComment;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatusUser() {
		return statusUser;
	}
	public void setStatusUser(String statusUser) {
		this.statusUser = statusUser;
	}
	public String getStatusDate() {
		return statusDate;
	}
	public void setStatusDate(String statusDate) {
		this.statusDate = statusDate;
	}
	
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getSubjectTraningType() {
		return subjectTraningType;
	}
	public void setSubjectTraningType(String subjectTraningType) {
		this.subjectTraningType = subjectTraningType;
	}
	public String getActivityCnt() {
		return activityCnt;
	}
	public void setActivityCnt(String activityCnt) {
		this.activityCnt = activityCnt;
	}
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	public String getMemSeqs() {
		return memSeqs;
	}
	public void setMemSeqs(String memSeqs) {
		this.memSeqs = memSeqs;
	}
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getTraningProcessId() {
		return traningProcessId;
	}
	public void setTraningProcessId(String traningProcessId) {
		this.traningProcessId = traningProcessId;
	}
	public String getAddyn() {
		return addyn;
	}
	public void setAddyn(String addyn) {
		this.addyn = addyn;
	}
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public String getTraningDate() {
		return traningDate;
	}
	public void setTraningDate(String traningDate) {
		this.traningDate = traningDate;
	}
	public String getTraningSt() {
		return traningSt;
	}
	public void setTraningSt(String traningSt) {
		this.traningSt = traningSt;
	}
	public String getTraningEd() {
		return traningEd;
	}
	public void setTraningEd(String traningEd) {
		this.traningEd = traningEd;
	}
	public String getTimeHour() {
		return timeHour;
	}
	public void setTimeHour(String timeHour) {
		this.timeHour = timeHour;
	}
	public String getTimeMin() {
		return timeMin;
	}
	public void setTimeMin(String timeMin) {
		this.timeMin = timeMin;
	}
	public String getTraningStHour() {
		return traningStHour;
	}
	public void setTraningStHour(String traningStHour) {
		this.traningStHour = traningStHour;
	}
	public String getTraningStMin() {
		return traningStMin;
	}
	public void setTraningStMin(String traningStMin) {
		this.traningStMin = traningStMin;
	}
	public String getTraningEdHour() {
		return traningEdHour;
	}
	public void setTraningEdHour(String traningEdHour) {
		this.traningEdHour = traningEdHour;
	}
	public String getTraningEdMin() {
		return traningEdMin;
	}
	public void setTraningEdMin(String traningEdMin) {
		this.traningEdMin = traningEdMin;
	}
	public String getWeekId() {
		return weekId;
	}
	public void setWeekId(String weekId) {
		this.weekId = weekId;
	}
	public String getTimeId() {
		return timeId;
	}
	public void setTimeId(String timeId) {
		this.timeId = timeId;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public String getPlanTime() {
		return planTime;
	}
	public void setPlanTime(String planTime) {
		this.planTime = planTime;
	}
	public String getStudyTime() {
		return studyTime;
	}
	public void setStudyTime(String studyTime) {
		this.studyTime = studyTime;
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
	public String getActivityNoteId() {
		return activityNoteId;
	}
	public void setActivityNoteId(String activityNoteId) {
		this.activityNoteId = activityNoteId;
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
	public String getWeekCnt() {
		return weekCnt;
	}
	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}
	public String getTraningType() {
		return traningType;
	}
	public void setTraningType(String traningType) {
		this.traningType = traningType;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
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
	public String getProjAtchFileId() {
		return projAtchFileId;
	}
	public void setProjAtchFileId(String projAtchFileId) {
		this.projAtchFileId = projAtchFileId;
	}
	public String getFieldFeedback() {
		return fieldFeedback;
	}
	public void setFieldFeedback(String fieldFeedback) {
		this.fieldFeedback = fieldFeedback;
	}
	public String getProfessorFeedback() {
		return professorFeedback;
	}
	public void setProfessorFeedback(String professorFeedback) {
		this.professorFeedback = professorFeedback;
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
