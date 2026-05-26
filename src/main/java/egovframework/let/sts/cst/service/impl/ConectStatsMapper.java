package egovframework.let.sts.cst.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sts.com.StatsVO;

/**
 * 접속 통계 조회에 대한 Mapper 인터페이스를 정의한다.
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.12
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  박지욱          최초 생성
 *  2011.06.30  이기하          패키지 분리(sts -> sts.cst)
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *  2026.05.27  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 *  </pre>
 */
@EgovMapper("conectStatsMapper")
public interface ConectStatsMapper {

	/**
	 * 접속 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	List<StatsVO> selectConectStats(StatsVO vo) throws Exception;

}
