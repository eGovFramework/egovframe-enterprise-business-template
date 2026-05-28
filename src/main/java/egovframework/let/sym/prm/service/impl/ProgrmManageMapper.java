package egovframework.let.sym.prm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.prm.service.ProgrmManageDtlVO;
import egovframework.let.sym.prm.service.ProgrmManageVO;

/**
 * 프로그램 목록관리 및 프로그램변경관리에 대한 Mapper 인터페이스를 정의한다.
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
@EgovMapper
public interface ProgrmManageMapper {

	List<?> selectProgrmList_D(ComDefaultVO vo) throws Exception;

	int selectProgrmListTotCnt_S(ComDefaultVO vo);

	int selectProgrmNMTotCnt(ComDefaultVO vo) throws Exception;

	ProgrmManageVO selectProgrm_D(ComDefaultVO vo) throws Exception;

	void insertProgrm_S(ProgrmManageVO vo);

	void updateProgrm_S(ProgrmManageVO vo);

	void deleteProgrm_S(ProgrmManageVO vo);

	void deleteAllProgrm(ProgrmManageVO vo);

	int selectProgrmListTotCnt(ProgrmManageVO vo);

	List<?> selectProgrmChangeRequstList_D(ComDefaultVO vo) throws Exception;

	int selectProgrmChangeRequstListTotCnt_S(ComDefaultVO vo);

	ProgrmManageDtlVO selectProgrmChangeRequstNo_D(ProgrmManageDtlVO vo);

	ProgrmManageDtlVO selectProgrmChangeRequst_D(ProgrmManageDtlVO vo) throws Exception;

	void insertProgrmChangeRequst_S(ProgrmManageDtlVO vo);

	void updateProgrmChangeRequst_S(ProgrmManageDtlVO vo);

	void deleteProgrmChangeRequst_S(ProgrmManageDtlVO vo);

	void updateProgrmChangeRequstProcess_S(ProgrmManageDtlVO vo);

	List<?> selectChangeRequstProcessList_D(ComDefaultVO vo) throws Exception;

	int selectChangeRequstProcessListTotCnt_S(ComDefaultVO vo);

	void deleteAllProgrmDtls(ProgrmManageDtlVO vo);

	ProgrmManageDtlVO selectRqesterEmail(ProgrmManageDtlVO vo);

}
