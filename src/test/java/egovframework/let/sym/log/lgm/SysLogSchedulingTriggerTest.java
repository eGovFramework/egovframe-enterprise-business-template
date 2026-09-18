package egovframework.let.sym.log.lgm;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.Duration;
import java.util.Date;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.quartz.SimpleTrigger;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;

/**
 * 시스템 로그 요약 스케줄링 설정 단위 테스트.
 *
 * context-scheduling-sym-log-lgm.xml 의 트리거만 조립해 실행 주기를 검증한다.
 * 요약 SQL 은 전날 하루치만 집계하므로 트리거는 24시간마다 발화해야 한다.
 */
class SysLogSchedulingTriggerTest {

    /** 잡 대상 빈 자리를 채우는 대역. */
    public static class SysLogSchedulingStub {
        public void sysLogSummary() {
            // 트리거 조립에만 쓰이므로 동작이 없다.
        }
    }

    private SimpleTrigger sysLogTrigger() {
        DefaultListableBeanFactory beanFactory = new DefaultListableBeanFactory();
        beanFactory.registerSingleton("egovSysLogScheduling", new SysLogSchedulingStub());
        new XmlBeanDefinitionReader(beanFactory)
                .loadBeanDefinitions("classpath:egovframework/spring/com/context-scheduling-sym-log-lgm.xml");
        return beanFactory.getBean("sysLogTrigger", SimpleTrigger.class);
    }

    @Test
    @DisplayName("시스템 로그 요약 트리거는 24시간마다 발화한다")
    void sysLogTrigger_firesEveryTwentyFourHours() {
        SimpleTrigger trigger = sysLogTrigger();

        Date first = trigger.getStartTime();
        Date second = trigger.getFireTimeAfter(first);

        assertEquals(Duration.ofHours(24),
                Duration.between(first.toInstant(), second.toInstant()),
                "요약 SQL 은 전날 하루치만 집계하는데 트리거 간격이 24시간이 아님");
    }

}
