package egovframework.let.sym.ccm.cca.service.impl;

import java.util.List;

import egovframework.let.sym.ccm.cca.service.CmmnCode;
import egovframework.let.sym.ccm.cca.service.CmmnCodeVO;
import egovframework.let.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;



/**
 *
 * 공통코드에 대한 서비스 구현클래스를 정의한다
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
@Service("CmmnCodeManageService")
public class EgovCcmCmmnCodeManageServiceImpl extends EgovAbstractServiceImpl implements EgovCcmCmmnCodeManageService {

    @Resource(name="CmmnCodeManageDAO")
    private CmmnCodeManageDAO cmmnCodeManageDAO;

	/**
	 * 공통코드를 삭제한다.
	 */
	@Override
	public void deleteCmmnCode(CmmnCode cmmnCode) throws Exception {
		cmmnCodeManageDAO.deleteCmmnCode(cmmnCode);
	}

	/**
	 * 공통코드를 등록한다.
	 */
	@Override
	public void insertCmmnCode(CmmnCode cmmnCode) throws Exception {
    	cmmnCodeManageDAO.insertCmmnCode(cmmnCode);
	}

	/**
	 * 공통코드 상세항목을 조회한다.
	 */
	@Override
	public CmmnCode selectCmmnCodeDetail(CmmnCode cmmnCode) throws Exception {
    	CmmnCode ret = cmmnCodeManageDAO.selectCmmnCodeDetail(cmmnCode);
    	return ret;
	}

	/**
	 * 공통코드 목록을 조회한다.
	 */
	@Override
	public List<?> selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception {
        return cmmnCodeManageDAO.selectCmmnCodeList(searchVO);
	}

	/**
	 * 공통코드 총 갯수를 조회한다.
	 */
	@Override
	public int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO) throws Exception {
        return cmmnCodeManageDAO.selectCmmnCodeListTotCnt(searchVO);
	}

	/**
	 * 공통코드를 수정한다.
	 */
	@Override
	public void updateCmmnCode(CmmnCode cmmnCode) throws Exception {
		cmmnCodeManageDAO.updateCmmnCode(cmmnCode);
	}

}
