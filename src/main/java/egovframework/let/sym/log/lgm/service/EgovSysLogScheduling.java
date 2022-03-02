package egovframework.let.sym.log.lgm.service;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

/**
 * 시스템 로그 요약을 위한 스케쥴링 클래스
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
@Service("egovSysLogScheduling")
public class EgovSysLogScheduling extends EgovAbstractServiceImpl {

	@Resource(name="EgovSysLogService")
	private EgovSysLogService sysLogService;

	/**
	 * 시스템 로그정보를 요약한다.
	 * 전날의 로그를 요약하여 입력하고, 6개월전의 로그를 삭제한다.
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void sysLogSummary() throws Exception {
		sysLogService.logInsertSysLogSummary();
	}

}
