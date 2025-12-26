
/*******************************************************************************
 * COPYRIGHT(C) 2016 gocle LEARN ALL RIGHTS RESERVED.
 * This software is the proprietary information of gocle LEARN.
 *
 * Revision History
 * Author   Date            Description
 * ------   ----------      ------------------------------------
 * AA    2016. 8. 9.         First Draft.
 *
 *******************************************************************************/ 
package kr.co.gocle.oklms.commbiz.photo.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.gocle.aunuri.service.AunuriLinkService;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberVO;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.atchFile.vo.AtchFileVO;
import kr.co.gocle.oklms.commbiz.util.AtchFileUtil;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.web.EgovImageProcessController;

 /**
 * 클래스에 대한 내용을 작성한다.
 * @author AA
 * @since 2016. 8. 9.
 */
@Controller
public class PhotoController extends BaseController {

	@Resource(name = "aunuriLinkService")
	private AunuriLinkService aunuriLinkService;
	
	@RequestMapping(value = "/commbiz/photo/getAunuriUserImage.do")
	public void getAunuriUserImage(@ModelAttribute("frmComcode") AunuriLinkMemberVO aunuriLinkMemberVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//세션자동복사
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.getLoginInfo();
		if(loginInfo.isLogin()){
			
			if("2016AUTH0000002".equals(loginInfo.getAuthGroupId())){
				aunuriLinkMemberVO.setMemId(loginInfo.getMemId());
			}
			
			logger.debug("#### URL = /common/getAunuriUserImage.do?memId="+aunuriLinkMemberVO.getMemId() );
			
			aunuriLinkMemberVO =  aunuriLinkService.getAunuriUserImage(aunuriLinkMemberVO);
	        
		    response.setContentType("image/jpeg");  // Content Type Set
		    
		    try {
		    	
		    	byte[] bytes = aunuriLinkMemberVO.getPhoto();
			    InputStream is = new ByteArrayInputStream(bytes);
			    ServletOutputStream os = response.getOutputStream();
			    int binaryRead;
			    
			    while ((binaryRead = is.read()) != -1) {
			        os.write(binaryRead);
			    }
				
			} catch (Exception e) {
				// TODO: handle exception
			}
		    
		    			
		}

	}
}
