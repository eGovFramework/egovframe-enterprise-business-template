package egovframework.let.uss.umt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.uss.umt.service.UserManageVO;

/**
 * 사용자관리에 관한 Mapper 인터페이스를 정의한다.
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
@EgovMapper
public interface UserManageMapper {

	int checkIdDplct_S(String checkId);

	void deleteUser_S(String delId);

	void insertUser_S(UserManageVO userManageVO);

	UserManageVO selectUser_S(String uniqId);

	List<?> selectUserList_S(UserDefaultVO userSearchVO);

	int selectUserListTotCnt_S(UserDefaultVO userSearchVO);

	void updateUser_S(UserManageVO userManageVO);

	void insertUserHistory_S(UserManageVO userManageVO);

	void updatePassword_S(UserManageVO passVO);

	UserManageVO selectPassword_S(UserManageVO userManageVO);

}
