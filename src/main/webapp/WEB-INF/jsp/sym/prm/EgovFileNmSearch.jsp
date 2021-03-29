<%--
  Class Name : EgovFileNmSearch.jsp
  Description : 프로그램파일명 검색 화면
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
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/popup.css" rel="stylesheet" type="text/css" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
<title>프로그램파일명 검색</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script language="javascript1.2"  type="text/javaScript"> 
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.progrmManageForm.pageIndex.value = pageNo;
	document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListSearch.do'/>";
   	document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */ 
function selectProgramListSearch() { 
	document.progrmManageForm.pageIndex.value = 1;
	document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListSearch.do'/>";
	document.progrmManageForm.submit();
}

/* ********************************************************
 * 프로그램목록 선택 처리 함수
 ******************************************************** */ 
function choisProgramListSearch(vFileNm) { 
	eval("opener.document.all."+opener.document.all.tmp_SearchElementName.value).value = vFileNm;
	if(opener.document.all.progrmFileNm_view){
		opener.document.all.progrmFileNm_view.value = vFileNm;
	}
    window.close();
}
//-->
</script>
</head>
<body> 
<form name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListSearch.do'/>" method="post">
<input type="submit" id="invisible" class="invisible"/>
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
    <!-- 검색 필드 박스 시작 -->
    <div id="search_field">
        <div id="search_field_loc" class="h_title">프로그램파일명 검색</div>
            <fieldset><legend>조건정보 영역</legend>    
            <div class="sf_start">
                <ul id="search_first_ul">
                    <li>
                        <label for="searchKeyword">프로그램파일명 : </label>
                        <input id="searchKeyword" name="searchKeyword" type="text" size="30" value=""  maxlength="60" title="검색조건">
                    </li>       
                </ul>
                <ul id="search_second_ul">
                    <li>
                        <div class="buttons" style="float:right;">
                            <a href="#LINK" onclick="javascript:selectProgramListSearch(); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
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
        <table width="100%" summary="프로그램파일명 검색목록으로 프로그램파일명 프로그램명으로 구성됨">
            <caption>프로그램파일명 검색</caption>
            <colgroup>
            <col width="50%" >
            <col width="50%" >  
            </colgroup>
            <thead>
            <tr>
                <th scope="col" class="f_field" nowrap="nowrap">프로그램파일명</th>
                <th scope="col" nowrap="nowrap">프로그램명</th>
            </tr>
            </thead>
            <tbody>                 
            
            <c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
            <!-- loop 시작 -->                                
              <tr>
			    <td nowrap="nowrap">
			        <span class="link"><a href="#LINK" onclick="choisProgramListSearch('<c:out value="${result.progrmFileNm}"/>'); return false;">
			      <c:out value="${result.progrmFileNm}"/></a></span></td>
			    <td nowrap="nowrap"><c:out value="${result.progrmKoreanNm}"/></td>
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
</body>
</html>

