package egovframework.let.uat.uap.web;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.uat.uap.service.LoginPolicy;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import lombok.RequiredArgsConstructor;

/**
 * <pre>
 * 로그인정책에 대한 controller 클래스를 정의한다.
 * 로그인정책에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * 로그인정책의 조회기능은 목록조회, 상세조회로 구분된다.
 * </pre>
 * 
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j       최초 생성
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.11  이백행          컨트리뷰션 검색 조건 유지
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Controller
@RequiredArgsConstructor
public class EgovLoginPolicyController {

	private final EgovMessageSource egovMessageSource;

	private final EgovLoginPolicyService egovLoginPolicyService;

	private final DefaultBeanValidator beanValidator;

	/**
	 * 로그인정책 목록 조회화면으로 이동한다.
	 * 
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uat/uap/selectLoginPolicyListView.do")
	public String selectLoginPolicyListView() throws Exception {
		return "/uat/uap/EgovLoginPolicyList";
	}

	/**
	 * 로그인정책 목록을 조회한다.
	 * 
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uat/uap/selectLoginPolicyList.do")
	public String selectLoginPolicyList(@ModelAttribute("loginPolicyVO") LoginPolicyVO loginPolicyVO, ModelMap model)
			throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(loginPolicyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(loginPolicyVO.getPageUnit());
		paginationInfo.setPageSize(loginPolicyVO.getPageSize());

		loginPolicyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		loginPolicyVO.setLastIndex(paginationInfo.getLastRecordIndex());
		loginPolicyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		loginPolicyVO.setLoginPolicyList(egovLoginPolicyService.selectLoginPolicyList(loginPolicyVO));
		model.addAttribute("loginPolicyList", loginPolicyVO.getLoginPolicyList());

		int totCnt = egovLoginPolicyService.selectLoginPolicyListTotCnt(loginPolicyVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uat/uap/EgovLoginPolicyList";
	}

	/**
	 * 로그인정책 목록의 상세정보를 조회한다.
	 * 
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uat/uap/getLoginPolicy.do")
	public String selectLoginPolicy(@RequestParam("emplyrId") String emplyrId,
			@ModelAttribute("loginPolicyVO") LoginPolicyVO loginPolicyVO, ModelMap model) throws Exception {

		loginPolicyVO.setEmplyrId(emplyrId);

		model.addAttribute("loginPolicy", egovLoginPolicyService.selectLoginPolicy(loginPolicyVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		LoginPolicyVO vo = (LoginPolicyVO) model.get("loginPolicy");

		if (vo.getRegYn().equals("N"))
			return "/uat/uap/EgovLoginPolicyRegist";
		else
			return "/uat/uap/EgovLoginPolicyUpdt";
	}

	/**
	 * 로그인정책 정보 등록화면으로 이동한다.
	 * 
	 * @param loginPolicy - 로그인정책 model
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uat/uap/addLoginPolicyView.do")
	public String insertLoginPolicyView(@RequestParam("emplyrId") String emplyrId,
			@ModelAttribute("loginPolicyVO") LoginPolicyVO loginPolicyVO, ModelMap model) throws Exception {

		loginPolicyVO.setEmplyrId(emplyrId);

		model.addAttribute("loginPolicy", egovLoginPolicyService.selectLoginPolicy(loginPolicyVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uat/uap/EgovLoginPolicyRegist";
	}

	/**
	 * 로그인정책 정보를 신규로 등록한다.
	 * 
	 * @param loginPolicy - 로그인정책 model
	 * @return String - 리턴 Url
	 */
	@PostMapping("/uat/uap/addLoginPolicy.do")
	public String insertLoginPolicy(@ModelAttribute("loginPolicy") LoginPolicy loginPolicy, BindingResult bindingResult,
			ModelMap model) throws Exception {

		beanValidator.validate(loginPolicy, bindingResult); // validation 수행

		if (bindingResult.hasErrors()) {
			model.addAttribute("loginPolicyVO", loginPolicy);
			return "/uat/uap/EgovLoginPolicyRegist";
		} else {

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			loginPolicy.setUserId(user.getId());

			egovLoginPolicyService.insertLoginPolicy(loginPolicy);
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));

			addAttributeSearch(loginPolicy, model);

			return "redirect:/uat/uap/getLoginPolicy.do";
		}
	}

	/**
	 * 기 등록된 로그인정책 정보를 수정한다.
	 * 
	 * @param loginPolicy - 로그인정책 model
	 * @return String - 리턴 Url
	 */
	@PostMapping("/uat/uap/updtLoginPolicy.do")
	public String updateLoginPolicy(@ModelAttribute("loginPolicy") LoginPolicy loginPolicy, BindingResult bindingResult,
			ModelMap model) throws Exception {

		beanValidator.validate(loginPolicy, bindingResult); // validation 수행

		if (bindingResult.hasErrors()) {
			model.addAttribute("loginPolicyVO", loginPolicy);
			return "/uat/uap/EgovLoginPolicyUpdt";
		} else {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			loginPolicy.setUserId(user.getId());

			egovLoginPolicyService.updateLoginPolicy(loginPolicy);
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));

			addAttributeSearch(loginPolicy, model);

			return "redirect:/uat/uap/selectLoginPolicyList.do";
		}
	}

	/**
	 * 기 등록된 로그인정책 정보를 삭제한다.
	 * 
	 * @param loginPolicy - 로그인정책 model
	 * @return String - 리턴 Url
	 */
	@PostMapping("/uat/uap/removeLoginPolicy.do")
	public String deleteLoginPolicy(@ModelAttribute("loginPolicy") LoginPolicy loginPolicy, ModelMap model)
			throws Exception {

		egovLoginPolicyService.deleteLoginPolicy(loginPolicy);

		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));

		addAttributeSearch(loginPolicy, model);

		return "redirect:/uat/uap/selectLoginPolicyList.do";
	}

	private void addAttributeSearch(LoginPolicy loginPolicy, ModelMap model) {
		model.addAttribute("searchCondition", loginPolicy.getSearchCondition());
		model.addAttribute("searchKeyword", loginPolicy.getSearchKeyword());
		model.addAttribute("pageIndex", loginPolicy.getPageIndex());

		model.addAttribute("emplyrId", loginPolicy.getEmplyrId());
	}

}
