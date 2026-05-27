package egovframework.let.sym.log.lgm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.log.lgm.service.SysLog;

/**
 * 시스템 로그 관리에 대한 Mapper 인터페이스를 정의한다.
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 2.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이삼섭          최초 생성
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.lgm)
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2025.05.28  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * </pre>
 */
@EgovMapper("sysLogMapper")
public interface SysLogMapper {

	/**
	 * 시스템 로그정보를 생성한다.
	 * @param sysLog SysLog
	 * @throws Exception
	 */
	void logInsertSysLog(SysLog sysLog) throws Exception;

	/**
	 * 시스템 로그정보를 요약한다.
	 * @throws Exception
	 */
	void logInsertSysLogSummary() throws Exception;

	/**
	 * 시스템 로그 6개월전 로그를 삭제한다.
	 * @throws Exception
	 */
	void logDeleteSysLogSummary() throws Exception;

	/**
	 * 시스템 로그정보를 조회한다.
	 * @param sysLog SysLog
	 * @return SysLog
	 * @throws Exception
	 */
	SysLog selectSysLog(SysLog sysLog) throws Exception;

	/**
	 * 시스템 로그정보 목록을 조회한다.
	 * @param sysLog SysLog
	 * @return List
	 * @throws Exception
	 */
	List<SysLog> selectSysLogInf(SysLog sysLog) throws Exception;

	/**
	 * 시스템 로그정보 목록의 총 건수를 조회한다.
	 * @param sysLog SysLog
	 * @return int
	 * @throws Exception
	 */
	int selectSysLogInfCnt(SysLog sysLog) throws Exception;

}
