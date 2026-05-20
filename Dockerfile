# syntax=docker/dockerfile:1.7
FROM maven:3.9.9-jdk-17 AS builder
WORKDIR /build

# Resolve dependencies first so subsequent rebuilds reuse the layer cache
# whenever only application sources change.
COPY pom.xml ./
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -ntp dependency:go-offline

COPY src ./src
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -ntp clean package -DskipTests

FROM tomcat:10.1-jre17
WORKDIR /app
COPY --from=builder /build/target/egovframe-template-enterprise /usr/local/tomcat/webapps/ROOT
ENV JAVA_TOOL_OPTIONS="\
  -XX:MaxRAMPercentage=60.0 \
  -XX:+UseG1GC \
  -XX:+HeapDumpOnOutOfMemoryError \
  -Djava.security.egd=file:/dev/./urandom"
CMD ["catalina.sh", "run"]
