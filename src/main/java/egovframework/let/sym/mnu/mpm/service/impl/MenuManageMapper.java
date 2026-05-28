package egovframework.let.sym.mnu.mpm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.mnu.mcm.service.MenuCreatVO;
import egovframework.let.sym.mnu.mpm.service.MenuManageVO;

/**
 * 메뉴관리, 메뉴생성에 대한 Mapper 인터페이스를 정의한다.
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
public interface MenuManageMapper {

	/* ===== EgovMenuManage_SQL (메뉴관리) ===== */

	List<?> selectMenuManageList_D(ComDefaultVO vo) throws Exception;

	int selectMenuManageListTotCnt_S(ComDefaultVO vo);

	MenuManageVO selectMenuManage_D(ComDefaultVO vo) throws Exception;

	void insertMenuManage_S(MenuManageVO vo);

	void updateMenuManage_S(MenuManageVO vo);

	void deleteMenuManage_S(MenuManageVO vo);

	int selectMenuNoByPk(MenuManageVO vo) throws Exception;

	int selectUpperMenuNoByPk(MenuManageVO vo) throws Exception;

	List<?> selectMenuListT_D(ComDefaultVO vo) throws Exception;

	void deleteAllMenuList(MenuManageVO vo);

	int selectMenuListTotCnt(MenuManageVO vo);

	/* ===== EgovMainMenu_SQL (메인메뉴) ===== */

	List<?> selectMainMenuHead(MenuManageVO vo) throws Exception;

	List<?> selectMainMenuLeft(MenuManageVO vo) throws Exception;

	String selectLastMenuURL(MenuManageVO vo) throws Exception;

	int selectLastMenuNo(MenuManageVO vo) throws Exception;

	int selectLastMenuNoCnt(MenuManageVO vo) throws Exception;

	/* ===== EgovMenuCreat_SQL (메뉴생성) ===== */

	int selectUsrByPk(ComDefaultVO vo) throws Exception;

	MenuCreatVO selectAuthorByUsr(ComDefaultVO vo) throws Exception;

	List<?> selectMenuCreatManageList_D(ComDefaultVO vo) throws Exception;

	int selectMenuCreatManageTotCnt_S(ComDefaultVO vo);

	List<?> selectMenuCreatList_D(MenuCreatVO vo) throws Exception;

	void insertMenuCreat_S(MenuCreatVO vo);

	int selectMenuCreatCnt_S(MenuCreatVO vo);

	void updateMenuCreat_S(MenuCreatVO vo);

	void deleteMenuCreat_S(MenuCreatVO vo);

}
