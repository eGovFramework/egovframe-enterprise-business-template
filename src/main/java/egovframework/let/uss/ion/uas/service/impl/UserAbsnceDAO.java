package egovframework.let.uss.ion.uas.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.uss.ion.uas.service.UserAbsnce;
import egovframework.let.uss.ion.uas.service.UserAbsnceVO;
import jakarta.annotation.Resource;

/**
 * 사용자부재에 대한 DAO 클래스를 정의한다.
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j        최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("userAbsnceDAO")
public class UserAbsnceDAO {

	@Resource(name = "userAbsnceMapper")
	private UserAbsnceMapper userAbsnceMapper;

	public List<UserAbsnceVO> selectUserAbsnceList(UserAbsnceVO userAbsnceVO) throws Exception {
		return userAbsnceMapper.selectUserAbsnceList(userAbsnceVO);
	}

	public int selectUserAbsnceListTotCnt(UserAbsnceVO userAbsnceVO) throws Exception {
		return userAbsnceMapper.selectUserAbsnceListTotCnt(userAbsnceVO);
	}

	public UserAbsnceVO selectUserAbsnce(UserAbsnceVO userAbsnceVO) throws Exception {
		return userAbsnceMapper.selectUserAbsnce(userAbsnceVO);
	}

	public void insertUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		userAbsnceMapper.insertUserAbsnce(userAbsnce);
	}

	public void updateUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		userAbsnceMapper.updateUserAbsnce(userAbsnce);
	}

	public void deleteUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		userAbsnceMapper.deleteUserAbsnce(userAbsnce);
	}

	public UserAbsnceVO selectUserAbsnceResult(UserAbsnceVO userAbsnceVO) throws Exception {
		return null;
	}

}
