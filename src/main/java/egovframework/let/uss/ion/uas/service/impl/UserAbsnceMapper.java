package egovframework.let.uss.ion.uas.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uss.ion.uas.service.UserAbsnce;
import egovframework.let.uss.ion.uas.service.UserAbsnceVO;

/**
 * 사용자부재에 대한 Mapper 인터페이스를 정의한다.
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
@EgovMapper
public interface UserAbsnceMapper {

	List<UserAbsnceVO> selectUserAbsnceList(UserAbsnceVO userAbsnceVO) throws Exception;

	int selectUserAbsnceListTotCnt(UserAbsnceVO userAbsnceVO) throws Exception;

	UserAbsnceVO selectUserAbsnce(UserAbsnceVO userAbsnceVO) throws Exception;

	void insertUserAbsnce(UserAbsnce userAbsnce) throws Exception;

	void updateUserAbsnce(UserAbsnce userAbsnce) throws Exception;

	void deleteUserAbsnce(UserAbsnce userAbsnce) throws Exception;

}
