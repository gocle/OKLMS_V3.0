package kr.co.gocle.oklms.lu.traningstatus.vo;
 
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;

public class TraningStatusVO extends TraningNoteVO {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5437941623232546407L;
	
	private String subClass;	
	private String allTimeHour;
	private String allTimeHourNow;
	private String allOnAvgProgressRate;
	private String realProgressRate;
	private String onRealProgressRate;
	
	private String attendRate;
	private String onlineAttendRate;
	
	private String searchClass;
	private String searchMemName;	
	private String searchStartRate;
	private String searchEndRate;

	private String searchMemNameDetail;	
	private String searchStartRateDetail;
	private String searchEndRateDetail;
	
	private String searchType;
	
	private String totalTime;
	private String attend;
	private String lateness; 

	private String onTotalTime;
	private String onAttend;
	private String onLateness; 

	private String content;
	private String nextWeek;
	private String te1;
	private String te2;
	private String te3;
	private String te4;
	private String te5;
	private String te6;
	private String te7;
	private String te8;
	private String te9;
	private String te10;
	private String te11;
	private String te12;
	private String te13;
	private String te14;
	private String te15;
	
	
	private String week1;
	private String week2;
	private String week3;
	private String week4;
	private String week5;
	private String week6;
	private String week7;
	private String week8;
	private String week9;
	private String week10;
	private String week11;
	private String week12;
	private String week13;
	private String week14;
	private String week15;
	private String onlineTypeName;
	private String deptName;
	private String weekLen;
	private String subjectType;
	private String onlineType;
	private String subjectTraningTypeName;
	private String point;
	private String insNames;
	private String year;
	
	private String yyyy;
	private String subjectCode;
	private String subjectName;
	private String subjectClass;
	private String yySemstrNm;
	private String ncsUnitId;
	private String ncsUnitName;
	private String offAttGoal;
	private String offAttCompl;
	private String achvYn;
	private String grd;
	private String reCorsYn;
	private String subjectTraningType;
	private String onAttCompl;
	private String onAttGoal;
	private String searchTab;
	private String term;
	private String weekCnt;
	private String noteCnt;
	private String actCnt;
	private String stdName;
	private String stdId;
	private String subjectGrade;
	private String searchMemId;
	private String departmentName;
	private String actCnt1;
	private String actCnt2;
	private String actCnt3;
	private String actMaxCnt;
	private String noteCnt1;
	private String noteCnt2;
	private String noteCnt3;
	private String noteMaxCnt;
	private String lessonId;
	private String passYn;
	private String grade;
	private String traningProcessManageId;
	private String searchYyyy;
	private String searchTerm;
	private String searchSubjectCode;
	private String searchSubjectClass;
	private String ncsCnt;
	private String absDay;
	private String outYn;
	private String lessonCnt;
	private String tutNames;
	
	public String getLessonCnt() {
		return lessonCnt;
	}

	public void setLessonCnt(String lessonCnt) {
		this.lessonCnt = lessonCnt;
	}

	public String getTutNames() {
		return tutNames;
	}

	public void setTutNames(String tutNames) {
		this.tutNames = tutNames;
	}
	
	public String getOutYn() {
		return outYn;
	}

	public void setOutYn(String outYn) {
		this.outYn = outYn;
	}
	
	public String getAbsDay() {
		return absDay;
	}


	public void setAbsDay(String absDay) {
		this.absDay = absDay;
	}


	public String getNcsCnt() {
		return ncsCnt;
	}


	public void setNcsCnt(String ncsCnt) {
		this.ncsCnt = ncsCnt;
	}


	public String getSearchYyyy() {
		return searchYyyy;
	}


	public void setSearchYyyy(String searchYyyy) {
		this.searchYyyy = searchYyyy;
	}


	public String getSearchTerm() {
		return searchTerm;
	}


	public void setSearchTerm(String searchTerm) {
		this.searchTerm = searchTerm;
	}


	public String getSearchSubjectCode() {
		return searchSubjectCode;
	}


	public void setSearchSubjectCode(String searchSubjectCode) {
		this.searchSubjectCode = searchSubjectCode;
	}


	public String getSearchSubjectClass() {
		return searchSubjectClass;
	}


	public void setSearchSubjectClass(String searchSubjectClass) {
		this.searchSubjectClass = searchSubjectClass;
	}
	
	public String getTraningProcessManageId() {
		return traningProcessManageId;
	}


	public void setTraningProcessManageId(String traningProcessManageId) {
		this.traningProcessManageId = traningProcessManageId;
	}


	public String getLessonId() {
		return lessonId;
	}


	public void setLessonId(String lessonId) {
		this.lessonId = lessonId;
	}


	public String getPassYn() {
		return passYn;
	}


	public void setPassYn(String passYn) {
		this.passYn = passYn;
	}


	public String getGrade() {
		return grade;
	}


	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public String getDepartmentName() {
		return departmentName;
	}


	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}


	public String getActCnt1() {
		return actCnt1;
	}


	public void setActCnt1(String actCnt1) {
		this.actCnt1 = actCnt1;
	}


	public String getActCnt2() {
		return actCnt2;
	}


	public void setActCnt2(String actCnt2) {
		this.actCnt2 = actCnt2;
	}


	public String getActCnt3() {
		return actCnt3;
	}


	public void setActCnt3(String actCnt3) {
		this.actCnt3 = actCnt3;
	}


	public String getActMaxCnt() {
		return actMaxCnt;
	}


	public void setActMaxCnt(String actMaxCnt) {
		this.actMaxCnt = actMaxCnt;
	}


	public String getNoteCnt1() {
		return noteCnt1;
	}


	public void setNoteCnt1(String noteCnt1) {
		this.noteCnt1 = noteCnt1;
	}


	public String getNoteCnt2() {
		return noteCnt2;
	}


	public void setNoteCnt2(String noteCnt2) {
		this.noteCnt2 = noteCnt2;
	}


	public String getNoteCnt3() {
		return noteCnt3;
	}


	public void setNoteCnt3(String noteCnt3) {
		this.noteCnt3 = noteCnt3;
	}


	public String getNoteMaxCnt() {
		return noteMaxCnt;
	}


	public void setNoteMaxCnt(String noteMaxCnt) {
		this.noteMaxCnt = noteMaxCnt;
	}
	
	public String getSearchMemId() {
		return searchMemId;
	}


	public void setSearchMemId(String searchMemId) {
		this.searchMemId = searchMemId;
	}


	public String getSubjectGrade() {
		return subjectGrade;
	}


	public void setSubjectGrade(String subjectGrade) {
		this.subjectGrade = subjectGrade;
	}


	public String getStdName() {
		return stdName;
	}


	public void setStdName(String stdName) {
		this.stdName = stdName;
	}


	public String getStdId() {
		return stdId;
	}


	public void setStdId(String stdId) {
		this.stdId = stdId;
	}
	
	public String getTerm() {
		return term;
	}


	public void setTerm(String term) {
		this.term = term;
	}


	public String getWeekCnt() {
		return weekCnt;
	}


	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}


	public String getNoteCnt() {
		return noteCnt;
	}


	public void setNoteCnt(String noteCnt) {
		this.noteCnt = noteCnt;
	}


	public String getActCnt() {
		return actCnt;
	}


	public void setActCnt(String actCnt) {
		this.actCnt = actCnt;
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

	
	public String getSearchTab() {
		return searchTab;
	}
	public void setSearchTab(String searchTab) {
		this.searchTab = searchTab;
	}
	public String getNcsUnitName() {
		return ncsUnitName;
	}
	public void setNcsUnitName(String ncsUnitName) {
		this.ncsUnitName = ncsUnitName;
	}
	
	
	public String getYyyy() {
		return yyyy;
	}
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
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
	public String getYySemstrNm() {
		return yySemstrNm;
	}
	public void setYySemstrNm(String yySemstrNm) {
		this.yySemstrNm = yySemstrNm;
	}
	public String getNcsUnitId() {
		return ncsUnitId;
	}
	public void setNcsUnitId(String ncsUnitId) {
		this.ncsUnitId = ncsUnitId;
	}
	public String getOffAttGoal() {
		return offAttGoal;
	}
	public void setOffAttGoal(String offAttGoal) {
		this.offAttGoal = offAttGoal;
	}
	public String getOffAttCompl() {
		return offAttCompl;
	}
	public void setOffAttCompl(String offAttCompl) {
		this.offAttCompl = offAttCompl;
	}
	public String getAchvYn() {
		return achvYn;
	}
	public void setAchvYn(String achvYn) {
		this.achvYn = achvYn;
	}
	public String getGrd() {
		return grd;
	}
	public void setGrd(String grd) {
		this.grd = grd;
	}
	public String getReCorsYn() {
		return reCorsYn;
	}
	public void setReCorsYn(String reCorsYn) {
		this.reCorsYn = reCorsYn;
	}
	public String getSubjectTraningType() {
		return subjectTraningType;
	}
	public void setSubjectTraningType(String subjectTraningType) {
		this.subjectTraningType = subjectTraningType;
	}
	public String getOnAttCompl() {
		return onAttCompl;
	}
	public void setOnAttCompl(String onAttCompl) {
		this.onAttCompl = onAttCompl;
	}
	public String getOnAttGoal() {
		return onAttGoal;
	}
	public void setOnAttGoal(String onAttGoal) {
		this.onAttGoal = onAttGoal;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getInsNames() {
		return insNames;
	}
	public void setInsNames(String insNames) {
		this.insNames = insNames;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	
	public String getSubjectTraningTypeName() {
		return subjectTraningTypeName;
	}
	public void setSubjectTraningTypeName(String subjectTraningTypeName) {
		this.subjectTraningTypeName = subjectTraningTypeName;
	}
	public String getSubjectType() {
		return subjectType;
	}
	public void setSubjectType(String subjectType) {
		this.subjectType = subjectType;
	}
	public String getOnlineType() {
		return onlineType;
	}
	public void setOnlineType(String onlineType) {
		this.onlineType = onlineType;
	}
	
	public String getWeekLen() {
		return weekLen;
	}
	public void setWeekLen(String weekLen) {
		this.weekLen = weekLen;
	}
	public String getWeek1() {
		return week1;
	}
	public void setWeek1(String week1) {
		this.week1 = week1;
	}
	public String getWeek2() {
		return week2;
	}
	public void setWeek2(String week2) {
		this.week2 = week2;
	}
	public String getWeek3() {
		return week3;
	}
	public void setWeek3(String week3) {
		this.week3 = week3;
	}
	public String getWeek4() {
		return week4;
	}
	public void setWeek4(String week4) {
		this.week4 = week4;
	}
	public String getWeek5() {
		return week5;
	}
	public void setWeek5(String week5) {
		this.week5 = week5;
	}
	public String getWeek6() {
		return week6;
	}
	public void setWeek6(String week6) {
		this.week6 = week6;
	}
	public String getWeek7() {
		return week7;
	}
	public void setWeek7(String week7) {
		this.week7 = week7;
	}
	public String getWeek8() {
		return week8;
	}
	public void setWeek8(String week8) {
		this.week8 = week8;
	}
	public String getWeek9() {
		return week9;
	}
	public void setWeek9(String week9) {
		this.week9 = week9;
	}
	public String getWeek10() {
		return week10;
	}
	public void setWeek10(String week10) {
		this.week10 = week10;
	}
	public String getWeek11() {
		return week11;
	}
	public void setWeek11(String week11) {
		this.week11 = week11;
	}
	public String getWeek12() {
		return week12;
	}
	public void setWeek12(String week12) {
		this.week12 = week12;
	}
	public String getWeek13() {
		return week13;
	}
	public void setWeek13(String week13) {
		this.week13 = week13;
	}
	public String getWeek14() {
		return week14;
	}
	public void setWeek14(String week14) {
		this.week14 = week14;
	}
	public String getWeek15() {
		return week15;
	}
	public void setWeek15(String week15) {
		this.week15 = week15;
	}
	public String getOnlineTypeName() {
		return onlineTypeName;
	}
	public void setOnlineTypeName(String onlineTypeName) {
		this.onlineTypeName = onlineTypeName;
	}
	
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getNextWeek() {
		return nextWeek;
	}
	public void setNextWeek(String nextWeek) {
		this.nextWeek = nextWeek;
	}
	public String getTe1() {
		return te1;
	}
	public void setTe1(String te1) {
		this.te1 = te1;
	}
	public String getTe2() {
		return te2;
	}
	public void setTe2(String te2) {
		this.te2 = te2;
	}
	public String getTe3() {
		return te3;
	}
	public void setTe3(String te3) {
		this.te3 = te3;
	}
	public String getTe4() {
		return te4;
	}
	public void setTe4(String te4) {
		this.te4 = te4;
	}
	public String getTe5() {
		return te5;
	}
	public void setTe5(String te5) {
		this.te5 = te5;
	}
	public String getTe6() {
		return te6;
	}
	public void setTe6(String te6) {
		this.te6 = te6;
	}
	public String getTe7() {
		return te7;
	}
	public void setTe7(String te7) {
		this.te7 = te7;
	}
	public String getTe8() {
		return te8;
	}
	public void setTe8(String te8) {
		this.te8 = te8;
	}
	public String getTe9() {
		return te9;
	}
	public void setTe9(String te9) {
		this.te9 = te9;
	}
	public String getTe10() {
		return te10;
	}
	public void setTe10(String te10) {
		this.te10 = te10;
	}
	public String getTe11() {
		return te11;
	}
	public void setTe11(String te11) {
		this.te11 = te11;
	}
	public String getTe12() {
		return te12;
	}
	public void setTe12(String te12) {
		this.te12 = te12;
	}
	public String getTe13() {
		return te13;
	}
	public void setTe13(String te13) {
		this.te13 = te13;
	}
	public String getTe14() {
		return te14;
	}
	public void setTe14(String te14) {
		this.te14 = te14;
	}
	public String getTe15() {
		return te15;
	}
	public void setTe15(String te15) {
		this.te15 = te15;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSearchMemNameDetail() {
		return searchMemNameDetail;
	}
	public void setSearchMemNameDetail(String searchMemNameDetail) {
		this.searchMemNameDetail = searchMemNameDetail;
	}
	public String getSearchStartRateDetail() {
		return searchStartRateDetail;
	}
	public void setSearchStartRateDetail(String searchStartRateDetail) {
		this.searchStartRateDetail = searchStartRateDetail;
	}
	public String getSearchEndRateDetail() {
		return searchEndRateDetail;
	}
	public void setSearchEndRateDetail(String searchEndRateDetail) {
		this.searchEndRateDetail = searchEndRateDetail;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getOnRealProgressRate() {
		return onRealProgressRate;
	}
	public void setOnRealProgressRate(String onRealProgressRate) {
		this.onRealProgressRate = onRealProgressRate;
	}
	public String getOnTotalTime() {
		return onTotalTime;
	}
	public void setOnTotalTime(String onTotalTime) {
		this.onTotalTime = onTotalTime;
	}
	public String getOnAttend() {
		return onAttend;
	}
	public void setOnAttend(String onAttend) {
		this.onAttend = onAttend;
	}
	public String getOnLateness() {
		return onLateness;
	}
	public void setOnLateness(String onLateness) {
		this.onLateness = onLateness;
	}
	public String getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}
	public String getAttend() {
		return attend;
	}
	public void setAttend(String attend) {
		this.attend = attend;
	}
	public String getLateness() {
		return lateness;
	}
	public void setLateness(String lateness) {
		this.lateness = lateness;
	}
	public String getAllTimeHour() {
		return allTimeHour;
	}
	public void setAllTimeHour(String allTimeHour) {
		this.allTimeHour = allTimeHour;
	}
	public String getAllTimeHourNow() {
		return allTimeHourNow;
	}
	public void setAllTimeHourNow(String allTimeHourNow) {
		this.allTimeHourNow = allTimeHourNow;
	}
	public String getRealProgressRate() {
		return realProgressRate;
	}
	public void setRealProgressRate(String realProgressRate) {
		this.realProgressRate = realProgressRate;
	}

	public String getSubClass() {
		return subClass;
	}
	public void setSubClass(String subClass) {
		this.subClass = subClass;
	}
	public String getAttendRate() {
		return attendRate;
	}
	public void setAttendRate(String attendRate) {
		this.attendRate = attendRate;
	}
	public String getOnlineAttendRate() {
		return onlineAttendRate;
	}
	public void setOnlineAttendRate(String onlineAttendRate) {
		this.onlineAttendRate = onlineAttendRate;
	}
	public String getSearchClass() {
		return searchClass;
	}
	public void setSearchClass(String searchClass) {
		this.searchClass = searchClass;
	}
	public String getSearchMemName() {
		return searchMemName;
	}
	public void setSearchMemName(String searchMemName) {
		this.searchMemName = searchMemName;
	}
	public String getSearchStartRate() {
		return searchStartRate;
	}
	public void setSearchStartRate(String searchStartRate) {
		this.searchStartRate = searchStartRate;
	}
	public String getSearchEndRate() {
		return searchEndRate;
	}
	public void setSearchEndRate(String searchEndRate) {
		this.searchEndRate = searchEndRate;
	}
	public String getAllOnAvgProgressRate() {
		return allOnAvgProgressRate;
	}
	public void setAllOnAvgProgressRate(String allOnAvgProgressRate) {
		this.allOnAvgProgressRate = allOnAvgProgressRate;
	}
	
	
}
