package kr.co.gocle.oklms.la.dept.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

public class DeptVO extends BaseVO implements Serializable{
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 8760759278133755105L;
	
	
	private String deptCd; // 과목코드
	private String deptName; // 과목명
	private String mstYn; // 고숙련여부
	
	private String runCnt1; // 1학년재학총원
	private String failCnt1; // 1학년중탈총원

	private String runCnt2; // 2학년재학총원
	private String failCnt2; // 2학년중탈총원
	
	private String runCnt3; // 3학년재학총원
	private String failCnt3; // 3학년중탈총원
	
	private String runCnt4; // 4학년재학총원
	private String failCnt4; // 4학년중탈총원
	
	private String runCnt5; // 5학년재학총원
	private String failCnt5; // 5학년중탈총원
	
	private String runCnt32; // 3학년편입재학총원
	private String failCnt32; // 3학년편입중탈총원
	
	private String runCnt42; // 4학년편입재학총원
	private String failCnt42; // 4학년편입중탈총원
	
	private String runCnt52; // 5학년편입재학총원
	private String failCnt52; // 5학년편입중탈총원	
	 
	 
	public String getDeptCd() {
		return deptCd;
	}
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getMstYn() {
		return mstYn;
	}
	public void setMstYn(String mstYn) {
		this.mstYn = mstYn;
	}
	public String getRunCnt1() {
		return runCnt1;
	}
	public void setRunCnt1(String runCnt1) {
		this.runCnt1 = runCnt1;
	}
	public String getFailCnt1() {
		return failCnt1;
	}
	public void setFailCnt1(String failCnt1) {
		this.failCnt1 = failCnt1;
	}
	public String getRunCnt2() {
		return runCnt2;
	}
	public void setRunCnt2(String runCnt2) {
		this.runCnt2 = runCnt2;
	}
	public String getFailCnt2() {
		return failCnt2;
	}
	public void setFailCnt2(String failCnt2) {
		this.failCnt2 = failCnt2;
	}
	public String getRunCnt3() {
		return runCnt3;
	}
	public void setRunCnt3(String runCnt3) {
		this.runCnt3 = runCnt3;
	}
	public String getFailCnt3() {
		return failCnt3;
	}
	public void setFailCnt3(String failCnt3) {
		this.failCnt3 = failCnt3;
	}
	public String getRunCnt4() {
		return runCnt4;
	}
	public void setRunCnt4(String runCnt4) {
		this.runCnt4 = runCnt4;
	}
	public String getFailCnt4() {
		return failCnt4;
	}
	public void setFailCnt4(String failCnt4) {
		this.failCnt4 = failCnt4;
	}
	public String getRunCnt5() {
		return runCnt5;
	}
	public void setRunCnt5(String runCnt5) {
		this.runCnt5 = runCnt5;
	}
	public String getFailCnt5() {
		return failCnt5;
	}
	public void setFailCnt5(String failCnt5) {
		this.failCnt5 = failCnt5;
	}
	public String getRunCnt32() {
		return runCnt32;
	}
	public void setRunCnt32(String runCnt32) {
		this.runCnt32 = runCnt32;
	}
	public String getFailCnt32() {
		return failCnt32;
	}
	public void setFailCnt32(String failCnt32) {
		this.failCnt32 = failCnt32;
	}
	public String getRunCnt42() {
		return runCnt42;
	}
	public void setRunCnt42(String runCnt42) {
		this.runCnt42 = runCnt42;
	}
	public String getFailCnt42() {
		return failCnt42;
	}
	public void setFailCnt42(String failCnt42) {
		this.failCnt42 = failCnt42;
	}
	public String getRunCnt52() {
		return runCnt52;
	}
	public void setRunCnt52(String runCnt52) {
		this.runCnt52 = runCnt52;
	}
	public String getFailCnt52() {
		return failCnt52;
	}
	public void setFailCnt52(String failCnt52) {
		this.failCnt52 = failCnt52;
	}
	
	
}
