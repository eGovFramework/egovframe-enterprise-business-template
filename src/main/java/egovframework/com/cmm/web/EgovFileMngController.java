package egovframework.com.cmm.web;

import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cryptography.EgovCryptoService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일          수정자        수정내용
 *  ----------     --------    ---------------------------
 *  2009.03.25     이삼섭        최초 생성
 *  2016.10.13     장동한        deleteFileInf 메소드 return 방식 수정
 *  2022.12.02     윤창원        File ID 암호화 처리
 *  2022.12.22     신용호        JSTL 커스텀 태그 추가 및 기능 보완
 *   2024.08.10  이백행          이클립스 문제(Problems) 제거
 *
 *      </pre>
 */
@Controller
public class EgovFileMngController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovFileMngController.class);

	/** 암호화서비스 */
	private static EgovCryptoService cryptoService;

	@Resource(name = "egovARIACryptoService")
	public void setEgovCryptoService(EgovCryptoService cryptoService) {
		EgovFileMngController.cryptoService = cryptoService;
	}

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;

	// 주의 : 반드시 기본값 "egovframe"을 다른것으로 변경하여 사용하시기 바랍니다.
	public static final String ALGORITHM_KEY = EgovProperties.getProperty("Globals.File.algorithmKey");

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
	public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, HttpServletRequest request,
			@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		byte[] encrypted_atchFileId = Base64.getDecoder().decode(param_atchFileId);
		String decodedAtchFileId = "";
		if (param_atchFileId != null && !"".equals(param_atchFileId)) {
			decodedAtchFileId = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
		}

		fileVO.setAtchFileId(decodedAtchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.atchFileId;
			file.setAtchFileId(
					Base64.getEncoder().encodeToString(cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY)));
		}

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", param_atchFileId);

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
	public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO,
			@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		byte[] encrypted_atchFileId = Base64.getDecoder().decode(param_atchFileId);
		String decodedAtchFileId = "";
		if (param_atchFileId != null && !"".equals(param_atchFileId)) {
			decodedAtchFileId = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
		}

		fileVO.setAtchFileId(decodedAtchFileId);

		List<FileVO> result = fileService.selectFileInfs(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.atchFileId;
			file.setAtchFileId(
					Base64.getEncoder().encodeToString(cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY)));
		}

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", param_atchFileId);

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
	public String deleteFileInf(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam("returnUrl") String returnUrl,
			HttpServletRequest request, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
			fileService.deleteFileInf(fileVO);
		}

		// --------------------------------------------
		// contextRoot가 있는 경우 제외 시켜야 함
		// --------------------------------------------
		//// return "forward:/cmm/fms/selectFileInfs.do";
		// return "forward:" + returnUrl;

		if ("".equals(request.getContextPath()) || "/".equals(request.getContextPath())) {
			return "forward:" + returnUrl;
		}

		if (returnUrl.startsWith(request.getContextPath())) {
			return "forward:" + returnUrl.substring(returnUrl.indexOf("/", 1));
		} else {
			return "forward:" + returnUrl;
		}
		//// ------------------------------------------
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
	public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO,
			@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("atchFileId");
		String decodedAtchFileId = "";
		if (param_atchFileId != null && !"".equals(param_atchFileId)) {
			byte[] encrypted_atchFileId = Base64.getDecoder().decode(param_atchFileId);
			decodedAtchFileId = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
			decodedAtchFileId = StringUtils.substringAfter(decodedAtchFileId, "|");
		}

		fileVO.setAtchFileId(decodedAtchFileId);
		List<FileVO> result = fileService.selectImageFileList(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.atchFileId;
			file.setAtchFileId(
					Base64.getEncoder().encodeToString(cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY)));
		}

		model.addAttribute("fileList", result);

		return "cmm/fms/EgovImgFileList";
	}

	/**
	 * 원본 문자열을 암호화 하는 메서드.
	 * 
	 * @param source 원본 문자열
	 * @return 암호화 문자열
	 */
	public static String encrypt(String atchFileId) {
		String returnVal = "-";
		returnVal = Base64.getEncoder().encodeToString(cryptoService.encrypt(atchFileId.getBytes(), ALGORITHM_KEY));
		return returnVal;
	}

	/**
	 * 원본 문자열을 암호화 하는 메서드.
	 * 
	 * @param source 원본 문자열
	 * @return 암호화 문자열
	 */
	public static String encryptSession(String atchFileId, String sessionId) {
		String returnVal = "-";
		String toEncrypt = sessionId + "|" + atchFileId;
		returnVal = Base64.getEncoder().encodeToString(cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY));
		return returnVal;
	}

	/**
	 * 암호화 문자열을 복호화 하는 메서드.
	 * 
	 * @param source 암호화 문자열
	 * @return 원본 문자열
	 */
	public static String decrypt(String base64AtchFileId) {
		String returnVal = "FILE_ID_DECRIPT_EXCEPTION_02";
		if (base64AtchFileId != null && !"".equals(base64AtchFileId)) {
			try {
				byte[] encrypted_atchFileId = Base64.getDecoder().decode(base64AtchFileId);
				returnVal = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
			} catch (Exception e) {
				LOGGER.debug(e.getMessage());
			}
		}
		return returnVal;
	}
}
