package egovframework.com.config;

import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.jmx.JmxConfig;
import io.micrometer.jmx.JmxMeterRegistry;
import io.micrometer.core.instrument.binder.jvm.*;
import io.micrometer.core.instrument.binder.system.ProcessorMetrics;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ObservabilityConfig {

    @Bean
    public JmxConfig jmxConfig() {
        // null 리턴은 기본값 사용 의미
        return new JmxConfig() {
            @Override 
            public String get(String k) { 
                return null; 
            }
        };
    }

    @Bean
    public MeterRegistry meterRegistry(JmxConfig jmxConfig) {
        MeterRegistry registry = new JmxMeterRegistry(jmxConfig, io.micrometer.core.instrument.Clock.SYSTEM);
        
        // JVM 메트릭 바인더 등록
        new ClassLoaderMetrics().bindTo(registry);
        new JvmMemoryMetrics().bindTo(registry);
        new JvmThreadMetrics().bindTo(registry);
        new ProcessorMetrics().bindTo(registry);
        
        return registry;
    }
}