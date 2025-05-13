package egovframework.let.uss.ion.uas.web;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.ion.uas.service.EgovUserAbsnceService;
import egovframework.let.uss.ion.uas.service.UserAbsnce;
import egovframework.let.uss.ion.uas.service.UserAbsnceVO;

/**
 * 사용자부재에 대한 controller 클래스를 정의한다.
 * 사용자부재에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * 사용자부재의 조회기능은 목록조회, 상세조회로 구분된다.
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j        최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Controller
public class EgovUserAbsnceController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "egovUserAbsnceService")
	private EgovUserAbsnceService egovUserAbsnceService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 사용자부재 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@GetMapping("/uss/ion/uas/selectUserAbsnceListView.do")
	public String selectUserAbsnceListView() throws Exception {

		return "/uss/ion/uas/EgovUserAbsnceList";
	}

	/**
	 * 사용자부재정보를 관리하기 위해 등록된 사용자부재 목록을 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uss/ion/uas/selectUserAbsnceList.do")
	public String selectUserAbsnceList(@RequestParam("selAbsnceAt") String selAbsnceAt, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, Model model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userAbsnceVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userAbsnceVO.getPageUnit());
		paginationInfo.setPageSize(userAbsnceVO.getPageSize());

		userAbsnceVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userAbsnceVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userAbsnceVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		userAbsnceVO.setSelAbsnceAt(selAbsnceAt);
		userAbsnceVO.setUserAbsnceList(egovUserAbsnceService.selectUserAbsnceList(userAbsnceVO));

		model.addAttribute("userAbsnceList", userAbsnceVO.getUserAbsnceList());

		int totCnt = egovUserAbsnceService.selectUserAbsnceListTotCnt(userAbsnceVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uss/ion/uas/EgovUserAbsnceList";
	}

	/**
	 * 등록된 사용자부재 상세정보를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uss/ion/uas/getUserAbsnce.do")
	public String selectUserAbsnce(@RequestParam("userId") String userId, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, Model model) throws Exception {

		userAbsnceVO.setUserId(userId);
		model.addAttribute("userAbsnce", egovUserAbsnceService.selectUserAbsnce(userAbsnceVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		UserAbsnceVO vo = (UserAbsnceVO) model.getAttribute("userAbsnce");

		if (vo.getRegYn().equals("N"))
			return "/uss/ion/uas/EgovUserAbsnceRegist";
		else
			return "/uss/ion/uas/EgovUserAbsnceUpdt";
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uss/ion/uas/addViewUserAbsnce.do")
	public String insertUserAbsnceView(@RequestParam("userId") String userId, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, Model model) throws Exception {
		userAbsnceVO.setUserId(userId);
		model.addAttribute("userAbsnce", egovUserAbsnceService.selectUserAbsnce(userAbsnceVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uss/ion/uas/EgovUserAbsnceRegist";
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@PostMapping("/uss/ion/uas/addUserAbsnce.do")
	public String insertUserAbsnce(@ModelAttribute("userAbsnce") UserAbsnce userAbsnce, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, BindingResult bindingResult,
			Model model) throws Exception {

		beanValidator.validate(userAbsnce, bindingResult); //validation 수행

		if (bindingResult.hasErrors()) {
			model.addAttribute("userAbsnceVO", userAbsnceVO);
			return "/uss/ion/msi/EgovMainImageRegist";
		} else {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userAbsnce.setLastUpdusrId(user.getId());
			// userAbsnce.setLastUpdusrId("jung");

			model.addAttribute("userAbsnce", egovUserAbsnceService.insertUserAbsnce(userAbsnce, userAbsnceVO));
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));

			return "/uss/ion/uas/EgovUserAbsnceUpdt";
		}
	}

	/**
	 * 기 등록된 사용자부재정보를 수정한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@PostMapping("/uss/ion/uas/updtUserAbsnce.do")
	public String updateUserAbsnce(@ModelAttribute("userAbsnce") UserAbsnce userAbsnce, BindingResult bindingResult, Model model) throws Exception {

		if (bindingResult.hasErrors()) {
			model.addAttribute("userAbsnceVO", userAbsnce);
			return "/uss/ion/uas/EgovUserAbsnceUpdt";
		} else {

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userAbsnce.setLastUpdusrId(user.getId());
			//userAbsnce.setLastUpdusrId("jung");

			egovUserAbsnceService.updateUserAbsnce(userAbsnce);
			return "forward:/uss/ion/uas/getUserAbsnce.do";
		}
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@PostMapping("/uss/ion/uas/removeUserAbsnce.do")
	public String deleteUserAbsnce(UserAbsnceVO userAbsnceVO, @ModelAttribute("userAbsnce") UserAbsnce userAbsnce,
			Model model) throws Exception {

		egovUserAbsnceService.deleteUserAbsnce(userAbsnce);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		addAttributeSearch(userAbsnceVO, model);
		return "redirect:/uss/ion/uas/selectUserAbsnceList.do";
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@PostMapping("/uss/ion/uas/removeUserAbsnceList.do")
	public String deleteUserAbsnceList(@RequestParam("userIds") String userIds, @ModelAttribute("userAbsnce") UserAbsnce userAbsnce, Model model) throws Exception {

		String[] strUserIds = userIds.split(";");

		for (int i = 0; i < strUserIds.length; i++) {
			userAbsnce.setUserId(strUserIds[i]);
			egovUserAbsnceService.deleteUserAbsnce(userAbsnce);
		}

		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/uss/ion/uas/selectUserAbsnceList.do";
	}

	/**
	 * MyPage에 사용자부재정보를 제공하기 위해 목록을 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@GetMapping("/uss/ion/uas/selectUserAbsnceMainList.do")
	public String selectUserAbsnceMainList(@ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, Model model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userAbsnceVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(userAbsnceVO.getPageSize());

		userAbsnceVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userAbsnceVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userAbsnceVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		userAbsnceVO.setSelAbsnceAt("A");
		userAbsnceVO.setUserAbsnceList(egovUserAbsnceService.selectUserAbsnceList(userAbsnceVO));

		model.addAttribute("userAbsnceList", userAbsnceVO.getUserAbsnceList());

		return "/uss/ion/uas/EgovUserAbsnceMainList";
	}
	
	private void addAttributeSearch(UserAbsnceVO userAbsnceVO, Model model) {
		model.addAttribute("searchCondition", userAbsnceVO.getSearchCondition());
		model.addAttribute("searchKeyword", userAbsnceVO.getSearchKeyword());
		model.addAttribute("pageIndex", userAbsnceVO.getPageIndex());

		model.addAttribute("selAbsnceAt", userAbsnceVO.getSelAbsnceAt());
	}
}
