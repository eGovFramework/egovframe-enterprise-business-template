package egovframework.let.sym.cal.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.sym.cal.service.Restde;
import egovframework.let.sym.cal.service.RestdeVO;
import jakarta.annotation.Resource;

/**
 *
 * 휴일에 대한 데이터 접근 클래스를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2025.05.28  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * </pre>
 */
@Repository("RestdeManageDAO")
public class RestdeManageDAO {

	@Resource(name = "restdeManageMapper")
	private RestdeManageMapper restdeManageMapper;

	/**
	 * 일반달력 팝업 정보를 조회한다.
	 * @param restde Restde
	 * @return List(일반달력 팝업 날짜정보)
	 * @throws Exception
	 */
	public List<Restde> selectNormalRestdePopup(Restde restde) throws Exception {
		return restdeManageMapper.selectNormalRestdePopup(restde);
	}

	/**
	 * 행정달력 팝업 정보를 조회한다.
	 * @param restde Restde
	 * @return List(행정달력 팝업 날짜정보)
	 * @throws Exception
	 */
	public List<Restde> selectAdministRestdePopup(Restde restde) throws Exception {
		return restdeManageMapper.selectAdministRestdePopup(restde);
	}

	/**
	 * 일반달력 일간 정보를 조회한다.
	 * @param restde Restde
	 * @return List(일반달력 일간 날짜정보)
	 * @throws Exception
	 */
	public List<Restde> selectNormalDayCal(Restde restde) throws Exception {
		return restdeManageMapper.selectNormalDayCal(restde);
	}

	/**
	 * 일반달력 일간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List(일반달력 일간 휴일정보)
	 * @throws Exception
	 */
	public List<Restde> selectNormalDayRestde(Restde restde) throws Exception {
		return restdeManageMapper.selectNormalDayRestde(restde);
	}

	/**
	 * 일반달력 월간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List(일반달력 월간 휴일정보)
	 * @throws Exception
	 */
	public List<Restde> selectNormalMonthRestde(Restde restde) throws Exception {
		return restdeManageMapper.selectNormalMonthRestde(restde);
	}

	/**
	 * 행정달력 일간 정보를 조회한다.
	 * @param restde Restde
	 * @return List(행정달력 일간 날짜정보)
	 * @throws Exception
	 */
	public List<Restde> selectAdministDayCal(Restde restde) throws Exception {
		return restdeManageMapper.selectAdministDayCal(restde);
	}

	/**
	 * 행정달력 일간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List(행정달력 일간 휴일정보)
	 * @throws Exception
	 */
	public List<Restde> selectAdministDayRestde(Restde restde) throws Exception {
		return restdeManageMapper.selectAdministDayRestde(restde);
	}

	/**
	 * 행정달력 월간 휴일을 조회한다.
	 * @param restde Restde
	 * @return List(행정달력 월간 휴일정보)
	 * @throws Exception
	 */
	public List<Restde> selectAdministMonthRestde(Restde restde) throws Exception {
		return restdeManageMapper.selectAdministMonthRestde(restde);
	}

	/**
	 * 휴일을 삭제한다.
	 * @param restde Restde
	 * @throws Exception
	 */
	public void deleteRestde(Restde restde) throws Exception {
		restdeManageMapper.deleteRestde(restde);
	}

	/**
	 * 휴일을 등록한다.
	 * @param restde Restde
	 * @throws Exception
	 */
	public void insertRestde(Restde restde) throws Exception {
		restdeManageMapper.insertRestde(restde);
	}

	/**
	 * 휴일 상세항목을 조회한다.
	 * @param restde Restde
	 * @return Restde(휴일)
	 * @throws Exception
	 */
	public Restde selectRestdeDetail(Restde restde) throws Exception {
		return restdeManageMapper.selectRestdeDetail(restde);
	}

	/**
	 * 휴일 목록을 조회한다.
	 * @param searchVO RestdeVO
	 * @return List(휴일 목록)
	 * @throws Exception
	 */
	public List<Restde> selectRestdeList(RestdeVO searchVO) throws Exception {
		return restdeManageMapper.selectRestdeList(searchVO);
	}

	/**
	 * 휴일 총 갯수를 조회한다.
	 * @param searchVO RestdeVO
	 * @return int(휴일 총 갯수)
	 * @throws Exception
	 */
	public int selectRestdeListTotCnt(RestdeVO searchVO) throws Exception {
		return restdeManageMapper.selectRestdeListTotCnt(searchVO);
	}

	/**
	 * 휴일을 수정한다.
	 * @param restde Restde
	 * @throws Exception
	 */
	public void updateRestde(Restde restde) throws Exception {
		restdeManageMapper.updateRestde(restde);
	}

}
