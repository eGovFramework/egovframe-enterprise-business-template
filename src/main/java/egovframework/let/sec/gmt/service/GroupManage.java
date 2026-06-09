package egovframework.let.sec.gmt.service;

import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;
import jakarta.validation.constraints.Size;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

/**
 * 그룹관리에 대한 model 클래스를 정의한다.
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
public class GroupManage extends ComDefaultVO {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 그룹 관리
	 */
	private GroupManage groupManage;
	/**
	 * 그룹 ID
	 */
	private String groupId;
	/**
	 * 그룹명
	 */
	@EgovNullCheck
	@Size(max=50)
	private String groupNm;
	/**
	 * 그룹등록일시
	 */
	private String groupCreatDe;
	/**
	 * 그룹설명
	 */
	@Size(max=50)
	private String groupDc;
	
}