FROM adoptopenjdk/openjdk11:alpine-jre

# Install git
RUN apk update && apk add git

# Clone the GitHub repository with credentials
RUN git clone https://ineeladri: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@github.com/ineeladri/config-files.git /config

RUN mvn clean install -DskipTests

# Copy the application properties and application-dev properties files to the container
COPY src/main/resources/application.properties /app/config/

# Add the application JAR
ARG  target/configserver-0.0.1-SNAPSHOT.jar.original app.jar

EXPOSE 8888

# Start the config server with the config files from GitHub
ENTRYPOINT ["java","-Dspring.config.name=application","-Dspring.config.location=/app/config/","-jar","/app.jar"]
