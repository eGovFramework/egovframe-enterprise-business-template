package egovframework.let.uss.ion.uas.service.impl;

import java.util.List;

import egovframework.let.uss.ion.uas.service.UserAbsnce;
import egovframework.let.uss.ion.uas.service.UserAbsnceVO;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import org.springframework.stereotype.Repository;
/**
 * 사용자부재에 대한 DAO 클래스를 정의한다.
 * 사용자부재에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * 사용자부재의 조회기능은 목록조회, 상세조회로 구분된다.
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j        최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("userAbsnceDAO")
public class UserAbsnceDAO extends EgovAbstractMapper {

	/**
	 * 사용자부재정보를 관리하기 위해 등록된 사용자부재 목록을 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return List - 사용자부재 목록
	 */
	@SuppressWarnings("unchecked")
	public List<UserAbsnceVO> selectUserAbsnceList(UserAbsnceVO userAbsnceVO) throws Exception {
		return (List<UserAbsnceVO>) list("userAbsnceDAO.selectUserAbsnceList", userAbsnceVO);
	}

    /**
	 * 사용자부재목록 총 갯수를 조회한다.
	 * @param mainImageVO - 사용자부재 VO
	 * @return int
	 * @exception Exception
	 */
    public int selectUserAbsnceListTotCnt(UserAbsnceVO userAbsnceVO) throws Exception {
        return (Integer)selectOne("userAbsnceDAO.selectUserAbsnceListTotCnt", userAbsnceVO);
    }

	/**
	 * 등록된 사용자부재 상세정보를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO selectUserAbsnce(UserAbsnceVO userAbsnceVO) throws Exception {
		return (UserAbsnceVO) selectOne("userAbsnceDAO.selectUserAbsnce", userAbsnceVO);
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param userAbsnce - 사용자부재 model
	 */
	public void insertUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		insert("userAbsnceDAO.insertUserAbsnce", userAbsnce);
	}

	/**
	 * 기 등록된 사용자부재정보를 수정한다.
	 * @param userAbsnce - 사용자부재 model
	 */
	public void updateUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		update("userAbsnceDAO.updateUserAbsnce", userAbsnce);
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param userAbsnce - 사용자부재 model
	 */
	public void deleteUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		delete("userAbsnceDAO.deleteUserAbsnce", userAbsnce);
	}

	/**
	 * 사용자부재정보가 특정화면에 반영된 결과를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO selectUserAbsnceResult(UserAbsnceVO userAbsnceVO) throws Exception {
		return null;
	}
}
