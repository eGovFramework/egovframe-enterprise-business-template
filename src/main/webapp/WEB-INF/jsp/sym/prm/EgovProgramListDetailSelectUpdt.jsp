<%--
  Class Name : EgovProgramListDetailSelectUpdt.jsp
  Description : 프로그램목록 상세조회및 수정 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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

<title>내부업무 사이트 > 내부시스템관리 > 프로그램목록관리</title>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="progrmManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 수정처리 함수
 ******************************************************** */
function updateProgramListManage(form) {
    if(confirm("<spring:message code="common.save.msg" />")){
        if(!validateProgrmManageVO(form)){          
            return;
        }else{
            form.action="<c:url value='/'/>sym/prm/EgovProgramListDetailSelectUpdt.do";
            form.submit();
        }
    }
}

/* ********************************************************
 * 삭제처리함수
 ******************************************************** */
function deleteProgramListManage(form) {
    if(confirm("<spring:message code="common.delete.msg" />")){
        form.action="<c:url value='/'/>sym/prm/EgovProgramListManageDelete.do";
        form.submit();
    }
}

/* ********************************************************
 * 목록조회 함수
 ******************************************************** */
function selectList(){
    location.href = "<c:url value='/'/>sym/prm/EgovProgramListManageSelect.do";
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
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
                                        <li><a href="">메뉴관리</a></li>
                                        <li>프로그램목록관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="progrmManageVO" action="/sym/prm/EgovProgramListDetailSelectUpdt.do">

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">프로그램목록관리</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="progrmFileNm">프로그램파일명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="" class="f_txt w_full" type="text" disabled="disabled" value="<c:out value="${progrmManageVO.progrmFileNm }"/>" readonly="readonly" >
                                                <form:input path="progrmFileNm" type="hidden" maxlength="50" title="프로그램파일명" />
                                                <form:errors path="progrmFileNm"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="progrmStrePath">저장경로</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt w_full" path="progrmStrePath" maxlength="50" title="저장경로"/>
                                                <form:errors path="progrmStrePath"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="progrmKoreanNm">프로그램 한글명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt w_full" path="progrmKoreanNm" maxlength="50" title="프로그램 한글명"/>
                                                <form:errors path="progrmKoreanNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="URL">URL</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt w_full" path="URL" maxlength="60" title="URL" />
                                                <form:errors path="URL" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="progrmDc">프로그램설명</label>
                                            </td>
                                            <td>
                                                <form:textarea id="" class="f_txtar w_full h_200" path="progrmDc" rows="10" cols="30" title="프로그램설명"/>
                                                <form:errors path="progrmDc" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="<c:url value='/sym/prm/EgovProgramListManageDelete.do'/>?progrmFileNm=<c:out value="${progrmManageVO.progrmFileNm  }"/>" class="btn btn_skyblue_h46 w_100" onclick="deleteProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:updateProgramListManage(document.getElementById('progrmManageVO')); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/sym/mpm/EgovProgramListManageSelect.do'/>" class="btn btn_blue_46 w_100" onclick="selectList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input name="cmd" type="hidden" value="<c:out value='update'/>"/>
                                
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