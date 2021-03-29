<%--
  Class Name : EgovMenuRegist.jsp
  Description : 메뉴정보 등록 화면
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

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>메뉴정보등록</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 입력처리 함수
 ******************************************************** */
function insertMenuManage(form) {
    if(!validateMenuManageVO(form)){            
        return;
    }else{
    	if(confirm("<spring:message code="common.save.msg" />")){
         form.action="<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>";
         form.submit();
    	}
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
 * 목록조회  함수
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
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>        
    <!-- //header 끝 --> 
    <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>내부시스템관리</li>
                            <li>&gt;</li>
                            <li>메뉴관리</li>
                            <li>&gt;</li>
                            <li><strong>메뉴목록관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>메뉴 등록</strong></h2></div>
                </div>
                <form:form commandName="menuManageVO" name="menuManageVO" method="post" action="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuRegistInsert.do">

                    <div class="modify_user" >
                        <table summary="메뉴 등록화면">
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNo">메뉴번호</label><img src="${ImgUrl}/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <form:input path="menuNo" size="10" maxlength="10" title="메뉴No"/>
						      <form:errors path="menuNo" />
						    </td>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuOrdr">메뉴순서</label><img src="${ImgUrl}/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <form:input path="menuOrdr" size="10"  maxlength="10" title="메뉴순서" />
						      <form:errors path="menuOrdr" />
						    </td>
						  </tr>  
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuNm">메뉴명</label><img src="${ImgUrl}/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <form:input path="menuNm" size="30"  maxlength="30" title="메뉴명" />
						      <form:errors path="menuNm" />
						    </td>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="upperMenuId">상위메뉴번호</label><img src="${ImgUrl}/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="35%" nowrap="nowrap">
						      &nbsp;
						      <form:input path="upperMenuId" size="10"  maxlength="10" title="상위메뉴No"/>
						      <form:errors path="upperMenuId" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="progrmFileNm">프로그램파일명</label><img src="${ImgUrl}/required.gif" width="15" height="15" alt="필수"></th>
						    <td width="85%"  colspan="3" nowrap="nowrap">
						        &nbsp;
						        <input type="text" name="progrmFileNm_view" size="60" disabled="disabled">
						        <form:input path="progrmFileNm" size="60"  maxlength="60" title="프로그램파일명" cssStyle="display:none"/>
						        <form:errors path="progrmFileNm" />
						        <a href="<c:url value='/sym/prm/EgovProgramListSearch.do'/>?tmp_SearchElementName=progrmFileNm" target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;" style="selector-dummy:expression(this.hideFocus=false);" >
						        <img src="<c:url value='/images/img_search.gif' />" alt='프로그램파일명 검색' width="15" height="15" />(프로그램파일명 검색)</a>
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">관련이미지명</label></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <form:input path="relateImageNm" size="30"  maxlength="30" title="관련이미지명"/>
						          <form:errors path="relateImageNm" />
						    </td>
						    <th width="15%" height="23" class="required_text" scope="row"><label for="relateImagePath">관련이미지경로</label></th>
						    <td width="35%" nowrap="nowrap">
						          &nbsp;
						          <form:input path="relateImagePath" size="30"  maxlength="30" title="관련이미지경로"/>
						          <form:errors path="relateImagePath" />
						    </td>
						  </tr>
						  <tr> 
						    <th width="15%" height="23" class="required_text" scope="row"><label for="menuDc">메뉴설명</label></th>
						    <td colspan="3" nowrap="nowrap">&nbsp;
						      <form:textarea path="menuDc" rows="14" cols="75" cssClass="txaClass" title="메뉴설명"/>
						      <form:errors path="menuDc"/>
						    </td>
						  </tr> 
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                            <a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" onclick="javascript:selectList(); return false;">목록</a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#LINK" onclick="javascript:insertMenuManage(document.getElementById('menuManageVO')); return false;"><spring:message code="button.save" /></a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
					<input type="hidden" name="tmp_SearchElementName" value="">
					<input type="hidden" name="tmp_SearchElementVal" value="">
					<input name="cmd" type="hidden" value="<c:out value='insert'/>">
                    <!-- 검색조건 유지 -->
                </form:form>

            </div>  
            <!-- //content 끝 -->    
    </div>  
    <!-- //container 끝 -->
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //전체 레이어 끝 -->
</body>
</html>

