package egovframework.test;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/**
 * MySQL Testcontainers 기본 연결 테스트
 * 애플리케이션 코드에 비침투적인 테스트로 MySQL 컨테이너가 정상적으로 시작되는지 검증
 */
@Testcontainers
public class MysqlSmokeIT {

    @Container
    static MySQLContainer<?> MYSQL = new MySQLContainer<>("mysql:8.0")
            .withDatabaseName("ebt")
            .withUsername("root")
            .withPassword("admin");

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        // 테스트 시 Testcontainers MySQL 사용하도록 데이터소스 설정 오버라이드
        registry.add("spring.datasource.url", MYSQL::getJdbcUrl);
        registry.add("spring.datasource.username", MYSQL::getUsername);
        registry.add("spring.datasource.password", MYSQL::getPassword);
    }

    @Test
    void containerStarts() {
        // MySQL 컨테이너가 정상적으로 시작되었는지 검증
        Assertions.assertTrue(MYSQL.isRunning());
        Assertions.assertEquals("ebt", MYSQL.getDatabaseName());
    }

    @Test
    void containerHasCorrectConfiguration() {
        // 컨테이너 설정이 올바른지 검증
        Assertions.assertEquals("root", MYSQL.getUsername());
        Assertions.assertEquals("admin", MYSQL.getPassword());
        Assertions.assertTrue(MYSQL.getJdbcUrl().contains("ebt"));
    }
}