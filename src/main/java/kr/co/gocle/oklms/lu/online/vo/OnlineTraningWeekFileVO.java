package kr.co.gocle.oklms.lu.online.vo;

import java.io.Serializable;







import kr.co.gocle.oklms.comm.vo.BaseVO;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class OnlineTraningWeekFileVO extends BaseVO implements Serializable{
	
	private static final long serialVersionUID = -7340430331504665566L;
	
	private String fileSeq;
	private String weekId;
	private String fileSavePath;
	private String saveFileName;
	private String orgFileName;
	private String atchFileId;
	private String fileSn;
	
	public String getFileSn() {
		return fileSn;
	}


	public void setFileSn(String fileSn) {
		this.fileSn = fileSn;
	}


	public String getAtchFileId() {
		return atchFileId;
	}


	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}


	public String getFileSeq() {
		return fileSeq;
	}


	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}


	public String getWeekId() {
		return weekId;
	}


	public void setWeekId(String weekId) {
		this.weekId = weekId;
	}


	public String getFileSavePath() {
		return fileSavePath;
	}


	public void setFileSavePath(String fileSavePath) {
		this.fileSavePath = fileSavePath;
	}


	public String getSaveFileName() {
		return saveFileName;
	}


	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}


	public String getOrgFileName() {
		return orgFileName;
	}


	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	
	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }
	

}
