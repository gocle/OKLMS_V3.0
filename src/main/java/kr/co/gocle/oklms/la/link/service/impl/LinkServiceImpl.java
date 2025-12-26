
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
package kr.co.gocle.oklms.la.link.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.aunuri.service.impl.AunuriLinkMapper;
import kr.co.gocle.aunuri.vo.AunuriLinkLessonVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberMappingVO;
import kr.co.gocle.aunuri.vo.AunuriLinkMemberVO;
import kr.co.gocle.aunuri.vo.AunuriLinkScheduleVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekNcsVO;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekVO;
import kr.co.gocle.ifx.service.impl.CmsIfxServiceImpl;
import kr.co.gocle.oklms.comm.util.CommonUtil;
import kr.co.gocle.oklms.commbiz.cmmcode.service.CommonCodeService;
import kr.co.gocle.oklms.commbiz.cmmcode.vo.CommonCodeVO;
import kr.co.gocle.oklms.la.link.service.LinkService;
import kr.co.gocle.oklms.la.member.service.impl.MemberMapper;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;












import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

 /**
 * 프로토타입 게시판 CRUD 비지니스 로직을 구현하는 클레스.
 * @author 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("linkService")
public class LinkServiceImpl extends EgovAbstractServiceImpl implements LinkService {
	
	private static final Logger LOG = LoggerFactory.getLogger(LinkServiceImpl.class);
	
	/** ID Generation */
    @Resource(name="memberIdGnrService")
    private EgovIdGnrService memberIdGnrService;
    
	/** ID Generation */
    @Resource(name="memberIdGnrService")
    private EgovIdGnrService memberIdInsGnrService;
    
    /** ID Generation */
    @Resource(name="subjWeekIdGnrService")
    private EgovIdGnrService subjWeekIdGnrService;
    
    /** ID Generation */
    @Resource(name="subjWeekTimeIdGnrService")
    private EgovIdGnrService subjWeekTimeIdGnrService;
    
    /** ID Generation */
    @Resource(name="insMappingIdGnrService")
    private EgovIdGnrService insMappingIdGnrService;
    
    /** ID Generation */
    @Resource(name="cdpMappingIdGnrService")
    private EgovIdGnrService cdpMappingIdGnrService;
    
    /** ID Generation */
    @Resource(name="lessonIdGnrService")
    private EgovIdGnrService lessonIdGnrService;
    
    /** ID Generation */
    @Resource(name="subjectHistoryIdGnrService")
    private EgovIdGnrService subjectHistoryIdGnrService;
	
	@Resource(name = "aunuriLinkMapper")
    private AunuriLinkMapper aunuriLinkMapper;
	
    @Resource(name = "linkMapper")
    private LinkMapper linkMapper;
    
    @Resource(name = "memberMapper")
    private MemberMapper memberMapper;
    
    @Resource(name = "commonCodeService")
    private CommonCodeService  commonCodeService;
	
	@Override
	public int insertAunuriMember(AunuriLinkMemberVO aunuriLinkMemberVO) throws Exception {
		
		List<AunuriLinkMemberVO> data = aunuriLinkMapper.listAunuriMember(aunuriLinkMemberVO);
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				aunuriLinkMemberVO = data.get(i);
				aunuriLinkMemberVO.setMemSeq(memberIdGnrService.getNextStringId());
				iResult += linkMapper.insertAunuriMember(aunuriLinkMemberVO);
			}
		}
		
		return iResult;
	}
	

	@Override
    public int insertAunuriSubject(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception {
		
		List<AunuriLinkSubjectVO> data = aunuriLinkMapper.listAunuriSubject(aunuriLinkSubjectVO);
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				aunuriLinkSubjectVO = data.get(i);
				
				// 개설교과목 등록
				iResult += linkMapper.insertAunuriSubject(aunuriLinkSubjectVO);
				
				// Off-JT 일 경우에만 주차등록
				if("OFF".equals(aunuriLinkSubjectVO.getSubjectTraningType())){
					// 주차, 주차별 시간, 주차별 NCS  정보등록
					for( int x=0;  x < 15; x++ ){	// 현시점에서는 듀얼쪽은 15주차라 하드 코딩 (학습계획서에는 15주차 이상이라해도 실제로 15주차)
						AunuriLinkSubjectWeekVO weekVO = new AunuriLinkSubjectWeekVO();
						
						weekVO.setWeekId(subjWeekIdGnrService.getNextStringId());
						weekVO.setWeekCnt(String.valueOf( x+1 ) ); 
						weekVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
						weekVO.setTerm(aunuriLinkSubjectVO.getTerm());
						weekVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
						weekVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
						
						AunuriLinkSubjectWeekVO infoVO = aunuriLinkMapper.getAunuriWeekLessonInfo(weekVO);
						
						if(infoVO != null){
							weekVO.setLessonCn(infoVO.getLessonCn());
							weekVO.setLessonMthd(infoVO.getLessonMthd());
						}
						
						
						// 교과목 > 주차등록
						iResult += linkMapper.insertAunuriSubjectWeek(weekVO);
						
						AunuriLinkSubjectWeekVO weekTimeVO = aunuriLinkMapper.getAunuriWeekTime(weekVO);
						
						// 교과목 주차 > 시간
						if( weekTimeVO != null ) {
							weekTimeVO.setWeekId(weekVO.getWeekId());
							weekTimeVO.setTimeId(subjWeekTimeIdGnrService.getNextStringId());
							iResult += linkMapper.insertAunuriWeekTime(weekTimeVO);
						}
					}
				}
			}
		}
		
		return iResult;
	}
    
	
	@Override
    public int insertAunuriLesson(AunuriLinkLessonVO aunuriLinkLessonVO) throws Exception {
		
		List<AunuriLinkLessonVO> data = aunuriLinkMapper.listAunuriLesson(aunuriLinkLessonVO);
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				aunuriLinkLessonVO = data.get(i);
				String memSeq = memberMapper.getMemberSeq(aunuriLinkLessonVO.getMemId());
				aunuriLinkLessonVO.setMemSeq(memSeq);
				aunuriLinkLessonVO.setLecStatus("A");
				aunuriLinkLessonVO.setLessonId(lessonIdGnrService.getNextStringId());
				
				iResult += linkMapper.insertAunuriLesson(aunuriLinkLessonVO);
				
			}
		}
		
		return iResult;
	}
	
	@Override
    public int insertAunuriIns(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception {
		
		List<AunuriLinkMemberMappingVO> data = aunuriLinkMapper.listAunuriIns(aunuriLinkMemberMappingVO);
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				
				aunuriLinkMemberMappingVO = data.get(i);
				String memSeq = memberMapper.getMemberSeq(aunuriLinkMemberMappingVO.getMemId());
				
				// 회원정보가 있을경우에만 등록
				if(memSeq != null && !"".equals(memSeq)){
					aunuriLinkMemberMappingVO.setMemSeq(memSeq);
					aunuriLinkMemberMappingVO.setSubjInsMappingId(insMappingIdGnrService.getNextStringId());
					iResult += linkMapper.insertAunuriIns(aunuriLinkMemberMappingVO);
				}
			}
		}
		
		return iResult;
	}
	
	@Override
    public int insertAunuriCdp(AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO) throws Exception {
		
		List<AunuriLinkMemberMappingVO> data = linkMapper.listSubjectCdp(aunuriLinkMemberMappingVO);
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				
				aunuriLinkMemberMappingVO = data.get(i);
				aunuriLinkMemberMappingVO.setSubjCdpMappingId(cdpMappingIdGnrService.getNextStringId());
				
				iResult += linkMapper.insertAunuriCdp(aunuriLinkMemberMappingVO);
			}
		}
		
		return iResult;
	}
	
	@Override
    public int insertAunuriSchedule(AunuriLinkScheduleVO aunuriLinkScheduleVO) throws Exception {
		
		List<AunuriLinkScheduleVO> data = aunuriLinkMapper.listAunuriHaksaSchedule(aunuriLinkScheduleVO);
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				
				aunuriLinkScheduleVO = data.get(i);
				
				iResult += linkMapper.insertAunuriSchedule(aunuriLinkScheduleVO);
			}
		}
		return iResult;
	}
	
	
	@Override
    public int insertAunuriWeekNcs(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception {
		
		
		List<AunuriLinkSubjectWeekNcsVO> data = linkMapper.listAunuriWeek(aunuriLinkSubjectWeekNcsVO);
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				
				aunuriLinkSubjectWeekNcsVO = data.get(i);
				
				LOG.debug("===================================  list getWeekId : "+aunuriLinkSubjectWeekNcsVO.getWeekId());
				LOG.debug("===================================  list getYyyy :   "+aunuriLinkSubjectWeekNcsVO.getYyyy());
				LOG.debug("===================================  list getTerm :   "+aunuriLinkSubjectWeekNcsVO.getTerm());
				LOG.debug("===================================  list getSubjectCode :   "+aunuriLinkSubjectWeekNcsVO.getSubjectCode());
				LOG.debug("===================================  list getSubjectClass :   "+aunuriLinkSubjectWeekNcsVO.getSubjectClass());
				LOG.debug("===================================  list getWeekCnt :   "+aunuriLinkSubjectWeekNcsVO.getWeekCnt());
				
				// NCS 단위를 가져옴
				AunuriLinkSubjectWeekNcsVO weekNcsVO = aunuriLinkMapper.getAunuriWeekNcsUnit(aunuriLinkSubjectWeekNcsVO);
				
				if(weekNcsVO != null){
					weekNcsVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
					
					LOG.debug("***************************************  weekNcsVO getYyyy :   "+weekNcsVO.getYyyy());
					LOG.debug("***************************************  weekNcsVO getTerm :   "+weekNcsVO.getTerm());
					LOG.debug("***************************************  weekNcsVO getSubjectCode :   "+weekNcsVO.getSubjectCode());
					LOG.debug("***************************************  weekNcsVO getSubjectClass :   "+weekNcsVO.getSubjectClass());
					LOG.debug("***************************************  weekNcsVO getWeekCnt :   "+weekNcsVO.getWeekCnt());
					LOG.debug("***************************************  weekNcsVO getNcsUnitId :   "+weekNcsVO.getNcsUnitId());
					LOG.debug("***************************************  weekNcsVO getNcsUnitName :   "+weekNcsVO.getNcsUnitName());
					
					// NCS 단위 등록
					iResult += linkMapper.insertAunuriWeekNcsUnit(weekNcsVO);
					
					// NCS 요소를 가져옴
					weekNcsVO.setWeekCnt(aunuriLinkSubjectWeekNcsVO.getWeekCnt());
					List<AunuriLinkSubjectWeekNcsVO> dataList = aunuriLinkMapper.listAunuriWeekNcsElem(weekNcsVO);
					
					for(int x=0; x < dataList.size(); x++){
						AunuriLinkSubjectWeekNcsVO elemVO = dataList.get(x);
						
						LOG.debug("############################### elemVO getYyyy :   "+weekNcsVO.getYyyy());
						LOG.debug("###############################  elemVO getTerm :   "+weekNcsVO.getTerm());
						LOG.debug("###############################  elemVO getSubjectCode :   "+weekNcsVO.getSubjectCode());
						LOG.debug("###############################  elemVO getSubjectClass :   "+weekNcsVO.getSubjectClass());
						LOG.debug("###############################  elemVO getWeekCnt :   "+weekNcsVO.getWeekCnt());
						LOG.debug("###############################  elemVO getNcsUnitId :   "+weekNcsVO.getNcsUnitId());
						LOG.debug("###############################  elemVO getNcsElemtId :   "+weekNcsVO.getNcsElemId());
						LOG.debug("###############################  elemVO getNcsElemName :   "+weekNcsVO.getNcsElemName());
						
						elemVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
						iResult += linkMapper.insertAunuriWeekNcsElem(elemVO);
					}
				}
			}
		}
		return iResult;
	}
	
	
	@Override
    public int updateAunuriWeek(AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO) throws Exception {
		
		
		List<AunuriLinkSubjectWeekNcsVO> data = linkMapper.listAunuriWeek(aunuriLinkSubjectWeekNcsVO);
		
		
		int iResult = 0;
		if( data.size() > 0 ) {
			for( int i=0; i < data.size(); i++ ){
				
				aunuriLinkSubjectWeekNcsVO = data.get(i);
				
				
				LOG.debug("===================================  list getWeekId : "+aunuriLinkSubjectWeekNcsVO.getWeekId());
				LOG.debug("===================================  list getYyyy :   "+aunuriLinkSubjectWeekNcsVO.getYyyy());
				LOG.debug("===================================  list getTerm :   "+aunuriLinkSubjectWeekNcsVO.getTerm());
				LOG.debug("===================================  list getSubjectCode :   "+aunuriLinkSubjectWeekNcsVO.getSubjectCode());
				LOG.debug("===================================  list getSubjectClass :   "+aunuriLinkSubjectWeekNcsVO.getSubjectClass());
				LOG.debug("===================================  list getWeekCnt :   "+aunuriLinkSubjectWeekNcsVO.getWeekCnt());
				
				// NCS 단위를 가져옴
				AunuriLinkSubjectWeekNcsVO weekNcsVO = aunuriLinkMapper.getAunuriWeekNcsUnit(aunuriLinkSubjectWeekNcsVO);
				
				if(weekNcsVO != null){
					weekNcsVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
					
					LOG.debug("***************************************  weekNcsVO getYyyy :   "+weekNcsVO.getYyyy());
					LOG.debug("***************************************  weekNcsVO getTerm :   "+weekNcsVO.getTerm());
					LOG.debug("***************************************  weekNcsVO getSubjectCode :   "+weekNcsVO.getSubjectCode());
					LOG.debug("***************************************  weekNcsVO getSubjectClass :   "+weekNcsVO.getSubjectClass());
					LOG.debug("***************************************  weekNcsVO getWeekCnt :   "+weekNcsVO.getWeekCnt());
					LOG.debug("***************************************  weekNcsVO getNcsUnitId :   "+weekNcsVO.getNcsUnitId());
					LOG.debug("***************************************  weekNcsVO getNcsUnitName :   "+weekNcsVO.getNcsUnitName());
					
					// NCS 단위 등록
					iResult += linkMapper.insertAunuriWeekNcsUnit(weekNcsVO);
					
					// NCS 요소를 가져옴
					weekNcsVO.setWeekCnt(aunuriLinkSubjectWeekNcsVO.getWeekCnt());
					List<AunuriLinkSubjectWeekNcsVO> dataList = aunuriLinkMapper.listAunuriWeekNcsElem(weekNcsVO);
					
					for(int x=0; x < dataList.size(); x++){
						AunuriLinkSubjectWeekNcsVO elemVO = dataList.get(x);
						
						LOG.debug("############################### elemVO getYyyy :   "+weekNcsVO.getYyyy());
						LOG.debug("###############################  elemVO getTerm :   "+weekNcsVO.getTerm());
						LOG.debug("###############################  elemVO getSubjectCode :   "+weekNcsVO.getSubjectCode());
						LOG.debug("###############################  elemVO getSubjectClass :   "+weekNcsVO.getSubjectClass());
						LOG.debug("###############################  elemVO getWeekCnt :   "+weekNcsVO.getWeekCnt());
						LOG.debug("###############################  elemVO getNcsUnitId :   "+weekNcsVO.getNcsUnitId());
						LOG.debug("###############################  elemVO getNcsElemtId :   "+weekNcsVO.getNcsElemId());
						LOG.debug("###############################  elemVO getNcsElemName :   "+weekNcsVO.getNcsElemName());
						
						elemVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
						iResult += linkMapper.insertAunuriWeekNcsElem(elemVO);
					}
				}
			}
		}
		return iResult;
	}
	
	
	@Override
	public int insertAunuriLinkTerm(AunuriLinkSubjectVO aunuriLinkSubjectVO) throws Exception {
		
		// 연계 후 등록 교과목정보를 불러옴
		// 교과목정보 OKLMS 등록
		// 해당 교과목의 학습근로자 및 교수자 목록을 조회
		// 학습근로자 및 교수자가 OKLMS 에 없다면 회원등록
		// 수강정보 등록
		// 교수정보 매핑
		// 학과전담자 매핑
		
		int iResult = 0;
		int weekLen = 0;
		String leadTime = "";
		String weekStartDate = aunuriLinkSubjectVO.getWeekStartDate();
		
		// 임시 =====================
		//aunuriLinkSubjectVO.setYyyy("2017");
		//aunuriLinkSubjectVO.setTerm("3");
		// 임시 =====================
		List<AunuriLinkSubjectVO> data = aunuriLinkMapper.listAunuriTermSubject(aunuriLinkSubjectVO);
		
		if( data.size() > 0 ) {
			
			// 2학기 연동시 고숙련 학번업데이트
			if(aunuriLinkSubjectVO.getTerm().equals("2")){
			//	linkMapper.updateStdLecTargetYear();
			}
			
			String historyId = subjectHistoryIdGnrService.getNextStringId();
			
			//weekStartDate = aunuriLinkMapper.getAunuriWeekStartDate(aunuriLinkSubjectVO);
			// 임시 =====================
			//weekStartDate = "2017.06.24";
			// 임시 =====================
			
			for( int i=0; i < data.size(); i++ ){
				
				aunuriLinkSubjectVO = data.get(i);
				aunuriLinkSubjectVO.setHistoryId(historyId);
				
				// 정규학기일 경우 디폴트 15주
				if(aunuriLinkSubjectVO.getTerm().equals("1") || aunuriLinkSubjectVO.getTerm().equals("2")){
					weekLen = 15;
				} else { // 계절학기일 경우 순수 온라인은 4주 그 외는 5주
					if(aunuriLinkSubjectVO.getOnlineType().equals("101")){
						weekLen = 4;
					} else {
						weekLen = 5;
					} 
					
					// 계절학기이고 OJT일 경우 주차는 8주차로 세팅 
					if("OJT".equals(aunuriLinkSubjectVO.getSubjectTraningType())){
						weekLen = 8;
					}
				}
				
				// 브렌디드 과정 > 플립러닝으로 변경
				
				//순수온라인 : 101
				//브렌디드 : 102
				//보조활용 : 103
				//플립러닝 10주 : 104
				//플립러닝  4주 : 105
				//평생교육과정 온라인강좌 : 106
				//플립러닝  8주 : 107
				//플립러닝 12주 : 108
				
				if(aunuriLinkSubjectVO.getOnlineType().equals("102") || aunuriLinkSubjectVO.getOnlineType().equals("105") || aunuriLinkSubjectVO.getOnlineType().equals("107") || aunuriLinkSubjectVO.getOnlineType().equals("108") ){
					aunuriLinkSubjectVO.setOnlineType("104");
				}
				
				//String sumOffTimeHour = (aunuriLinkSubjectVO.getLctreTime()+aunuriLinkSubjectVO.getTestExecTime()) * weekLen;
				
				// 개설교과목 등록
				iResult += linkMapper.insertAunuriSubjectTerm(aunuriLinkSubjectVO);
			
					
				// 주차, 주차별 시간, 주차별 NCS  정보등록
				for( int x=0;  x < weekLen; x++ ){	// 현시점에서는 듀얼쪽은 15주차라 하드 코딩 (학습계획서에는 15주차 이상이라해도 실제로 15주차)
					AunuriLinkSubjectWeekVO weekVO = new AunuriLinkSubjectWeekVO();
					
					weekVO.setWeekId(subjWeekIdGnrService.getNextStringId());
					weekVO.setWeekCnt( String.valueOf( x+1 ) ); 
					weekVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
					weekVO.setTerm(aunuriLinkSubjectVO.getTerm());
					weekVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
					weekVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
					
					LOG.debug("*************************************** weekVO.getWeekCnt() :   "+weekVO.getWeekCnt());
					
					
					AunuriLinkSubjectWeekVO infoVO = aunuriLinkMapper.getAunuriWeekLessonInfo(weekVO);
					
					if(infoVO != null){
						weekVO.setLessonCn(infoVO.getLessonCn());
						weekVO.setLessonMthd(infoVO.getLessonMthd());
					}
					
					// 교과목 > 주차등록
					iResult += linkMapper.insertAunuriSubjectWeek(weekVO);
					
					
					// Off-JT 일 경우에만 주차 및 시간표등록
					if("OFF".equals(aunuriLinkSubjectVO.getSubjectTraningType())){
					
						AunuriLinkSubjectWeekVO weekTimeVO = aunuriLinkMapper.getAunuriWeekTime(weekVO);
						
						int addDateCnt = 7;
						//if("1".equals(weekVO.getWeekCnt())) addDateCnt = 0;
						
						//============ 요구사항 변경으로 인한 두번째주차 잘못들어감 확인필요
						
						// 교과목 주차 > 시간 등록
						if( weekTimeVO == null ) weekTimeVO = new AunuriLinkSubjectWeekVO();
							weekTimeVO.setYyyy(weekVO.getYyyy());
							weekTimeVO.setTerm(weekVO.getTerm());
							weekTimeVO.setSubjectCode(weekVO.getSubjectCode());
							weekTimeVO.setSubjectClass(weekVO.getSubjectClass());
							weekTimeVO.setWeekId(weekVO.getWeekId());
							weekTimeVO.setWeekCnt(weekVO.getWeekCnt());
							weekTimeVO.setTimeId(subjWeekTimeIdGnrService.getNextStringId());
							
							if("1".equals(weekVO.getWeekCnt())){
								weekTimeVO.setTraningDate(weekStartDate);
							} else {
								weekTimeVO.setTraningDate(CommonUtil.getLaterDay(weekStartDate,"yyyy.MM.dd", addDateCnt * (Integer.parseInt(weekVO.getWeekCnt())-1)));
							}
							LOG.debug("***************************************  weekTimeVO getTraningDate :   "+weekTimeVO.getTraningDate());
							weekTimeVO.setWeekLen(String.valueOf(weekLen));
							
							// 주차별 시간을 가져옴 계절학기 순수온라인 소수점건 때문에 수정
							LOG.debug("====================== weekTimeVO.getWeekLen()  : "+weekTimeVO.getWeekLen());
							LOG.debug("====================== weekTimeVO.getWeekCnt()  : "+weekTimeVO.getWeekCnt());
							
							if(weekTimeVO.getWeekLen().equals("4")){
								if(weekTimeVO.getWeekCnt().equals("4")){
									leadTime = linkMapper.getAunuriWeekOnlineFourTimeLeadTime(weekTimeVO);
								} else {
									leadTime = linkMapper.getAunuriWeekTimeLeadTime(weekTimeVO);
								}
							} else {
								 leadTime = linkMapper.getAunuriWeekTimeLeadTime(weekTimeVO);
							}
							
							LOG.debug("***************************************  weekTimeVO leadTime :   "+leadTime);
							LOG.debug("***************************************  weekTimeVO getTraningDate :   "+weekTimeVO.getTraningDate());
							
							weekTimeVO.setLeadTime(leadTime);
							iResult += linkMapper.insertAunuriWeekTime(weekTimeVO);
						
						
						// NCS 단위를 가져옴
						
						weekVO.setWeekCnt(String.valueOf( x+1 ) ); 
						weekVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
						weekVO.setTerm(aunuriLinkSubjectVO.getTerm());
						weekVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
						weekVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
						
						AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO = new AunuriLinkSubjectWeekNcsVO();
						aunuriLinkSubjectWeekNcsVO.setYyyy(weekVO.getYyyy());
						aunuriLinkSubjectWeekNcsVO.setTerm(weekVO.getTerm());
						aunuriLinkSubjectWeekNcsVO.setSubjectCode(weekVO.getSubjectCode());
						aunuriLinkSubjectWeekNcsVO.setSubjectClass(weekVO.getSubjectClass());
						aunuriLinkSubjectWeekNcsVO.setWeekCnt(weekVO.getWeekCnt());
						aunuriLinkSubjectWeekNcsVO.setWeekId(weekVO.getWeekId());
						
						AunuriLinkSubjectWeekNcsVO weekNcsVO = aunuriLinkMapper.getAunuriWeekNcsUnit(aunuriLinkSubjectWeekNcsVO);
						
						if(weekNcsVO != null){
							weekNcsVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
							
							LOG.debug("***************************************  weekNcsVO getYyyy :   "+weekNcsVO.getYyyy());
							LOG.debug("***************************************  weekNcsVO getTerm :   "+weekNcsVO.getTerm());
							LOG.debug("***************************************  weekNcsVO getSubjectCode :   "+weekNcsVO.getSubjectCode());
							LOG.debug("***************************************  weekNcsVO getSubjectClass :   "+weekNcsVO.getSubjectClass());
							LOG.debug("***************************************  weekNcsVO getWeekCnt :   "+weekNcsVO.getWeekCnt());
							LOG.debug("***************************************  weekNcsVO getNcsUnitId :   "+weekNcsVO.getNcsUnitId());
							LOG.debug("***************************************  weekNcsVO getNcsUnitName :   "+weekNcsVO.getNcsUnitName());
							
							// NCS 단위 등록
							iResult += linkMapper.insertAunuriWeekNcsUnit(weekNcsVO);
							
							// NCS 요소를 가져옴
							weekNcsVO.setWeekCnt(aunuriLinkSubjectWeekNcsVO.getWeekCnt());
							List<AunuriLinkSubjectWeekNcsVO> dataList = aunuriLinkMapper.listAunuriWeekNcsElem(weekNcsVO);
							
							for(int y=0; y < dataList.size(); y++){
								AunuriLinkSubjectWeekNcsVO elemVO = dataList.get(y);
								
								LOG.debug("############################### elemVO getYyyy :   "+weekNcsVO.getYyyy());
								LOG.debug("###############################  elemVO getTerm :   "+weekNcsVO.getTerm());
								LOG.debug("###############################  elemVO getSubjectCode :   "+weekNcsVO.getSubjectCode());
								LOG.debug("###############################  elemVO getSubjectClass :   "+weekNcsVO.getSubjectClass());
								LOG.debug("###############################  elemVO getWeekCnt :   "+weekNcsVO.getWeekCnt());
								LOG.debug("###############################  elemVO getNcsUnitId :   "+weekNcsVO.getNcsUnitId());
								LOG.debug("###############################  elemVO getNcsElemtId :   "+weekNcsVO.getNcsElemId());
								LOG.debug("###############################  elemVO getNcsElemName :   "+weekNcsVO.getNcsElemName());
								
								elemVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
								iResult += linkMapper.insertAunuriWeekNcsElem(elemVO);
							}
						}
					}
				}
				//======================= 주차별 훈련시간 등록
					
					
				
				// 수강생 회원가입 여무 확인 및 lesson 등록
				
				AunuriLinkLessonVO aunuriLinkLessonVO = new AunuriLinkLessonVO();
				aunuriLinkLessonVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
				aunuriLinkLessonVO.setTerm(aunuriLinkSubjectVO.getTerm());
				aunuriLinkLessonVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
				aunuriLinkLessonVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
				
				List<AunuriLinkLessonVO> lessonData = aunuriLinkMapper.listAunuriLessonTerm(aunuriLinkLessonVO);
				
				if( lessonData.size() > 0 ) {
					for( int ii =0; ii < lessonData.size(); ii++ ){
						aunuriLinkLessonVO =lessonData.get(ii);
						
						String memSeq = memberMapper.getMemberSeq(aunuriLinkLessonVO.getMemId());
						
						// 회원가입이 안된 수강생이라면 회원가입
						if(memSeq == null || "".equals(memSeq)){
							AunuriLinkMemberVO aunuriLinkMemberVO = new AunuriLinkMemberVO();
							aunuriLinkMemberVO.setMemId(aunuriLinkLessonVO.getMemId());
							// 아우누리에서 회원정보를 가져옴
							aunuriLinkMemberVO = aunuriLinkMapper.getAunuriMember(aunuriLinkMemberVO);
							aunuriLinkMemberVO.setLecTargetYear(aunuriLinkLessonVO.getYyyy());
							
							if( aunuriLinkMemberVO != null ){
								aunuriLinkMemberVO.setMemSeq(memberIdGnrService.getNextStringId());
								
								// 신,폅입구분 추가
								String stdTransferYn = "N";
								
								if(aunuriLinkMemberVO.getEntNm().equals("편입학")){
									stdTransferYn = "Y";
								}
								
								aunuriLinkMemberVO.setStdTransferYn(stdTransferYn);
								iResult += linkMapper.insertAunuriStdMember(aunuriLinkMemberVO);
								iResult += linkMapper.insertAunuriStdAuthMember(aunuriLinkMemberVO);
							}
						}
						
						memSeq = memberMapper.getMemberSeq(aunuriLinkLessonVO.getMemId());
						
						if(memSeq != null && !"".equals(memSeq)){
							aunuriLinkLessonVO.setMemSeq(memSeq);
							aunuriLinkLessonVO.setLecStatus("A");
							aunuriLinkLessonVO.setLessonId(lessonIdGnrService.getNextStringId());
							
							// 수강테이블 등록
							iResult += linkMapper.insertAunuriLesson(aunuriLinkLessonVO);
						}
						
					}
				}
				
				// 교수 회원가입 여부 확인 및 mapping 테이블에 등록
				AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO = new AunuriLinkMemberMappingVO();
				
				aunuriLinkMemberMappingVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
				aunuriLinkMemberMappingVO.setTerm(aunuriLinkSubjectVO.getTerm());
				aunuriLinkMemberMappingVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
				aunuriLinkMemberMappingVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
				
				List<AunuriLinkMemberMappingVO> insData = aunuriLinkMapper.listAunuriInsTerm(aunuriLinkMemberMappingVO);
				LOG.debug("###############################  insData.size() :   "+insData.size());
				
				if( insData.size() > 0 ) {
					for( int yy =0; yy < insData.size(); yy++ ){
						aunuriLinkMemberMappingVO = insData.get(yy);
						
						String memSeq = memberMapper.getMemberSeq(aunuriLinkMemberMappingVO.getMemId());
						
						// 회원가입이 안된 교수자라면 회원가입
						if(memSeq == null || "".equals(memSeq)){
							AunuriLinkMemberVO aunuriLinkMemberVO = new AunuriLinkMemberVO();
							aunuriLinkMemberVO.setMemId(aunuriLinkMemberMappingVO.getMemId());
							// 아우누리에서 회원정보를 가져옴
							aunuriLinkMemberVO = aunuriLinkMapper.getAunuriMember(aunuriLinkMemberVO);
							
							if(aunuriLinkMemberVO != null){
								aunuriLinkMemberVO.setMemSeq(memberIdGnrService.getNextStringId());
								iResult += linkMapper.insertAunuriMember(aunuriLinkMemberVO);
							}
						}
						
						memSeq = memberMapper.getMemberSeq(aunuriLinkMemberMappingVO.getMemId());
						
						if(memSeq != null && !"".equals(memSeq)){	
							LOG.debug("###############################  insData.memSeq() :   "+memSeq);
							aunuriLinkMemberMappingVO.setMemSeq(memSeq);
							aunuriLinkMemberMappingVO.setSubjInsMappingId(insMappingIdGnrService.getNextStringId());
							// 교수매핑테이블 등록
							iResult += linkMapper.insertAunuriIns(aunuriLinkMemberMappingVO);
						}
					}
				}
				
				// 학과전담자 매핑
				/*
				aunuriLinkMemberMappingVO = new AunuriLinkMemberMappingVO();
				
				aunuriLinkMemberMappingVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
				aunuriLinkMemberMappingVO.setTerm(aunuriLinkSubjectVO.getTerm());
				aunuriLinkMemberMappingVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
				aunuriLinkMemberMappingVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
				
				List<AunuriLinkMemberMappingVO> cdpData = linkMapper.listSubjectCdpTerm(aunuriLinkMemberMappingVO);
				
				if( data.size() > 0 ) {
					for( int z=0; z < cdpData.size(); z++ ){
						
						aunuriLinkMemberMappingVO = cdpData.get(z);
						aunuriLinkMemberMappingVO.setSubjCdpMappingId(cdpMappingIdGnrService.getNextStringId());
						
						iResult += linkMapper.insertAunuriCdp(aunuriLinkMemberMappingVO);
					}
				}
				*/
			}
		}
		
		
		return iResult;
	}
	
	public int excuteAunuriBatch() throws Exception {
		AunuriLinkMemberVO aVO = new AunuriLinkMemberVO();
	
		List<AunuriLinkMemberVO> outList = aunuriLinkMapper.listAunuriMemberOutYn(aVO);
		List<AunuriLinkMemberVO> passList = aunuriLinkMapper.listAunuriMemberPassYn(aVO);
		
		LOG.debug("############################################");
		LOG.debug("############################################");
		LOG.debug("# 			outList.size 	: "+outList.size()+"				#");
		LOG.debug("# 			passList.size : "+passList.size()+"				 #");
		LOG.debug("############################################");
		int outCnt = 0;
		int passCnt = 0;
		
		for(int i=0; i < outList.size(); i++){
			LOG.debug("# 			outList.get(i).getMemId() 	: "+outList.get(i).getMemId()+"				#");
			outCnt += linkMapper.updateAunuriMemberOutYn(outList.get(i).getMemId());
		}
		
		for(int i=0; i < passList.size(); i++){
			LOG.debug("# 			passList.size 	: "+passList.get(i).getMemId()+"				#");
			passCnt += linkMapper.updateAunuriMemberPassYn(passList.get(i).getMemId());
		}
		
		LOG.debug("# 			outCnt  : "+outCnt+"				#");
		LOG.debug("# 			passCnt : "+passCnt+"				 #");
		
		LOG.debug("############################################");
		LOG.debug("############################################");
		
		AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO = new AunuriLinkSubjectWeekVO();
		CommonCodeVO commonCodeVO =	commonCodeService.selectYearTerm();
		System.out.println("commonCodeVO.getYyyy() = " + StringUtils.defaultString(commonCodeVO.getYyyy(),""));	
		System.out.println("commonCodeVO.getTerm() = " + StringUtils.defaultString(commonCodeVO.getTerm(),""));
		aunuriLinkSubjectWeekVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));	
		aunuriLinkSubjectWeekVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		
		int iResult = 0;
		
		LOG.debug("############################################");
		List<AunuriLinkSubjectWeekVO> dataList = linkMapper.listSubjectWeek(aunuriLinkSubjectWeekVO);
		
		LOG.debug("week size : "+dataList.size());
		for(int i=0; i < dataList.size(); i++){
		
			aunuriLinkSubjectWeekVO = dataList.get(i);
			AunuriLinkSubjectWeekNcsVO aunuriLinkSubjectWeekNcsVO = new AunuriLinkSubjectWeekNcsVO();
			aunuriLinkSubjectWeekNcsVO.setYyyy(aunuriLinkSubjectWeekVO.getYyyy());
			aunuriLinkSubjectWeekNcsVO.setTerm(aunuriLinkSubjectWeekVO.getTerm());
			aunuriLinkSubjectWeekNcsVO.setSubjectCode(aunuriLinkSubjectWeekVO.getSubjectCode());
			aunuriLinkSubjectWeekNcsVO.setSubjectClass(aunuriLinkSubjectWeekVO.getSubjectClass());
			aunuriLinkSubjectWeekNcsVO.setWeekCnt(aunuriLinkSubjectWeekVO.getWeekCnt());
			aunuriLinkSubjectWeekNcsVO.setWeekId(aunuriLinkSubjectWeekVO.getWeekId());
			
			AunuriLinkSubjectWeekNcsVO weekNcsVO = aunuriLinkMapper.getAunuriWeekNcsUnit(aunuriLinkSubjectWeekNcsVO);
			
			
			// 2019학년도 / 1학기 / 소프트웨어공학특론 / 01분반 / 1~4주차는 NCS 변경안함
			if( !aunuriLinkSubjectWeekNcsVO.getWeekId().equals("2019WEEK0049664") 
					&& !aunuriLinkSubjectWeekNcsVO.getWeekId().equals("2019WEEK0049665")
					&& !aunuriLinkSubjectWeekNcsVO.getWeekId().equals("2019WEEK0049666")
					&& !aunuriLinkSubjectWeekNcsVO.getWeekId().equals("2019WEEK0049667") ) {
			
				// 능력단위가 있다면
				if(weekNcsVO != null){
					weekNcsVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
					
					int unitCount = linkMapper.getWeekNcsUnitCnt(weekNcsVO);
					
					// 등록 된 능력단위가 있다면 업데이트 아니면 등록
					if(unitCount > 0){
						// NCS 단위 업데이트
						iResult += linkMapper.updateWeekNcsUnit(weekNcsVO);
					} else {
						// NCS 단위 등록
						iResult += linkMapper.insertWeekNcsUnit(weekNcsVO);
					}
					
					// NCS 요소를 가져옴
					weekNcsVO.setWeekCnt(aunuriLinkSubjectWeekNcsVO.getWeekCnt());
					List<AunuriLinkSubjectWeekNcsVO> list = aunuriLinkMapper.listAunuriWeekNcsElem(weekNcsVO);
					
					if(list.size() > 0){
						iResult += linkMapper.delete_WeekNcsElem(weekNcsVO);
						for(int y=0; y < list.size(); y++){
							AunuriLinkSubjectWeekNcsVO elemVO = list.get(y);
							elemVO.setWeekId(aunuriLinkSubjectWeekNcsVO.getWeekId());
							/*
							int elemCount = linkMapper.getWeekNcsUnitCnt(weekNcsVO);
							if(elemCount > 0){
								iResult += linkMapper.updateWeekNcsElem(elemVO);
							} else {
								iResult += linkMapper.insertWeekNcsElem(elemVO);
							}*/
							iResult += linkMapper.insertWeekNcsElem(elemVO);
						}
					}
				} else {
					// 삭제
					iResult += linkMapper.deleteWeekNcsUnit(aunuriLinkSubjectWeekNcsVO);
					iResult += linkMapper.deleteWeekNcsElem(aunuriLinkSubjectWeekNcsVO);
				}
			}
		}
		
		//============== 수강생 배치 START  20180201 + 교수자 배치 추가 20170228
		
		AunuriLinkSubjectVO aunuriLinkSubjectVO = new AunuriLinkSubjectVO();
		aunuriLinkSubjectVO.setYyyy(StringUtils.defaultString(commonCodeVO.getYyyy(),""));	
		aunuriLinkSubjectVO.setTerm(StringUtils.defaultString(commonCodeVO.getTerm(),""));
		List<AunuriLinkSubjectVO> subjectList = linkMapper.listSubjectTerm(aunuriLinkSubjectVO);
		
		LOG.debug("subjectList size : "+subjectList.size());
		for(int i=0; i < subjectList.size(); i++){
		
			aunuriLinkSubjectVO = subjectList.get(i);
			AunuriLinkLessonVO aunuriLinkLessonVO = new AunuriLinkLessonVO();
			aunuriLinkLessonVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
			aunuriLinkLessonVO.setTerm(aunuriLinkSubjectVO.getTerm());
			aunuriLinkLessonVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
			aunuriLinkLessonVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
			
			List<AunuriLinkLessonVO> lessonData = aunuriLinkMapper.listAunuriLessonTerm(aunuriLinkLessonVO);
			
			if( lessonData.size() > 0 ) {
				for( int ii =0; ii < lessonData.size(); ii++ ){
					aunuriLinkLessonVO =lessonData.get(ii);
					
					String memSeq = memberMapper.getMemberSeq(aunuriLinkLessonVO.getMemId());
					
					// 회원가입이 안된 수강생이라면 회원가입
					if(memSeq == null || "".equals(memSeq)){
						AunuriLinkMemberVO aunuriLinkMemberVO = new AunuriLinkMemberVO();
						aunuriLinkMemberVO.setMemId(aunuriLinkLessonVO.getMemId());
						// 아우누리에서 회원정보를 가져옴
						aunuriLinkMemberVO = aunuriLinkMapper.getAunuriMember(aunuriLinkMemberVO);
						if( aunuriLinkMemberVO != null ){
							aunuriLinkMemberVO.setMemSeq(memberIdGnrService.getNextStringId());
							iResult += linkMapper.insertAunuriMember(aunuriLinkMemberVO);
						}
					}
					
					memSeq = memberMapper.getMemberSeq(aunuriLinkLessonVO.getMemId());
					
					if(memSeq != null && !"".equals(memSeq)){
						
						aunuriLinkLessonVO.setMemSeq(memSeq);
						// 등록 된 수강생인지 확인
						int lessonCnt = linkMapper.getAunuriLessonCnt(aunuriLinkLessonVO);
						
						if(lessonCnt == 0){ // 등록 된 수강생이 아닐 경우에만
							// 수강테이블 등록
							aunuriLinkLessonVO.setLecStatus("A");
							aunuriLinkLessonVO.setLessonId(lessonIdGnrService.getNextStringId());
							iResult += linkMapper.insertAunuriLesson(aunuriLinkLessonVO);
						}
					}
				}
			}
			// 교수자추가 
			// 교수 회원가입 여부 확인 및 mapping 테이블에 등록
			AunuriLinkMemberMappingVO aunuriLinkMemberMappingVO = new AunuriLinkMemberMappingVO();
			
			aunuriLinkMemberMappingVO.setYyyy(aunuriLinkSubjectVO.getYyyy());
			aunuriLinkMemberMappingVO.setTerm(aunuriLinkSubjectVO.getTerm());
			aunuriLinkMemberMappingVO.setSubjectCode(aunuriLinkSubjectVO.getSubjectCode());
			aunuriLinkMemberMappingVO.setSubjectClass(aunuriLinkSubjectVO.getSubjectClass());
			
			List<AunuriLinkMemberMappingVO> insData = aunuriLinkMapper.listAunuriInsTerm(aunuriLinkMemberMappingVO);
			LOG.debug("###############################  insData.size() :   "+insData.size());
			
			if( insData.size() > 0 ) {
				for( int yy =0; yy < insData.size(); yy++ ){
					aunuriLinkMemberMappingVO = insData.get(yy);
					
					String memSeq = memberMapper.getMemberSeq(aunuriLinkMemberMappingVO.getMemId());
					
					// 회원가입이 안된 교수자라면 회원가입
					if(memSeq == null || "".equals(memSeq)){
						AunuriLinkMemberVO aunuriLinkMemberVO = new AunuriLinkMemberVO();
						aunuriLinkMemberVO.setMemId(aunuriLinkMemberMappingVO.getMemId());
						// 아우누리에서 회원정보를 가져옴
						aunuriLinkMemberVO = aunuriLinkMapper.getAunuriMember(aunuriLinkMemberVO);
						
						if(aunuriLinkMemberVO != null){
							aunuriLinkMemberVO.setMemSeq(memberIdGnrService.getNextStringId());
							iResult += linkMapper.insertAunuriMember(aunuriLinkMemberVO);
						}
					}
					
					memSeq = memberMapper.getMemberSeq(aunuriLinkMemberMappingVO.getMemId());
					
					if(memSeq != null && !"".equals(memSeq)){	
						LOG.debug("###############################  insData.memSeq() :   "+memSeq);
						aunuriLinkMemberMappingVO.setMemSeq(memSeq);
						// 등록 된 교수인지 확인
						int insCnt = linkMapper.getAunuriInsCnt(aunuriLinkMemberMappingVO);
						
						if(insCnt == 0){ // 등록 된 교수가 아닐 경우에만
							aunuriLinkMemberMappingVO.setSubjInsMappingId(insMappingIdGnrService.getNextStringId());
							// 교수매핑테이블 등록
							iResult += linkMapper.insertAunuriIns(aunuriLinkMemberMappingVO);
						}
					}
				}
			}
			
		}
		//============== 수강생 배치 END  20180201
		
		return (outCnt+passCnt+iResult);
	}
	
	
	public int updateAunuriWeekNcs(AunuriLinkSubjectWeekVO aunuriLinkSubjectWeekVO) throws Exception {
		int iResult = 0;
		
		
		
		return iResult;
	}
	
	public int excuteStdBatch() throws Exception {
		int iResult = linkMapper.excuteStdBatch();
		return iResult;
	}
	
	public int excuteAttendBatch() throws Exception {
		int iResult = 0;
		iResult += linkMapper.deleteAttend();
		iResult += linkMapper.insertAttend();
		return iResult;
	}
	
	
}
