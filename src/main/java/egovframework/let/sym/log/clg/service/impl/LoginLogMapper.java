package egovframework.let.sym.log.clg.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.log.clg.service.LoginLog;

/**
 * 시스템 로그 관리를 위한 Mapper 인터페이스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
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
 *
 * </pre>
 */
@EgovMapper
public interface LoginLogMapper {

	void logInsertLoginLog(LoginLog loginLog) throws Exception;

	LoginLog selectLoginLog(LoginLog loginLog) throws Exception;

	List<?> selectLoginLogInf(LoginLog loginLog) throws Exception;

	int selectLoginLogInfCnt(LoginLog loginLog) throws Exception;

}
