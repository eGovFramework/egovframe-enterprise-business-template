package egovframework.com.cmm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;

/**
 * @Class Name : CmmUseMapper.java
 * @Description : 공통코드 등 전체 업무에서 공용으로 사용하는 서비스를 위한 Mapper 인터페이스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭    최초생성
 *    2024.11.01  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version 2.0
 * @see
 *
 */
@EgovMapper("cmmUseDAO")
public interface CmmUseMapper {

	/**
	 * 주어진 조건에 따른 공통코드를 불러온다.
	 * @param vo ComDefaultCodeVO
	 * @return List&lt;CmmnDetailCode&gt;
	 * @exception Exception
	 */
	List<CmmnDetailCode> selectCmmCodeDetail(ComDefaultCodeVO vo) throws Exception;

	/**
	 * 공통코드로 사용할 조직정보를 불러온다.
	 * @param vo ComDefaultCodeVO
	 * @return List&lt;CmmnDetailCode&gt;
	 * @exception Exception
	 */
	List<CmmnDetailCode> selectOgrnztIdDetail(ComDefaultCodeVO vo) throws Exception;

	/**
	 * 공통코드로 사용할 그룹정보를 불러온다.
	 * @param vo ComDefaultCodeVO
	 * @return List&lt;CmmnDetailCode&gt;
	 * @exception Exception
	 */
	List<CmmnDetailCode> selectGroupIdDetail(ComDefaultCodeVO vo) throws Exception;

}
