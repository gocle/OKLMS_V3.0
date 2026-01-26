package kr.co.gocle.oklms.la.api.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gocle.oklms.comm.web.BaseController;
import kr.co.gocle.oklms.la.api.service.ApiService;
import kr.co.gocle.oklms.la.api.vo.ApiVO;
import kr.co.gocle.oklms.la.company.vo.CompanyVO;


/**
* 
* 콘텐츠 관리 컨트롤러
* 
* @author 최종 수정자 JGH
* @version 1.0, 작업 내용
* @see /adm
*/
@Controller
public class ApiController extends BaseController{

	private static final Logger LOG = LoggerFactory.getLogger(ApiController.class);
	
	@Resource(name = "apiService")
	private ApiService apiService;
	
	/** 센텀전담자 리스트 */
	@ResponseBody
	@RequestMapping(value = "/api/ccnMemberList.do", method = {RequestMethod.GET, RequestMethod.POST})
    public Map<String, Object> getVidoList(
                                 HttpSession session, ModelMap model,
                                 HttpServletRequest request)
    		throws Exception {
		
			Map<String,Object> rtnMap = new HashMap<String, Object>();
			
			// 컨텐츠 정보
    		List<ApiVO> ccnMemberList = apiService.ccnMemberList();
            			
    		if (ccnMemberList != null && !ccnMemberList.isEmpty()) {
    		    List<Map<String, String>> memberInfoList = new ArrayList<>();

    		    for (ApiVO vo : ccnMemberList) {
    		        Map<String, String> infoMap = new HashMap<>();
    		        infoMap.put("memName", vo.getMemName());
    		        infoMap.put("memSeq", vo.getMemSeq());
    		        memberInfoList.add(infoMap);
    		    }

    		    rtnMap.put("memberInfoList", memberInfoList);
    		} else {
    		    rtnMap.put("msg", "접속가능한 컨텐츠가 없습니다.");
    		}
    		
        return rtnMap;
    }
	
	/** 사업자 등록번호 체크 */
	@ResponseBody
	@RequestMapping(value = "/api/companyNoChk.do", method = {RequestMethod.GET, RequestMethod.POST})
    public Map<String, Object> companyNoChk(
    							@RequestParam(value = "companyName", required = false) String companyName, // 기업명
    							@RequestParam(value = "companyNo", required = false) String companyNo, // 사업자 등록번호
    							@RequestParam(value = "ceo", required = false) String ceo, // 사업자
    							@RequestParam(value = "oklmsYn", required = false) String oklmsYn, // oklms 연동여부
    							@RequestParam(value = "ccnMemberSeq", required = false) String ccnMemberSeq, // 사업담당자
    							@RequestParam(value = "choiceDay", required = false) String choiceDay, // 선정일
    							@RequestParam(value = "regularEmploymentCnt", required = false) String regularEmploymentCnt, // 상시근로자수
    							@RequestParam(value = "zipCode", required = false) String zipCode, // 주소
    							@RequestParam(value = "address", required = false) String address, // 주소
    							@RequestParam(value = "addressDtl", required = false) String addressDtl, // 주소
    							@RequestParam(value = "homepageUrl", required = false) String homepageUrl, // 홈페이지 url
    							@RequestParam(value = "companyId", required = false) String companyId, // 기업아이디
                                 HttpSession session, ModelMap model,
                                 HttpServletRequest request)
    		throws Exception {
		
			Map<String,Object> rtnMap = new HashMap<String, Object>();
			
			CompanyVO companyVO = new CompanyVO();
			companyVO.setCompanyName(companyName);
			companyVO.setCompanyNo(companyNo);
			companyVO.setCeo(ceo);
			companyVO.setSessionMemType("CCN");
			companyVO.setMemSeq(ccnMemberSeq);
			companyVO.setChoiceDay(choiceDay);
			companyVO.setRegularEmploymentCnt(regularEmploymentCnt);
			companyVO.setZipCode(zipCode);
			companyVO.setAddress(address);
			companyVO.setAddressDtl(addressDtl);
			companyVO.setHomepageUrl(homepageUrl);
			companyVO.setCompanyId(companyId);
			
			companyVO.setCompanyNo(StringUtils.delete(companyVO.getCompanyNo(), "-").trim());
			
			boolean isInsert = (companyId == null || companyId.trim().isEmpty());
			
			if ("Y".equals(oklmsYn)) {
			
				if(companyVO.getCompanyNo().length() == 10) {
					// 사업자 등록번호 체크
		    		int companyNoChk = apiService.companyNoChk(companyVO.getCompanyNo());
		            			
		    		if (companyNoChk > 0 && isInsert){
		    		    rtnMap.put("msg", "사업자 등록번호가 중복입니다.");
		    		} else {
		    				
		        			if(isInsert) {
		        				String returnStr = apiService.insertCompany(companyVO);
		        				rtnMap.put("companyId", returnStr);
		        			}else {
		        				apiService.updateCompany(companyVO);
		        			}
		        			
		        		    rtnMap.put("msg", "등록가능한 기업입니다.");
		    			
		    			
		    		}
				}else {
					rtnMap.put("msg", "사업자 등록번호는 숫자 10자리여야 합니다.");
				}
			
			}
			
			
    		
        return rtnMap;
    }	
	
}
