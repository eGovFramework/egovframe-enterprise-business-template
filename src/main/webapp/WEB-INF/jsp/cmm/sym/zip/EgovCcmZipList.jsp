<%--
  Class Name : EgovCcmZipList.jsp
  Description : EgovCcmZipList 화면
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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<title>내부업무 사이트 > 내부시스템관리 > 우편번호관리</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){
    sC = document.listForm.searchCondition.value;
    sK = document.listForm.searchKeyword.value; 
    if (sC == "1") {
        document.listForm.searchKeyword.value = sK.replace(/\-/, "");
    }
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipRegist.do'/>";
}
/* ********************************************************
 * 엑셀등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmExcelZipRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Zip(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Zip(zip,sn){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipDetail.do'/>";
    varForm.zip.value        = zip;
    varForm.sn.value         = sn;
    varForm.submit();
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
                                        <li>우편번호관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="listForm" action="<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>" method="post">

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">우편번호관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition">
                                    <label class="item f_select" for="sel1">
                                        <select id="sel1" name="searchCondition" class="select" title="searchCondition">
                                            <option selected="" value="">선택하세요</option>
                                            <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>우편번호</option>
                                            <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>시도명</option>
                                            <option value='3' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>>시군구명</option>
                                            <option value='4' <c:if test="${searchVO.searchCondition == '4'}">selected="selected"</c:if>>읍면동명</option>
                                            <option value='5' <c:if test="${searchVO.searchCondition == '5'}">selected="selected"</c:if>>리건물명</option>
                                        </select>
                                    </label>
                                    <span class="item f_search">
                                        <input class="f_input w_500" name="searchKeyword" type="text" value="${searchVO.searchKeyword}" maxlength="35" id="searchKeyword">
                                        <button class="btn" type="submit" onclick="fn_egov_search_Zip(); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <div class="board_list_top">
                                    <div class="left_col">
                                    </div>

                                    <div class="right_col">
                                        <a href="#LINK" class="item btn btn_blue_46 w_100" onclick="fn_egov_regist_Zip(); return false;"><spring:message code='button.create' /></a><!-- 등록 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_regist_ExcelZip(); return false;">엑셀등록</a><!-- 엑셀등록 -->
                                    </div>
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="우편번호와 주소를 출력하는 우편번호 목록 테이블이다.">
                                    	<caption>공통코드 목록</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">우편번호</th>
                                                <th scope="col">주소</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        		<tr>
                                        			<td colspan=3><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                            <tr>
                                                <td><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
                                                <td><a href="#LINK" class="lnk" onclick="javascript:fn_egov_detail_Zip('${resultInfo.zip}','${resultInfo.sn}');"><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></a></td>
                                                <td>${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm} ${resultInfo.lnbrDongHo}</td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_pageview" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- // 페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
                                
                                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                                
                                </form>

								<form name="Form" method="post" action="<c:url value='/sym/ccm/zip/EgovCcmZipDetail.do'/>">
								    <input type="hidden" name="zip">
								    <input type="hidden" name="sn">
								</form>
                                
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