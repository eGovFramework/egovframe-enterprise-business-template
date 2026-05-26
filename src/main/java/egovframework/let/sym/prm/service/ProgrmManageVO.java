package egovframework.let.sym.prm.service;

import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * 프로그램목록 처리를 위한 VO 클래스르를 정의한다
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Getter
@Setter
public class ProgrmManageVO {

	/** 프로그램파일명 */
	@EgovNullCheck
	@Size(max=50)
	private String progrmFileNm;
	/** 프로그램저장경로 */
	@EgovNullCheck
	@Size(max=60)
	private String progrmStrePath;
	/** 프로그램한글명 */
	@EgovNullCheck
	@Size(max=50)
	private String progrmKoreanNm;
	/** URL */
	@EgovNullCheck
	@Size(max=60)
	private String URL;
	/** 프로그램설명 */
	private String progrmDc;

}
