package egovframework.let.sym.log.lgm.web;

import java.util.HashMap;

import egovframework.let.sym.log.lgm.service.EgovSysLogService;
import egovframework.let.sym.log.lgm.service.SysLog;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 시스템 로그정보를 관리하기 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이삼섭          최초 생성
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.lgm)
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Controller
public class EgovSysLogController {

	@Resource(name="EgovSysLogService")
	private EgovSysLogService sysLogService;

	@Resource(name="propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * 시스템 로그 목록 조회
	 *
	 * @param sysLog
	 * @return sym/log/lgm/EgovSysLogList
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/log/lgm/SelectSysLogList.do")
	public String selectSysLogInf(@ModelAttribute("searchVO") SysLog sysLog,
			ModelMap model) throws Exception{

		sysLog.setPageUnit(propertyService.getInt("pageUnit"));
		sysLog.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sysLog.getPageIndex());
		paginationInfo.setRecordCountPerPage(sysLog.getPageUnit());
		paginationInfo.setPageSize(sysLog.getPageSize());

		sysLog.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sysLog.setLastIndex(paginationInfo.getLastRecordIndex());
		sysLog.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		HashMap<?, ?> _map = (HashMap<?, ?>)sysLogService.selectSysLogInf(sysLog);
		int totCnt = Integer.parseInt((String)_map.get("resultCnt"));

		model.addAttribute("resultList", _map.get("resultList"));
		model.addAttribute("resultCnt", _map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sym/log/lgm/EgovSysLogList";
	}

	/**
	 * 시스템 로그 상세 조회
	 *
	 * @param sysLog
	 * @param model
	 * @return sym/log/lgm/EgovSysLogInqire
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/log/lgm/InqireSysLog.do")
	public String selectSysLog(@ModelAttribute("searchVO") SysLog sysLog,
			@RequestParam("requstId") String requstId,
			ModelMap model) throws Exception{

		sysLog.setRequstId(requstId.trim());

		SysLog vo = sysLogService.selectSysLog(sysLog);
		model.addAttribute("result", vo);
		return "sym/log/lgm/EgovSysLogInqire";
	}

}
