package kr.co.gocle.oklms.la.statistics.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.gocle.ifx.service.CmsIfxService;
import kr.co.gocle.ifx.vo.CmsCourseBaseVO;
import kr.co.gocle.ifx.vo.CmsCourseContentVO;
import kr.co.gocle.oklms.la.statistics.service.ContentStatisticsService;
import kr.co.gocle.oklms.la.statistics.vo.ContentStatVO;
import kr.co.gocle.oklms.lu.online.vo.OnlineTraningSchVO;
import kr.co.gocle.oklms.lu.subject.vo.SubjectVO;


@Service
public class ContentStatisticsServiceImpl extends EgovAbstractServiceImpl implements ContentStatisticsService {

	@Resource(name = "contentStatisticsMapper")
	private ContentStatisticsMapper contentStatisticsMapper;
	
	@Resource(name = "cmsIfxService")
	private CmsIfxService cmsIfxService;
	
	@Override
	public List<ContentStatVO> getContentDetailStat(CmsCourseBaseVO cmsCourseBaseVO) throws Exception {
		List<ContentStatVO> resultList = new ArrayList<>();
		
		cmsCourseBaseVO.setPage(0);
        cmsCourseBaseVO.setAddURL("getCourseContentItemList");
        
        String cmsData = cmsIfxService.getCmsData(cmsCourseBaseVO);
        
        JsonParser parser = new JsonParser();
        JsonObject jsonObject = parser.parse(cmsData).getAsJsonObject();

        String retCd = jsonObject.get("code").getAsString();
        if (!"10000".equals(retCd)) {
            return resultList;
        }
        
        JsonObject body = jsonObject.getAsJsonObject("body");
        if (body == null) {
            return resultList;
        }
        
        JsonArray list = body.getAsJsonArray("list");
        if (list == null || list.size() == 0) {
            return resultList;
        }
        
        for (JsonElement el : list) {

            JsonObject obj = el.getAsJsonObject();

            JsonObject lesson = obj.getAsJsonObject("lesson");
            if (lesson == null || !lesson.has("id")) {
                continue;
            }

            String lessonId = lesson.get("id").getAsString();
            String lessonTitle = lesson.has("title") && !lesson.get("title").isJsonNull() ? lesson.get("title").getAsString() : "";

            System.out.println("lessonId = " + lessonId);
            System.out.println("lessonTitle = " + lessonTitle);
            
            String usedCourseCnt = contentStatisticsMapper.selectUsedCourseCnt(lessonId);
            String studentCnt    = contentStatisticsMapper.selectStudentCnt(lessonId);

            ContentStatVO vo = new ContentStatVO();
            vo.setLessonId(lessonId);
            vo.setLessonTitle(lessonTitle);
            vo.setUsedCourseCnt(usedCourseCnt == null ? "0" : usedCourseCnt);
            vo.setStudentCnt(studentCnt == null ? "0" : studentCnt);
            
            resultList.add(vo);
        }
        
        return resultList;
	}

	@Override
	public List<CmsCourseContentVO> listCourseContentStat(CmsCourseBaseVO cmsCourseBaseVO) throws Exception {
		return contentStatisticsMapper.listCourseContentStat(cmsCourseBaseVO);
	}

	@Override
	public List<SubjectVO> listUsedCourse(String lessonId) throws Exception {
		return contentStatisticsMapper.listUsedCourse(lessonId);
	}

}
