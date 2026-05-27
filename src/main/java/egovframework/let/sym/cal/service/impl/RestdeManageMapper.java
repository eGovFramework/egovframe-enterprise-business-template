package egovframework.let.sym.cal.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.cal.service.Restde;
import egovframework.let.sym.cal.service.RestdeVO;

/**
 * 휴일 관리에 대한 Mapper 인터페이스를 정의한다.
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 2.0
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
@EgovMapper("restdeManageMapper")
public interface RestdeManageMapper {

	/**
	 * 일반달력 팝업 정보를 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectNormalRestdePopup(Restde restde) throws Exception;

	/**
	 * 행정달력 팝업 정보를 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectAdministRestdePopup(Restde restde) throws Exception;

	/**
	 * 일반달력 일간 정보를 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectNormalDayCal(Restde restde) throws Exception;

	/**
	 * 일반달력 일간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectNormalDayRestde(Restde restde) throws Exception;

	/**
	 * 일반달력 월간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectNormalMonthRestde(Restde restde) throws Exception;

	/**
	 * 행정달력 일간 정보를 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectAdministDayCal(Restde restde) throws Exception;

	/**
	 * 행정달력 일간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectAdministDayRestde(Restde restde) throws Exception;

	/**
	 * 행정달력 월간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectAdministMonthRestde(Restde restde) throws Exception;

	/**
	 * 휴일을 삭제한다.
	 * @param restde Restde
	 * @exception Exception
	 */
	void deleteRestde(Restde restde) throws Exception;

	/**
	 * 휴일을 등록한다.
	 * @param restde Restde
	 * @exception Exception
	 */
	void insertRestde(Restde restde) throws Exception;

	/**
	 * 휴일 상세항목을 조회한다.
	 * @param restde Restde
	 * @return Restde
	 * @exception Exception
	 */
	Restde selectRestdeDetail(Restde restde) throws Exception;

	/**
	 * 휴일 목록을 조회한다.
	 * @param searchVO RestdeVO
	 * @return List
	 * @exception Exception
	 */
	List<Restde> selectRestdeList(RestdeVO searchVO) throws Exception;

	/**
	 * 휴일 총 갯수를 조회한다.
	 * @param searchVO RestdeVO
	 * @return int
	 * @exception Exception
	 */
	int selectRestdeListTotCnt(RestdeVO searchVO) throws Exception;

	/**
	 * 휴일을 수정한다.
	 * @param restde Restde
	 * @exception Exception
	 */
	void updateRestde(Restde restde) throws Exception;

}
