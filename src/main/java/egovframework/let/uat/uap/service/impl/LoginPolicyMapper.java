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
@EgovMapper
public interface LoginPolicyMapper {

	List<LoginPolicyVO> selectLoginPolicyList(LoginPolicyVO loginPolicyVO) throws Exception;

	int selectLoginPolicyListTotCnt(LoginPolicyVO loginPolicyVO) throws Exception;

	LoginPolicyVO selectLoginPolicy(LoginPolicyVO loginPolicyVO);

	void insertLoginPolicy(LoginPolicy loginPolicy) throws Exception;

	void updateLoginPolicy(LoginPolicy loginPolicy) throws Exception;

	void deleteLoginPolicy(LoginPolicy loginPolicy) throws Exception;

}
