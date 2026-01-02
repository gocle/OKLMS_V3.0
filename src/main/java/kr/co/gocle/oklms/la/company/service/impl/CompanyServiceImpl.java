
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
package kr.co.gocle.oklms.la.company.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;













import kr.co.gocle.oklms.comm.util.ExcelData;
import kr.co.gocle.oklms.comm.util.ExcelDataSet;
import kr.co.gocle.oklms.comm.util.ExcelHandler;
import kr.co.gocle.oklms.comm.util.FileUploadUtil;
//import kr.co.gocle.oklms.comm.util.FileUploadUtil;
//import kr.co.gocle.oklms.comm.util.UUID;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.la.company.service.CompanyService;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import kr.co.gocle.oklms.la.member.vo.MemberVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
//import org.apache.commons.beanutils.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
//import kr.co.gocle.oklms.commbiz.util.IOUtills;
//import kr.co.gocle.oklms.la.mail.service.MailService;
//import kr.co.gocle.oklms.la.mail.vo.MailVO;

 /**
 * 프로토타입 게시판 CRUD 비지니스 로직을 구현하는 클레스.
 * @author 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("companyService")
public class CompanyServiceImpl extends EgovAbstractServiceImpl implements CompanyService {

	/** ID Generation */
    @Resource(name="companyIdGnrService")
    private EgovIdGnrService companyIdGnrService;

    @Resource(name = "companyMapper")
    private CompanyMapper companyMapper;

  	@Override
	public List<CompanyVO> listCompanyTraningProcess(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCompanyTraningProcess(companyVO);
		return data;
	}

  	@Override
	public List<CompanyVO> listCompanyTraningProcessSearch(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCompanyTraningProcessSearch(companyVO);
		return data;
	}

  	@Override
	public List<CompanyVO> listCompany(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCompany(companyVO);
		return data;
	}
  	
  	@Override
	public List<CompanyVO> listAllCompany(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listAllCompany(companyVO);
		return data;
	}
  	
  	@Override
	public List<CompanyVO> listCcnCompany(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCcnCompany(companyVO);
		return data;
	}
  	
  	@Override
	public List<CompanyVO> listCcnMappingCompany(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCcnMappingCompany(companyVO);
		return data;
	}
  	
  	
  	@Override
	public List<CompanyVO> listCcnMember(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCcnMember(companyVO);
		return data;
	}

  	@Override
	public List<CompanyVO> listCompanySearch(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCompanySearch(companyVO);
		return data;
	}
  	
  	@Override
	public List<CompanyVO> listCompanySearch1(CompanyVO companyVO) throws Exception {
		List<CompanyVO> data = companyMapper.listCompanySearch1(companyVO);
		return data;
	}
  	
	 @Override
	 public CompanyVO getCompany(CompanyVO companyVO) throws Exception {
		 CompanyVO data = companyMapper.getCompany(companyVO);
		 return data;
	 }

	@Override
	public String insertCompany(CompanyVO companyVO) throws Exception {
		String returnStr = "";
		System.out.println("1111111111111111111");
		String pkCompanyId = companyIdGnrService.getNextStringId();
		companyVO.setCompanyId(pkCompanyId);

		System.out.println("222222222222222222");
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);
		
		
		System.out.println("333333333333333333");
		//공백제거
		companyVO.setCompanyId(StringUtils.delete(companyVO.getCompanyId(), " ").trim());
		int sqlResultInt = companyMapper.insertCompany(companyVO);
		if( 0 < sqlResultInt ){
			returnStr = pkCompanyId;
			
			// 센터전담자가 등록했을 경우 담당기업으로 자동매핑
			if(companyVO.getSessionMemType().equals("CCN")){
				companyVO.setMemSeq(companyVO.getSessionMemSeq());
				companyMapper.insertCcnCompany(companyVO);
			}
		}
		
		return returnStr;
	}

	@Override
	public int updateCompany(CompanyVO companyVO) throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);

		int sqlResultInt = companyMapper.updateCompany(companyVO);
		return sqlResultInt;
	}

	@Override
	public int deleteCompany(CompanyVO companyVO) throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);
		
		int sqlResultInt = companyMapper.deleteCompany(companyVO);
		
		if( 0 < sqlResultInt ){
			companyMapper.deleteCcnMappingCompany(companyVO);
		}

		return companyMapper.deleteCompany(companyVO);
	}
	
	@Override
	public int pwMember() throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		LoginVO vo = new LoginVO();
		List<LoginVO> data = companyMapper.listPwMember(vo);
		
		for(int i=0; i < data.size(); i++){
			 //MEM_SEQ,MEM_PASSWORD
			 LoginVO v = data.get(i);
			 companyMapper.updateMemberPw(v);
		}
		
		LoginVO vo1 = new LoginVO();
		List<LoginVO> data1 = companyMapper.listPwTempMember(vo1);
		
		for(int i=0; i < data1.size(); i++){
			 //MEM_SEQ,MEM_PASSWORD
			 LoginVO v = data1.get(i);
			 companyMapper.updateTempMemberPw(v);
		}

		return 1;
	}
	
	
	

	@Override
	public int getCompanyNoCnt(CompanyVO companyVO) throws Exception {

		return companyMapper.getCompanyNoCnt(companyVO);
	}
	
	@Override
	public int saveCcnCompany(CompanyVO companyVO) throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);
		
		int iResult = 0;
		
		iResult += companyMapper.deleteCcnCompany(companyVO);
		
		if( companyVO.getCompanyIds() != null && companyVO.getCompanyIds().length > 0 ){
			for( int i = 0; i < companyVO.getCompanyIds().length; i++ ){
				CompanyVO compVO = new CompanyVO();
				loginInfo.putSessionToVo(compVO);
				compVO.setCompanyId(companyVO.getCompanyIds()[i]);
				compVO.setMemSeq(companyVO.getMemSeq());
				iResult += companyMapper.insertCcnCompany(compVO);
			}
		}
		
		return iResult;
	}
	
	@Override
	public String getMyCompanyCcn(CompanyVO companyVO) throws Exception {
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);
		String data = companyMapper.getMyCompanyCcn(companyVO);
		return data;
	}
	
	@Override
	public String insertCompanyAllExcel(CompanyVO companyVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String result = "";
		String memIdDualChkId ="";
		int sqlResultInt = 0;
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);
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
			
			
			if (!CollectionUtils.isEmpty(dataSet)) {
				//엑셀업로드 파일에 중복회원 체크
				
				//중복된 회원아이디가 없을떼 엑셀에 회원항목들을 VO에 메핑한다.
				if("".equals(memIdDualChkId)){
					for (int i = 0; i < dataSet.size(); i++) {
						CompanyVO compVO = new CompanyVO();
						row = dataSet.getRow(i);
						
						String companyName = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("기업명").trim(),"");
						String employInsManageNo = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("기업고용보험관리번호").trim(),"");
						String companyNo = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("사업자등록번호").trim(),"");
						String address = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("주소").trim(),"");
						String addressDtl = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("주소(상세)").trim(),"");
						String zipCode = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("주소(우편번호)").trim(),"");
						String ceo = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("대표자").trim(),"");
						String position = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("담장자(직위)").trim(),"");
						String name = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("담당자(성명)").trim(),"");
						String telNo = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("담당자(연락처)").trim(),"");
						String hpNo = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("담당자(휴대폰)").trim(),"");
						String faxNo = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("담당자(팩스)").trim(),"");
						String email = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("담당자(E-MAIL)").trim(),"");
						String choiceDay = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("선정일").trim(),"");
						String regularEmploymentCnt = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("상시근로자수").trim(),"");
						String companyDivCd = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("기업구분").trim(),"");
						String homepageUrl = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("홈페이지URL").trim(),"");
						String traningStatusCd = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("훈련참여상태").trim(),"");
						String companyStatusCd = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("기업상태").trim(),"");
						String controlPlaceName = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("관할지부지사").trim(),"");
						String stuLevelName1 = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("도제(참여기관명)").trim(),"");
						String stuLevelName2 = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("Uni-Tech(참여기관명)").trim(),"");
						String stuLevelName3 = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("IPP(참여기관명)").trim(),"");
						String compLevelName1 = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("단독기업형").trim(),"");
						String compLevelName2 = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("대학연계형(참여기관명)").trim(),"");
						String compLevelName3 = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("P-Tech(참여기관명)").trim(),"");
						String compLevelName4 = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("고숙련마이스터(참여기관명)").trim(),"");
						String makeDay = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("설립일자").trim(),"");
						String creditLevel = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("신용등급").trim(),"");
						String assets = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("자산총계").trim(),"");
						String liabilities = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("부채총계").trim(),"");
						String equities = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("자본총계").trim(),"");
						String revenue = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("매출액").trim(),"");
						String operatingIncome = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("영업이익").trim(),"");
						String netIncome = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("당기순이익").trim(),"");
						String evalDay = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("평가일자").trim(),"");
						String searchPlaceName = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("조회기관").trim(),"");
						
						
						compVO.setCompanyId(companyIdGnrService.getNextStringId()); //회원 고유번호
						compVO.setCompanyName(companyName);
						compVO.setEmployInsManageNo(employInsManageNo);
						compVO.setCompanyNo(companyNo);
						compVO.setAddress(address);
						compVO.setAddressDtl(addressDtl);
						compVO.setZipCode(zipCode);
						compVO.setCeo(ceo);
						compVO.setPosition(position);
						compVO.setName(name);
						
						if(telNo.indexOf("-") != -1){
							
							compVO.setTelNo1(telNo.split("\\-")[0]);
							compVO.setTelNo2(telNo.split("\\-")[1]);
							compVO.setTelNo3(telNo.split("\\-")[2]);
						}
						
						if(hpNo.indexOf("-") != -1){
													
							compVO.setHpNo1(hpNo.split("\\-")[0]);
							compVO.setHpNo2(hpNo.split("\\-")[1]);
							compVO.setHpNo3(hpNo.split("\\-")[2]);
						}
						
						if(faxNo.indexOf("-") != -1){
							
							compVO.setFaxNo1(faxNo.split("\\-")[0]);
							compVO.setFaxNo2(faxNo.split("\\-")[1]);
							compVO.setFaxNo3(faxNo.split("\\-")[2]);
						}
						
						compVO.setEmail(email);
						compVO.setChoiceDay(choiceDay);
						compVO.setRegularEmploymentCnt(regularEmploymentCnt);
						compVO.setCompanyDivCd(companyDivCd);
						compVO.setHomepageUrl(homepageUrl);
						compVO.setTraningStatusCd(traningStatusCd);
						compVO.setCompanyStatusCd(companyStatusCd);
						compVO.setControlPlaceName(controlPlaceName);
						compVO.setStuLevelName1(stuLevelName1);
						compVO.setStuLevelName2(stuLevelName2);
						compVO.setStuLevelName3(stuLevelName3);
						compVO.setCompLevelName1(compLevelName1);
						compVO.setCompLevelName2(compLevelName2);
						compVO.setCompLevelName3(compLevelName3);
						compVO.setCompLevelName4(compLevelName4);
						compVO.setMakeDay(makeDay);
						compVO.setCreditLevel(creditLevel);
						compVO.setAssets(assets);
						compVO.setLiabilities(liabilities);
						compVO.setEquities(equities);
						compVO.setRevenue(revenue);
						compVO.setOperatingIncome(operatingIncome);
						compVO.setNetIncome(netIncome);
						compVO.setEvalDay(evalDay);
						compVO.setSearchPlaceName(searchPlaceName);
						

						try{
							sqlResultInt += companyMapper.insertCompany(compVO);
							
							// 센터전담자가 등록했을 경우 담당기업으로 자동매핑
							if(companyVO.getSessionMemType().equals("CCN")){
								companyVO.setMemSeq(companyVO.getSessionMemSeq());
								companyVO.setCompanyId(compVO.getCompanyId());
								companyMapper.insertCcnCompany(companyVO);
							}
							
						} catch(Exception e){
							throw new Exception("액셀쉬트를 읽어서 Insert하는도중 애러가 발생 하였습니다.");
						}													
					}
				}
			}
			
			//업로드한 임시엑셀파일을 삭제한다.
			FileUploadUtil.deleteFormFile(mfile, fullPath);
		}
		
		if(sqlResultInt == 0){
			result = "FAIL";
		}else{
			result = "SUCCESS";
		}
		
		return result;
	}
	
	@Override
	public String insertExcelMemberCompany(CompanyVO companyVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String result = "";
		String memIdDualChkId ="";
		int sqlResultInt = 0;
		
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(companyVO);
		MultipartFile mfile = multiRequest.getFile("uploadExcelFile");
		
		if (!mfile.isEmpty() ) {
			String realUploadPath 	= EgovProperties.getProperty("Globals.fileStorePath");
			String tmpFile			 	= FileUploadUtil.uploadFormFile(mfile, realUploadPath );
			//물리경로 
			String fullPath 				= realUploadPath + File.separator+tmpFile;
			int memIdDualchkCnt = 0;
			
			
			ExcelData 		row;
			ExcelHandler 	eh 		= new ExcelHandler(fullPath);
			ExcelDataSet 	dataSet 	= eh.parseExcelData();
			
			
			if (!CollectionUtils.isEmpty(dataSet)) {
				//엑셀업로드 파일에 중복회원 체크
				
				//중복된 회원아이디가 없을떼 엑셀에 회원항목들을 VO에 메핑한다.
				if("".equals(memIdDualChkId)){
					for (int i = 0; i < dataSet.size(); i++) {
						CompanyVO compVO = new CompanyVO();
						row = dataSet.getRow(i);
						
						String memId = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("학번").trim(),"");
						String companyId = org.apache.commons.lang3.StringUtils.defaultString(row.getColumn("기업코드").trim(),"");
						
						
						compVO.setCompanyId(companyId); //회원 고유번호
						compVO.setMemId(memId);
						

						try{
							sqlResultInt += companyMapper.updateCompanyMember(compVO);
							
							
						} catch(Exception e){
							throw new Exception("액셀쉬트를 읽어서 update 하는도중 애러가 발생 하였습니다.");
						}													
					}
				}
			}
			
			//업로드한 임시엑셀파일을 삭제한다.
			FileUploadUtil.deleteFormFile(mfile, fullPath);
		}
		
		if(sqlResultInt == 0){
			result = "FAIL";
		}else{
			result = "SUCCESS";
		}
		
		return result;
	}

	@Override
	public List<CompanyVO> listCompanyStat(CompanyVO companyVO) throws Exception {
		// TODO Auto-generated method stub
		List<CompanyVO> data = companyMapper.listCompanyStat(companyVO);
		return data;
	}
	
	@Override
	public List<CompanyVO> listCompanyStat1(CompanyVO companyVO) throws Exception {
		// TODO Auto-generated method stub
		List<CompanyVO> data = companyMapper.listCompanyStat1(companyVO);
		return data;
	}
	
	@Override
	public List<CompanyVO> listMember(CompanyVO companyVO) throws Exception {
		// TODO Auto-generated method stub
		List<CompanyVO> data = companyMapper.listMember(companyVO);
		return data;
	}
	
	@Override
	public CompanyVO mainCompanyStat() throws Exception {
		// TODO Auto-generated method stub
		return companyMapper.mainCompanyStat();
	}
	
	@Override
	public CompanyVO mainCompanyStatCnt() throws Exception {
		// TODO Auto-generated method stub
		return companyMapper.mainCompanyStatCnt();
	}
	
}
