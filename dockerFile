# Stage 1: Build the application
FROM gradle:8.11.1-jdk21 AS builder

# Gradle 캐시를 활용하기 위해 Gradle 환경 변수 설정
ENV GRADLE_USER_HOME=/home/gradle/.gradle

# 작업 디렉토리 설정
WORKDIR /app

# Gradle Wrapper 및 소스 파일 복사
COPY gradle gradle
COPY gradlew .
COPY settings.gradle .
COPY build.gradle .
COPY src ./src

# Gradle 빌드 (테스트는 생략)
RUN ./gradlew clean build -x test

# Stage 2: Create a lightweight runtime image
FROM eclipse-temurin:21-slim

# 런타임 환경 변수 설정
ENV SPRING_PROFILES_ACTIVE=prod
ENV JAVA_OPTS=""

# 작업 디렉토리 설정
WORKDIR /app

# 빌드 결과물 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 포트 설정 (Spring Boot 기본 포트)
EXPOSE 8080

# 애플리케이션 실행
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
