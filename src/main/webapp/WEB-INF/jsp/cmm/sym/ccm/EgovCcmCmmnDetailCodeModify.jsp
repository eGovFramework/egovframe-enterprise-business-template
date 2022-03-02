<%--
  Class Name : EgovCcmCmmnDetailCodeModify.jsp
  Description : EgovCcmCmmnDetailCodeModify 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:url var="ImgUrl" value="/images"/>
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

<title>내부업무 사이트 > 내부시스템관리 > 상세코드관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnDetailCode" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_CmmnDetailCode(){
    location.href = "<c:url value='/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_CmmnDetailCode(form){
    if(confirm("<spring:message code='common.save.msg'/>")){
        if(!validateCmmnDetailCode(form)){          
            return;
        }else{
            form.cmd.value = "Modify";
            form.submit();
        }
    }
}
//-->
</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                                        <li><a href="">내부시스템관리</a></li>
                                        <li><a href="">코드관리</a></li>
                                        <li>상세코드관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="cmmnDetailCode" name="cmmnDetailCode" method="post">
								
								<input name="cmd" type="hidden" value="Modify">
								<form:hidden path="codeId"/>
								<form:hidden path="code"/>

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">상세코드관리</h2>
                                
                                <div class="board_view2">
                                    <table summary="코드명, 코드설명, 사용여부를 수정할 수 있는 공통상세코드 수정 테이블이다.">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="codeIdNm">코드ID</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	${cmmnDetailCode.codeIdNm}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">코드</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value='${cmmnDetailCode.code}'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">코드명</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input class="f_txt w_full" path="codeNm" maxlength="60" id="codeNm"/>
                                                <form:errors path="codeNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="codeDc">코드설명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:textarea class="f_txtar w_full h_80" path="codeDc" rows="10" cols="30" id="codeDc"/>
                                                <form:errors path="codeDc" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="useAt">사용여부</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="useAt">
                                                    <select id="useAt" name="useAt">
                                                        <option value="Y" label="Yes">Yes</option>
                                                        <option value="N" label="No">No</option>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_modify_CmmnDetailCode(document.cmmnDetailCode); return false;"><spring:message code='button.save' /></a><!-- 저장 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_list_CmmnDetailCode(); return false;"><spring:message code='button.list' /></a><!-- 목록 -->
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