package egovframework.let.uat.uap.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.uat.uap.service.LoginPolicy;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import jakarta.annotation.Resource;

/**
 * 로그인정책에 대한 DAO 클래스를 정의한다.
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
@Repository("loginPolicyDAO")
public class LoginPolicyDAO {

	@Resource(name = "loginPolicyMapper")
	private LoginPolicyMapper loginPolicyMapper;

	public List<LoginPolicyVO> selectLoginPolicyList(LoginPolicyVO loginPolicyVO) throws Exception {
		return loginPolicyMapper.selectLoginPolicyList(loginPolicyVO);
	}

	public int selectLoginPolicyListTotCnt(LoginPolicyVO loginPolicyVO) throws Exception {
		return loginPolicyMapper.selectLoginPolicyListTotCnt(loginPolicyVO);
	}

	public LoginPolicyVO selectLoginPolicy(LoginPolicyVO loginPolicyVO) {
		return loginPolicyMapper.selectLoginPolicy(loginPolicyVO);
	}

	public void insertLoginPolicy(LoginPolicy loginPolicy) throws Exception {
		loginPolicyMapper.insertLoginPolicy(loginPolicy);
	}

	public void updateLoginPolicy(LoginPolicy loginPolicy) throws Exception {
		loginPolicyMapper.updateLoginPolicy(loginPolicy);
	}

	public void deleteLoginPolicy(LoginPolicy loginPolicy) throws Exception {
		loginPolicyMapper.deleteLoginPolicy(loginPolicy);
	}

	public LoginPolicyVO selectLoginPolicyResult(LoginPolicyVO loginPolicyVO) throws Exception {
		return null;
	}

}
