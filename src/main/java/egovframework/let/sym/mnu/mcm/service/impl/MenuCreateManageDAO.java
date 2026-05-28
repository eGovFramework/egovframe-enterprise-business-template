package egovframework.let.sym.mnu.mcm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.mnu.mcm.service.MenuCreatVO;
import egovframework.let.sym.mnu.mpm.service.impl.MenuManageMapper;
import jakarta.annotation.Resource;

/**
 * 메뉴생성, 사이트맵 생성에 대한 DAO 클래스를 정의한다.
 * @author 공통컴포넌트 개발팀 서준식
 * @since 2011.06.30
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.06.30  서 준 식   최초 생성
 *   2011.08.31  JJY       경량환경 템플릿 커스터마이징버전 생성
 * </pre>
 */
@Repository("menuCreateManageDAO")
public class MenuCreateManageDAO {

	@Resource(name = "menuManageMapper")
	private MenuManageMapper menuManageMapper;

	public int selectUsrByPk(ComDefaultVO vo) throws Exception {
		return menuManageMapper.selectUsrByPk(vo);
	}

	public MenuCreatVO selectAuthorByUsr(ComDefaultVO vo) throws Exception {
		return menuManageMapper.selectAuthorByUsr(vo);
	}

	public List<?> selectMenuCreatManagList(ComDefaultVO vo) throws Exception {
		return menuManageMapper.selectMenuCreatManageList_D(vo);
	}

	public int selectMenuCreatManagTotCnt(ComDefaultVO vo) {
		return menuManageMapper.selectMenuCreatManageTotCnt_S(vo);
	}

	public List<?> selectMenuCreatList(MenuCreatVO vo) throws Exception {
		return menuManageMapper.selectMenuCreatList_D(vo);
	}

	public void insertMenuCreat(MenuCreatVO vo) {
		menuManageMapper.insertMenuCreat_S(vo);
	}

	public int selectMenuCreatCnt(MenuCreatVO vo) {
		return menuManageMapper.selectMenuCreatCnt_S(vo);
	}

	public void updateMenuCreat(MenuCreatVO vo) {
		menuManageMapper.updateMenuCreat_S(vo);
	}

	public void deleteMenuCreat(MenuCreatVO vo) {
		menuManageMapper.deleteMenuCreat_S(vo);
	}

}
