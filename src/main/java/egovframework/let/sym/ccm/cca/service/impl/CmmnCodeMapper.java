package egovframework.let.sym.ccm.cca.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.ccm.cca.service.CmmnCode;
import egovframework.let.sym.ccm.cca.service.CmmnCodeVO;

/**
 * 공통코드 MyBatis 매퍼 인터페이스
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
 *   2025.05.28  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * </pre>
 */
@EgovMapper("cmmnCodeMapper")
public interface CmmnCodeMapper {

	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCode
	 */
	void deleteCmmnCode(CmmnCode cmmnCode);

	/**
	 * 공통코드를 등록한다.
	 * @param cmmnCode
	 */
	void insertCmmnCode(CmmnCode cmmnCode);

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCode
	 * @return CmmnCode(공통코드)
	 */
	CmmnCode selectCmmnCodeDetail(CmmnCode cmmnCode);

	/**
	 * 공통코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통코드 목록)
	 */
	List<?> selectCmmnCodeList(CmmnCodeVO searchVO);

	/**
	 * 공통코드 총 갯수를 조회한다.
	 * @param searchVO
	 * @return int(공통코드 총 갯수)
	 */
	int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO);

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCode
	 */
	void updateCmmnCode(CmmnCode cmmnCode);

}
