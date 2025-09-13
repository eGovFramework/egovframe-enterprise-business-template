package egovframework.com.cmm.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

/**
 * 보안 헤더를 추가하는 필터
 * 기본적인 웹 보안 헤더를 모든 응답에 적용합니다.
 * 
 * @author eGovFramework
 * @since 2024.09
 */
public class SecurityHeadersFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 로직 (필요시 추가)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            
            // X-Content-Type-Options: MIME 스니핑 방지
            httpResponse.setHeader("X-Content-Type-Options", "nosniff");
            
            // X-Frame-Options: 클릭재킹 방지 (iframe 삽입 차단)
            httpResponse.setHeader("X-Frame-Options", "DENY");
            
            // X-XSS-Protection: XSS 공격 차단 (레거시 브라우저 지원)
            httpResponse.setHeader("X-XSS-Protection", "1; mode=block");
            
            // Referrer-Policy: 리퍼러 정보 제한
            httpResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 필터 정리 로직 (필요시 추가)
    }
}