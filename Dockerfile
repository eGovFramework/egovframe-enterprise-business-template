FROM maven:3.8.6-jdk-8 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jre8
WORKDIR /app
COPY --from=builder /build/target/ebt_webapp /usr/local/tomcat/webapps/ROOT
ENV JAVA_TOOL_OPTIONS="\
  -XX:MaxRAMPercentage=60.0 \
  -XX:+UseG1GC \
  -XX:+HeapDumpOnOutOfMemoryError \
  -Djava.security.egd=file:/dev/./urandom"
CMD ["catalina.sh", "run"]
