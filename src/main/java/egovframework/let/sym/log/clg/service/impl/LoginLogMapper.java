package egovframework.let.sym.log.clg.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.log.clg.service.LoginLog;

/**
 * 접속로그 관리에 대한 Mapper 인터페이스를 정의한다.
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
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.clg)
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2025.05.25  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * </pre>
 */
@EgovMapper("loginLogMapper")
public interface LoginLogMapper {

	/**
	 * 접속로그를 기록한다.
	 * @param loginLog LoginLog
	 * @exception Exception
	 */
	void logInsertLoginLog(LoginLog loginLog) throws Exception;

	/**
	 * 접속로그를 조회한다.
	 * @param loginLog LoginLog
	 * @return LoginLog
	 * @exception Exception
	 */
	LoginLog selectLoginLog(LoginLog loginLog) throws Exception;

	/**
	 * 접속로그 목록을 조회한다.
	 * @param loginLog LoginLog
	 * @return List
	 * @exception Exception
	 */
	List<LoginLog> selectLoginLogInf(LoginLog loginLog) throws Exception;

	/**
	 * 접속로그 목록의 총 건수를 조회한다.
	 * @param loginLog LoginLog
	 * @return int
	 * @exception Exception
	 */
	int selectLoginLogInfCnt(LoginLog loginLog) throws Exception;

}
