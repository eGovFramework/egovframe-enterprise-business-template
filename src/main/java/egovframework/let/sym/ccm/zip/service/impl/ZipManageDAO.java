package egovframework.let.sym.ccm.zip.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.sym.ccm.zip.service.Zip;
import egovframework.let.sym.ccm.zip.service.ZipVO;
import jakarta.annotation.Resource;

/**
 *
 * 우편번호에 대한 데이터 접근 클래스를 정의한다
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
@Repository("ZipManageDAO")
public class ZipManageDAO {

	@Resource(name = "zipManageMapper")
	private ZipManageMapper zipManageMapper;

	public void deleteZip(Zip zip) throws Exception {
		zipManageMapper.deleteZip(zip);
	}

	public void deleteAllZip() throws Exception {
		zipManageMapper.deleteAllZip();
	}

	public void insertZip(Zip zip) throws Exception {
		zipManageMapper.insertZip(zip);
	}

	public void insertExcelZip() throws Exception {
		zipManageMapper.deleteAllZip();
	}

	public Zip selectZipDetail(Zip zip) throws Exception {
		return zipManageMapper.selectZipDetail(zip);
	}

	public List<?> selectZipList(ZipVO searchVO) throws Exception {
		return zipManageMapper.selectZipList(searchVO);
	}

	public int selectZipListTotCnt(ZipVO searchVO) throws Exception {
		return zipManageMapper.selectZipListTotCnt(searchVO);
	}

	public void updateZip(Zip zip) throws Exception {
		zipManageMapper.updateZip(zip);
	}

}
