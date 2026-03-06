package egovframework.let.uat.uap.filter;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import egovframework.let.utl.sim.service.EgovClntInfo;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/**
 * 로그인 정책 체크 필터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성
 *
 *  </pre>
 */
/**
 * 로그인 정책 체크 필터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성
 *
 *  </pre>
 */


public class EgovLoginPolicyFilter implements Filter {

	private FilterConfig config;

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovLoginPolicyFilter.class);

	public void destroy() {

	}


	/**
	 * IP를 이용해 로그인을 제한하는 메서든
	 * @param request
	 * @param response
	 * @param chain
	 * @return void
	 * @exception IOException, ServletException
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		EgovLoginPolicyService egovLoginPolicyService = (EgovLoginPolicyService) act.getBean("egovLoginPolicyService");
		EgovMessageSource egovMessageSource = (EgovMessageSource)act.getBean("egovMessageSource");

		HttpServletRequest httpRequest = (HttpServletRequest)request;

		String id = request.getParameter("id");
		//String password = request.getParameter("password");
		String userSe = request.getParameter("userSe");
		String userIp = "";

		if (id == null || userSe == null) {//if (id == null || password == null || userSe == null) {
			((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do");
		}

		// 1. LoginVO를 DB로 부터 가져오는 과정

		try {
			// 접속IP
			userIp = EgovClntInfo.getClntIP((HttpServletRequest) request);

			boolean loginPolicyYn = true;

			LoginPolicyVO loginPolicyVO = new LoginPolicyVO();
			loginPolicyVO.setEmplyrId(id);
			loginPolicyVO = egovLoginPolicyService
					.selectLoginPolicy(loginPolicyVO);

			if (loginPolicyVO == null) {
				loginPolicyYn = true;
			} else {
				// 26.03.04 KISA 보안취약점 조치 : equals 비교 개선
				if ("Y".equals(loginPolicyVO.getLmttAt())) {
					if (!userIp.equals(loginPolicyVO.getIpInfo())) {
						loginPolicyYn = false;
					}
				}
			}

			if (loginPolicyYn) {
				chain.doFilter(request, response);

			} else {
				((HttpServletRequest) request).setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
				((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do");
			}

			// 26.03.04 KISA 보안취약점 조치 : 구체적인 Exception 추가
		} catch (DataAccessException e) {
			// DB 조회(selectLoginPolicy) 중 오류
			LOGGER.error("Exception:  {}", e.getClass().getName());
			LOGGER.error("Exception  Message:  {}", e.getMessage());
			((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do?login_error=1");
		} catch (ServletException e) {
			// chain.doFilter() 처리 중 오류
			LOGGER.error("Exception:  {}", e.getClass().getName());
			LOGGER.error("Exception  Message:  {}", e.getMessage());
			((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do?login_error=1");
		} catch (IOException e) {
			// sendRedirect() 또는 chain.doFilter() 중 I/O 오류
			LOGGER.error("Exception:  {}", e.getClass().getName());
			LOGGER.error("Exception  Message:  {}", e.getMessage());
			((HttpServletResponse) response).sendRedirect(httpRequest.getContextPath() + "/uat/uia/egovLoginUsr.do?login_error=1");
		}



	}

	public void init(FilterConfig config) throws ServletException {

		this.config = config;

	}

}
