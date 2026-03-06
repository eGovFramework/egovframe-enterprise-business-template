package egovframework.let.sym.ccm.cde.web;

import java.util.List;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.let.sym.ccm.cca.service.CmmnCode;
import egovframework.let.sym.ccm.cca.service.CmmnCodeVO;
import egovframework.let.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;
import egovframework.let.sym.ccm.ccc.service.CmmnClCodeVO;
import egovframework.let.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;
import egovframework.let.sym.ccm.cde.service.CmmnDetailCodeVO;
import egovframework.let.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

/**
 *
 * 공통상세코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한
 * Controller를 정의한다
 * 
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *      </pre>
 */
@Controller
public class EgovCcmCmmnDetailCodeManageController {

	@Resource(name = "CmmnDetailCodeManageService")
	private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;

	@Resource(name = "CmmnClCodeManageService")
	private EgovCcmCmmnClCodeManageService cmmnClCodeManageService;

	@Resource(name = "CmmnCodeManageService")
	private EgovCcmCmmnCodeManageService cmmnCodeManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * 공통상세코드를 삭제한다.
	 * 
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sym/ccm/cde/EgovCcmCmmnDetailCodeRemove.do")
	public String deleteCmmnDetailCode(@ModelAttribute("loginVO") LoginVO loginVO, CmmnDetailCode cmmnDetailCode,
			ModelMap model) throws Exception {
		cmmnDetailCodeManageService.deleteCmmnDetailCode(cmmnDetailCode);
		return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
	}

	/**
	 * 공통상세코드 등록 화면으로 이동 (GET)
	 * 
	 * @param loginVO
	 * @param cmmnCode
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeRegist"
	 * @throws Exception
	 */
	@GetMapping(value = "/sym/ccm/cde/EgovCcmCmmnDetailCodeRegist.do")
	public String insertCmmnDetailCodeView(@ModelAttribute("loginVO") LoginVO loginVO,
			@RequestParam(value = "clCode", required = false) String clCodeParam, CmmnCode cmmnCode,
			ModelMap model) throws Exception {

		CmmnClCodeVO searchClCodeVO = new CmmnClCodeVO();
		searchClCodeVO.setRecordCountPerPage(999999);
		searchClCodeVO.setFirstIndex(0);
		searchClCodeVO.setSearchCondition("CodeList");
		List<?> CmmnClCodeList = cmmnClCodeManageService.selectCmmnClCodeList(searchClCodeVO);
		model.addAttribute("cmmnClCodeList", CmmnClCodeList);

		// 쿼리 파라미터로 전달된 clCode가 있으면 우선 사용 (빈 문자열 제외)
		if (clCodeParam != null && !clCodeParam.trim().isEmpty()) {
			if (cmmnCode == null) {
				cmmnCode = new CmmnCode();
			}
			cmmnCode.setClCode(clCodeParam.trim());
		}

		CmmnCodeVO searchCodeVO = new CmmnCodeVO();
		searchCodeVO.setRecordCountPerPage(999999);
		searchCodeVO.setFirstIndex(0);
		searchCodeVO.setSearchCondition("clCode");

		// cmmnCode가 null이거나 clCode가 비어있으면 첫 번째 분류코드 사용
		if (cmmnCode == null || cmmnCode.getClCode() == null || cmmnCode.getClCode().trim().isEmpty()) {
			if (CmmnClCodeList != null && !CmmnClCodeList.isEmpty()) {
				EgovMap emp = (EgovMap) CmmnClCodeList.get(0);
				if (cmmnCode == null) {
					cmmnCode = new CmmnCode();
				}
				cmmnCode.setClCode(emp.get("clCode").toString());
			}
		}

		if (cmmnCode != null && cmmnCode.getClCode() != null && !cmmnCode.getClCode().isEmpty()) {
			searchCodeVO.setSearchKeyword(cmmnCode.getClCode());
		}

		List<?> cmmnCodeList = cmmnCodeManageService.selectCmmnCodeList(searchCodeVO);

		model.addAttribute("cmmnCodeList", cmmnCodeList);
		model.addAttribute("cmmnDetailCode", new CmmnDetailCode());
		if (cmmnCode != null) {
			model.addAttribute("cmmnCode", cmmnCode);
		} else {
			model.addAttribute("cmmnCode", new CmmnCode());
		}

		return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeRegist";
	}

	/**
	 * 공통상세코드를 등록한다 (POST)
	 * 
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeRegist"
	 * @throws Exception
	 */
	@PostMapping(value = "/sym/ccm/cde/EgovCcmCmmnDetailCodeRegist.do")
	public String insertCmmnDetailCode(@ModelAttribute("loginVO") LoginVO loginVO,
			@Valid @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode, BindingResult bindingResult,
			@ModelAttribute("cmmnCode") CmmnCode cmmnCode, ModelMap model, HttpServletRequest request)
			throws Exception {

		// POST 요청에서 clCode 파라미터 확인
		String clCodeParam = request.getParameter("clCode");
		if (clCodeParam != null && !clCodeParam.isEmpty()) {
			if (cmmnCode == null) {
				cmmnCode = new CmmnCode();
			}
			cmmnCode.setClCode(clCodeParam);
		}

		// Validation 오류가 발생하면 등록 화면으로 돌아감
		if (bindingResult.hasErrors()) {
			CmmnClCodeVO searchClCodeVO = new CmmnClCodeVO();
			searchClCodeVO.setRecordCountPerPage(999999);
			searchClCodeVO.setFirstIndex(0);
			searchClCodeVO.setSearchCondition("CodeList");
			List<?> CmmnClCodeList = cmmnClCodeManageService.selectCmmnClCodeList(searchClCodeVO);
			model.addAttribute("cmmnClCodeList", CmmnClCodeList);

			CmmnCodeVO searchCodeVO = new CmmnCodeVO();
			searchCodeVO.setRecordCountPerPage(999999);
			searchCodeVO.setFirstIndex(0);
			searchCodeVO.setSearchCondition("clCode");

			// cmmnCode가 null이거나 clCode가 비어있으면 첫 번째 분류코드 사용
			if (cmmnCode == null || cmmnCode.getClCode() == null || cmmnCode.getClCode().isEmpty()) {
				if (CmmnClCodeList != null && !CmmnClCodeList.isEmpty()) {
					EgovMap emp = (EgovMap) CmmnClCodeList.get(0);
					if (cmmnCode == null) {
						cmmnCode = new CmmnCode();
					}
					cmmnCode.setClCode(emp.get("clCode").toString());
				}
			}

			if (cmmnCode != null && cmmnCode.getClCode() != null && !cmmnCode.getClCode().isEmpty()) {
				searchCodeVO.setSearchKeyword(cmmnCode.getClCode());
			}

			model.addAttribute("cmmnCodeList", cmmnCodeManageService.selectCmmnCodeList(searchCodeVO));
			model.addAttribute("cmmnDetailCode", cmmnDetailCode);
			if (cmmnCode != null) {
				model.addAttribute("cmmnCode", cmmnCode);
			} else {
				model.addAttribute("cmmnCode", new CmmnCode());
			}

			return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeRegist";
		}

		// 인증 서비스 확인
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		// 26.03.04 KISA 보안취약점 조치 : 불필요한 try-catch 제거
		if (!isAuthenticated) {
			model.addAttribute("message", "로그인이 필요합니다.");
			return "uat/uia/EgovLoginUsr";
		}

		cmmnDetailCode.setFrstRegisterId(loginVO.getUniqId());
		cmmnDetailCodeManageService.insertCmmnDetailCode(cmmnDetailCode);
		return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
	}

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * 
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "cmm/sym/ccm/EgovCcmCmmnDetailCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sym/ccm/cde/EgovCcmCmmnDetailCodeDetail.do")
	public String selectCmmnDetailCodeDetail(@ModelAttribute("loginVO") LoginVO loginVO, CmmnDetailCode cmmnDetailCode,
			ModelMap model) throws Exception {
		CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
		model.addAttribute("result", vo);

		return "cmm/sym/ccm/EgovCcmCmmnDetailCodeDetail";
	}

	/**
	 * 공통상세코드 목록을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do")
	public String selectCmmnDetailCodeList(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("searchVO") CmmnDetailCodeVO searchVO, ModelMap model) throws Exception {
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("resultList", cmmnDetailCodeManageService.selectCmmnDetailCodeList(searchVO));

		int totCnt = cmmnDetailCodeManageService.selectCmmnDetailCodeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeList";
	}

	/**
	 * 공통상세코드 수정 화면으로 이동 (GET)
	 *
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeModify"
	 * @throws Exception
	 */
	@GetMapping(value = "/sym/ccm/cde/EgovCcmCmmnDetailCodeModify.do")
	public String updateCmmnDetailCodeView(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode, ModelMap model) throws Exception {
		CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
		model.addAttribute("cmmnDetailCode", vo);
		return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeModify";
	}

	/**
	 * 공통상세코드를 수정한다 (POST)
	 *
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param bindingResult
	 * @param model
	 * @return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do"
	 * @throws Exception
	 */
	@PostMapping(value = "/sym/ccm/cde/EgovCcmCmmnDetailCodeModify.do")
	public String updateCmmnDetailCode(@ModelAttribute("loginVO") LoginVO loginVO,
			@Valid @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode, BindingResult bindingResult,
			ModelMap model) throws Exception {

		if (bindingResult.hasErrors()) {
			// DB에서 원본 데이터 조회하여 form에 없는 필드들 복원
			CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
			// 원본 객체에 form에 없는 필드들만 설정 (BindingResult 유지)
			cmmnDetailCode.setCodeIdNm(vo.getCodeIdNm());
			// cmmnDetailCode 객체를 그대로 사용하여 BindingResult와 연결 유지
			return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeModify";
		}

		cmmnDetailCode.setLastUpdusrId(loginVO.getUniqId());
		cmmnDetailCodeManageService.updateCmmnDetailCode(cmmnDetailCode);
		return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
	}

}