/*******************************************************************************
 * COPYRIGHT(C) 2016 SMART INFORMATION TECHNOLOGY. ALL RIGHTS RESERVED.
 * This software is the proprietary information of SMART INFORMATION TECHNOLOGY..
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * 이진근    2016. 07. 01.         First Draft.( Auto Code Generate )
 *
 *******************************************************************************/ 
package kr.co.gocle.aunuri.web;


import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.gocle.aunuri.service.AunuriLinkService;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.lu.currproc.vo.CurrProcVO;
import kr.co.gocle.oklms.lu.report.vo.ReportVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.Globals;


@Controller
public class AunuriLinkController extends BaseController{
	
	
	
	
	
}
