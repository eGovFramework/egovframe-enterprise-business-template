package egovframework.let.sym.ccm.ccc.web;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.validation.Valid;

import egovframework.com.cmm.LoginVO;
import egovframework.let.sym.ccm.ccc.service.CmmnClCode;
import egovframework.let.sym.ccm.ccc.service.CmmnClCodeVO;
import egovframework.let.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;
import jakarta.annotation.Resource;

/**
 *
 * 공통분류코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한
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
public class EgovCcmCmmnClCodeManageController {
	
	@Resource(name = "CmmnClCodeManageService")
	private EgovCcmCmmnClCodeManageService cmmnClCodeManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * 공통분류코드를 삭제한다.
	 * 
	 * @param loginVO
	 * @param cmmnClCode
	 * @param model
	 * @return "forward:/sym/ccm/ccc/EgovCcmCmmnClCodeList.do"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sym/ccm/ccc/EgovCcmCmmnClCodeRemove.do")
	public String deleteCmmnClCode(@ModelAttribute("loginVO") LoginVO loginVO, CmmnClCode cmmnClCode, ModelMap model)
			throws Exception {
		cmmnClCodeManageService.deleteCmmnClCode(cmmnClCode);
		return "forward:/sym/ccm/ccc/EgovCcmCmmnClCodeList.do";
	}

	/**
	 * 공통분류코드 등록 화면으로 이동 (GET)
	 * 
	 * @return "/cmm/sym/ccm/EgovCcmCmmnClCodeRegist"
	 * @throws Exception
	 */
	@GetMapping(value = "/sym/ccm/ccc/EgovCcmCmmnClCodeRegist.do")
	public String insertCmmnClCodeView(ModelMap model) throws Exception {
		model.addAttribute("cmmnClCode", new CmmnClCode());
		return "/cmm/sym/ccm/EgovCcmCmmnClCodeRegist";
	}

	/**
	 * 공통분류코드를 등록한다 (POST)
	 * 
	 * @param loginVO
	 * @param cmmnClCode
	 * @param bindingResult
	 * @return "forward:/sym/ccm/ccc/EgovCcmCmmnClCodeList.do"
	 * @throws Exception
	 */
	@PostMapping(value = "/sym/ccm/ccc/EgovCcmCmmnClCodeRegist.do")
	public String insertCmmnClCode(@ModelAttribute("loginVO") LoginVO loginVO,
			@Valid @ModelAttribute("cmmnClCode") CmmnClCode cmmnClCode, BindingResult bindingResult, ModelMap model)
			throws Exception {

		if (bindingResult.hasErrors()) {
			model.addAttribute("cmmnClCode", cmmnClCode);
			return "/cmm/sym/ccm/EgovCcmCmmnClCodeRegist";
		}

		cmmnClCode.setFrstRegisterId(loginVO.getUniqId());
		cmmnClCodeManageService.insertCmmnClCode(cmmnClCode);
		return "forward:/sym/ccm/ccc/EgovCcmCmmnClCodeList.do";
	}

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 * 
	 * @param loginVO
	 * @param cmmnClCode
	 * @param model
	 * @return "cmm/sym/ccm/EgovCcmCmmnClCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sym/ccm/ccc/EgovCcmCmmnClCodeDetail.do")
	public String selectCmmnClCodeDetail(@ModelAttribute("loginVO") LoginVO loginVO, CmmnClCode cmmnClCode,
			ModelMap model) throws Exception {
		CmmnClCode vo = cmmnClCodeManageService.selectCmmnClCodeDetail(cmmnClCode);
		model.addAttribute("result", vo);

		return "cmm/sym/ccm/EgovCcmCmmnClCodeDetail";
	}

	/**
	 * 공통분류코드 목록을 조회한다.
	 * 
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnClCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sym/ccm/ccc/EgovCcmCmmnClCodeList.do")
	public String selectCmmnClCodeList(@ModelAttribute("loginVO") LoginVO loginVO,
			@ModelAttribute("searchVO") CmmnClCodeVO searchVO, ModelMap model) throws Exception {

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

		model.addAttribute("resultList", cmmnClCodeManageService.selectCmmnClCodeList(searchVO));

		int totCnt = cmmnClCodeManageService.selectCmmnClCodeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/cmm/sym/ccm/EgovCcmCmmnClCodeList";
	}

	/**
	 * 공통분류코드 수정 화면으로 이동 (GET)
	 * 
	 * @param cmmnClCode
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnClCodeModify"
	 * @throws Exception
	 */
	@GetMapping(value = "/sym/ccm/ccc/EgovCcmCmmnClCodeModify.do")
	public String updateCmmnClCodeView(@ModelAttribute("cmmnClCode") CmmnClCode cmmnClCode, ModelMap model)
			throws Exception {

		CmmnClCode vo = cmmnClCodeManageService.selectCmmnClCodeDetail(cmmnClCode);
		
		model.addAttribute("cmmnClCode", vo);
		return "/cmm/sym/ccm/EgovCcmCmmnClCodeModify";
	}

	/**
	 * 공통분류코드를 수정한다 (POST)
	 * 
	 * @param loginVO
	 * @param cmmnClCode
	 * @param bindingResult
	 * @param model
	 * @return "forward:/sym/ccm/ccc/EgovCcmCmmnClCodeList.do"
	 * @throws Exception
	 */
	@PostMapping(value = "/sym/ccm/ccc/EgovCcmCmmnClCodeModify.do")
	public String updateCmmnClCode(@ModelAttribute("loginVO") LoginVO loginVO,
			@Valid @ModelAttribute("cmmnClCode") CmmnClCode cmmnClCode, BindingResult bindingResult, ModelMap model,
			HttpServletRequest request)
			throws Exception {

		// clCode는 수정 불가이므로 항상 원본 값으로 보장
		if (cmmnClCode.getClCode() != null && !cmmnClCode.getClCode().isEmpty()) {
			CmmnClCode tempCode = new CmmnClCode();
			tempCode.setClCode(cmmnClCode.getClCode());
			CmmnClCode originalData = cmmnClCodeManageService.selectCmmnClCodeDetail(tempCode);
			if (originalData != null) {
				// clCode는 항상 원본 값으로 설정 (중복 방지)
				cmmnClCode.setClCode(originalData.getClCode());
			}
		}

		// Validation 오류가 발생하면 수정 화면으로 돌아감
		if (bindingResult.hasErrors()) {
			model.addAttribute("cmmnClCode", cmmnClCode);
			return "/cmm/sym/ccm/EgovCcmCmmnClCodeModify";
		}


		cmmnClCode.setLastUpdusrId(loginVO.getUniqId());
		cmmnClCodeManageService.updateCmmnClCode(cmmnClCode);
		
		return "forward:/sym/ccm/ccc/EgovCcmCmmnClCodeList.do";
	}

}