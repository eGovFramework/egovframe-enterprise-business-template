package egovframework.let.sym.log.lgm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.sym.log.lgm.service.SysLog;
import jakarta.annotation.Resource;

/**
 * 로그관리(시스템)를 위한 데이터 접근 클래스
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
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.lgm)
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("SysLogDAO")
public class SysLogDAO {

	@Resource(name = "sysLogMapper")
	private SysLogMapper sysLogMapper;

	public void logInsertSysLog(SysLog sysLog) throws Exception {
		sysLogMapper.logInsertSysLog(sysLog);
	}

	public void logInsertSysLogSummary() throws Exception {
		sysLogMapper.logInsertSysLogSummary();
		sysLogMapper.logDeleteSysLogSummary();
	}

	public SysLog selectSysLog(SysLog sysLog) throws Exception {
		return sysLogMapper.selectSysLog(sysLog);
	}

	public List<?> selectSysLogInf(SysLog sysLog) throws Exception {
		return sysLogMapper.selectSysLogInf(sysLog);
	}

	public int selectSysLogInfCnt(SysLog sysLog) throws Exception {
		return sysLogMapper.selectSysLogInfCnt(sysLog);
	}

}
