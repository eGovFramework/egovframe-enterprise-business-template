package egovframework.let.sym.log.clg.service;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

import egovframework.com.cmm.LoginVO;

/**
 * 시스템 로그 생성을 위한 ASPECT 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이삼섭          최초 생성
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.clg)
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
public class EgovLoginLogAspect {

	@Resource(name="EgovLoginLogService")
	private EgovLoginLogService loginLogService;

	/**
	 * 로그인 로그정보를 생성한다.
	 * EgovLoginController.actionMain Method
	 *
	 * @param
	 * @return void
	 * @throws Exception
	 */
	public void logLogin(LoginVO loginVO) throws Throwable {
		
		String uniqId = "";
		String ip = "";
        
        uniqId = loginVO.getUniqId();
    	/* 실제 클라이언트 ip를 얻고자 할 경우 EgovClntInfo.getClntIP() 사용 가능 */
    	ip = "127.0.0.1";

    	LoginLog loginLog = new LoginLog();
    	loginLog.setLoginId(uniqId);
        loginLog.setLoginIp(ip);
        loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
        loginLog.setErrOccrrAt("N");
        loginLog.setErrorCode("");
        loginLogService.logInsertLoginLog(loginLog);
	}

	/**
	 * 로그아웃 로그정보를 생성한다.
	 * EgovLoginController.actionLogout Method
	 *
	 * @param
	 * @return void
	 * @throws Exception
	 */
	public void logLogout() throws Throwable {

		String uniqId = "";
		String ip = "";

		/* Authenticated  */
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated.booleanValue()) {
			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
			uniqId = user.getUniqId();
			ip = user.getIp();
    	}

    	LoginLog loginLog = new LoginLog();
    	loginLog.setLoginId(uniqId);
        loginLog.setLoginIp(ip);
        loginLog.setLoginMthd("O"); // 로그인:I, 로그아웃:O
        loginLog.setErrOccrrAt("N");
        loginLog.setErrorCode("");
        loginLogService.logInsertLoginLog(loginLog);
	}

}
