<%--
  Class Name : EgovMenuDetailSelectUpdt.jsp
  Description : 메뉴정보 상세조회및 수정 화면
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

<title>내부업무 사이트 > 내부시스템관리 > 메뉴목록관리</title>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript">
<!--
/* ********************************************************
 * 수정처리 함수
 ******************************************************** */
function updateMenuManage(form) {
    
    if(!validateMenuManageVO(form)){            
        return;
    }else{
    	if(confirm("<spring:message code='common.save.msg' />")){
         form.action="<c:url value='/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do'/>";
         form.submit();
    	}
    }
}

/* ********************************************************
 * 삭제처리함수
 ******************************************************** */
function deleteMenuManage(form) {
    if(confirm("<spring:message code='common.delete.msg' />")){
        form.action="<c:url value='/sym/mnu/mpm/EgovMenuManageDelete.do'/>";
        form.submit();
    }
}
/* ********************************************************
 * 파일목록조회  함수
 ******************************************************** */
function searchFileNm() {
    document.all.tmp_SearchElementName.value = "progrmFileNm";
    window.open("<c:url value='/sym/prm/EgovProgramListSearch.do'/>",'','width=800,height=600');
}
/* ********************************************************
 * 목록조회 함수
 ******************************************************** */
function selectList(){
    location.href = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
}

/* ********************************************************
 * 파일명 엔터key 목록조회  함수
 ******************************************************** */
function press() {
    if (event.keyCode==13) {
        searchFileNm();    // 원래 검색 function 호출
    }
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
                                        <li>메뉴목록관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="menuManageVO" name="menuManageVO" action ="<c:url value='/sym/mnu/mpm/EgovMenuDetailSelectUpdt.do' />" method="post">

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">메뉴목록관리</h2>

                                <div class="board_view2">
                                    <table summary="메뉴상세정보">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min"><label for="menuNo">메뉴번호</label></span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input class="f_txt" type="text" value="<c:out value="${menuManageVO.menuNo}"/>" id="" readonly="readonly">
                                                <form:hidden path="menuNo" />
                                                <form:errors path="menuNo" />
                                            </td>
                                            <td class="lb">
                                                <label for="menuOrdr">메뉴순서</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="menuOrdr" maxlength="10" title="메뉴순서"/>
                                                <form:errors path="menuOrdr" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="menuNm">메뉴명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="menuNm" maxlength="30" title="메뉴명"/>
                                                <form:errors path="menuNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="upperMenuId">상위메뉴번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="upperMenuId" maxlength="10" title="상위메뉴No"/>
                                                <form:errors path="upperMenuId" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="progrmFileNm">프로그램파일명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <span class="f_search2 w_500">
                                                    <input id="" type="text" name="progrmFileNm_view" size="60" disabled="disabled" value="${menuManageVO.progrmFileNm}" readonly="readonly">
                                                    <form:input path="progrmFileNm" type="hidden" maxlength="60" title="프로그램파일명" />
                                                    <form:errors path="progrmFileNm" />
                                                    <button type="button" class="btn" onclick="searchFileNm();return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                                </span>
                                                <span class="f_txt_inner ml15">(프로그램파일명 검색)</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="relateImageNm">관련이미지명</label>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="relateImageNm" maxlength="30" title="관련이미지명"/>
                                                <form:errors path="relateImageNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="relateImagePath">관련이미지경로</label>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="relateImagePath" maxlength="30" title="관련이미지경로"/>
                                                <form:errors path="relateImagePath" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="menuDc">메뉴설명</label>
                                            </td>
                                            <td colspan="3">
                                                <form:textarea id="" class="f_txtar w_full h_200" path="menuDc" rows="10" cols="30" title="메뉴설명"/>
                                                <form:errors path="menuDc" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="deleteMenuManage(document.getElementById('menuManageVO')); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:updateMenuManage(document.getElementById('menuManageVO')); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" class="btn btn_blue_46 w_100" onclick="selectList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input type="hidden" name="tmp_SearchElementName" value=""/>
                                <input type="hidden" name="tmp_SearchElementVal" value=""/>
                                <input name="cmd" type="hidden" value="update"/>
                                
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