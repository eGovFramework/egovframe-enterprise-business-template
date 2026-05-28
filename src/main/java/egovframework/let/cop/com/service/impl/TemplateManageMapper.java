package egovframework.let.cop.com.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.cop.com.service.TemplateInf;
import egovframework.let.cop.com.service.TemplateInfVO;

/**
 * 템플릿 정보관리를 위한 Mapper 인터페이스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.17
 * @version 1.0
 */
@EgovMapper
public interface TemplateManageMapper {

    void deleteTemplateInf(TemplateInf tmplatInf);

    void insertTemplateInf(TemplateInf tmplatInf);

    void updateTemplateInf(TemplateInf tmplatInf);

    List<TemplateInfVO> selectTemplateInfs(TemplateInfVO tmplatInfVO);

    int selectTemplateInfsCnt(TemplateInfVO tmplatInfVO);

    TemplateInfVO selectTemplateInf(TemplateInfVO tmplatInfVO);

    List<TemplateInfVO> selectTemplateInfsByCode(TemplateInfVO tmplatInfVO);
}
