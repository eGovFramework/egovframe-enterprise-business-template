<%--
  Class Name : EgovMenuBndeRegist.jsp
  Description : 메뉴프로그램목록 일괄 등록 화면
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images_old/egovframework/sym/mpm/icon";
  String imagePath_button = "/images_old/egovframework/sym/mpm/button/";
%>
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

<script  language="javascript1.2" type="text/javaScript">
/* ********************************************************
 * 메뉴일괄생성처리 함수
 ******************************************************** */
function insertMenuManage() {
    if(confirm("메뉴일괄등록을 하시겠습니까?. \n 메뉴정보와  프로그램목록, 프로그램 변경내역 존재시 삭제 하실 수 없습니다.")){
       if(checkFile()){
           document.menuManageRegistForm.action ="<c:url value='/sym/mnu/mpm/EgovMenuBndeRegist.do'/>";
          document.menuManageRegistForm.submit();
       }
    }
}
/* ********************************************************
 * 메뉴일괄삭제처리 함수
 ******************************************************** */
function deleteMenuList() {
    if(confirm("메뉴일괄삭제를 하시겠습니까?. \n 메뉴정보와  프로그램목록, 프로그램 변경내역 데이타 모두  삭제 삭제처리 됩니다.")){
        document.menuManageRegistForm.action ="<c:url value='/sym/mpm/EgovMenuBndeAllDelete.do'/>";
        document.menuManageRegistForm.submit();
    }
}
/* ********************************************************
 * 메뉴일괄등록시 등록파일 체크 함수
 ******************************************************** */
function checkFile(){ 
    if(document.menuManageRegistForm.file.value==""){
       alert("업로드 할 파일을 지정해 주세요");
       return false;
    }

    var  str_dotlocation,str_ext,str_low;
    str_value  = document.menuManageRegistForm.file.value;
    str_low   = str_value.toLowerCase(str_value);
    str_dotlocation = str_low.lastIndexOf(".");
    str_ext   = str_low.substring(str_dotlocation+1);
    
    switch (str_ext) {
      case "xls" :
      case "xlsx" :
         return true;
         break;
      default:
         alert("파일 형식이 맞지 않습니다.\n xls,XLS,xlsx,XLSX 만\n 업로드가 가능합니다!");
         return false;
    }
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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

								<form name="menuManageRegistForm" action ="<c:url value='/sym/mpm/EgovMenuBndeRegist.do'/>" method="post" enctype="multipart/form-data">

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">메뉴목록관리</h2>

                                <div class="board_view2">
                                    <table summary="메뉴일괄등록">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min"><label for="file">일괄파일</label></span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input type="file" id="file" class="f_file" name="file" title="일괄파일"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:insertMenuManage(); return false;"><spring:message code='button.save' /></a><!-- 저장 -->
                                        <a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" class="btn btn_blue_46 w_100" onclick="selectList(); return false;"><spring:message code='button.list' /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input name="cmd" type="hidden" value="<c:out value='bndeInsert'/>"/>
                                
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