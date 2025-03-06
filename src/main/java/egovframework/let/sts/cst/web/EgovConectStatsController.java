package egovframework.let.sts.cst.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import egovframework.let.sts.com.StatsVO;
import egovframework.let.sts.cst.service.EgovConectStatsService;
import lombok.RequiredArgsConstructor;

/**
 * 접속 통계 검색 컨트롤러 클래스
 * 
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.19
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
@Controller
@RequiredArgsConstructor
public class EgovConectStatsController {

	/** EgovConectStatsService */
	private final EgovConectStatsService conectStatsService;

	/**
	 * 접속 통계를 조회한다
	 * 
	 * @param statsVO StatsVO
	 * @return String
	 * @exception Exception
	 */
	@GetMapping(value = "/sts/cst/selectConectStats.do")
	public String selectUserStats(@ModelAttribute("statsVO") StatsVO statsVO, ModelMap model) throws Exception {

		if (statsVO.getFromDate() != null && !"".equals(statsVO.getFromDate())) {

			List<?> conectStats = conectStatsService.selectConectStats(statsVO);

			// 1. 서비스별
			if ("SERVICE".equals(statsVO.getStatsKind())) {
				model.addAttribute("conectStats", conectStats);
				model.addAttribute("statsInfo", statsVO);
				// 2. 개인별
			} else {
				// 그래프에 표시될 이미지 길이를 결정한다.
				float iMaxUnit = 50.0f;
				for (int i = 0; i < conectStats.size(); i++) {
					StatsVO vo = (StatsVO) conectStats.get(i);
					int iCnt = vo.getStatsCo();
					if (iCnt > 10 && iCnt <= 100) {
						if (iMaxUnit > 5.0f) {
							iMaxUnit = 5.0f;
						}
					} else if (iCnt > 100 && iCnt <= 1000) {
						if (iMaxUnit > 0.5f) {
							iMaxUnit = 0.5f;
						}
					} else if (iCnt > 1000) {
						if (iMaxUnit > 0.05f) {
							iMaxUnit = 0.05f;
						}
					}
				}
				statsVO.setMaxUnit(iMaxUnit);
				model.addAttribute("conectStats", conectStats);
				model.addAttribute("statsInfo", statsVO);
			}
		}
		return "sts/cst/EgovConectStats";
	}
}
