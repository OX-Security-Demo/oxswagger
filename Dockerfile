#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app

#Personal access token are an alternative to using passwords 
#for authentication to GitHub when using the GitHub API or the command line. 
#Personal access tokens are intended to access GitHub resources on behalf of yourself.
RUN echo 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 > /home/app/key.json

RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/swagger-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]
