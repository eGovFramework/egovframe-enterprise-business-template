package egovframework.let.sec.rgm.web;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import egovframework.let.sec.rgm.service.AuthorGroup;
import egovframework.let.sec.rgm.service.AuthorGroupVO;
import egovframework.let.sec.rgm.service.EgovAuthorGroupService;
import lombok.RequiredArgsConstructor;

/**
 * 권한그룹에 관한 controller 클래스를 정의한다.
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
 *   2024.09.17  이백행          컨트리뷰션 검색 조건 유지
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */

@Controller
@RequiredArgsConstructor
public class EgovAuthorGroupController {

	private final EgovMessageSource egovMessageSource;

	private final EgovAuthorGroupService egovAuthorGroupService;

	private final EgovAuthorManageService egovAuthorManageService;

	/**
	 * 권한 목록화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@GetMapping("/sec/rgm/EgovAuthorGroupListView.do")
	public String selectAuthorGroupListView() throws Exception {

		return "/sec/rgm/EgovAuthorGroupManage";
	}

	/**
	 * 그룹별 할당된 권한 목록 조회
	 * 
	 * @param authorGroupVO  AuthorGroupVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sec/rgm/EgovAuthorGroupList.do")
	public String selectAuthorGroupList(@ModelAttribute("authorGroupVO") AuthorGroupVO authorGroupVO,
			@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, Model model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorGroupVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorGroupVO.getPageUnit());
		paginationInfo.setPageSize(authorGroupVO.getPageSize());

		authorGroupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorGroupVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorGroupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		authorGroupVO.setAuthorGroupList(egovAuthorGroupService.selectAuthorGroupList(authorGroupVO));
		model.addAttribute("authorGroupList", authorGroupVO.getAuthorGroupList());

		int totCnt = egovAuthorGroupService.selectAuthorGroupListTotCnt(authorGroupVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
		model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());

		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/sec/rgm/EgovAuthorGroupManage";
	}

	/**
	 * 그룹에 권한정보를 할당하여 데이터베이스에 등록
	 * 
	 * @param userIds     String
	 * @param authorCodes String
	 * @param regYns      String
	 * @param authorGroup AuthorGroup
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/rgm/EgovAuthorGroupInsert.do")
	public String insertAuthorGroup(@RequestParam("userIds") String userIds,
			@RequestParam("authorCodes") String authorCodes, @RequestParam("regYns") String regYns,
			@RequestParam("mberTyCodes") String mberTyCode, final AuthorGroupVO authorGroupVO,
			@ModelAttribute("authorGroup") AuthorGroup authorGroup, SessionStatus status, Model model)
			throws Exception {

		String[] strUserIds = userIds.split(";");
		String[] strAuthorCodes = authorCodes.split(";");
		String[] strRegYns = regYns.split(";");
		String[] strMberTyCode = mberTyCode.split(";");

		for (int i = 0; i < strUserIds.length; i++) {
			authorGroup.setUniqId(strUserIds[i]);
			authorGroup.setAuthorCode(strAuthorCodes[i]);
			authorGroup.setMberTyCode(strMberTyCode[i]);
			if (strRegYns[i].equals("N"))
				egovAuthorGroupService.insertAuthorGroup(authorGroup);
			else
				egovAuthorGroupService.updateAuthorGroup(authorGroup);
		}

		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
		addAttributeSearch(authorGroupVO, model);
		return "redirect:/sec/rgm/EgovAuthorGroupList.do";
	}

	/**
	 * 그룹별 할당된 시스템 메뉴 접근권한을 삭제
	 * 
	 * @param userIds     String
	 * @param authorGroup AuthorGroup
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/rgm/EgovAuthorGroupDelete.do")
	public String deleteAuthorGroup(@RequestParam("userIds") String userIds, final AuthorGroupVO authorGroupVO,
			@ModelAttribute("authorGroup") AuthorGroup authorGroup, SessionStatus status, Model model)
			throws Exception {

		String[] strUserIds = userIds.split(";");
		for (int i = 0; i < strUserIds.length; i++) {
			authorGroup.setUniqId(strUserIds[i]);
			egovAuthorGroupService.deleteAuthorGroup(authorGroup);
		}

		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		addAttributeSearch(authorGroupVO, model);
		return "redirect:/sec/rgm/EgovAuthorGroupList.do";
	}

	private void addAttributeSearch(final AuthorGroupVO authorGroupVO, final Model model) {
		model.addAttribute("searchCondition", authorGroupVO.getSearchCondition());
		model.addAttribute("searchKeyword", authorGroupVO.getSearchKeyword());
		model.addAttribute("pageIndex", authorGroupVO.getPageIndex());
	}

}
