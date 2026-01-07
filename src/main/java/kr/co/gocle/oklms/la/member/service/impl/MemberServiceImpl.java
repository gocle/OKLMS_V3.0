
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
package kr.co.gocle.oklms.la.member.service.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import kr.co.gocle.oklms.comm.util.Config;
import kr.co.gocle.oklms.comm.util.ExcelData;
import kr.co.gocle.oklms.comm.util.ExcelDataSet;
import kr.co.gocle.oklms.comm.util.ExcelHandler;
import kr.co.gocle.oklms.comm.util.FileUploadUtil;
//import kr.co.gocle.oklms.comm.util.FileUploadUtil;
//import kr.co.gocle.oklms.comm.util.UUID;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
//import kr.co.gocle.oklms.commbiz.util.IOUtills;
//import kr.co.gocle.oklms.la.mail.service.MailService;
//import kr.co.gocle.oklms.la.mail.vo.MailVO;
import kr.co.gocle.oklms.la.member.service.MemberService;
import kr.co.gocle.oklms.la.member.vo.ExcelMemberVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
//import org.apache.commons.beanutils.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovProperties;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

 /**
 * 프로토타입 게시판 CRUD 비지니스 로직을 구현하는 클레스.
 * @author 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("memberService")
public class MemberServiceImpl extends EgovAbstractServiceImpl implements MemberService {

	/** ID Generation */
    @Resource(name="memberIdGnrService")
    private EgovIdGnrService memberIdGnrService;
    
    @Resource(name = "memberMapper")
    private MemberMapper memberMapper;
    
    /*@Resource(name = "mailService")
    private MailService mailService;*/
    
    @Resource(name = "atchFileService")
    private AtchFileService atchFileService;

	@Override
	public List<MemberVO> listMember(MemberVO memberVO) throws Exception {

		List<MemberVO> data = memberMapper.listMember(memberVO);
		return data;
	}
	
	@Override
	public List<ExcelMemberVO> listMemberAllExcelList(ExcelMemberVO excelMemberVO) throws Exception {

		List<ExcelMemberVO> data = memberMapper.listMemberAllExcelList(excelMemberVO);
		return data;
	}

	 @Override
	 public MemberVO getMember(MemberVO memberVO) throws Exception {
		 // TODO Auto-generated method stub
		 MemberVO data = memberMapper.getMember(memberVO);
		 return data;
	 }
	 
	 @Override
	 public MemberVO getStdMember(MemberVO memberVO) throws Exception {
		 // TODO Auto-generated method stub
		 MemberVO data = memberMapper.getStdMember(memberVO);
		 return data;
	 }

	 @Override
	 public MemberVO getMember(String memSeq) throws Exception {
		 MemberVO memberVO = new MemberVO();
		 memberVO.setMemSeq(memSeq);
		 MemberVO data = memberMapper.getMember(memberVO);
		 return data;
	 }
	 
	 @Override
	 public String getMemNameGet(MemberVO memberVO) throws Exception {
		 List memberList = null;
		 String memNameSet ="";
		 
	     memberVO.setMemSeqs(memberVO.getMemSeq().split(","));
	     memberList = memberMapper.listMemberMail(memberVO);
         if (memberList!=null && memberList.size()>0){
            for(int idx=0 ; idx < memberList.size() ; idx++){
            	MemberVO memberModel = (MemberVO) memberList.get(idx);
                memNameSet += memberModel.getMemName();
                if (idx < memberList.size()-1){
                    memNameSet += ","; 
                }
            }
         }
         
		 return memNameSet;
	 }
	 
	 @Override
	 public String getMemTutorLessonId(MemberVO memberVO) throws Exception {
		 String lessonIds = "";
		 String sendMemIdGubunFlag = "";
		 String[] strMemSeqs = null;
		 sendMemIdGubunFlag = memberVO.getSendMemIdGubunFlag();
		 if("single".equals(sendMemIdGubunFlag)){
			 lessonIds = memberVO.getMemSeq();
		 }else{
			 memberVO.setMemSeqs(memberVO.getMemSeq().split(","));
			 if (memberVO.getMemSeqs().length > 0){
		            /*for(int idx=0 ; idx < memberVO.getMemSeqs().length ; idx++){
		            	lessonIds += memberVO.getMemSeqs();
		                if (idx < memberVO.getMemSeqs().length - 1){
		                	lessonIds +=  ",";
		                } 
		            }*/
				 	for(int idx=0 ; idx < memberVO.getMemSeqs().length ; idx++){
				 		strMemSeqs = memberVO.getMemSeqs();
		            }
				 	for(int idx=0 ; idx < strMemSeqs.length ; idx++){
				 		lessonIds += strMemSeqs[idx];
				 		lessonIds +=  ",";
		            }
		        }
		 }
		 
		 return lessonIds;
	 }
	 
	 @Override
	 public String getMemTypeEmail(MemberVO memberVO) throws Exception {
		 List memberList = null;
		 String emailSet ="";
		 
	     memberVO.setMemSeqs(memberVO.getMemSeq().split(","));
	     memberList = memberMapper.listMemberMail(memberVO);
         if (memberList!=null && memberList.size()>0){
            for(int idx=0 ; idx < memberList.size() ; idx++){
            	MemberVO memberModel = (MemberVO) memberList.get(idx);
            	emailSet += memberModel.getEmail();
                if (idx < memberList.size()-1){
                	emailSet += ","; 
                }
            }
         }
         
		 return emailSet;
	 }
	 
	 @Override
	 public String getMemSeq(MemberVO memberVO) throws Exception {
		 List memberList = null;
		 String recvMemSeqSet ="";
		 
	     memberVO.setMemSeqs(memberVO.getMemSeq().split(","));
	     memberList = memberMapper.listMemberMail(memberVO);
         if (memberList!=null && memberList.size()>0){
            for(int idx=0 ; idx < memberList.size() ; idx++){
            	MemberVO memberModel = (MemberVO) memberList.get(idx);
            	recvMemSeqSet += memberModel.getMemSeq();
                if (idx < memberList.size()-1){
                	recvMemSeqSet += ","; 
                }
            }
         }
         
		 return recvMemSeqSet;
	 }
	 
	 @Override
	 public String getMemSeqTutor(MemberVO memberVO) throws Exception {
		 List memberList = null;
		 String recvMemSeqSet ="";
		 
	     memberVO.setMemSeqs(memberVO.getMemSeq().split(","));
	     memberList = memberMapper.listMemberMail(memberVO);
         if (memberList!=null && memberList.size()>0){
            for(int idx=0 ; idx < memberList.size() ; idx++){
            	MemberVO memberModel = (MemberVO) memberList.get(idx);
            	recvMemSeqSet += memberModel.getMemSeq();
                if (idx < memberList.size()-1){
                	recvMemSeqSet += ","; 
                }
            }
         }
         
		 return recvMemSeqSet;
	 }
	 
	 @Override
	 public String getMemPhoneNo(MemberVO memberVO) throws Exception {
		 List memberList = null;
		 String trPhoneNo ="";
		 
	     memberVO.setMemSeqs(memberVO.getMemSeq().split(","));
	     memberList = memberMapper.listMemberMail(memberVO);
         if (memberList!=null && memberList.size()>0){
            for(int idx=0 ; idx < memberList.size() ; idx++){
            	MemberVO memberModel = (MemberVO) memberList.get(idx);
            	trPhoneNo += memberModel.getTrPhone();
                if (idx < memberList.size()-1){
                	trPhoneNo += ","; 
                }
            }
         }
         
		 return trPhoneNo;
	 }

	@Override
	public String insertMember(MemberVO memberVO) throws Exception {
		String returnStr = "";
		String pkStr = memberIdGnrService.getNextStringId();
		memberVO.setMemSeq(pkStr);

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		
		//공백제거
		memberVO.setMemId(StringUtils.delete(memberVO.getMemId(), " ").trim());
		memberVO.setMemPasswordEncript(StringUtils.delete(memberVO.getMemPasswordEncript(), " ").trim());
		
		System.out.println("============ memberVO.getMemPasswordEncript() : "+memberVO.getMemPasswordEncript());
		
		if(StringUtils.hasText(memberVO.getDeptNo())){
			String dept = memberVO.getDeptNo();
			memberVO.setDeptNo(dept.split("_")[0]);
			memberVO.setDeptNm(dept.split("_")[1]);
		}
		
		// 비밀번호 변경없이 최대 사용 일수
		String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); 
		memberVO.setLoginPWMaxUsedDays(loginPWMaxUsedDays);

		int sqlResultInt = memberMapper.insertMember(memberVO);
		
		if(sqlResultInt > 0){
			if( memberVO.getAuthGroupIds() != null ){
				for( int i=0; i< memberVO.getAuthGroupIds().length; i++ ){
					
					String authGroup = memberVO.getAuthGroupIds()[i];
					
					memberVO.setAuthGroupId(authGroup.split("_")[0]);
					memberVO.setMemType(authGroup.split("_")[1]);
					sqlResultInt += memberMapper.insertAuthMember(memberVO);
				}
			}
		}
		
		if( 0 < sqlResultInt ){
			returnStr = pkStr;
		}
		return returnStr;
	}
	
	
	@Override
	public String insertCompMember(MemberVO memberVO,final MultipartHttpServletRequest multiRequest) throws Exception {
		String returnStr = "";
		String pkStr = memberIdGnrService.getNextStringId();
		memberVO.setMemSeq(pkStr);

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		
		//공백제거
		memberVO.setMemId(StringUtils.delete(memberVO.getMemId(), " ").trim());
		//memberVO.setMemPasswordEncript(StringUtils.delete(memberVO.getMemPasswordEncript(), " ").trim());
		
		memberVO.setMemPasswordEncript(StringUtils.delete(memberVO.getMemPassword(), " ").trim());
		
		System.out.println("============ memberVO.getMemPasswordEncript() : "+memberVO.getMemPasswordEncript());
		
		if(StringUtils.hasText(memberVO.getDeptNo())){
			String dept = memberVO.getDeptNo();
			memberVO.setDeptNo(dept.split("_")[0]);
			memberVO.setDeptNm(dept.split("_")[1]);
		}
		
		// 비밀번호 변경없이 최대 사용 일수
		String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); 
		memberVO.setLoginPWMaxUsedDays(loginPWMaxUsedDays);
		
		//첨부파일 저장	 		
		final List< MultipartFile > fileObj = multiRequest.getFiles("file-input");
		String storePathString ="Globals.fileStorePath";
		String atchFileId = atchFileService.saveAtchFile( fileObj, "COP", "", storePathString ,"licence");
		memberVO.setAtchFileId(atchFileId);
		
		memberVO.setAuthGroupId(memberVO.getAuthGroupIds()[0].split("_")[0]);
		memberVO.setMemType(memberVO.getAuthGroupIds()[0].split("_")[1]);
		int sqlResultInt = memberMapper.insertMember(memberVO);
		
		if(sqlResultInt > 0){
			if( memberVO.getAuthGroupIds() != null ){
				for( int i=0; i< memberVO.getAuthGroupIds().length; i++ ){
					
					String authGroup = memberVO.getAuthGroupIds()[i];
					
					memberVO.setAuthGroupId(authGroup.split("_")[0]);
					memberVO.setMemType(authGroup.split("_")[1]);
					sqlResultInt += memberMapper.insertAuthMember(memberVO);
				}
			}
		}
		
		if( 0 < sqlResultInt ){
			returnStr = pkStr;
		}
		return returnStr;
	}
	
	@Override
	public String insertMemberAllExcel(ExcelMemberVO excelMemberVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String result = "";
		String memIdDualChkId ="";
		int sqlResultInt = 0;
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(excelMemberVO);
		MultipartFile mfile = multiRequest.getFile("uploadExcelFile");
		
		if (!mfile.isEmpty() ) {
			String realUploadPath 	= EgovProperties.getProperty("Globals.fileStorePath");
			String tmpFile			 	= FileUploadUtil.uploadFormFile(mfile, realUploadPath );
			//물리경로 
			String fullPath 				= realUploadPath + File.separator+tmpFile;
			String memId ="";
			int memIdDualchkCnt = 0;
			
			
			ExcelData 		row;
			ExcelHandler 	eh 		= new ExcelHandler(fullPath);
			ExcelDataSet 	dataSet 	= eh.parseExcelData();
			
			MemberVO memDualChkVO = new MemberVO();
			
			if (!CollectionUtils.isEmpty(dataSet)) {
				//엑셀업로드 파일에 중복회원 체크
				for (int j = 0; j < dataSet.size(); j++) {
					row = dataSet.getRow(j);
					
					memId = row.getColumn("회원아이디").trim();
					memDualChkVO.setMemId(memId);
					memIdDualchkCnt = memberMapper.getMemberCnt(memDualChkVO);
					
					if(0 < memIdDualchkCnt){
						memIdDualChkId += memId + ",";
					}
				}
				
				result = memIdDualChkId;
				System.out.println("========================================");
				System.out.println("memIdDualChkId : " + memIdDualChkId);
				System.out.println("result : " + result);
				System.out.println("========================================");
				
				//중복된 회원아이디가 없을떼 엑셀에 회원항목들을 VO에 메핑한다.
				if("".equals(memIdDualChkId)){
					for (int i = 0; i < dataSet.size(); i++) {
						ExcelMemberVO memVO = new ExcelMemberVO();
						
						row = dataSet.getRow(i);
						memVO.setMemSeq(memberIdGnrService.getNextStringId()); //회원 고유번호
						memVO.setMemId(row.getColumn("회원아이디").trim()); //회원아이디
						
						String memType = row.getColumn("회원유형").trim(); //회원유형
						memVO.setMemType(memType);
						
						//권한그룹아이디
						if("STD".equals(memType)){ //학습자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_STD); 
						} else if("PRT".equals(memType)){ //담당교수
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_PRO_TUTOR); 
						} else if("ATT".equals(memType)){ //지도교수
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_ADV_TUTOR); 
						} else if("COT".equals(memType)){ //기업현장교사
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_SUPERVISOR_TEACHAR); 
						} else if("CCM".equals(memType)){ //기업전담자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_CRI_COMPANY); 
						} else if("CCN".equals(memType)){ //센터전담자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_CRI_CENTER); 
						} else if("CDP".equals(memType)){ //학과전담자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_CRI_DEPARTMENT); 
						} else { //관리자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_ADM);
						}
						
						memVO.setMemName(row.getColumn("회원성명").trim()); //회원성명
						String sex = row.getColumn("성별").trim(); //성별
						if("여자".equals(sex)){ 
							memVO.setSex("F"); //여자
						} else {
							memVO.setSex("M"); //남자
						}
						
						memVO.setMemBirth(row.getColumn("생년월일").trim().replaceAll("-", "")); //생년월일
						String memPassword = "";
						memPassword = row.getColumn("비밀번호").trim();
						memPassword = memPassword.replaceAll(".0", "");
						memVO.setMemPassword(memPassword);  //비밀번호
						
						//핸드폰번호
						if (row.getColumn("핸드폰번호").indexOf("-") < 0) {
							throw new Exception("핸드폰번호에 '-'이없습니다 ");
						}
						String[] phonNm = row.getColumn("핸드폰번호").split("-");
						memVO.setHpNo1(phonNm[0].trim());
						memVO.setHpNo2(phonNm[1].trim());
						memVO.setHpNo3(phonNm[2].trim());
						
						memVO.setEmail(row.getColumn("이메일").trim()); //이메일
						memVO.setBndlRegYn("Y"); //일괄등록여부
						memVO.setForeignYn("N"); //외국인여부
						memVO.setReceiveMailYn("Y"); //이메일수신여부
						memVO.setReceiveSmsYn("Y"); //SMS수신여부
						
						//소속명 및 소속코드
						String companyName = "";
						String companyId = "";
						companyName = row.getColumn("소속").trim();
						companyId = memberMapper.getCompanyName(companyName);
						memVO.setCompNm(companyName);
						memVO.setCompanyId(companyId);
						
						memVO.setZipCode(row.getColumn("우편번호").trim()); //우편번호
						memVO.setAddress(row.getColumn("주소").trim()); //주소
						memVO.setAddressDtl(row.getColumn("상세주소").trim()); //상세주소
						
						memVO.setSessionMemSeq(excelMemberVO.getSessionMemSeq()); //일괄업로드 등록자 세션정보
						memVO.setLoginPWMaxUsedDays(EgovProperties.getProperty("Globals.loginPWMaxUsedDays")); //사용만료일자
						memVO.setInsertResult("1");

						try{
							memVO.setCertiYn("Y");
							sqlResultInt += memberMapper.insertExcelMember(memVO);
							MemberVO memberVO = new MemberVO();
							memberVO.setMemSeq(memVO.getMemSeq());
							memberVO.setAuthGroupId(memVO.getAuthGroupId());
							memberVO.setMemType(memVO.getMemType());
							memberMapper.insertAuthMember(memberVO);
							memVO.setInsertResult("1");
						} catch(Exception e){
							throw new Exception("액셀쉬트를 읽어서 Insert하는도중 애러가 발생 하였습니다.");
						}													
					}
				}
			}
			
			//업로드한 임시엑셀파일을 삭제한다.
			FileUploadUtil.deleteFormFile(mfile, fullPath);
		}
		
		//회원ID가 중복건이 없을시 엑셀업로드 저정후 결과값 셋팅
		if("".equals(memIdDualChkId)){
			if(sqlResultInt == 0){
				result = "FAIL";
			}else{
				result = "SUCCESS";
			}
		}
		
		return result;
	}
	
	@Override
	public String insertExcelCompMember(ExcelMemberVO excelMemberVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String result = "";
		String memIdDualChkId ="";
		int sqlResultInt = 0;
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(excelMemberVO);
		MultipartFile mfile = multiRequest.getFile("uploadExcelFile");
		
		if (!mfile.isEmpty() ) {
			String realUploadPath 	= EgovProperties.getProperty("Globals.fileStorePath");
			String tmpFile			 	= FileUploadUtil.uploadFormFile(mfile, realUploadPath );
			//물리경로 
			String fullPath 				= realUploadPath + File.separator+tmpFile;
			String memId ="";
			int memIdDualchkCnt = 0;
			
			
			ExcelData 		row;
			ExcelHandler 	eh 		= new ExcelHandler(fullPath);
			ExcelDataSet 	dataSet 	= eh.parseExcelData();
			
			MemberVO memDualChkVO = new MemberVO();
			
			if (!CollectionUtils.isEmpty(dataSet)) {
				//엑셀업로드 파일에 중복회원 체크
				for (int j = 0; j < dataSet.size(); j++) {
					row = dataSet.getRow(j);
					
					memId = row.getColumn("아이디").trim();
					memDualChkVO.setMemId(memId);
					memIdDualchkCnt = memberMapper.getMemberCnt(memDualChkVO);
					
					if(0 < memIdDualchkCnt){
						memIdDualChkId += memId + ",";
					}
				}
				
				result = memIdDualChkId;
				System.out.println("========================================");
				System.out.println("memIdDualChkId : " + memIdDualChkId);
				System.out.println("result : " + result);
				System.out.println("========================================");
				
				//중복된 회원아이디가 없을떼 엑셀에 회원항목들을 VO에 메핑한다.
				if("".equals(memIdDualChkId)){
					for (int i = 0; i < dataSet.size(); i++) {
						ExcelMemberVO memVO = new ExcelMemberVO();
						
						row = dataSet.getRow(i);
						memVO.setMemSeq(memberIdGnrService.getNextStringId()); //회원 고유번호
						memVO.setMemId(row.getColumn("아이디").trim()); //회원아이디
						
						String memType = row.getColumn("유저타입").trim(); //회원유형
						memVO.setMemType(memType);
						
						//권한그룹아이디
						if("STD".equals(memType)){ //학습자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_STD); 
						} else if("PRT".equals(memType)){ //담당교수
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_PRO_TUTOR); 
						} else if("ATT".equals(memType)){ //지도교수
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_ADV_TUTOR); 
						} else if("COT".equals(memType)){ //기업현장교사
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_SUPERVISOR_TEACHAR); 
						} else if("CCM".equals(memType)){ //기업전담자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_CRI_COMPANY); 
						} else if("CCN".equals(memType)){ //센터전담자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_CRI_CENTER); 
						} else if("CDP".equals(memType)){ //학과전담자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_CRI_DEPARTMENT); 
						} else { //관리자
							memVO.setAuthGroupId(Config.DEFAULT_AUTH_ADM);
						}
						
						memVO.setMemName(row.getColumn("성명").trim()); //회원성명
						String memPassword = "";
						memPassword = row.getColumn("비밀번호").trim();
						memPassword = memPassword.replaceAll(".0", "");
						memVO.setMemPassword(memPassword);  //비밀번호
						memVO.setCompLicenceCd(row.getColumn("이수교육").trim().replaceAll(".0", ""));
						memVO.setSex(row.getColumn("성별").trim()); //남자
						memVO.setMemBirth(row.getColumn("생년월일").trim().replaceAll("-", "")); //생년월일
						memVO.setHpNo(row.getColumn("휴대폰번호").trim().replaceAll(".0", ""));
						
						memVO.setEmail(row.getColumn("이메일").trim()); //이메일
						memVO.setCompJoinDay(row.getColumn("입사일").trim().replaceAll(".0", "")); //입사일
						memVO.setCompTelNo(row.getColumn("사무실번호").trim().replaceAll(".0", "")); //사무실번호
						memVO.setDutyNm(row.getColumn("직위").trim());
						
						memVO.setBndlRegYn("Y"); //일괄등록여부
						memVO.setForeignYn("N"); //외국인여부
						memVO.setReceiveMailYn("Y"); //이메일수신여부
						memVO.setReceiveSmsYn("Y"); //SMS수신여부
						memVO.setCompanyId(excelMemberVO.getCompanyId());
						memVO.setSessionMemSeq(excelMemberVO.getSessionMemSeq()); //일괄업로드 등록자 세션정보
						memVO.setLoginPWMaxUsedDays(EgovProperties.getProperty("Globals.loginPWMaxUsedDays")); //사용만료일자
						memVO.setInsertResult("1");

							memVO.setCertiYn("Y");
							sqlResultInt += memberMapper.insertExcelCompMember(memVO);
							MemberVO memberVO = new MemberVO();
							memberVO.setMemSeq(memVO.getMemSeq());
							memberVO.setAuthGroupId(memVO.getAuthGroupId());
							memberVO.setMemType(memVO.getMemType());
							memberMapper.insertAuthMember(memberVO);
							memVO.setInsertResult("1");
					}
				}
			}
			
			//업로드한 임시엑셀파일을 삭제한다.
			FileUploadUtil.deleteFormFile(mfile, fullPath);
		}
		
		//회원ID가 중복건이 없을시 엑셀업로드 저정후 결과값 셋팅
		if("".equals(memIdDualChkId)){
			if(sqlResultInt == 0){
				result = "FAIL";
			}else{
				result = "SUCCESS";
			}
		}
		
		return result;
	}

	@Override
	public int getMemberCnt(MemberVO memberVO) throws Exception {
		
		int sqlResultInt = memberMapper.getMemberCnt(memberVO); 
		return sqlResultInt;
	}
	
	@Override
	public int updateMember(MemberVO memberVO) throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		
		if(StringUtils.hasText(memberVO.getDeptNo())){
			String dept = memberVO.getDeptNo();
			memberVO.setDeptNo(dept.split("_")[0]);
			memberVO.setDeptNm(dept.split("_")[1]);
		}
		
		
		if( memberVO.getAuthGroupIds() != null ){
			String authGroup = memberVO.getAuthGroupIds()[0];
			memberVO.setMemType(authGroup.split("_")[1]);
		}
		
		int sqlResultInt = memberMapper.updateMember(memberVO); 
		
		
		if(sqlResultInt > 0){
			
			if( memberVO.getAuthGroupIds() != null ){
				
				// 기존 권한 삭제 
				memberMapper.deleteAuthMember(memberVO);
				
				for( int i=0; i< memberVO.getAuthGroupIds().length; i++ ){
					
					String authGroup = memberVO.getAuthGroupIds()[i];
					
					memberVO.setMemType(authGroup.split("_")[1]);
					memberVO.setAuthGroupId(authGroup.split("_")[0]);
					sqlResultInt += memberMapper.insertAuthMember(memberVO);
				}
			}
			
			if( memberVO.getDeptNos() != null ){
				
				memberMapper.deleteDeptMember(memberVO);
				
				for( int i=0; i< memberVO.getDeptNos().length; i++ ){
					
					String deptNo = memberVO.getDeptNos()[i].split("_")[0];
					
					memberVO.setDeptNo(deptNo);
					sqlResultInt += memberMapper.insertDeptMember(memberVO);
				}
			}
			
		}
		
		return sqlResultInt;
	}
	
	@Override
	public int updateCompMember(MemberVO memberVO,final MultipartHttpServletRequest multiRequest) throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		
		final List< MultipartFile > fileObj = multiRequest.getFiles("file-input");
		String storePathString ="Globals.fileStorePath";
		String atchFileId = atchFileService.saveAtchFile( fileObj, "COP", "", storePathString ,"licence");
		memberVO.setAtchFileId(atchFileId);
		
		// 첨부파일 2번째
		final List<MultipartFile> fileObj2 = multiRequest.getFiles("file-input2");
		String atchFileId2 = atchFileService.saveAtchFile(fileObj2, "COP", "", storePathString, "licence2");
		memberVO.setAtchFileId2(atchFileId2);

		
		if(StringUtils.hasText(memberVO.getDeptNo())){
			String dept = memberVO.getDeptNo();
			memberVO.setDeptNo(dept.split("_")[0]);
			memberVO.setDeptNm(dept.split("_")[1]);
		}
		
		memberVO.setAuthGroupId(memberVO.getAuthGroupIds()[0].split("_")[0]);
		memberVO.setMemType(memberVO.getAuthGroupIds()[0].split("_")[1]);
		
		int sqlResultInt = memberMapper.updateMember(memberVO); 
		
		if(sqlResultInt > 0){
			if( memberVO.getAuthGroupIds() != null ){
				
				// 기존 권한 삭제 
				memberMapper.deleteAuthMember(memberVO);
				
				for( int i=0; i< memberVO.getAuthGroupIds().length; i++ ){
					
					String authGroup = memberVO.getAuthGroupIds()[i];
					
					memberVO.setMemType(authGroup.split("_")[1]);
					memberVO.setAuthGroupId(authGroup.split("_")[0]);
					sqlResultInt += memberMapper.insertAuthMember(memberVO);
				}
			}
		}
		
		return sqlResultInt;
	}
	
	
	
	
	@Override
	public int updateMemberPassWordInit(MemberVO memberVO) throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		
		memberVO.setMemPasswordEncript(memberVO.getMemId());
		
		String loginPWMaxUsedDays = EgovProperties.getProperty("Globals.loginPWMaxUsedDays"); // 비밀번호 변경없이 최대 사용 일수
		memberVO.setLoginPWMaxUsedDays(loginPWMaxUsedDays);
		
		int sqlResultInt = memberMapper.updateMemberPwInit(memberVO); 
		return sqlResultInt;
	}

	@Override
	public int deleteMemberList(MemberVO memberVO) throws Exception {
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		int sqlResultInt = memberMapper.deleteMemberList(memberVO);
		if(sqlResultInt > 0){
			sqlResultInt +=memberMapper.deleteAuthMemberList(memberVO);
		}
		return sqlResultInt;
	}

	@Override
	public int deleteMember(MemberVO memberVO) throws Exception {
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		
		int sqlResultInt = memberMapper.deleteMember(memberVO);
		if(sqlResultInt > 0){
			sqlResultInt +=memberMapper.deleteAuthMember(memberVO);
		}
		
		return sqlResultInt;
	}
	
	//축하메일 발송
	public void sendMail(ExcelMemberVO memberVO) throws Exception {
		/*String mailContent;
		String strTemplateFile = EgovProperties.getProperty("adm01.template.file");
		String strTempalte = IOUtills.getContents(new File(Config.realPath + EgovProperties.getProperty("mail.adm.template")
                + File.separator + strTemplateFile));
		
		MailVO mailVO = new MailVO();      
		mailVO.setMailContentText(mailVO.getMailContent());  
		mailContent = strTempalte.replace("../",Config.mailUrlPath);
		
		String memberId = memberVO.getMemId();
		String memberPw = memberVO.getMemPassword();

		mailContent = mailContent.replace("korName", memberVO.getMemName());
		mailContent = mailContent.replace("memberId", memberId);
		mailContent = mailContent.replace("memberPw", memberPw);
		mailVO.setMailContent(mailContent);
		mailVO.setMsgType(1);
		mailVO.setRecvEmailSet(memberVO.getEmail());
		mailVO.setSendName(EgovProperties.getProperty("mail.admin.name"));
		//보내는 사람 회원번호
		mailVO.setSenderMemSeq(Config.SYSTEM_ADMIN_MEM_SEQ);
		mailVO.setRecvMemSeqSet(memberVO.getMemSeq());
		//메일유형 회원가입
		mailVO.setMailClass(Config.MAIL_CLASS_ENTER);
		mailVO.setMailTitle(memberVO.getMemName() + "회원님 가입이 성공하였습니다.");
		
		mailVO.setSendEmail(EgovProperties.getProperty("mail.admin.mailadd"));
		mailService.sendMail(mailVO);*/
	}
	
	@Override
	public List<MemberVO> listStdMember(MemberVO memberVO) throws Exception {
		List<MemberVO> data = memberMapper.listStdMember(memberVO);
		return data;
	}
	
	
	@Override
	public int getOjtPrtCnt(MemberVO memberVO) throws Exception {
		
		int iResult = memberMapper.getOjtPrtCnt(memberVO);
		
		return iResult;
	}
	
	@Override
	public int updateStdMember(MemberVO memberVO) throws Exception {
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		int sqlResultInt = 0;
		
		for( int i = 0; i < memberVO.getMemSeqs().length; i++ ){
			
			memberVO.setMemSeq(memberVO.getMemSeqs()[i]);
			
			if(memberVO.getSessionMemType().equals("PRT")){
				memberVO.setEtcGrade1(memberVO.getEtcGrade1s()[i]);
				memberVO.setEtcGrade2(memberVO.getEtcGrade2s()[i]);
				memberVO.setEtcGrade3(memberVO.getEtcGrade3s()[i]);
				memberVO.setBigo1(memberVO.getBigo1s()[i]);
			}
			
			if(memberVO.getSessionMemType().equals("CCN")){
				memberVO.setBigo2(memberVO.getBigo2s()[i]);
			}
			
			sqlResultInt += memberMapper.updateStdMember(memberVO);
		}
		
		return sqlResultInt;
	}
	
	@Override
	public int saveStdMember(MemberVO memberVO) throws Exception {
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(memberVO);
		int sqlResultInt = 0;
		
		for( int i = 0; i < memberVO.getMemSeqss().length; i++ ){
			
			memberVO.setMemSeq(memberVO.getMemSeqss()[i]);
			
			if(memberVO.getSessionMemType().equals("PRT")){
				memberVO.setEtcGrade1(memberVO.getEtcGrade1s()[i]);
				memberVO.setEtcGrade2(memberVO.getEtcGrade2s()[i]);
				memberVO.setEtcGrade3(memberVO.getEtcGrade3s()[i]);
				memberVO.setBigo1(memberVO.getBigo1s()[i]);
			}
			
			if(memberVO.getSessionMemType().equals("CCN")){
				memberVO.setBigo2(memberVO.getBigo2s()[i]);
			}
			
			sqlResultInt += memberMapper.updateStdMember(memberVO);
		}
		
		return sqlResultInt;
	}

	@Override
	public List<MemberVO> listCotMemberStat(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		return memberMapper.listCotMemberStat(memberVO);
	}
	
	@Override
	public int updateCcnStdMember(MemberVO memberVO) throws Exception {

		int sqlResultInt = memberMapper.updateCcnStdMember(memberVO); 
		
		return sqlResultInt;
	}
	
	@Override
	public int updateTraningStatus(MemberVO memberVO) throws Exception {

		int sqlResultInt = memberMapper.updateTraningStatus(memberVO); 
		
		return sqlResultInt;
	}
	
	@Override
	public List<MemberVO> listStudyMemberStat(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		return  memberMapper.listStudyMemberStat(memberVO); 
	}

	
	
}
