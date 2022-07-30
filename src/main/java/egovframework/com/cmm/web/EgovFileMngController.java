package egovframework.com.cmm.web;

import java.awt.Desktop;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.25  이삼섭          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Controller
public class EgovFileMngController {

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;

	/**
	 * 첨부파일에 대한 목록을 조회한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/selectFileInfs.do")
	public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		String atchFileId = (String) commandMap.get("param_atchFileId");

		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);

		return "cmm/fms/EgovFileList";
	}

	/**
	 * 첨부파일 변경을 위한 수정페이지로 이동한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/selectFileInfsForUpdate.do")
	public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		String atchFileId = (String) commandMap.get("param_atchFileId");

		fileVO.setAtchFileId(atchFileId);

		List<FileVO> result = fileService.selectFileInfs(fileVO);

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);

		return "cmm/fms/EgovFileList";
	}

	/**
	 * 첨부파일에 대한 삭제를 처리한다.
	 *
	 * @param fileVO
	 * @param returnUrl
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/deleteFileInfs.do")
	public String deleteFileInf(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam("returnUrl") String returnUrl, HttpServletRequest request, ModelMap model)
			throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
			fileService.deleteFileInf(fileVO);
		}

		//--------------------------------------------
		// contextRoot가 있는 경우 제외 시켜야 함
		//--------------------------------------------
		////return "forward:/cmm/fms/selectFileInfs.do";
		//return "forward:" + returnUrl;

		if ("".equals(request.getContextPath()) || "/".equals(request.getContextPath())) {
			return "forward:" + returnUrl;
		}

		if (returnUrl.startsWith(request.getContextPath())) {
			return "forward:" + returnUrl.substring(returnUrl.indexOf("/", 1));
		} else {
			return "forward:" + returnUrl;
		}
		////------------------------------------------
	}

	/**
	 * 이미지 첨부파일에 대한 목록을 조회한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/selectImageFileInfs.do")
	public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		String atchFileId = (String) commandMap.get("atchFileId");

		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectImageFileList(fileVO);

		model.addAttribute("fileList", result);

		return "cmm/fms/EgovImgFileList";
	}
	
	/**
     * 첨부파일로 등록된 파일에 대하여 보기를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
	@RequestMapping(value = "/cmm/fms/FileOpen.do")
	public void FileOpen(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String atchFileId = (String) commandMap.get("atchFileId");
		String fileSn = (String) commandMap.get("fileSn");
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
		
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			fileVO.setFileSn(fileSn);
			FileVO fvo = fileService.selectFileInf(fileVO);

			File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
			long fSize = uFile.length();
			
			if (fSize > 0) {
				
				FileInputStream fis = null;
				BufferedOutputStream bos = null;
				String ext = fvo.getFileExtsn();
				
				try {
					if (ext.equals("csv")) {
						response.setContentType("text/csv");
					} else if (ext.equals("doc")) {
						response.setContentType("application/msword");
					} else if (ext.equals("gif")) {
						response.setContentType("image/gif");
					} else if (ext.equals("htm")||ext.equals("html")) {
						response.setContentType("text/html");
					} else if (ext.equals("jpg")||ext.equals("jpeg")) {
						response.setContentType("image/jpeg");
					} else if (ext.equals("pdf")) {
						response.setContentType("application/pdf");
					} else if (ext.equals("ppt")) {
						response.setContentType("application/vnd.ms-powerpoint");
					} else if (ext.equals("xml")) {
						response.setContentType("application/xml");
					} else if (ext.equals("png")) {
						response.setContentType("image/png");
					} else if (ext.equals("txt")) {
						response.setContentType("text/plain");
					} else if (ext.equals("hwp")) {
						response.setContentType("application/haansofthwp");
					} else if (ext.equals("hwpx")) {
						response.setContentType("application/haansofthwpx");
					} else {
						response.addHeader("else", "true");
						try
						{
							if(!Desktop.isDesktopSupported())
							{
							    System.out.println("not supported");
							    return;
							}
							Desktop desktop = Desktop.getDesktop();
							if(uFile.exists()) {
							    desktop.open(uFile);
							}
							return;
						}
						catch(Exception e)
						{
							e.printStackTrace();
							return;
						}
					}
					
					fis = new FileInputStream(uFile);
					int size = fis.available();
					byte[] buf = new byte[size];
					int readCount = fis.read(buf);
					
					response.flushBuffer();
					bos = new BufferedOutputStream(response.getOutputStream());
					bos.write(buf, 0, readCount);
					bos.flush();
				} catch(Exception e) {
					 e.printStackTrace();
				} finally {
					 try {
						 if (fis != null) fis.close();
						 if (bos != null) bos.close();
					 } catch (IOException e) {
						 e.printStackTrace();
					 }
				}
			}
			
		} else {
			
			request.getRequestDispatcher("/cmm/error/egovBizException.jsp").forward(request, response);
						
		}
	}
}
