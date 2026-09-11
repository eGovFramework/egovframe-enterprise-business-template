package egovframework.test;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * MultipartFilter 가 찾는 리졸버 빈 이름이 루트 컨텍스트에 실제로 선언돼 있는지 확인한다.
 *
 * <p>MultipartFilter 는 init-param 이 없으면 기본 이름 filterMultipartResolver 를 찾고,
 * 못 찾으면 자체 기본 리졸버로 요청을 먼저 감싼다. 그러면 DispatcherServlet 이
 * 이미 감싸진 요청을 다시 풀지 않아 EgovMultipartResolver 의 확장자 검증이 실행되지 않는다.
 */
class MultipartResolverWiringTest {

	/** MultipartFilter 가 init-param 없이 쓰는 기본 빈 이름 */
	private static final String DEFAULT_BEAN_NAME = "filterMultipartResolver";

	private static final Path WEB_XML = Paths.get("src/main/webapp/WEB-INF/web.xml");
	private static final Path CONTEXT_COMMON =
			Paths.get("src/main/resources/egovframework/spring/com/context-common.xml");

	@Test
	@DisplayName("MultipartFilter 가 찾는 리졸버 빈이 루트 컨텍스트에 선언돼 있다")
	void multipartFilterResolvesToDeclaredBean() throws IOException {
		String webXml = read(WEB_XML);
		String contextCommon = read(CONTEXT_COMMON);

		String beanName = multipartResolverBeanName(webXml);

		assertTrue(declaresBean(contextCommon, beanName),
				"MultipartFilter 는 빈 '" + beanName + "' 을 찾는데 context-common.xml 에 그 이름이 없다."
						+ " 이대로면 필터가 기본 리졸버로 요청을 감싸 EgovMultipartResolver 의 검증이 실행되지 않는다.");
	}

	/** web.xml 의 MultipartFilter 선언에서 init-param 으로 지정한 빈 이름을 읽는다. 없으면 기본 이름. */
	private String multipartResolverBeanName(String webXml) {
		Matcher filter = Pattern
				.compile("<filter>(?:(?!</filter>).)*MultipartFilter(?:(?!</filter>).)*</filter>", Pattern.DOTALL)
				.matcher(webXml);
		if (!filter.find()) {
			return DEFAULT_BEAN_NAME;
		}
		Matcher param = Pattern.compile(
				"<param-name>\\s*multipartResolverBeanName\\s*</param-name>\\s*<param-value>\\s*([^<\\s]+)\\s*</param-value>",
				Pattern.DOTALL).matcher(filter.group());
		return param.find() ? param.group(1) : DEFAULT_BEAN_NAME;
	}

	private boolean declaresBean(String contextCommon, String beanName) {
		return Pattern.compile("<(?:bean|alias)[^>]*(?:id|name|alias)\\s*=\\s*\"" + Pattern.quote(beanName) + "\"")
				.matcher(contextCommon).find();
	}

	private String read(Path path) throws IOException {
		return new String(Files.readAllBytes(path), StandardCharsets.UTF_8);
	}
}
