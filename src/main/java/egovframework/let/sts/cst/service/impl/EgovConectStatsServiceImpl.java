package egovframework.let.sts.cst.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.sts.com.StatsVO;
import egovframework.let.sts.cst.service.EgovConectStatsService;
import lombok.RequiredArgsConstructor;

/**
 * 접속 통계 검색 비즈니스 구현 클래스
 * 
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.12
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *   2009.03.19  박지욱          최초 생성
 *   2011.06.30  이기하          패키지 분리(sts -> sts.cst)
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Service
@RequiredArgsConstructor
public class EgovConectStatsServiceImpl extends EgovAbstractServiceImpl implements EgovConectStatsService {

	private final ConectStatsDAO conectStatsDAO;

	/**
	 * 접속 통계를 조회한다
	 * 
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	@Override
	public List<?> selectConectStats(StatsVO vo) throws Exception {
		return conectStatsDAO.selectConectStats(vo);
	}
}
