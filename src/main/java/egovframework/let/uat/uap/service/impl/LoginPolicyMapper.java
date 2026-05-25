package egovframework.let.uat.uap.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uat.uap.service.LoginPolicy;
import egovframework.let.uat.uap.service.LoginPolicyVO;

/**
 * 로그인정책에 대한 Mapper 인터페이스를 정의한다.
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
@EgovMapper("loginPolicyMapper")
public interface LoginPolicyMapper {

	/**
	 * 로그인정책 목록을 조회한다.
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return List - 로그인정책 목록
	 */
	List<LoginPolicyVO> selectLoginPolicyList(LoginPolicyVO loginPolicyVO) throws Exception;

	/**
	 * 로그인정책 목록 수를 조회한다.
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return int
	 */
	int selectLoginPolicyListTotCnt(LoginPolicyVO loginPolicyVO) throws Exception;

	/**
	 * 로그인정책 목록의 상세정보를 조회한다.
	 * @param loginPolicyVO - 로그인정책 VO
	 * @return LoginPolicyVO - 로그인정책 VO
	 */
	LoginPolicyVO selectLoginPolicy(LoginPolicyVO loginPolicyVO);

	/**
	 * 로그인정책 정보를 신규로 등록한다.
	 * @param loginPolicy - 로그인정책 model
	 */
	void insertLoginPolicy(LoginPolicy loginPolicy) throws Exception;

	/**
	 * 기 등록된 로그인정책 정보를 수정한다.
	 * @param loginPolicy - 로그인정책 model
	 */
	void updateLoginPolicy(LoginPolicy loginPolicy) throws Exception;

	/**
	 * 기 등록된 로그인정책 정보를 삭제한다.
	 * @param loginPolicy - 로그인정책 model
	 */
	void deleteLoginPolicy(LoginPolicy loginPolicy) throws Exception;

}
