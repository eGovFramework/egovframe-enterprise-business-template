package egovframework.com.cmm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.service.FileVO;

/**
 * @Class Name : FileManageMapper.java
 * @Description : 파일정보 관리를 위한 Mapper 인터페이스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭    최초생성
 *    2024.11.01  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version 2.0
 * @see
 *
 */
@EgovMapper("FileManageDAO")
public interface FileManageMapper {

	/**
	 * 여러 개의 파일 마스터를 등록한다.
	 * @param vo FileVO
	 * @exception Exception
	 */
	void insertFileMaster(FileVO vo) throws Exception;

	/**
	 * 파일 상세정보를 등록한다.
	 * @param vo FileVO
	 * @exception Exception
	 */
	void insertFileDetail(FileVO vo) throws Exception;

	/**
	 * 파일 상세정보를 삭제한다.
	 * @param vo FileVO
	 * @exception Exception
	 */
	void deleteFileDetail(FileVO vo) throws Exception;

	/**
	 * 파일에 대한 목록을 조회한다.
	 * @param vo FileVO
	 * @return List&lt;FileVO&gt;
	 * @exception Exception
	 */
	List<FileVO> selectFileList(FileVO vo) throws Exception;

	/**
	 * 파일 구분자에 대한 최대값을 구한다.
	 * @param fvo FileVO
	 * @return int
	 * @exception Exception
	 */
	int getMaxFileSN(FileVO fvo) throws Exception;

	/**
	 * 파일에 대한 상세정보를 조회한다.
	 * @param fvo FileVO
	 * @return FileVO
	 * @exception Exception
	 */
	FileVO selectFileInf(FileVO fvo) throws Exception;

	/**
	 * 전체 파일을 삭제(USE_AT = 'N')한다.
	 * @param fvo FileVO
	 * @exception Exception
	 */
	void deleteCOMTNFILE(FileVO fvo) throws Exception;

	/**
	 * 파일명 검색에 대한 목록을 조회한다.
	 * @param fvo FileVO
	 * @return List&lt;FileVO&gt;
	 * @exception Exception
	 */
	List<FileVO> selectFileListByFileNm(FileVO fvo) throws Exception;

	/**
	 * 파일명 검색에 대한 목록 전체 건수를 조회한다.
	 * @param fvo FileVO
	 * @return int
	 * @exception Exception
	 */
	int selectFileListCntByFileNm(FileVO fvo) throws Exception;

	/**
	 * 이미지 파일에 대한 목록을 조회한다.
	 * @param vo FileVO
	 * @return List&lt;FileVO&gt;
	 * @exception Exception
	 */
	List<FileVO> selectImageFileList(FileVO vo) throws Exception;

}
