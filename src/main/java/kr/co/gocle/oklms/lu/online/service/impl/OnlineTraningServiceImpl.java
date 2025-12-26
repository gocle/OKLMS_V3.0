
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
package kr.co.gocle.oklms.lu.online.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.gocle.ifx.service.CmsIfxService;
import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.lu.online.service.OnlineTraningService;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchElemVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekFileVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningWeekVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

 /**
 * 프로토타입 게시판 CRUD 비지니스 로직을 구현하는 클레스.
 * @author 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("OnlineTraningService")
public class OnlineTraningServiceImpl extends EgovAbstractServiceImpl implements OnlineTraningService{
	
	private static final Logger LOG = LoggerFactory.getLogger(OnlineTraningServiceImpl.class);
	
	/** ID Generation */
    @Resource(name="subjWeekSchIdGnrService")
    private EgovIdGnrService subjWeekSchIdGnrService;
    
    /** ID Generation */
    @Resource(name="subjWeekSchElemIdGnrService")
    private EgovIdGnrService subjWeekSchElemIdGnrService;
    
    @Resource(name = "onlineTraningMapper")
    private OnlineTraningMapper onlineTraningMapper;
    
    @Resource(name = "atchFileService")
	private AtchFileService atchFileService;
    
    @Resource(name = "cmsIfxService")
	private CmsIfxService cmsIfxService;
    
    @Override
	public List<OnlineTraningSchVO> listOnlineTraningSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningSchedule(onlineTraningSchVO);
		return data;
	}
    
    @Override
   	public List<OnlineTraningSchVO> listOnlineTraningSubject(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
   		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningSubject(onlineTraningSchVO);
   		return data;
   	}
    
    
    @Override
   	public List<OnlineTraningSchVO> listOnlineTraningCdpSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
   		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningCdpSchedule(onlineTraningSchVO);
   		return data;
   	}
    
    @Override
   	public List<OnlineTraningSchVO> listOfflineTraningCdpSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
   		List<OnlineTraningSchVO> data = onlineTraningMapper.listOfflineTraningCdpSchedule(onlineTraningSchVO);
   		return data;
   	}
    
    
    
    @Override
	public List<OnlineTraningSchVO> listOnlineTraningAllWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningAllWeekSchedule(onlineTraningSchVO);
		
		List<OnlineTraningSchVO> list = new ArrayList<OnlineTraningSchVO>();
		
		List<OnlineTraningSchElemVO> elemList = null;
		
		for(int i=0; i < data.size(); i++){
			OnlineTraningSchVO schVO = data.get(i);
			
			// CMS 연계 차시라면 JSON 데이터 생성
			if("Y".equals(schVO.getLinkContentYn())){
				
				elemList = onlineTraningMapper.listOnlineTraningWeekScheduleElem(schVO);
				
				
				//OnlineTraningSchElemVO onlineTraningSchElemVO = null;
				JsonArray jsonArray = new JsonArray(); 
				for(int x=0; x < elemList.size(); x++){
					//onlineTraningSchElemVO = new OnlineTraningSchElemVO();
					OnlineTraningSchElemVO elemVO  = elemList.get(x);
					JsonObject jsonObject = new JsonObject(); 
					
					jsonObject.addProperty("lesson_id", elemVO.getLessonId());
					jsonObject.addProperty("lesson_item_id", elemVO.getLessonItemId());
					jsonObject.addProperty("lesson_sub_item_id", elemVO.getLessonSubItemId());
					jsonObject.addProperty("required_learning_time_in_seconds", elemVO.getRequiredLearningTimeInSeconds());
					
					jsonArray.add(jsonObject);
					
				}
				
				Gson gson = new Gson();
				String jsonLessonDate = gson.toJson(jsonArray);
				schVO.setJsonLessonData(jsonLessonDate);
				
				LOG.debug("============== schVO.getJsonLessonData : "+schVO.getJsonLessonData());
				
			} else {
				schVO.setJsonLessonData("");
			}
			
			list.add(schVO);
		}
		
		return list;
	}
    
    @Override
	public List<OnlineTraningSchVO> listOnlineTraningStdOnlineSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningStdOnlineSchedule(onlineTraningSchVO);
		return data;
	}
    
    
    @Override
	public int insertOnlineTraningStand(OnlineTraningVO onlineTraningVO) throws Exception {
		int sqlResultInt = onlineTraningMapper.insertOnlineTraningStand(onlineTraningVO); 
		return sqlResultInt;
	}
    
    
    @Override
	public OnlineTraningVO getOnlineTraningStand(OnlineTraningVO onlineTraningVO) throws Exception {
    	OnlineTraningVO data = onlineTraningMapper.getOnlineTraningStand(onlineTraningVO); 
		return data;
	}
    
    @Override
	public int updateOnlineTraningStand(OnlineTraningVO onlineTraningVO) throws Exception {
		int sqlResultInt = onlineTraningMapper.updateOnlineTraningStand(onlineTraningVO); 
		return sqlResultInt;
	}
    
    @Override
   	public int insertOnlineWeekSchedule(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception {
   		int weekResult = 0;
   		int weekSchResult = 0;
   		int weekSchNum = 0;
   		int weekSchElemResult = 0;
    	if( onlineTraningWeekVO.getWeekIds() != null && onlineTraningWeekVO.getWeekIds().length > 0 ){
    		String [] delim = onlineTraningWeekVO.getWeekSchDelim().split("\\|");
    		
    		
    		//LOG.debug("======================= onlineTraningWeekVO.getWeekSchDelim() : "+onlineTraningWeekVO.getWeekSchDelim());
    		
    		OnlineTraningWeekVO onWeekVO;
    		
    		for(int i=0; i < onlineTraningWeekVO.getWeekIds().length; i++){
    			onWeekVO = new OnlineTraningWeekVO();
    			
    			onWeekVO.setWeekId(onlineTraningWeekVO.getWeekIds()[i]);
    			onWeekVO.setWeekCnt(onlineTraningWeekVO.getWeekCnts()[i]);
    			onWeekVO.setContentName(onlineTraningWeekVO.getContentNames()[i]);
    			onWeekVO.setWeekStDate(onlineTraningWeekVO.getWeekStDates()[i]);
    			onWeekVO.setWeekEdDate(onlineTraningWeekVO.getWeekEdDates()[i]);
    			onWeekVO.setWeekMin(onlineTraningWeekVO.getWeekMins()[i]);
    			
    			// 등록시 기존 주차별 콘텐츠 명 및 차시정보, 차시별 오소정보 삭제
    			weekResult += onlineTraningMapper.deleteOnlineTraningWeekContent(onWeekVO.getWeekId());
    			weekResult += onlineTraningMapper.deleteOnlineTraningWeekSchedule(onWeekVO.getWeekId());
    			weekResult += onlineTraningMapper.deleteOnlineTraningWeekScheduleElem(onWeekVO.getWeekId());
    			
    			//LOG.debug("======================= onWeekVO.getWeekStDate : "+onWeekVO.getWeekStDate());
    			//LOG.debug("======================= onWeekVO.getWeekEdDate : "+onWeekVO.getWeekStDate());
    					
    					
    			weekResult += onlineTraningMapper.insertOnlineTraningWeekContent(onWeekVO);
    			//System.out.println("==================== weekResult : "+weekResult);
    			//LOG.debug("======================= delim[i] : "+delim[i]);
    			//LOG.debug("======================= onWeekVO.getWeekCnt : "+onWeekVO.getWeekCnt());
    			int unit = Integer.parseInt(delim[i]);
    			
    			//LOG.debug("======================= unit : "+unit);
    			
    			OnlineTraningSchVO onSchVO;
    			for(int x=0; x < unit; x++){
    				
    				onSchVO = new OnlineTraningSchVO();
    				String pkSubjSchId = subjWeekSchIdGnrService.getNextStringId();
    				
    				//LOG.debug("======================= pkSubjSchId : "+pkSubjSchId);
    				
    				onSchVO.setYyyy(onlineTraningWeekVO.getYyyy());
    				onSchVO.setTerm(onlineTraningWeekVO.getTerm());
        			onSchVO.setSubjectClass(onlineTraningWeekVO.getSubjectClass());
        			onSchVO.setSubjectCode(onlineTraningWeekVO.getSubjectCode());
    				
    				
    				onSchVO.setSubjSchId(pkSubjSchId);
    				onSchVO.setWeekId(onWeekVO.getWeekId());
    				onSchVO.setWeekCnt(onWeekVO.getWeekCnt());
    				onSchVO.setSubjStep(String.valueOf(x+1));
    				
    				onSchVO.setStartDate(onlineTraningWeekVO.getWeekSchStDates()[weekSchNum]);
    				onSchVO.setEndDate(onlineTraningWeekVO.getWeekSchEdDates()[weekSchNum]);
    				onSchVO.setStudyTime(onlineTraningWeekVO.getWeekSchMins()[weekSchNum]);
    				
    				String linkContentTypes = onlineTraningWeekVO.getLinkContentTypes()[weekSchNum];
    				
    				
    				
    				if(linkContentTypes.equals("CMS")){
    					onSchVO.setLinkContentYn("Y");
    					// CMS 에서 끌어온 콘텐츠라면 요소들을 DB에 등록
    					String jsonLessonData = onlineTraningWeekVO.getJsonLessonDatas()[weekSchNum];
    					Gson gson = new Gson();
    					
    					LOG.debug("======================= pre jsonLessonData : "+jsonLessonData.toString());
    					
    					jsonLessonData = jsonLessonData.replaceAll("&quot;", "\\\"");
    					
    					LOG.debug("======================= next jsonLessonData : "+jsonLessonData.toString());
    					
    					
    					JsonArray jsonArray = new JsonParser().parse(jsonLessonData).getAsJsonArray();
    					
    					//LOG.debug("======================= elem jsonArray.size() : "+jsonArray.size());

    					for (int y = 0; y < jsonArray.size(); y++) {
					        JsonElement str = jsonArray.get(y);
					        OnlineTraningSchElemVO elemVO = gson.fromJson(str, OnlineTraningSchElemVO.class);
					        elemVO.setElemId(subjWeekSchElemIdGnrService.getNextStringId());
					        elemVO.setWeekId(onWeekVO.getWeekId());
					        elemVO.setWeekCnt(onWeekVO.getWeekCnt());
					        elemVO.setSubjSchId(onSchVO.getSubjSchId());
					        elemVO.setSubjStep(onSchVO.getSubjStep());
					        
					        CmsCourseBaseVO cmsBaseVO = new CmsCourseBaseVO();
					        cmsBaseVO.setAddURL("viewLesson");  
					        cmsBaseVO.setLessonId(elemVO.getLesson_id());
					        cmsBaseVO.setLessonItemId(elemVO.getLesson_item_id());
					        cmsBaseVO.setLessonSubItemId(elemVO.getLesson_sub_item_id());
					        
					        LOG.debug("======================= elemVO.getLesson_id : "+elemVO.getLesson_id());
					    	LOG.debug("======================= elemVO.getLesson_item_id : "+elemVO.getLesson_item_id());
					    	LOG.debug("======================= elemVO.getLessonSubItemId : "+elemVO.getLesson_sub_item_id());
					        
					    	HashMap<String, String> data = cmsIfxService.viewLesson(cmsBaseVO);
					        
					        elemVO.setContentUrl(data.get("contentUrl").toString());
					        elemVO.setWidth(data.get("width").toString());
					        elemVO.setHeight(data.get("height").toString());
					        elemVO.setTitle(data.get("title").toString());
					        elemVO.setRequired_learning_time_in_seconds(data.get("required_learning_time_in_seconds").toString());
					        elemVO.setDisplayOrder(data.get("display_order").toString());
					        
					        weekSchElemResult += onlineTraningMapper.insertOnlineTraningWeekScheduleElem(elemVO);
					    }	
					    onSchVO.setPageCount(jsonArray == null ? 0 : jsonArray.size());
    				} else {
    					onSchVO.setLinkContentYn("N");
    					onSchVO.setPageCount(1);
    				}
    				
    				onSchVO.setSubjTitle(onlineTraningWeekVO.getSubjTitles()[weekSchNum]);
					onSchVO.setCmsCourseContentId(onlineTraningWeekVO.getCmsCourseContentIds()[weekSchNum]);
    				onSchVO.setCmsLessonId(onlineTraningWeekVO.getCmsLessonIds()[weekSchNum]);
    				onSchVO.setCmsId(onlineTraningWeekVO.getCmsIds()[weekSchNum]);
    				onSchVO.setDeviceTypeCode(onlineTraningWeekVO.getDeviceTypeCodes()[weekSchNum]);
    				onSchVO.setContentType(onlineTraningWeekVO.getContentTypes()[weekSchNum]);
    				onSchVO.setContentsDir(onlineTraningWeekVO.getContentsDirs()[weekSchNum]);
    				onSchVO.setContentsIdxFile(onlineTraningWeekVO.getContentsIdxFiles()[weekSchNum]);
    				onSchVO.setContentsRealFile(onlineTraningWeekVO.getContentsRealFiles()[weekSchNum]);
    				onSchVO.setUrl(onlineTraningWeekVO.getUrls()[weekSchNum]);
    				
    				
    				//LOG.debug("======================= onSchVO.getSubjTitle() : "+onSchVO.getSubjTitle());
    				//LOG.debug("======================= onSchVO.getCmsCourseContentId() : "+onSchVO.getCmsCourseContentId());
    				//LOG.debug("======================= onSchVO.getCmsId() : "+onSchVO.getCmsId());
    				//LOG.debug("======================= onSchVO.getDeviceTypeCode() : "+onSchVO.getDeviceTypeCode());
    				//LOG.debug("======================= onSchVO.getContentType() : "+onSchVO.getContentType());
    				//LOG.debug("======================= onSchVO.getContentsDir() : "+onSchVO.getContentsDir());
    				//LOG.debug("======================= onSchVO.getContentsIdxFile() : "+onSchVO.getContentsIdxFile());
    				//LOG.debug("======================= onSchVO.getContentsRealFile() : "+onSchVO.getContentsRealFile());
    				//LOG.debug("======================= onSchVO.getUrl() : "+onSchVO.getUrl());
    				
    				
    				
    				weekSchResult += onlineTraningMapper.insertOnlineTraningWeekSchedule(onSchVO);
    				//System.out.println("==================== weekSchResult : "+weekSchResult);
    				
    				weekSchNum++;
    			}
    			
        	}
    	}
    	
   		return (weekResult+weekSchResult+weekSchElemResult);
   	}
    
    @Override
   	public int updateOnlineWeekSchedule(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception {
   		int weekResult = 0;
   		int weekSchResult = 0;
   		int weekSchNum = 0;
   		int weekSchElemResult = 0;
    	if( onlineTraningWeekVO.getWeekIds() != null && onlineTraningWeekVO.getWeekIds().length > 0 ){
    		String [] delim = onlineTraningWeekVO.getWeekSchDelim().split("\\|");
    		
    		
    		//LOG.debug("======================= onlineTraningWeekVO.getWeekSchDelim() : "+onlineTraningWeekVO.getWeekSchDelim());
    		
    		OnlineTraningWeekVO onWeekVO;
    		
    		for(int i=0; i < onlineTraningWeekVO.getWeekIds().length; i++){
    			onWeekVO = new OnlineTraningWeekVO();
    			
    			onWeekVO.setWeekId(onlineTraningWeekVO.getWeekIds()[i]);
    			onWeekVO.setWeekCnt(onlineTraningWeekVO.getWeekCnts()[i]);
    			onWeekVO.setContentName(onlineTraningWeekVO.getContentNames()[i]);
    			onWeekVO.setWeekStDate(onlineTraningWeekVO.getWeekStDates()[i]);
    			onWeekVO.setWeekEdDate(onlineTraningWeekVO.getWeekEdDates()[i]);
    			onWeekVO.setWeekMin(onlineTraningWeekVO.getWeekMins()[i]);
    			
    			weekResult += onlineTraningMapper.updateOnlineTraningWeekContent(onWeekVO);
    			
    			//System.out.println("==================== weekResult : "+weekResult);
    			//LOG.debug("======================= delim[i] : "+delim[i]);
    			//LOG.debug("======================= onWeekVO.getWeekId : "+onWeekVO.getWeekId());
    			//LOG.debug("======================= onWeekVO.getWeekCnt : "+onWeekVO.getWeekCnt());
    			//LOG.debug("======================= onWeekVO.getContentName : "+onWeekVO.getContentName());
    			//LOG.debug("======================= onWeekVO.getWeekStDate : "+onWeekVO.getWeekStDate());
    			//LOG.debug("======================= onWeekVO.getWeekEdDate : "+onWeekVO.getWeekEdDate());
    			//LOG.debug("======================= onWeekVO.getWeekMin : "+onWeekVO.getWeekMin());
    			
    			int unit = Integer.parseInt(delim[i]);
    			
    			//LOG.debug("======================= unit : "+unit);
    			
    			OnlineTraningSchVO onSchVO;
    			for(int x=0; x < unit; x++){
    				
    				onSchVO = new OnlineTraningSchVO();
    				
    				onSchVO.setWeekId(onWeekVO.getWeekId());
    				onSchVO.setWeekCnt(onWeekVO.getWeekCnt());
        			onSchVO.setSubjSchId(onlineTraningWeekVO.getSubjSchIds()[weekSchNum]);
    				onSchVO.setSubjTitle(onlineTraningWeekVO.getSubjTitles()[weekSchNum]);
    				onSchVO.setStartDate(onlineTraningWeekVO.getWeekSchStDates()[weekSchNum]);
    				onSchVO.setEndDate(onlineTraningWeekVO.getWeekSchEdDates()[weekSchNum]);
    				onSchVO.setStudyTime(onlineTraningWeekVO.getWeekSchMins()[weekSchNum]);
    				
        			//LOG.debug("======================= onSchVO.getWeekId : "+onSchVO.getSubjSchId());
        			//LOG.debug("======================= onSchVO.getWeekCnt : "+onSchVO.getWeekId());
        			//LOG.debug("======================= onSchVO.getContentName : "+onSchVO.getStartDate());
        			//LOG.debug("======================= onSchVO.getWeekStDate : "+onSchVO.getEndDate());
        			//LOG.debug("======================= onSchVO.getWeekEdDate : "+onSchVO.getStudyTime());
    				
    				
    				weekSchResult += onlineTraningMapper.updateOnlineTraningWeekSchedule(onSchVO);
    				//System.out.println("==================== weekSchResult : "+weekSchResult);
    				
    				weekSchNum++;
    			}
    			
        	}
    	}
    	
   		return (weekResult+weekSchResult+weekSchElemResult);
   	}
    
    
    
    
    
    @Override
	public List<OnlineTraningSchVO> listOnlineTraningStdSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningStdSchedule(onlineTraningSchVO);
		return data;
	}
    
    @Override
	public OnlineTraningSchVO getOnlineWeekLessonSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		OnlineTraningSchVO data = onlineTraningMapper.getOnlineWeekLessonSchedule(onlineTraningSchVO);
		return data;
	}
    
    @Override
	public OnlineTraningSchVO getOnlineWeekLessonSchedulePreview(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		OnlineTraningSchVO data = onlineTraningMapper.getOnlineWeekLessonSchedulePreview(onlineTraningSchVO);
		return data;
	}
    
    @Override
	public OnlineTraningSchVO getAllProgressRateLesson(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
    	OnlineTraningSchVO data = onlineTraningMapper.getAllProgressRateLesson(onlineTraningSchVO);
		return data;
	}
    
    @Override
	public List<OnlineTraningSchVO> listOjtTraningStdSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOjtTraningStdSchedule(onlineTraningSchVO);
		return data;
	}
    @Override
   	public OnlineTraningSchVO getTraningStatus(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
       	OnlineTraningSchVO data = onlineTraningMapper.getTraningStatus(onlineTraningSchVO);
   		return data;
   	}
    
    @Override
	public List<OnlineTraningSchVO> listOnlineTraningInsSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningInsSchedule(onlineTraningSchVO);
		return data;
	}
    
    @Override
   	public List<OnlineTraningSchVO> listOjtTraningInsSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
   		List<OnlineTraningSchVO> data = onlineTraningMapper.listOjtTraningInsSchedule(onlineTraningSchVO);
   		return data;
   	}
    
    @Override
   	public List<OnlineTraningSchVO> listOjtTraningCotSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
   		List<OnlineTraningSchVO> data = onlineTraningMapper.listOjtTraningCotSchedule(onlineTraningSchVO);
   		return data;
   	}
    
    
    @Override
	public List<OnlineTraningSchVO> listOnlineTraningWeekSchedule(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningWeekSchedule(onlineTraningSchVO);
		return data;
	}
    
    @Override
	public List<OnlineTraningSchVO> listOnlineTraningWeekSch(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		List<OnlineTraningSchVO> data = onlineTraningMapper.listOnlineTraningWeekSch(onlineTraningSchVO);
		return data;
	}
    
    @Override
   	public List<OnlineTraningSchElemVO> listOnlineTraningWeekSchElem(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception {
   		List<OnlineTraningSchElemVO> data = onlineTraningMapper.listOnlineTraningWeekSchElem(onlineTraningSchElemVO);
   		return data;
   	}
    
    
    @Override
	public List<OnlineTraningSchElemVO> listOnlineTraningWeekScheduleElemLesson(OnlineTraningSchElemVO onlineTraningSchElemVO) throws Exception {
		List<OnlineTraningSchElemVO> data = onlineTraningMapper.listOnlineTraningWeekScheduleElemLesson(onlineTraningSchElemVO);
		return data;
	}
    
    @Override
	public String getOnlineTraningWeekProgressYn(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		String data = onlineTraningMapper.getOnlineTraningWeekProgressYn(onlineTraningSchVO);
		return data;
	}
    
    @Override
	public String getOnlineTraningWeekScheduleProgressYn(OnlineTraningSchVO onlineTraningSchVO) throws Exception {
		String data = onlineTraningMapper.getOnlineTraningWeekScheduleProgressYn(onlineTraningSchVO);
		return data;
	}
    
    @Override
   	public int insertOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception {
   		int sqlResultInt = onlineTraningMapper.insertOnlineTraningWeekFile(onlineTraningWeekFileVO); 
   		return sqlResultInt;
   	}
       
    @Override
   	public int deleteOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception {
   		int sqlResultInt = onlineTraningMapper.deleteOnlineTraningWeekFile(onlineTraningWeekFileVO); 
   		return sqlResultInt;
   	}
    
    @Override
   	public String getOnlineTraningWeekFileSeq(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception {
    	String data = onlineTraningMapper.getOnlineTraningWeekFileSeq(onlineTraningWeekFileVO); 
   		return data;
   	}
    
    @Override
	public List<OnlineTraningWeekFileVO> listOnlineTraningWeekFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception {
		List<OnlineTraningWeekFileVO> data = onlineTraningMapper.listOnlineTraningWeekFile(onlineTraningWeekFileVO);
		return data;
	}
    
    @Override
	public List<OnlineTraningWeekFileVO> listOnlineTraningFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO) throws Exception {
		List<OnlineTraningWeekFileVO> data = onlineTraningMapper.listOnlineTraningFile(onlineTraningWeekFileVO);
		return data;
	}
    
    
    @Override
	public int insertOnlineTraningFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO,final MultipartHttpServletRequest multiRequest)	throws Exception {
		//첨부파일 저장	 		
		final List< org.springframework.web.multipart.MultipartFile > fileObj = multiRequest.getFiles("atchFiles");
		String storePathString ="Globals.fileStorePath";
		String atchFileId = atchFileService.saveAtchFile( fileObj, "WEEK", "", storePathString ,"onilneData");
		System.out.println("======================= atchFileId : "+atchFileId);
		onlineTraningWeekFileVO.setAtchFileId(atchFileId);
		int iResilt = onlineTraningMapper.insertOnlineTraningFile(onlineTraningWeekFileVO);
		
		return iResilt;
    }
    
    @Override
	public int updateOnlineTraningFile(OnlineTraningWeekFileVO onlineTraningWeekFileVO,final MultipartHttpServletRequest multiRequest)	throws Exception {
		int iResilt = onlineTraningMapper.updateOnlineTraningFile(onlineTraningWeekFileVO);
		return iResilt;
    }
    
    @Override
	public int saveTermOnStand(OnlineTraningVO onlineTraningVO)	throws Exception {
    	int iResilt = 0;
    	iResilt += onlineTraningMapper.deleteTermOnStand(onlineTraningVO);
    	iResilt += onlineTraningMapper.insertTermOnStand(onlineTraningVO);
		return iResilt;
    }
    
    @Override
	public OnlineTraningVO getTermOnStand(OnlineTraningVO onlineTraningVO)	throws Exception {
    	OnlineTraningVO data = onlineTraningMapper.getTermOnStand(onlineTraningVO);
		return data;
    }
    
    @Override
	public int saveTermOnWeek(OnlineTraningWeekVO onlineTraningWeekVO)	throws Exception {
    	int iResilt = 0;
    	
    	
    	if( onlineTraningWeekVO.getWeekCnts() != null && onlineTraningWeekVO.getWeekCnts().length > 0 ){
    		
    		iResilt += onlineTraningMapper.deleteTermOnWeek(onlineTraningWeekVO);
    		
    		OnlineTraningWeekVO onWeekVO;
    		
    		for(int i=0; i < onlineTraningWeekVO.getWeekCnts().length; i++){
    			onWeekVO = new OnlineTraningWeekVO();
    			
    			onWeekVO.setYyyy(onlineTraningWeekVO.getYyyy());
    			onWeekVO.setTerm(onlineTraningWeekVO.getTerm());
    			onWeekVO.setOnlineType(onlineTraningWeekVO.getOnlineType());
    		
    			onWeekVO.setWeekCnt(onlineTraningWeekVO.getWeekCnts()[i]);
    			onWeekVO.setWeekStDate(onlineTraningWeekVO.getWeekStDates()[i]);
    			onWeekVO.setWeekEdDate(onlineTraningWeekVO.getWeekEdDates()[i]);
    			
    			iResilt += onlineTraningMapper.insertTermOnWeek(onWeekVO);
    			
    		}
    	}
    	
		return iResilt;
    }
    
    @Override
   	public List<OnlineTraningWeekVO> listTermOnWeek(OnlineTraningWeekVO onlineTraningWeekVO) throws Exception {
   		List<OnlineTraningWeekVO> data = onlineTraningMapper.listTermOnWeek(onlineTraningWeekVO);
   		return data;
   	}
    
    
    @Override
   	public int  mergeContent() throws Exception {
   		int iResult = 0;
    	List<OnlineTraningSchElemVO> list = onlineTraningMapper.listContentUrl();
    	
    	LOG.debug("======================= list.size : "+list.size());
    	
    	for(int i=0; i < list.size(); i++){
    		
    		OnlineTraningSchElemVO elemVO = list.get(i);
    		
    		
    		CmsCourseBaseVO cmsBaseVO = new CmsCourseBaseVO();
	        cmsBaseVO.setAddURL("viewLesson");  
	        cmsBaseVO.setLessonId(elemVO.getLessonId());
	        cmsBaseVO.setLessonItemId(elemVO.getLessonItemId());
	        cmsBaseVO.setLessonSubItemId(elemVO.getLessonSubItemId());
	        
	        LOG.debug("======================= i : "+i);
	        LOG.debug("======================= elemVO.getLesson_id : "+elemVO.getLessonId());
	    	LOG.debug("======================= elemVO.getLesson_item_id : "+elemVO.getLessonItemId());
	    	LOG.debug("======================= elemVO.getLessonSubItemId : "+elemVO.getLessonSubItemId());
	        
	    	HashMap<String, String> data = cmsIfxService.viewLesson(cmsBaseVO);
	        
	        elemVO.setContentUrl(data.get("contentUrl").toString());
	        elemVO.setWidth(data.get("width").toString());
	        elemVO.setHeight(data.get("height").toString());
	        elemVO.setTitle(data.get("title").toString());
	        elemVO.setRequired_learning_time_in_seconds(data.get("required_learning_time_in_seconds").toString());
	        elemVO.setDisplayOrder(data.get("display_order").toString());
	        
	        
	        
	        onlineTraningMapper.updateContentUrl(elemVO) ;
	        
    	}
    	
   		return iResult;
   	}
    

}
