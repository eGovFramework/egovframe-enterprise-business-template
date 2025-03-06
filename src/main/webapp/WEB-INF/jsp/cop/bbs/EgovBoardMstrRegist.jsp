<%--
  Class Name : EgovBoardMstrRegist.jsp
  Description : 게시판 생성 화면
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

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
    function fn_egov_regist_brdMstr(){
        event.preventDefault();
        if (!validateBoardMaster(document.boardMaster)){
            return;
        }

        if (confirm('<spring:message code="common.regist.msg" />')) {
            form = document.boardMaster;
            form.action = "<c:url value='/cop/bbs/insertBBSMasterInf.do'/>";
            form.submit();
        }
    }
    
    function fn_egov_select_brdMstrList(){
        event.preventDefault();
        form = document.boardMaster;
        form.action = "<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>";
        form.method = 'get';
        form.submit();  
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

<title>내부업무 사이트 > 내부서비스관리 > 게시판템플릿관리</title>

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

								<form:form modelAttribute="boardMaster" name="boardMaster" method="post" action="cop/bbs/SelectBBSMasterInfs.do">

								<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}" />">
								<input type="hidden" name="searchWrd" value="<c:out value="${searchVO.searchWrd}" />">
								<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>

                                <h1 class="tit_1">내부서비스관리</h1>

                                <h2 class="tit_2">게시판생성관리</h2>
                                
                                <div class="board_view2">
                                    <table summary="게시판명,게시판소개,게시판 유형,게시판 속성,답장가능여부,파일첨부가능여부, .. 입니다">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="bbsNm"><spring:message code="cop.bbsNm" /></label><!-- 게시판명 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <form:input id="" class="f_txt w_full" title="게시판명입력" path="bbsNm" />
                                                <br/><form:errors path="bbsNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="bbsIntrcn"><spring:message code="cop.bbsIntrcn" /></label><!-- 게시판소개 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <form:textarea id="" class="f_txtar w_full h_80" title="게시판소개입력" path="bbsIntrcn" cols="30" rows="10" />
                                                <br/><form:errors path="bbsIntrcn" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="bbsTyCode"><spring:message code="cop.bbsTyCode" /></label><!-- 게시판 유형 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="bbsTyCode">
                                                    <form:select path="bbsTyCode" id="bbsTyCode" name="bbsTyCode" title="게시판유형선택">
                                                        <form:option value='' label="선택하세요" selected="selected" />
                                                        <form:options items="${typeList}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <br/><form:errors path="bbsTyCode" />
                                            </td>
                                            <td class="lb">
                                            	<label for="bbsAttrbCode"><spring:message code="cop.bbsAttrbCode" /></label><!-- 게시판 속성 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="bbsAttrbCode">
                                                    <form:select path="bbsAttrbCode" id="bbsAttrbCode" name="bbsAttrbCode" title="게시판속성선택">
                                                        <form:option value='' label="선택하세요" selected="selected" />
                                                        <form:options items="${attrbList}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <br/><form:errors path="bbsAttrbCode" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label><spring:message code="cop.replyPosblAt" /></label><!-- 답장가능여부 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                                <form:radiobutton path="replyPosblAt" id="rdo1" name="aa" value="Y" checked="checked" />
                                                <spring:message code="button.possible" /><!-- 가능 -->
                                                <form:radiobutton path="replyPosblAt" id="rdo2" class="ml20" name="aa" value="N"  />
                                                <spring:message code="button.impossible" /><!-- 불가능 -->
                                            </td>
                                            <td class="lb">
                                            	<label><spring:message code="cop.fileAtchPosblAt" /></label><!-- 파일첨부가능여부 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                                <form:radiobutton path="fileAtchPosblAt" id="rdo3" name="bb" value="Y" onclick="document.boardMaster.posblAtchFileNumber.disabled='';" checked="checked" />
                                                <spring:message code="button.possible" /><!-- 가능 -->
                                                <form:radiobutton path="fileAtchPosblAt" id="rdo4" class="ml20" name="bb" value="N" onclick="document.boardMaster.posblAtchFileNumber.disabled='disabled';" />
                                                <spring:message code="button.impossible" /><!-- 불가능 -->
                                                <br/><form:errors path="fileAtchPosblAt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="posblAtchFileNumber"><spring:message code="cop.posblAtchFileNumber" /></label><!-- 첨부가능파일 숫자 -->
                                            </td>
                                            <td colspan="3">
                                                <label class="f_select" for="posblAtchFileNumber">
                                                    <form:select path="posblAtchFileNumber" id="posblAtchFileNumber" name="posblAtchFileNumber" title="첨부가능파일 숫자선택" >
                                                        <form:option value="0" label="선택하세요" selected="selected" />
                                                        <form:option value="1">1개</form:option>
                                                        <form:option value="2">2개</form:option>
                                                        <form:option value="3">3개</form:option>
                                                    </form:select>
                                                </label>
                                                <br/><form:errors path="posblAtchFileNumber" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="tmplatNm"><spring:message code="cop.tmplatId" /></label><!-- 템플릿정보 -->
                                            </td>
                                            <td colspan="3">
                                                <span class="f_search2 w_350">
                                                    <form:input path="tmplatNm" id="tmplatNm" name="" readonly="true" title="템플릿정보입력" value="게시판 기본템플릿" />
                                                    <form:hidden path="tmplatId" id="tmplatId" value="TMPLAT_BOARD_DEFAULT" />
<!--                                                     <button type="button" class="btn" onclick="fn_egov_inqire_tmplatInqire();">조회</button> -->
                                                </span>
                                                <br/><form:errors path="tmplatId" />
                                            </td>
                                        </tr>
                                        
                                        <!-- 2009.06.26 : 2단계 기능 추가  -->
			                            <c:if test="${addedOptions == 'true'}">
			                            	<tr>
			                                	<th class="lb"><label for="option">추가 선택사항</label></th>
				                                <td colspan="3">
				                                    <form:select path="option" title="추가선택사항선택" >
				                                    	<form:option value="" label="미선택" />
				                                    	<form:option value='comment'>댓글</form:option>
				                                    	<form:option value='stsfdg'>만족도조사</form:option>
				                                   </form:select>
				                                </td>
			                            	</tr>
			                            </c:if>
			                            <!-- // 2009.06.26 : 2단계 기능 추가 끝  -->
                                        
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="" class="btn btn_blue_46 w_100" onclick="fn_egov_regist_brdMstr();"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="" class="btn btn_blue_46 w_100" onclick="fn_egov_select_brdMstrList(); "><spring:message code="button.list" /></a><!-- 목록 -->
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