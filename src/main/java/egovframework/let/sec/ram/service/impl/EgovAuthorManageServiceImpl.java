package egovframework.let.sec.ram.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.sec.ram.service.AuthorManage;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import lombok.RequiredArgsConstructor;

/**
 * 권한관리에 관한 ServiceImpl 클래스를 정의한다.
 * 
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.28  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */

@Service
@RequiredArgsConstructor
public class EgovAuthorManageServiceImpl extends EgovAbstractServiceImpl implements EgovAuthorManageService {

	private final AuthorManageDAO authorManageDAO;

	/**
	 * 권한 목록을 조회한다.
	 * 
	 * @param authorManageVO AuthorManageVO
	 * @return List<AuthorManageVO>
	 * @exception Exception
	 */
	@Override
	public List<AuthorManageVO> selectAuthorList(AuthorManageVO authorManageVO) throws Exception {
		return authorManageDAO.selectAuthorList(authorManageVO);
	}

	/**
	 * 권한을 등록한다.
	 * 
	 * @param authorManage AuthorManage
	 * @exception Exception
	 */
	@Override
	public void insertAuthor(AuthorManage authorManage) throws Exception {
		authorManageDAO.insertAuthor(authorManage);
	}

	/**
	 * 권한을 수정한다.
	 * 
	 * @param authorManage AuthorManage
	 * @exception Exception
	 */
	@Override
	public void updateAuthor(AuthorManage authorManage) throws Exception {
		authorManageDAO.updateAuthor(authorManage);
	}

	/**
	 * 권한을 삭제한다.
	 * 
	 * @param authorManage AuthorManage
	 * @exception Exception
	 */
	@Override
	public void deleteAuthor(AuthorManage authorManage) throws Exception {
		authorManageDAO.deleteAuthor(authorManage);
	}

	/**
	 * 권한을 조회한다.
	 * 
	 * @param authorManageVO AuthorManageVO
	 * @return AuthorManageVO
	 * @exception Exception
	 */
	@Override
	public AuthorManageVO selectAuthor(AuthorManageVO authorManageVO) throws Exception {
		AuthorManageVO resultVO = authorManageDAO.selectAuthor(authorManageVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

	/**
	 * 권한 목록 카운트를 조회한다.
	 * 
	 * @param authorManageVO AuthorManageVO
	 * @return int
	 * @exception Exception
	 */
	@Override
	public int selectAuthorListTotCnt(AuthorManageVO authorManageVO) throws Exception {
		return authorManageDAO.selectAuthorListTotCnt(authorManageVO);
	}

	/**
	 * 모든 권한목록을 조회한다.
	 * 
	 * @param authorManageVO AuthorManageVO
	 * @return List<AuthorManageVO>
	 * @exception Exception
	 */
	@Override
	public List<AuthorManageVO> selectAuthorAllList(AuthorManageVO authorManageVO) throws Exception {
		return authorManageDAO.selectAuthorAllList(authorManageVO);
	}
}
