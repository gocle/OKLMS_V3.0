package kr.co.gocle.oklms.lu.traning.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.lu.activity.service.impl.ActivityMapper;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO;
import kr.co.gocle.oklms.lu.traning.service.TraningNoteSerivce;
import kr.co.gocle.oklms.lu.traning.service.TraningService;
import kr.co.gocle.oklms.lu.traning.vo.TraningMemberVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningProcessMappingVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningVO; 

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.com.cmm.LoginVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

@Transactional(rollbackFor=Exception.class)
@Service("traningNoteSerivce")
public class TraningNoteServiceImpl extends EgovAbstractServiceImpl implements TraningNoteSerivce {
	/** ID Generation */
    @Resource(name="traningProcessIdGnrService")
    private EgovIdGnrService traningProcessIdGnrService;

    @Resource(name="traningProcessMappingIdGnrService")
    private EgovIdGnrService traningProcessMappingIdGnrService;

	/** ID Generation */
	// 훈련 상세 lms_traning_note_detail
    @Resource(name="traningDetailIdGnrService")
    private EgovIdGnrService traningDetailIdGnrService;

	/** ID Generation */
	// 훈련 상세 lms_traning_note_detail
    @Resource(name="traningMasterIdGnrService")
    private EgovIdGnrService traningMasterIdGnrService;
    
    //lms_subj_week_time_enrichment
    @Resource(name="traningWeekTimeEnrichmentWeekIdGnrService")
    private EgovIdGnrService traningWeekTimeEnrichmentWeekIdGnrService;

    @Resource(name="traningWeekTimeEnrichmentTimeIdGnrService")
    private EgovIdGnrService traningWeekTimeEnrichmentTimeIdGnrService;
    
    /** ID Generation */
    @Resource(name="subjWeekTimeIdGnrService")
    private EgovIdGnrService subjWeekTimeIdGnrService;

    @Resource(name = "traningNoteMapper")
    private TraningNoteMapper traningNoteMapper;
    
	@Resource(name = "activityMapper")
    private ActivityMapper activityMapper;
	
	/** ID Generation */
    @Resource(name="activityNoteIdGnrService")
    private EgovIdGnrService activityNoteIdGnrService;
    
	@Override
	public TraningNoteVO getTraningNote(TraningNoteVO traningNoteVO)throws Exception {
		TraningNoteVO result = traningNoteMapper.getTraningNote(traningNoteVO);
		return result;
	}
	
	@Override
	public TraningNoteVO getSubject(TraningNoteVO traningNoteVO)throws Exception {
		TraningNoteVO result = traningNoteMapper.getSubject(traningNoteVO);
		return result;
	}
	
	@Override
	public List<TraningNoteVO> listTraningRegularClassMember(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = null;
		data = traningNoteMapper.listTraningRegularClassMember(traningNoteVO);
		return data;
	}
	@Override
	public List<TraningNoteVO> listTraningRegularClassHsMember(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = null;
		data = traningNoteMapper.listTraningRegularClassHsMember(traningNoteVO);
		return data;
	}
	@Override
	public List<TraningNoteVO> listTraningClassMember(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listTraningClassMember(traningNoteVO);
		return data;
	}
	
	@Override
	public TraningNoteVO getTraningRegularTime(TraningNoteVO traningNoteVO) 	throws Exception {

		TraningNoteVO result  = traningNoteMapper.getTraningRegularTime(traningNoteVO);
		return result;
	}

	@Override
	public int goInsertTraningNoteDetail(TraningNoteVO traningNoteVO)	throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		traningNoteVO.setFeedback(loginVO.getSessionMemName());
		int sqlResultInt = 0;

		String memId [] = traningNoteVO.getMemIdArr();
		String startTime[] = traningNoteVO.getStudyTimeArr();
		String bigo[] = traningNoteVO.getBigoArr();
		String memNm[] = traningNoteVO.getMemNmArr();
		String traniningNoteDetailId = "";
		String traniningNoteMasterId = "";

		String traniningNoteDetailIdArr[] = traningNoteVO.getTraniningNoteDetailIdArr();
		String traniningNoteMasterIdArr[] = traningNoteVO.getTraniningNoteMasterIdArr();

		for(int i = 0; i < memId.length; i++ ){

			traningNoteVO.setMemId(memId[i]);
			traningNoteVO.setStartTime(startTime[i]);
			traningNoteVO.setBigo(bigo[i]);
			traningNoteVO.setMemNm(memNm[i]);
			 
			//수정시 
			if(traniningNoteDetailIdArr[i] != ""){
				traningNoteVO.setTraniningNoteDetailId(traniningNoteDetailIdArr[i]);
				traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterIdArr[i]);
				
				traningNoteVO.setAchievement(traningNoteVO.getScore()[i]);
				sqlResultInt = traningNoteMapper.goUpdateTraningNoteMaster(traningNoteVO);
				sqlResultInt = traningNoteMapper.goUpdateTraningNoteDetail(traningNoteVO);
			//등록시
			}else{
				if(i==0){
					traniningNoteMasterId = traningMasterIdGnrService.getNextStringId();
					traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterId);
					sqlResultInt = traningNoteMapper.goInsertTraningNoteMaster(traningNoteVO);
				}
					traniningNoteDetailId = traningDetailIdGnrService.getNextStringId();
					traningNoteVO.setTraniningNoteDetailId(traniningNoteDetailId);
					traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterId);
					traningNoteVO.setAchievement(traningNoteVO.getScore()[i]);
					sqlResultInt = traningNoteMapper.goInsertTraningNoteDetail(traningNoteVO);

			}
		}
		return sqlResultInt;
	}
	
	
	@Override
	public int goInsertOjtTraningNoteDetail(TraningNoteVO traningNoteVO)	throws Exception {

		LoginInfo loginInfo = new LoginInfo();
		ActivityVO	activityVO = new ActivityVO();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		loginInfo.putSessionToVo(activityVO);
		traningNoteVO.setFeedback(loginVO.getSessionMemName());
		int sqlResultInt = 0;
		
		String memId [] = traningNoteVO.getMemIdArr();
		String startTime[] = traningNoteVO.getStudyTimeArr();
		String bigo[] = traningNoteVO.getBigoArr();
		String memNm[] = traningNoteVO.getMemNmArr();
		String traniningNoteDetailId = "";
		String traniningNoteMasterId = "";

		String traniningNoteDetailIdArr[] = traningNoteVO.getTraniningNoteDetailIdArr();
		String traniningNoteMasterIdArr[] = traningNoteVO.getTraniningNoteMasterIdArr();
		
		
		for(int i = 0; i < memId.length; i++ ){

			traningNoteVO.setMemId(memId[i]);
			traningNoteVO.setStartTime(startTime[i]);
			traningNoteVO.setBigo(bigo[i]);
			traningNoteVO.setMemNm(memNm[i]);
			
			System.out.println("======== traningNoteVO.getMemId() : "+traningNoteVO.getMemId());
			System.out.println("======== traningNoteVO.setMemNm() : "+traningNoteVO.getMemNm());
			
			//수정시 
			if(traniningNoteDetailIdArr[i] != ""){
				traningNoteVO.setTraniningNoteDetailId(traniningNoteDetailIdArr[i]);
				traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterIdArr[i]);
				
				traningNoteVO.setAchievement(traningNoteVO.getScore()[i]);
				sqlResultInt = traningNoteMapper.goUpdateTraningNoteMaster(traningNoteVO);
				sqlResultInt = traningNoteMapper.goUpdateTraningNoteDetail(traningNoteVO);
				
				// 고숙련 학생일 경우 학습활동서도 같이 등록
				if(sqlResultInt > 0){
					activityVO.setYyyy(traningNoteVO.getYyyy());
					activityVO.setTerm(traningNoteVO.getTerm());
					activityVO.setSubjectCode(traningNoteVO.getSubjectCode());
					activityVO.setClassId(traningNoteVO.getClassId());
					activityVO.setWeekCnt(traningNoteVO.getWeekCnt());
					activityVO.setContent(traningNoteVO.getReview());
					activityVO.setTimeId(traningNoteVO.getTimeId());
					sqlResultInt += activityMapper.updateActivityHs(activityVO);	
				}
				
			//등록시
			}else{
				traniningNoteMasterId = traningMasterIdGnrService.getNextStringId();
				traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterId);
				sqlResultInt = traningNoteMapper.goInsertTraningNoteMaster(traningNoteVO);
				traniningNoteDetailId = traningDetailIdGnrService.getNextStringId();
				traningNoteVO.setTraniningNoteDetailId(traniningNoteDetailId);
				traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterId);
				traningNoteVO.setAchievement(traningNoteVO.getScore()[i]);
				sqlResultInt = traningNoteMapper.goInsertTraningNoteDetail(traningNoteVO);
				
				// 고숙련 학생일 경우 학습활동서도 같이 등록
				if(sqlResultInt > 0){
					activityVO.setActivityNoteId(activityNoteIdGnrService.getNextStringId());
					activityVO.setYyyy(traningNoteVO.getYyyy());
					activityVO.setTerm(traningNoteVO.getTerm());
					activityVO.setSubjectCode(traningNoteVO.getSubjectCode());
					activityVO.setClassId(traningNoteVO.getClassId());
					activityVO.setWeekCnt(traningNoteVO.getWeekCnt());
					activityVO.setTraningType("OJT");
					activityVO.setContent(traningNoteVO.getReview());
					activityVO.setTimeId(traningNoteVO.getTimeId());
					activityVO.setMemId(traningNoteVO.getMemId());
					activityVO.setMemNm(traningNoteVO.getMemNm());
					sqlResultInt += activityMapper.insertActivity(activityVO);	
				}

			}
		}
			
					
	
		return sqlResultInt;
	}

	
	
	@Override
	public int applovalOjtTraningNote(TraningNoteVO traningNoteVO) throws Exception {
		int sqlResultInt = 0;
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		
		if( traningNoteVO.getTraniningNoteMasterIds() != null ){
			for( int i=0; i < traningNoteVO.getTraniningNoteMasterIds().length; i++ ){
				
				//2020TNMI0030365|HSKILL|2020TIME0078885|2051039015
				
				String traniningNoteMasterId = traningNoteVO.getTraniningNoteMasterIds()[i].split("\\|")[0];
				String subjectType = traningNoteVO.getTraniningNoteMasterIds()[i].split("\\|")[1];
				String timeId = traningNoteVO.getTraniningNoteMasterIds()[i].split("\\|")[2];
				String memId = traningNoteVO.getTraniningNoteMasterIds()[i].split("\\|")[3];
				
				traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterId);
				sqlResultInt += traningNoteMapper.applovalOjtTraningNote(traningNoteVO);
				
				if(subjectType.equals("HSKILL")){ // 고숙련 과정일 경우 학습활동서도 업데이트
					ActivityVO activityVO = new ActivityVO();
					loginInfo.putSessionToVo(activityVO);
					activityVO.setStatus(traningNoteVO.getStatus());
					activityVO.setTimeId(timeId);
					activityVO.setMemId(memId);
					activityVO.setReturnComment(traningNoteVO.getReturnComment());
					activityMapper.approvalActivity(activityVO);
				}
				
			}
		}

		return sqlResultInt;
	}
	
	@Override
	public int applovalOjtTraningNoteOne(TraningNoteVO traningNoteVO) throws Exception {
		int sqlResultInt = 0;
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		
		if( traningNoteVO.getTraniningNoteMasterIds() != null ){
			for( int i=0; i < traningNoteVO.getTraniningNoteMasterIds().length; i++ ){
				
				traningNoteVO.setTraniningNoteMasterId(traningNoteVO.getTraniningNoteMasterIds()[i]);
				sqlResultInt += traningNoteMapper.applovalOjtTraningNote(traningNoteVO);
			}
		}

		return sqlResultInt;
	}
	
	@Override
	public int saveTraningNoteTime(TraningNoteVO traningNoteVO) throws Exception {
		traningNoteVO.setTimeId(subjWeekTimeIdGnrService.getNextStringId());
		int sqlResultInt = traningNoteMapper.saveTraningNoteTime(traningNoteVO);
		return sqlResultInt;
	}
	
	@Override
	public int updateTraningNoteTime(TraningNoteVO traningNoteVO) throws Exception {
		int sqlResultInt = traningNoteMapper.updateTraningNoteTime(traningNoteVO);
		return sqlResultInt;
	}
	
	@Override
	public int deleteTraningNoteTime(TraningNoteVO traningNoteVO) throws Exception {
		int sqlResultInt = traningNoteMapper.deleteTraningNoteTime(traningNoteVO);
		sqlResultInt += traningNoteMapper.deleteActivity(traningNoteVO);
		return sqlResultInt;
	}
	
	@Override
	public List<TraningNoteVO> getTraningEnrichmentTime(TraningNoteVO traningNoteVO)	throws Exception {
		 List<TraningNoteVO> result  = traningNoteMapper.getTraningEnrichmentTime(traningNoteVO);
		return result;
	}

	@Override
	public List<TraningNoteVO> listTraningEnrichmentClassMember(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listTraningEnrichmentClassMember(traningNoteVO);
		return data;
	}

	@Override
	public int goInsertEnrichmentTraningTime(TraningNoteVO traningNoteVO)	throws Exception { 
 
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		traningNoteVO.setFeedback(loginVO.getSessionMemName());

		int sqlResultInt = 0;
 
		String memId [] = traningNoteVO.getMemIdArr();
		String startTime[] = traningNoteVO.getStudyTimeArr();
		String bigo[] = traningNoteVO.getBigoArr();
		String memNm[] = traningNoteVO.getMemNmArr();
		String traniningNoteDetailId = "";
		String traniningNoteMasterId = "";

		traningNoteVO.setDeleteYn("N");
		if(traningNoteVO.getTimeId() == ""){
			String timeId = traningWeekTimeEnrichmentTimeIdGnrService.getNextStringId();
			traningNoteVO.setTimeId(timeId);
			sqlResultInt = traningNoteMapper.goInsertEnrichmentTraningTime(traningNoteVO);
		}else{
			sqlResultInt = traningNoteMapper.goUpdateEnrichmentTraningTime(traningNoteVO);
		}

		for(int i = 0; i < memId.length; i++ ){

			traningNoteVO.setMemId(memId[i]);
			traningNoteVO.setStartTime(startTime[i]);
			traningNoteVO.setBigo(bigo[i]);
			traningNoteVO.setMemNm(memNm[i]);
			traningNoteVO.setAchievement(traningNoteVO.getScore()[i]);

			String traniningNoteDetailIdArr[] = traningNoteVO.getTraniningNoteDetailIdArr();
			//String traniningNoteMasterIdArr[] = traningNoteVO.getTraniningNoteMasterIdArr();
			
			//수정시
			if(traniningNoteDetailIdArr[i] != ""){
				traningNoteVO.setTraniningNoteDetailId(traniningNoteDetailIdArr[i]);
				traningNoteVO.setTraniningNoteMasterId(traningNoteVO.getTraniningNoteMasterId());
				sqlResultInt = traningNoteMapper.goUpdateTraningNoteMaster(traningNoteVO);
				sqlResultInt = traningNoteMapper.goUpdateTraningNoteDetail(traningNoteVO);
			//등록시
			}else{
					// 첫번째인데 마스터키가없을경우 생성(신규등록시)
					if(i==0 && (traningNoteVO.getTraniningNoteMasterId()==null || traningNoteVO.getTraniningNoteMasterId().equals(""))){
						traniningNoteMasterId = traningMasterIdGnrService.getNextStringId();
						traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterId);
						sqlResultInt = traningNoteMapper.goInsertTraningNoteMaster(traningNoteVO);
					}else{
						// 마스터키가 있는경우(추가등록시)
						traniningNoteMasterId = traningNoteVO.getTraniningNoteMasterId();
					}

					traniningNoteDetailId = traningDetailIdGnrService.getNextStringId();
					traningNoteVO.setTraniningNoteDetailId(traniningNoteDetailId);
					traningNoteVO.setTraniningNoteMasterId(traniningNoteMasterId);
					sqlResultInt = traningNoteMapper.goInsertTraningNoteDetail(traningNoteVO);
			}
		}
		return sqlResultInt;
	}

	@Override
	public int deleteTraningNoteEnrichment(TraningNoteVO traningNoteVO)
			throws Exception {
		int sqlResultInt = 0;
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(traningNoteVO); // session의 정보를 VO에 추가.
		traningNoteVO.setDeleteYn("Y");
		//sqlResultInt = traningNoteMapper.goUpdateTraningNoteMaster(traningNoteVO);
		sqlResultInt = traningNoteMapper.goUpdateTraningNoteDetail(traningNoteVO);

		return sqlResultInt;
	}

	@Override
	public List<TraningNoteVO> listSubjcetName(TraningNoteVO traningNoteVO)
			throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listSubjcetName(traningNoteVO);
		return data;
	}

	@Override
	public List<TraningNoteVO> listTraningRegularTime(
			TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listTraningRegularTime(traningNoteVO);
		return data;
	}
	
	@Override
	public List<TraningNoteVO> listHsTraningRegularTime(
			TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listHsTraningRegularTime(traningNoteVO);
		return data;
	}
	
	
	@Override
	public int getTraningRegularClassMemberCnt(TraningNoteVO traningNoteVO)
			throws Exception {
		// TODO Auto-generated method stub
		return   traningNoteMapper.getTraningRegularClassMemberCnt(traningNoteVO);
	}

	@Override
	public TraningNoteVO getTraningNowWeekCnt(TraningNoteVO traningNoteVO)
			throws Exception {
		// TODO Auto-generated method stub
		return traningNoteMapper.getTraningNowWeekCnt(traningNoteVO);
	}
	
	@Override
	public List<TraningNoteVO> listOjtTraningNoteApproval(
			TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listOjtTraningNoteApproval(traningNoteVO);
		return data;
	}
	
	
	
	@Override
	public TraningNoteVO getMonthTraningNoteOt(TraningNoteVO traningNoteVO) 	throws Exception {

		TraningNoteVO result  = traningNoteMapper.getMonthTraningNoteOt(traningNoteVO);
		return result;
	}
	
	@Override
	public List<TraningNoteVO> listMonthTraningNoteOt(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listMonthTraningNoteOt(traningNoteVO);
		return data;
	}
	
	@Override
	public List<TraningNoteVO> listTraningNoteCcn(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> data = traningNoteMapper.listTraningNoteCcn(traningNoteVO);
		return data;
	}
	
	
}
