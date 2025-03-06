<%--
  Class Name : EgovBoardMstrUpdt.jsp
  Description : 게시판 속성정보 변경화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.12  이삼섭          최초 생성
     2009.06.26  한성곤          2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31  JJY           경량환경 버전 생성
     2024.09.05  이백행          컨트리뷰션 검색 조건 유지
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.12
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<title>내부업무 사이트 > 내부서비스관리 > 게시판생성관리</title>

<script type="text/javascript" src="<c:url value="/js/EgovBBSMng.js" />" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
    function fn_egov_validateForm(obj){
        return true;
    }
    
    function fn_egov_update_brdMstr(){
        event.preventDefault();
        if (!validateBoardMaster(document.boardMaster)){
            return;
        }
        
        if(confirm('<spring:message code="common.update.msg" />')){
            document.boardMaster.action = "<c:url value='/cop/bbs/UpdateBBSMasterInf.do'/>";
            document.boardMaster.submit();                  
        }
    }   
    
    function fn_egov_select_brdMstrList(){
        event.preventDefault();
        document.boardMaster.action = "<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>";
        document.boardMaster.method = 'get';
        document.boardMaster.submit();  
    }   
    
    function fn_egov_delete_brdMstr(){
        event.preventDefault();
        if(confirm('<spring:message code="common.delete.msg" />')){
            document.boardMaster.action = "<c:url value='/cop/bbs/DeleteBBSMasterInf.do'/>";
            document.boardMaster.submit();  
        }       
    }
    
    function fn_egov_inqire_tmplatInqire(){
        event.preventDefault();
        
        var $dialog = $('<div id="modalPan"></div>')
    	.html('<iframe style="border: 0px; " src="' + "<c:url value='/cop/com/selectTemplateInfsPop.do'/>" +'" width="100%" height="100%"></iframe>')
    	.dialog({
        	autoOpen: false,
            modal: true,
            width: 1050,
            height: 950,
            title: "템플릿 목록"
    	});
        $(".ui-dialog-titlebar").hide();
    	$dialog.dialog('open');
    }
    
    function fn_egov_returnValue(retVal){
    	if(retVal != null){
            var tmp = retVal.split("|");
            document.getElementById("tmplatId").value = tmp[0];
            document.getElementById("tmplatNm").value = tmp[1];
        }
    	
    	fn_egov_modal_remove();
	}

    /**********************************************************
     * 모달 종료 버튼
     ******************************************************** */
    function fn_egov_modal_remove() {
    	$('#modalPan').remove();
    }
    
</script>

</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
		<c:import url="/sym/mms/EgovHeader.do" />
		<!--// Header -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">내부서비스관리</a></li>
                                        <li><a href="">내부업무게시판관리</a></li>
                                        <li>게시판생성관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="boardMaster" name="boardMaster" action="<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>" method="post" >

								<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}" />">
								<input type="hidden" name="searchWrd" value="<c:out value="${searchVO.searchWrd}" />">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<input name="bbsId" type="hidden" value="<c:out value='${result.bbsId}'/>" />
								<input name="bbsTyCode" type="hidden" value="<c:out value='${result.bbsTyCode}'/>" />
								<input name="bbsAttrbCode" type="hidden" value="<c:out value='${result.bbsAttrbCode}'/>" />
								<input name="replyPosblAt" type="hidden" value="<c:out value='${result.replyPosblAt}'/>" />

                                <h1 class="tit_1">내부서비스관리</h1>

                                <h2 class="tit_2">게시판생성관리</h2>
                                
                                <div class="board_view2">
                                    <table summary="게시판명,게시판 소개,게시판 유형,게시판 속성,답장가능여부, ..입니다">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="bbsNm">게시판명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <input title="게시판명입력" id="bbsNm" class="f_txt w_full" name="bbsNm" type="text" value='<c:out value="${result.bbsNm}"/>' maxlength="60" >
                                                <br/><form:errors path="bbsNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="bbsIntrcn">게시판소개</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <textarea title="게시판소개입력" id="bbsIntrcn" class="f_txtar w_full h_80" name="bbsIntrcn" cols="30" rows="10" ><c:out value="${result.bbsIntrcn}" escapeXml="true" /></textarea>
                                                <form:errors path="bbsIntrcn" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">게시판 유형</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.bbsTyCodeNm}"/>
                                            </td>
                                            <td class="lb">
                                                <span class="min">게시판 속성</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.bbsAttrbCodeNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">답장가능여부</span>
                                            </td>
                                            <td>
                                            	<c:choose>
                                            		<c:when test="${result.replyPosblAt == 'Y'}">
                                            			<spring:message code="button.possible" />
                                            		</c:when>
                                            		<c:otherwise>
                                            			<spring:message code="button.impossible" />
                                            		</c:otherwise>
                                            	</c:choose>
                                            </td>
                                            <td class="lb">
                                            	<label>파일첨부가능여부</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                                <input type="radio" id="rdo3" name="fileAtchPosblAt" onclick="document.boardMaster.posblAtchFileNumber.disabled='';" value="Y" <c:if test="${result.fileAtchPosblAt == 'Y'}"> checked="checked"</c:if>>
                                                <spring:message code="button.possible" />
                                                <input type="radio" id="rdo4" class="ml20" name="fileAtchPosblAt" onclick="document.boardMaster.posblAtchFileNumber.disabled='disabled';" value="N" <c:if test="${result.fileAtchPosblAt == 'N'}"> checked="checked"</c:if>>
                                                <spring:message code="button.impossible" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="posblAtchFileNumber">첨부가능파일 숫자</label>
                                            </td>
                                            <td colspan="3">
                                                <label class="f_select" for="posblAtchFileNumber">
                                                    <select id="posblAtchFileNumber" name="posblAtchFileNumber" title="첨부가능파일 숫자선택" <c:if test="${result.fileAtchPosblAt == 'N'}"> disabled="disabled"</c:if>>
                                                        <option value="0" selected="selected">선택하세요</option>
                                                        <option value='1' <c:if test="${result.posblAtchFileNumber == '1'}">selected="selected"</c:if>>1개</option>
                                                        <option value='2' <c:if test="${result.posblAtchFileNumber == '2'}">selected="selected"</c:if>>2개</option>
                                                        <option value='3' <c:if test="${result.posblAtchFileNumber == '3'}">selected="selected"</c:if>>3개</option>
                                                    </select>
                                                    <br/><form:errors path="posblAtchFileNumber" />
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="tmplatNm">템플릿정보</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <span class="f_search2 w_350">
                                                    <input title="템플릿정보입력" id="tmplatNm" name="tmplatNm" type="text" value="<c:out value="${result.tmplatNm}"/>" maxlength="20" readonly="readonly" >
                                                    <input id="tmplatId" name="tmplatId" type="hidden" value='<c:out value="${result.tmplatId}"/>' >
<%--                                                     <button type="button" class="btn" onclick="fn_egov_inqire_tmplatInqire();"><spring:message code='button.inquire' /></button><!-- 조회 --> --%>
                                                    <br/><form:errors path="tmplatId" />
                                                </span>
                                            </td>
                                        </tr>
                                        
                                        <c:if test="${addedOptions == 'true'}">
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="">추가 선택사항</label>
	                                            </td>
	                                            <td colspan="3">
	                                                <label class="f_select" for="option">
                                                    <select id="option" name="option" title="추가선택사항선택" <c:if test="${result.option != 'na'}">disabled="disabled"</c:if>>
                                                        <option value='na' <c:if test="${result.option == 'na'}">selected="selected"</c:if>>선택하세요</option>
                                                        <option value='' <c:if test="${result.option == ''}">selected="selected"</c:if>>미선택</option>
                                                        <option value='comment' <c:if test="${result.option == 'comment'}">selected="selected"</c:if>>댓글</option>
                                                        <option value='stsfdg' <c:if test="${result.option == 'stsfdg'}">selected="selected"</c:if>>만족도조사</option>
                                                    </select>
                                                    	 ※ 추가 선택사항은 수정 불가 (미설정된 기존 게시판의 경우 처음 설정은 가능함)
                                                </label>
	                                            </td>
	                                        </tr>
                                        </c:if>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    	<a href="" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_delete_brdMstr();"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="" class="btn btn_blue_46 w_100" onclick="fn_egov_update_brdMstr();"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value="/cop/bbs/SelectBBSMasterInfs.do" />?searchCnd=<c:out value="${searchVO.searchCnd}" />&searchWrd=<c:out value="${searchVO.searchWrd}" />&pageIndex=<c:out value="${searchVO.pageIndex}" />" class="btn btn_blue_46 w_100" onclick="fn_egov_select_brdMstrList();"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                </form:form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
    </div>
    
</body>
</html>