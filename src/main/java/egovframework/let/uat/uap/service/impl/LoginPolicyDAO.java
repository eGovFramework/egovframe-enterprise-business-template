package egovframework.let.uat.uap.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.uat.uap.service.LoginPolicy;
import egovframework.let.uat.uap.service.LoginPolicyVO;

/**
 * 로그인정책에 대한 DAO 클래스를 정의한다. 로그인정책에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다. 로그인정책의
 * 조회기능은 목록조회, 상세조회로 구분된다.
 * 
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j       최초 생성
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.10  이백행          이클립스 문제(Problems) 제거
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Repository
public class LoginPolicyDAO extends EgovAbstractMapper {

	/**
	 * 로그인정책 목록을 조회한다.
	 * 
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return List - 로그인정책 목록
	 */
	public List<LoginPolicyVO> selectLoginPolicyList(LoginPolicyVO loginPolicyVO) throws Exception {
		return selectList("loginPolicyDAO.selectLoginPolicyList", loginPolicyVO);
	}

	/**
	 * 로그인정책 목록 수를 조회한다.
	 * 
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return int
	 */
	public int selectLoginPolicyListTotCnt(LoginPolicyVO loginPolicyVO) throws Exception {
		return (Integer) selectOne("loginPolicyDAO.selectLoginPolicyListTotCnt", loginPolicyVO);
	}

	/**
	 * 로그인정책 목록의 상세정보를 조회한다.
	 * 
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return LoginPolicyVO - 로그인정책 VO
	 */
	public LoginPolicyVO selectLoginPolicy(LoginPolicyVO loginPolicyVO) throws Exception {
		return (LoginPolicyVO) selectOne("loginPolicyDAO.selectLoginPolicy", loginPolicyVO);
	}

	/**
	 * 로그인정책 정보를 신규로 등록한다.
	 * 
	 * @param loginPolicy - 로그인정책 model
	 */
	public void insertLoginPolicy(LoginPolicy loginPolicy) throws Exception {
		insert("loginPolicyDAO.insertLoginPolicy", loginPolicy);
	}

	/**
	 * 기 등록된 로그인정책 정보를 수정한다.
	 * 
	 * @param loginPolicy - 로그인정책 model
	 */
	public void updateLoginPolicy(LoginPolicy loginPolicy) throws Exception {
		update("loginPolicyDAO.updateLoginPolicy", loginPolicy);
	}

	/**
	 * 기 등록된 로그인정책 정보를 삭제한다.
	 * 
	 * @param loginPolicy - 로그인정책 model
	 */
	public void deleteLoginPolicy(LoginPolicy loginPolicy) throws Exception {
		delete("loginPolicyDAO.deleteLoginPolicy", loginPolicy);
	}

	/**
	 * 로그인정책에 대한 현재 반영되어 있는 결과를 조회한다.
	 * 
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return LoginPolicyVO - 로그인정책 VO
	 */
	public LoginPolicyVO selectLoginPolicyResult(LoginPolicyVO loginPolicyVO) throws Exception {
		return null;
	}
}
