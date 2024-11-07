# Use a slim OpenJDK 17 image that doesn't have apt-get
FROM openjdk:17-slim

# Install apt and the required packages
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    gnupg \
    curl \
    default-mysql-client \
    maven

WORKDIR /app
COPY pom.xml pom.xml
RUN mvn dependency:resolve

COPY . .
RUN mvn clean package
RUN chmod 755 /app/scripts/start.sh

EXPOSE 8080
CMD ["sh", "-c", "/app/scripts/start.sh"]
