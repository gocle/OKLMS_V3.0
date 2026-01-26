package kr.co.gocle.oklms.la.log.vo;

import java.io.Serializable;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import egovframework.com.cmm.service.Globals;
import kr.co.gocle.oklms.comm.vo.BaseVO;

public class AdminLogVO extends BaseVO implements Serializable {

	private static final long serialVersionUID = -6330475442026300668L;

	/** 로그SEQ */
    private String logSeq;

    /** 회원SEQ */
    private String memSeq;

    /** 회원아이디 */
    private String memId;
    
    /** 회원명 */
    private String memName;
    
    /** 접속시간 */
    private String loginDate;

    /** 아이피 */
    private String clientIp;

    /** OS */
    private String clientOs;

    /** AP */
    private String clientBrowser;

    /** 메뉴ID */
    private String menuId;

    /** 작업종류 */
    private String workType;

    /** 작업URL */
    private String workUrl;

    /** 접속헤더정보 */
    private String workText;
    
    private String startDate;	//조회시작일자
	private String finishDate;	//조회종료일자
	private String searchClientIp; 	//조회조건 로그인 아이피
	private String searchLogMemId;	//조회조건 로그인 아이디
	
	public void setRequest(HttpServletRequest request) {		
		try {
			this.clientIp = setClntIP(request);
			this.clientOs = setClntOsInfo(request);			
			this.clientBrowser = setClntWebKind(request);
			this.workUrl= setWorkUrl(request);
			this.memId =(String)request.getSession().getAttribute(Globals.SESSION_USER_ID);
			this.memSeq =(String)request.getSession().getAttribute(Globals.SESSION_USER_SEQ);
						
			Enumeration ename= request.getParameterNames();
			String nameStr  = "";
			String value = "";
			String msg1 ="";
			while(ename.hasMoreElements()){
			   nameStr=(String)ename.nextElement();
			   String[] nameStrvalue=request.getParameterValues(nameStr);
			   int temp = nameStrvalue.length;
			   if(temp>1){
				   for(int x=0;nameStrvalue.length>x ;x++){
					   if(nameStrvalue[x]!=null && !nameStrvalue[x].equals("")){
						   if(nameStr!=null && !nameStr.equals("memPasswordEncript")) {
							   msg1+=nameStr + " :: " + nameStrvalue[x] +",";			
						   }
					   }				   
				   }	   
			   }else{
				   
				   value=request.getParameter(nameStr);

				   if(value!=null && !value.equals("")){
					   if(nameStr.equals("menuId")) {
						   this.menuId=value;
					   }else {
						   if(nameStr!=null && !nameStr.equals("memPasswordEncript")) {
							   msg1+=nameStr + " : " + value +",";
						   }
					   }   
				   }
			   }
			}
			this.workText=  msg1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static String setWorkUrl(HttpServletRequest request) throws Exception {
		String workUrl = request.getRequestURI();
		return workUrl;
	}
	
	public static String setClntIP(HttpServletRequest request) throws Exception {
		String ipAddr = request.getRemoteAddr();
		return ipAddr;
	}
	
	public static String setClntOsInfo(HttpServletRequest request) throws Exception {
		
		String agent = request.getHeader("user-agent");
		String os = "";
		
		if(agent.indexOf("NT 6.0") != -1) os = "Windows Vista/Server 2008";
		else if(agent.indexOf("NT 5.2") != -1) os = "Windows Server 2003";
		else if(agent.indexOf("NT 5.1") != -1) os = "Windows XP";
		else if(agent.indexOf("NT 5.0") != -1) os = "Windows 2000";
		else if(agent.indexOf("NT") != -1) os = "Windows NT";
		else if(agent.indexOf("9x 4.90") != -1) os = "Windows Me";
		else if(agent.indexOf("98") != -1) os = "Windows 98";
		else if(agent.indexOf("95") != -1) os = "Windows 95";
		else if(agent.indexOf("Win16") != -1) os = "Windows 3.x";
		else if(agent.indexOf("Windows") != -1) os = "Windows";
		else if(agent.indexOf("Linux") != -1) os = "Linux";
		else if(agent.indexOf("Macintosh") != -1) os = "Macintosh";
		else os = "";  
		return os;
	}
	
	public static String setClntWebKind(HttpServletRequest request) throws Exception {
		String agent = request.getHeader("user-agent");
		String brower = null;

		if (agent != null) {
		   if (agent.indexOf("Trident") > -1) {
		      brower = "MSIE";
		   } else if (agent.indexOf("Chrome") > -1) {
		      brower = "Chrome";
		   } else if (agent.indexOf("Opera") > -1) {
		      brower = "Opera";
		   } else if (agent.indexOf("iPhone") > -1 && agent.indexOf("Mobile") > -1) {
		      brower = "iPhone";
		   } else if (agent.indexOf("Android") > -1 && agent.indexOf("Mobile") > -1) {
		      brower = "Android";
		   }
		}

		return brower;
	}

	public String getLogSeq() {
		return logSeq;
	}

	public void setLogSeq(String logSeq) {
		this.logSeq = logSeq;
	}

	public String getMemSeq() {
		return memSeq;
	}

	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}

	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}

	public String getClientIp() {
		return clientIp;
	}

	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}

	public String getClientOs() {
		return clientOs;
	}

	public void setClientOs(String clientOs) {
		this.clientOs = clientOs;
	}

	public String getClientBrowser() {
		return clientBrowser;
	}

	public void setClientBrowser(String clientBrowser) {
		this.clientBrowser = clientBrowser;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public String getWorkUrl() {
		return workUrl;
	}

	public void setWorkUrl(String workUrl) {
		this.workUrl = workUrl;
	}

	public String getWorkText() {
		return workText;
	}

	public void setWorkText(String workText) {
		this.workText = workText;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getSearchClientIp() {
		return searchClientIp;
	}

	public void setSearchClientIp(String searchClientIp) {
		this.searchClientIp = searchClientIp;
	}

	public String getSearchLogMemId() {
		return searchLogMemId;
	}

	public void setSearchLogMemId(String searchLogMemId) {
		this.searchLogMemId = searchLogMemId;
	}
    
}
