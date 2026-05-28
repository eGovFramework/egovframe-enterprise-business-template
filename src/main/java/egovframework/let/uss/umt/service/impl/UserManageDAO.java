package egovframework.let.uss.umt.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.uss.umt.service.UserManageVO;
import jakarta.annotation.Resource;

/**
 * 사용자관리에 관한 데이터 접근 클래스를 정의한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("userManageDAO")
public class UserManageDAO {

	@Resource(name = "userManageMapper")
	private UserManageMapper userManageMapper;

	public int checkIdDplct(String checkId) {
		return userManageMapper.checkIdDplct_S(checkId);
	}

	public void deleteUser(String delId) {
		userManageMapper.deleteUser_S(delId);
	}

	public void insertUser(UserManageVO userManageVO) {
		userManageMapper.insertUser_S(userManageVO);
	}

	public UserManageVO selectUser(String uniqId) {
		return userManageMapper.selectUser_S(uniqId);
	}

	public List<?> selectUserList(UserDefaultVO userSearchVO) {
		return userManageMapper.selectUserList_S(userSearchVO);
	}

	public int selectUserListTotCnt(UserDefaultVO userSearchVO) {
		return userManageMapper.selectUserListTotCnt_S(userSearchVO);
	}

	public void updateUser(UserManageVO userManageVO) {
		userManageMapper.updateUser_S(userManageVO);
	}

	public void insertUserHistory(UserManageVO userManageVO) {
		userManageMapper.insertUserHistory_S(userManageVO);
	}

	public void updatePassword(UserManageVO passVO) {
		userManageMapper.updatePassword_S(passVO);
	}

	public UserManageVO selectPassword(UserManageVO userManageVO) {
		return userManageMapper.selectPassword_S(userManageVO);
	}

}
