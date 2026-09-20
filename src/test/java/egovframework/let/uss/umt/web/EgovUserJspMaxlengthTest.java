package egovframework.let.uss.umt.web;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import egovframework.let.uss.umt.service.UserManageVO;
import jakarta.validation.constraints.Size;

/**
 * [업무사용자관리] 등록·수정 화면의 입력 길이 제한이 서버 검증(UserManageVO의 @Size)과 일치하는지 검증한다.
 *
 * @author 최완택
 * @since 2026-09-17
 */
@DisplayName("업무사용자관리 화면 입력 길이 제한")
class EgovUserJspMaxlengthTest {

	private static final Path INSERT_JSP = Path.of(
			"src/main/webapp/WEB-INF/jsp/cmm/uss/umt/EgovUserInsert.jsp");
	private static final Path SELECT_UPDT_JSP = Path.of(
			"src/main/webapp/WEB-INF/jsp/cmm/uss/umt/EgovUserSelectUpdt.jsp");

	private static String readJspWithoutComments(Path path) throws IOException {
		String content = new String(Files.readAllBytes(path), StandardCharsets.UTF_8);
		content = content.replaceAll("(?s)<%--.*?--%>", "");
		content = content.replaceAll("(?s)<!--.*?-->", "");
		return content;
	}

	private static int maxlengthOf(String jsp, String fieldName) {
		Pattern p = Pattern.compile(
				"(?:name|path)=\"" + fieldName + "\"[^>]*?maxlength=\"(\\d+)\"|"
						+ "maxlength=\"(\\d+)\"[^>]*?(?:name|path)=\"" + fieldName + "\"");
		Matcher m = p.matcher(jsp);
		if (!m.find()) {
			throw new AssertionError("maxlength 속성을 찾지 못함: " + fieldName);
		}
		String value = m.group(1) != null ? m.group(1) : m.group(2);
		return Integer.parseInt(value);
	}

	private static int sizeMaxOf(String fieldName) throws NoSuchFieldException {
		Field field = UserManageVO.class.getDeclaredField(fieldName);
		Size size = field.getAnnotation(Size.class);
		if (size == null) {
			throw new AssertionError("@Size 애노테이션이 없음: " + fieldName);
		}
		return size.max();
	}

	@Test
	@DisplayName("등록 화면의 사용자명·전화번호 길이가 서버 검증과 같다")
	void insertJspMaxlengthMatchesServerValidation() throws Exception {
		String jsp = readJspWithoutComments(INSERT_JSP);

		assertEquals(sizeMaxOf("emplyrNm"), maxlengthOf(jsp, "emplyrNm"));
		assertEquals(sizeMaxOf("areaNo"), maxlengthOf(jsp, "areaNo"));
		assertEquals(sizeMaxOf("homemiddleTelno"), maxlengthOf(jsp, "homemiddleTelno"));
		assertEquals(sizeMaxOf("homeendTelno"), maxlengthOf(jsp, "homeendTelno"));
	}

	@Test
	@DisplayName("수정 화면의 사용자명 길이가 서버 검증과 같다")
	void selectUpdtJspMaxlengthMatchesServerValidation() throws Exception {
		String jsp = readJspWithoutComments(SELECT_UPDT_JSP);

		assertEquals(sizeMaxOf("emplyrNm"), maxlengthOf(jsp, "emplyrNm"));
	}
}
