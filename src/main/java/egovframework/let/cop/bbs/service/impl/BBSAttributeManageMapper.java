package egovframework.let.cop.bbs.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.cop.bbs.service.BoardMaster;
import egovframework.let.cop.bbs.service.BoardMasterVO;

/**
 * 게시판 속성정보 관리를 위한 Mapper 인터페이스
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.12
 * @version 1.0
 */
@EgovMapper
public interface BBSAttributeManageMapper {

    void deleteBBSMasterInf(BoardMaster boardMaster);

    int insertBBSMasterInf(BoardMaster boardMaster);

    BoardMasterVO selectBBSMasterInf(BoardMaster vo);

    List<BoardMasterVO> selectBBSMasterInfs(BoardMasterVO vo);

    int selectBBSMasterInfsCnt(BoardMasterVO vo);

    void updateBBSMasterInf(BoardMaster boardMaster);

    List<BoardMasterVO> selectAllBBSMaster(BoardMasterVO vo);

    List<BoardMasterVO> selectBdMstrListByTrget(BoardMasterVO vo);

    int selectBdMstrListCntByTrget(BoardMasterVO vo);

    List<BoardMasterVO> selectAllBdMstrByTrget(BoardMasterVO vo);

    List<BoardMasterVO> selectNotUsedBdMstrList(BoardMasterVO vo);

    int selectNotUsedBdMstrListCnt(BoardMasterVO vo);
}
