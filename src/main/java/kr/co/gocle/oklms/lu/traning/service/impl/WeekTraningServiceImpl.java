package kr.co.gocle.oklms.lu.traning.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.lu.traning.service.WeekTraningService;
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

@Transactional(rollbackFor=Exception.class)
@Service("weekTraningService")
public class WeekTraningServiceImpl extends EgovAbstractServiceImpl implements WeekTraningService {

    @Resource(name = "weekTraningMapper")
	private WeekTraningMapper weekTraningMapper;
    
    @Resource(name = "atchFileService")
	private AtchFileService atchFileService;
    
    
	@Override
	public List<TraningNoteVO> listWeekTraningNoteCot(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> resultList = weekTraningMapper.listWeekTraningNoteCot(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> listWeekTraningNoteBottomCot(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.listWeekTraningNoteBottomCot(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> getWeekTraningNoteCot(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.getWeekTraningNoteCot(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> getWeekTraningNoteSingCot(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.getWeekTraningNoteSingCot(traningNoteVO);
		return resultList;
	}
	
	
	@Override
	public List<TraningNoteVO> getWeekTraningNoteAddCot(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.getWeekTraningNoteAddCot(traningNoteVO);
		return resultList;
	}
	@Override
	public int updateWeekTraningNoteCot(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.updateWeekTraningNoteCot(traningNoteVO);
	}

	@Override
	public List<TraningNoteVO> listWeekTraningNotePrd(TraningNoteVO traningNoteVO) throws Exception {
		List<TraningNoteVO> resultList = weekTraningMapper.listWeekTraningNotePrd(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> listWeekTraningNoteBottomPrd(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.listWeekTraningNoteBottomPrd(traningNoteVO);
		return resultList;
	}
	@Override
	public int updateWeekTraningNotePrd(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.updateWeekTraningNotePrd(traningNoteVO);
	}
	@Override
	public List<TraningNoteVO> listWeekTraningNoteBottomCcn(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.listWeekTraningNoteBottomCcn(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> getWeekTraningNoteCcn(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.getWeekTraningNoteCcn(traningNoteVO);
		return resultList;
	}
	@Override
	public int updateWeekTraningNoteCcn(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.updateWeekTraningNoteCcn(traningNoteVO);
	}
	
	@Override
	public int updateWeekTraningNoteCcnFile(TraningNoteVO traningNoteVO,final MultipartHttpServletRequest multiRequest)	throws Exception {
		// TODO Auto-generated method stub
		
		//첨부파일 저장	 		
		final List< MultipartFile > fileObj = multiRequest.getFiles("atchFiles");
		String storePathString ="Globals.fileStorePath";
		String atchFileId = atchFileService.saveAtchFile( fileObj, "WEF", "", storePathString ,"weektraning");
		System.out.println("======================= atchFileId : "+atchFileId);
		traningNoteVO.setAtchFileId(atchFileId);
		int iResilt = weekTraningMapper.updateWeekTraningNoteCcnFile(traningNoteVO);
		
		return iResilt;
	}
	
	
	
	@Override
	public List<TraningNoteVO> getWeekTraningNoteAddCcn(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.getWeekTraningNoteAddCcn(traningNoteVO);
		return resultList;
	}
 
	@Override
	public List<TraningNoteVO> getWeekTraningNotePrd(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.getWeekTraningNotePrd(traningNoteVO);
		return resultList;
	}
 
	@Override
	public List<TraningNoteVO> getWeekTraningNoteAddPrd(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.getWeekTraningNoteAddPrd(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> detailTraningNotePrd(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.detailTraningNotePrd(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> detailTraningNoteCot(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		List<TraningNoteVO> resultList = weekTraningMapper.detailTraningNoteCot(traningNoteVO);
		return resultList;
	}
	@Override
	public List<TraningNoteVO> selectDayTraningNoteAll(	TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.selectDayTraningNoteAll(traningNoteVO);
	}
	@Override
	public TraningNoteVO selectDayTraningNoteAllSum(TraningNoteVO traningNoteVO)	throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.selectDayTraningNoteAllSum(traningNoteVO);
	}
	@Override
	public List<TraningNoteVO> selectDayTraningNoteTotal(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.selectDayTraningNoteTotal(traningNoteVO);
	}
	@Override
	public List<TraningNoteVO> getWeekTraningNoteAddCcnAdd(
			TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		return  weekTraningMapper.getWeekTraningNoteAddCcnAdd(traningNoteVO);
	} 
	
	@Override
	public List<TraningNoteVO> excelWeekTraningAttendCot(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.excelWeekTraningAttendCot(traningNoteVO);
	}
	
	@Override
	public List<TraningNoteVO> excelWeekTraningAttendPrd(TraningNoteVO traningNoteVO) throws Exception {
		// TODO Auto-generated method stub
		return weekTraningMapper.excelWeekTraningAttendPrd(traningNoteVO);
	}

}
