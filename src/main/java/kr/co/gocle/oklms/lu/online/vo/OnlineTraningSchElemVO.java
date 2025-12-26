package kr.co.gocle.oklms.lu.online.vo;

import java.io.Serializable;







import kr.co.gocle.oklms.comm.vo.BaseVO;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class OnlineTraningSchElemVO extends BaseVO implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2481114028940676114L;
	/**
	 * 
	 */
	
	private String elemId   = "";
	private String weekId        = "";
	private String weekCnt      = "";
	private String subjSchId     = ""; 
	private String subjStep	= "";
	private String subjTitle = "";
	private String lesson_id        = "";
	private String lesson_item_id       = "";
	private String lesson_sub_item_id   = "";
	private String required_learning_time_in_seconds  = "";
	
	private String lessonId        = "";
	private String lessonItemId       = "";
	private String lessonSubItemId   = "";
	private String requiredLearningTimeInSeconds  = "";
	
	private String contentUrl;
	private String displayOrder;
	private String width;
	private String height;
	private String title;
	private String linkContentYn;
	

	private String contentType;
	private String contentsDir;
	private String contentsIdxFile;
	private String contentsRealFile;
    private String url;
	private String deviceTypeCode;
	public String getLesson_sub_item() {
		return lesson_sub_item;
	}


	public void setLesson_sub_item(String lesson_sub_item) {
		this.lesson_sub_item = lesson_sub_item;
	}


	private String lesson_sub_item   = "";
	
	
	public String getContentType() {
		return contentType;
	}


	public void setContentType(String contentType) {
		this.contentType = contentType;
	}


	public String getContentsDir() {
		return contentsDir;
	}


	public void setContentsDir(String contentsDir) {
		this.contentsDir = contentsDir;
	}


	public String getContentsIdxFile() {
		return contentsIdxFile;
	}


	public void setContentsIdxFile(String contentsIdxFile) {
		this.contentsIdxFile = contentsIdxFile;
	}


	public String getContentsRealFile() {
		return contentsRealFile;
	}


	public void setContentsRealFile(String contentsRealFile) {
		this.contentsRealFile = contentsRealFile;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public String getDeviceTypeCode() {
		return deviceTypeCode;
	}


	public void setDeviceTypeCode(String deviceTypeCode) {
		this.deviceTypeCode = deviceTypeCode;
	}
	
	public String getLessonProgress() {
		return lessonProgress;
	}


	public void setLessonProgress(String lessonProgress) {
		this.lessonProgress = lessonProgress;
	}


	public String getDisplay_order() {
		return display_order;
	}


	public void setDisplay_order(String display_order) {
		this.display_order = display_order;
	}


	private String lessonProgress;
	private String display_order;
	
	public String getLinkContentYn() {
		return linkContentYn;
	}


	public void setLinkContentYn(String linkContentYn) {
		this.linkContentYn = linkContentYn;
	}


	public String getSubjTitle() {
		return subjTitle;
	}


	public void setSubjTitle(String subjTitle) {
		this.subjTitle = subjTitle;
	}
	
	public String getContentUrl() {
		return contentUrl;
	}


	public void setContentUrl(String contentUrl) {
		this.contentUrl = contentUrl;
	}


	public String getDisplayOrder() {
		return displayOrder;
	}


	public void setDisplayOrder(String displayOrder) {
		this.displayOrder = displayOrder;
	}


	public String getWidth() {
		return width;
	}


	public void setWidth(String width) {
		this.width = width;
	}


	public String getHeight() {
		return height;
	}


	public void setHeight(String height) {
		this.height = height;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getLessonId() {
		return lessonId;
	}


	public void setLessonId(String lessonId) {
		this.lessonId = lessonId;
	}


	public String getLessonItemId() {
		return lessonItemId;
	}


	public void setLessonItemId(String lessonItemId) {
		this.lessonItemId = lessonItemId;
	}


	public String getLessonSubItemId() {
		return lessonSubItemId;
	}


	public void setLessonSubItemId(String lessonSubItemId) {
		this.lessonSubItemId = lessonSubItemId;
	}


	public String getRequiredLearningTimeInSeconds() {
		return requiredLearningTimeInSeconds;
	}


	public void setRequiredLearningTimeInSeconds(
			String requiredLearningTimeInSeconds) {
		this.requiredLearningTimeInSeconds = requiredLearningTimeInSeconds;
	}
	
	public String getElemId() {
		return elemId;
	}


	public void setElemId(String elemId) {
		this.elemId = elemId;
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


	public String getSubjSchId() {
		return subjSchId;
	}


	public void setSubjSchId(String subjSchId) {
		this.subjSchId = subjSchId;
	}


	public String getSubjStep() {
		return subjStep;
	}


	public void setSubjStep(String subjStep) {
		this.subjStep = subjStep;
	}


	public String getLesson_id() {
		return lesson_id;
	}


	public void setLesson_id(String lesson_id) {
		this.lesson_id = lesson_id;
	}


	public String getLesson_item_id() {
		return lesson_item_id;
	}


	public void setLesson_item_id(String lesson_item_id) {
		this.lesson_item_id = lesson_item_id;
	}


	public String getLesson_sub_item_id() {
		return lesson_sub_item_id;
	}


	public void setLesson_sub_item_id(String lesson_sub_item_id) {
		this.lesson_sub_item_id = lesson_sub_item_id;
	}


	public String getRequired_learning_time_in_seconds() {
		return required_learning_time_in_seconds;
	}


	public void setRequired_learning_time_in_seconds(
			String required_learning_time_in_seconds) {
		this.required_learning_time_in_seconds = required_learning_time_in_seconds;
	}
	

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }
	

}
