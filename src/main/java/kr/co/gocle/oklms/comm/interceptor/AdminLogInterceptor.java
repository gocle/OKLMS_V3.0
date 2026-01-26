package kr.co.gocle.oklms.comm.interceptor;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.messaging.handler.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.gocle.oklms.comm.vo.LoginInfo;
import kr.co.gocle.oklms.commbiz.menu.vo.CommbizMenuVO;
import kr.co.gocle.oklms.la.log.service.AdminLogService;
import kr.co.gocle.oklms.la.log.vo.AdminLogVO;

public class AdminLogInterceptor extends HandlerInterceptorAdapter {

    private AdminLogService adminLogService;

    public void setAdminLogService(AdminLogService adminLogService) {
        this.adminLogService = adminLogService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        LoginInfo loginInfo = new LoginInfo(request, response);
        if (loginInfo.getLoginInfo() == null) {
            return true;
        }

        String uri = request.getRequestURI();
	     if (!uri.startsWith("/la")) {
	         return true;
	     }

        // 기본 WorkType
        String workType = "관리자 화면 접근";

        String rootMenuId = StringUtils.defaultIfBlank(request.getParameter("rootMenuId"), (String)request.getAttribute("rootMenuId") );
		String menuId = StringUtils.defaultIfBlank(request.getParameter("menuId"), (String)request.getAttribute("menuId") );

		ArrayList<CommbizMenuVO> menuList = (ArrayList<CommbizMenuVO>) loginInfo.getAuthenticMenuInfo();
		
		if (menuList == null || menuList.isEmpty()) {
		    // 메뉴 컨텍스트 없는 요청은 로그 대상 제외
		    return true;
		}
		
	    CommbizMenuVO currentMenu = null;
	    for (CommbizMenuVO menuVO : menuList) {
	        if (menuId.equals(menuVO.getMenuId())) {
	            currentMenu = menuVO;
	            break;
	        }
	    }

	    if (currentMenu == null) {
	        return true;
	    }

	    AdminWorkType workTypeEnum = resolveWorkType(uri, currentMenu);
		
        AdminLogVO adminLogVO = new AdminLogVO();
        adminLogVO.setRequest(request);
        adminLogVO.setMenuId(menuId);
        adminLogVO.setWorkType(currentMenu.getMenuTitle() + workTypeEnum.getLabel());
        adminLogService.insertAdminLog(adminLogVO);

        return true;
    }
    
    public enum AdminWorkType {

        LIST("(목록 조회)"),
        READ("(상세 조회)"),
        CREATE("(등록)"),
        UPDATE("(수정)"),
        DELETE("(삭제)"),
        PRINT("(출력)"),
        DOWNLOAD("(다운로드)"),
        OTHER("(기타)"),
        UNKNOWN("(기타)");

        private final String label;

        AdminWorkType(String label) {
            this.label = label;
        }

        public String getLabel() {
            return label;
        }
    }
    
    private AdminWorkType resolveWorkType(
            String requestUri,
            CommbizMenuVO menuVO) {

        if (requestUri.matches(menuVO.getCreateAuthUrlPattern())) {
            return AdminWorkType.CREATE;
        }
        if (requestUri.matches(menuVO.getReadAuthUrlPattern())) {
            return AdminWorkType.READ;
        }
        if (requestUri.matches(menuVO.getUpdateAuthUrlPattern())) {
            return AdminWorkType.UPDATE;
        }
        if (requestUri.matches(menuVO.getDeleteAuthUrlPattern())) {
            return AdminWorkType.DELETE;
        }
        if (requestUri.matches(menuVO.getPrintAuthUrlPattern())) {
            return AdminWorkType.PRINT;
        }
        if (requestUri.matches(menuVO.getDownloadAuthUrlPattern())) {
            return AdminWorkType.DOWNLOAD;
        }
        if (requestUri.matches(menuVO.getListAuthUrlPattern())) {
            return AdminWorkType.LIST;
        }
        if (requestUri.matches(menuVO.getOtherAuthUrlPattern())) {
            return AdminWorkType.OTHER;
        }

        return AdminWorkType.UNKNOWN;
    }
}
