<%--
  Class Name : EgovFileList.jsp
  Description : 파일 목록화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.26   이삼섭          최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.26 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<script type="text/javascript">
<!--
    function fn_egov_downFile(atchFileId, fileSn){
        window.open("<c:url value='/cmm/fms/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
    }   
    
    function fn_egov_deleteFile(atchFileId, fileSn) {
        // 동적으로 form을 생성하여 제출 (form nesting 문제 해결)
        var form = document.createElement("form");
        form.method = "POST";
        form.action = "<c:url value='/cmm/fms/deleteFileInfs.do'/>";

        var fields = {
            "atchFileId": atchFileId,
            "fileSn": fileSn,
            "returnUrl": window.location.pathname + window.location.search
        };

        for (var key in fields) {
            var input = document.createElement("input");
            input.type = "hidden";
            input.name = key;
            input.value = fields[key];
            form.appendChild(input);
        }

        document.body.appendChild(form);
        form.submit();
    }
    
    function fn_egov_check_file(flag) {
        if (flag=="Y") {
            document.getElementById('file_upload_posbl').style.display = "block";
            document.getElementById('file_upload_imposbl').style.display = "none";          
        } else {
            document.getElementById('file_upload_posbl').style.display = "none";
            document.getElementById('file_upload_imposbl').style.display = "block";
        }
    }
//-->
</script>

<div id="fileListDiv">

<c:forEach var="fileVO" items="${fileList}" varStatus="status">
	<c:choose>
		<c:when test="${updateFlag=='Y'}">
			<c:out value="${fileVO.orignlFileNm}"/>&nbsp;<span>[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]</span>
			<input type="button" value="삭제" onClick="fn_egov_deleteFile('<c:out value="${atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>');">
		</c:when>
		<c:otherwise>
			<a href="#LINK" onclick="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>')">
				<c:out value="${fileVO.orignlFileNm}"/>
			</a>
			&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
		</c:otherwise>
	</c:choose>
	<div style="padding: 3px;"></div>
</c:forEach>
<c:if test="${fn:length(fileList) == 0}">
</c:if>
</div>

<script type="text/javascript">
// 파일 목록 업데이트 및 파일 업로드 버튼 표시 로직
setTimeout(function() {
    var updateFlag = "<c:out value='${updateFlag}'/>";
    var fileListCntValue = "<c:out value='${fileListCnt}'/>";

    // 부모 form 찾기
    var fileListDiv = document.getElementById('fileListDiv');
    var parentForm = fileListDiv;
    while (parentForm && parentForm.tagName !== 'FORM') {
        parentForm = parentForm.parentElement;
    }

    if (parentForm) {
        // fileListCnt 업데이트 또는 생성
        var fileListCntInput = parentForm.querySelector("input[name='fileListCnt']");
        if (!fileListCntInput) {
            fileListCntInput = document.createElement("input");
            fileListCntInput.type = "hidden";
            fileListCntInput.name = "fileListCnt";
            fileListCntInput.value = fileListCntValue;
            parentForm.appendChild(fileListCntInput);
        } else {
            fileListCntInput.value = fileListCntValue;
        }

        // 수정 모드일 때만 파일 업로드 버튼 처리
        if (updateFlag === 'Y') {
            var maxFileNumInput = parentForm.querySelector("input[name='posblAtchFileNumber']");

            if (maxFileNumInput) {
                var existFileNum = parseInt(fileListCntValue, 10);
                var maxFileNum = parseInt(maxFileNumInput.value, 10);
                var uploadableFileNum = maxFileNum - existFileNum;

                if (uploadableFileNum > 0) {
                    fn_egov_check_file("Y");

                    // MultiSelector 초기화 (부모 페이지에서 정의된 경우)
                    if (typeof MultiSelector !== 'undefined') {
                        var listContainer = document.getElementById("egovComFileList");
                        var uploader = document.getElementById("egovComFileUploader");

                        if (listContainer && uploader) {
                            var multiSelector = new MultiSelector(listContainer, maxFileNum);
                            multiSelector.addElement(uploader);
                        }
                    }
                } else {
                    fn_egov_check_file("N");
                }
            }
        }
    }
}, 50);
</script>