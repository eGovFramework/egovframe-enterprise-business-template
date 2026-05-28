package egovframework.let.sym.ccm.ccc.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.ccm.ccc.service.CmmnClCode;
import egovframework.let.sym.ccm.ccc.service.CmmnClCodeVO;

/**
 *
 * 공통분류코드에 대한 Mapper 인터페이스를 정의한다
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
@EgovMapper
public interface CmmnClCodeManageMapper {

	/**
	 * 공통분류코드를 삭제한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	void deleteCmmnClCode(CmmnClCode cmmnClCode) throws Exception;

	/**
	 * 공통분류코드를 등록한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	void insertCmmnClCode(CmmnClCode cmmnClCode) throws Exception;

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 * @param cmmnClCode
	 * @return CmmnClCode(공통분류코드)
	 */
	CmmnClCode selectCmmnClCodeDetail(CmmnClCode cmmnClCode);

	/**
	 * 공통분류코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통분류코드 목록)
	 * @throws Exception
	 */
	List<?> selectCmmnClCodeList(CmmnClCodeVO searchVO) throws Exception;

	/**
	 * 공통분류코드 총 갯수를 조회한다.
	 * @param searchVO
	 * @return int(공통분류코드 총 갯수)
	 * @throws Exception
	 */
	int selectCmmnClCodeListTotCnt(CmmnClCodeVO searchVO) throws Exception;

	/**
	 * 공통분류코드를 수정한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	void updateCmmnClCode(CmmnClCode cmmnClCode) throws Exception;

}
