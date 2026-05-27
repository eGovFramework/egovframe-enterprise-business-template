package egovframework.let.sec.rmt.service;

import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;
import jakarta.validation.constraints.Size;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

/**
 * 롤관리에 대한 model 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */

@Getter
@Setter
public class RoleManage extends ComDefaultVO {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 롤 관리
	 */
	private RoleManage roleManage;
	/**
	 * 롤코드
	 */
	private String roleCode;
	/**
	 * 롤명
	 */
	@EgovNullCheck
	@Size(max=50)
	private String roleNm;
	/**
	 * 롤패턴
	 */
	@EgovNullCheck
	@Size(max=50)
	private String rolePtn;
	/**
	 * 롤 설명
	 */
	@Size(max=50)
	private String roleDc;
	/**
	 * 롤 타입
	 */
	@EgovNullCheck
	private String roleTyp;
	/**
	 * 롤 Sort
	 */
	@EgovNullCheck
	@Size(max=50)
	private String roleSort;
	/**
	 * 롤 등록일시
	 */
	private String roleCreatDe;
	/**
	 * 권한 코드
	 */
	private String authorCode;

}
