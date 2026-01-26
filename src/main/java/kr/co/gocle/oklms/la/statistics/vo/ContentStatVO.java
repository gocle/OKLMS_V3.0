package kr.co.gocle.oklms.la.statistics.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

public class ContentStatVO extends BaseVO implements Serializable {

	private static final long serialVersionUID = 2991752675972687942L;

	/** 콘텐츠 마스터 정보 */
    private String courseContentId;     // 콘텐츠 ID
    private String institutionName;      // 산하기관
    private String developYear;          // 개발년도
    private String contentTitle;         // 콘텐츠명

    /** 차시 정보 */
    private String lessonId;               // 차시 ID
    private String lessonTitle;            // 차시명

    /** 통계 정보 */
    private String usedCourseCnt;        // 사용 과목 수
    private String studentCnt;           // 수강생 수

    private String registeredDate;

	public String getCourseContentId() {
		return courseContentId;
	}

	public void setCourseContentId(String courseContentId) {
		this.courseContentId = courseContentId;
	}

	public String getInstitutionName() {
		return institutionName;
	}

	public void setInstitutionName(String institutionName) {
		this.institutionName = institutionName;
	}

	public String getDevelopYear() {
		return developYear;
	}

	public void setDevelopYear(String developYear) {
		this.developYear = developYear;
	}

	public String getContentTitle() {
		return contentTitle;
	}

	public void setContentTitle(String contentTitle) {
		this.contentTitle = contentTitle;
	}

	public String getUsedCourseCnt() {
		return usedCourseCnt;
	}

	public void setUsedCourseCnt(String usedCourseCnt) {
		this.usedCourseCnt = usedCourseCnt;
	}

	public String getStudentCnt() {
		return studentCnt;
	}

	public void setStudentCnt(String studentCnt) {
		this.studentCnt = studentCnt;
	}

	public String getRegisteredDate() {
		return registeredDate;
	}

	public void setRegisteredDate(String registeredDate) {
		this.registeredDate = registeredDate;
	}

	public String getLessonId() {
		return lessonId;
	}

	public void setLessonId(String lessonId) {
		this.lessonId = lessonId;
	}

	public String getLessonTitle() {
		return lessonTitle;
	}

	public void setLessonTitle(String lessonTitle) {
		this.lessonTitle = lessonTitle;
	}
}
