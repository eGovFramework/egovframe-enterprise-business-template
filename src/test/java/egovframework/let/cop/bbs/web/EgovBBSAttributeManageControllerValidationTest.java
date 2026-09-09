package egovframework.let.cop.bbs.web;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.validation.BindingResult;

import jakarta.validation.Valid;

/**
 * BindingResult를 선언한 핸들러는 바로 앞 파라미터에 {@code @Valid}가 있어야 한다.
 *
 * {@code @Valid}가 없으면 Spring이 검증기를 호출하지 않아 BindingResult가 항상 비고,
 * bindingResult.hasErrors() 분기가 실행되지 않는다.
 *
 * @author 최완택
 * @since 2026-08-30
 */
@DisplayName("게시판 속성 관리 컨트롤러")
class EgovBBSAttributeManageControllerValidationTest {

	@Test
	@DisplayName("BindingResult를 받는 핸들러는 검증 대상 파라미터에 @Valid를 선언한다")
	void handlersWithBindingResultDeclareValid() {
		List<String> missing = new ArrayList<>();

		for (Method method : EgovBBSAttributeManageController.class.getDeclaredMethods()) {
			Parameter[] parameters = method.getParameters();

			for (int i = 1; i < parameters.length; i++) {
				if (!BindingResult.class.isAssignableFrom(parameters[i].getType())) {
					continue;
				}
				if (!hasValid(parameters[i - 1])) {
					missing.add(method.getName());
				}
			}
		}

		assertTrue(missing.isEmpty(), "BindingResult 앞 파라미터에 @Valid가 없는 핸들러: " + missing);
	}

	private boolean hasValid(Parameter parameter) {
		for (Annotation annotation : parameter.getAnnotations()) {
			if (annotation instanceof Valid) {
				return true;
			}
		}
		return false;
	}

}
