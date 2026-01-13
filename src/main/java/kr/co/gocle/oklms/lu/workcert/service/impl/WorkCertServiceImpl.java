package kr.co.gocle.oklms.lu.workcert.service.impl;

import java.util.List;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.mail.service.MailService;
import kr.co.gocle.oklms.commbiz.mail.vo.MailVO;
import kr.co.gocle.oklms.lu.workcert.service.WorkCertService;
import kr.co.gocle.oklms.lu.workcert.vo.WorkCertVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 재직증빙서류 제출을 위한 서비스 인터페이스 클래스
 * @author 이창현
 * @since 2016.12.29
 * @version 1.0
 *
 *
 */
@Transactional(rollbackFor=Exception.class)
@Service("workCertService")
public class WorkCertServiceImpl extends EgovAbstractServiceImpl implements WorkCertService {

	/** ID Generation */
    @Resource(name="workCertIdGnrService")
    private EgovIdGnrService workCertIdGnrService;

    @Resource(name = "workCertMapper")
    private WorkCertMapper workCertMapper;

    @Resource(name="workCertPeriodIdGnrService")
    private EgovIdGnrService workCertPeriodIdGnrService;
    
	@Resource(name = "atchFileService")
	private AtchFileService atchFileService;
	
	@Resource(name = "mailService")
	private MailService mailService;

	/**
	 * 제직징빙서류 제출 기간 등록 및 수정
	 */
	@Override
	public int goInsertWorkCertPeriod(WorkCertVO workCertVO) throws Exception {
 
		int sqlResultInt = 0;		
		sqlResultInt = workCertMapper.selectWorkCertPeriodCnt(workCertVO);
		if(sqlResultInt>0 ){
			sqlResultInt = workCertMapper.updateWorkCertPeriod(workCertVO);
		}else{
			String periodId =  workCertPeriodIdGnrService.getNextStringId();
			workCertVO.setPeriodId(periodId);
			//workCertVO.setDeptNo(workCertVO.getSessionDeptNo());
			workCertVO.setDeptNo(workCertVO.getDeptNo());
			workCertVO.setCreatorId(workCertVO.getSessionMemSeq());
			sqlResultInt = workCertMapper.goInsertWorkCertPeriod(workCertVO);
			
			List<WorkCertVO> workCertList =workCertMapper.listWorkMembers(workCertVO);
	
			// 학과 기초데이터생성
			for(int a=0;workCertList.size()>a ;a++){
				
				String pkCompanyId = workCertIdGnrService.getNextStringId();
				
				workCertVO.setWorkProofId(pkCompanyId);
				workCertVO.setMemId(workCertList.get(a).getMemId());
				workCertVO.setMemName(workCertList.get(a).getMemName());	
				workCertVO.setSendYn("N");
				sqlResultInt = workCertMapper.goInsertWorkCert(workCertVO);
				
			}
		}
		return sqlResultInt;
	}
 
	/**
	 * 제직징빙서류 제출 기간 상세
	 */
	@Override
	public WorkCertVO getWorkCertPeriod(WorkCertVO workCertVO) throws Exception {
		// TODO Auto-generated method stub
		WorkCertVO result = workCertMapper.getWorkCertPeriod(workCertVO);
		return result;
	}
	/**
	 * 제직징빙서류 제출 기간 리스트
	 */
	@Override
	public List<WorkCertVO> listWorkCertPeriod(WorkCertVO workCertVO)
			throws Exception {
		// TODO Auto-generated method stub
		List<WorkCertVO> data = workCertMapper.listWorkCertPeriod(workCertVO);
		return data;
	}
 

	/**
     * 재직증빙서류제출 목록을 조회 한다.
     *
     * @param WorkCertVO
     */
	@Override
	public List<WorkCertVO> selectWorkCert(WorkCertVO workCertVo) throws Exception {

		List<WorkCertVO> data = workCertMapper.selectWorkCert(workCertVo);
		return data;
	}

	/**
     * 재직증빙서류제출 첨부파일아이디를 조회한다.
     *
     * @param WorkCertVO
     */
	@Override
	public WorkCertVO selectAtchFileId(WorkCertVO workCertVo) throws Exception {

		WorkCertVO data = workCertMapper.selectAtchFileId(workCertVo);
		return data;
	}

    

	/**
     *  재직증빙서류를 다운로드 하면 DB를 수정한다.
     *
     * @param WorkCertVO
     */
	@Override
	public String downloadWorkCert(WorkCertVO workCertVo) throws Exception {
		String returnStr = "";
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(workCertVo);

		int sqlResultInt = workCertMapper.downloadWorkCert(workCertVo);
		if( 0 < sqlResultInt ){
			returnStr = loginInfo.getMemId();
		}
		return returnStr;
	}

	/**
     *  재직증빙서류를 다운로드 완료후 삭제에 대한 DB를 수정한다.
     *
     * @param WorkCertVO
     */
	@Override
	public String removeWorkCert(WorkCertVO workCertVo) throws Exception {
		String returnStr = "";
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.putSessionToVo(workCertVo);

		int sqlResultInt = workCertMapper.removeWorkCert(workCertVo);
		if( 0 < sqlResultInt ){
			returnStr = loginInfo.getMemId();
		}
		return returnStr;
	}
 
	/**
	 * 제직징빙서류 제출 기간 삭제
	 */
	@Override
	public int deleteWorkCertPeriod(WorkCertVO workCertVO)throws Exception {
		// TODO Auto-generated method stub
		int sqlResultInt = 0;
		sqlResultInt =  workCertMapper.deleteWorkCertPeriod(workCertVO);
		
		// 삭제성공시 제출 대상자들도 삭제처리
		if(sqlResultInt > 0){
			sqlResultInt += workCertMapper.deleteWorkProof(workCertVO);
		}
		
		return sqlResultInt;

	}
 
	/**
	 * 학습 근로자 제직징빙서류 등록 및 수정
	 */
	@Override
	public int goInsertWorkCert(WorkCertVO workCertVO,final MultipartHttpServletRequest multiRequest) throws Exception {
		
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(workCertVO); // session의 정보를 VO에 추가.

		
		String storePathString ="Globals.fileStorePath";
		String atchFileId = "";
		//첨부파일 저장	 		
		final List< MultipartFile > fileObj1 = multiRequest.getFiles("file_atchFileIdRec");
		final List< MultipartFile > fileObj2 = multiRequest.getFiles("file_atchFileIdInc");
		final List< MultipartFile > fileObj3 = multiRequest.getFiles("file_atchFileIdDoc");
		final List< MultipartFile > fileObj4 = multiRequest.getFiles("file_atchFileIdWok");
		
		if(fileObj1!=null && fileObj1.size()>0){			
			atchFileId = atchFileService.saveAtchFile( fileObj1, "", "", storePathString  ,"workcert");		
			workCertVO.setAtchFileIdRec(atchFileId);
			workCertVO.setStateRec("00");
		}
		if(fileObj2!=null && fileObj2.size()>0){			
			atchFileId = atchFileService.saveAtchFile( fileObj2, "", "", storePathString  ,"workcert");		
			workCertVO.setAtchFileIdInc(atchFileId);
			workCertVO.setStateInc("00");
		}
		if(fileObj3!=null && fileObj3.size()>0){			
			atchFileId = atchFileService.saveAtchFile( fileObj3, "", "", storePathString  ,"workcert");		
			workCertVO.setAtchFileIdDoc(atchFileId);
			workCertVO.setStateDoc("00");
		}
		if(fileObj4!=null && fileObj4.size()>0){			
			atchFileId = atchFileService.saveAtchFile( fileObj4, "", "", storePathString  ,"workcert");		
			workCertVO.setAtchFileIdWok(atchFileId);
			workCertVO.setStateWok("00");
		}
		
		int sqlResultInt = 0;		
		if(workCertVO.getWorkProofId()!=null && !workCertVO.getWorkProofId().equals("")){
			sqlResultInt = workCertMapper.updateWorkCert(workCertVO);
		}else{
			String pkCompanyId = workCertIdGnrService.getNextStringId();
			workCertVO.setWorkProofId(pkCompanyId);
			workCertVO.setSendYn("Y");
			sqlResultInt = workCertMapper.goInsertWorkCert(workCertVO);
		}
		return sqlResultInt;
	}
 

	@Override
	public int updateWorkCertMember(WorkCertVO workCertVO) throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(workCertVO); // session의 정보를 VO에 추가.

		int sqlResultInt = 0;
		//workProofId
		String memIdArr[] =  workCertVO.getMemIdArr();
		for(int i= 0 ; i <memIdArr.length; i ++  ){

			workCertVO.setMemId(memIdArr[i]);
			if(workCertVO.getReturnType() != null) {
				switch (workCertVO.getReturnType()) {
					case "Rec":
						workCertVO.setReturnReasonRec(workCertVO.getReturnReason());
						break;
					case "Inc":
						workCertVO.setReturnReasonInc(workCertVO.getReturnReason());
						break;
					case "Wok":
						workCertVO.setReturnReasonWok(workCertVO.getReturnReason());
						break;
					case "Doc":
						workCertVO.setReturnReasonDoc(workCertVO.getReturnReason());
						break;
					default:
				}
			}
			//승인일 경우 모두 승인처리
			if(workCertVO.getState().equals("01")) {
				workCertVO.setStateRec("01");
				workCertVO.setStateInc("01");
				workCertVO.setStateWok("01");
				workCertVO.setStateDoc("01");
			}
			sqlResultInt = workCertMapper.updateWorkCertMember(workCertVO);
			workCertMapper.insertWorkCertReturnReason(workCertVO);
			
			if ("Y".equals(workCertVO.getSendSms())) {
	            sendReturnSms(workCertVO);
	        }
		}

		return sqlResultInt;

	}
	
	
	@Override
	public List<WorkCertVO> listWorkCertReturnReason(WorkCertVO workCertVO)
			throws Exception {
		List<WorkCertVO> resultList= workCertMapper.listWorkCertReturnReason(workCertVO);
		return resultList;
	}
 
	@Override
	public List<WorkCertVO> listWorkCertStatePop(WorkCertVO workCertVO)
			throws Exception {
		List<WorkCertVO> resultList= workCertMapper.listWorkCertStatePop(workCertVO);
		return resultList;
	}

	@Override
	public List<WorkCertVO> listWorkCertStatePopup(WorkCertVO workCertVO)
			throws Exception {
		// TODO Auto-generated method stub
		return  workCertMapper.listWorkCertStatePopup(workCertVO);
	}

	@Override
	public List<WorkCertVO> listWorkCertDetail(WorkCertVO workCertVO)
			throws Exception {
		// TODO Auto-generated method stub
		return workCertMapper.listWorkCertDetail(workCertVO);
	}

	@Override
	public List<WorkCertVO> selectAtchFileIdList(WorkCertVO workCertVO)
			throws Exception {
		// TODO Auto-generated method stub
		return workCertMapper.selectAtchFileIdList(workCertVO);
	}

	@Override
	public int updateWorkCertMemberFiledown(WorkCertVO workCertVO)
			throws Exception {
		// TODO Auto-generated method stub
		return workCertMapper.updateWorkCertMemberFiledown(workCertVO);
	}

	@Override
	public int updateOffWorkCertMember(WorkCertVO workCertVO) throws Exception {
		// TODO Auto-generated method stub
		return workCertMapper.updateOffWorkCertMember(workCertVO);
	}
 
	@Override
	public int updateOffWorkCertClearMember(WorkCertVO workCertVO) throws Exception {
		// TODO Auto-generated method stub
		// 각 항목 제출초기화
		int iResult = workCertMapper.updateOffWorkCertClearMember(workCertVO);
		
		if(iResult > 0){
			// 오프라인 제출 카운트를 가져옴
			int checkCnt = workCertMapper.selectWorkCertMemberStateCnt(workCertVO);
			if( checkCnt == 0 ){
				workCertMapper.updateOffWorkCertClearSendMember(workCertVO);
			}
		}
		return iResult;
	}
	
	@Override
	public List<WorkCertVO> listMyDept(String sessionMemSeq)
			throws Exception {
		// TODO Auto-generated method stub
		return workCertMapper.listMyDept(sessionMemSeq);
	}
	
	
	private void sendReturnSms(WorkCertVO workCertVO) throws Exception {

	    MailVO mailVO = new MailVO();

	    mailVO.setSessionMemId(workCertVO.getSessionMemId());
	    mailVO.setSessionMemSeq(workCertVO.getSessionMemSeq());
	    mailVO.setSessionMemName(workCertVO.getSessionMemName());
	    
	    try {
	    String sender = EgovProperties.getProperty("Globals.sms.sender.default.phoneno");
		String senderName = EgovProperties.getProperty("Globals.sms.sender.default.phonename");

	    // 수신 대상
	    mailVO.setMemIds(new String[]{ workCertVO.getMemId() });

	    // 문자 내용
	    mailVO.setSmsContent(
	        "재직증빙서류가 반려 처리되었습니다.\n반려 사유: " + workCertVO.getReturnReason()
	    );
	    
	    mailVO.setSendType("SMS");
	    mailVO.setTrCallBack(sender);
	    mailVO.setSendName(senderName);
	    mailVO.setMailTempType("WORKCERT_RETURN");
	    mailVO.setRealTypeYn("Y");

	    mailService.insertSendMaster(mailVO);
	    } catch (Exception e) {
		    e.printStackTrace();
		}
	}
}
