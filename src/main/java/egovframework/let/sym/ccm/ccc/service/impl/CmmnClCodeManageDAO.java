package egovframework.let.sym.ccm.ccc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.sym.ccm.ccc.service.CmmnClCode;
import egovframework.let.sym.ccm.ccc.service.CmmnClCodeVO;
import jakarta.annotation.Resource;

/**
 *
 * 공통분류코드에 대한 데이터 접근 클래스를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("CmmnClCodeManageDAO")
public class CmmnClCodeManageDAO {

	@Resource(name = "cmmnClCodeManageMapper")
	private CmmnClCodeManageMapper cmmnClCodeManageMapper;

	public void deleteCmmnClCode(CmmnClCode cmmnClCode) throws Exception {
		cmmnClCodeManageMapper.deleteCmmnClCode(cmmnClCode);
	}

	public void insertCmmnClCode(CmmnClCode cmmnClCode) throws Exception {
		cmmnClCodeManageMapper.insertCmmnClCode(cmmnClCode);
	}

	public CmmnClCode selectCmmnClCodeDetail(CmmnClCode cmmnClCode) {
		return cmmnClCodeManageMapper.selectCmmnClCodeDetail(cmmnClCode);
	}

	public List<?> selectCmmnClCodeList(CmmnClCodeVO searchVO) throws Exception {
		return cmmnClCodeManageMapper.selectCmmnClCodeList(searchVO);
	}

	public int selectCmmnClCodeListTotCnt(CmmnClCodeVO searchVO) throws Exception {
		return cmmnClCodeManageMapper.selectCmmnClCodeListTotCnt(searchVO);
	}

	public void updateCmmnClCode(CmmnClCode cmmnClCode) throws Exception {
		cmmnClCodeManageMapper.updateCmmnClCode(cmmnClCode);
	}

}
