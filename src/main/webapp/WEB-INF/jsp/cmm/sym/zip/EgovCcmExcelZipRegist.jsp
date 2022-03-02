<%--
  Class Name : EgovCcmExcelZipRegist.jsp
  Description : EgovCcmExcelZipRegist 화면
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

<title>내부업무 사이트 > 내부시스템관리 > 우편번호관리</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
    var varForm              = document.all["Form"];

    // 파일 확장명 확인
    var arrExt      = "xls";
    var objInput    = varForm.elements["fileNm"];
    var strFilePath = objInput.value;
    var arrTmp      = strFilePath.split(".");
    var strExt      = arrTmp[arrTmp.length-1].toLowerCase();

    if (arrExt != strExt) {
        alert("엑셀 파일을 첨부하지 않았습니다.\n확인후 다시 처리하십시오. ");
        abort;
    } 
    
    varForm.action           = "/sym/ccm/zip/EgovCcmExcelZipRegist.do";
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

								<form name="Form" action="<c:url value='/sym/ccm/zip/EgovCcmZipRegist.do'/>" method="post" enctype="multipart/form-data" >

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">우편번호관리</h2>

                                <div class="board_view2">
                                    <table summary="우편번호 엑셀파일을 첨부할 수 있는 등록 테이블이다.">
                                        <colgroup>
                                            <col style="width: 230px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="fileNm">우편번호 엑셀파일 등록</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="fileNm" type="file" id="fileNm" class="f_file" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_regist_ExcelZip(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_list_Zip(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input name="cmd" type="hidden" value="<c:out value='ExcelZipRegist'/>"/>
                                
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