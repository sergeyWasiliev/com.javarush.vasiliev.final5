# Build stage
FROM maven:3.9.6-amazoncorretto-17-debian AS builder
WORKDIR /build

# Копируем только pom.xml сначала для кэширования зависимостей
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Копируем исходный код
COPY src ./src
COPY config ./config
COPY resources ./resources
COPY lombok.config .

# Сборка приложения
RUN mvn clean package -DskipTests

# Runtime stage
FROM openjdk:17-jdk-slim
WORKDIR /opt/jirarush

# Создаем пользователя для безопасности
RUN groupadd -r spring && useradd -r -g spring spring
USER spring:spring

# Копируем собранный JAR
COPY --from=builder /build/target/*.jar app.jar

# Копируем конфиги и ресурсы
COPY --from=builder /build/config ./config
COPY --from=builder /build/resources ./resources

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]