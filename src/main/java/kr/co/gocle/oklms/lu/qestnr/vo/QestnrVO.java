/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2017. 04. 10.         First Draft.
 *
 *******************************************************************************/
package kr.co.gocle.oklms.lu.qestnr.vo;

import java.io.Serializable;

import kr.co.gocle.oklms.comm.vo.BaseVO;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class QestnrVO extends BaseVO implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = -8896862284083878758L;
	private String yyyy = "";
	private String term = "";
	private String subjectCode = "";
	private String subClass = "";

	private String qestnrId = "";         //설문지ID
	private String qustnrQesitmId = "";   //설문문항ID
	private String qustnrSj = "";         //설문제목
	private String qustnrPurps = "";      //설문목적
	private String qustnrAnswer = "";      //설문정답
	private String qustnrStartDate = "";  //설문시작일
	private String qustnrEndDate = "";    //설문종료일
	private String currentDt = "";    	  //현재일
	private String etcAnswerAt = "";      //기타답변여부(Y:기타입력있음, N:기타입력없음)
	private String qestnSn = "";          //질문순번
	private String qestnCn1 = "";         //질문내용1
	private String qestnCn2 = "";         //질문내용2
	private String qestnCn3 = "";         //질문내용3
	private String qestnCn4 = "";         //질문내용4
	private String qestnCn5 = "";         //질문내용5
	private String qestnCn6 = "";         //질문내용6
	private String qestnCn7 = "";         //질문내용7
	private String qestnCn8 = "";         //질문내용8
	private String qestnCn9 = "";         //질문내용9
	private String qestnCn10 = "";         //질문내용10	
	
	private String qestnCn = "";         //질문내용
	
	private String qestnAnswerSn = ""; //질문답변순번
	
	private String qestnAnswerSn1 = ""; //질문답변순번1
	private String qestnAnswerSn2 = ""; //질문답변순번2
	private String qestnAnswerSn3 = ""; //질문답변순번3
	private String qestnAnswerSn4 = ""; //질문답변순번4
	private String qestnAnswerSn5 = ""; //질문답변순번5
	private String qestnAnswerSn6 = ""; //질문답변순번6
	private String qestnAnswerSn7 = ""; //질문답변순번7
	private String qestnAnswerSn8 = ""; //질문답변순번8
	private String qestnAnswerSn9 = ""; //질문답변순번9
	private String qestnAnswerSn10 = ""; //질문답변순번10	
	private String qestnAnswerSn11 = ""; //질문답변(기타)
	
	private String qestnAnswerPercent1 = ""; //질문답변순번1
	private String qestnAnswerPercent2 = ""; //질문답변순번2
	private String qestnAnswerPercent3 = ""; //질문답변순번3
	private String qestnAnswerPercent4 = ""; //질문답변순번4
	private String qestnAnswerPercent5 = ""; //질문답변순번5
	private String qestnAnswerPercent6 = ""; //질문답변순번6
	private String qestnAnswerPercent7 = ""; //질문답변순번7
	private String qestnAnswerPercent8 = ""; //질문답변순번8
	private String qestnAnswerPercent9 = ""; //질문답변순번9
	private String qestnAnswerPercent10 = ""; //질문답변순번10	
	private String qestnAnswerPercent11 = ""; //질문답변(기타)
	
	private String status = "";  		  //상태(1:진행 2:종료)
	private String etcAnswerCn = "";      //기타답변내용
	private String searchStatus = "";
	private String searchJoinAt = "";
	private String progrressStatus = "";
	private String dayOfWeekStart = "";
	private String dayOfWeekEnd = "";
	private String memSeq = "";
	private String memName = "";
	private String memId = "";
	private String joinAt = "";
	private String answerResultCnt = "";
	private String lessonStdCnt = "";

	private String tmpQestnrIdArr[];
	
	
	public String[] getTmpQestnrIdArr() {
		return tmpQestnrIdArr;
	}
	public void setTmpQestnrIdArr(String[] tmpQestnrIdArr) {
		this.tmpQestnrIdArr = tmpQestnrIdArr;
	}
	public String getQustnrAnswer() {
		return qustnrAnswer;
	}
	public void setQustnrAnswer(String qustnrAnswer) {
		this.qustnrAnswer = qustnrAnswer;
	}
	public String getQestnCn() {
		return qestnCn;
	}
	public void setQestnCn(String qestnCn) {
		this.qestnCn = qestnCn;
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
	public String getQestnrId() {
		return qestnrId;
	}
	public void setQestnrId(String qestnrId) {
		this.qestnrId = qestnrId;
	}
	public String getQustnrQesitmId() {
		return qustnrQesitmId;
	}
	public void setQustnrQesitmId(String qustnrQesitmId) {
		this.qustnrQesitmId = qustnrQesitmId;
	}
	public String getQustnrSj() {
		return qustnrSj;
	}
	public void setQustnrSj(String qustnrSj) {
		this.qustnrSj = qustnrSj;
	}
	public String getQustnrPurps() {
		return qustnrPurps;
	}
	public void setQustnrPurps(String qustnrPurps) {
		this.qustnrPurps = qustnrPurps;
	}
	public String getQustnrStartDate() {
		return qustnrStartDate;
	}
	public void setQustnrStartDate(String qustnrStartDate) {
		this.qustnrStartDate = qustnrStartDate;
	}
	public String getQustnrEndDate() {
		return qustnrEndDate;
	}
	public void setQustnrEndDate(String qustnrEndDate) {
		this.qustnrEndDate = qustnrEndDate;
	}
	public String getCurrentDt() {
		return currentDt;
	}
	public void setCurrentDt(String currentDt) {
		this.currentDt = currentDt;
	}
	public String getEtcAnswerAt() {
		return etcAnswerAt;
	}
	public void setEtcAnswerAt(String etcAnswerAt) {
		this.etcAnswerAt = etcAnswerAt;
	}
	public String getQestnSn() {
		return qestnSn;
	}
	public void setQestnSn(String qestnSn) {
		this.qestnSn = qestnSn;
	}
	public String getQestnCn1() {
		return qestnCn1;
	}
	public void setQestnCn1(String qestnCn1) {
		this.qestnCn1 = qestnCn1;
	}
	public String getQestnCn2() {
		return qestnCn2;
	}
	public void setQestnCn2(String qestnCn2) {
		this.qestnCn2 = qestnCn2;
	}
	public String getQestnCn3() {
		return qestnCn3;
	}
	public void setQestnCn3(String qestnCn3) {
		this.qestnCn3 = qestnCn3;
	}
	public String getQestnCn4() {
		return qestnCn4;
	}
	public void setQestnCn4(String qestnCn4) {
		this.qestnCn4 = qestnCn4;
	}
	public String getQestnCn5() {
		return qestnCn5;
	}
	public void setQestnCn5(String qestnCn5) {
		this.qestnCn5 = qestnCn5;
	}
	
	public String getQestnAnswerSn() {
		return qestnAnswerSn;
	}
	public void setQestnAnswerSn(String qestnAnswerSn) {
		this.qestnAnswerSn = qestnAnswerSn;
	}
	public String getQestnAnswerSn1() {
		return qestnAnswerSn1;
	}
	public void setQestnAnswerSn1(String qestnAnswerSn1) {
		this.qestnAnswerSn1 = qestnAnswerSn1;
	}
	public String getQestnAnswerSn2() {
		return qestnAnswerSn2;
	}
	public void setQestnAnswerSn2(String qestnAnswerSn2) {
		this.qestnAnswerSn2 = qestnAnswerSn2;
	}
	public String getQestnAnswerSn3() {
		return qestnAnswerSn3;
	}
	public void setQestnAnswerSn3(String qestnAnswerSn3) {
		this.qestnAnswerSn3 = qestnAnswerSn3;
	}
	public String getQestnAnswerSn4() {
		return qestnAnswerSn4;
	}
	public void setQestnAnswerSn4(String qestnAnswerSn4) {
		this.qestnAnswerSn4 = qestnAnswerSn4;
	}
	public String getQestnAnswerSn5() {
		return qestnAnswerSn5;
	}
	public void setQestnAnswerSn5(String qestnAnswerSn5) {
		this.qestnAnswerSn5 = qestnAnswerSn5;
	}
	public String getQestnAnswerSn6() {
		return qestnAnswerSn6;
	}
	public void setQestnAnswerSn6(String qestnAnswerSn6) {
		this.qestnAnswerSn6 = qestnAnswerSn6;
	}
	public String getQestnAnswerPercent1() {
		return qestnAnswerPercent1;
	}
	public void setQestnAnswerPercent1(String qestnAnswerPercent1) {
		this.qestnAnswerPercent1 = qestnAnswerPercent1;
	}
	public String getQestnAnswerPercent2() {
		return qestnAnswerPercent2;
	}
	public void setQestnAnswerPercent2(String qestnAnswerPercent2) {
		this.qestnAnswerPercent2 = qestnAnswerPercent2;
	}
	public String getQestnAnswerPercent3() {
		return qestnAnswerPercent3;
	}
	public void setQestnAnswerPercent3(String qestnAnswerPercent3) {
		this.qestnAnswerPercent3 = qestnAnswerPercent3;
	}
	public String getQestnAnswerPercent4() {
		return qestnAnswerPercent4;
	}
	public void setQestnAnswerPercent4(String qestnAnswerPercent4) {
		this.qestnAnswerPercent4 = qestnAnswerPercent4;
	}
	public String getQestnAnswerPercent5() {
		return qestnAnswerPercent5;
	}
	public void setQestnAnswerPercent5(String qestnAnswerPercent5) {
		this.qestnAnswerPercent5 = qestnAnswerPercent5;
	}
	public String getQestnAnswerPercent6() {
		return qestnAnswerPercent6;
	}
	public void setQestnAnswerPercent6(String qestnAnswerPercent6) {
		this.qestnAnswerPercent6 = qestnAnswerPercent6;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEtcAnswerCn() {
		return etcAnswerCn;
	}
	public void setEtcAnswerCn(String etcAnswerCn) {
		this.etcAnswerCn = etcAnswerCn;
	}
	public String getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}
	public String getSearchJoinAt() {
		return searchJoinAt;
	}
	public void setSearchJoinAt(String searchJoinAt) {
		this.searchJoinAt = searchJoinAt;
	}
	public String getProgrressStatus() {
		return progrressStatus;
	}
	public void setProgrressStatus(String progrressStatus) {
		this.progrressStatus = progrressStatus;
	}
	public String getDayOfWeekStart() {
		return dayOfWeekStart;
	}
	public void setDayOfWeekStart(String dayOfWeekStart) {
		this.dayOfWeekStart = dayOfWeekStart;
	}
	public String getDayOfWeekEnd() {
		return dayOfWeekEnd;
	}
	public void setDayOfWeekEnd(String dayOfWeekEnd) {
		this.dayOfWeekEnd = dayOfWeekEnd;
	}
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getJoinAt() {
		return joinAt;
	}
	public void setJoinAt(String joinAt) {
		this.joinAt = joinAt;
	}
	public String getAnswerResultCnt() {
		return answerResultCnt;
	}
	public void setAnswerResultCnt(String answerResultCnt) {
		this.answerResultCnt = answerResultCnt;
	}
	public String getLessonStdCnt() {
		return lessonStdCnt;
	}
	public void setLessonStdCnt(String lessonStdCnt) {
		this.lessonStdCnt = lessonStdCnt;
	}
	public String getQestnCn6() {
		return qestnCn6;
	}
	public void setQestnCn6(String qestnCn6) {
		this.qestnCn6 = qestnCn6;
	}
	public String getQestnCn7() {
		return qestnCn7;
	}
	public void setQestnCn7(String qestnCn7) {
		this.qestnCn7 = qestnCn7;
	}
	public String getQestnCn8() {
		return qestnCn8;
	}
	public void setQestnCn8(String qestnCn8) {
		this.qestnCn8 = qestnCn8;
	}
	public String getQestnCn9() {
		return qestnCn9;
	}
	public void setQestnCn9(String qestnCn9) {
		this.qestnCn9 = qestnCn9;
	}
	public String getQestnCn10() {
		return qestnCn10;
	}
	public void setQestnCn10(String qestnCn10) {
		this.qestnCn10 = qestnCn10;
	}
	public String getQestnAnswerSn7() {
		return qestnAnswerSn7;
	}
	public void setQestnAnswerSn7(String qestnAnswerSn7) {
		this.qestnAnswerSn7 = qestnAnswerSn7;
	}
	public String getQestnAnswerSn8() {
		return qestnAnswerSn8;
	}
	public void setQestnAnswerSn8(String qestnAnswerSn8) {
		this.qestnAnswerSn8 = qestnAnswerSn8;
	}
	public String getQestnAnswerSn9() {
		return qestnAnswerSn9;
	}
	public void setQestnAnswerSn9(String qestnAnswerSn9) {
		this.qestnAnswerSn9 = qestnAnswerSn9;
	}
	public String getQestnAnswerSn10() {
		return qestnAnswerSn10;
	}
	public void setQestnAnswerSn10(String qestnAnswerSn10) {
		this.qestnAnswerSn10 = qestnAnswerSn10;
	}
	public String getQestnAnswerSn11() {
		return qestnAnswerSn11;
	}
	public void setQestnAnswerSn11(String qestnAnswerSn11) {
		this.qestnAnswerSn11 = qestnAnswerSn11;
	}
	public String getQestnAnswerPercent7() {
		return qestnAnswerPercent7;
	}
	public void setQestnAnswerPercent7(String qestnAnswerPercent7) {
		this.qestnAnswerPercent7 = qestnAnswerPercent7;
	}
	public String getQestnAnswerPercent8() {
		return qestnAnswerPercent8;
	}
	public void setQestnAnswerPercent8(String qestnAnswerPercent8) {
		this.qestnAnswerPercent8 = qestnAnswerPercent8;
	}
	public String getQestnAnswerPercent9() {
		return qestnAnswerPercent9;
	}
	public void setQestnAnswerPercent9(String qestnAnswerPercent9) {
		this.qestnAnswerPercent9 = qestnAnswerPercent9;
	}
	public String getQestnAnswerPercent10() {
		return qestnAnswerPercent10;
	}
	public void setQestnAnswerPercent10(String qestnAnswerPercent10) {
		this.qestnAnswerPercent10 = qestnAnswerPercent10;
	}
	public String getQestnAnswerPercent11() {
		return qestnAnswerPercent11;
	}
	public void setQestnAnswerPercent11(String qestnAnswerPercent11) {
		this.qestnAnswerPercent11 = qestnAnswerPercent11;
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
	

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
