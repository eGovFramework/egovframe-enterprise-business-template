<%--
  Class Name : EgovCcmCmmnClCodeList.jsp
  Description : EgovCcmCmmnClCodeList 화면
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>공통분류코드 목록</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fnRegist(){
    location.href = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(clCode){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeDetail.do'/>";
    varForm.clCode.value     = clCode;
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    // 
}
//-->
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
            <form name="listForm" action="<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'/>" method="post">
            <input type="submit" id="invisible" class="invisible"/>
            
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>내부시스템관리</li>
                            <li>&gt;</li>
                            <li>코드관리</li>
                            <li>&gt;</li>
                            <li><strong>분류코드관리</strong></li>
                        </ul>
                    </div>
                </div>

                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>공통분류코드 목록</strong></h2></div>
                        
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
								    <select name="searchCondition" title="검색조건" class="select" >
							           <option selected value=''>--선택하세요--</option>
							           <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>분류코드</option>
							           <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>분류코드명</option>
							        </select>
                                </li>
                                <li>
                                    <input name="searchKeyword" title="검색어" type="text" size="35" value="${searchVO.searchKeyword}"  maxlength="35" id="searchKeyword" >
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="position:absolute;left:870px;top:200px;">
                                        <a href="#noscript" onclick="fnSearch(); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                        <a href="#noscript" onclick="fnRegist(); return false;">등록</a> 
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
                    <table summary="분류코드, 분류코드명, 사용여부를 조회하는 공통분류코드 목록 테이블이다." cellpadding="0" cellspacing="0">
                    <caption>공통분류코드 목록</caption>
                    <colgroup>
                    <col width="10%" >
                    <col width="20%" >  
                    <col width="50%" >
                    <col width="20%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col" class="f_field" nowrap="nowrap">순번</th>
                        <th scope="col" nowrap="nowrap">분류코드</th>
                        <th scope="col" nowrap="nowrap">분류코드명</th>
                        <th scope="col" nowrap="nowrap">사용여부</th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                    <!-- loop 시작 -->                                
						<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fnDetail('${resultInfo.clCode}');">
						    <td nowrap="nowrap"><strong><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></strong></td>
						    <td nowrap="nowrap">${resultInfo.clCode}</td>
						    <td nowrap="nowrap">${resultInfo.clCodeNm}</td>
						    <td nowrap="nowrap"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
						</tr>   
                    </c:forEach>     
					<c:if test="${fn:length(resultList) == 0}">
					    <tr> 
					        <td colspan=4>
					            <spring:message code="common.nodata.msg" />
					        </td>
					    </tr>                                              
					</c:if>
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
				        <ui:pagination paginationInfo = "${paginationInfo}"
				                type="image"
				                jsFunction="linkPage"
				                />
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  
                
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            </form>

			<form name="Form" method="post" action="<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeDetail.do'/>">
			    <input type=hidden name="clCode">
			    <input type="submit" class="invisible"/>
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