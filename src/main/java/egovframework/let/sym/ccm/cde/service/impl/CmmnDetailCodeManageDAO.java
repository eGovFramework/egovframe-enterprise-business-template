package egovframework.let.sym.ccm.cde.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.let.sym.ccm.cde.service.CmmnDetailCodeVO;
import jakarta.annotation.Resource;

/**
 *
 * 공통상세코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("CmmnDetailCodeManageDAO")
public class CmmnDetailCodeManageDAO {

	@Resource(name = "cmmnDetailCodeManageMapper")
	private CmmnDetailCodeManageMapper cmmnDetailCodeManageMapper;

	public void deleteCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception {
		cmmnDetailCodeManageMapper.deleteCmmnDetailCode(cmmnDetailCode);
	}

	public void insertCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception {
		cmmnDetailCodeManageMapper.insertCmmnDetailCode(cmmnDetailCode);
	}

	public CmmnDetailCode selectCmmnDetailCodeDetail(CmmnDetailCode cmmnDetailCode) throws Exception {
		return cmmnDetailCodeManageMapper.selectCmmnDetailCodeDetail(cmmnDetailCode);
	}

	public List<?> selectCmmnDetailCodeList(CmmnDetailCodeVO searchVO) throws Exception {
		return cmmnDetailCodeManageMapper.selectCmmnDetailCodeList(searchVO);
	}

	public int selectCmmnDetailCodeListTotCnt(CmmnDetailCodeVO searchVO) throws Exception {
		return cmmnDetailCodeManageMapper.selectCmmnDetailCodeListTotCnt(searchVO);
	}

	public void updateCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception {
		cmmnDetailCodeManageMapper.updateCmmnDetailCode(cmmnDetailCode);
	}

}
