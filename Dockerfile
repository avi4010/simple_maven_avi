FROM maven:3.6-jdk-8

# Install maven
#RUN apt-get update
#RUN apt-get install -y maven

WORKDIR /simple_maven_avi

# Prepare by downloading dependencies
ADD pom.xml /simple_maven_avi/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
# This assumes you've configured such a goal in pom.xml
ADD src /simple_maven_avi/src
RUN ["mvn", "package"]

EXPOSE 4567
CMD ["java", "-jar", "target/simple_maven_avi-0.0.1-SNAPSHOT.jar"]
