package kr.co.gocle.oklms.lu.activity.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.commbiz.util.AtchFileUtil;
import kr.co.gocle.oklms.lu.activity.service.ActivityService;
import kr.co.gocle.oklms.lu.activity.vo.ActivityVO; 
import kr.co.gocle.oklms.lu.activity.vo.MemberVO;
import kr.co.gocle.oklms.lu.activity.vo.SubjweekStdVO;
import egovframework.com.cmm.LoginVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

@Transactional(rollbackFor=Exception.class)
@Service("ActivityService")
public class ActivityServiceImpl extends EgovAbstractServiceImpl implements ActivityService {

	@Resource(name = "activityMapper")
    private ActivityMapper activityMapper;

	@Resource(name = "atchFileService")
	private AtchFileService atchFileService;

	@Resource(name = "atchFileUtil")
	private AtchFileUtil atchFileUtil;
	
	/** ID Generation */
    @Resource(name="activityNoteIdGnrService")
    private EgovIdGnrService activityNoteIdGnrService;
    
	@Override
	public List<ActivityVO> listActivity(ActivityVO activityVO)
			throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listActivity(activityVO);
	}

	@Override
	public ActivityVO getActivity(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.getActivity(activityVO);
	}

	@Override
	public int insertActivity(ActivityVO activityVO,final MultipartHttpServletRequest multiRequest) throws Exception {
		// TODO Auto-generated method stub

		int data =0;
		if(activityVO.getActivityNoteId()==null || activityVO.getActivityNoteId().equals("")){

	  		String pkActivityId = activityNoteIdGnrService.getNextStringId();
			//첨부파일 저장	 		
			final List< MultipartFile > fileObj = multiRequest.getFiles("file-input");
			String storePathString ="Globals.fileStorePath";
			String atchFileId = atchFileService.saveAtchFile( fileObj, "ANI", "", storePathString ,"activity");
			activityVO.setActivityNoteId(pkActivityId);
			activityVO.setAtchFileId(atchFileId);
			data = activityMapper.insertActivity(activityVO);			
			
		}else{
			//첨부파일 저장	 		
			final List< MultipartFile > fileObj = multiRequest.getFiles("file-input");
			String storePathString ="Globals.fileStorePath";
			String atchFileId = atchFileService.saveAtchFile( fileObj, "ANI", "", storePathString ,"activity");
			activityVO.setAtchFileId(atchFileId);			
			data =activityMapper.updateActivity(activityVO);
			
		}	
		
		return data;
	}
	
	@Override
	public int saveActivity(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		
		int sqlResultInt = 0;
		LoginInfo loginInfo = new LoginInfo();
		LoginVO loginVO = (LoginVO) loginInfo.getLoginInfo();
		loginInfo.putSessionToVo(activityVO); // session의 정보를 VO에 추가.
		
		if( activityVO.getActivityNoteIds() != null ){
			for( int i=0; i < activityVO.getActivityNoteIds().length; i++ ){
				activityVO.setActivityNoteId(activityVO.getActivityNoteIds()[i]);
				sqlResultInt += activityMapper.saveActivity(activityVO);
			}
		}
		return sqlResultInt;
	}

	
	
	@Override
	public int updateActivity(ActivityVO activityVO,final MultipartHttpServletRequest multiRequest) throws Exception {
		// TODO Auto-generated method stub
		//첨부파일 저장	 		
		final List< MultipartFile > fileObj = multiRequest.getFiles("file-input");
		String storePathString ="Globals.fileStorePath";
		String atchFileId = atchFileService.saveAtchFile( fileObj, "ANI", "", storePathString ,"activity");
		activityVO.setAtchFileId(atchFileId);
		
		int data =activityMapper.updateActivity(activityVO);
		
		return data;
	}

	@Override
	public int deleteActivity(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.deleteActivity(activityVO);
	}

	@Override
	public SubjweekStdVO getSubjWeek(SubjweekStdVO subjweekStdVO)
			throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.getSubjWeek(subjweekStdVO);
	}

	@Override
	public List<MemberVO> listActivityMember(MemberVO memberVO)
			throws Exception {
		// TODO Auto-generated method stub
		
		List<MemberVO> data = activityMapper.listActivityMember(memberVO);
		
		
		for(int a=0 ;data.size()>a ;a++){
			ActivityVO activityVO = new ActivityVO();
			MemberVO mv=data.get(a);
			activityVO.setSubjectCode(memberVO.getSubjectCode());
			activityVO.setWeekCnt(memberVO.getWeekCnt());
			activityVO.setYyyy(memberVO.getYyyy());
			activityVO.setClassId(memberVO.getClassId());
			activityVO.setMemId(mv.getMemId());	
			activityVO.setTerm(memberVO.getTerm());
			//List<ActivityVO> resultMember = activityMapper.getActivityMember(activityVO);
			List<ActivityVO> resultMember = activityMapper.getMyActivity(activityVO);
			mv.setArrActivityVO(resultMember);
		}		
		
		return data;
	}
	
	@Override
	public List<MemberVO> listActivityOjtMember(MemberVO memberVO)
			throws Exception {
		// TODO Auto-generated method stub
		
		List<MemberVO> data = activityMapper.listActivityOjtMember(memberVO);
		
		
		for(int a=0 ;data.size()>a ;a++){
			ActivityVO activityVO = new ActivityVO();
			MemberVO mv=data.get(a);
			activityVO.setSubjectCode(memberVO.getSubjectCode());
			activityVO.setWeekCnt(memberVO.getWeekCnt());
			activityVO.setYyyy(memberVO.getYyyy());
			activityVO.setClassId(memberVO.getClassId());
			activityVO.setMemId(mv.getMemId());	
			activityVO.setTerm(memberVO.getTerm());
			//List<ActivityVO> resultMember = activityMapper.getActivityMember(activityVO);
			List<ActivityVO> resultMember = activityMapper.getMyActivity(activityVO);
			mv.setArrActivityVO(resultMember);
		}		
		
		return data;
	}
	
	@Override
	public List<MemberVO> listLessonMember(MemberVO memberVO)
			throws Exception {
		// TODO Auto-generated method stub
		
		List<MemberVO> data = activityMapper.listLessonMember(memberVO);
		
		return data;
	}
	
	@Override
	public List<MemberVO> listActivityCompany(MemberVO memberVO)
			throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listActivityCompany(memberVO);
	}

	@Override
	public List<ActivityVO> getActivityMember(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.getActivityMember(activityVO);
	}
	
	@Override
	public List<ActivityVO> getMyActivity(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.getMyActivity(activityVO);
	}
	
	@Override
	public List<ActivityVO> listOjtActivityApproval(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listOjtActivityApproval(activityVO);
	}
	
	@Override
	public List<SubjweekStdVO> listActivityHrd(SubjweekStdVO subjweekStdVO)
			throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listActivityHrd(subjweekStdVO);
	}

	@Override
	public List<SubjweekStdVO> selectActivityHrd(SubjweekStdVO subjweekStdVO)
			throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.selectActivityHrd(subjweekStdVO);
	}

	@Override
	public List<SubjweekStdVO> listWeekActivityStd(SubjweekStdVO subjweekStdVO)
			throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listWeekActivityStd(subjweekStdVO);
	}

	@Override
	public int updateActivitySubmit(ActivityVO activityVO ) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.updateActivitySubmit(activityVO);
	}

	@Override
	public List<ActivityVO> listActivityNotMake(ActivityVO activityVO)
			throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listActivityNotMake(activityVO);
	}

	@Override
	public List<SubjweekStdVO> listWeekActivityMakeStd(SubjweekStdVO activityVO)	throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listWeekActivityMakeStd(activityVO);
	}
 
	@Override
	public List<ActivityVO> listMonthActivityStd(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listMonthActivityStd(activityVO);
	}
	
	@Override
	public List<ActivityVO> listActivityCcn(ActivityVO activityVO) throws Exception {
		// TODO Auto-generated method stub
		return activityMapper.listActivityCcn(activityVO);
	}
	
}
