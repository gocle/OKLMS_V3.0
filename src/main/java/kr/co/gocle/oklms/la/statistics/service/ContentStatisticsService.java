package kr.co.gocle.oklms.la.statistics.service;

import java.util.List;

import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.ifx.vo.CmsCourseContentVO;
import kr.co.gocle.oklms.la.statistics.vo.ContentStatVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

public interface ContentStatisticsService {

	List<ContentStatVO> getContentDetailStat(CmsCourseBaseVO vo) throws Exception;

	List<CmsCourseContentVO> listCourseContentStat(CmsCourseBaseVO cmsCourseBaseVO) throws Exception;

	List<SubjectVO> listUsedCourse(String lessonId) throws Exception;

}
