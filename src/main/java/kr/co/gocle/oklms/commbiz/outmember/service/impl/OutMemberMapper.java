package kr.co.gocle.oklms.commbiz.outmember.service.impl;

import egovframework.com.cmm.LoginVO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.commbiz.outmember.vo.OutMemberVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;
 
@Mapper
public interface OutMemberMapper {

	OutMemberVO tempMemIdCheck(OutMemberVO outMemberVO) throws Exception;
 
	MemberVO memIdCheck(MemberVO memberVO) throws Exception;
	
	int inesertTempOutMember(OutMemberVO outMemberVO) throws Exception;
	
	
	List<OutMemberVO> listTempOutMember(OutMemberVO outMemberVO) throws Exception;
	
	
	int updateOutMemberStatus(OutMemberVO outMemberVO) throws Exception;
	
	int deleteOutMember(OutMemberVO outMemberVO) throws Exception;
	
	OutMemberVO getOutMember(OutMemberVO outMemberVO) throws Exception;
	
	int insertMember(OutMemberVO outMemberVO) throws Exception;
	
	
	List<OutMemberVO> tempMemInfoCheck(OutMemberVO outMemberVO) throws Exception;
	
	List<MemberVO> memInfoCheck(MemberVO memberVO) throws Exception;

	int changePassword(LoginVO loginVO) throws Exception;

	String selectPassword(LoginVO user) throws Exception;
	
	
}