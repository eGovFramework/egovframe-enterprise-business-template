package egovframework.let.sym.mnu.mpm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.mnu.mpm.service.MenuManageVO;
import jakarta.annotation.Resource;

/**
 * 메뉴관리, 메뉴생성, 사이트맵 생성에 대한 DAO 클래스를 정의한다.
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
 *   2011.07.01  서준식          selectUpperMenuNoByPk() 메서드 추가
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("menuManageDAO")
public class MenuManageDAO {

	@Resource(name = "menuManageMapper")
	private MenuManageMapper menuManageMapper;

	public List<?> selectMenuManageList(ComDefaultVO vo) throws Exception {
		return menuManageMapper.selectMenuManageList_D(vo);
	}

	public int selectMenuManageListTotCnt(ComDefaultVO vo) {
		return menuManageMapper.selectMenuManageListTotCnt_S(vo);
	}

	public MenuManageVO selectMenuManage(ComDefaultVO vo) throws Exception {
		return menuManageMapper.selectMenuManage_D(vo);
	}

	public void insertMenuManage(MenuManageVO vo) {
		menuManageMapper.insertMenuManage_S(vo);
	}

	public void updateMenuManage(MenuManageVO vo) {
		menuManageMapper.updateMenuManage_S(vo);
	}

	public void deleteMenuManage(MenuManageVO vo) {
		menuManageMapper.deleteMenuManage_S(vo);
	}

	public List<?> selectMenuList() throws Exception {
		ComDefaultVO vo = new ComDefaultVO();
		return menuManageMapper.selectMenuListT_D(vo);
	}

	public int selectMenuNoByPk(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectMenuNoByPk(vo);
	}

	public int selectUpperMenuNoByPk(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectUpperMenuNoByPk(vo);
	}

	public boolean deleteAllMenuList() {
		MenuManageVO vo = new MenuManageVO();
		menuManageMapper.deleteAllMenuList(vo);
		return true;
	}

	public int selectMenuListTotCnt() {
		MenuManageVO vo = new MenuManageVO();
		return menuManageMapper.selectMenuListTotCnt(vo);
	}

	public List<?> selectMainMenuHead(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectMainMenuHead(vo);
	}

	public List<?> selectMainMenuLeft(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectMainMenuLeft(vo);
	}

	public String selectLastMenuURL(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectLastMenuURL(vo);
	}

	public int selectLastMenuNo(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectLastMenuNo(vo);
	}

	public int selectLastMenuNoCnt(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectLastMenuNoCnt(vo);
	}

}
