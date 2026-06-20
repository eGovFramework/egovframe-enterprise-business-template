package egovframework.let.sym.prm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.prm.service.ProgrmManageDtlVO;
import egovframework.let.sym.prm.service.ProgrmManageVO;
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
 *   2026.06.20  이백행           [2026년 컨트리뷰션] 불필요한 예외(throws Exception) 제거
 *
 * </pre>
 */

@Repository("progrmManageDAO")
public class ProgrmManageDAO extends EgovAbstractMapper {

	/**
	 * 프로그램 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 */

	public List<?> selectProgrmList(ComDefaultVO vo) {
		return selectList("progrmManageDAO.selectProgrmList_D", vo);
	}

    /**
	 * 프로그램목록 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 */
    public int selectProgrmListTotCnt(ComDefaultVO vo) {
        return (Integer)selectOne("progrmManageDAO.selectProgrmListTotCnt_S", vo);
    }

	/**
	 * 프로그램 기본정보를 조회
	 * @param vo ComDefaultVO
	 * @return ProgrmManageVO
	 */
	public ProgrmManageVO selectProgrm(ComDefaultVO vo) {
		return (ProgrmManageVO)selectOne("progrmManageDAO.selectProgrm_D", vo);
	}

	/**
	 * 프로그램 기본정보 및 URL을 등록
	 * @param vo ProgrmManageVO
	 */
	public void insertProgrm(ProgrmManageVO vo){
		insert("progrmManageDAO.insertProgrm_S", vo);
	}

	/**
	 * 프로그램 기본정보 및 URL을 수정
	 * @param vo ProgrmManageVO
	 */
	public void updateProgrm(ProgrmManageVO vo){
		update("progrmManageDAO.updateProgrm_S", vo);
	}

	/**
	 * 프로그램 기본정보 및 URL을 삭제
	 * @param vo ProgrmManageVO
	 */
	public void deleteProgrm(ProgrmManageVO vo){
		delete("progrmManageDAO.deleteProgrm_S", vo);
	}

	/**
	 * 프로그램 파일 존재여부를 조회
	 * @param vo ProgrmManageVO
	 * @return int
	 */
	public int selectProgrmNMTotCnt(ComDefaultVO vo) {
		return (Integer)selectOne("progrmManageDAO.selectProgrmNMTotCnt", vo);
	}


	/**
	 * 프로그램변경요청 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 */

	public List<?> selectProgrmChangeRequstList(ComDefaultVO vo) {
		return selectList("progrmManageDAO.selectProgrmChangeRequstList_D", vo);
	}

    /**
	 * 프로그램변경요청 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return  int
	 */
    public int selectProgrmChangeRequstListTotCnt(ComDefaultVO vo) {
        return (Integer)selectOne("progrmManageDAO.selectProgrmChangeRequstListTotCnt_S", vo);
    }

	/**
	 * 프로그램변경요청 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 */
	public ProgrmManageDtlVO selectProgrmChangeRequst(ProgrmManageDtlVO vo) {
		return (ProgrmManageDtlVO)selectOne("progrmManageDAO.selectProgrmChangeRequst_D", vo);
	}

	/**
	 * 프로그램변경요청을 등록
	 * @param vo ProgrmManageDtlVO
	 */
	public void insertProgrmChangeRequst(ProgrmManageDtlVO vo){
		insert("progrmManageDAO.insertProgrmChangeRequst_S", vo);
	}

	/**
	 * 프로그램변경요청을 수정
	 * @param vo ProgrmManageDtlVO
	 */
	public void updateProgrmChangeRequst(ProgrmManageDtlVO vo){
		update("progrmManageDAO.updateProgrmChangeRequst_S", vo);
	}

	/**
	 * 프로그램변경요청을 삭제
	 * @param vo ProgrmManageDtlVO
	 */
	public void deleteProgrmChangeRequst(ProgrmManageDtlVO vo){
		delete("progrmManageDAO.deleteProgrmChangeRequst_S", vo);
	}

	/**
	 * 프로그램변경요청 요청번호MAX 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 */
	public ProgrmManageDtlVO selectProgrmChangeRequstNo(ProgrmManageDtlVO vo){
		return (ProgrmManageDtlVO)selectOne("progrmManageDAO.selectProgrmChangeRequstNo_D", vo);
	}

	/**
	 * 프로그램변경요청 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 */
	public List<?> selectChangeRequstProcessList(ComDefaultVO vo) {
		return selectList("progrmManageDAO.selectChangeRequstProcessList_D", vo);
	}

    /**
	 * 프로그램변경요청 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 */
    public int selectChangeRequstListProcessTotCnt(ComDefaultVO vo) {
        return (Integer)selectOne("progrmManageDAO.selectChangeRequstProcessListTotCnt_S", vo);
    }

	/**
	 * 프로그램변경요청 처리 수정
	 * @param vo ProgrmManageDtlVO
	 */
	public void updateProgrmChangeRequstProcess(ProgrmManageDtlVO vo){
		update("progrmManageDAO.updateProgrmChangeRequstProcess_S", vo);
	}


	/**
	 * 프로그램목록 전체삭제 초기화
	 * @return boolean
	 */
	public boolean deleteAllProgrm(){
		ProgrmManageVO vo = new ProgrmManageVO();
		update("progrmManageDAO.deleteAllProgrm", vo);
		return true;
	}

	/**
	 * 프로그램변경내역 전체삭제 초기화
	 * @return boolean
	 */
	public boolean deleteAllProgrmDtls(){
		ProgrmManageDtlVO vo = new ProgrmManageDtlVO();
		update("progrmManageDAO.deleteAllProgrmDtls", vo);
		return true;
	}

    /**
	 * 프로그램목록 데이타 존재여부 조회한다.
	 * @return int
	 */
    public int selectProgrmListTotCnt() {
    	ProgrmManageVO vo = new ProgrmManageVO();
        return (Integer)selectOne("progrmManageDAO.selectProgrmListTotCnt", vo);
    }

	/**
	 * 프로그램변경요청자 Email 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 */
	public ProgrmManageDtlVO selectRqesterEmail(ProgrmManageDtlVO vo){
		return (ProgrmManageDtlVO)selectOne("progrmManageDAO.selectRqesterEmail", vo);
	}
}