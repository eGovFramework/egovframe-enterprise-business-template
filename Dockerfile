FROM maven:3.9.9-jdk-17 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jre17
WORKDIR /app
COPY --from=builder /build/target/egovframe-template-enterprise /usr/local/tomcat/webapps/ROOT
ENV JAVA_TOOL_OPTIONS="\
  -XX:MaxRAMPercentage=60.0 \
  -XX:+UseG1GC \
  -XX:+HeapDumpOnOutOfMemoryError \
  -Djava.security.egd=file:/dev/./urandom"
CMD ["catalina.sh", "run"]
