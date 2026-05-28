package egovframework.let.sym.log.clg.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.sym.log.clg.service.LoginLog;
import jakarta.annotation.Resource;

/**
 * 시스템 로그 관리를 위한 데이터 접근 클래스
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
@Repository("loginLogDAO")
public class LoginLogDAO {

	@Resource(name = "loginLogMapper")
	private LoginLogMapper loginLogMapper;

	public void logInsertLoginLog(LoginLog loginLog) throws Exception {
		loginLogMapper.logInsertLoginLog(loginLog);
	}

	public LoginLog selectLoginLog(LoginLog loginLog) throws Exception {
		return loginLogMapper.selectLoginLog(loginLog);
	}

	public List<?> selectLoginLogInf(LoginLog loginLog) throws Exception {
		return loginLogMapper.selectLoginLogInf(loginLog);
	}

	public int selectLoginLogInfCnt(LoginLog loginLog) throws Exception {
		return loginLogMapper.selectLoginLogInfCnt(loginLog);
	}

}
