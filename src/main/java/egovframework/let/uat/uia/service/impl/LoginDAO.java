package egovframework.let.uat.uia.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.LoginVO;
import jakarta.annotation.Resource;

/**
 * 일반 로그인을 처리하는 DAO 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  </pre>
 */
@Repository("loginDAO")
public class LoginDAO {

	@Resource(name = "loginMapper")
	private LoginMapper loginMapper;

	public LoginVO actionLogin(LoginVO vo) throws Exception {
		return loginMapper.actionLogin(vo);
	}

	public LoginVO searchId(LoginVO vo) throws Exception {
		return loginMapper.searchId(vo);
	}

	public LoginVO searchPassword(LoginVO vo) throws Exception {
		return loginMapper.searchPassword(vo);
	}

	public void updatePassword(LoginVO vo) throws Exception {
		loginMapper.updatePassword(vo);
	}

}
