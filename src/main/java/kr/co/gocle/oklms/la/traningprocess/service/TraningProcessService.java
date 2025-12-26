package kr.co.gocle.oklms.la.traningprocess.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
 















import kr.co.gocle.oklms.la.traningprocess.vo.TraningProcessVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningProcessMappingVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningScheduleVO;
import kr.co.gocle.oklms.lu.traning.vo.TraningVO; 

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Transactional(rollbackFor=Exception.class)
public interface TraningProcessService {

	List<TraningProcessVO> listTraningProcess(TraningProcessVO traningProcessVO)
			throws Exception;
	
	List<TraningProcessVO> listSearchTraningProcess(TraningProcessVO traningProcessVO)
			throws Exception;
	

	TraningProcessVO getTraningProcess(TraningProcessVO traningProcessVO)
			throws Exception;

	int getTraningProcessUseCnt(TraningProcessVO traningProcessVO)
			throws Exception;

	int insertTraningProcess(TraningProcessVO traningProcessVO)
			throws Exception;

	int updateTraningProcess(TraningProcessVO traningProcessVO)
			throws Exception;

	int deleteTraningProcess(TraningProcessVO traningProcessVO)
			throws Exception;

	 
	List<TraningProcessVO> listTraningProcessStat(TraningProcessVO traningProcessVO) throws Exception;

	List<HashMap> mainTraningProcessStat() throws Exception;
	
	List<TraningProcessVO> listTraningDeptStat() throws Exception;
}
