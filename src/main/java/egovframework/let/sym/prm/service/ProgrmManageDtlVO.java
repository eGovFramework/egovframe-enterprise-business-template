package egovframework.let.sym.prm.service;

import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * 프로그램변경관리 처리를 위한 VO 클래스르를 정의한다
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
public class ProgrmManageDtlVO {

	/** 프로그램파일명 */
	@EgovNullCheck
	@Size(max=50)
	private String progrmFileNm;
	/** 요청번호 */
	private int rqesterNo;
	/** 요청제목 */
	@Size(max=200)
	private String rqesterSj;
	/** 요청자ID */
	@EgovNullCheck
	@Size(max=20)
	private String rqesterPersonId;
	/** 요청일자 */
	private String rqesterDe;
	/** 변경요청내용 */
	@Size(max=4000)
	private String changerqesterCn;
	/** 처리자ID */
	@EgovNullCheck
	@Size(max=20)
	private String opetrId;
	/** 처리상태코드 */
	private String processSttus;
	/** 처리일자 */
	private String processDe;
	/** 요청처리내용 */
	@Size(max=4000)
	private String rqesterProcessCn;

	/** 요청시작일자 */
	private String rqesterDeBegin;
	/** 요청종료일자 */
	private String rqesterDeEnd;

	/** 프로그램파일명 */
	private String tmp_progrmNm;
	/** 요청번호 */
	private int tmp_rqesterNo;
	/** tmp_Email */
	private String tmp_Email;

}
