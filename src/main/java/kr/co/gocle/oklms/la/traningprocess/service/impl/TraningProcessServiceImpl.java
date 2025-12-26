
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
package kr.co.gocle.oklms.la.traningprocess.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.gocle.aunuri.service.impl.AunuriLinkMapper;
import kr.co.gocle.aunuri.vo.AunuriLinkSubjectWeekNcsVO;
import kr.co.gocle.oklms.comm.util.ExcelData;
import kr.co.gocle.oklms.comm.util.ExcelDataSet;
import kr.co.gocle.oklms.comm.util.ExcelHandler;
import kr.co.gocle.oklms.comm.util.FileUploadUtil;
import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.commbiz.atchFile.service.AtchFileService;
import kr.co.gocle.oklms.la.link.service.impl.LinkMapper;
import kr.co.gocle.oklms.la.traningprocess.service.TraningProcessService;
import kr.co.gocle.oklms.la.traningprocess.vo.TraningProcessVO;
import kr.co.gocle.oklms.lu.grade.vo.GradeVO;
import kr.co.gocle.oklms.lu.traning.service.TraningService;
import kr.co.gocle.oklms.lu.traning.vo.TraningMemberVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningNoteVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningProcessMappingVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningScheduleVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.sim.service.EgovClntInfo;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

 /**
 * 프로토타입 게시판 CRUD 비지니스 로직을 구현하는 클레스.
 * @author 이진근
 * @since 2016. 07. 01.
 */
@Transactional(rollbackFor=Exception.class)
@Service("traningProcessService")
public class TraningProcessServiceImpl extends EgovAbstractServiceImpl implements TraningProcessService{


    @Resource(name = "traningProcessMapper")
    private TraningProcessMapper traningProcessMapper;
    
    @Resource(name="traningProcessSearchIdGnrService")
    private EgovIdGnrService traningProcessSearchIdGnrService;
    

    @Override
	public List<TraningProcessVO> listTraningProcess(TraningProcessVO traningProcessVO) throws Exception {
		return traningProcessMapper.listTraningProcess(traningProcessVO);
	}
    
    @Override
   	public List<TraningProcessVO> listSearchTraningProcess(TraningProcessVO traningProcessVO) throws Exception {
   		return traningProcessMapper.listSearchTraningProcess(traningProcessVO);
   	}
    
	@Override
	public TraningProcessVO getTraningProcess(TraningProcessVO traningProcessVO) throws Exception {
		return traningProcessMapper.getTraningProcess(traningProcessVO);
	}
	
	@Override
	public int getTraningProcessUseCnt(TraningProcessVO traningProcessVO) throws Exception {
		return traningProcessMapper.getTraningProcessUseCnt(traningProcessVO);
	}
	
	@Override
	public int insertTraningProcess(TraningProcessVO traningProcessVO) throws Exception {
		traningProcessVO.setTraningProcessId(traningProcessSearchIdGnrService.getNextStringId());
		return traningProcessMapper.insertTraningProcess(traningProcessVO);
	}
	
	@Override
	public int updateTraningProcess(TraningProcessVO traningProcessVO) throws Exception {
		int iResult = 0;
		iResult =  traningProcessMapper.updateTraningProcess(traningProcessVO);
		if( iResult > 0 ){
			iResult += traningProcessMapper.updateTraningProcessHrd(traningProcessVO);
		}
		return iResult;
	}
	
	@Override
	public int deleteTraningProcess(TraningProcessVO traningProcessVO) throws Exception {
		return traningProcessMapper.deleteTraningProcess(traningProcessVO);
	}

	@Override
	public List<TraningProcessVO> listTraningProcessStat(TraningProcessVO traningProcessVO) throws Exception {
		// TODO Auto-generated method stub
		return traningProcessMapper.listTraningProcessStat(traningProcessVO);
	}

	@Override
	public List<HashMap> mainTraningProcessStat() throws Exception {
		// TODO Auto-generated method stub
		return traningProcessMapper.mainTraningProcessStat();
	}
	
	@Override
	public List<TraningProcessVO> listTraningDeptStat() throws Exception {
		// TODO Auto-generated method stub
		return traningProcessMapper.listTraningDeptStat();
	}
	
	
	
	
}
