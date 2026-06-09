package egovframework.let.uat.uap.service;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * 로그인정책에 대한 VO 클래스를 정의한다.
 * 로그인정책정보의 목록 항목을 관리한다.
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
@Getter
@Setter
public class LoginPolicyVO extends LoginPolicy {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 로그인 정책 목록
	 */
	List<LoginPolicyVO> loginPolicyList;
	/**
	 * 삭제 여부
	 */
	String[] delYn;

}
