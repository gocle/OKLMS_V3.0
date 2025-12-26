package kr.co.gocle.oklms.commbiz.outmember.service;

import java.util.List;

import kr.co.gocle.oklms.commbiz.mail.vo.MailVO; 
import kr.co.gocle.oklms.commbiz.outmember.vo.OutMemberVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.LoginVO;

@Transactional(rollbackFor=Exception.class)
public interface OutMemberService {

	OutMemberVO tempMemIdCheck(OutMemberVO outMemberVO) throws Exception;

	MemberVO memIdCheck(MemberVO memberVO) throws Exception;

	String inesertTempOutMember(OutMemberVO outMemberVO,final MultipartHttpServletRequest multiRequest) throws Exception;

	List<OutMemberVO> listTempOutMember(OutMemberVO outMemberVO) throws Exception;

	int updateOutMemberStatus(OutMemberVO outMemberVO) throws Exception;
	
	
	int deleteOutMember(OutMemberVO outMemberVO) throws Exception;
	
	int approvalTempMember(OutMemberVO outMemberVO) throws Exception;
	
	
	List<OutMemberVO> tempMemInfoCheck(OutMemberVO outMemberVO) throws Exception;
	
	List<MemberVO> memInfoCheck(MemberVO memberVO) throws Exception;

	int changePassword(LoginVO loginVO) throws Exception;

	String selectPassword(LoginVO user) throws Exception;
	
	
}