package egovframework.let.sym.log.clg.web;

import java.util.HashMap;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.let.sym.log.clg.service.EgovLoginLogService;
import egovframework.let.sym.log.clg.service.LoginLog;
import lombok.RequiredArgsConstructor;

/**
 * 접속로그정보를 관리하기 위한 컨트롤러 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이삼섭          최초 생성
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.clg)
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.06  이백행          컨트리뷰션 검색 조건 유지
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Controller
@RequiredArgsConstructor
public class EgovLoginLogController {

	private final EgovLoginLogService loginLogService;

	private final EgovPropertyService propertyService;

	/**
	 * 로그인 로그 목록 조회
	 *
	 * @param loginLog
	 * @return sym/log/clg/EgovLoginLogList
	 * @throws Exception
	 */
	@GetMapping(value = "/sym/log/clg/SelectLoginLogList.do")
	public String selectLoginLogInf(@ModelAttribute("searchVO") LoginLog loginLog, ModelMap model) throws Exception {
		System.out.println("eeee:::" + loginLog);
		loginLog.setPageUnit(propertyService.getInt("pageUnit"));
		loginLog.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(loginLog.getPageIndex());
		paginationInfo.setRecordCountPerPage(loginLog.getPageUnit());
		paginationInfo.setPageSize(loginLog.getPageSize());

		loginLog.setFirstIndex(paginationInfo.getFirstRecordIndex());
		loginLog.setLastIndex(paginationInfo.getLastRecordIndex());
		loginLog.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		loginLog.setSearchBgnDe(loginLog.getSearchBgnDe().replaceAll("-", ""));
		loginLog.setSearchEndDe(loginLog.getSearchEndDe().replaceAll("-", ""));

		HashMap<?, ?> _map = (HashMap<?, ?>) loginLogService.selectLoginLogInf(loginLog);
		int totCnt = Integer.parseInt((String) _map.get("resultCnt"));

		model.addAttribute("resultList", _map.get("resultList"));
		model.addAttribute("resultCnt", _map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sym/log/clg/EgovLoginLogList";
	}

	/**
	 * 로그인 로그 상세 조회
	 *
	 * @param loginLog
	 * @param model
	 * @return sym/log/clg/EgovLoginLogInqire
	 * @throws Exception
	 */
	@GetMapping(value = "/sym/log/clg/InqireLoginLog.do")
	public String selectLoginLog(@ModelAttribute("searchVO") LoginLog loginLog, @RequestParam("logId") String logId,
			ModelMap model) throws Exception {

		loginLog.setLogId(logId.trim());

		LoginLog vo = loginLogService.selectLoginLog(loginLog);
		model.addAttribute("result", vo);
		return "sym/log/clg/EgovLoginLogInqire";
	}

}
