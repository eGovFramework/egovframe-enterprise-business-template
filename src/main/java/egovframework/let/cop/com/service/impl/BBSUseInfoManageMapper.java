package egovframework.let.cop.com.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.cop.com.service.BoardUseInf;
import egovframework.let.cop.com.service.BoardUseInfVO;

/**
 * 게시판 이용정보 관리를 위한 Mapper 인터페이스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.04.02
 * @version 1.0
 */
@EgovMapper
public interface BBSUseInfoManageMapper {

    void deleteBBSUseInf(BoardUseInf bdUseInf);

    List<BoardUseInf> selectBBSUseInfByCmmnty(BoardUseInfVO bdUseVO);

    List<BoardUseInf> selectBBSUseInfByClub(BoardUseInfVO bdUseVO);

    void deleteAllBBSUseInfByCmmnty(BoardUseInfVO bdUseVO);

    void deleteAllBBSUseInfByClub(BoardUseInfVO bdUseVO);

    void insertBBSUseInf(BoardUseInf bdUseInf);

    List<BoardUseInfVO> selectBBSUseInfs(BoardUseInfVO bdUseVO);

    int selectBBSUseInfsCnt(BoardUseInfVO bdUseVO);

    BoardUseInfVO selectBBSUseInf(BoardUseInfVO bdUseVO);

    void updateBBSUseInf(BoardUseInf bdUseInf);

    void deleteBBSUseInfByBoardId(BoardUseInf bdUseInf);

    List<BoardUseInfVO> selectBBSUseInfsByTrget(BoardUseInfVO bdUseVO);

    int selectBBSUseInfsCntByTrget(BoardUseInfVO bdUseVO);

    void updateBBSUseInfByTrget(BoardUseInf bdUseInf);
}
