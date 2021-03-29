<%--
  Class Name : EgovMenuManage.jsp
  Description : 메뉴관리 조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon";
  String imagePath_button = "/images/egovframework/sym/mpm/button";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>메뉴관리리스트</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.menuManageForm.checkField;
    if(document.menuManageForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
    var checkField = document.menuManageForm.checkField;
    var menuNo = document.menuManageForm.checkMenuNo;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {

        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + menuNo[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = menuNo.value;
            }
        }
    }   

    document.menuManageForm.checkedMenuNoForDel.value=checkMenuNos;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDelete.do'/>";
    document.menuManageForm.submit(); 
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
//  document.menuManageForm.searchKeyword.value = 
    document.menuManageForm.pageIndex.value = pageNo;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuManageList() { 
    document.menuManageForm.pageIndex.value = 1;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}

/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertMenuManage() {
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>";
    document.menuManageForm.submit();   
}

/* ********************************************************
 * 일괄처리 화면호출 함수
 ******************************************************** */
/* function bndeInsertMenuManage() {
        document.menuManageForm.action = "<c:url value='/sym/mpm/EgovMenuRegistInsert.do'/>";
        document.menuManageForm.submit();   
    }
 */
function bndeInsertMenuManage() {
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuBndeRegist.do'/>";
    document.menuManageForm.submit();
} 
/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtMenuManageDetail(menuNo) {
    document.menuManageForm.req_menuNo.value = menuNo;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'/>";
    document.menuManageForm.submit();   
}
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuManageSelect(){ 
    document.menuManageForm.action = "<c:url value='/sym/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
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
            <form name="menuManageForm" action ="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" method="post">
            <input type="submit" id="invisible" class="invisible"/>
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
                    <div id="search_field_loc"><h2><strong>메뉴관리리스트</strong></h2></div>
                        
							<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input name="checkedMenuNoForDel" type="hidden" />
							<input name="req_menuNo" type="hidden"  />
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                    <label for="searchKeyword">메뉴명 : </label>
                                    <input id="searchKeyword" name="searchKeyword" type="text" size="80" value="<c:out value='${searchVO.searchKeyword}'/>"  maxlength="60" title="검색조건"/>
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="#LINK" onclick="javascript:selectMenuManageList(); return false;" ><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                        <a href="<c:url value='/sym/mpm/EgovMenuRegistInsert.do'/>" onclick="bndeInsertMenuManage(); return false;">일괄등록</a>                              
                                        <a href="<c:url value='/sym/mpm/EgovMenuRegistInsert.do'/>" onclick="insertMenuManage(); return false;"><spring:message code="button.create" /></a>
                                        <a href="#LINK" onclick="fDeleteMenuList(); return false;"><spring:message code="button.delete" /></a>
                                    </div>
                                </li>
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->
                <div id="page_info"><div id="page_info_align"></div></div>                    
                <!-- table add start -->
                <div class="default_tablestyle">
                    <table summary="메뉴관리 목록 조회화면으로 메뉴ID,메뉴한글명,프로그램파일명,메뉴설명,상위메뉴ID로 구성." cellpadding="0" cellspacing="0">
                    <caption>메뉴관리 목록</caption>
                    <colgroup>
                        <col width="4%" >
                        <col width="13%" >  
                        <col width="20%" >
                        <col width="20%" >
                        <col width="30%" >
                        <col width="13%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col" class="f_field" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fCheckAll();" title="전체선택"/></th>
                        <th scope="col" nowrap="nowrap">메뉴번호</th>
                        <th scope="col" nowrap="nowrap">메뉴명</th>
                        <th scope="col" nowrap="nowrap">프로그램파일명</th>
                        <th scope="col" nowrap="nowrap">메뉴설명</th>
                        <th scope="col" nowrap="nowrap">상위메뉴번호</th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${list_menumanage}" varStatus="status">
                    <!-- loop 시작 -->                                
                      <tr>
					    <td nowrap="nowrap">
					       <input type="checkbox" name="checkField" class="check2" title="선택"/>
					       <input name="checkMenuNo" type="hidden" value="<c:out value='${result.menuNo}'/>"/>
					    </td>
					    <td nowrap="nowrap"><c:out value="${result.menuNo}"/></td>
					    <td nowrap style="cursor:hand;">
					       <span class="link"><a href="<c:url value='/sym/mpm/EgovMenuManageListDetailSelect.do?req_menuNo='/>${result.menuNo}" onclick="selectUpdtMenuManageDetail('<c:out value="${result.menuNo}"/>'); return false;"><c:out value="${result.menuNm}"/></a></span>
					    </td>
					    <td nowrap="nowrap"><c:out value="${result.progrmFileNm}"/></td>
					    <td nowrap="nowrap"><c:out value="${result.menuDc}"/></td>  
					    <td nowrap="nowrap"><c:out value="${result.upperMenuId}"/></td>  
                      </tr>
                     </c:forEach>     
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
                        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>                        
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  

            </form>

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