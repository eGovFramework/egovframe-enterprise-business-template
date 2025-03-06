package egovframework.let.sec.ram.web;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.sec.ram.service.AuthorManage;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import lombok.RequiredArgsConstructor;

/**
 * 권한관리에 관한 controller 클래스를 정의한다.
 * 
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */

@Controller
@RequiredArgsConstructor
public class EgovAuthorManageController {

	private final EgovMessageSource egovMessageSource;

	private final EgovAuthorManageService egovAuthorManageService;

	private final DefaultBeanValidator beanValidator;

	/**
	 * 권한 목록화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@GetMapping("/sec/ram/EgovAuthorListView.do")
	public String selectAuthorListView() throws Exception {
		return "/sec/ram/EgovAuthorManage";
	}

	/**
	 * 권한 목록을 조회한다
	 * 
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sec/ram/EgovAuthorList.do")
	public String selectAuthorList(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, Model model)
			throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorManageVO.getPageUnit());
		paginationInfo.setPageSize(authorManageVO.getPageSize());

		authorManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorList(authorManageVO));
		model.addAttribute("authorList", authorManageVO.getAuthorManageList());

		int totCnt = egovAuthorManageService.selectAuthorListTotCnt(authorManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/sec/ram/EgovAuthorManage";
	}

	/**
	 * 권한 세부정보를 조회한다.
	 * 
	 * @param authorCode     String
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sec/ram/EgovAuthor.do")
	public String selectAuthor(@RequestParam("authorCode") String authorCode,
			@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, Model model) throws Exception {

		authorManageVO.setAuthorCode(authorCode);

		model.addAttribute("authorManage", egovAuthorManageService.selectAuthor(authorManageVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
		return "/sec/ram/EgovAuthorUpdate";
	}

	/**
	 * 권한 등록화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@GetMapping("/sec/ram/EgovAuthorInsertView.do")
	public String insertAuthorView(final AuthorManageVO authorManageVO, final Model model) throws Exception {
		return "/sec/ram/EgovAuthorInsert";
	}

	/**
	 * 권한 세부정보를 등록한다.
	 * 
	 * @param authorManage  AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/ram/EgovAuthorInsert.do")
	public String insertAuthor(final AuthorManageVO authorManageVO,
			@ModelAttribute("authorManage") AuthorManage authorManage, BindingResult bindingResult,
			SessionStatus status, Model model) throws Exception {

		beanValidator.validate(authorManage, bindingResult); // validation 수행

		if (bindingResult.hasErrors()) {
			return "/sec/ram/EgovAuthorInsert";
		} else {
			egovAuthorManageService.insertAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			addAttributeSearch(authorManageVO, model);
			return "redirect:/sec/ram/EgovAuthor.do";
		}
	}

	/**
	 * 권한 세부정보를 수정한다.
	 * 
	 * @param authorManage  AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/ram/EgovAuthorUpdate.do")
	public String updateAuthor(final AuthorManageVO authorManageVO,
			@ModelAttribute("authorManage") AuthorManage authorManage, BindingResult bindingResult,
			SessionStatus status, Model model) throws Exception {

		beanValidator.validate(authorManage, bindingResult); // validation 수행

		if (bindingResult.hasErrors()) {
			return "/sec/ram/EgovAuthorUpdate";
		} else {
			egovAuthorManageService.updateAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
			addAttributeSearch(authorManageVO, model);
			return "redirect:/sec/ram/EgovAuthor.do";
		}
	}

	/**
	 * 권한 세부정보를 삭제한다.
	 * 
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/ram/EgovAuthorDelete.do")
	public String deleteAuthor(final AuthorManageVO authorManageVO,
			@ModelAttribute("authorManage") AuthorManage authorManage, SessionStatus status, Model model)
			throws Exception {

		egovAuthorManageService.deleteAuthor(authorManage);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		addAttributeSearch(authorManageVO, model);
		return "redirect:/sec/ram/EgovAuthorList.do";
	}

	/**
	 * 권한목록을 삭제한다.
	 * 
	 * @param authorCodes  String
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/ram/EgovAuthorListDelete.do")
	public String deleteAuthorList(@RequestParam("authorCodes") String authorCodes, final AuthorManageVO authorManageVO,
			@ModelAttribute("authorManage") AuthorManage authorManage, SessionStatus status, Model model)
			throws Exception {

		String[] strAuthorCodes = authorCodes.split(";");
		for (int i = 0; i < strAuthorCodes.length; i++) {
			authorManage.setAuthorCode(strAuthorCodes[i]);
			egovAuthorManageService.deleteAuthor(authorManage);
		}
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		addAttributeSearch(authorManageVO, model);
		return "redirect:/sec/ram/EgovAuthorList.do";
	}

	/**
	 * 권한제한 화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@GetMapping("/sec/ram/accessDenied.do")
	public String accessDenied() throws Exception {
		return "sec/accessDenied";
	}

	private void addAttributeSearch(final AuthorManageVO authorManageVO, final Model model) {
		model.addAttribute("searchCondition", authorManageVO.getSearchCondition());
		model.addAttribute("searchKeyword", authorManageVO.getSearchKeyword());
		model.addAttribute("pageIndex", authorManageVO.getPageIndex());

		model.addAttribute("authorCode", authorManageVO.getAuthorCode());
	}

}
