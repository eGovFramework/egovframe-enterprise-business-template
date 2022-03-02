<%--
  Class Name : EgovGroupSearch.jsp
  Description : EgovGroupSearch Search 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23    lee.m.j              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.03.23
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

<title>그룹 정보</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var checkCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    returnValue = checkField[i].value;
                }
            }

            if(checkCount > 1) {
                alert("하나 이상의 그룹이 선택되었습니다.");
                return;
            } else if(checkCount < 1) {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        } else {
        	if(checkField.checked == true) {
        		returnValue = checkId.value;
        	} else {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        }

        returnBoolean = true;

    } else {
    	alert("조회 결과가 없습니다.");
    }

    document.listForm.groupId.value = returnValue;

    return returnBoolean;
    
}

function fncSelectGroupList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectGroup(groupId) {
 // window.returnValue = groupId;
    parent.document.listForm.searchKeyword.value = groupId;
    fn_egov_cancel_popup();
}

function fncSelectGroupConfirm() {
	if(fncManageChecked()) {
		opener.listForm.searchKeyword.value = document.listForm.groupId.value;
     // window.returnValue = document.listForm.groupId.value;
		window.close();
	}
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectGroupList('1');
    }
}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}
//-->
</script>

</head>

<body>

	<form name="listForm" action="<c:url value='/sec/gmt/EgovGroupSearchList.do'/>" method="post">
	
	<!-- 그룹 조회 팝업 -->
    <div class="popup POP_GROUP_SEARCH">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>그룹 조회 팝업</h1>
                <button type="button" class="close"  onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition2">
                    <label for="searchKeyword" class="lb mr10">그룹 명 : </label>
                    <span class="item f_search">
                        <input id="searchKeyword" class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${groupManageVO.searchKeyword}'/>" title="검색" onkeypress="press();" />
                        <button class="btn" type="submit" onclick="javascript:fncSelectGroupList('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                    </span>
                </div>
                <!--// 검색조건 -->

                <!-- 게시판 -->
                <div class="board_list">
                    <table summary="그룹 조회 결과를  보여주는 테이블입니다.그룹 ID,그룹 명의 정보를 담고 있습니다.">
                    	<caption>그룹 조회 팝업</caption>
                        <colgroup>
                            <col style="width: 30%;">
                            <col style="width: auto;">
                            <col style="width: 150px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">그룹 ID</th>
                                <th scope="col">그룹 명</th>
                                <th scope="col">선택</th>
                            </tr>
                        </thead>
                        <tbody>
                        	
                        	<c:if test="${empty groupList}">
                        		<tr>
                        			<td colspan="3">검색된 결과가 없습니다.</td>
                        		</tr>
                        	</c:if>
                        	
                        	<c:forEach var="group" items="${groupList}" varStatus="status">
                            <tr>
                                <td><c:out value="${group.groupId}"/></td>
                                <td><c:out value="${group.groupNm}"/></td>
                                <td><a href="#LINK" class="btn btn_blue_30 w_80" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')">선택</a></td>
                            </tr>
                            </c:forEach>
                            
                        </tbody>
                    </table>
                </div>

				<!-- 페이지 네비게이션 시작 -->
				<c:if test="${!empty groupManageVO.pageIndex }">
                <div class="board_list_bot">
                    <div class="paging" id="paging_div">
                        <ul>
                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                        </ul>
                    </div>
                </div>
                </c:if>
                <!-- // 페이지 네비게이션 끝 -->
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!--// 그룹 조회 팝업 -->
    
    <input type="hidden" name="groupId"/>
	<input type="hidden" name="groupIds"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
	<input type="hidden" name="searchCondition"/>
	
	</form>
    
</body>
</html>
