<%--
  Class Name : EgovLoginLogList.jsp
  Description : 로그인 로그 정보목록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.11  이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀  이삼섭
    since    : 2009.03.11  
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript">
	/* ********************************************************
	* PROTOTYPE JS FUNCTION
	******************************************************** */
	String.prototype.trim = function(){
	    return this.replace(/^\s+|\s+$/g, "");
	}
	
	String.prototype.replaceAll = function(src, repl){
	     var str = this;
	     if(src == repl){return str;}
	     while(str.indexOf(src) != -1) {
	        str = str.replace(src, repl);
	     }
	     return str;
	}

	function fn_egov_select_loginLog(pageNo){
	    var fromDate = document.frm.searchBgnDe.value;
	    var toDate = document.frm.searchEndDe.value;
	    
	    fromDate = fromDate.replaceAll('-','');
        toDate = toDate.replaceAll('-','');
        
	    if(fromDate > toDate) {
	        alert("종료일자는 시작일자보다  이후날짜로 선택하세요.");
	        //return false;
	    } else {
	        document.frm.pageIndex.value = pageNo;
	        document.frm.action = "<c:url value='/sym/log/clg/SelectLoginLogList.do'/>";
	        document.frm.submit();
	    }
	}
   
    function fn_egov_inqire_loginLog(logId){
        var url = "<c:url value ='/sym/log/clg/InqireLoginLog.do?logId='/>" + logId;
        
        var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=640,height=320,left=0,top=0"; 
        window.open(url,"p_loginLogInqire", openParam);
    }
</script>
<title>로그인 로그 목록</title>
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
            <form name="frm" id="frm" action ="<c:url value='/sym/log/SelectLoginLogList.do'/>" method="post">
            <input type="submit" id="invisible" class="invisible"/>
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>내부서비스관리</li>
                            <li>&gt;</li>
                            <li>사용현황관리</li>
                            <li>&gt;</li>
                            <li><strong>접속로그관리</strong></li>
                        </ul>
                    </div>
                </div>

                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>로그인 로그조회</strong></h2></div>
						
						<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
                        <fieldset><legend>조건정보 영역</legend>
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>발생일자
							          <!-- input name="searchBgnDe" type="hidden"  value="<c:out value='${searchVO.searchBgnDe}'/>" -->
							          <input name="searchBgnDe" type="text" size="10" value="${searchVO.searchBgnDe}"  readOnly
							            onClick="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchBgnDe);" title="시작일자입력">
							          <a href="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchBgnDe);"
							            style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif' />" alt="달력창팝업버튼이미지"
							            width="15" height="15"></a>
							          ~
							          <!-- input name="searchEndDe" type="hidden"  value="<c:out value='${searchVO.searchEndDe}'/>"-->
							          <input name="searchEndDe" type="text" size="10" value="${searchVO.searchEndDe}"  readOnly
							            onClick="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchEndDe);" title="종료일자입력">
							          <a href="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchEndDe);"
							            style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif' />" alt="달력창팝업버튼이미지"
							            width="15" height="15"></a>
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="<c:url value='/sym/log/SelectLoginLogList.do'/>" onclick="javascript:fn_egov_select_loginLog('1'); return false;" >
                                            <img src="<c:url value='/images/img_search.gif' />" alt="search" >조회
                                        </a>
                                        <a href="#LINK" onclick="document.frm.searchBgnDe.value=''; document.frm.searchEndDe.value=''; return false;" >초기화 </a>
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
                    <table cellpadding="0" cellspacing="0">
                    <caption>로그인 로그조회</caption>
                    <colgroup>
                        <col width="10%" >
                        <col width="20%" >  
                        <col width="20%" >
                        <col width="20%" >
                        <col width="20%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col" class="f_field" nowrap="nowrap">번호</th>
                        <th scope="col" nowrap="nowrap">로그ID</th>
                        <th scope="col" nowrap="nowrap">발생일자</th>
                        <th scope="col" nowrap="nowrap">로그유형</th>
                        <th scope="col" nowrap="nowrap">상세보기</th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <!-- loop 시작 -->                                
                        <tr>
					        <td nowrap="nowrap"><strong><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></strong></td>
					        <td nowrap="nowrap"><c:out value="${result.logId}"/></td>
					        <td nowrap="nowrap"><c:out value="${result.creatDt}"/></td>
					        <td nowrap="nowrap"><c:out value="${result.loginMthd}"/></td>    
					        <td nowrap="nowrap">
					        <a href="#LINK" onclick="javascript:fn_egov_inqire_loginLog('<c:out value="${result.logId}"/>'); return false;" 
					            style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/search.gif'/>"  alt="상세보기"
					            width="15" height="15" align="middle"></a>
					        </td>
                        </tr>
                    </c:forEach>     
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
				        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_loginLog" />
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
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