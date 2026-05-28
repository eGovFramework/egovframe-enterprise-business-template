package egovframework.let.cop.bbs.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.cop.bbs.service.Board;
import egovframework.let.cop.bbs.service.BoardVO;

/**
 * 게시물 관리를 위한 Mapper 인터페이스
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.19
 * @version 1.0
 */
@EgovMapper
public interface BBSManageMapper {

    long selectMaxNttId();

    void insertBoardArticle(Board board);

    void replyBoardArticle(Board board);

    BoardVO selectBoardArticle(BoardVO boardVO);

    List<BoardVO> selectBoardArticleList(BoardVO boardVO);

    int selectBoardArticleListCnt(BoardVO boardVO);

    void updateBoardArticle(Board board);

    void deleteBoardArticle(Board board);

    void updateInqireCo(BoardVO boardVO);

    int selectMaxInqireCo(BoardVO boardVO);

    List<BoardVO> selectNoticeListForSort(Board board);

    void updateSortOrder(BoardVO vo);

    long selectNoticeItemForSort(Board board);

    List<BoardVO> selectGuestList(BoardVO boardVO);

    int selectGuestListCnt(BoardVO boardVO);

    void deleteGuestList(BoardVO boardVO);

    String getPasswordInf(Board board);

    long getParentNttNo(Board board);

    void updateOtherNttNo(Board board);

    void updateNttNo(Board board);
}
