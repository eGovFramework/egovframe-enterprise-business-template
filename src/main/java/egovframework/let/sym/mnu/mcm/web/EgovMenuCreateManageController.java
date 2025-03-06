package egovframework.let.sym.mnu.mcm.web;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.sym.mnu.mcm.service.EgovMenuCreateManageService;
import egovframework.let.sym.mnu.mcm.service.MenuCreatVO;
import lombok.RequiredArgsConstructor;

/**
 * 메뉴목록 관리및 메뉴생성, 사이트맵 생성을 처리하는 비즈니스 구현 클래스
 *
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 * 
 *      <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이용           최초 생성
 *   2011.07.29  서준식          사이트맵 저장경로 수정
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.24  이백행          컨트리뷰션 검색 조건 유지
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */

@Controller
@RequiredArgsConstructor
public class EgovMenuCreateManageController {

	/** EgovPropertyService */
	private final EgovPropertyService propertiesService;

	/** EgovMenuManageService */
	private final EgovMenuCreateManageService menuCreateManageService;

	/** EgovMessageSource */
	private final EgovMessageSource egovMessageSource;

	/*********** 메뉴 생성 관리 ***************/

	/**
	 * *메뉴생성목록을 조회한다.
	 *
	 * @param searchVO ComDefaultVO
	 * @return 출력페이지정보 "sym/mnu/mcm/EgovMenuCreatManage"
	 * @exception Exception
	 */
	@GetMapping(value = "/sym/mnu/mcm/EgovMenuCreatManageSelect.do")
	public String selectMenuCreatManagList(@ModelAttribute("searchVO") ComDefaultVO searchVO, Model model)
			throws Exception {
		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		// 내역 조회
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
		if (searchVO.getSearchKeyword() != null && !searchVO.getSearchKeyword().equals("")) {
			int IDcnt = menuCreateManageService.selectUsrByPk(searchVO);
			if (IDcnt == 0) {
				resultMsg = egovMessageSource.getMessage("info.nodata.msg");
			} else {
				/* AuthorCode 검색 */
				MenuCreatVO vo = new MenuCreatVO();
				vo = menuCreateManageService.selectAuthorByUsr(searchVO);
				searchVO.setSearchKeyword(vo.getAuthorCode());
			}
		}
		model.addAttribute("list_menumanage", menuCreateManageService.selectMenuCreatManagList(searchVO));

		int totCnt = menuCreateManageService.selectMenuCreatManagTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultMsg", resultMsg);
		return "sym/mnu/mcm/EgovMenuCreatManage";
	}

	/* 메뉴생성 세부조회 */
	/**
	 * 메뉴생성 세부화면을 조회한다.
	 *
	 * @param menuCreatVO MenuCreatVO
	 * @return 출력페이지정보 "sym/mnu/mcm/EgovMenuCreat"
	 * @exception Exception
	 */
	@GetMapping(value = "/sym/mnu/mcm/EgovMenuCreatSelect.do")
	public String selectMenuCreatList(@ModelAttribute("menuCreatVO") MenuCreatVO menuCreatVO, Model model)
			throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		model.addAttribute("list_menulist", menuCreateManageService.selectMenuCreatList(menuCreatVO));
		model.addAttribute("resultVO", menuCreatVO);

		return "sym/mnu/mcm/EgovMenuCreat";
	}

	/**
	 * 메뉴생성처리 및 메뉴생성내역을 등록한다.
	 *
	 * @param checkedAuthorForInsert String
	 * @param checkedMenuNoForInsert String
	 * @return 출력페이지정보 등록처리시 "forward:/sym/mnu/mcm/EgovMenuCreatSelect.do"
	 * @exception Exception
	 */
	@PostMapping("/sym/mnu/mcm/EgovMenuCreatInsert.do")
	public String insertMenuCreatList(@RequestParam("checkedAuthorForInsert") String checkedAuthorForInsert,
			@RequestParam("checkedMenuNoForInsert") String checkedMenuNoForInsert,
			@ModelAttribute("searchVO") ComDefaultVO searchVO, @ModelAttribute("menuCreatVO") MenuCreatVO menuCreatVO,
			Model model) throws Exception {
		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		String[] insertMenuNo = checkedMenuNoForInsert.split(",");
		if (insertMenuNo == null || (insertMenuNo.length == 0)) {
			resultMsg = egovMessageSource.getMessage("fail.common.insert");
		} else {
			menuCreateManageService.insertMenuCreatList(checkedAuthorForInsert, checkedMenuNoForInsert);
			resultMsg = egovMessageSource.getMessage("success.common.insert");
		}
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("authorCode", menuCreatVO.getAuthorCode());
		addAttributeSearch(searchVO, model);
		return "redirect:/sym/mnu/mcm/EgovMenuCreatSelect.do";
	}

	private void addAttributeSearch(final ComDefaultVO searchVO, final Model model) {
		model.addAttribute("searchCondition", searchVO.getSearchCondition());
		model.addAttribute("searchKeyword", searchVO.getSearchKeyword());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
	}

}
