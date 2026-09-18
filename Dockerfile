FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jre17-temurin
WORKDIR /app
COPY --from=builder /build/target/egovframe-template-enterprise-*.war /usr/local/tomcat/webapps/ROOT.war
ENV JAVA_TOOL_OPTIONS="\
  -XX:MaxRAMPercentage=60.0 \
  -XX:+UseG1GC \
  -XX:+HeapDumpOnOutOfMemoryError \
  -Djava.security.egd=file:/dev/./urandom"
CMD ["catalina.sh", "run"]