package egovframework.let.uss.ion.uas.web;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

/**
 * [사용자부재][EgovUserAbsnceController.insertUserAbsnce] Controller 단위 테스트
 *
 * 사용자명이 빈 값이면 등록 화면을 다시 그려야 한다. 형제인 updateUserAbsnce가 검증 실패 시
 * 자기 화면 EgovUserAbsnceUpdt를 반환하는 것과 같다.
 *
 * @author 최완택
 * @since 2026-09-09
 */
@DisplayName("사용자부재 컨트롤러")
class EgovUserAbsnceControllerViewTest {

	/**
	 * 서버 측 Spring MVC 테스트 지원을 위한 주요 진입점입니다.
	 */
	private final MockMvc mockMvc = MockMvcBuilders.standaloneSetup(new EgovUserAbsnceController()).build();

	/**
	 * 사용자부재정보 등록의 입력값 검증이 실패하면 등록 화면으로 되돌아간다.
	 *
	 * @throws Exception
	 */
	@Test
	@DisplayName("등록 검증 실패 시 등록 화면으로 되돌아간다")
	void insertUserAbsnceReturnsRegistViewOnValidationError() throws Exception {
		// given

		// when
		final MvcResult result = mockMvc.perform(post("/uss/ion/uas/addUserAbsnce.do").param("userNm", ""))
				.andExpect(status().isOk()).andReturn();

		// then
		assertEquals("/uss/ion/uas/EgovUserAbsnceRegist", result.getModelAndView().getViewName(),
				"검증 실패 시 등록 화면을 다시 그려야 한다.");
	}

}
