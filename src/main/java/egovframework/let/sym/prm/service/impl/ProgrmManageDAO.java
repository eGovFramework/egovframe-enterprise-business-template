package egovframework.let.sym.prm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.prm.service.ProgrmManageDtlVO;
import egovframework.let.sym.prm.service.ProgrmManageVO;
import jakarta.annotation.Resource;

/**
 * 프로그램 목록관리및 프로그램변경관리에 대한 DAO 클래스를 정의한다.
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
@Repository("progrmManageDAO")
public class ProgrmManageDAO {

	@Resource(name = "progrmManageMapper")
	private ProgrmManageMapper progrmManageMapper;

	public List<?> selectProgrmList(ComDefaultVO vo) throws Exception {
		return progrmManageMapper.selectProgrmList_D(vo);
	}

	public int selectProgrmListTotCnt(ComDefaultVO vo) {
		return progrmManageMapper.selectProgrmListTotCnt_S(vo);
	}

	public ProgrmManageVO selectProgrm(ComDefaultVO vo) throws Exception {
		return progrmManageMapper.selectProgrm_D(vo);
	}

	public void insertProgrm(ProgrmManageVO vo) {
		progrmManageMapper.insertProgrm_S(vo);
	}

	public void updateProgrm(ProgrmManageVO vo) {
		progrmManageMapper.updateProgrm_S(vo);
	}

	public void deleteProgrm(ProgrmManageVO vo) {
		progrmManageMapper.deleteProgrm_S(vo);
	}

	public int selectProgrmNMTotCnt(ComDefaultVO vo) throws Exception {
		return progrmManageMapper.selectProgrmNMTotCnt(vo);
	}

	public List<?> selectProgrmChangeRequstList(ComDefaultVO vo) throws Exception {
		return progrmManageMapper.selectProgrmChangeRequstList_D(vo);
	}

	public int selectProgrmChangeRequstListTotCnt(ComDefaultVO vo) {
		return progrmManageMapper.selectProgrmChangeRequstListTotCnt_S(vo);
	}

	public ProgrmManageDtlVO selectProgrmChangeRequst(ProgrmManageDtlVO vo) throws Exception {
		return progrmManageMapper.selectProgrmChangeRequst_D(vo);
	}

	public void insertProgrmChangeRequst(ProgrmManageDtlVO vo) {
		progrmManageMapper.insertProgrmChangeRequst_S(vo);
	}

	public void updateProgrmChangeRequst(ProgrmManageDtlVO vo) {
		progrmManageMapper.updateProgrmChangeRequst_S(vo);
	}

	public void deleteProgrmChangeRequst(ProgrmManageDtlVO vo) {
		progrmManageMapper.deleteProgrmChangeRequst_S(vo);
	}

	public ProgrmManageDtlVO selectProgrmChangeRequstNo(ProgrmManageDtlVO vo) {
		return progrmManageMapper.selectProgrmChangeRequstNo_D(vo);
	}

	public List<?> selectChangeRequstProcessList(ComDefaultVO vo) throws Exception {
		return progrmManageMapper.selectChangeRequstProcessList_D(vo);
	}

	public int selectChangeRequstListProcessTotCnt(ComDefaultVO vo) {
		return progrmManageMapper.selectChangeRequstProcessListTotCnt_S(vo);
	}

	public void updateProgrmChangeRequstProcess(ProgrmManageDtlVO vo) {
		progrmManageMapper.updateProgrmChangeRequstProcess_S(vo);
	}

	public boolean deleteAllProgrm() {
		ProgrmManageVO vo = new ProgrmManageVO();
		progrmManageMapper.deleteAllProgrm(vo);
		return true;
	}

	public boolean deleteAllProgrmDtls() {
		ProgrmManageDtlVO vo = new ProgrmManageDtlVO();
		progrmManageMapper.deleteAllProgrmDtls(vo);
		return true;
	}

	public int selectProgrmListTotCnt() {
		ProgrmManageVO vo = new ProgrmManageVO();
		return progrmManageMapper.selectProgrmListTotCnt(vo);
	}

	public ProgrmManageDtlVO selectRqesterEmail(ProgrmManageDtlVO vo) {
		return progrmManageMapper.selectRqesterEmail(vo);
	}

}
