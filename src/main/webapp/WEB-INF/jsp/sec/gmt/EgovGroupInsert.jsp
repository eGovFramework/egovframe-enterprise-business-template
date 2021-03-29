<%--
  Class Name : EgovAuthorInsert.jsp
  Description : EgovAuthorInsert 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<c:set var="registerFlag" value="${empty groupManageVO.groupId ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty groupManageVO.groupId ? '그룹 등록' : '그룹 수정'}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>그룹 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="groupManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectGroupList() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
    varFrom.submit();       
}

function fncGroupInsert() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncGroupUpdate() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncGroupDelete() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupDelete.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
}

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
                            <li>사용자권한관리</li>
                            <li>&gt;</li>
                            <li><strong>사용자그룹관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong><c:out value="${registerFlagName}"/></strong></h2></div>
                </div>
                <form:form commandName="groupManage" method="post" >

                    <div class="modify_user" >
                        <table summary="그룹을 수정하는 테이블입니다.그룹 ID,그룹 명,설명,등록일자 정보를 담고 있습니다.">
                          <tr>
                            <th class="required_text" width="25%" scope="row"  nowrap="nowrap">그룹 ID
                            </th>
                            <td nowrap="nowrap"><input name="groupId" id="groupId" type="text" value="<c:out value='${groupManage.groupId}'/>" size="40" title="그룹 ID"/></td>
                          </tr>
                          <tr>    
                            <th class="required_text" width="25%" scope="row"  nowrap="nowrap">그룹 명
                                <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                            </th>
                            <td nowrap="nowrap"><input name="groupNm" id="groupNm" type="text" value="<c:out value='${groupManage.groupNm}'/>" title="그룹명" maxLength="50" size="40" />&nbsp;<form:errors path="groupNm" /></td>
                          </tr>
                          <tr>    
                            <th class="required_text" width="20%" scope="row"  nowrap="nowrap">설명</th>
                            <td nowrap="nowrap"><input name="groupDc" id="groupDc" type="text" value="<c:out value='${groupManage.groupDc}'/>" title="설명" maxLength="50" size="50" /></td>
                          </tr>
                          <tr>    
                            <th class="required_text" width="20%" scope="row"  nowrap="nowrap">등록일자</th>
                            <td nowrap="nowrap"><input name="groupCreatDe" id="groupCreatDe" type="text" value="<c:out value='${groupManage.groupCreatDe}'/>" title="등록일자" maxLength="50" size="20" readonly="readonly"/></td>
                          </tr>
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                            <a href="#LINK" onclick="javascript:fncSelectGroupList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a>  
                          </td>
                          <c:if test="${registerFlag == 'INSERT'}">
                              <td width="10"></td>
                              <td>
                                <a href="#LINK" onclick="javascript:fncGroupInsert()" style="selector-dummy:expression(this.hideFocus=false);">저장</a>  
                              </td>
                          </c:if>
                          <c:if test="${registerFlag == 'UPDATE'}">
                              <td width="10"></td>
                              <td>
                                <a href="#LINK" onclick="javascript:fncGroupUpdate()" style="selector-dummy:expression(this.hideFocus=false);">저장</a>  
                              </td>
                              <td width="10"></td>
                              <td>
                                <a href="#LINK" onclick="javascript:fncGroupDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a>   
                              </td>
                          </c:if>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

					<!-- 검색조건 유지 -->
					<c:if test="${registerFlag == 'UPDATE'}">
					<input type="hidden" name="searchCondition" value="<c:out value='${groupManageVO.searchCondition}'/>"/>
					<input type="hidden" name="searchKeyword" value="<c:out value='${groupManageVO.searchKeyword}'/>"/>
					<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
					</c:if>
                    <!-- 검색조건 유지 -->
                </form:form>

                <div align="right">
                    <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지" />
                </div>


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

