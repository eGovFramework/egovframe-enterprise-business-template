package egovframework.let.sym.ccm.cca.web;

import java.util.Map;

import egovframework.com.cmm.LoginVO;
import egovframework.let.sym.ccm.cca.service.CmmnCode;
import egovframework.let.sym.ccm.cca.service.CmmnCodeVO;
import egovframework.let.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;
import egovframework.let.sym.ccm.ccc.service.CmmnClCodeVO;
import egovframework.let.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 *
 * 공통코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Controller
public class EgovCcmCmmnCodeManageController {

	@Resource(name = "CmmnCodeManageService")
    private EgovCcmCmmnCodeManageService cmmnCodeManageService;

	@Resource(name = "CmmnClCodeManageService")
    private EgovCcmCmmnClCodeManageService cmmnClCodeManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 공통코드를 삭제한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param model
	 * @return "forward:/sym/ccm/cca/EgovCcmCmmnCodeList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/cca/EgovCcmCmmnCodeRemove.do")
	public String deleteCmmnCode (@ModelAttribute("loginVO") LoginVO loginVO
			, CmmnCode cmmnCode
			, ModelMap model
			) throws Exception {
    	cmmnCodeManageService.deleteCmmnCode(cmmnCode);
        return "forward:/sym/ccm/cca/EgovCcmCmmnCodeList.do";
	}

	/**
	 * 공통코드를 등록한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnCodeRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/cca/EgovCcmCmmnCodeRegist.do")
	public String insertCmmnCode (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, ModelMap model
			) throws Exception {
    	if   (cmmnCode.getClCode() == null
    		||cmmnCode.getClCode().equals("")) {

    		CmmnClCodeVO searchVO;
    		searchVO = new CmmnClCodeVO();
    		searchVO.setRecordCountPerPage(999999);
    		searchVO.setFirstIndex(0);
    		searchVO.setSearchCondition("CodeList");
            model.addAttribute("cmmnClCode", cmmnClCodeManageService.selectCmmnClCodeList(searchVO));

    		return "/cmm/sym/ccm/EgovCcmCmmnCodeRegist";
    	}

        beanValidator.validate(cmmnCode, bindingResult);
		if (bindingResult.hasErrors()){
    		CmmnClCodeVO searchVO;
    		searchVO = new CmmnClCodeVO();
    		searchVO.setRecordCountPerPage(999999);
    		searchVO.setFirstIndex(0);
    		searchVO.setSearchCondition("CodeList");
            model.addAttribute("cmmnClCode", cmmnClCodeManageService.selectCmmnClCodeList(searchVO));

            return "/cmm/sym/ccm/EgovCcmCmmnCodeRegist";
		}

    	cmmnCode.setFrstRegisterId(loginVO.getUniqId());
    	cmmnCodeManageService.insertCmmnCode(cmmnCode);
        return "forward:/sym/ccm/cca/EgovCcmCmmnCodeList.do";
    }

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param model
	 * @return "cmm/sym/ccm/EgovCcmCmmnCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/ccm/cca/EgovCcmCmmnCodeDetail.do")
 	public String selectCmmnCodeDetail (@ModelAttribute("loginVO") LoginVO loginVO
 			, CmmnCode cmmnCode
 			, ModelMap model
 			) throws Exception {
		CmmnCode vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
		model.addAttribute("result", vo);

		return "cmm/sym/ccm/EgovCcmCmmnCodeDetail";
	}

    /**
	 * 공통코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/cmm/sym/ccm/EgovCcmCmmnCodeList"
     * @throws Exception
     */
    @RequestMapping(value="/sym/ccm/cca/EgovCcmCmmnCodeList.do")
	public String selectCmmnCodeList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") CmmnCodeVO searchVO
			, ModelMap model
			) throws Exception {
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

        model.addAttribute("resultList", cmmnCodeManageService.selectCmmnCodeList(searchVO));

        int totCnt =cmmnCodeManageService.selectCmmnCodeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "/cmm/sym/ccm/EgovCcmCmmnCodeList";
	}

	/**
	 * 공통코드를 수정한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnCodeModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/cca/EgovCcmCmmnCodeModify.do")
	public String updateCmmnCode (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, @RequestParam Map <String, Object> commandMap
			, ModelMap model
			) throws Exception {
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
    	if (sCmd.equals("")) {
    		CmmnCode vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
    		model.addAttribute("cmmnCode", vo);

    		return "/cmm/sym/ccm/EgovCcmCmmnCodeModify";
    	} else if (sCmd.equals("Modify")) {
            beanValidator.validate(cmmnCode, bindingResult);
    		if (bindingResult.hasErrors()){
        		CmmnCode vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
        		model.addAttribute("cmmnCode", vo);

        		return "/cmm/sym/ccm/EgovCcmCmmnCodeModify";
    		}

    		cmmnCode.setLastUpdusrId(loginVO.getUniqId());
	    	cmmnCodeManageService.updateCmmnCode(cmmnCode);
	        return "forward:/sym/ccm/cca/EgovCcmCmmnCodeList.do";
    	} else {
    		return "forward:/sym/ccm/cca/EgovCcmCmmnCodeList.do";
    	}
    }

}