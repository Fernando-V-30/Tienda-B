# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
FROM alpine:latest

CMD ["/bin/sh"]

#Etapa #1: Compilación

 

FROM maven:3.8.5-openjdk-17 as build
WORKDIR /app
COPY . . 
RUN mvn -f pom.xml clean package -DskipTest

 

#Etapa 2: Creación de la imagen final
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","app.jar"]