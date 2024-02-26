FROM registry.access.redhat.com/ubi9/openjdk-17 as builder

USER 0
RUN mkdir /build
WORKDIR /build
COPY . /build

RUN /build/gradlew clean bootJar

FROM registry.access.redhat.com/ubi9/openjdk-17-runtime

COPY --from=builder /build/build/libs/*-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]