FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jre17-temurin
WORKDIR /app
COPY --from=builder /build/target/egovframe-template-enterprise-5.0.0 /usr/local/tomcat/webapps/egovframe-template-enterprise
ENV JAVA_TOOL_OPTIONS="\
  -XX:MaxRAMPercentage=60.0 \
  -XX:+UseG1GC \
  -XX:+HeapDumpOnOutOfMemoryError \
  -Djava.security.egd=file:/dev/./urandom"

CMD ["sh", "-c", "awk -v url=\"$GLOBALS_URL\" '{if ($0 == \"Globals.Url = jdbc:log4jdbc:mysql://127.0.0.1:3306/ebt\") print \"Globals.Url = \" url; else print}' /usr/local/tomcat/webapps/egovframe-template-enterprise/WEB-INF/classes/egovframework/egovProps/globals.properties > /tmp/globals.properties && mv /tmp/globals.properties /usr/local/tomcat/webapps/egovframe-template-enterprise/WEB-INF/classes/egovframework/egovProps/globals.properties && exec catalina.sh run"]
