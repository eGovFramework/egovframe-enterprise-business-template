package egovframework.let.sym.ccm.cca.service.impl;

import java.util.List;

import egovframework.let.sym.ccm.cca.service.CmmnCode;
import egovframework.let.sym.ccm.cca.service.CmmnCodeVO;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 *
 * 공통코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("CmmnCodeManageDAO")
public class CmmnCodeManageDAO extends EgovAbstractMapper {

	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void deleteCmmnCode(CmmnCode cmmnCode) throws Exception {
		delete("CmmnCodeManageDAO.deleteCmmnCode", cmmnCode);
	}


	/**
	 * 공통코드를 등록한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void insertCmmnCode(CmmnCode cmmnCode) throws Exception {
        insert("CmmnCodeManageDAO.insertCmmnCode", cmmnCode);
	}

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCode
	 * @return CmmnCode(공통코드)
	 */
	public CmmnCode selectCmmnCodeDetail(CmmnCode cmmnCode) throws Exception {
		return (CmmnCode)selectOne("CmmnCodeManageDAO.selectCmmnCodeDetail", cmmnCode);
	}


    /**
	 * 공통코드 목록을 조회한다.
     * @param searchVO
     * @return List(공통코드 목록)
     * @throws Exception
     */
	public List<?> selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception {
        return list("CmmnCodeManageDAO.selectCmmnCodeList", searchVO);
    }

    /**
	 * 공통코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통코드 총 갯수)
     */
    public int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO) throws Exception {
        return (Integer)selectOne("CmmnCodeManageDAO.selectCmmnCodeListTotCnt", searchVO);
    }

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void updateCmmnCode(CmmnCode cmmnCode) throws Exception {
		update("CmmnCodeManageDAO.updateCmmnCode", cmmnCode);
	}

}
