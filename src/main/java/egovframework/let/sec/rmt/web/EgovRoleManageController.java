package egovframework.let.sec.rmt.web;

import java.util.List;

import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import egovframework.let.sec.rmt.service.EgovRoleManageService;
import egovframework.let.sec.rmt.service.RoleManage;
import egovframework.let.sec.rmt.service.RoleManageVO;
import jakarta.annotation.Resource;

/**
 * 롤관리에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */

@Controller
public class EgovRoleManageController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "egovRoleManageService")
    private EgovRoleManageService egovRoleManageService;

    @Resource(name = "EgovCmmUseService")
    EgovCmmUseService egovCmmUseService;

    @Resource(name = "egovAuthorManageService")
    private EgovAuthorManageService egovAuthorManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Message ID Generation */
    @Resource(name="egovRoleIdGnrService")
    private EgovIdGnrService egovRoleIdGnrService;

    /**
	 * 롤 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @GetMapping("/sec/rmt/EgovRoleListView.do")
    public String selectRoleListView()
            throws Exception {
        return "/sec/rmt/EgovRoleManage";
    }

	/**
	 * 등록된 롤 정보 목록 조회
	 * @param roleManageVO RoleManageVO
	 * @return String
	 * @exception Exception
	 */
    @GetMapping(value = "/sec/rmt/EgovRoleList.do")
	public String selectRoleList(@ModelAttribute("roleManageVO") RoleManageVO roleManageVO, Model model)
			throws Exception {

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(roleManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(roleManageVO.getPageUnit());
		paginationInfo.setPageSize(roleManageVO.getPageSize());

		roleManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		roleManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		roleManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		roleManageVO.setRoleManageList(egovRoleManageService.selectRoleList(roleManageVO));
        model.addAttribute("roleList", roleManageVO.getRoleManageList());

        int totCnt = egovRoleManageService.selectRoleListTotCnt(roleManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

        return "/sec/rmt/EgovRoleManage";
	}

	/**
	 * 등록된 롤 정보 조회
	 * @param roleCode String
	 * @param roleManageVO RoleManageVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @GetMapping(value = "/sec/rmt/EgovRole.do")
	public String selectRole(@RequestParam("roleCode") String roleCode,
			@ModelAttribute("roleManageVO") RoleManageVO roleManageVO,
			@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, Model model) throws Exception {

    	roleManageVO.setRoleCode(roleCode);

    	authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));

    	model.addAttribute("roleManage", egovRoleManageService.selectRole(roleManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"COM029"));

        return "/sec/rmt/EgovRoleUpdate";
	}

    /**
	 * 롤 등록화면 이동
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @GetMapping("/sec/rmt/EgovRoleInsertView.do")
	public String insertRoleView(final RoleManageVO roleManageVO,
			@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, Model model) throws Exception {

    	authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"COM029"));
        model.addAttribute("roleManage", new RoleManage());

        return "/sec/rmt/EgovRoleInsert";
    }

    /**
	 * 공통코드 호출
	 * @param comDefaultCodeVO ComDefaultCodeVO
	 * @param codeId String
	 * @return List
	 * @exception Exception
	 */
	public List<?> getCmmCodeDetailList(ComDefaultCodeVO comDefaultCodeVO, String codeId)  throws Exception {
    	comDefaultCodeVO.setCodeId(codeId);
    	return egovCmmUseService.selectCmmCodeDetail(comDefaultCodeVO);
    }

	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 등록
	 * @param roleManage RoleManage
	 * @param roleManageVO RoleManageVO
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/rmt/EgovRoleInsert.do")
	public String insertRole(@Valid @ModelAttribute("roleManage") RoleManage roleManage,
			BindingResult bindingResult, @ModelAttribute("roleManageVO") RoleManageVO roleManageVO,
			SessionStatus status, Model model, RedirectAttributes redirectAttributes,
			@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO) throws Exception {

    	if (bindingResult.hasErrors()) {
			model.addAttribute("roleManage", roleManage);
			authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
	        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
	        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"COM029"));
			return "/sec/rmt/EgovRoleInsert";
		} else {
    	    String roleTyp = roleManage.getRoleTyp();
	    	if(roleTyp.equals("method"))
	    		roleTyp = "mtd";
	    	else if(roleTyp.equals("pointcut"))
	    		roleTyp = "pct";
	    	else roleTyp = "web";

	    	roleManage.setRoleCode(roleTyp.concat("-").concat(egovRoleIdGnrService.getNextStringId()));
	    	roleManageVO.setRoleCode(roleManage.getRoleCode());

	    	egovRoleManageService.insertRole(roleManage, roleManageVO);

	    	status.setComplete();
	    	redirectAttributes.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
	        addAttributeSearch(roleManageVO, redirectAttributes);
			return "redirect:/sec/rmt/EgovRoleList.do";
		}
	}

	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 수정
	 * @param roleManage RoleManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/rmt/EgovRoleUpdate.do")
	public String updateRole(final RoleManageVO roleManageVO, @Valid @ModelAttribute("roleManage") RoleManage roleManage,
			BindingResult bindingResult, SessionStatus status, Model model, RedirectAttributes redirectAttributes,
			@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO) throws Exception {

    	if (bindingResult.hasErrors()) {
			model.addAttribute("roleManage", roleManage);
			authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
	        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
	        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"COM029"));
			return "/sec/rmt/EgovRoleUpdate";
		} else {
    	egovRoleManageService.updateRole(roleManage);
    	status.setComplete();
    	redirectAttributes.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
    	addAttributeSearch(roleManageVO, redirectAttributes);
		return "redirect:/sec/rmt/EgovRoleList.do";
		}
	}

	/**
	 * 불필요한 롤정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param roleManage RoleManage
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/rmt/EgovRoleDelete.do")
	public String deleteRole(final RoleManageVO roleManageVO, @ModelAttribute("roleManage") RoleManage roleManage,
			SessionStatus status, Model model, RedirectAttributes redirectAttributes) throws Exception {

    	egovRoleManageService.deleteRole(roleManage);
    	status.setComplete();
    	redirectAttributes.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
    	addAttributeSearch(roleManageVO, redirectAttributes);
		return "redirect:/sec/rmt/EgovRoleList.do";

	}

	/**
	 * 불필요한 그룹정보 목록을 화면에 조회하여 데이터베이스에서 삭제
	 * @param roleCodes String
	 * @param roleManage RoleManage
	 * @return String
	 * @exception Exception
	 */
	@PostMapping(value = "/sec/rmt/EgovRoleListDelete.do")
	public String deleteRoleList(@RequestParam("roleCodes") String roleCodes, final RoleManageVO roleManageVO,
			@ModelAttribute("roleManage") RoleManage roleManage, SessionStatus status, Model model,
			RedirectAttributes redirectAttributes) throws Exception {
    	String [] strRoleCodes = roleCodes.split(";");
    	for(int i=0; i<strRoleCodes.length;i++) {
    		roleManage.setRoleCode(strRoleCodes[i]);
    		egovRoleManageService.deleteRole(roleManage);
    	}
		status.setComplete();
		redirectAttributes.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		addAttributeSearch(roleManageVO, redirectAttributes);
		return "redirect:/sec/rmt/EgovRoleList.do";
	}
	
	private void addAttributeSearch(final RoleManageVO roleManageVO, final RedirectAttributes redirectAttributes) {
		redirectAttributes.addAttribute("searchCondition", roleManageVO.getSearchCondition());
		redirectAttributes.addAttribute("searchKeyword", roleManageVO.getSearchKeyword());
		redirectAttributes.addAttribute("pageIndex", roleManageVO.getPageIndex());
	}

}