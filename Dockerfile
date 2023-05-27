# Define la imagen base de Java para construir la aplicación
FROM adoptopenjdk:11-jdk-hotspot

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo JAR de la aplicación al directorio de trabajo en el contenedor
COPY target/cicd-0.0.1-SNAPSHOT.jar app.jar

# Expone el puerto en el que se ejecuta la aplicación dentro del contenedor
EXPOSE 8099

# Comando para ejecutar la aplicación cuando se inicie el contenedor
CMD ["java", "-jar", "app.jar"]
