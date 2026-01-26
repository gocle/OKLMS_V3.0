package kr.co.gocle.oklms.la.statistics.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.ifx.vo.CmsCourseContentVO;
import kr.co.gocle.oklms.la.statistics.vo.ContentStatVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;

@Mapper
public interface ContentStatisticsMapper {

	String selectUsedCourseCnt(String lessonId) throws Exception;

	String selectStudentCnt(String lessonId) throws Exception;

	List<CmsCourseContentVO> listCourseContentStat(CmsCourseBaseVO cmsCourseBaseVO) throws Exception;

	List<SubjectVO> listUsedCourse(String lessonId) throws Exception;

}
