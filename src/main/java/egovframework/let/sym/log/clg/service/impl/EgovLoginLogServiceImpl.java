package egovframework.let.sym.log.clg.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Service;

import egovframework.let.sym.log.clg.service.EgovLoginLogService;
import egovframework.let.sym.log.clg.service.LoginLog;
import lombok.RequiredArgsConstructor;

/**
 * 접속로그 관리를 위한 서비스 구현 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이삼섭          최초 생성
 *   2011.07.01  이기하          패키지 분리(stm.log -> sym.log.clg)
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Service
@RequiredArgsConstructor
public class EgovLoginLogServiceImpl extends EgovAbstractServiceImpl implements EgovLoginLogService {

	private final LoginLogDAO loginLogDAO;

	/** ID Generation */
	private final EgovIdGnrService egovLoginLogIdGnrService;

	/**
	 * 접속로그를 기록한다.
	 * 
	 * @param LoginLog
	 */
	@Override
	public void logInsertLoginLog(LoginLog loinLog) throws Exception {
		// TODO Auto-generated method stub
		String logId = egovLoginLogIdGnrService.getNextStringId();
		loinLog.setLogId(logId);

		loginLogDAO.logInsertLoginLog(loinLog);

	}

	/**
	 * 접속로그를 조회한다.
	 * 
	 * @param loginLog
	 * @return loginLog
	 * @throws Exception
	 */
	@Override
	public LoginLog selectLoginLog(LoginLog loginLog) throws Exception {

		return loginLogDAO.selectLoginLog(loginLog);
	}

	/**
	 * 접속로그 목록을 조회한다.
	 * 
	 * @param LoginLog
	 */
	@Override
	public Map<String, Object> selectLoginLogInf(LoginLog loinLog) throws Exception {
		// TODO Auto-generated method stub

		Map<String, Object> _map = new HashMap<String, Object>();
		_map.put("resultList", loginLogDAO.selectLoginLogInf(loinLog));
		_map.put("resultCnt", Integer.toString(loginLogDAO.selectLoginLogInfCnt(loinLog)));

		return _map;
	}

}
