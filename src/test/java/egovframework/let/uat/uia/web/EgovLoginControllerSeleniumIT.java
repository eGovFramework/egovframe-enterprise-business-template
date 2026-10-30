package egovframework.let.uat.uia.web;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * [로그인] 셀레늄 통합 테스트 (failsafe {@code *IT}).
 *
 * <p>실행 중인 서버({@code -Dtest.baseUrl}, 기본 {@code http://localhost:8080})와
 * ChromeDriver가 필요하므로 {@code mvn test}에서는 실행되지 않고
 * {@code mvn verify}에서만 실행된다. 환경이 없으면 실패가 아니라 건너뛴다.</p>
 *
 * @author 이백행
 * @since 2024-08-30
 *
 */
@Slf4j
@NoArgsConstructor
class EgovLoginControllerSeleniumIT {

	/**
	 * 테스트 기본 URL
	 */
	private static final String BASE_URL = System.getProperty("test.baseUrl", "http://localhost:8080");

	/**
	 * 웹 드라이버
	 */
	private WebDriver driver;

	/**
	 * 설정
	 */
	@BeforeEach
	public void setup() {
		try {
			driver = new ChromeDriver();
//			driver = new EdgeDriver();
//			driver = new FirefoxDriver();
//			driver = new InternetExplorerDriver();
//			driver = new SafariDriver();
		} catch (WebDriverException e) {
			Assumptions.abort("WebDriver를 실행할 수 없어 테스트를 건너뜁니다.");
		}
	}

	@Test
	void test() {
		if (log.isDebugEnabled()) {
			log.debug("test");
		}

		// given

		// 로그인 화면 이동 (서버가 없으면 실패가 아니라 건너뜀)
		try {
			driver.get(BASE_URL + "/uat/uia/egovLoginUsr.do");
		} catch (WebDriverException e) {
			Assumptions.abort("테스트 서버에 연결할 수 없어 테스트를 건너뜁니다: " + BASE_URL);
		}

		final JavascriptExecutor executor = (JavascriptExecutor) driver;

		// 로그인 화면 새로고침
		sleep();
		executor.executeScript("location.reload();");

		// 아이디 입력
		sleep();
		final WebElement idElement = driver.findElement(By.id("id"));
		idElement.sendKeys("admin");

		// 비밀번호 입력
		sleep();
		final WebElement passwordElement = driver.findElement(By.id("password"));
		passwordElement.sendKeys("1");

		// when

		// 로그인 버튼 클릭
		sleep();
		executor.executeScript("actionLogin();");

		// then

		final WebElement spanElement = driver
				.findElement(By.cssSelector("body > div > div.header > div > div.top_menu > span.t > span"));

		assertEquals("관리자 님", spanElement.getText(), "로그인 실패");
	}

	/**
	 * 정리
	 */
	@AfterEach
	void tearDown() {
		if (driver != null) {
			try {
				driver.quit();
			} catch (WebDriverException e) {
				log.warn("WebDriver 종료 중 오류가 발생했습니다.", e);
			} finally {
				driver = null;
			}
		}
	}

	private void sleep() {
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			fail("InterruptedException: Thread.sleep");
		}
	}

}