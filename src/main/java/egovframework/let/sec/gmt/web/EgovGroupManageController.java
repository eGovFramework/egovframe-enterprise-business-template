package egovframework.let.sec.gmt.web;

import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.sec.gmt.service.EgovGroupManageService;
import egovframework.let.sec.gmt.service.GroupManage;
import egovframework.let.sec.gmt.service.GroupManageVO;
import lombok.RequiredArgsConstructor;

/**
 * 그룹관리에 관한 controller 클래스를 정의한다.
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
 *   2024.09.16  이백행          컨트리뷰션 검색 조건 유지
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입 *
 *
 *      </pre>
 */

@Controller
@RequiredArgsConstructor
public class EgovGroupManageController {

	private final EgovMessageSource egovMessageSource;

	private final EgovGroupManageService egovGroupManageService;

	/** Message ID Generation */
	private final EgovIdGnrService egovGroupIdGnrService;

	private final DefaultBeanValidator beanValidator;

	/**
	 * 그룹 목록화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/sec/gmt/EgovGroupListView.do")
	public String selectGroupListView() throws Exception {
		return "/sec/gmt/EgovGroupManage";
	}

	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * 
	 * @param groupManageVO GroupManageVO
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sec/gmt/EgovGroupList.do")
	public String selectGroupList(@ModelAttribute("groupManageVO") GroupManageVO groupManageVO, Model model)
			throws Exception {
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());

		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		groupManageVO.setGroupManageList(egovGroupManageService.selectGroupList(groupManageVO));
		model.addAttribute("groupList", groupManageVO.getGroupManageList());

		int totCnt = egovGroupManageService.selectGroupListTotCnt(groupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/sec/gmt/EgovGroupManage";
	}

	/**
	 * 검색조건에 따른 그룹정보를 조회
	 * 
	 * @param groupManageVO GroupManageVO
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sec/gmt/EgovGroup.do")
	public String selectGroup(@ModelAttribute("groupManageVO") GroupManageVO groupManageVO, Model model)
			throws Exception {

		model.addAttribute("groupManage", egovGroupManageService.selectGroup(groupManageVO));
		return "/sec/gmt/EgovGroupUpdate";
	}

	/**
	 * 그룹 등록화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sec/gmt/EgovGroupInsertView.do")
	public String insertGroupView() throws Exception {
		return "/sec/gmt/EgovGroupInsert";
	}

	/**
	 * 그룹 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * 
	 * @param groupManage   GroupManage
	 * @param groupManageVO GroupManageVO
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/gmt/EgovGroupInsert.do")
	public String insertGroup(@ModelAttribute("groupManage") GroupManage groupManage,
			@ModelAttribute("groupManageVO") GroupManageVO groupManageVO, BindingResult bindingResult,
			SessionStatus status, Model model) throws Exception {

		beanValidator.validate(groupManage, bindingResult); // validation 수행

		if (bindingResult.hasErrors()) {
			return "/sec/gmt/EgovGroupInsert";
		} else {
			groupManage.setGroupId(egovGroupIdGnrService.getNextStringId());
			groupManageVO.setGroupId(groupManage.getGroupId());

			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			model.addAttribute("groupManage", egovGroupManageService.insertGroup(groupManage, groupManageVO));
			addAttributeSearch(groupManageVO, model);
			return "redirect:/sec/gmt/EgovGroupList.do";
		}
	}

	/**
	 * 화면에 조회된 그룹의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * 
	 * @param groupManage GroupManage
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/gmt/EgovGroupUpdate.do")
	public String updateGroup(final GroupManageVO groupManageVO, @ModelAttribute("groupManage") GroupManage groupManage,
			BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		beanValidator.validate(groupManage, bindingResult); // validation 수행

		if (bindingResult.hasErrors()) {
			return "/sec/gmt/EgovGroupUpdate";
		} else {
			egovGroupManageService.updateGroup(groupManage);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
			addAttributeSearch(groupManageVO, model);
			return "redirect:/sec/gmt/EgovGroup.do";
		}
	}

	/**
	 * 불필요한 그룹정보를 화면에 조회하여 데이터베이스에서 삭제
	 * 
	 * @param groupManage GroupManage
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/gmt/EgovGroupDelete.do")
	public String deleteGroup(final GroupManageVO groupManageVO, @ModelAttribute("groupManage") GroupManage groupManage,
			SessionStatus status, Model model) throws Exception {
		egovGroupManageService.deleteGroup(groupManage);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		addAttributeSearch(groupManageVO, model);
		return "redirect:/sec/gmt/EgovGroupList.do";
	}

	/**
	 * 불필요한 그룹정보 목록을 화면에 조회하여 데이터베이스에서 삭제
	 * 
	 * @param groupIds    String
	 * @param groupManage GroupManage
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/gmt/EgovGroupListDelete.do")
	public String deleteGroupList(@RequestParam("groupIds") String groupIds, final GroupManageVO groupManageVO,
			@ModelAttribute("groupManage") GroupManage groupManage, SessionStatus status, Model model)
			throws Exception {
		String[] strGroupIds = groupIds.split(";");
		for (int i = 0; i < strGroupIds.length; i++) {
			groupManage.setGroupId(strGroupIds[i]);
			egovGroupManageService.deleteGroup(groupManage);
		}
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		addAttributeSearch(groupManageVO, model);
		return "redirect:/sec/gmt/EgovGroupList.do";
	}

	/**
	 * 그룹팝업 화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@GetMapping("/sec/gmt/EgovGroupSearchView.do")
	public String selectGroupSearchView() throws Exception {
		return "/sec/gmt/EgovGroupSearch";
	}

	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * 
	 * @param groupManageVO GroupManageVO
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sec/gmt/EgovGroupSearchList.do")
	public String selectGroupSearchList(@ModelAttribute("groupManageVO") GroupManageVO groupManageVO, Model model)
			throws Exception {
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());

		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		groupManageVO.setGroupManageList(egovGroupManageService.selectGroupList(groupManageVO));
		model.addAttribute("groupList", groupManageVO.getGroupManageList());

		int totCnt = egovGroupManageService.selectGroupListTotCnt(groupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/sec/gmt/EgovGroupSearch";
	}

	private void addAttributeSearch(final GroupManageVO groupManageVO, final Model model) {
		model.addAttribute("searchCondition", groupManageVO.getSearchCondition());
		model.addAttribute("searchKeyword", groupManageVO.getSearchKeyword());
		model.addAttribute("pageIndex", groupManageVO.getPageIndex());

		model.addAttribute("groupId", groupManageVO.getGroupId());
	}

}
