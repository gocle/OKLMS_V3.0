package kr.co.gocle.oklms.lu.activitydesc.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.lu.activitydesc.vo.ActivityNoteVO;

@Mapper
public interface ActivityNoteDescMapper {

	List<ActivityNoteVO> listActivityDesc(ActivityNoteVO activityVO)throws Exception;

	int insertActivityDesc(ActivityNoteVO activityVO)throws Exception;

	ActivityNoteVO goInsertActivityDesc(ActivityNoteVO activityVO)throws Exception;

	int selectActivityDescCnt(ActivityNoteVO activityVO)throws Exception;

	int updateActivityDesc(ActivityNoteVO activityVO)throws Exception;

	int selectActivityDescDetailCnt(ActivityNoteVO activityVO)throws Exception;

	int updateActivityDetailDesc(ActivityNoteVO activityVO)throws Exception;

	int insertActivityDescDetail(ActivityNoteVO activityVO)throws Exception;
	  
	List<ActivityNoteVO> listActivityDescDetail(ActivityNoteVO activityVO)throws Exception; 

	int updateActivityDescPrint(ActivityNoteVO activityVO)throws Exception;
	/**
	 * 활동 내역 삭제
	 * @param activityVO
	 * @return
	 * @throws Exception
	 */
	int deleteActivityDesc(ActivityNoteVO activityVO)throws Exception;	
}
